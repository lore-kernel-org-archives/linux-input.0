From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH] Input: xpad: correct xbox one pad device name
Date: Tue, 12 Jan 2016 23:23:09 +0100
Message-ID: <1452637389-7690-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:32909 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752332AbcALWXm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jan 2016 17:23:42 -0500
Received: by mail-wm0-f53.google.com with SMTP id f206so272725337wmf.0
        for <linux-input@vger.kernel.org>; Tue, 12 Jan 2016 14:23:42 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Pavel Rojtberg <rojtberg@gmail.com>

From: Pavel Rojtberg <rojtberg@gmail.com>

apparently the Covert Forces id is not Covert Forces pad exclusive, but
rather denotes a new Firmware Version that can be found on all new
controllers and can be also updated on old hardware using Windows 10.

see: https://github.com/paroj/xpad/issues/19

Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 22e6205..6727954 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -128,7 +128,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x0289, "Microsoft X-Box pad v2 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
-	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Covert Forces)", 0, XTYPE_XBOXONE },
+	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
-- 
1.9.1

