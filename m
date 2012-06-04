From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [RFC][PATCH 0/2] HID: wiimote: proper joystick device support
Date: Mon,  4 Jun 2012 21:19:11 +0200
Message-ID: <1338837553-10756-1-git-send-email-giuseppe.bilotta@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:48538 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948Ab2FDTTb (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jun 2012 15:19:31 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so4362260wgb.1
        for <linux-input@vger.kernel.org>; Mon, 04 Jun 2012 12:19:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: David Herrmann <dh.herrmann@googlemail.com>, Vojtech Pavlik <vojtech@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

The Wii Remote driver exposes three input devices for each connected Wii
Remote: a main device for buttons and rumble, the accelorometer and the
IR camera.

Since the main device exposes a BTN_A, it is considered to be a gamepad
from the input subsystem, and it gets handled as a joystick, accessible
via the appropriate /dev/input/jsN device. However, since the input
device itself does not expose any positional information, it appears as
a joystick with no axes (and 7 buttons).

The following two patches try to fix this problem by allowing buttons to
also be exposed via the Accelerometer input device. This way this device
also becomes a joystick, this time fully functional (three axes, 7
buttons).

The patchset is marked as RFC because I'm not 100% satisfied with the
solution. Although it does make the device usable as joystick in software
that does not have support for it otherwise, it presents two problems:

(1) button presses are reported twice, so one has to e.g. disable input
from the main device in software that supports both keyboards and
joysticks at the same time;
(2) the main device is still reported as a gamepad and caught by the
joydev driver.

A possible solution (not yet implemented in this patchset) for issue #1
would be to have a control (accessible via e.g. the /sys interface) to
select the device(s) for which the keys are reported.

For issue #2 there are two possible solutions: an explicit blacklist of
the the Wii Remote main device, or a fine-tuning of joydev_ids list.

Suggestions and critism welcome.

Giuseppe Bilotta (2):
  HID: wiimote: refactor key reporting
  HID: wiimote: report keys in Accelerometer too

 drivers/hid/hid-wiimote-core.c |   44 ++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

-- 
1.7.10.rc3.204.g95589

