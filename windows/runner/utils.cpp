#include "utils.h"
#include <windows.h>
std::string Utf8FromUtf16(const wchar_t* utf16_string) {
  if (utf16_string == nullptr) return {};
  unsigned int target_length = ::WideCharToMultiByte(CP_UTF8, WC_ERR_INVALID_CHARS, utf16_string, -1, nullptr, 0, nullptr, nullptr) - 1;
  if (target_length == 0) return {};
  std::string utf8_string;
  utf8_string.resize(target_length);
  int converted_length = ::WideCharToMultiByte(CP_UTF8, WC_ERR_INVALID_CHARS, utf16_string, -1, utf8_string.data(), target_length, nullptr, nullptr);
  if (converted_length == 0) return {};
  return utf8_string;
}
std::vector<std::string> GetCommandLineArguments() {
  int argc;
  wchar_t** argv = ::CommandLineToArgvW(::GetCommandLineW(), &argc);
  if (argv == nullptr) return {};
  std::vector<std::string> args;
  for (int i = 1; i < argc; i++) args.push_back(Utf8FromUtf16(argv[i]));
  ::LocalFree(argv);
  return args;
}
