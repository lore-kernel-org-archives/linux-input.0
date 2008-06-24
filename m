From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] WM9712: Warn if user attempts to use pressure measurement with 5 wire mode
Date: Tue, 24 Jun 2008 12:57:10 +0100
Message-ID: <1214308630-11154-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:4168 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYFXL5P (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Jun 2008 07:57:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

This is not supported by the hardware.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/input/touchscreen/wm9712.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/wm9712.c b/drivers/input/touchscreen/wm9712.c
index 0b6e4cf..4c5d85a 100644
--- a/drivers/input/touchscreen/wm9712.c
+++ b/drivers/input/touchscreen/wm9712.c
@@ -168,6 +168,18 @@ static void wm9712_phy_init(struct wm97xx *wm)
 			64000 / rpu);
 	}
 
+	/* WM9712 five wire */
+	if (five_wire) {
+		dig2 |= WM9712_45W;
+		dev_dbg(wm->dev, "setting 5-wire touchscreen mode.");
+
+		if (pil) {
+			dev_warn(wm->dev, "pressure measurement is not "
+				 "supported in 5-wire mode\n");
+			pil = 0;
+		}
+	}
+
 	/* touchpanel pressure current*/
 	if (pil == 2) {
 		dig2 |= WM9712_PIL;
@@ -179,12 +191,6 @@ static void wm9712_phy_init(struct wm97xx *wm)
 	if (!pil)
 		pressure = 0;
 
-	/* WM9712 five wire */
-	if (five_wire) {
-		dig2 |= WM9712_45W;
-		dev_dbg(wm->dev, "setting 5-wire touchscreen mode.");
-	}
-
 	/* polling mode sample settling delay */
 	if (delay < 0 || delay > 15) {
 		dev_dbg(wm->dev, "supplied delay out of range.");
-- 
1.5.3.2

