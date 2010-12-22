From: Dan Carpenter <error27@gmail.com>
Subject: [patch -next] Staging: ste_rmi4: use after
 input_unregister_device()
Date: Thu, 23 Dec 2010 00:07:33 +0300
Message-ID: <20101222210733.GJ1936@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33411 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751218Ab0LVVHv (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Dec 2010 16:07:51 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: Henrik Rydberg <rydberg@euromail.se>, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>, Linus Walleij <linus.walleij@stericsson.com>, devel@driverdev.osuosl.org, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org

The original code called input_free_device(rmi4_data->input_dev) after
input_unregister_device(rmi4_data->input_dev) and that's a double free.
This is described in the comments to input_unregister_device().

The normal way to handle this is to make input_register_device() the
last function in the probe which can fail.  That way you can avoid the
call to input_unregister_device() entirely.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
index e8f047e..80183a7 100644
--- a/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
+++ b/drivers/staging/ste_rmi4/synaptics_i2c_rmi4.c
@@ -986,12 +986,6 @@ static int __devinit synaptics_rmi4_probe
 	input_set_abs_params(rmi4_data->input_dev, ABS_MT_TOUCH_MAJOR, 0,
 						MAX_TOUCH_MAJOR, 0, 0);
 
-	retval = input_register_device(rmi4_data->input_dev);
-	if (retval) {
-		dev_err(&client->dev, "%s:input register failed\n", __func__);
-		goto err_input_register;
-	}
-
 	/* Clear interrupts */
 	synaptics_rmi4_i2c_block_read(rmi4_data,
 			rmi4_data->fn01_data_base_addr + 1, intr_status,
@@ -1003,15 +997,20 @@ static int __devinit synaptics_rmi4_probe
 	if (retval) {
 		dev_err(&client->dev, "%s:Unable to get attn irq %d\n",
 				__func__, platformdata->irq_number);
-		goto err_request_irq;
+		goto err_unset_clientdata;
+	}
+
+	retval = input_register_device(rmi4_data->input_dev);
+	if (retval) {
+		dev_err(&client->dev, "%s:input register failed\n", __func__);
+		goto err_free_irq;
 	}
 
 	return retval;
 
-err_request_irq:
+err_free_irq:
 	free_irq(platformdata->irq_number, rmi4_data);
-	input_unregister_device(rmi4_data->input_dev);
-err_input_register:
+err_unset_clientdata:
 	i2c_set_clientdata(client, NULL);
 err_query_dev:
 	if (platformdata->regulator_en) {
