From: Petr Sebor <petr@scssoft.com>
Subject: [PATCH] Input: xpad - added new USB IDs for Logitech F310 and F710
Date: Fri,  3 Jan 2014 00:24:23 +0100
Message-ID: <1388705063-6922-1-git-send-email-petr@scssoft.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.scssoft.com ([213.151.92.134]:47951 "EHLO mail.scssoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaABXba (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 2 Jan 2014 18:31:30 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Petr Sebor <petr@scssoft.com>

This enables the rumble force feedback on the F710 unit since
it is no longer treated as XTYPE_UNKNOWN type.

Signed-off-by: Petr Sebor <petr@scssoft.com>
---
 drivers/input/joystick/xpad.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 75e3b10..958489a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -125,6 +125,8 @@ static const struct xpad_device {
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
+	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
+	{ 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xc242, "Logitech Chillstream Controller", 0, XTYPE_XBOX360 },
 	{ 0x046d, 0xca84, "Logitech Xbox Cordless Controller", 0, XTYPE_XBOX },
 	{ 0x046d, 0xca88, "Logitech Compact Controller for Xbox", 0, XTYPE_XBOX },
-- 
1.8.3.2

