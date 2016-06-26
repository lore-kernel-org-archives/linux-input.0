From: Richard Pospesel <pospeselr@gmail.com>
Subject: [PATCH] made the byd_detect function more restrictive to prevent false positives when actual mouse is a generic PS/2 mouse; byd_detect now tries to go through BYD touchpad configuration steps, which fail when not performed on BYD touchpad
Date: Sat, 25 Jun 2016 19:25:21 -0700
Message-ID: <1466907921-10210-2-git-send-email-pospeselr@gmail.com>
References: <1466907921-10210-1-git-send-email-pospeselr@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35627 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751671AbcFZCZr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Jun 2016 22:25:47 -0400
Received: by mail-pa0-f68.google.com with SMTP id hf6so12256672pac.2
        for <linux-input@vger.kernel.org>; Sat, 25 Jun 2016 19:25:47 -0700 (PDT)
In-Reply-To: <1466907921-10210-1-git-send-email-pospeselr@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: chris@diamand.org, dmitry.torokhov@gmail.com, phonesyfreakies@gmail.com

---
 drivers/input/mouse/byd.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/byd.c b/drivers/input/mouse/byd.c
index ec73f75..380e295 100644
--- a/drivers/input/mouse/byd.c
+++ b/drivers/input/mouse/byd.c
@@ -355,7 +355,7 @@ static int byd_reset_touchpad(struct psmouse *psmouse)
 		{ PSMOUSE_CMD_ENABLE, 0 },
 		/*
 		 * BYD-specific initialization, which enables absolute mode and
-		 * (if desired), the touchpad's built-in gesture detection.
+		 * disables the builtin hardware gesture recogniton.
 		 */
 		{ 0x10E2, 0x00 },
 		{ 0x10E0, 0x02 },
@@ -435,6 +435,7 @@ int byd_detect(struct psmouse *psmouse, bool set_properties)
 	struct ps2dev *ps2dev = &psmouse->ps2dev;
 	u8 param[4] = {0x03, 0x00, 0x00, 0x00};
 
+	/* 'Secret' handshake */
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
 		return -1;
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES))
@@ -446,7 +447,21 @@ int byd_detect(struct psmouse *psmouse, bool set_properties)
 	if (ps2_command(ps2dev, param, PSMOUSE_CMD_GETINFO))
 		return -1;
 
-	if (param[1] != 0x03 || param[2] != 0x64)
+	/*
+	 * BYD touchpad returns 0x03 for resolution ( 8 count / mm ) and
+	 * 0x64 ( 100 samples / sec ) for sampling rate
+	 * The first byte's value is dependent on the mouse button states:
+	 *  0 : no button pressed
+	 *  1 : right button pressed
+	 *  4 : left button pressed
+	 *  5 : right and left button pressed
+	 */
+	if ((param[0] & 0x05) != param[0] || param[1] != 0x03 ||
+	    param[2] != 0x64)
+		return -ENODEV;
+
+	/* Attempt to set BYD unique settings */
+	if (byd_reset_touchpad(psmouse))
 		return -ENODEV;
 
 	psmouse_dbg(psmouse, "BYD touchpad detected\n");
@@ -504,4 +519,4 @@ int byd_init(struct psmouse *psmouse)
 	__clear_bit(REL_Y, dev->relbit);
 
 	return 0;
-}
+}
\ No newline at end of file
-- 
2.5.0

