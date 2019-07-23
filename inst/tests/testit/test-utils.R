library(testit)

assert('coerceValue() works for various classes', {
  (coerceValue('100', 1L) %==% 100L)
  (coerceValue('1.23', 3.1416) %==% 1.23)
  (coerceValue('2018-02-14', Sys.Date()) %==% as.Date('2018-02-14'))

  actual = coerceValue('2018-02-14T22:18:52Z', Sys.time())
  expect = structure(1518646732, class = c("POSIXct", "POSIXt"), tzone = "UTC")
  (actual %==% expect)

  (coerceValue('a', 'b') %==% 'a')
  (coerceValue('a', factor('b', levels = c('a', 'b'))) %==% 'a')

  has_warning({actual = coerceValue('a', factor('b', levels = c('c', 'b')))})
  (actual %==% NA_character_)

  has_warning({actual = coerceValue('FALSE', TRUE)})
  (actual %==% 'FALSE')
})

