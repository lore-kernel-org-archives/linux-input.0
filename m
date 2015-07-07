From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: of_touchscreen - always issue warning if axis is not set up
Date: Mon,  6 Jul 2015 17:27:27 -0700
Message-ID: <1436228849-29530-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35825 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275AbbGGA1t (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 20:27:49 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Maxime Ripard <maxime.ripard@free-electrons.com>, Sebastian Reichel <sre@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, Roger Quadros <rogerq@ti.com>, linux-kernel@vger.kernel.org

Do issue warning about axis that is present in device tree but not specified
by the driver even in case of multi-touch axis as callers now tell us if they
expect multi-touch data or not.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/of_touchscreen.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/of_touchscreen.c b/drivers/input/touchscreen/of_touchscreen.c
index 806cd0a..759cf4b 100644
--- a/drivers/input/touchscreen/of_touchscreen.c
+++ b/drivers/input/touchscreen/of_touchscreen.c
@@ -39,13 +39,9 @@ static void touchscreen_set_params(struct input_dev *dev,
 	struct input_absinfo *absinfo;
 
 	if (!test_bit(axis, dev->absbit)) {
-		/*
-		 * Emit a warning only if the axis is not a multitouch
-		 * axis, which might not be set by the driver.
-		 */
-		if (!input_is_mt_axis(axis))
-			dev_warn(&dev->dev,
-				 "DT specifies parameters but the axis is not set up\n");
+		dev_warn(&dev->dev,
+			 "DT specifies parameters but the axis %lu is not set up\n",
+			 axis);
 		return;
 	}
 
-- 
2.4.3.573.g4eafbef

