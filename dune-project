(lang dune 3.15)

(name ztl)

(generate_opam_files true)

(source
 (github noghartt/ztl))

(authors "Guilherme Ananias")

(maintainers "Guilherme Ananias")

(license LICENSE)

(package
 (name ztl)
 (synopsis "A short synopsis")
 (description "A longer description")
 (depends 
  ocaml
  dune
  (yojson (= 2.1.0))
  ppx_deriving_yojson
  minttea))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
