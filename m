From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] Input-as5011: Use common error handling code in
 as5011_configure_chip()
Date: Thu, 26 Oct 2017 20:55:54 +0200
Message-ID: <18c826ed-c587-927b-87a7-9180215e60d9@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:63069 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932334AbdJZS4E (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 26 Oct 2017 14:56:04 -0400
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fabien Marteau <fabien.marteau@armadeus.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Oct 2017 20:48:49 +0200

Add a jump target so that a specific error message is stored only once
at the end of this function implementation.
Replace four calls of the function "dev_err" by goto statements.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/input/joystick/as5011.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/input/joystick/as5011.c b/drivers/input/joystick/as5011.c
index 005d852a06e9..1858ebec020a 100644
--- a/drivers/input/joystick/as5011.c
+++ b/drivers/input/joystick/as5011.c
@@ -192,28 +192,20 @@ static int as5011_configure_chip(struct as5011_device *as5011,
 
 	/* write threshold */
 	error = as5011_i2c_write(client, AS5011_XP, plat_dat->xp);
-	if (error < 0) {
-		dev_err(&client->dev, "Can't write threshold\n");
-		return error;
-	}
+	if (error < 0)
+		goto report_write_failure;
 
 	error = as5011_i2c_write(client, AS5011_XN, plat_dat->xn);
-	if (error < 0) {
-		dev_err(&client->dev, "Can't write threshold\n");
-		return error;
-	}
+	if (error < 0)
+		goto report_write_failure;
 
 	error = as5011_i2c_write(client, AS5011_YP, plat_dat->yp);
-	if (error < 0) {
-		dev_err(&client->dev, "Can't write threshold\n");
-		return error;
-	}
+	if (error < 0)
+		goto report_write_failure;
 
 	error = as5011_i2c_write(client, AS5011_YN, plat_dat->yn);
-	if (error < 0) {
-		dev_err(&client->dev, "Can't write threshold\n");
-		return error;
-	}
+	if (error < 0)
+		goto report_write_failure;
 
 	/* to free irq gpio in chip */
 	error = as5011_i2c_read(client, AS5011_X_RES_INT, &value);
@@ -223,6 +215,10 @@ static int as5011_configure_chip(struct as5011_device *as5011,
 	}
 
 	return 0;
+
+report_write_failure:
+	dev_err(&client->dev, "Can't write threshold\n");
+	return error;
 }
 
 static int as5011_probe(struct i2c_client *client,
-- 
2.14.3

