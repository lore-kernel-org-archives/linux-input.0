From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH 1/3] Input: xpad - add product ID for Xbox One S pad
Date: Sat,  6 Aug 2016 14:30:28 -0700
Message-ID: <1470519030-23051-2-git-send-email-aicommander@gmail.com>
References: <1470519030-23051-1-git-send-email-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35623 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbcHFVad (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Aug 2016 17:30:33 -0400
Received: by mail-pa0-f68.google.com with SMTP id cf3so21295434pad.2
        for <linux-input@vger.kernel.org>; Sat, 06 Aug 2016 14:30:32 -0700 (PDT)
In-Reply-To: <1470519030-23051-1-git-send-email-aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, rojtberg@gmail.com
Cc: linux-input@vger.kernel.org

This is the new gamepad that ships with the Xbox One S which
includes Bluetooth functionality.

Signed-off-by: Cameron Gutman <aicommander@gmail.com>
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
2.7.4

