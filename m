From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] Input: wacom: NULL dereference on allocation failure
Date: Wed, 4 Apr 2012 14:19:38 +0300
Message-ID: <20120404111938.GB23719@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:33245 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756125Ab2DDLTs (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Apr 2012 07:19:48 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

If the "wac_i2c" alloction fails, then it leads to a NULL dereference.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
index b29f064..b8ca4a6 100644
--- a/drivers/input/touchscreen/wacom_i2c.c
+++ b/drivers/input/touchscreen/wacom_i2c.c
@@ -252,7 +252,7 @@ static int __devinit wacom_i2c_probe(struct i2c_client *client,
 err_free_irq:
 	free_irq(client->irq, wac_i2c);
 err_free_mem:
-	input_free_device(wac_i2c->input);
+	input_free_device(input);
 	kfree(wac_i2c);
 
 	return error;
