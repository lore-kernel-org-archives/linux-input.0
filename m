From: shubhrajyoti@ti.com
Subject: [PATCH] Prevent the NULL dereferencing
Date: Tue,  5 Apr 2011 15:28:15 +0530
Message-ID: <1301997495-20876-1-git-send-email-shubhrajyoti@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35473 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920Ab1DEJ6X (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Apr 2011 05:58:23 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: axel.lin@gmail.com, Shubhrajyoti D <a0393217@india.ti.com>

From: Shubhrajyoti D <a0393217@india.ti.com>


Signed-off-by: Shubhrajyoti D <a0393217@india.ti.com>
---
 drivers/input/keyboard/twl4030_keypad.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index 09bef79..cc06c4b 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -338,7 +338,7 @@ static int __devinit twl4030_kp_probe(struct platform_device *pdev)
 	u8 reg;
 	int error;
 
-	if (!pdata || !pdata->rows || !pdata->cols ||
+	if (!pdata || !pdata->rows || !pdata->cols || !pdata->keymap_data ||
 	    pdata->rows > TWL4030_MAX_ROWS || pdata->cols > TWL4030_MAX_COLS) {
 		dev_err(&pdev->dev, "Invalid platform_data\n");
 		return -EINVAL;
-- 
1.7.1

