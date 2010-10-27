From: Dan Carpenter <error27@gmail.com>
Subject: [patch] touchscreen/bu21013_ts: null dereference in error handling
Date: Wed, 27 Oct 2010 12:08:22 +0200
Message-ID: <20101027100822.GF6062@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55037 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754463Ab0J0KIe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Oct 2010 06:08:34 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

If kzalloc() returned NULL then it would lead to a NULL deref after the
goto.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index ccde586..8f120b1 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -446,11 +446,14 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 	}
 
 	bu21013_data = kzalloc(sizeof(struct bu21013_ts_data), GFP_KERNEL);
+	if (!bu21013_data)
+		return -ENOMEM;
+
 	in_dev = input_allocate_device();
-	if (!bu21013_data || !in_dev) {
+	if (!in_dev) {
 		dev_err(&client->dev, "device memory alloc failed\n");
 		error = -ENOMEM;
-		goto err_free_mem;
+		goto err_free;
 	}
 
 	bu21013_data->in_dev = in_dev;
@@ -515,6 +518,7 @@ err_cs_disable:
 	pdata->cs_dis(pdata->cs_pin);
 err_free_mem:
 	input_free_device(bu21013_data->in_dev);
+err_free:
 	kfree(bu21013_data);
 
 	return error;
