From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] Input, blackfin: ! has a higher priority than >
Date: Wed, 28 Jan 2009 23:22:41 +0100
Message-ID: <4980DAB1.6090202@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:50079 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZA1WWk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Jan 2009 17:22:40 -0500
Received: by fg-out-1718.google.com with SMTP id 13so717980fge.17
        for <linux-input@vger.kernel.org>; Wed, 28 Jan 2009 14:22:38 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, michael.hennerich@analog.com, cooloney@kernel.org
Cc: linux-input@vger.kernel.org

! has a higher priority than >

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index 1928401..ee855c5 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -209,8 +209,8 @@ static int __devinit bfin_kpad_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	if (!pdata->debounce_time || !pdata->debounce_time > MAX_MULT ||
-	    !pdata->coldrive_time || !pdata->coldrive_time > MAX_MULT) {
+	if (!pdata->debounce_time || pdata->debounce_time > MAX_MULT ||
+	    !pdata->coldrive_time || pdata->coldrive_time > MAX_MULT) {
 		printk(KERN_ERR DRV_NAME
 			": Invalid Debounce/Columdrive Time from pdata\n");
 		bfin_write_KPAD_MSEL(0xFF0);	/* Default MSEL	*/

