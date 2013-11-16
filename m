From: Alexander Ploumistos <alex.ploumistos@gmail.com>
Subject: Logitech M560 (Unifying receiver mouse) - strange keycodes, wrong mapping
Date: Sat, 16 Nov 2013 13:09:31 +0200
Message-ID: <CAM86y2vwou-C11eo8gwpgnTbQQEpd+3NNhoRCr41t13oWrg8kA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:40008 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906Ab3KPLJd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Nov 2013 06:09:33 -0500
Received: by mail-wi0-f182.google.com with SMTP id en1so179132wid.15
        for <linux-input@vger.kernel.org>; Sat, 16 Nov 2013 03:09:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello everyone,

I recently got my hands on a Logitech M560 mouse and I tried to use it
with 3.11.x kernels (Fedora & Ubuntu). The button mapping was not what
I expected, so I ran it through evtest, xev and xinput, to see what
was off.

First, a few words about the device itself: It appears to be a
somewhat new model, so there is almost no info about it on the net. It
has nine buttons (left & right click, scroll wheel, tilt, forward &
back buttons and a small button behind the wheel) and it connects to
the computer via a "Unifying receiver". It lacks a middle button;
pressing on the wheel engages and disengages the freewheel mechanism,
although I guess the small button behind the wheel is not too
inconvenient to be used for middle clicks. However, this button is
supposed to do something special in windows 8 and surprisingly, it has
two different states.

The original mapping: Left and right clicks are mapped to buttons 1
and 3, wheel up/down to buttons 4/5, left/right tilts to buttons 8/9
(BTN_SIDE & BTN_EXTRA respectively instead of horizontal wheel
left/right), the back button sends simultaneously keypresses for
Super_L and "d", the forward button acts like a keypress for Super_R.
When you press the aforementioned "special" button for the first time,
it sends keycodes 64, 133 and 201 simultaneously (Alt_L, Super_L and
XF86TouchpadOff); press it again, and it acts like button 1. From
there on, it cycles between those two events.

Would anyone be interested in adding support for the mouse? Is it
possible to override the keycodes sent by the buttons, so that they
are recognized as buttons and not keyboard keys?

I will send the evtest output in a follow-up message.

Thank you for your time
