From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 2/3] Input: ALPS - Add code to support "Rushmore" touchpads
Date: Mon, 06 May 2013 21:34:51 +0200
Message-ID: <87mws76gx0.fsf@dell.be.48ers.dk>
References: <10bf6ea5c8f86eca66cd39498ca38d58@localhost>
	<092b691c8e994d31cb235fd7c45afee4@localhost>
	<87zjzwqhxi.fsf@dell.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f177.google.com ([74.125.82.177]:45041 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755631Ab3EFTe4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 15:34:56 -0400
Received: by mail-we0-f177.google.com with SMTP id u3so3211009wey.36
        for <linux-input@vger.kernel.org>; Mon, 06 May 2013 12:34:54 -0700 (PDT)
In-Reply-To: <87zjzwqhxi.fsf@dell.be.48ers.dk> (Peter Korsgaard's message of
	"Sat, 26 Jan 2013 12:53:29 +0100")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: dmitry.torokhov@gmail.com, seth.forshee@canonical.com, linux-input@vger.kernel.org

>>>>> "Peter" == Peter Korsgaard <jacmet@sunsite.dk> writes:

Hi,

Old thread, but I only now got time to upgrade to 3.9 and retest.

 Peter> Thanks. I've tested it here on a e6230 (bios rev 08), and it gets
 Peter> correctly detected

 Peter> But the input events seem very noisy (E.G. the cursor jumps up and down
 Peter> if I keep my finger pressed on the touchpad). Especially the Y
 Peter> coordinate seems unstable:

 Peter> Event: time 1359201123.864208, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1042
 Peter> Event: time 1359201123.864208, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 669
 Peter> Event: time 1359201123.864208, type 3 (EV_ABS), code 0 (ABS_X), value 1042
 Peter> Event: time 1359201123.864208, type 3 (EV_ABS), code 1 (ABS_Y), value 669
 Peter> Event: time 1359201123.864208, -------------- SYN_REPORT ------------
 Peter> Event: time 1359201123.874130, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1043
 Peter> Event: time 1359201123.874130, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 659
 Peter> Event: time 1359201123.874130, type 3 (EV_ABS), code 0 (ABS_X), value 1043
 Peter> Event: time 1359201123.874130, type 3 (EV_ABS), code 1 (ABS_Y), value 659
 Peter> Event: time 1359201123.874130, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 32
 Peter> Event: time 1359201123.874130, -------------- SYN_REPORT ------------

I still see this noisy output with 3.9:

sudo evtest /dev/input/event16                                         ~
Input driver version is 1.0.1
Input device ID: bus 0x11 vendor 0x2 product 0x8 version 0x300
Input device name: "AlpsPS/2 ALPS GlidePoint"
Supported events:
  Event type 0 (EV_SYN)
  Event type 1 (EV_KEY)
    Event code 272 (BTN_LEFT)
    Event code 273 (BTN_RIGHT)
    Event code 274 (BTN_MIDDLE)
    Event code 325 (BTN_TOOL_FINGER)
    Event code 330 (BTN_TOUCH)
    Event code 333 (BTN_TOOL_DOUBLETAP)
    Event code 334 (BTN_TOOL_TRIPLETAP)
    Event code 335 (BTN_TOOL_QUADTAP)
  Event type 3 (EV_ABS)
    Event code 0 (ABS_X)
      Value    363
      Min        0
      Max     2000
    Event code 1 (ABS_Y)
      Value    295
      Min        0
      Max     1400
    Event code 24 (ABS_PRESSURE)
      Value      0
      Min        0
      Max      127
    Event code 47 (ABS_MT_SLOT)
      Value      0
      Min        0
      Max        1
    Event code 53 (ABS_MT_POSITION_X)
      Value      0
      Min        0
      Max     2000
    Event code 54 (ABS_MT_POSITION_Y)
      Value      0
      Min        0
      Max     1400
    Event code 57 (ABS_MT_TRACKING_ID)
      Value      0
      Min        0
      Max    65535
Properties:
  Property type 3 (INPUT_PROP_SEMI_MT)
Testing ... (interrupt to exit)

Event: time 1367868378.646499, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1147
Event: time 1367868378.646499, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 855
Event: time 1367868378.646499, type 3 (EV_ABS), code 0 (ABS_X), value 1147
Event: time 1367868378.646499, type 3 (EV_ABS), code 1 (ABS_Y), value 855
Event: time 1367868378.646499, -------------- SYN_REPORT ------------
Event: time 1367868378.656671, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1145
Event: time 1367868378.656671, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 858
Event: time 1367868378.656671, type 3 (EV_ABS), code 0 (ABS_X), value 1145
Event: time 1367868378.656671, type 3 (EV_ABS), code 1 (ABS_Y), value 858
Event: time 1367868378.656671, -------------- SYN_REPORT ------------
Event: time 1367868378.667997, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1144
Event: time 1367868378.667997, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 853
Event: time 1367868378.667997, type 3 (EV_ABS), code 0 (ABS_X), value 1144
Event: time 1367868378.667997, type 3 (EV_ABS), code 1 (ABS_Y), value 853
Event: time 1367868378.667997, -------------- SYN_REPORT ------------
Event: time 1367868378.677139, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1142
Event: time 1367868378.677139, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 851
Event: time 1367868378.677139, type 3 (EV_ABS), code 0 (ABS_X), value 1142
Event: time 1367868378.677139, type 3 (EV_ABS), code 1 (ABS_Y), value 851
Event: time 1367868378.677139, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 33
Event: time 1367868378.677139, -------------- SYN_REPORT ------------
Event: time 1367868378.687460, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1140
Event: time 1367868378.687460, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 849
Event: time 1367868378.687460, type 3 (EV_ABS), code 0 (ABS_X), value 1140
Event: time 1367868378.687460, type 3 (EV_ABS), code 1 (ABS_Y), value 849
Event: time 1367868378.687460, -------------- SYN_REPORT ------------
Event: time 1367868378.697723, type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 1138
Event: time 1367868378.697723, type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 843
Event: time 1367868378.697723, type 3 (EV_ABS), code 0 (ABS_X), value 1138
Event: time 1367868378.697723, type 3 (EV_ABS), code 1 (ABS_Y), value 843
Event: time 1367868378.697723, type 3 (EV_ABS), code 24 (ABS_PRESSURE), value 32

This is with a single finger stadily on the touchpad. X/Y/Z all seem to
move a bit around.

I added a few debug printks to alps.c and see that it correctly gets
detected as a rushmore/v3:

ALPS touchpad: E7=73 03 0a, EC=88 08 1d
alps_identify detected proto 3

This is the data sequence it generates:

alps decode af 46 2c 08 35 1b
alps decode 9f 46 2c 08 31 1b
alps decode 8f 46 2c 08 33 1b
alps decode 8f 46 2c 08 32 1b
alps decode 8f 46 2c 08 32 1b
alps decode bf 46 2c 08 25 1b
alps decode 9f 46 2c 08 32 1b
alps decode bf 46 2c 08 26 1b
alps decode 8f 46 2c 08 31 1b
alps decode 8f 46 2c 08 38 1b
alps decode 8f 46 2c 08 32 1c
alps decode 9f 46 2c 08 31 1c
alps decode bf 46 2c 08 30 1c
alps decode af 46 2c 08 36 1b
alps decode af 46 2c 08 35 1b
alps decode 9f 46 2c 08 35 1b
alps decode bf 46 2c 08 29 1b
alps decode 8f 46 2c 08 31 1c
alps decode 9f 46 2b 08 3e 1b
alps decode 9f 46 2c 08 38 1b
alps decode 9f 46 2c 08 32 1b
alps decode 9f 46 2c 08 35 1c
alps decode af 46 2c 08 37 1b

Is this expected behaviour? From a quick look at alps_decode_pinnacle()
it looks sensible. Anything I can do to debug it further?

-- 
Bye, Peter Korsgaard
