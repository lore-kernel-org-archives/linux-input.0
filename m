From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH v3 1/2] Input: xpad - add product ID for Xbox One S pad
Date: Fri, 25 Nov 2016 14:18:34 -0800
Message-ID: <0933bcf40040714e9ca3efdf80fd942f1b009547.1480111549.git.aicommander@gmail.com>
References: <cover.1480111549.git.aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36535 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbcKYWTZ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 25 Nov 2016 17:19:25 -0500
Received: by mail-pg0-f67.google.com with SMTP id x23so6458385pgx.3
        for <linux-input@vger.kernel.org>; Fri, 25 Nov 2016 14:18:51 -0800 (PST)
In-Reply-To: <cover.1480111549.git.aicommander@gmail.com>
In-Reply-To: <cover.1480111549.git.aicommander@gmail.com>
References: <cover.1480111549.git.aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org, Cameron Gutman <aicommander@gmail.com>

This is the new gamepad that ships with the Xbox One S which
includes Bluetooth functionality.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
No changes in v3.

---
 drivers/input/joystick/xpad.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 83af17a..19886db 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -134,6 +134,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
+	{ 0x045e, 0x02ea, "Microsoft X-Box One S pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
-- 
2.9.3

