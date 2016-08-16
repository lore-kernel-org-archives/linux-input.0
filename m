From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH v2 1/4] Input: xpad - add device ID for Xbox One S pad
Date: Mon, 15 Aug 2016 21:10:13 -0700
Message-ID: <1471320616-13110-2-git-send-email-aicommander@gmail.com>
References: <1471320616-13110-1-git-send-email-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36171 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbcHPEKT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Aug 2016 00:10:19 -0400
Received: by mail-pf0-f193.google.com with SMTP id y134so4765609pfg.3
        for <linux-input@vger.kernel.org>; Mon, 15 Aug 2016 21:10:19 -0700 (PDT)
In-Reply-To: <1471320616-13110-1-git-send-email-aicommander@gmail.com>
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

