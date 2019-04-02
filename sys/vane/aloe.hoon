::  %aloe, message transceiver
::
::    Implements the Ames network protocol for messaging among ships.
::
!:
!?  141
::  3-bit ames protocol version; only packets at this version will be accepted
::
=/  protocol-version=?(%0 %1 %2 %3 %4 %5 %6 %7)  %0
=>
::  type definitions
::
|%
::  |able: public move interfaces
::
++  able
  |%
  ::  +task: requests to this vane
  ::
  +$  task
    $%  ::  %pass-message: encode and send :message to another :ship
        ::
        [%pass-message =ship =path message=*]
        ::  %forward-message: ask :ship to relay :message to another ship
        ::
        ::    This sends :ship a message that has been wrapped in an envelope
        ::    containing the address of the intended recipient.
        ::
        [%forward-message =ship =path message=*]
        ::  %hear: receive a packet from unix
        ::
        [%hear =lane packet=@]
        ::  %hole: receive notification from unix that packet crashed
        ::
        [%hole =lane packet=@]
        ::  %born: urbit process restarted
        ::
        [%born ~]
        ::  %crud: previous unix event errored
        ::
        [%crud =error]
        ::  %vega: kernel reset notification
        ::
        [%vega ~]
        ::  %wegh: request for memory usage report
        ::
        [%wegh ~]
    ==
  ::  +gift: responses from this vane
  ::
  +$  gift
    $%  ::  %ack-message: ack for a command, sent to a client vane
        ::
        ::    Flows we initiate are called "forward flows." In a forward flow,
        ::    a client vane can ask us to send a command to our neighbor.
        ::    When we get a message from the neighbor acking our command,
        ::    we notify the client vane by sending it this gift.
        ::
        [%ack-message =error=(unit error)]
        ::  %give-message: relay response message to another vane
        ::
        ::    Emitted upon hearing a message from Unix (originally from
        ::    another ship) in response to a message the vane
        ::    asked us to send.
        ::
        [%give-message message=*]
        ::  %send: tell unix to send a packet to another ship
        ::
        ::    Each %mess +task will cause one or more %send gifts to be
        ::    emitted to Unix, one per message fragment.
        ::
        [%send =lane packet=@]
        ::  %turf: tell unix which domains to bind
        ::
        ::    Sometimes Jael learns new domains we should be using
        ::    to look up galaxies. We hand this information to Unix.
        ::
        [%turf domains=(list domain)]
        ::  %mass: memory usage report, in response to a %wegh +task
        ::
        [%mass =mass]
    ==
  --
::  +move: output effect
::
+$  move  [=duct card=(wind note gift:able)]
::  +note: request from us to another vane
::
+$  note
  $%  $:  %b
          $%  ::  %wait: set a timer at :date
              ::
              [%wait date=@da]
              ::  %rest: cancel a timer at :date
              ::
              [%rest date=@da]
      ==  ==
      $:  %c
          $%  ::  %pass-message: encode and send :message to :ship
              ::
              [%pass-message =ship =path message=*]
      ==  ==
      $:  %d
          $%  [%flog =flog:dill]
      ==  ==
      $:  %g
          $%  ::  %pass-message: encode and send :message to :ship
              ::
              [%pass-message =ship =path message=*]
      ==  ==
      $:  %j
          $%  ::  %pass-message: encode and send :message to :ship
              ::
              [%pass-message =ship =path message=*]
              ::  %meet: tell jael we've neighbored with :ship at :life
              ::
              [%meet =ship =life]
              ::  %pubs: subscribe to public keys for :ship
              ::
              [%pubs =ship]
              ::  %turf: subscribe to domains to look up galaxies
              ::
              ::    We'll relay this information out to Unix when we receive
              ::    an update from Jael.
              ::
              [%turf ~]
              ::  %vein: subscribe to our private keys
              ::
              [%vein ~]
  ==  ==  ==
::  +sign: response to us from another vane
::
+$  sign
  $%  $:  %b
          $%  ::  %wake: a timer we set has elapsed
              ::
              [%wake ~]
      ==  ==
      $:  %c
          $%  ::  %give-message: response (subscription update) from clay
              ::
              ::    Only applicable for backward flows, where the neighbor
              ::    initiated the flow and we're streaming down subscription
              ::    data.
              ::
              [%give-message message=*]
              ::  %ack-message: acknowledge a request (forward message)
              ::
              ::    If :error is non-null, this is a nack (negative
              ::    acknowledgment). An Ames client must acknowledge a request,
              ::    whereas a subscription update has no application-level
              ::    ack; just a message ack from Ames.
              ::
              [%ack-message =error=(unit error)]
      ==  ==
      $:  %g
          $%  ::  %give-message: response (subscription update) from a gall app
              ::
              ::    Only applicable for backward flows, where the neighbor
              ::    initiated the flow and we're streaming down subscription
              ::    data.
              ::
              [%give-message message=*]
              ::  %ack-message: acknowledge a request (forward message)
              ::
              ::    If :error is non-null, this is a nack (negative
              ::    acknowledgment). An Ames client must acknowledge a request,
              ::    whereas a subscription update has no application-level
              ::    ack; just a message ack from Ames.
              ::
              [%ack-message =error=(unit error)]
      ==  ==
      $:  %j
          $%  ::  %give-message: response (subscription update) from jael
              ::
              ::    Only applicable for backward flows, where the neighbor
              ::    initiated the flow and we're streaming down subscription
              ::    data.
              ::
              [%give-message message=*]
              ::  %ack-message: acknowledge a request (forward message)
              ::
              ::    If :error is non-null, this is a nack (negative
              ::    acknowledgment). An Ames client must acknowledge a request,
              ::    whereas a subscription update has no application-level
              ::    ack; just a message ack from Ames.
              ::
              [%ack-message =error=(unit error)]
              ::  %pubs: a ship's public keys changed
              ::
              [%pubs public:able:jael]
              ::  %sunk: a ship breached (reincarnated)
              ::
              [%sunk =ship =life]
              ::  %turf: receive new list of galaxy domains
              ::
              ::    We'll relay this information out to Unix.
              ::
              [%turf domains=(list domain)]
              ::  %vein: our private keys changed
              ::
              [%vein =life vein=(map life ring)]
  ==  ==  ==
::  +ames-state: all persistent state
::
+$  ames-state  ~
::  +domain: an HTTP domain, as list of '.'-delimited segments
::
+$  domain  (list @t)
::  +lane: route; ip addresss, port, and expiration date
::
::    A lane can expire when we're no longer confident the other party
::    is still reachable using this route.
::
::    TODO: more docs
::
+$  lane
  $%  [%if (expiring [port=@ud ipv4=@if])]
      [%is port=@ud lane=(unit lane) ipv6=@is]
      [%ix (expiring [port=@ud ipv4=@if])]
  ==
+$  symmetric-key       @uvI
+$  public-key          pass
+$  private-key         ring
+$  key-hash            @uvH
+$  signature           @
+$  message-descriptor  [=message-id encoding-num=@ num-fragments=@]
+$  message-id          [=bone =message-seq]
+$  message-seq         @ud
+$  fragment-num        @ud
+$  fragment-index      [=message-seq =fragment-num]
+$  packet-hash           @uvH
+$  error               [tag=@tas =tang]
+$  packet              [[to=ship from=ship] =encoding payload=@]
+$  encoding            ?(%none %open %fast %full)
::  +live-packet: data needed to track a packet in flight
::
::    Prepends :expiration-date and :sent-date to a +packet-descriptor.
::
+$  live-packet
  %-  expiring
  $:  sent-date=@da
      =packet-descriptor
  ==
::  +packet-descriptor: immutable data for an enqueued, possibly sent, packet
::
::    TODO: what is the virgin field?
::
+$  packet-descriptor
  $:  virgin=?
      =fragment-index
      =packet-hash
      payload=@
  ==
::  +pump-state: all data relevant to a per-ship |packet-pump
::
::    Note that while :live and :lost are structurally normal queues,
::    we actually treat them as bespoke priority queues.
::
+$  pump-state
  $:  live=(qeu live-packet)
      lost=(qeu packet-descriptor)
      =pump-statistics
  ==
::  +pump-statistics: congestion control information
::
::    TODO: document
::
+$  pump-statistics
  $:  $:  window-length=@ud
          max-packets-out=@ud
          retry-length=@ud
      ==
      $:  rtt=@dr
          last-sent=@da
          last-deadline=@da
  ==  ==
::  +meal: packet payload
::
+$  meal
  $%  ::  %back: acknowledgment
      ::
      ::    bone: opaque flow identifier
      ::    packet-hash: hash of acknowledged contents
      ::    error: non-null iff nack (negative acknowledgment)
      ::    wtf: TODO what is this
      ::
      [%back =bone =packet-hash error=(unit error) wtf=@dr]
      ::  %bond: full message
      ::
      ::    message-id: pair of flow id and message sequence number
      ::    remote-route: intended recipient module on receiving ship
      ::    message: noun payload
      ::
      [%bond =message-id remote-route=path message=*]
      ::  %carp: message fragment
      ::
      ::    message-descriptor: message id and fragment count
      ::    fragment-num: which fragment is being sent
      ::    message-fragment: one slice of a message's bytestream
      ::
      [%carp =message-descriptor fragment-num=@ message-fragment=@]
      ::  %fore: forwarded packet
      ::
      ::    ship: destination ship, to be forwarded to
      ::    lane: IP route, or null if unknown
      ::    payload: the wrapped packet, to be sent to :ship
      ::
      [%fore =ship lane=(unit lane) payload=@]
  ==
::  +pipe: (possibly) secure channel between our and her
::
::    Everything we need to encode or decode a message between our and her.
::    :her-sponsors is the list of her current sponsors, not numeric ancestors.
::
::    TODO: do we need the map of her public keys, or just her current key?
::
+$  pipe
  $:  fast-key=(unit [=key-hash key=(expiring =symmetric-key)])
      her-life=(unit life)
      her-public-keys=(map life public-key)
      her-sponsors=(list ship)
  ==
::  +deed: identity attestation, typically signed by sponsor
::
+$  deed  (attested [=life =public-key =signature])
::  +expiring: a value that expires at the specified date
::
+*  expiring  [value]  [expiration-date=@da value]
::  +attested: a value signed by :ship.oath to attest to its validity
::
+*  attested  [value]  [oath=[=ship =life =signature] value]
::
++  packet-format
  |%
  +$  none  raw-payload=@
  +$  open  [=from=life deed=(unit deed) signed-payload=@]
  +$  fast  [=key-hash encrypted-payload=@]
  +$  full  [[=to=life =from=life] deed=(unit deed) encrypted-payload=@]
  --
--
=<
::  vane interface core
::
|=  pit=vase
::
=|  ames-state
=*  state  -
|=  [our=ship now=@da eny=@uvJ scry-gate=sley]
=*  ames-gate  .
|%
::  +call: handle a +task:able:aloe request
::
++  call
  |=  $:  =duct
          type=*
          wrapped-task=(hobo task:able)
      ==
  ^-  [(list move) _ames-gate]
  ::  unwrap :task, coercing to valid type if needed
  ::
  =/  =task:able
    ?.  ?=(%soft -.wrapped-task)
      wrapped-task
    (task:able wrapped-task)
  ::
  =/  event-core  (per-event [our now eny scry-gate duct] state)
  ::
  =^  moves  state
    =<  abet
    ?-  -.task
      %wegh  wegh:event-core
      *      ~|  [%aloe-not-implemented -.task]  !!
    ==
  ::
  [moves ames-gate]
::  +load: migrate an old state to a new aloe version
::
++  load
  |=  old=*
  ^+  ames-gate
  ::
  ~|  %aloe-load-fail
  ames-gate(state (ames-state old))
::  +scry: handle scry request for internal state
::
++  scry
  |=  [fur=(unit (set monk)) ren=@tas why=shop syd=desk lot=coin tyl=path]
  ^-  (unit (unit cage))
  ::
  ~
::
++  stay  state
::  +take: receive response from another vane
::
++  take
  |=  [=wire =duct sign-type=type =sign:able]
  ^-  [(list move) _ames-gate]
  ::
  =/  event-core  (per-event [our now eny scry-gate duct] state)
  ::
  =^  moves  state
    =<  abet
    ?-  sign
      [%b %wake ~]  (wake:event-core wire)
      *             ~|  [%aloe-not-implemented -.sign]  !!
    ==
  ::
  [moves ames-gate]
--
::  implementation core
::
|%
++  per-event
  =|  moves=(list move)
  |=  [[our=ship now=@da eny=@ scry-gate=sley =duct] state=ames-state]
  |%
  +|  %entry-points
  ::  +wake: handle elapsed timer from behn
  ::
  ++  wake
    |=  =wire
    ^+  event-core
    !!
  ::  +wegh: report memory usage
  ::
  ++  wegh
    ^+  event-core
    %-  emit
    :^  duct  %give  %mass
    ^-  mass
    :+  %aloe  %|
    :~  dot+&+state
    ==
  ::
  +|  %utilities
  ::  +abet: finalize, producing [moves state] with moves in the right order
  ::
  ++  abet  [(flop moves) state]
  ::  +emit: enqueue an output move to be emitted at the end of the event
  ::
  ::    Prepends the move to :moves.event-core, which is reversed
  ::    at the end of an event.
  ::
  ++  emit  |=(=move event-core(moves [move moves]))
  ::
  ++  event-core  .
  --
::  |pump: packet pump state machine
::
++  pump
  =>  |%
      ::  +gift: packet pump effect; either %good logical ack, or %send packet
      ::
      ++  gift
        $%  [%good =packet-hash =fragment-index rtt=@dr error=(unit error)]
            [%send =packet-hash =fragment-index payload=@]
            ::  TODO [%wait @da] to set timer
        ==
      ::  +task: request to the packet pump
      ::
      ++  task
        $%  ::  %back: raw acknowledgment
            ::
            ::    packet-hash: the hash of the packet we're acknowledging
            ::    error: non-null if negative acknowledgment (nack)
            ::    lag: self-reported computation lag, to be factored out of RTT
            ::
            [%back =packet-hash error=(unit error) lag=@dr]
            ::  %cull: cancel message
            ::
            [%cull =message-seq]
            ::  %pack: enqueue packets for sending
            ::
            [%pack packets=(list packet-descriptor)]
            ::  %wake: timer expired
            ::
            ::    TODO: revisit after timer refactor
            ::
            [%wake ~]
        ==
      --
  |=  =pump-state
  =|  gifts=(list gift)
  |%
  ::  |entry-points: external interface to the |pump core
  ::
  +|  %entry-points
  ::  +work: handle +task request, producing effects and new +pump-state
  ::
  ++  work
    |=  [now=@da =task]
    ^+  [gifts pump-state]
    ::
    =<  abet
    ^+  pump-core
    ::
    ?-  -.task
      %back  (back now [packet-hash error lag]:task)
      %cull  (cull message-seq.task)
      %pack  (send-packets now packets.task)
      %wake  (wake now)
    ==
  ::  +next-wakeup: when should this core wake back up to do more processing?
  ::
  ::    Produces null if no wakeup needed.
  ::    TODO: call in +abet to produce a set-timer effect
  ::
  ++  next-wakeup
    ^-  (unit @da)
    =/  next-expiring-packet=(unit live-packet)  ~(top to live.pump-state)
    ?~  next-expiring-packet
      ~
    `expiration-date.u.next-expiring-packet
  ::  +window-slots: how many packets can be sent before window fills up?
  ::
  ::   Called externally to query window information.
  ::
  ++  window-slots
    ^-  @ud
    =,  pump-statistics.pump-state
    ::
    (sub-safe max-packets-out (add window-length retry-length))
  ::  %utilities: helper arms
  ::
  +|  %utilities
  ::  +back: process raw ack
  ::
  ::    TODO: better docs
  ::    TODO: verify queue invariants
  ::
  ++  back
    |=  [now=@da =packet-hash error=(unit error) lag=@dr]
    ^+  pump-core
    ::  post-process by adjusting timing information and losing packets
    ::
    =-  =.  live.pump-state  lov
        =.  pump-core  (lose ded)
        ::  rtt: roundtrip time, subtracting reported computation :lag
        ::
        =/  rtt=@dr
          ?~  ack  ~s0
          (sub-safe (sub now sent-date.u.ack) lag)
        ::
        (done ack packet-hash error rtt)
    ::  liv: iteratee starting as :live.pump-state
    ::
    =/  liv=(qeu live-packet)  live.pump-state
    ::  main loop
    ::
    |-  ^-  $:  ack=(unit live-packet)
                ded=(list live-packet)
                lov=(qeu live-packet)
            ==
    ?~  liv  [~ ~ ~]
    ::  ryt: result of searching the right (front) side of the queue
    ::
    =+  ryt=$(liv r.liv)
    ::  found in front; no need to search back
    ::
    ?^  ack.ryt  [ack.ryt ded.ryt liv(r lov.ryt)]
    ::  lose unacked packets sent before an acked virgin.
    ::
    ::    Uses head recursion to produce :ack, :ded, and :lov.
    ::
    =+  ^-  $:  top=?
                ack=(unit live-packet)
                ded=(list live-packet)
                lov=(qeu live-packet)
            ==
        ?:  =(packet-hash packet-hash.packet-descriptor.n.liv)
          [| `n.liv ~ l.liv]
        [& $(liv l.liv)]
    ::
    ?~  ack  [~ ~ liv]
    ::
    =*  virgin  virgin.packet-descriptor.u.ack
    ::
    =?  ded  top     [n.liv ded]
    =?  ded  virgin  (weld ~(tap to r.liv) ded)
    =?  lov  top     [n.liv lov ~]
    ::
    [ack ded lov]
  ::  +cancel-message: unqueue all packets from :message-seq
  ::
  ::    Clears all packets from a message from the :live and :lost queues.
  ::
  ::    TODO test
  ::
  ++  cull
    |=  =message-seq
    ^+  pump-core
    ::
    =.  live.pump-state
      =/  liv  live.pump-state
      |-  ^+  live.pump-state
      ?~  liv  ~
      ::  first recurse on left and right trees
      ::
      =/  vil  liv(l $(liv l.liv), r $(liv r.liv))
      ::  if the head of the tree is from the message to be deleted, cull it
      ::
      ?.  =(message-seq message-seq.fragment-index.packet-descriptor.n.liv)
        vil
      ~(nip to `(qeu live-packet)`vil)
    ::
    =.  lost.pump-state
      =/  lop  lost.pump-state
      |-  ^+  lost.pump-state
      ?~  lop  ~
      ::  first recurse on left and right trees
      ::
      =/  pol  lop(l $(lop l.lop), r $(lop r.lop))
      ::  if the head of the tree is from the message to be deleted, cull it
      ::
      ?.  =(message-seq message-seq.fragment-index.n.lop)
        pol
      ~(nip to `(qeu packet-descriptor)`pol)
    ::
    pump-core
  ::  +done: process a cooked ack; may emit a %good ack gift
  ::
  ++  done
    |=  $:  live-packet=(unit live-packet)
            =packet-hash
            error=(unit error)
            rtt=@dr
        ==
    ^+  pump-core
    ?~  live-packet
      pump-core
    ::
    =*  fragment-index  fragment-index.packet-descriptor.u.live-packet
    =.  pump-core  (give [%good packet-hash fragment-index rtt error])
    ::
    =.  window-length.pump-statistics.pump-state
      (dec window-length.pump-statistics.pump-state)
    ::
    pump-core
  ::  +enqueue-lost-packet: ordered enqueue into :lost.pump-state
  ::
  ::    The :lost queue isn't really a queue in case of
  ::    resent packets; packets from older messages
  ::    need to be sent first. Unfortunately hoon.hoon
  ::    lacks a general sorted/balanced heap right now.
  ::    so we implement a balanced queue insert by hand.
  ::
  ::    This queue is ordered by:
  ::      - message sequence number
  ::      - fragment number within the message
  ::      - packet-hash
  ::
  ::    TODO: why do we need the packet-hash tiebreaker?
  ::    TODO: write queue order function
  ::
  ++  enqueue-lost-packet
    ::
    |=  pac=packet-descriptor
    ^+  lost.pump-state
    ::
    =/  lop  lost.pump-state
    ::
    |-  ^+  lost.pump-state
    ?~  lop  [pac ~ ~]
    ::
    ?:  ?|  (older fragment-index.pac fragment-index.n.lop)
            ?&  =(fragment-index.pac fragment-index.n.lop)
                (lth packet-hash.pac packet-hash.n.lop)
        ==  ==
      lop(r $(lop r.lop))
    lop(l $(lop l.lop))
  ::  +fire-packet: emit a %send gift for a packet and do bookkeeping
  ::
  ++  fire-packet
    |=  [now=@da pac=packet-descriptor]
    ^+  pump-core
    ::  stats: read-only accessor for convenience
    ::
    =/  stats  pump-statistics.pump-state
    ::  sanity check: make sure we don't exceed the max packets in flight
    ::
    ?>  (lth [window-length max-packets-out]:stats)
    ::  reset :last-sent date to :now or incremented previous value
    ::
    =.  last-sent.pump-statistics.pump-state
      ?:  (gth now last-sent.stats)
        now
      +(last-sent.stats)
    ::  reset :last-deadline to twice roundtrip time from now, or increment
    ::
    =.  last-deadline.pump-statistics.pump-state
      =/  new-deadline=@da  (add now (mul 2 rtt.stats))
      ?:  (gth new-deadline last-deadline.stats)
        new-deadline
      +(last-deadline.stats)
    ::  increment our count of packets in flight
    ::
    =.  window-length.pump-statistics.pump-state
      +(window-length.pump-statistics.pump-state)
    ::  register the packet in the :live queue
    ::
    =.  live.pump-state
      %-  ~(put to live.pump-state)
      ^-  live-packet
      :+  last-deadline.pump-statistics.pump-state
        last-sent.pump-statistics.pump-state
      pac
    ::  emit the packet
    ::
    (give [%send packet-hash fragment-index payload]:pac)
  ::  +lose: abandon packets
  ::
  ++  lose
    |=  packets=(list live-packet)
    ^+  pump-core
    ?~  packets  pump-core
    ::
    =.  lost.pump-state  (enqueue-lost-packet packet-descriptor.i.packets)
    ::
    %=    $
        packets  t.packets
    ::
        window-length.pump-statistics.pump-state
      (dec window-length.pump-statistics.pump-state)
    ::
        retry-length.pump-statistics.pump-state
      +(retry-length.pump-statistics.pump-state)
    ==
  ::  +send-packets: send packets until window closes; sends from backlog first
  ::
  ++  send-packets
    |=  [now=@da packets=(list packet-descriptor)]
    ^+  pump-core
    ::  if our outgoing queue is full, no-op, dropping new packets
    ::
    ::    TODO: is it ok to just drop the supplied packets without enqueueing
    ::    them somewhere?
    ::
    ?:  (gte [window-length max-packets-out]:pump-statistics.pump-state)
      pump-core
    ::  if no packets to retry, start sending new packets
    ::
    ?:  =(0 retry-length.pump-statistics.pump-state)
      ?~  packets
        pump-core
      ::
      =.  pump-core  (fire-packet now i.packets)
      $(packets t.packets)
    ::  send a lost packet from our backlog
    ::
    =^  lost-packet  lost.pump-state  ~(get to lost.pump-state)
    =.  retry-length.pump-statistics.pump-state
      (dec retry-length.pump-statistics.pump-state)
    ::
    =.  pump-core  (fire-packet now lost-packet)
    $
  ::  +wake: handle elapsed timer
  ::
  ++  wake
    |=  now=@da
    ^+  pump-core
    ::
    =-  (lose(live.pump-state live.-) dead.-)
    ::
    ^-  [dead=(list live-packet) live=(qeu live-packet)]
    ::
    =|  dead=(list live-packet)
    =/  live=(qeu live-packet)  live.pump-state
    ::  binary search through :live for dead packets
    ::
    ::    The :live packet tree is sorted right-to-left by the packets'
    ::    lost-by deadlines. Packets with later deadlines are on the left.
    ::    Packets with earlier deadlines are on the right.
    ::
    ::    Start by examining the packet at the tree's root.
    ::
    ::      If the tree is empty (~):
    ::
    ::    We're done. Produce the empty tree and any dead packets we reaped.
    ::
    ::      If the root packet is dead:
    ::
    ::    Kill everything to its right, since all those packets have older
    ::    deadlines than the root and will also be dead. Then recurse on
    ::    the left node, since the top node might not have been the newest
    ::    packet that needs to die.
    ::
    ::      If the root packet is alive:
    ::
    ::    Recurse to the right, which will look for older packets
    ::    to be marked dead. Replace the right side of the :live tree with
    ::    the modified tree resulting from the recursion.
    ::
    |-  ^+  [dead=dead live=live]
    ?~  live  [dead ~]
    ::  if packet at root of queue is dead, everything to its right is too
    ::
    ?:  (gte now expiration-date.n.live)
      $(live l.live, dead (welp ~(tap to r.live) [n.live dead]))
    ::  otherwise, replace right side of tree with recursion result
    ::
    =/  right-result  $(live r.live)
    [dead.right-result live(r live.right-result)]
  ::  +abet: finalize core, reversing effects
  ::
  ++  abet  [(flop gifts) pump-state]
  ::  +give: emit effect, prepended to :gifts to be reversed before emission
  ::
  ++  give  |=(=gift pump-core(gifts [gift gifts]))
  ++  pump-core  .
  --
::  +encode-meal: generate a message and packets from a +meal, with effects
::
++  encode-meal
  =>  |%
      ::  +gift: side effect
      ::
      +$  gift
        $%  ::  %line: set symmetric key
            ::
            ::    Connections start as %full, which uses asymmetric encryption.
            ::    This core can produce an upgrade to a shared symmetric key,
            ::    which is must faster; hence the %fast tag on that encryption.
            ::
            [%symmetric-key symmetric-key=(expiring symmetric-key)]
        ==
      --
  ::  outer gate: establish pki context, producing inner gate
  ::
  |=  [our=ship =our=life crypto-core=acru:ames her=ship =pipe]
  ::  inner gate: process a meal, producing side effects and packets
  ::
  |=  [now=@da eny=@ =meal]
  ::
  |^  ^-  [gifts=(list gift) fragments=(list @)]
      ::
      =+  ^-  [gifts=(list gift) =encoding message=@]  generate-message
      ::
      [gifts (generate-fragments encoding message)]
  ::  +generate-fragments: split a message into packets
  ::
  ++  generate-fragments
    |=  [=encoding message=@]
    ^-  (list @)
    ::  total-packets: number of packets for message
    ::
    ::    Each packet has max 2^13 bits so it fits in the MTU on most systems.
    ::
    =/  total-fragments=@ud  (met 13 message)
    ::  if message fits in one packet, don't fragment
    ::
    ?:  =(1 total-fragments)
      [(encode-packet [our her] encoding message) ~]
    ::  fragments: fragments generated from splitting message
    ::
    =/  fragments=(list @)  (rip 13 message)
    =/  fragment-index=@ud  0
    ::  wrap each fragment in a %none encoding of a %carp meal
    ::
    |-  ^-  (list @)
    ?~  fragments  ~
    ::
    :-  ^-  @
        %^  encode-packet  [our her]  %none
        %-  jam
        ^-  ^meal
        :+  %carp
          ^-  message-descriptor
          [(get-message-id meal) (encoding-to-number encoding) total-fragments]
        [fragment-index i.fragments]
    ::
    $(fragments t.fragments, fragment-index +(fragment-index))
  ::  +generate-message: generate message from meal
  ::
  ++  generate-message
    ^-  [gifts=(list gift) =encoding payload=@]
    ::  if :meal is just a single fragment, don't bother double-encrypting it
    ::
    ?:  =(%carp -.meal)
      [gifts=~ encoding=%none payload=(jam meal)]
    ::  if this channel has a symmetric key, use it to encrypt
    ::
    ?^  fast-key.pipe
      :-  ~
      :-  %fast
      %^  cat  7
        key-hash.u.fast-key.pipe
      (en:crub:crypto symmetric-key.key.u.fast-key.pipe (jam meal))
    ::  if we don't know their life, just sign this packet without encryption
    ::
    ?~  her-life.pipe
      :-  ~
      :-  %open
      %^    jam
          our-life
        deed=~
      (sign:as:crypto-core (jam meal))
    ::  asymmetric encrypt; also produce symmetric key gift for upgrade
    ::
    ::    Generate a new symmetric key by hashing entropy, the date,
    ::    and an insecure hash of :meal. We might want to change this to use
    ::    a key derived using Diffie-Hellman.
    ::
    =/  new-symmetric-key=symmetric-key  (shaz :(mix (mug meal) now eny))
    ::  expire the key in one month
    ::  TODO: when should the key expire?
    ::
    :-  [%symmetric-key `@da`(add now ~m1) new-symmetric-key]~
    :-  %full
    %-  jam
    ::
    ^-  full:packet-format
    ::  TODO: send our deed if we're a moon or comet
    ::
    :+  [to=u.her-life.pipe from=our-life]  deed=~
    ::  encrypt the pair of [new-symmetric-key (jammed-meal)] for her eyes only
    ::
    ::    This sends the new symmetric key by piggy-backing it onto the
    ::    original message.
    ::
    %+  seal:as:crypto-core
      (~(got by her-public-keys.pipe) u.her-life.pipe)
    (jam [new-symmetric-key (jam meal)])
  --
::  +interpret-packet: authenticate and decrypt a packet, effectfully
::
++  interpret-packet
  =>  |%
      +$  gift
        $%  [%symmetric-key =symmetric-key]
            [%meet =ship =life =public-key]
        ==
      --
  ::  outer gate: establish context
  ::
  ::    her:             ship that sent us the message
  ::    our-private-key: our private key at current life
  ::    pipe:            channel between our and her
  ::
  |=  $:  her=ship
          crypto-core=acru:ames
          =pipe
      ==
  ::  inner gate: decode a packet
  ::
  |=  [=encoding buffer=@]
  ^-  [gifts=(list gift) authenticated=? =meal]
  ::
  =|  gifts=(list gift)
  ::
  |^  ?-  encoding
        %none  decode-none
        %open  decode-open
        %fast  decode-fast
        %full  decode-full
      ==
  ::  +decode-none: decode an unsigned, unencrypted packet
  ::
  ++  decode-none
    ^-  [gifts=(list gift) authenticated=? =meal]
    ::
    (produce-meal authenticated=%.n buffer)
  ::  +decode-open: decode a signed, unencrypted packet
  ::
  ++  decode-open
    ^-  [gifts=(list gift) authenticated=? =meal]
    ::
    =/  packet-noun  (cue buffer)
    =/  open-packet  (open:packet-format packet-noun)
    ::
    =?    decoder-core
        ?=(^ deed.open-packet)
      (apply-deed u.deed.open-packet)
    ::  TODO: is this assertion at all correct?
    ::  TODO: make sure the deed gets applied to the pipe if needed
    ::
    ?>  =((need her-life.pipe) from-life.open-packet)
    ::
    =/  her-public-key  (~(got by her-public-keys.pipe) (need her-life.pipe))
    ::
    %+  produce-meal  authenticated=%.y
    %-  need
    (extract-signed her-public-key signed-payload.open-packet)
  ::  +decode-fast: decode a packet with symmetric encryption
  ::
  ++  decode-fast
    ^-  [gifts=(list gift) authenticated=? =meal]
    ::
    ?~  fast-key.pipe
      ~|  %ames-no-fast-key^her  !!
    ::
    =/  key-hash=@   (end 7 1 buffer)
    =/  payload=@    (rsh 7 1 buffer)
    ::
    ~|  [%ames-bad-fast-key `@ux`key-hash `@ux`key-hash.u.fast-key.pipe]
    ?>  =(key-hash key-hash.u.fast-key.pipe)
    ::
    %+  produce-meal  authenticated=%.y
    %-  need
    (de:crub:crypto symmetric-key.key.u.fast-key.pipe payload)
  ::  +decode-full: decode a packet with asymmetric encryption
  ::
  ++  decode-full
    ^-  [gifts=(list gift) authenticated=? =meal]
    ::
    =/  packet-noun  (cue buffer)
    =/  full-packet  (full:packet-format packet-noun)
    ::
    =?    decoder-core
        ?=(^ deed.full-packet)
      (apply-deed u.deed.full-packet)
    ::  TODO: is this assertion valid if we hear a new deed?
    ::
    ~|  [%ames-life-mismatch her her-life.pipe from-life.full-packet]
    ?>  =((need her-life.pipe) from-life.full-packet)
    ::
    =/  her-public-key  (~(got by her-public-keys.pipe) (need her-life.pipe))
    =/  jammed-wrapped=@
      %-  need
      (tear:as:crypto-core her-public-key encrypted-payload.full-packet)
    ::
    =+  %-  ,[=symmetric-key jammed-message=@]
        (cue jammed-wrapped)
    ::
    =.  decoder-core  (give %symmetric-key symmetric-key)
    =.  decoder-core  (give %meet her (need her-life.pipe) her-public-key)
    ::
    (produce-meal authenticated=%.y jammed-message)
  ::  +apply-deed: produce a %meet gift if the deed checks out
  ::
  ++  apply-deed
    |=  =deed
    ^+  decoder-core
    ::
    =+  [expiration-date life public-key signature]=deed
    ::  if we already know the public key for this life, noop
    ::
    ?:  =(`public-key (~(get by her-public-keys.pipe) life))
      decoder-core
    ::  TODO: what if the deed verifies at the same fife for :her?
    ::
    ?>  (verify-deed deed)
    ::
    (give %meet her life public-key)
  ::  +verify-deed: produce %.y iff deed is valid
  ::
  ::    TODO: actually implement; this is just a stub
  ::
  ++  verify-deed
    |=  =deed
    ^-  ?
    ::  if :her is anything other than a moon or comet, the deed is invalid
    ::
    ?+    (clan:title her)  %.n
        ::  %earl: :her is a moon, with deed signed by numeric parent
        ::
        %earl
      ~|  %ames-moons-not-implemented  !!
    ::
        ::  %pawn: comet, self-signed, life 1, address is fingerprint
        ::
        %pawn
      ~|  %ames-comets-not-implemented  !!
    ==
  ::  +give: emit +gift effect, to be flopped later
  ::
  ++  give  |=(=gift decoder-core(gifts [gift gifts]))
  ::  +produce-meal: exit this core with a +meal +cue'd from :meal-precursor
  ::
  ++  produce-meal
    |=  [authenticated=? meal-precursor=@]
    ^-  [gifts=(list gift) authenticated=? =meal]
    ::
    :+  (flop gifts)  authenticated
    %-  meal
    (cue meal-precursor)
  ::
  ++  decoder-core  .
  --
::  +decode-packet: deserialize a packet from a bytestream, reading the header
::
++  decode-packet
  |=  buffer=@uvO
  ^-  packet
  ::  first 32 (2^5) bits are header; the rest is body
  ::
  =/  header  (end 5 1 buffer)
  =/  body    (rsh 5 1 buffer)
  ::
  =/  version           (end 0 3 header)
  =/  checksum          (cut 0 [3 20] header)
  =/  receiver-width    (decode-ship-type (cut 0 [23 2] header))
  =/  sender-width      (decode-ship-type (cut 0 [25 2] header))
  =/  message-encoding  (number-to-encoding (cut 0 [27 5] header))
  ::
  ?>  =(protocol-version version)
  ?>  =(checksum (end 0 20 (mug body)))
  ::
  :+  :-  to=(end 3 receiver-width body)
      from=(cut 3 [receiver-width sender-width] body)
    encoding=message-encoding
  payload=(rsh 3 (add receiver-width sender-width) body)
::  +encode-packet: serialize a packet into a bytestream
::
++  encode-packet
  |=  =packet
  ^-  @uvO
  ::
  =/  receiver-type   (encode-ship-type to.packet)
  =/  receiver-width  (bex +(receiver-type))
  ::
  =/  sender-type   (encode-ship-type from.packet)
  =/  sender-width  (bex +(sender-type))
  ::  body: <<receiver sender payload>>
  ::
  =/  body
    ;:  mix
      to.packet
      (lsh 3 receiver-width from.packet)
      (lsh 3 (add receiver-width sender-width) payload.packet)
    ==
  ::
  =/  encoding-number  (encoding-to-number encoding.packet)
  ::  header: 32-bit header assembled from bitstreams of fields
  ::
  ::    <<protocol-version checksum receiver-type sender-type encoding>>
  ::
  =/  header
    %+  can  0
    :~  [3 protocol-version]
        [20 (mug body)]
        [2 receiver-type]
        [2 sender-type]
        [5 encoding-number]
    ==
  ::  result is <<header body>>
  ::
  (mix header (lsh 5 1 body))
::  +decode-ship-type: decode a 2-bit ship type specifier into a byte width
::
::    Type 0: galaxy or star -- 2 bytes
::    Type 1: planet         -- 4 bytes
::    Type 2: moon           -- 8 bytes
::    Type 3: comet          -- 16 bytes
::
++  decode-ship-type
  |=  ship-type=@
  ^-  @
  ::
  ?+  ship-type  ~|  %invalid-ship-type  !!
    %0  2
    %1  4
    %2  8
    %3  16
  ==
::  +encode-ship-type: produce a 2-bit number representing :ship's address type
::
::    0: galaxy or star
::    1: planet
::    2: moon
::    3: comet
::
++  encode-ship-type
  |=  =ship
  ^-  @
  ::
  =/  bytes  (met 3 ship)
  ::
  ?:  (lte bytes 2)  0
  ?:  (lte bytes 4)  1
  ?:  (lte bytes 8)  2
  3
::  +number-to-encoding: read a number off the wire into an encoding type
::
++  number-to-encoding
  |=  number=@
  ^-  encoding
  ?+  number  ~|  %invalid-encoding  !!
    %0  %none
    %1  %open
    %2  %fast
    %3  %full
  ==
::  +encoding-to-number: convert encoding to wire-compatible enumeration
::
++  encoding-to-number
  |=  =encoding
  ^-  @
  ::
  ?-  encoding
    %none  0
    %open  1
    %fast  2
    %full  3
  ==
::  +get-message-id: extract message-id from a +meal, or default to initial value
::
++  get-message-id
  |=  =meal
  ^-  message-id
  ?+  -.meal  [0 0]
    %bond  message-id.meal
    %carp  message-id.message-descriptor.meal
  ==
::  +extract-signed: if valid signature, produce extracted value; else produce ~
::
++  extract-signed
  |=  [=public-key signed-buffer=@]
  ^-  (unit @)
  ::
  (sure:as:(com:nu:crub:crypto public-key) signed-buffer)
::  +older: is fragment-index :a older than fragment-index :b?
::
++  older
  |=  [a=fragment-index b=fragment-index]
  ^-  ?
  ?:  (lth message-seq.a message-seq.b)
    %.y
  ::
  ?&  =(message-seq.a message-seq.b)
      (lth fragment-num.a fragment-num.b)
  ==
::  +sub-safe: subtract :b from :a unless :a is bigger, in which case produce 0
::
++  sub-safe
  |=  [a=@ b=@]
  ^-  @
  ?:  (lth a b)
    0
  (sub a b)
--
