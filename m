From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: egalax: potential NULL dereference on error
Date: Sat, 19 Dec 2015 13:58:24 +0300
Message-ID: <20151219105824.GA3749@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27053 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750931AbbLSK6n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Dec 2015 05:58:43 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?iso-8859-1?B?QvZzevZybelueWkgWm9sdOFu?= <zboszormenyi@sicom.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

We didn't check input_allocate_device() for failures so it could lead to
a NULL deref.

Fixes: 6b0f8f9c52ef ('Input: add eGalaxTouch serial touchscreen driver')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/touchscreen/egalax_ts_serial.c b/drivers/input/touchscreen/egalax_ts_serial.c
index a078c1c..8becd26 100644
--- a/drivers/input/touchscreen/egalax_ts_serial.c
+++ b/drivers/input/touchscreen/egalax_ts_serial.c
@@ -104,10 +104,13 @@ static int egalax_connect(struct serio *serio, struct serio_driver *drv)
 	int error;
 
 	egalax = kzalloc(sizeof(struct egalax), GFP_KERNEL);
+	if (!egalax)
+		return -ENOMEM;
+
 	input_dev = input_allocate_device();
-	if (!egalax) {
+	if (!input_dev) {
 		error = -ENOMEM;
-		goto err_free_mem;
+		goto err_free_egalax;
 	}
 
 	egalax->serio = serio;
@@ -145,8 +148,8 @@ err_close_serio:
 	serio_close(serio);
 err_reset_drvdata:
 	serio_set_drvdata(serio, NULL);
-err_free_mem:
 	input_free_device(input_dev);
+err_free_egalax:
 	kfree(egalax);
 	return error;
 }
