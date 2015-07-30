From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 25/27] Input: touchscreen - Export OF module alias information
Date: Thu, 30 Jul 2015 18:18:50 +0200
Message-ID: <1438273132-20926-26-git-send-email-javier@osg.samsung.com>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:55121 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753620AbbG3QUT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 30 Jul 2015 12:20:19 -0400
In-Reply-To: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org

The I2C core always reports the MODALIAS uevent as "i2c:<client name"
regardless if the driver was matched using the I2C id_table or the
of_match_table. So technically there's no need for a driver to export
the OF table since currently it's not used.

In fact, the I2C device ID table is mandatory for I2C drivers since
a i2c_device_id is passed to the driver's probe function even if the
I2C core used the OF table to match the driver.

And since the I2C core uses different tables, OF-only drivers needs to
have duplicated data that has to be kept in sync and also the dev node
compatible manufacturer prefix is stripped when reporting the MODALIAS.

To avoid the above, the I2C core behavior may be changed in the future
to not require an I2C device table for OF-only drivers and report the
OF module alias. So, it's better to also export the OF table to prevent
breaking module autoloading if that happens.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 drivers/input/touchscreen/egalax_ts.c | 1 +
 drivers/input/touchscreen/mms114.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
index 7bce2d90ec74..1afc08b08155 100644
--- a/drivers/input/touchscreen/egalax_ts.c
+++ b/drivers/input/touchscreen/egalax_ts.c
@@ -264,6 +264,7 @@ static const struct of_device_id egalax_ts_dt_ids[] = {
 	{ .compatible = "eeti,egalax_ts" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, egalax_ts_dt_ids);
 
 static struct i2c_driver egalax_ts_driver = {
 	.driver = {
diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 6b69f461733c..7cce87650fc8 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -572,6 +572,7 @@ static const struct of_device_id mms114_dt_match[] = {
 	{ .compatible = "melfas,mms114" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, mms114_dt_match);
 #endif
 
 static struct i2c_driver mms114_driver = {
-- 
2.4.3

