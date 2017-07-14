From: Cameron Gutman <aicommander@gmail.com>
Subject: [PATCH] Input: xpad - fix PowerA init quirk for some gamepad models
Date: Thu, 13 Jul 2017 20:58:38 -0700
Message-ID: <20170714035838.6053-1-aicommander@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33785 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753059AbdGND7A (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 13 Jul 2017 23:59:00 -0400
Received: by mail-pg0-f68.google.com with SMTP id u62so9110923pgb.0
        for <linux-input@vger.kernel.org>; Thu, 13 Jul 2017 20:59:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, rojtberg@gmail.com
Cc: kyleabeauchamp@gmail.com, Cameron Gutman <aicommander@gmail.com>

The PowerA gamepad initialization quirk worked with the PowerA
wired gamepad I had around (0x24c6:0x543a), but a user reported [0]
that it didn't work for him, even though our gamepads shared the
same vendor and product IDs.

When I initially implemented the PowerA quirk, I wanted to avoid
actually triggering the rumble action during init. My tests showed
that my gamepad would work correctly even if it received a rumble
of 0 intensity, so that's what I went with.

Unfortunately, this apparently isn't true for all models (perhaps
a firmware difference?). This non-working gamepad seems to require
the real magic rumble packet that the Microsoft driver sends, which
actually vibrates the gamepad. To counteract this effect, I still
send the old zero-rumble PowerA quirk packet which cancels the
rumble effect before the motors can spin up enough to vibrate.

[0]: https://github.com/paroj/xpad/issues/48#issuecomment-313904867

Reported-by: Kyle Beauchamp <kyleabeauchamp@gmail.com>
Tested-by: Kyle Beauchamp <kyleabeauchamp@gmail.com>
Fixes: 81093c9848a7 ("Input: xpad - support some quirky Xbox One pads")
Cc: stable@vger.kernel.org # v4.12
Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
 drivers/input/joystick/xpad.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 298a6ba51411..ca0e19ae7a90 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -476,10 +476,21 @@ static const u8 xboxone_hori_init[] = {
 };
 
 /*
- * A rumble packet is required for some PowerA pads to start
+ * A specific rumble packet is required for some PowerA pads to start
  * sending input reports. One of those pads is (0x24c6:0x543a).
  */
-static const u8 xboxone_zerorumble_init[] = {
+static const u8 xboxone_rumblebegin_init[] = {
+	0x09, 0x00, 0x00, 0x09, 0x00, 0x0F, 0x00, 0x00,
+	0x1D, 0x1D, 0xFF, 0x00, 0x00
+};
+
+/*
+ * A rumble packet with zero FF intensity will immediately
+ * terminate the rumbling required to init PowerA pads.
+ * This should happen fast enough that the motors don't
+ * spin up to enough speed to actually vibrate the gamepad.
+ */
+static const u8 xboxone_rumbleend_init[] = {
 	0x09, 0x00, 0x00, 0x09, 0x00, 0x0F, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00
 };
@@ -494,9 +505,12 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
 	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
-	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_zerorumble_init),
-	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_zerorumble_init),
-	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_zerorumble_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumbleend_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumbleend_init),
+	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumbleend_init),
 };
 
 struct xpad_output_packet {
-- 
2.13.0

