From: =?UTF-8?Q?Petr_=C5=A0ebor?= <petr@scssoft.com>
Subject: [PATCH] Input: xpad - do not map the DPAD to buttons with xbox 360  wireless controllers
Date: Mon, 27 Jan 2014 00:21:59 +0100
Message-ID: <10f1d8a1b4e46e767197c00c77719f77@mail.scs>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.scssoft.com ([213.151.92.134]:53332 "EHLO mail.scssoft.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753144AbaAZXWA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 26 Jan 2014 18:22:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Having the DPAD mapped to buttons makes the wireless gamepad behave
differently from the wired counterpart. Given the MAP_DPAD_TO_BUTTONS
flag is typically used for dance pads, this was probably added by
a mistake. Not specifying the flag makes the controller's hat switch
behave as expected.

Signed-off-by: Petr Sebor <petr@scssoft.com>
---
  drivers/input/joystick/xpad.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/joystick/xpad.c 
b/drivers/input/joystick/xpad.c
index 603fe0d..a433636 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -121,8 +121,8 @@ static const struct xpad_device {
  	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
  	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", 0, XTYPE_XBOX },
  	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
-	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", 
MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
-	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, 
XTYPE_XBOX360W },
+	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", 0, 
XTYPE_XBOX360W },
+	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", 0, XTYPE_XBOX360W },
  	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
  	{ 0x046d, 0xc21d, "Logitech Gamepad F310", 0, XTYPE_XBOX360 },
  	{ 0x046d, 0xc21f, "Logitech Gamepad F710", 0, XTYPE_XBOX360 },
-- 
1.8.3.2


