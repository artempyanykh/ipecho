(lang dune 2.0)

(name ipecho)

(license ISC)

(authors "Artem Pianykh")

(maintainers "Artem Pianykh")

(source
 (github artempyanykh/ipecho))

(generate_opam_files true)

(package
 (name ipecho)
 (synopsis "Server that echoes IP addresses of clients")
 (description "Server that echoes IP addresses of clients")
 (depends
  (ocaml
   (>= 5.0.0))
  dune
  (alcotest :with-test)
  (odoc :with-doc)
  cmdliner
  fmt
  httpaf
  httpaf-lwt-unix
  logs
  lwt))
