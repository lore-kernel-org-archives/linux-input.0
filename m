From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 11/13] Input: touchscreen - drop unnecessary calls to device_init_wakeup
Date: Sat, 21 Jan 2017 10:46:03 -0800
Message-ID: <1485024365-3368-12-git-send-email-linux@roeck-us.net>
References: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:51375 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751039AbdAUStK (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 13:49:10 -0500
In-Reply-To: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-arm-kernel@lists.infradead.org, Petr Cvek <petr.cvek@tul.cz>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>

Calling device_init_wakeup in the remove function is unnecessary since the
device is going away, and thus won't be able to cause any wakeups under any
circumstances. Besides, the driver cleanup code already handles the
necessary cleanup.

Similar, disabling wakeup in the probe error path is unnecessary, as is
disabling wakeup in the probe function in the first place.

Changes were done automatically using the following coccinelle script.

@probe@
identifier p, probefn;
declarer name module_platform_driver_probe;
position pos;
@@
(
  module_platform_driver_probe(p, probefn@pos);
|
  struct platform_driver p = {
    .probe = probefn@pos,
  };
|
  struct i2c_driver p = {
    .probe = probefn@pos,
  };
|
  struct spi_driver p = {
    .probe = probefn@pos,
  };
)

@remove@
identifier p, removefn;
@@

  struct
(
  platform_driver
|
  i2c_driver
|
  spi_driver
|
  hv_driver
)
  p = {
    .remove = \(__exit_p(removefn)\|removefn\),
  };

@depends on remove@
identifier remove.removefn;
@@

removefn(...) {
<+...
- device_init_wakeup(...);
...+>
}

@depends on probe@
identifier probe.probefn;
expression dev;
@@

probefn(...) {
<+...
- device_init_wakeup(..., \(false\|0\));
  ...+>
}

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/touchscreen/ads7846.c    | 2 --
 drivers/input/touchscreen/bu21013_ts.c | 2 --
 drivers/input/touchscreen/eeti_ts.c    | 1 -
 drivers/input/touchscreen/lpc32xx_ts.c | 1 -
 drivers/input/touchscreen/st1232.c     | 1 -
 5 files changed, 7 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 1ce3ecbe37f8..f5793e3d945f 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1462,8 +1462,6 @@ static int ads7846_remove(struct spi_device *spi)
 {
 	struct ads7846 *ts = spi_get_drvdata(spi);
 
-	device_init_wakeup(&spi->dev, false);
-
 	sysfs_remove_group(&spi->dev.kobj, &ads784x_attr_group);
 
 	ads7846_disable(ts);
diff --git a/drivers/input/touchscreen/bu21013_ts.c b/drivers/input/touchscreen/bu21013_ts.c
index 931417eb4f5a..4fa5da8d5fa8 100644
--- a/drivers/input/touchscreen/bu21013_ts.c
+++ b/drivers/input/touchscreen/bu21013_ts.c
@@ -637,8 +637,6 @@ static int bu21013_remove(struct i2c_client *client)
 
 	kfree(bu21013_data);
 
-	device_init_wakeup(&client->dev, false);
-
 	return 0;
 }
 
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index fa974579eb41..16023867b9da 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -231,7 +231,6 @@ static int eeti_ts_probe(struct i2c_client *client,
 	 */
 	eeti_ts_stop(priv);
 
-	device_init_wakeup(&client->dev, 0);
 	return 0;
 
 err3:
diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index 7fbb3b0c8571..e0baa7de4102 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -313,7 +313,6 @@ static int lpc32xx_ts_remove(struct platform_device *pdev)
 	struct lpc32xx_tsc *tsc = platform_get_drvdata(pdev);
 	struct resource *res;
 
-	device_init_wakeup(&pdev->dev, 0);
 	free_irq(tsc->irq, tsc);
 
 	input_unregister_device(tsc->dev);
diff --git a/drivers/input/touchscreen/st1232.c b/drivers/input/touchscreen/st1232.c
index e943678ce54c..be5615c6bf8f 100644
--- a/drivers/input/touchscreen/st1232.c
+++ b/drivers/input/touchscreen/st1232.c
@@ -237,7 +237,6 @@ static int st1232_ts_remove(struct i2c_client *client)
 {
 	struct st1232_ts_data *ts = i2c_get_clientdata(client);
 
-	device_init_wakeup(&client->dev, 0);
 	st1232_ts_power(ts, false);
 
 	return 0;
-- 
2.7.4

