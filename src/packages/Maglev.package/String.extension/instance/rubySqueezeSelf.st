*maglev-runtime
rubySqueezeSelf
 "convert each repeating character sequence in receiver to a single character"
| n dest prev ch sz |
sz := self size .
sz > 1 ifTrue:[
  prev := -1 .
  n := 1 .
  [ n <= sz and:[(ch := self at: n) ~~ prev]] whileTrue:[
    n := n + 1 .
    prev := ch
  ].
  dest := n - 1 .
  [ n <= sz ] whileTrue:[ 
    (ch := self at: n) == prev ifTrue:[
      n := n + 1 .
      [ n <= sz and:[ (ch := self at: n) == prev ]] whileTrue:[
	n := n + 1
      ].
      n <= sz ifTrue:[
        dest := dest + 1 .
        self at: dest put: ch .
      ] 
    ] ifFalse:[
      dest := dest + 1 .
      self at: dest put: ch .
    ].
    n := n + 1 .
    prev := ch .
  ].
  dest < sz ifTrue:[ self size: dest .   ^ self ]
           ifFalse:[ ^ nil "no changes made" ]
] ifFalse:[
  ^ nil "no changes made"
].

