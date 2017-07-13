
lambda { |stdout,stderr,status|
  output = stdout + stderr
  return :amber if /PHP Parse error:/.match(output)
  return :red   if /FAILURES!/.match(output)
  return :green if /OK \(/.match(output)
  return :amber
}
