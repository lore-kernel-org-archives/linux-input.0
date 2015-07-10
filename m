From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 0/8] Input: xpad: fix wireless pad connection and URB out
Date: Sat, 11 Jul 2015 01:47:40 +0200
Message-ID: <1436572068-10661-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36556 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632AbbGKGvM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jul 2015 02:51:12 -0400
Received: by widjy10 with SMTP id jy10so30836033wid.1
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2015 23:51:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

This series tries to finish the work of:
http://www.spinics.net/lists/linux-input/msg29445.html
Citing the original submission:
Rework the xpad driver to fix the issue where when a wireless xpad controller
is plugged in, 4 joystick devices are created, no matter how many are really 
attached to the system.
This is done by dynamically creating the devices only when they are found 
by the wireless receiver.
Along the way all usages of the out URB were guarded by the mutex and a
active flag was introduced to prevent usage while active.
This makes outbound communication more robust. (LED, FF, presence query)

Patches 1-2 clean up the x360 LED code after:
http://www.spinics.net/lists/linux-input/msg39147.html
partifularly the LED command on x360w pads is not submitted twice any more.
They are the same as already submitted here:
http://www.spinics.net/lists/linux-input/msg39438.html

Patches 3-6 implement the actual "on demand" creation/ deletion of input 
devices. To this end pad enumeration had to be changed from an monotonic
counter to a bitmask based counter. See Patch 6 for rationale.

Patches 7-8 prevent sending active URBs. This was alrady an issue before, but
is now more pressing as we always send the query packet on driver load. (x360w)

Pavel Rojtberg (6):
  Input: xpad: clarify LED enumeration
  Input: xpad: remove bulk out URB
  Input: xpad: query Wireless controller state at init
  Input: xpad: use bitmask for finding the pad_nr
  Input: xpad: factor out URB submission in xpad_play_effect
  Input: xpad: do not submit active URBs

Pierre-Loup A. Griffais (2):
  Input: xpad: move the input device creation to a new function
  Input: xpad: handle "present" and "gone" correctly

 xpad.c | 539 +++++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 290 insertions(+), 249 deletions(-)

-- 
1.9.1

