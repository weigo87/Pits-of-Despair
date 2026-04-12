BEGIN ZBNEPHP

// Kickout Dialogue
IF ~Global("ZB_NEPH_JOINS","GLOBAL",1) Global("ZB_NEPH_LEFT","GLOBAL",0)~ ZBNEPHKICKOUT
  SAY @116 /* You wish to part ways? */
  IF ~~ THEN REPLY @117 /* Indeed, we can’t travel on as we have for now. Go to the Copper Coronet so I know where to find you if I need you once more. */ DO ~
    SetGlobal("ZB_NEPH_MOVE_COPPER","GLOBAL",1)
    SetGlobal("ZB_NEPH_ESCAPE_1","GLOBAL",4)
    SetGlobal("ZB_NEPH_LEFT","GLOBAL",1)
    StartCutSceneMode()
    StartCutScene("zbnephm")~ EXIT
  IF ~Global("ShadowWork","GLOBAL",1)~ THEN REPLY @370 /* For now, yes. Head to the Shadow Thief guild in the docks. I’ll meet you there should I require your help again. */ DO ~
    SetGlobal("ZB_NEPH_MOVE_SHADOW_THIEF","GLOBAL",1)
    SetGlobal("ZB_NEPH_ESCAPE_1","GLOBAL",4)
    SetGlobal("ZB_NEPH_LEFT","GLOBAL",1)
    StartCutSceneMode()
    StartCutScene("zbnephmt")~ EXIT
  IF ~~ THEN REPLY @118 /* I don't know what I was thinking, of course I want you to stay. */ EXIT
END

// Rejoin
IF ~Global("ZB_NEPH_JOINS","GLOBAL",1) Global("ZB_NEPH_LEFT","GLOBAL",1)~ ZBNEPHREJOIN
  SAY @119 /* So, the prodigal Bhaalspawn returns. I assume that you’ve changed your mind and wish to continue our journey together? */
  IF ~~ THEN REPLY @120 /* Yes, please join us. */ DO ~SetGlobal("ZB_NEPH_LEFT","GLOBAL",0)~ GOTO ZBNEPHJOIND
  IF ~~ THEN REPLY @121 /* Not right now. We will contact you if we have a need for you. */ EXIT
END

// Join
IF ~~ ZBNEPHJOIND
  SAY @122 /* Good! I’d be surprised if you thought my talents truly were of no use to you. Let’s get going. */
  IF ~~ DO ~SetGlobal("ZB_NEPH_LEFT","GLOBAL",0) MakeGlobal() JoinParty()~ EXIT
END

// TODO: Trigger this due to ?
// Leave Due to Reputation
IF ~False()~ ZBNEPHLEAVEICANTSTANDSIGHTOFYOU
  SAY @371 /* I can’t stand the sight of you, <CHARNAME>. I hope we never meet again. */
  IF ~~ DO ~
    SetGlobal("ZB_NEPH_REP_LEFT","GLOBAL",1)
    SetGlobal("ZB_NEPH_LEFT","GLOBAL",1)
    StartCutSceneMode()
    StartCutScene("zbnephm")~ EXIT
END
