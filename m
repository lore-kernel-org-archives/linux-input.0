From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH 1/2] iforce: Add Gullemot Jet Leader Force Feedback
Date: Thu,  6 May 2010 23:34:00 +0200
Message-ID: <1273181641-24546-1-git-send-email-marek.vasut@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:11166 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751171Ab0EFVfX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 May 2010 17:35:23 -0400
Received: by fg-out-1718.google.com with SMTP id d23so534889fga.1
        for <linux-input@vger.kernel.org>; Thu, 06 May 2010 14:35:22 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, dtor@mail.ru, Marek Vasut <marek.vasut@gmail.com>

Patch for this was in my repo since like 2.6.16 times. I never used the device
much so the patch was always forgotten. This device features a RUDDER on the
knob, so I had to add one more definition for that. The rest is just a USB ID
addition.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/input/joystick/iforce/iforce-main.c |    4 ++++
 drivers/input/joystick/iforce/iforce-usb.c  |    1 +
 2 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joystick/iforce/iforce-main.c b/drivers/input/joystick/iforce/iforce-main.c
index b1edd77..987faea 100644
--- a/drivers/input/joystick/iforce/iforce-main.c
+++ b/drivers/input/joystick/iforce/iforce-main.c
@@ -54,6 +54,9 @@ static signed short btn_avb_wheel[] =
 static signed short abs_joystick[] =
 { ABS_X, ABS_Y, ABS_THROTTLE, ABS_HAT0X, ABS_HAT0Y, -1 };
 
+static signed short abs_joystick_rudder[] =
+{ ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER, ABS_HAT0X, ABS_HAT0Y, -1 };
+
 static signed short abs_avb_pegasus[] =
 { ABS_X, ABS_Y, ABS_THROTTLE, ABS_RUDDER, ABS_HAT0X, ABS_HAT0Y,
   ABS_HAT1X, ABS_HAT1Y, -1 };
@@ -76,6 +79,7 @@ static struct iforce_device iforce_device[] = {
 	{ 0x061c, 0xc0a4, "ACT LABS Force RS",                          btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x061c, 0xc084, "ACT LABS Force RS",				btn_wheel, abs_wheel, ff_iforce },
 	{ 0x06f8, 0x0001, "Guillemot Race Leader Force Feedback",	btn_wheel, abs_wheel, ff_iforce }, //?
+	{ 0x06f8, 0x0003, "Gullemot Jet Leader Force Feedback",		btn_joystick, abs_joystick_rudder, ff_iforce },
 	{ 0x06f8, 0x0004, "Guillemot Force Feedback Racing Wheel",	btn_wheel, abs_wheel, ff_iforce }, //?
 	{ 0x06f8, 0x0004, "Gullemot Jet Leader 3D",			btn_joystick, abs_joystick, ff_iforce }, //?
 	{ 0x06d6, 0x29bc, "Trust Force Feedback Race Master",		btn_wheel, abs_wheel, ff_iforce },
diff --git a/drivers/input/joystick/iforce/iforce-usb.c b/drivers/input/joystick/iforce/iforce-usb.c
index b41303d..6c96631 100644
--- a/drivers/input/joystick/iforce/iforce-usb.c
+++ b/drivers/input/joystick/iforce/iforce-usb.c
@@ -212,6 +212,7 @@ static struct usb_device_id iforce_usb_ids [] = {
 	{ USB_DEVICE(0x061c, 0xc0a4) },         /* ACT LABS Force RS */
 	{ USB_DEVICE(0x061c, 0xc084) },         /* ACT LABS Force RS */
 	{ USB_DEVICE(0x06f8, 0x0001) },		/* Guillemot Race Leader Force Feedback */
+	{ USB_DEVICE(0x06f8, 0x0003) },		/* Guillemot Jet Leader Force Feedback */
 	{ USB_DEVICE(0x06f8, 0x0004) },		/* Guillemot Force Feedback Racing Wheel */
 	{ USB_DEVICE(0x06f8, 0xa302) },		/* Guillemot Jet Leader 3D */
 	{ }					/* Terminating entry */
-- 
1.7.0

