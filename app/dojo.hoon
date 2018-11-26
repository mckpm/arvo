#+  #=  here-disc
  ^-  disc:ford
  !:
  =/  her=path  /==
  ~&  [%loading %]
  ?>  ?=([* * *] her)
  [(slav %p i.her) (slav %tas i.t.her)]
::
#+  #=  sole  #&  :-  here-disc  #.  /hoon/sole/sur
#+  #=  lens  #&  :-  here-disc  #.  /hoon/lens/sur
#+  #=  sole  #&  :-  here-disc  #.  /hoon/sole/lib
::
=/  pit=vase  !>(..zuse)
~&  [%zuse-version (slap pit %limb %zuse)]
::
=,  sole
=,  space:userlib
=,  format
!:
::                                                      ::  ::
::::                                                    ::  ::::
  ::                                                    ::    ::
=>  |%                                                  ::  external structures
    ++  house                                           ::  all state
      $:  $5
          egg/@u                                        ::  command count
          hoc/(map bone session)                        ::  conversations
      ==                                                ::
    ::  TODO: remove either session or monkey now that they're the same
    ::
    ++  session                                         ::  per conversation
      $:  say/sole-share                                ::  command-line state
          dir/beam                                      ::  active path
          poy/(unit dojo-project)                       ::  working
          var/(map term cage)                           ::  variable state
          old/(set term)                                ::  used TLVs
          buf/tape                                      ::  multiline buffer
      ==                                                ::
    ++  monkey                                         ::  per conversation
      $:  say/sole-share                                ::  command-line state
          dir/beam                                      ::  active path
          poy/(unit dojo-project)                       ::  working
          var/(map term cage)                           ::  variable state
          old/(set term)                                ::  used TLVs
          buf/tape                                      ::  multiline buffer
      ==                                                ::
    ++  dojo-command                                    ::
      $^  (pair dojo-sink dojo-source)                  ::  route value
      {$brev p/term}                                    ::  unbind variable
    ::
    ++  dojo-sink                                       ::
      $%  {$flat p/path}                                ::  atom to unix
          {$pill p/path}                                ::  noun to unix pill
          ::  {$tree p/path}                            ::  noun to unix tree
          {$file p/beam}                                ::  save to clay
          $:  $http                                     ::  http outbound
              p/?($post $put) 
              q/(unit knot) 
              r/purl:eyre
          ==
          {$poke p/goal}                                ::  poke app
          {$show p/?($0 $1 $2 $3)}                      ::  print val+type+hoon
          {$verb p/term}                                ::  store variable
      ==                                                ::
    ++  dojo-source                                     ::  construction node
      $:  p/@ud                                         ::  assembly index
          q/dojo-build                                  ::  general build
      ==                                                ::
    ++  dojo-build                                      ::  one arvo step
      $~  [%ex *hoon]
      $%  {$ur p/(unit knot) q/purl:eyre}               ::  http GET request
          {$ge p/dojo-model}                            ::  generator
          ::{$fo p/hoon}                                  ::  ford build
          {$dv p/path}                                  ::  core from source
          {$ex p/hoon}                                  ::  hoon expression
          {$sa p/mark}                                  ::  example mark value
          {$as p/mark q/dojo-source}                    ::  simple transmute
          {$do p/hoon q/dojo-source}                    ::  gate apply
          {$tu p/(list dojo-source)}                    ::  tuple
      ==                                                ::
    ++  dojo-model                                      ::  data construction 
      $:  p/dojo-server                                 ::  core source
          q/dojo-config                                 ::  configuration
      ==                                                ::
    ++  dojo-server                                     ::  numbered device
      $:  p/@ud                                         ::  assembly index
          q/path                                        ::  gate path
      ==                                                ::
    ++  dojo-config                                     ::  configuration
      $:  p/(list dojo-source)                          ::  by order
          q/(map term (unit dojo-source))               ::  by keyword
      ==                                                ::
    ++  dojo-project                                    ::  construction state
      $:  mad/dojo-command                              ::  operation
          num/@ud                                       ::  number of tasks
          cud/(unit dojo-source)                        ::  now solving
          pux/(unit path)                               ::  ford working
          pro/(unit vase)                               ::  prompting loop
          per/(unit sole-edit)                          ::  pending reverse
          job/(map @ud dojo-build)                      ::  problems
          rez/(map @ud cage)                            ::  results
      ==                                                ::
    ++  bead  {p/(set beam) q/cage}                     ::  computed result
    ++  goal  {p/ship q/term}                           ::  flat application
    ++  clap                                            ::  action, user
      $%  {$peer p/path}                                ::  subscribe
          {$poke p/(cask)}                              ::  apply
          {$pull ~}                                    ::  unsubscribe
      ==                                                ::
    ++  club                                            ::  action, system
      $%  {$peer p/path}                                ::  subscribe
          {$poke p/cage}                                ::  apply
          {$pull ~}                                    ::  unsubscribe
      ==                                                ::
    ++  card                                            ::  general card
      $%  {$diff $sole-effect sole-effect}              ::
          {$send wire {ship term} clap}                 ::
          $:  $hiss
              wire 
              (unit knot) 
              mark 
              {$hiss hiss:eyre}
          ==
          [%build wire @p ? schematic:ford]
          [%kill wire @p]
          {$deal wire sock term club}                   ::
          {$info wire @p toro:clay}                     ::
      ==                                                ::
    ++  move  (pair bone card)                          ::  user-level move
    ++  sign                                            ::
      $%  ::  %made: build result; response to %build +task
          ::
          $:  %made
              ::  date: formal date of the build
              ::
              date=@da
              ::  result: result of the build; either complete build, or error
              ::
              $=  result
              $%  ::  %complete: contains the result of the completed build
                  ::
                  [%complete result=(each vase tang)]
                  ::  %incomplete: couldn't finish build; contains error message
                  ::
                  [%incomplete =tang]
          ==  ==
          {$unto p/cuft:gall}                          ::  
      ==                                                ::
    --                                                  ::
::                                                      ::
::::                                                    ::
  ::                                                    ::
=,  gall
=+  foo=*monkey
|_  $:  hid/bowl                                        ::  system state
        house                                           ::  program state
    ==                                                  ::
++  he                                                  ::  per session
  |_  {moz/(list move) session}                         ::  
  ++  dp                                                ::  dojo parser
    |%  
    ++  dp-default-app  %hood
    ++  dp-message                                      ::  %poke
      |=  {gol/goal mod/dojo-model}  ^-  dojo-command
      [[%poke gol] [0 [%ge mod(q.p [q.gol q.p.mod])]]]
    ::
    ++  dp-command-line  ;~(sfix dp-command (star ace) (just '\0a'))
    ++  dp-variable                                     ::  %verb or %brev
      |*  {sym/rule src/rule}
      %+  cook  
        |=  {a/term b/(unit dojo-source)}  
        ^-  dojo-command
        ?~(b [%brev a] [[%verb a] u.b])
      ;~(plug sym (punt src))
    ::
    ++  dp-command                                      ::  ++dojo-command
      :: =<  ;~(less |-(;~(pose (jest '|*') ;~(pfix next (knee ** |.(^$))))) .)
      %+  knee  *dojo-command  |.  ~+
      ;~  pose  
        ;~  pfix  bar
          %+  cook  dp-message
          (stag [our.hid dp-default-app] dp-model)
        ==
      ::
        ;~  pfix  col
          %+  cook
            |=  {a/goal b/$^(dojo-model dojo-source)}
            ?@  -.b  [[%poke a] b]
            (dp-message a b)
          ;~  plug
            dp-goal
            ;~  pose
              ;~(pfix bar dp-model)
              ;~(pfix ace dp-source)
            ==
          ==
        ==
      ::
        ;~  pfix  tis
          ;~  pose
            (dp-variable (jest %dir) ;~(pfix ace :(stag 0 %ex dp-rood)))
            (dp-variable sym ;~(pfix ace dp-source))
          ==
        ==
      ::
        ;~((glue ace) dp-sink dp-source)
        (stag [%show %0] dp-source)
      ==
    ++  dp-sink
      ;~  pose
        ;~(plug (cold %file tar) dp-beam)
        ;~(plug (cold %flat vat) (most net sym))
        ;~(plug (cold %pill dot) (most net sym))
        ;~(plug (cold %http lus) (stag %post dp-iden-url))
        ;~(plug (cold %http hep) (stag %put dp-iden-url))
        (stag %show (cook $?($1 $2 $3) (cook lent (stun [1 3] wut))))
      ==
    ::
    ++  dp-hoon-punt                                   ::  hoon of unit
      |*(a/rule ;~(pose (stag [%bust %null] a) (easy [%bust %null])))
    ::
    ++  dp-case-hoon
      |=  a/coin  ^-  (unit hoon)
      ?.  ?=({~ case} a)  ~
      %+  some
        [%rock %tas p.p.a]
      [%sand p.a]
    ::
    ++  dp-source  (stag 0 dp-build)                    ::  ++dojo-source
    ++  dp-build                                        ::  ++dojo-build
      %+  knee  *dojo-build  |.  ~+
      ;~  pose
        ;~(plug (cold %ur lus) dp-iden-url)
        ;~(plug (cold %ge lus) dp-model)
        ;~(plug (cold %as pad) sym ;~(pfix ace dp-source))
        ;~(plug (cold %do cab) dp-hoon ;~(pfix ace dp-source))
        ::;~(plug (cold %fo ;~(plug lus hax gap)) dp-gear)
        dp-value
      ==
    :: 
    ++  dp-goal                                          ::  ++goal
      %+  cook  |=(a/goal a)
      ;~  pose
        ;~  plug
          ;~(pfix sig fed:ag)
          ;~(pose ;~(pfix net sym) (easy dp-default-app))
        ==
        %+  stag  our.hid
        ;~(pose sym (easy dp-default-app))
      ==
    ++  dp-beam                                         ::  ++beam
      %+  cook
        |=  a/path
        ::  hack: fixup paths that come out of the hoon parser
        ::
        ::    We currently invoke the hoon parser to read relative paths from
        ::    the command line, and this parser will produce leading ~ path
        ::    components with paths that start with a `/`.
        ::
        ::    This entire path is nuts and we shouldn't be representing paths
        ::    as arbitrary hoons.
        ::
        =?  a  &(?=(^ a) =('' i.a))
          t.a
        =+((de-beam a) ?^(- u [he-beak (flop a)]))
      =+  vez=(vang | dp-path)
      (sear plex:vez (stag %clsg poor:vez))
    ::
    ::++  dp-gear
    ::  =/  hoon-parser       vast
    ::  =.  wer.hoon-parser   dp-path
    ::  =/  gear-parser       tall-top:(rage allow-bare-hoons=&):hoon-parser
    ::  ::
    ::  (full (ifix [gay gay] gear-parser))
    ::
    ++  dp-iden-url
      %+  cook
        |=({a/(unit knot) b/purl:eyre} [`(fall a *knot) b])
      auru:de-purl:html
    ::
    ++  dp-model   ;~(plug dp-server dp-config)         ::  ++dojo-model
    ++  dp-path    (en-beam he-beam)                       ::  ++path
    ++  dp-server  (stag 0 (most net sym))              ::  ++dojo-server
    ++  dp-hoon    tall:(vang | dp-path)                ::  ++hoon
    ++  dp-rood                                         ::  'dir' hoon
      =>  (vang | (en-beam dir))
      ;~  pose
        rood
      ::
        =-  ;~(pfix cen (stag %clsg -))                 ::  XX refactor ++scat
        %+  sear  |=({a/@ud b/tyke} (posh ~ ~ a b))
        ;~  pose
          porc
          (cook |=(a/(list) [(lent a) ~]) (star cen))
        ==
      ==
    ++  dp-value                                        ::  ++dojo-source
      ;~  pose
        (stag %sa ;~(pfix tar pad sym))
        (stag %ex dp-hoon)
        (stag %tu (ifix [lac rac] (most ace dp-source)))
      ==
    ::
    ++  dp-config                                       ::  ++dojo-config
      ;~  plug
        (star ;~(pfix ace (stag 0 dp-value)))
        %+  cook
          ~(gas by *(map term (unit dojo-source)))
        %-  star
        ;~  plug 
          ;~(pfix com ace tis sym)
          (punt ;~(pfix ace (stag 0 dp-value)))
        ==
      ==
    --
  ::
  ++  dy                                                ::  project work
    |_  dojo-project                                    ::
    ++  dy-abet  +>(poy `+<)                            ::  resolve
    ++  dy-amok  +>(poy ~)                              ::  terminate
    ++  dy-ford                                         ::  send work to ford
      |=  [way=wire schematic=schematic:ford]
      ^+  +>+>
      ?>  ?=($~ pux)
      (he-card(poy `+>+<(pux `way)) %build way our.hid live=%.n schematic)
    ::
    ++  dy-eyre                                         ::  send work to eyre
      |=  {way/wire usr/(unit knot) req/hiss:eyre}
      ^+  +>+>
      ?>  ?=(~ pux)
      (he-card(poy `+>+<(pux `way)) %hiss way usr %httr %hiss req)
    ::
    ++  dy-stop                                         ::  stop work
      ^+  +>
      =.  poy  ~
      ?~  pux  +>
      %.  [%txt "! cancel {<u.pux>}"]
      he-diff:(he-card [%kill u.pux our.hid])
    ::
    ++  dy-slam                                         ::  call by ford
      |=  {way/wire gat/vase sam/vase}
      ^+  +>+>
      (dy-ford way `schematic:ford`[%ntbs [%ntdt gat] [%ntdt sam]])
    ::
    ++  dy-errd                                         ::  reject change, abet
      |=  {rev/(unit sole-edit) err/@u}
      ^+  +>+>
      (he-errd(poy `+>+<) rev err)
    ::
    ++  dy-diff                                         ::  send effects, abet
      |=  fec/sole-effect
      ^+  +>+>
      (he-diff(poy `+>+<) fec)
    ::
    ++  dy-rash                                         ::  send effects, amok
      |=  fec/sole-effect
      ^+  +>+>
      (he-diff(poy ~) fec)
    ::
    ++  dy-init-command                                 ::  ++dojo-command
      |=  mad/dojo-command
      ^+  [mad +>]
      ?@  -.mad  [mad +>.$]
      =.  q.mad
        ?+(-.p.mad q.mad $http [0 %as %mime q.mad])
      =^  src  +>.$  (dy-init-source q.mad)
      [mad(q src) +>.$]
    ::
    ++  dy-init-source                                  ::  ++dojo-source
      |=  src/dojo-source
      ^+  [src +>]
      =^  bul  +>  (dy-init-build q.src)
      =:  p.src  num
          q.src  bul
        ==
      [src +>.$(num +(num), job (~(put by job) -.src +.src))]
    ::
    ++  dy-init-source-unit                             ::  (unit dojo-source)
      |=  urc/(unit dojo-source)
      ^+  [urc +>]
      ?~  urc  [~ +>]
      =^  src  +>  (dy-init-source u.urc)
      [`src +>.$]
    ::
    ++  dy-init-build                                   ::  ++dojo-build
      |=  bul/dojo-build
      ^+  [bul +>]
      ?-    -.bul
        $ex  [bul +>.$]
        $dv  [bul +>.$]
        $sa  [bul +>.$]
        $as  =^(mor +>.$ (dy-init-source q.bul) [bul(q mor) +>.$])
        $do  =^(mor +>.$ (dy-init-source q.bul) [bul(q mor) +>.$])
        $ge  =^(mod +>.$ (dy-init-model p.bul) [[%ge mod] +>.$])
        $ur  [bul +>.$]
        $tu  =^  dof  +>.$
                 |-  ^+  [p.bul +>.^$]
                 ?~  p.bul  [~ +>.^$]
                 =^  dis  +>.^$  (dy-init-source i.p.bul)
                 =^  mor  +>.^$  $(p.bul t.p.bul)
                 [[dis mor] +>.^$]
             [[%tu dof] +>.$]
      ==
    ::
    ++  dy-init-model                                   ::  ++dojo-model
      |=  mol/dojo-model
      ^+  [mol +>]
      =^  one  +>.$  (dy-init-server p.mol)
      =^  two  +>.$  (dy-init-config q.mol)
      [[one two] +>.$]
    ::
    ++  dy-init-server                                  ::  ++dojo-server
      |=  srv/dojo-server
      =.  p.srv  num
      [srv +>.$(num +(num), job (~(put by job) num [%dv [%gen q.srv]]))]
    ::
    ++  dy-init-config                                  ::  prepare config
      |=  cig/dojo-config
      ^+  [cig +>]
      =^  ord  +>.$  (dy-init-ordered p.cig)
      =^  key  +>.$  (dy-init-named q.cig)
      [[ord key] +>.$]
    ::
    ++  dy-init-ordered                                 ::  (list dojo-source)
      |=  ord/(list dojo-source)
      ^+  [ord +>]
      ?~  ord  [~ +>.$]
      =^  fir  +>.$  (dy-init-source i.ord)
      =^  mor  +>.$  $(ord t.ord)
      [[fir mor] +>.$]
    ::
    ++  dy-init-named                                   ::  (map @tas dojo-src)
      |=  key/(map term (unit dojo-source))
      ^+  [key +>.$]
      ?~  key  [~ +>.$]
      =^  top  +>.$  (dy-init-source-unit q.n.key)
      =^  lef  +>.$  $(key l.key)
      =^  rit  +>.$  $(key r.key)
      [[[p.n.key top] lef rit] +>.$]
    ::
    ++  dy-init                                         ::  full initialize
      ^+  .
      =^(dam . (dy-init-command mad) +(mad dam))
    ::
    ++  dy-hand                                         ::  complete step
      |=  vax=vase
      ^+  +>+>
      ?>  ?=(^ cud)
      ::  TODO replace when we have real printing
      ::
      =/  =mark  ?~(((soft tang) q.vax) %noun %tang)
      (dy-step(cud ~, rez (~(put by rez) p.u.cud [mark vax])) +(p.u.cud))
    ::
    ++  dy-meal                                         ::  vase to cage
      |=  vax/vase
      ::
      ?>  ?=(^ cud)
      ::
      ?.  &(?=(@ -.q.vax) ((sane %tas) -.q.vax))
        ~&  %dy-meal-cage
        (dy-rash %bel ~)
      ::  TODO: duplicate code with +dy-hand
      ::
      =/  cay=cage  (vase-to-cage:forder vax)
      ::  TODO: clean up after we have real printing
      ::
      =/  maybe-tang  ((soft tang) q.q.cay)
      =?  cay  ?=(^ maybe-tang)  [%tang -:!>(*tang) u.maybe-tang]
      ::
      (dy-step(cud ~, rez (~(put by rez) p.u.cud cay)) +(p.u.cud))
    ::
    ++  dy-made-edit                                    ::  sole edit
      |=  vax=vase
      ^+  +>+>
      ?>  ?=(^ per)
      ?:  ?|  ?=(^ q.vax)
              =((lent buf.say) q.vax)
              !&(?=($del -.u.per) =(+(p.u.per) (lent buf.say)))
          ==
        dy-abet(per ~)
      (dy-errd(per ~) per q.vax)
    ::
    ++  dy-done                                         ::  dialog submit
      |=  txt/tape
      ?:  |(?=(^ per) ?=(^ pux) ?=(~ pro))
        ~&  %dy-no-prompt
        (dy-diff %bel ~)
      (dy-slam /dial u.pro !>(txt))
    ::
    ++  dy-cast
      |*  {typ/_* bun/vase}
      |=  a/vase  ^-  typ
      ~|  [p.bun p.a]
      ?>  (~(nest ut p.bun) & p.a)
      ;;(typ q.a)
    ::
    ++  dy-over                                         ::  finish construction
      ^+  +>
      ::  XX needs filter
      ::
      :: ?:  ?=({$show $3} -.mad)
      ::  (dy-rash %tan (dy-show-source q.mad) ~)       ::  XX separate command
      ~&  [%dy-over -.mad]
      ?:  ?=($brev -.mad)
        =.  var  (~(del by var) p.mad)
        =<  dy-amok
        ?+  p.mad  . 
          $?($eny $now $our)  !!
          $dir  .(dir [[our.hid %home ud+0] /])
        ==
      =+  cay=(~(got by rez) p.q.mad)
      ?-    -.p.mad
          $verb
        =.  var  (~(put by var) p.p.mad cay)
        ~|  bad-set+[p.p.mad p.q.cay]
        =<  dy-amok
        ?+  p.p.mad  .
            $eny  ~|(%entropy-is-eternal !!)
            $now  ~|(%time-is-immutable !!)
            $our  ~|(%self-is-immutable !!)
        ::
            $dir  =+  ^=  pax  ^-  path
                      =+  pax=((dy-cast path !>(*path)) q.cay)
                      ?:  ?=(~ pax)  ~[(scot %p our.hid) %home '0']
                      ?:  ?=({@ ~} pax)  ~[i.pax %home '0']
                      ?:  ?=({@ @ ~} pax)  ~[i.pax i.t.pax '0']
                      pax
                  =.  dir  (need (de-beam pax))
                  =-  +>(..dy (he-diff %tan - ~))
                  rose+[" " `~]^~[leaf+"=%" (smyt (en-beam he-beak s.dir))]
        ==
      ::
          $poke
        %-  he-card(poy ~)
        :*  %deal
            /poke
            [our.hid p.p.p.mad]
            q.p.p.mad
            %poke
            ::  TODO this is gross
            ::
            ::  (vase-to-cage:forder q.cay)
            cay
        ==
      ::
          $file
        %-  he-card(poy ~)  :*
          %info
          /file
          our.hid
          (foal (en-beam p.p.mad) cay)
        ==
      ::
          $flat
        ?^  q.q.cay 
          (dy-rash %tan [%leaf "not an atom"]~)
        (dy-rash %sav p.p.mad q.q.cay)
      ::
          $pill
        ~&  [%dojo-pill ?^(q.q.cay -.q.q.cay %is-atom)]
        (dy-rash %sag p.p.mad q.q.cay)
      ::
          $http
        ?>  ?=($mime p.cay)
        =+  mim=;;(mime q.q.cay)
        =+  maf=(~(add ja *math:eyre) %content-type (en-mite:mimes:html p.mim))
        (dy-eyre /show q.p.mad [r.p.mad p.p.mad maf ~ q.mim])
      ::
          $show
        %+  dy-print  cay
        =+  mar=|.(?:(=(%noun p.cay) ~ [%rose [~ "    " ~] >p.cay< ~]~))
        ?-  p.p.mad
          $0  ~
          $1  [[%rose [~ "  " ~] (skol p.q.cay) ~] (mar)]
          $2  [[%rose [~ "  " ~] (dy-show-type-noun p.q.cay) ~] (mar)]
          $3  ~
        ==
      ==
    ::
    ++  dy-show  |=(cay/cage (dy-print cay ~))
    ++  dy-print
      |=  {cay/cage tan/tang}
      %+  dy-rash  %tan
      %-  welp  :_  tan
      ?+  p.cay  ~&(%dy-print [(sell q.cay)]~)
        $tang  ;;(tang q.q.cay)
        $httr
          =+  hit=;;(httr:eyre q.q.cay)
          =-  (flop (turn `wall`- |=(a/tape leaf+(dash:us a '' ~))))
          :-  "HTTP {<p.hit>}"
          %+  weld
            (turn q.hit |=({a/@t b/@t} "{(trip a)}: {(trip b)}"))
          :-  i=""
          t=(turn `wain`?~(r.hit ~ (to-wain:format q.u.r.hit)) trip)
      ==
    ::  truncates `t` down to `i` characters, adding an ellipsis.
    ::
    ++  dy-truncate
      ::  todo: when ~palfun's string library is landed, switch to his
      ::  implementation.
      |=  {i/@u t/tape}
      ^-  tape
      =+  t-len=(lent t)
      ?:  (lth t-len i)
        t
      :(weld (scag (sub i 4) t) "...")
    ::
    ::  creates a tape of i spaces, used for padding.
    ++  dy-build-space
      ::  todo: when ~palfun's string library is landed, switch to his
      ::  implementation.
      |=  i/@u
      ^-  tape
      =|  t/tape
      |-
      ?:  =(0 i)
        t
      $(t (weld " " t), i (sub i 1))
    ::
    ::  returns the length of the longest tape in c.
    ++  dy-longest-tape
      |=  c/(list tape)
      =|  ret/@ud
      |-
      ?~  c
        ret
      =+  l=(lent i.c)
      ?:  (gth l ret)
        $(ret l, c t.c)
      $(c t.c)
    ::
    ++  dy-show-type-noun
      |=  a/type  ^-  tank
      *tank
    ::
    ++  dy-edit                                         ::  handle edit
      |=  cal/sole-change
      ^+  +>+>
      =^  dat  say  (~(transceive ^sole say) cal)
      ?:  |(?=(^ per) ?=(^ pux) ?=(~ pro))
        ~&  %dy-edit-busy
        =^  lic  say  (~(transmit ^sole say) dat)
        (dy-diff %mor [%det lic] [%bel ~] ~)
      (dy-slam(per `dat) /edit u.pro !>((tufa buf.say)))
    ::
    ++  dy-type                                         ::  sole action
      |=  act/sole-action
      ?-  -.act
        $det  (dy-edit +.act)
        $ret  (dy-done (tufa buf.say))
        $clr  dy-stop
      ==
    ::
    ++  dy-cage       |=(num/@ud (~(got by rez) num))   ::  known cage
    ++  dy-vase       |=(num/@ud q:(dy-cage num))       ::  known vase
    ::
    ++  dy-run-generator
      |=  {cay/cage cig/dojo-config}
      ^-  [wire schematic:ford]
      ::
      ?.  (~(nest ut [%cell [%atom %$ ~] %noun]) | p.q.cay)
        ::
        ::  naked gate
        ::
        ?.  &(?=({* ~} p.cig) ?=(~ q.cig))
          ~|(%one-argument !!)
        :-  /noun
        :+  %ntbs
          [%ntdt q.cay]
        [%ntdt (dy-vase p.i.p.cig)]
      ::  non-naked generator: produce a wire depending on the kind of generator
      ::
      :-  ?+  -.q.q.cay  ~|(%bad-gen ~_((sell (slot 2 q.cay)) !!))
            %say  /gent
            %ask  /dial
            %get  /scar
            %bud  /make
          ==
      ::  tell ford to eval the schematic produced by a %bud generator
      ::
      =-  ?.  =(%bud -.q.q.cay)
            run-generator
          ::
          :+  %ntnt
            [%ntcb ^~((ream '..zuse'))]
          run-generator
      ::  produce a schematic that runs the generator gate
      ::
      ^=  run-generator
      ^-  schematic:ford
      ::
      =+  gat=(slot 3 q.cay)
      ::
      :+  %ntbs
        [%ntdt gat]
      :+  [%ntdt !>([now=now.hid eny=eny.hid bec=he-beak])]
        ::  collect positional command-line arguments
        ::
        :-  %ntdt
        =/  src  p.cig
        ::
        |-  ^-  vase
        ?~  src  !>(~)
        (slop (dy-vase p.i.src) $(src t.src))
      ::  modify the default keyword arguments with supplied values
      ::
      :+  %ntbn  [%ntdt (fall (slew 27 gat) !>(~))]
      ::
      =/  args  ~(tap by q.cig)
      ::  build up from the identity schematic
      ::
      =/  res=schematic:ford  [%ntcb %$ 1]
      ::
      |-  ^+  res
      ?~  args  res
      ::
      =/  =term                   p.i.args
      =/  sor=(unit dojo-source)  q.i.args
      ::
      =.  res
        :+  %ntbn
          :+  %ntls  :+  %ntts  %arg-value
            :-  %ntdt
            ?~  sor
              !>([~ ~])
            (dy-vase p.u.sor)
          :-  %ntcb
          ^~((ream (crip ".({(trip term)} arg-value)")))
        res
      ::
      $(args t.args)
    ::
    ++  dy-hoon-subject                                 ::  dynamic state
      ::
      ::  our: the name of this urbit
      ::  now: the current time
      ::  eny: a piece of random entropy
      ::
      ^-  vase
      ::  prepend the event information so it shadows user-defined variables
      ::
      %+  slop
        !>([our=our now=now eny=eny]:hid)
      ::  start from the standard library
      ::
      =/  subject=vase  pit
      ::  prepend user-defined variables to the standard library
      ::
      =/  vars  ~(tap by var)
      ::
      |-  ^+  subject
      ?~  vars  subject
      ::
      =/  var-name=term  p.i.vars
      =/  value=vase     q.q.i.vars
      ::
      =.  subject  (slop [[%face var-name p.value] q.value] subject)
      ::
      $(vars t.vars)
    ::
    ++  dy-made-dial                                    ::  dialog product
      |=  vaz=vase
      ^+  +>+>
      ?.  ?=(^ q.vaz)
        (dy-errd ~ q.vaz)
      =+  tan=(tang +2.q.vaz)
      =.  +>+>.$  (he-diff %tan tan)
      =+  vax=(sped (slot 3 vaz))
      ?+    -.q.vax  !!
          %&
        ?~  +.q.vax
          ~&  %dy-made-dial-abort
          (dy-rash %bel ~)
        (dy-meal (slot 7 vax))
      ::
          %|
        =<  he-pone
        %-  dy-diff(pro `(slap (slot 7 vax) [%limb %q]))
        =+  pom=(sole-prompt +<.q.vax)
        [%pro pom(cad [':' ' ' cad.pom])]
      ==
    ::
    ++  dy-made-scar                                    ::  scraper product
      |=  vaz=vase
      ^+  +>+>
      ?.  ?=(^ q.vaz)
        (dy-errd ~ q.vaz)
      =+  tan=(tang +2.q.vaz)
      =.  +>+>.$  (he-diff %tan tan)
      =+  vax=(sped (slot 3 vaz))
      ~_  (sell vaz)
      ?+    -.q.vax  !!
          %&
        ?~  +.q.vax
          ~&  %dy-made-scar-abort
          (dy-rash %bel ~)
        (dy-meal (slot 7 vax))
      ::
          %|
        =>  .(vax (slap vax !,(*hoon ?>(?=(%| -) .))))  :: XX working sped  #72
        =+  typ={%| (unit knot) hiss:eyre *}
        =+  [* usr hiz *]=((dy-cast typ !>($:typ)) vax)
        =.  ..dy  (he-diff %tan leaf+"< {(en-purl:html p.hiz)}" ~)
        (dy-eyre(pro `(slap (slot 15 vax) limb+%r)) /scar usr hiz)
      ==
    ::
    ++  dy-sigh-scar                                    ::  scraper result
      |=  dat/cage
      ?~  pro
        ~&  %dy-no-scraper
        (dy-show dat)
      (dy-slam(pux ~) /scar u.pro q.dat) 
    ::
    ++  dy-made-gent                                    ::  %say gen product
      |=  vax=vase
      (dy-meal vax)
    ::
    ++  dy-made-noun                                    ::  naked gen product
      |=  vax=vase
      (dy-hand vax)
    ::
    ++  dy-made-make                                    ::  %bud gen product
      |=  vax=vase
      (dy-hand vax)
    ::
    ++  dy-make                                         ::  build step
      ^+  +>
      ?>  ?=(^ cud)
      =+  bil=q.u.cud                 ::  XX =*
      ?:  ?=($ur -.bil)
        (dy-eyre /hand p.bil [q.bil %get ~ ~])
      %-  dy-ford
      ^-  [path schematic:ford]
      ~&  [%dy-make -.bil]
      ?-  -.bil
        $ge  (dy-run-generator (dy-cage p.p.p.bil) q.p.bil)
        $dv  [/hand [%ntpd [%ntdt !>([he-disc (weld /hoon (flop p.bil))])]]]
        $ex  [/hand (dy-run-hoon p.bil)]
        $sa  [/hand (bunt:marker mark=p.bil disc=he-disc)]
        $as  [/hand (dy-cast-to-mark p.bil q.bil)]
        $do  [/hand [%ntbs (dy-run-hoon p.bil) [%ntdt (dy-vase p.q.bil)]]]
        ::$fo  :-  /hand
        ::     :+  %ntls  [%ntdt q:dy-hoon-head]
        ::     :+  %ntnt  [%ntcb ^~((ream '..zuse'))]
        ::     :+  %ntnt  [%ntcb ^~((ream '.'))]
        ::     [%ntcb p.bil]
        $tu  :-  /hand
             :-  %ntdt
             |-  ^-  vase
             ?~  p.bil  !!
             =+  hed=(dy-vase p.i.p.bil)
             ?~  t.p.bil  hed
             (slop hed $(p.bil t.p.bil))
      ==
    ::
    ++  dy-cast-to-mark
      |=  [end-mark=mark =dojo-source]
      ^-  schematic:ford
      ::
      =/  =cage  (dy-cage p.dojo-source)
      ::
      (cast:marker data=q.cage start=[p.cage he-disc] end=[end-mark he-disc])
    ::
    ++  dy-run-hoon
      |=  gen/hoon
      ^-  schematic:ford
      ::
      :+  %ntbn
        [%ntdt dy-hoon-subject]
      [%ntcb gen]
    ::
    ++  dy-step                                         ::  advance project
      |=  nex/@ud
      ^+  +>+>
      ?>  ?=(~ cud)
      ?:  ?=({$show $3} -.mad)
        ~&  %dy-step-show-3
        he-easter:dy-over
      ?:  =(nex num)
        ~&  %dy-step-over
        he-easter:dy-over
      ~&  %dy-step-make
      dy-make(cud `[nex (~(got by job) nex)])
    --
  ::
  ++  he-dope                                           ::  sole user of ++dp
    |=  txt/tape                                        ::
    ^-  (each (unit (each dojo-command tape)) hair)     ::  prefix+result
    =+  len=+((lent txt))                               ::  line length
    =.  txt  (weld buf `tape`(weld txt "\0a"))          ::
    =+  vex=((full dp-command-line):dp [1 1] txt)       ::
    ?:  =(q.p.vex len)                                  ::  matched to line end
      [%& ~]                                            ::
    ?:  =(p.p.vex +((lent (skim txt |=(a/@ =(10 a)))))) ::  parsed all lines
      [%& ~ ?~(q.vex [%| txt] [%& p.u.q.vex])]          ::  new buffer+complete
    [%| p.p.vex (dec q.p.vex)]                          ::  syntax error
  ::  
  ++  he-duke                                           ::  ++he-dope variant
    |=  txt/tape
    ^-  (each (unit (each dojo-command tape)) @ud)
    =+  foy=(he-dope txt)
    ?-  -.foy
      %|  [%| q.p.foy]
      %&  [%& p.foy]
    ==
  ::
  ++  he-easter                                         ::  hint messages
    ^+  .
    =.  egg  +(egg)
    =-  ?~(msg ..he-diff (he-diff %tan leaf+u.msg ~))
    ^-  msg/(unit tape)
    ?+  (clan:title our.hid)  ~
      $pawn  ?+  egg  ~
                $5  `":: To request a planet, run  |ask 'your@email.co'"
    ==       ==  
  ::
  ++  he-abet                                           ::  resolve
    [(flop moz) %_(+> hoc (~(put by hoc) ost.hid +<+))]
  ::
  ++  he-abut                                           ::  discard
    =>  he-stop
    [(flop moz) %_(+> hoc (~(del by hoc) ost.hid))]
  ::
  ++  he-disc  [p q]:he-beam
  ++  he-beak  [p q r]:he-beam
  ++  he-rail  [[p q] s]:he-beam
  ++  he-beam                                           ::  logical beam
    ^-  beam
    ?.  =(ud+0 r.dir)  dir
    dir(r [%da now.hid])
  ::
  ++  he-card                                           ::  emit gift
    |=  cad/card
    ^+  +>
    %_(+> moz [[ost.hid cad] moz])
  ::
  ++  he-send
    |=  {way/wire him/ship dap/term cop/clap}
    ^+  +>
    (he-card %send way [him dap] cop)
  ::
  ++  he-diff                                           ::  emit update
    |=  fec/sole-effect
    ^+  +>
    (he-card %diff %sole-effect fec)
  ::
  ++  he-stop                                           ::  abort work
    ^+  .
    ?~(poy . ~(dy-stop dy u.poy))
  ::
  ++  he-peer                                           ::  subscribe to
    |=(pax/path ?>(=(~ pax) he-prom))
  ::
  ++  he-pine                                           ::  restore prompt
    ^+  .
    ?^  poy  ~&  %he-pine-poy  .
    ~&  %he-pine-no-poy
    he-prom:he-pone
  ::
  ++  he-errd                                           ::  reject update
    |=  {rev/(unit sole-edit) err/@u}  ^+  +>
    =+  red=(fall rev [%nop ~])       ::  required for error location sync
    =^  lic  say  (~(transmit ^sole say) red)
    (he-diff %mor [%det lic] [%err err] ~)
  ::
  ++  he-pone                                           ::  clear prompt
    ^+  .
    =^  cal  say  (~(transmit ^sole say) [%set ~])
    (he-diff %mor [%det cal] ~)
  ::
  ++  he-prow                                           ::  where we are
    ^-  tape
    ?:  &(=(our.hid p.dir) =(%home q.dir) =([%ud 0] r.dir) =(~ s.dir))  ~
    %+  weld
      ?:  &(=(our.hid p.dir) =([%ud 0] r.dir))
        (weld "/" (trip q.dir))
      ;:  weld
        "/"  ?:(=(our.hid p.dir) "=" (scow %p p.dir))
        "/"  ?:(=(%home q.dir) "=" (trip q.dir))
        "/"  ?:(=([%ud 0] r.dir) "=" (scow r.dir))
      == 
    ?:(=(~ s.dir) "" (spud (flop s.dir)))
  ::
  ++  he-prom                                           ::  send prompt
    %-  he-diff
    :-  %pro
    [& %$ (weld he-prow ?~(buf "> " "< "))]
  ::
  ++  he-made                                           ::  result from ford
    |=  $:  way=wire
            date=@da
            $=  result
            $%  [%complete result=(each vase tang)]
                [%incomplete =tang]
        ==  ==
    ^+  +>
    ?>  ?=(^ poy)
    =<  he-pine
    ?-    -.result
        %incomplete
      (he-diff(poy ~) %tan tang.result)
    ::
        %complete
      ?-    -.result.result
          ::
          %&
        ::
        %.  p.result.result
        =+  dye=~(. dy u.poy(pux ~))
        ?+  way  !!
          {$hand ~}  dy-hand:dye
          {$dial ~}  dy-made-dial:dye
          {$gent ~}  dy-made-gent:dye
          {$noun ~}  dy-made-noun:dye
          {$scar ~}  dy-made-scar:dye
          {$make ~}  dy-made-make:dye
          {$edit ~}  dy-made-edit:dye
        ==
      ::
          %|
        (he-diff(poy ~) %tan p.result.result)
    ==  ==
  ::
  ++  he-sigh                                           ::  result from eyre
    |=  {way/wire hit/httr:eyre}
    ^+  +>
    ?>  ?=(^ poy)
    =<  he-pine
    =+  dye=~(. dy u.poy(pux ~))
    ?+  way  !!
      {$hand ~}  (dy-hand:dye !>(hit))
      {$show ~}  (dy-show:dye [%httr !>(hit)])
      {$scar ~}  (dy-sigh-scar:dye [%httr !>(hit)])
    ==
  ::
  ++  he-unto                                           ::  result from behn
    |=  {way/wire cit/cuft:gall}
    ^+  +>
    ?.  ?=($coup -.cit)
      ~&  [%strange-unto cit]
      +>
    ?~  p.cit  
      (he-diff %txt ">=")
    (he-diff %tan u.p.cit)
  ::
  ++  he-lens
    |=  com/command:^^^^lens
    ^+  +>
    =+  ^-  source/dojo-source
        =|  num/@
        =-  ?.  ?=($send-api -.sink.com)  ::  XX  num is incorrect
              sor
            :-  0
            :+  %as  `mark`(cat 3 api.sink.com '-poke')
            :-  1
            :+  %do
              ^-  hoon
              :+  %brtr  [%base %noun]
              :^  %clls  [%rock %tas %post]
                [%rock %$ endpoint.sink.com]
              [%cnts [%& 6]~ ~]
            sor
        ^=  sor
        |-  ^-  dojo-source
        :-  num
        ?-    -.source.com
            $data        [%ex %sand %t data.source.com]
            $dojo
          %+  rash  command.source.com
          (ifix [(punt gap) (punt gap)] dp-build:dp)
        ::
            $clay
          :-  %ex
          ^-  hoon
          :+  %dtkt
            [%base %noun]
          :+  %clhp
            [%rock %tas %cx]
          %+  rash  pax.source.com
          rood:(vang | /(scot %p our.hid)/home/(scot %da now.hid))
        ::
            $url         [%ur `~. url.source.com]
            $api         !!
            $get-api
          :-  %ex
          ^-  hoon
          :+  %dtkt
            [%like ~[%json] ~]
          :*  %clsg
              [%rock %tas %gx]
              [%sand %ta (scot %p our.hid)]
              [%sand %tas api.source.com]
              [%sand %ta (scot %da now.hid)]
              (turn endpoint.source.com |=(a/@t [%sand %ta a]))
          ==
        ::
            $listen-api  !!
            $as
          :*  %as  mar.source.com
              $(num +(num), source.com next.source.com)
          ==
        ::
            $hoon
          :*  %do
              %+  rash  code.source.com
              tall:(vang | /(scot %p our.hid)/home/(scot %da now.hid))
              $(num +(num), source.com next.source.com)
          ==
        ::
            $tuple
          :-  %tu
          |-  ^-  (list dojo-source)
          ?~  next.source.com
            ~
          =.  num  +(num)
          :-  ^$(source.com i.next.source.com)
          $(next.source.com t.next.source.com)
        ==
    =+  |-  ^-  sink/dojo-sink
        ?-  -.sink.com
          $stdout       [%show %0]
          $output-file  $(sink.com [%command (cat 3 '@' pax.sink.com)])
          $output-clay  [%file (need (de-beam pax.sink.com))]
          $url          [%http %post `~. url.sink.com]
          $to-api       !!
          $send-api     [%poke our.hid api.sink.com]
          $command      (rash command.sink.com dp-sink:dp)
          $app          [%poke our.hid app.sink.com]
        ==
    (he-plan sink source)
  ::
  ++  he-like                                           ::  accept line
    |=  buf/(list @c)
    =(%& -:(he-dope (tufa buf)))
  ::
  ++  he-stir                                           ::  apply change
    |=  cal/sole-change
    ^+  +>
    ::  ~&  [%his-clock ler.cal]
    ::  ~&  [%our-clock ven.say]
    =^  dat  say  (~(transceive ^sole say) cal)
    ?.  ?&  ?=($del -.dat)
            =(+(p.dat) (lent buf.say))
        ==
      +>.$
    =+  foy=(he-dope (tufa buf.say))
    ?:  ?=(%& -.foy)  +>.$
    ::  ~&  [%bad-change dat ted.cal]
    ::  ~&  [%our-leg leg.say]
    (he-errd `dat q.p.foy)
  ::
  ++  he-plan                                           ::  execute command
    |=  mad/dojo-command
    ^+  +>
    ?>  ?=(~ poy)
    he-pine:(dy-step:~(dy-init dy %*(. *dojo-project mad mad)) 0)
  ::
  ++  he-done                                           ::  parse command
    |=  txt/tape
    ^+  +>
    ?~  txt
      =<  he-prom(buf ~)
      %-  he-diff
      :~  %mor
          [%txt "> "]
          [%nex ~]
      ==
    =+  doy=(he-duke txt)
    ?-    -.doy
        %|  (he-errd ~ p.doy)
        %&
      ?~  p.doy
        (he-errd ~ (lent txt))
      =+  old=(weld ?~(buf "> " "  ") (tufa buf.say))
      =^  cal  say  (~(transmit ^sole say) [%set ~])
      =.  +>.$   (he-diff %mor txt+old nex+~ det+cal ~)
      ?-  -.u.p.doy
        %&  (he-plan(buf ~) p.u.p.doy)
        %|  he-prom(buf p.u.p.doy)
      ==
    ==
  ::
  ++  he-type                                           ::  apply input
    |=  act/sole-action
    ^+  +>
    ?^  poy
      he-pine:(~(dy-type dy u.poy) act)
    ?-  -.act
      $det  (he-stir +.act)
      $ret  (he-done (tufa buf.say))
      $clr  he-pine(buf "")
    ==
  ::
  ++  he-lame                                           ::  handle error
    |=  {wut/term why/tang}
    ^+  +>
    %-  (slog (flop `tang`[>%dojo-lame wut< why]))
    ?^  poy
      he-pine:~(dy-amok dy u.poy)
    he-pine                           ::  XX give mean to original keystroke
  --
::
++  prep
  |=  old/(unit house)
  ^+  [~ ..prep]
  ?~  old  `..prep
  `..prep(+<+ u.old)
::
::  pattern:  ++  foo  |=(data he-abet:(~(he-foo he (~(got by hoc) ost)) data))
++  arm  (arm-session ~ (~(got by hoc) ost.hid))
++  arm-session
  |=  {moz/(list move) ses/session}
  =>  ~(. he moz ses)
  =-  [wrap=- +]
  =+  he-arm=he-type
  |@  ++  $
        |:  +<.he-arm  
        ^-  (quip move _..he)
        he-abet:(he-arm +<)
  --
::
++  peer-sole
  ~?  !=(our.hid src.hid)  [%dojo-peer-stranger ost.hid src.hid]
  ?>  (team:title our.hid src.hid)
  =^  moz  .
    ?.  (~(has by hoc) ost.hid)  [~ .]
    ~&  [%dojo-peer-replaced ost.hid]
    ~(he-abut he ~ (~(got by hoc) ost.hid))
  =+  ses=%*(. *session -.dir [our.hid %home ud+0])
  (wrap he-peer):(arm-session moz ses)
::
++  poke-sole-action
  |=  act/sole-action  ~|  poke+act  %.  act
  (wrap he-type):arm
::
++  poke-lens-command
  |=  com/command:^^^^lens  ~|  poke-lens+com  %.  com
  (wrap he-lens):arm
::
++  poke-json
  |=  jon/json
  ^-  {(list move) _+>.$}
  ~&  jon=jon
  [~ +>.$]
::
++  made       (wrap he-made):arm
++  sigh-httr  (wrap he-sigh):arm
++  sigh-tang  |=({a/wire b/tang} ~|(`term`(cat 3 'sigh-' -.a) (mean b)))
++  lame       (wrap he-lame):arm
++  unto       (wrap he-unto):arm
++  pull
  |=  {pax/path}
  ^-  (quip move _+>)
  =^  moz  +>  ~(he-abut he ~ (~(got by hoc) ost.hid))
  [moz +>.$(hoc (~(del by hoc) ost.hid))]
--
