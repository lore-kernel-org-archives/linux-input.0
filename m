From: Sebastian Schmidt <yath@yath.de>
Subject: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware ID"
Date: Sat, 30 Dec 2017 16:22:13 +0100
Message-ID: <20171230152213.GA2099@marax.lan.yath.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from karr.yath.de ([144.76.4.50]:47822 "EHLO karr.yath.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750950AbdL3PWV (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 10:22:21 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: Greg KH <gregkh@linuxfoundation.org>, Aaron Ma <aaron.ma@canonical.com>

This reverts commit ec667683c532c93fb41e100e5d61a518971060e2, which
breaks the Trackpoint on ThinkPad X1 Carbon Gen5 (Model 20HR). That
commit intended to add support for later firmware versions to the
trackpoint driver, however, the version is reported in the second byte
whereas the change was made to the magic byte preceding that version.
The update package linked by Lenovo suggests that 20HR models use an
ALPS Touchpad instead.

Signed-off-by: Sebastian Schmidt <yath@yath.de>
Acked-by: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
---
 drivers/input/mouse/trackpoint.c | 3 +--
 drivers/input/mouse/trackpoint.h | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
index 0871010f18d5..20b5b21c1bba 100644
--- a/drivers/input/mouse/trackpoint.c
+++ b/drivers/input/mouse/trackpoint.c
@@ -265,8 +265,7 @@ static int trackpoint_start_protocol(struct psmouse *psmouse, unsigned char *fir
 	if (ps2_command(&psmouse->ps2dev, param, MAKE_PS2_CMD(0, 2, TP_READ_ID)))
 		return -1;
 
-	/* add new TP ID. */
-	if (!(param[0] & TP_MAGIC_IDENT))
+	if (param[0] != TP_MAGIC_IDENT)
 		return -1;
 
 	if (firmware_id)
diff --git a/drivers/input/mouse/trackpoint.h b/drivers/input/mouse/trackpoint.h
index 88055755f82e..5617ed3a7d7a 100644
--- a/drivers/input/mouse/trackpoint.h
+++ b/drivers/input/mouse/trackpoint.h
@@ -21,9 +21,8 @@
 #define TP_COMMAND		0xE2	/* Commands start with this */
 
 #define TP_READ_ID		0xE1	/* Sent for device identification */
-#define TP_MAGIC_IDENT		0x03	/* Sent after a TP_READ_ID followed */
+#define TP_MAGIC_IDENT		0x01	/* Sent after a TP_READ_ID followed */
 					/* by the firmware ID */
-					/* Firmware ID includes 0x1, 0x2, 0x3 */
 
 
 /*
-- 
2.15.1

