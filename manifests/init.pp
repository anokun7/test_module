class test_module {
  notify { $::rootpassword: }
  redact("$::fqdn","rootpassword","HOHOHO")
  #redact("$::fqdn","rootpassword")
}
