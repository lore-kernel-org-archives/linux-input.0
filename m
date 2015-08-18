From: Nick Bowler <nbowler@draconx.ca>
Subject: PROBLEM: Missing events on thinkpad trackpoint buttons
Date: Mon, 17 Aug 2015 22:31:01 -0400
Message-ID: <CAN_QmVxOaqyZ8fJ29Jtjkb8YnckjQ=q53igOcQuAFmrQG7hiZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yk0-f193.google.com ([209.85.160.193]:36841 "EHLO
	mail-yk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbbHRCbC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Aug 2015 22:31:02 -0400
Received: by ykas134 with SMTP id s134so5532314yka.3
        for <linux-input@vger.kernel.org>; Mon, 17 Aug 2015 19:31:01 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I'm not sure if this is actually a Linux issue but figured I'd at least
report it here to start...

I have a Lenovo Thinkpad X250, with the newfangled trackpoint buttons.
I have a problem with missing button press or release events: sometimes
pressing a button has no effect, and sometimes releasing a button has no
effect (the latter is especially annoying, as the button remains depressed
as far as any applications are concerned).

After some testing, the problem apparently depends on the position of my
hands over the touchpad.  I can reliably reproduce it as follows: place
two fingers on the touchpad, then press the button repeatedly.  Watching
with evtest, several events (could be either press or release) will
simply be missin, although the kernel never does anything weird like
send two release events in a row.  There are no problems if there are
0 or 1 fingers on the touchpad.

My current kernel version is 4.1.6, although the problem occurs in all
versions that I tried.

Here is the evtest result from placing two fingers on the touchpad, then
pressing the left trackpoint button 10 times, counting 1 second between
each press.  As you can see, only 3 presses and 3 release events total
were sent by the kernel, sometimes with many physical button presses
between the press and its corresponding release:

  Input driver version is 1.0.1
  Input device ID: bus 0x11 vendor 0x2 product 0xa version 0x0
  Input device name: "TPPS/2 IBM TrackPoint"
  Supported events:
    Event type 0 (EV_SYN)
    Event type 1 (EV_KEY)
      Event code 272 (BTN_LEFT)
      Event code 273 (BTN_RIGHT)
      Event code 274 (BTN_MIDDLE)
    Event type 2 (EV_REL)
      Event code 0 (REL_X)
      Event code 1 (REL_Y)
  Properties:
    Property type 0 (INPUT_PROP_POINTER)
    Property type 5 (?)
  Testing ... (interrupt to exit)
  Event: time 1439863173.241278, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863173.241278, -------------- SYN_REPORT ------------
  Event: time 1439863180.610511, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863180.610511, -------------- SYN_REPORT ------------
  Event: time 1439863182.162257, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863182.162257, -------------- SYN_REPORT ------------
  Event: time 1439863185.749212, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863185.749212, -------------- SYN_REPORT ------------
  Event: time 1439863187.145478, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863187.145478, -------------- SYN_REPORT ------------
  Event: time 1439863189.162652, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863189.162652, -------------- SYN_REPORT ------------

For reference: the same test was repeated with only one finger on the
touchpad; all events are delivered properly in this case:

  Input driver version is 1.0.1
  Input device ID: bus 0x11 vendor 0x2 product 0xa version 0x0
  Input device name: "TPPS/2 IBM TrackPoint"
  Supported events:
    Event type 0 (EV_SYN)
    Event type 1 (EV_KEY)
      Event code 272 (BTN_LEFT)
      Event code 273 (BTN_RIGHT)
      Event code 274 (BTN_MIDDLE)
    Event type 2 (EV_REL)
      Event code 0 (REL_X)
      Event code 1 (REL_Y)
  Properties:
    Property type 0 (INPUT_PROP_POINTER)
    Property type 5 (?)
  Testing ... (interrupt to exit)
  Event: time 1439863147.840979, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863147.840979, -------------- SYN_REPORT ------------
  Event: time 1439863147.919313, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863147.919313, -------------- SYN_REPORT ------------
  Event: time 1439863149.198783, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863149.198783, -------------- SYN_REPORT ------------
  Event: time 1439863149.285873, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863149.285873, -------------- SYN_REPORT ------------
  Event: time 1439863150.673035, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863150.673035, -------------- SYN_REPORT ------------
  Event: time 1439863150.780064, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863150.780064, -------------- SYN_REPORT ------------
  Event: time 1439863152.204741, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863152.204741, -------------- SYN_REPORT ------------
  Event: time 1439863152.321820, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863152.321820, -------------- SYN_REPORT ------------
  Event: time 1439863153.698388, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863153.698388, -------------- SYN_REPORT ------------
  Event: time 1439863153.834195, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863153.834195, -------------- SYN_REPORT ------------
  Event: time 1439863155.181776, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863155.181776, -------------- SYN_REPORT ------------
  Event: time 1439863155.308142, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863155.308142, -------------- SYN_REPORT ------------
  Event: time 1439863156.723367, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863156.723367, -------------- SYN_REPORT ------------
  Event: time 1439863156.849475, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863156.849475, -------------- SYN_REPORT ------------
  Event: time 1439863158.294692, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863158.294692, -------------- SYN_REPORT ------------
  Event: time 1439863158.419989, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863158.419989, -------------- SYN_REPORT ------------
  Event: time 1439863159.846138, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863159.846138, -------------- SYN_REPORT ------------
  Event: time 1439863159.962375, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863159.962375, -------------- SYN_REPORT ------------
  Event: time 1439863161.591024, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
  Event: time 1439863161.591024, -------------- SYN_REPORT ------------
  Event: time 1439863161.688792, type 1 (EV_KEY), code 272 (BTN_LEFT), value 0
  Event: time 1439863161.688792, -------------- SYN_REPORT ------------

Any thoughts?

Thanks,
  Nick
