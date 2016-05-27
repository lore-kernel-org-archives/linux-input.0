From: Pavel Rojtberg <rojtberg@gmail.com>
Subject: [PATCH 4/7] Input: xpad: xbox one elite controller support
Date: Fri, 27 May 2016 02:12:52 +0200
Message-ID: <1464307975-25890-5-git-send-email-rojtberg@gmail.com>
References: <1464307975-25890-1-git-send-email-rojtberg@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34492 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755453AbcE0ANT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 20:13:19 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so9498288wmn.1
        for <linux-input@vger.kernel.org>; Thu, 26 May 2016 17:13:18 -0700 (PDT)
In-Reply-To: <1464307975-25890-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Pavel Rojtberg <rojtberg@gmail.com>, "Pierre-Loup A . Griffais" <eduke32@plagman.net>

From: Pavel Rojtberg <rojtberg@gmail.com>

added the according id and incresed XPAD_PKT_LEN to 64 as the elite
controller sends at least 33 byte messages [1].
Verified to be working by [2].

[1]: https://franticrain.github.io/sniffs/XboxOneSniff.html
[2]: https://github.com/paroj/xpad/issues/23

Signed-off-by: Pierre-Loup A. Griffais <eduke32@plagman.net>
Signed-off-by: Pavel Rojtberg <rojtberg@gmail.com>
---
 drivers/input/joystick/xpad.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d601983..804dbcc 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -87,7 +87,7 @@
 #define DRIVER_AUTHOR "Marko Friedemann <mfr@bmx-chemnitz.de>"
 #define DRIVER_DESC "X-Box pad driver"
 
-#define XPAD_PKT_LEN 32
+#define XPAD_PKT_LEN 64
 
 /* xbox d-pads should map to buttons, as is required for DDR pads
    but we map them to axes when possible to simplify things */
@@ -129,6 +129,7 @@ static const struct xpad_device {
 	{ 0x045e, 0x028e, "Microsoft X-Box 360 pad", 0, XTYPE_XBOX360 },
 	{ 0x045e, 0x02d1, "Microsoft X-Box One pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x02dd, "Microsoft X-Box One pad (Firmware 2015)", 0, XTYPE_XBOXONE },
+	{ 0x045e, 0x02e3, "Microsoft X-Box One Elite pad", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0291, "Xbox 360 Wireless Receiver (XBOX)", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x045e, 0x0719, "Xbox 360 Wireless Receiver", MAP_DPAD_TO_BUTTONS, XTYPE_XBOX360W },
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
-- 
2.7.4

