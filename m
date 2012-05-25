From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 05/15] keyboard: imx_keypad: Use clk_prepare_enable/clk_disable_unprepare
Date: Fri, 25 May 2012 20:14:46 -0300
Message-ID: <1337987696-31728-5-git-send-email-festevam@gmail.com>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:47450 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759031Ab2EYXPT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 May 2012 19:15:19 -0400
Received: by mail-vc0-f174.google.com with SMTP id f11so727674vcb.19
        for <linux-input@vger.kernel.org>; Fri, 25 May 2012 16:15:18 -0700 (PDT)
In-Reply-To: <1337987696-31728-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kernel@pengutronix.de
Cc: shawn.guo@freescale.com, Fabio Estevam <fabio.estevam@freescale.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Prepare the clock before enabling it.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: <linux-input@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/input/keyboard/imx_keypad.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 6ee7421..9d57945 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -378,7 +378,7 @@ static void imx_keypad_close(struct input_dev *dev)
 	imx_keypad_inhibit(keypad);
 
 	/* Disable clock unit */
-	clk_disable(keypad->clk);
+	clk_disable_unprepare(keypad->clk);
 }
 
 static int imx_keypad_open(struct input_dev *dev)
@@ -391,7 +391,7 @@ static int imx_keypad_open(struct input_dev *dev)
 	keypad->enabled = true;
 
 	/* Enable the kpp clock */
-	clk_enable(keypad->clk);
+	clk_prepare_enable(keypad->clk);
 	imx_keypad_config(keypad);
 
 	/* Sanity control, not all the rows must be actived now. */
@@ -581,7 +581,7 @@ static int imx_kbd_suspend(struct device *dev)
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		clk_disable(kbd->clk);
+		clk_disable_unprepare(kbd->clk);
 
 	mutex_unlock(&input_dev->mutex);
 
@@ -603,7 +603,7 @@ static int imx_kbd_resume(struct device *dev)
 	mutex_lock(&input_dev->mutex);
 
 	if (input_dev->users)
-		clk_enable(kbd->clk);
+		clk_prepare_enable(kbd->clk);
 
 	mutex_unlock(&input_dev->mutex);
 
-- 
1.7.1

