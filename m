From: Naveen Kumar G <naveen.gaddipati@stericsson.com>
Subject: [PATCH 2/2] input:Remove display resolution parameters in BU21013 touch panel
Date: Wed, 12 Jan 2011 12:13:38 +0530
Message-ID: <1294814618-14603-1-git-send-email-naveen.gaddipati@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:45725 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750836Ab1ALGoY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jan 2011 01:44:24 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: STEricsson_nomadik_linux@list.st.com, linux-input@vger.kernel.org, tsoni@codeaurora.org, rydberg@euromail.se, Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

From: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>

Removed the display resolution parameters from platform data
of the BU21013 touch panel driver

Signed-off-by: Naveen Kumar Gaddipati <naveen.gaddipati@stericsson.com>
---
 drivers/input/touchscreen/bu21013_ts.c |    4 ++--
 include/linux/input/bu21013.h          |    4 ----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 531e982..ba89010 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -498,9 +498,9 @@ static int __devinit bu21013_probe(struct i2c_client *client,
 	__set_bit(EV_ABS, in_dev->evbit);
 
 	input_set_abs_params(in_dev, ABS_MT_POSITION_X, 0,
-						pdata->x_max_res, 0, 0);
+						pdata->touch_x_max, 0, 0);
 	input_set_abs_params(in_dev, ABS_MT_POSITION_Y, 0,
-						pdata->y_max_res, 0, 0);
+						pdata->touch_y_max, 0, 0);
 	input_set_drvdata(in_dev, bu21013_data);
 
 	error = request_threaded_irq(pdata->irq, NULL, bu21013_gpio_irq,
diff --git a/include/linux/input/bu21013.h b/include/linux/input/bu21013.h
index ac9ed7b..14bb641 100644
--- a/include/linux/input/bu21013.h
+++ b/include/linux/input/bu21013.h
@@ -13,8 +13,6 @@
  * @cs_en:	pointer to the cs enable function
  * @cs_dis:	pointer to the cs disable function
  * @irq_read_val:    pointer to read the pen irq value function
- * @x_max_res: xmax resolution
- * @y_max_res: ymax resolution
  * @touch_x_max: touch x max
  * @touch_y_max: touch y max
  * @cs_pin: chip select pin
@@ -31,8 +29,6 @@ struct bu21013_platform_device {
 	int (*cs_en)(int reset_pin);
 	int (*cs_dis)(int reset_pin);
 	int (*irq_read_val)(void);
-	int x_max_res;
-	int y_max_res;
 	int touch_x_max;
 	int touch_y_max;
 	unsigned int cs_pin;
-- 
1.7.2.dirty

