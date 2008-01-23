From: "eric miao" <eric.y.miao@gmail.com>
Subject: [PATCH 2/12] pxa: remove the pin configuration from the keypad driver
Date: Wed, 23 Jan 2008 15:17:17 +0800
Message-ID: <f17812d70801222317k641d55fy8f94c436770a8b0a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:28040 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbYAWHRR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jan 2008 02:17:17 -0500
Received: by wa-out-1112.google.com with SMTP id v27so4880612wah.23
        for <linux-input@vger.kernel.org>; Tue, 22 Jan 2008 23:17:17 -0800 (PST)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>

>From dbd62bced0f789765d1823f66af792933c6b46a1 Mon Sep 17 00:00:00 2001
From: eric miao <eric.miao@marvell.com>
Date: Tue, 22 Jan 2008 16:34:12 +0800
Subject: [PATCH] pxa: remove the pin configuration from the keypad driver

The pin configurations will slowly be moved to the board specific code
at initialization thus to make the driver more generic.

Signed-off-by: eric miao <eric.miao@marvell.com>
---
 drivers/input/keyboard/pxa27x_keypad.c   |    4 ----
 include/asm-arm/arch-pxa/pxa27x_keypad.h |    1 -
 2 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/pxa27x_keypad.c
b/drivers/input/keyboard/pxa27x_keypad.c
index 06c1d5a..43fb63d 100644
--- a/drivers/input/keyboard/pxa27x_keypad.c
+++ b/drivers/input/keyboard/pxa27x_keypad.c
@@ -208,10 +208,6 @@ static int __devinit pxa27x_keypad_probe(struct
platform_device *pdev)
 	if (error)
 		goto err_free_irq;

-	/* Setup GPIOs. */
-	for (i = 0; i < pdata->nr_rows + pdata->nr_cols; i++)
-		pxa_gpio_mode(pdata->gpio_modes[i]);
-
 	/*
 	 * Store rows/cols info into keyboard registers.
 	 */
diff --git a/include/asm-arm/arch-pxa/pxa27x_keypad.h
b/include/asm-arm/arch-pxa/pxa27x_keypad.h
index f19f74a..ef17db6 100644
--- a/include/asm-arm/arch-pxa/pxa27x_keypad.h
+++ b/include/asm-arm/arch-pxa/pxa27x_keypad.h
@@ -4,7 +4,6 @@
 struct pxa27x_keypad_platform_data {
 	int nr_rows, nr_cols;
 	int keycodes[PXAKBD_MAXROW][PXAKBD_MAXCOL];
-	int gpio_modes[PXAKBD_MAXROW + PXAKBD_MAXCOL];

 #ifdef CONFIG_PM
 	u32 reg_kpc;
-- 
1.5.2.5.GIT



-- 
Cheers
- eric
