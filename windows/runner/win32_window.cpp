#include "win32_window.h"
#include <dwmapi.h>
namespace {
  constexpr const wchar_t kWindowClassName[] = L"FLUTTER_RUNNER_WIN32_WINDOW";
  HINSTANCE g_hinstance = nullptr;
  int g_active_window_count = 0;
  void EnableFullDpiSupportIfAvailable(HWND hwnd) {
    HMODULE user32_module = LoadLibraryA("User32.dll");
    if (!user32_module) return;
    auto enable = reinterpret_cast<decltype(EnableNonClientDpiScaling)*>(GetProcAddress(user32_module, "EnableNonClientDpiScaling"));
    if (enable) enable(hwnd);
    FreeLibrary(user32_module);
  }
}
Win32Window::Win32Window() { ++g_active_window_count; }
Win32Window::~Win32Window() { --g_active_window_count; Destroy(); }
bool Win32Window::Create(const std::wstring& title, const Point& origin, const Size& size) {
  Destroy();
  WNDCLASS wc{};
  wc.hCursor = LoadCursor(nullptr, IDC_ARROW);
  wc.lpszClassName = kWindowClassName;
  wc.style = CS_HREDRAW | CS_VREDRAW;
  wc.hInstance = g_hinstance;
  wc.hbrBackground = 0;
  wc.lpfnWndProc = WndProc;
  RegisterClass(&wc);
  auto* result = CreateWindow(wc.lpszClassName, title.c_str(), WS_OVERLAPPEDWINDOW, origin.x, origin.y, size.width, size.height, nullptr, nullptr, g_hinstance, this);
  if (!result) return false;
  return OnCreate();
}
RECT Win32Window::GetClientArea() { RECT frame; GetClientRect(window_handle_, &frame); return frame; }
HWND Win32Window::GetHandle() { return window_handle_; }
void Win32Window::SetQuitOnClose(bool q) { quit_on_close_ = q; }
bool Win32Window::Show() { return ShowWindow(window_handle_, SW_SHOWNORMAL); }
void Win32Window::Destroy() { OnDestroy(); if (window_handle_) { DestroyWindow(window_handle_); window_handle_ = nullptr; } }
void Win32Window::SetChildContent(HWND content) {
  child_content_ = content;
  SetParent(content, window_handle_);
  RECT frame = GetClientArea();
  MoveWindow(content, frame.left, frame.top, frame.right - frame.left, frame.bottom - frame.top, true);
}
LRESULT Win32Window::MessageHandler(HWND hwnd, UINT const message, WPARAM const wparam, LPARAM const lparam) noexcept {
  switch (message) {
    case WM_DESTROY: window_handle_ = nullptr; Destroy(); if (quit_on_close_) PostQuitMessage(0); return 0;
    case WM_DPICHANGED: { auto* r = reinterpret_cast<RECT*>(lparam); SetWindowPos(hwnd, nullptr, r->left, r->top, r->right-r->left, r->bottom-r->top, SWP_NOZORDER|SWP_NOACTIVATE); return 0; }
    case WM_SIZE: { RECT rect = GetClientArea(); if (child_content_) MoveWindow(child_content_, rect.left, rect.top, rect.right-rect.left, rect.bottom-rect.top, TRUE); return 0; }
    case WM_ACTIVATE: if (child_content_) SetFocus(child_content_); return 0;
  }
  return DefWindowProc(window_handle_, message, wparam, lparam);
}
LRESULT CALLBACK Win32Window::WndProc(HWND const window, UINT const message, WPARAM const wparam, LPARAM const lparam) noexcept {
  if (message == WM_NCCREATE) {
    auto* ws = reinterpret_cast<CREATESTRUCT*>(lparam);
    SetWindowLongPtr(window, GWLP_USERDATA, reinterpret_cast<LONG_PTR>(ws->lpCreateParams));
    auto* that = static_cast<Win32Window*>(ws->lpCreateParams);
    EnableFullDpiSupportIfAvailable(window);
    that->window_handle_ = window;
  } else if (Win32Window* that = GetThisFromHandle(window)) {
    return that->MessageHandler(window, message, wparam, lparam);
  }
  return DefWindowProc(window, message, wparam, lparam);
}
Win32Window* Win32Window::GetThisFromHandle(HWND const window) noexcept {
  return reinterpret_cast<Win32Window*>(GetWindowLongPtr(window, GWLP_USERDATA));
}
bool Win32Window::OnCreate() { return true; }
void Win32Window::OnDestroy() {}
