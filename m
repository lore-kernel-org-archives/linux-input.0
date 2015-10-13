From: "Zooko Wilcox-O'Hearn" <zookog@gmail.com>
Subject: Re: Chromebook Pixel 1 atmel_mxt_ts doesn't work
Date: Tue, 13 Oct 2015 19:59:17 +0000
Message-ID: <CANdZDc7WGtg6rzbNOozH-Q-qEw8PWdd_E738oe=Vt=Fctk7JWQ@mail.gmail.com>
References: <CANdZDc4sHV5D6a8TsuSJ5hbecXP4SokmLp8E9KkD92pmMu7OTg@mail.gmail.com>
	<CAKdAkRTSUfVraTGkm6AwwxG_A1g4XJBdk4Xfmd7HP+MGrNhDKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:35191 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbbJMT7R (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Oct 2015 15:59:17 -0400
Received: by iofl186 with SMTP id l186so33473573iof.2
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2015 12:59:17 -0700 (PDT)
In-Reply-To: <CAKdAkRTSUfVraTGkm6AwwxG_A1g4XJBdk4Xfmd7HP+MGrNhDKA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Nick Dyer <nick.dyer@itdev.co.uk>

This is the complete output of running evtest and choosing option 10,
from the console (while X is running, but I'm not running evtest under
X).

zooko@spark ~ $ sudo evtest
No device specified, trying to scan all of /dev/input/event*
Available devices:
/dev/input/event0:      Lid Switch
/dev/input/event1:      Power Button
/dev/input/event2:      Sleep Button
/dev/input/event3:      Sleep Button
/dev/input/event4:      Power Button
/dev/input/event5:      AT Translated Set 2 keyboard
/dev/input/event6:      Chromebook HD WebCam
/dev/input/event7:      Video Bus
/dev/input/event8:      Logitech M325
/dev/input/event9:      Atmel maXTouch Touchscreen
/dev/input/event10:     Atmel maXTouch Touchpad
Select the device event number [0-10]: 10
Input driver version is 1.0.1
Input device ID: bus 0x18 vendor 0x0 product 0x0 version 0x0
Input device name: "Atmel maXTouch Touchpad"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 272 (BTN_LEFT)
    Event code 325 (BTN_TOOL_FINGER)
    Event code 328 (BTN_TOOL_QUINTTAP)
    Event code 330 (BTN_TOUCH)
    Event code 333 (BTN_TOOL_DOUBLETAP)
    Event code 334 (BTN_TOOL_TRIPLETAP)
    Event code 335 (BTN_TOOL_QUADTAP)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value      0
      Min        0
      Max     2039
      Resolution      20
    Event code 1 (ABS_Y)
      Value      0
      Min        0
      Max     1359
      Resolution      20
    Event code 24 (ABS_PRESSURE)
      Value      0
      Min        0
      Max      255
    Event code 47 (ABS_MT_SLOT)
      Value      0
      Min        0
      Max        9
    Event code 48 (ABS_MT_TOUCH_MAJOR)
      Value      0
      Min        0
      Max      255
    Event code 53 (ABS_MT_POSITION_X)
      Value      0
      Min        0
      Max     2039
      Resolution      20
    Event code 54 (ABS_MT_POSITION_Y)
      Value      0
      Min        0
      Max     1359
      Resolution      20
    Event code 57 (ABS_MT_TRACKING_ID)
      Value      0
      Min        0
      Max    65535
    Event code 58 (ABS_MT_PRESSURE)
      Value      0
      Min        0
      Max      255
Properties:
  Property type 0 (INPUT_PROP_POINTER)
  Property type 2 (INPUT_PROP_BUTTONPAD)
Testing ... (interrupt to exit)
