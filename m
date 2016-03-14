From: Silvan Jegen <s.jegen@gmail.com>
Subject: [PATCH] Input: xpad - Add Mad Catz FightStick TE 2 VID/PID
Date: Mon, 14 Mar 2016 20:07:08 +0100
Message-ID: <1457982428-9849-1-git-send-email-s.jegen@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34653 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbcCNTIA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Mar 2016 15:08:00 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Rojtberg <rojtberg@gmail.com>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Pierre-Loup A. Griffais" <githubpublic@plagman.net>
Cc: Silvan Jegen <s.jegen@gmail.com>, linux-kernel@vger.kernel.org

This adds the VID/PID combination for the Xbox One version of the Mad
Catz FightStick TE 2.

The functionality that this provides is about on par with what the
Windows drivers for the stick manage to deliver.

What works:
- Digital stick
- 6 main buttons
- Xbox button
- The two buttons on the back
- The locking buttons (preventing accidental Xbox button press)

What doesn't work:
- Two of the main buttons (don't work on Windows either)
- The "Haptic" button setting does not have an effect (not sure if it
  works on Windows)

I added the MAP_TRIGGERS_TO_BUTTONS option but in my (limited) testing
there was no practical difference with or without. The FightStick does
not have triggers though so adding it makes sense.

Signed-off-by: Silvan Jegen <s.jegen@gmail.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index e8a84d1..d3d7f7c 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -149,6 +149,7 @@ static const struct xpad_device {
 	{ 0x0738, 0x4556, "Mad Catz Lynx Wireless Controller", 0, XTYPE_XBOX },
 	{ 0x0738, 0x4716, "Mad Catz Wired Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0x4718, "Mad Catz Street Fighter IV FightStick SE", 0, XTYPE_XBOX360 },
+	{ 0x0738, 0x4a01, "Mad Catz FightStick TE 2", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0738, 0x4726, "Mad Catz Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0738, 0x4728, "Mad Catz Street Fighter IV FightPad", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
 	{ 0x0738, 0x4738, "Mad Catz Wired Xbox 360 Controller (SFIV)", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOX360 },
@@ -304,6 +305,7 @@ static struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
 	XPAD_XBOX360_VENDOR(0x0738),		/* Mad Catz X-Box 360 controllers */
 	{ USB_DEVICE(0x0738, 0x4540) },		/* Mad Catz Beat Pad */
+	XPAD_XBOXONE_VENDOR(0x0738),		/* Mad Catz FightStick TE 2 */
 	XPAD_XBOX360_VENDOR(0x0e6f),		/* 0x0e6f X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x12ab),		/* X-Box 360 dance pads */
 	XPAD_XBOX360_VENDOR(0x1430),		/* RedOctane X-Box 360 controllers */
-- 
2.7.2

