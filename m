From: Daniel Drake <dsd@laptop.org>
Subject: Multitouch type A protocol clarifications
Date: Thu, 6 Sep 2012 11:41:33 -0600
Message-ID: <CAMLZHHR4a=3TEbvHMMMuXfB+ooG4az6h9mefUGwJXxqtkh+FSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:60652 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932280Ab2IFRle (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Sep 2012 13:41:34 -0400
Received: by pbbrr13 with SMTP id rr13so2818250pbb.19
        for <linux-input@vger.kernel.org>; Thu, 06 Sep 2012 10:41:33 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: paul fox <pgf@laptop.org>

Hi,

I'm working with a prototype for the XO-4 touchscreen laptop (with
both trackpad + touchscreen). The touchscreen in this test unit is a
raydium device, using this driver:
http://dev.laptop.org/git/olpc-kernel/plain/drivers/input/touchscreen/raydium_ts.c?h=arm-3.0-wip

We understand that it is a type A device, since the hardware just
sends a list of touch points without tracking them. If I touch with
finger 1, it starts sending that as the first list entry. Then I touch
with finger 2, it starts reporting that in the second list entry. Then
I release finger 1, and finger 2 jumps into list entry 1.

The driver at the above link is wrong/confused since it reports
tracking IDs, and reading
http://www.kernel.org/doc/Documentation/input/multi-touch-protocol.txt
I see that tracking IDs are only for type B devices. Also, in the
following tests, I removed the pressure reporting, just to make things
more simplistic.

Removing also the BTN_TOUCH reporting, I end up with what is suggested
in multi-touch-protocol.txt as the example for type A. As reported
with evtest, two fingers are placed:

type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 678
type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 498
++++++++++++++ SYN_MT_REPORT ++++++++++++
type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 215
type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 288
++++++++++++++ SYN_MT_REPORT ++++++++++++
-------------- SYN_REPORT ------------

First finger is released:

type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 215
type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 288
++++++++++++++ SYN_MT_REPORT ++++++++++++
-------------- SYN_REPORT ------------

The other finger is released:

++++++++++++++ SYN_MT_REPORT ++++++++++++
-------------- SYN_REPORT ------------



Or, to simplify things, just a single finger quick touch and release:

type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 487
type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 343
++++++++++++++ SYN_MT_REPORT ++++++++++++
-------------- SYN_REPORT ------------
++++++++++++++ SYN_MT_REPORT ++++++++++++
-------------- SYN_REPORT ------------



That represents all of the events - I'm not reporting BTN_TOUCH,
pressure, tracking ID, ... (neither the event nor the capability). And
I think I'm following whats suggested in the documentation. But under
this setup, X (server 1.13, xf86-input-evdev-2.7.3, mtdev-1.1.2)
doesn't even consider the device as an input device (doesn't appear in
output of "xinput" command), and therefore the touchscreen is
unresponsive under X. I have to readd this line to get X to pick it
up:

	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);

(note that is just advertising the BTN_TOUCH capability - not actually
reporting any events from it)

Is that an X bug or is there room for improvement in the documentation
here? Right now the documentation makes me think that BTN_TOUCH is
optional.

Should I be reporting the BTN_TOUCH capability? Should I be sending
BTN_TOUCH events to report if there are any active touch points or
not?



At this point, whether or not I report BTN_TOUCH in the event stream,
I'm facing the problem that X (as reported by "xinput test-xi2") never
reports a TouchEnd event, not even for a simple touch. And, after
touching the screen for the first time, if I move the mouse cursor
around the screen with the touchpad, X reports that the first mouse
button is held down, when its not (no active touch, touchpad's mouse
button is not pressed).

Is that an X problem, or is there some further events I need to be passing?

Thanks,
Daniel
