From: Kevin McNeely <kev@cypress.com>
Subject: [v2] 2/3 i2c: Cypress TTSP G3 MTDEV I2C Device Driver
Date: Fri,  3 Dec 2010 18:06:22 -0800
Message-ID: <1291428384-26364-2-git-send-email-kev@cypress.com>
References: <Kevin McNeely <kev@cypress.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <Kevin McNeely <kev@cypress.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: David Brown <davidb@codeaurora.org>, Trilok Soni <tsoni@codeaurora.org>, Kevin McNeely <kev@cypress.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, Luotao Fu <l.fu@pengutronix.de>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Amended version of Cypress TTSP Gen3 I2C Device Driver.
Provides i2c communications modules for the Cypress
TTSP Gen3 MTDEV Core Driver.
Amendments include changes recommended by reviewers of
initial version.

Signed-off-by: Kevin McNeely <kev@cypress.com>
---
 drivers/input/touchscreen/Makefile     |    4 ++--
 drivers/input/touchscreen/cyttsp_i2c.c |   20 ++++++++------------
 2 files changed, 10 insertions(+), 14 deletions(-)
 mode change 100644 => 100755 drivers/input/touchscreen/cyttsp_i2c.c

diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 9c142b8..88ee091 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -16,8 +16,8 @@ obj-$(CONFIG_TOUCHSCREEN_ATMEL_TSADCC)	+= atmel_tsadcc.o
 obj-$(CONFIG_TOUCHSCREEN_BITSY)		+= h3600_ts_input.o
 obj-$(CONFIG_TOUCHSCREEN_BU21013)       += bu21013_ts.o
 obj-$(CONFIG_TOUCHSCREEN_CY8CTMG110)	+= cy8ctmg110_ts.o
-obj-$(CONFIG_TOUCHSCREEN_CYTTSP_CORE)	+= cyttsp_core.o
-obj-$(CONFIG_TOUCHSCREEN_CYTTSP_I2C)	+= cyttsp_i2c.o
+obj-$(CONFIG_TOUCHSCREEN_CYTTSP_CORE)   += cyttsp_core.o
+obj-$(CONFIG_TOUCHSCREEN_CYTTSP_I2C)    += cyttsp_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_DA9034)	+= da9034-ts.o
 obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
 obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+= hampshire.o
diff --git a/drivers/input/touchscreen/cyttsp_i2c.c b/drivers/input/touchscreen/cyttsp_i2c.c
old mode 100644
new mode 100755
index cacfe4d..2a066d8b
--- a/drivers/input/touchscreen/cyttsp_i2c.c
+++ b/drivers/input/touchscreen/cyttsp_i2c.c
@@ -87,17 +87,15 @@ static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
 	const struct i2c_device_id *id)
 {
 	struct cyttsp_i2c *ts;
-	int retval;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
 		return -EIO;
 
 	/* allocate and clear memory */
 	ts = kzalloc(sizeof(*ts), GFP_KERNEL);
-	if (ts == NULL) {
+	if (!ts) {
 		dev_dbg(&client->dev, "%s: Error, kzalloc.\n", __func__);
-		retval = -ENOMEM;
-		goto error_alloc_data_failed;
+		return -ENOMEM;
 	}
 
 	/* register driver_data */
@@ -109,18 +107,16 @@ static int __devinit cyttsp_i2c_probe(struct i2c_client *client,
 	ts->ops.dev = &client->dev;
 	ts->ops.dev->bus = &i2c_bus_type;
 
-	retval = cyttsp_core_init(&ts->ops, &client->dev, &ts->ttsp_client);
-	if (retval)
-		goto ttsp_core_err;
+	ts->ttsp_client = cyttsp_core_init(&ts->ops, &client->dev);
+	if (IS_ERR(ts->ttsp_client)) {
+		int retval = PTR_ERR(ts->ttsp_client);
+		kfree(ts);
+		return retval;
+	}
 
 	dev_dbg(ts->ops.dev, "%s: Registration complete\n", __func__);
 
 	return 0;
-
-ttsp_core_err:
-	kfree(ts);
-error_alloc_data_failed:
-	return retval;
 }
 
 
-- 
1.7.2.1


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------
