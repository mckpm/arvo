/-  eggtimer
=,  eggtimer
!:
|%
  +$  move  [bone card]
  +$  card  [%wait wire @da]
--
|_  [bowl:gall alarm-time=(unit @da) message=tape]
++  this  .
++  poke-eggtimer-command
  |=  cmd=command  ^-  (quip move _this)
  ?-  -.cmd
    %check  (check-status)
    %set  (set-alarm +.cmd)
  ==
++  check-status
  |=  *
  =/  msg=tape  ?~  alarm-time
    "alarm not set"
  %+  weld
    "alarm set for {(scow %da (need alarm-time))}: "
  message
  ~&  msg
  [~ this]
++  set-alarm
  |=  [dur=duration msg=tape]
  ?~  dur
    [~ this(alarm-time ~)]
  =/  future=@da  (add now dur)
  ~&  "setting alarm for {(scow %dr dur)} from now"
  :_  %=  this
    alarm-time  `future
    message  msg
  ==
  :_  ~
  [ost %wait /(scot %da now) future]
++  wake
  |=  [wir=wire error=(unit tang)]  ^-  (quip move _this)
  ~&  message
  [~ this(alarm-time ~)]
--
