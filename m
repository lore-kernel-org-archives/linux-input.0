From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 23/35] Input: misc: use dev_get_platdata()
Date: Tue, 30 Jul 2013 17:14:45 +0900
Message-ID: <005201ce8cfc$d9e761b0$8db62510$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:54929 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754524Ab3G3IOq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Jul 2013 04:14:46 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQQ00KDVPKLG2P0@mailout4.samsung.com> for
 linux-input@vger.kernel.org; Tue, 30 Jul 2013 17:14:45 +0900 (KST)
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/input/misc/ad714x.c           |    4 ++--
 drivers/input/misc/adxl34x.c          |    2 +-
 drivers/input/misc/bfin_rotary.c      |    2 +-
 drivers/input/misc/bma150.c           |    3 ++-
 drivers/input/misc/cma3000_d0x.c      |    2 +-
 drivers/input/misc/gp2ap002a00f.c     |    2 +-
 drivers/input/misc/gpio_tilt_polled.c |    3 ++-
 drivers/input/misc/kxtj9.c            |    3 ++-
 drivers/input/misc/pwm-beeper.c       |    2 +-
 drivers/input/misc/twl4030-vibra.c    |    2 +-
 drivers/input/misc/twl6040-vibra.c    |    2 +-
 11 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index 2e5d5e1..6deecdd 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -969,7 +969,7 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 	int error;
 	struct input_dev *input[MAX_DEVICE_NUM];
 
-	struct ad714x_platform_data *plat_data = dev->platform_data;
+	struct ad714x_platform_data *plat_data = dev_get_platdata(dev);
 	struct ad714x_chip *ad714x;
 	void *drv_mem;
 	unsigned long irqflags;
@@ -986,7 +986,7 @@ struct ad714x_chip *ad714x_probe(struct device *dev, u16 bus_type, int irq,
 		goto err_out;
 	}
 
-	if (dev->platform_data == NULL) {
+	if (dev_get_platdata(dev) == NULL) {
 		dev_err(dev, "platform data for ad714x doesn't exist\n");
 		error = -EINVAL;
 		goto err_out;
diff --git a/drivers/input/misc/adxl34x.c b/drivers/input/misc/adxl34x.c
index 0735de3..d204997 100644
--- a/drivers/input/misc/adxl34x.c
+++ b/drivers/input/misc/adxl34x.c
@@ -714,7 +714,7 @@ struct adxl34x *adxl34x_probe(struct device *dev, int irq,
 
 	ac->fifo_delay = fifo_delay_default;
 
-	pdata = dev->platform_data;
+	pdata = dev_get_platdata(dev);
 	if (!pdata) {
 		dev_dbg(dev,
 			"No platform data: Using default initialization\n");
diff --git a/drivers/input/misc/bfin_rotary.c b/drivers/input/misc/bfin_rotary.c
index cd139cb..7703447 100644
--- a/drivers/input/misc/bfin_rotary.c
+++ b/drivers/input/misc/bfin_rotary.c
@@ -92,7 +92,7 @@ static irqreturn_t bfin_rotary_isr(int irq, void *dev_id)
 
 static int bfin_rotary_probe(struct platform_device *pdev)
 {
-	struct bfin_rotary_platform_data *pdata = pdev->dev.platform_data;
+	struct bfin_rotary_platform_data *pdata = dev_get_platdata(&pdev->dev);
 	struct bfin_rot *rotary;
 	struct input_dev *input;
 	int error;
diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index 865c2f9..52d3a9b 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -526,7 +526,8 @@ static int bma150_register_polled_device(struct bma150_data *bma150)
 static int bma150_probe(struct i2c_client *client,
 				  const struct i2c_device_id *id)
 {
-	const struct bma150_platform_data *pdata = client->dev.platform_data;
+	const struct bma150_platform_data *pdata =
+			dev_get_platdata(&client->dev);
 	const struct bma150_cfg *cfg;
 	struct bma150_data *bma150;
 	int chip_id;
diff --git a/drivers/input/misc/cma3000_d0x.c b/drivers/input/misc/cma3000_d0x.c
index df9b756..c7d0074 100644
--- a/drivers/input/misc/cma3000_d0x.c
+++ b/drivers/input/misc/cma3000_d0x.c
@@ -284,7 +284,7 @@ EXPORT_SYMBOL(cma3000_resume);
 struct cma3000_accl_data *cma3000_init(struct device *dev, int irq,
 				       const struct cma3000_bus_ops *bops)
 {
-	const struct cma3000_platform_data *pdata = dev->platform_data;
+	const struct cma3000_platform_data *pdata = dev_get_platdata(dev);
 	struct cma3000_accl_data *data;
 	struct input_dev *input_dev;
 	int rev;
diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
index fe30bd0..de21e31 100644
--- a/drivers/input/misc/gp2ap002a00f.c
+++ b/drivers/input/misc/gp2ap002a00f.c
@@ -125,7 +125,7 @@ static int gp2a_initialize(struct gp2a_data *dt)
 static int gp2a_probe(struct i2c_client *client,
 				const struct i2c_device_id *id)
 {
-	const struct gp2a_platform_data *pdata = client->dev.platform_data;
+	const struct gp2a_platform_data *pdata = dev_get_platdata(&client->dev);
 	struct gp2a_data *dt;
 	int error;
 
diff --git a/drivers/input/misc/gpio_tilt_polled.c b/drivers/input/misc/gpio_tilt_polled.c
index 714c683..38b3c11 100644
--- a/drivers/input/misc/gpio_tilt_polled.c
+++ b/drivers/input/misc/gpio_tilt_polled.c
@@ -98,7 +98,8 @@ static void gpio_tilt_polled_close(struct input_polled_dev *dev)
 
 static int gpio_tilt_polled_probe(struct platform_device *pdev)
 {
-	const struct gpio_tilt_platform_data *pdata = pdev->dev.platform_data;
+	const struct gpio_tilt_platform_data *pdata =
+			dev_get_platdata(&pdev->dev);
 	struct device *dev = &pdev->dev;
 	struct gpio_tilt_polled_dev *tdev;
 	struct input_polled_dev *poll_dev;
diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index a993b67..d708478 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -509,7 +509,8 @@ out:
 static int kxtj9_probe(struct i2c_client *client,
 				 const struct i2c_device_id *id)
 {
-	const struct kxtj9_platform_data *pdata = client->dev.platform_data;
+	const struct kxtj9_platform_data *pdata =
+			dev_get_platdata(&client->dev);
 	struct kxtj9_data *tj9;
 	int err;
 
diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
index a37f0c9..7d5666d 100644
--- a/drivers/input/misc/pwm-beeper.c
+++ b/drivers/input/misc/pwm-beeper.c
@@ -67,7 +67,7 @@ static int pwm_beeper_event(struct input_dev *input,
 
 static int pwm_beeper_probe(struct platform_device *pdev)
 {
-	unsigned long pwm_id = (unsigned long)pdev->dev.platform_data;
+	unsigned long pwm_id = (unsigned long)dev_get_platdata(&pdev->dev);
 	struct pwm_beeper *beeper;
 	int error;
 
diff --git a/drivers/input/misc/twl4030-vibra.c b/drivers/input/misc/twl4030-vibra.c
index 68a5f33..d993775 100644
--- a/drivers/input/misc/twl4030-vibra.c
+++ b/drivers/input/misc/twl4030-vibra.c
@@ -193,7 +193,7 @@ static bool twl4030_vibra_check_coexist(struct twl4030_vibra_data *pdata,
 
 static int twl4030_vibra_probe(struct platform_device *pdev)
 {
-	struct twl4030_vibra_data *pdata = pdev->dev.platform_data;
+	struct twl4030_vibra_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *twl4030_core_node = pdev->dev.parent->of_node;
 	struct vibra_info *info;
 	int ret;
diff --git a/drivers/input/misc/twl6040-vibra.c b/drivers/input/misc/twl6040-vibra.c
index 0c2dfc8..c2f9bf5 100644
--- a/drivers/input/misc/twl6040-vibra.c
+++ b/drivers/input/misc/twl6040-vibra.c
@@ -257,7 +257,7 @@ static SIMPLE_DEV_PM_OPS(twl6040_vibra_pm_ops, twl6040_vibra_suspend, NULL);
 
 static int twl6040_vibra_probe(struct platform_device *pdev)
 {
-	struct twl6040_vibra_data *pdata = pdev->dev.platform_data;
+	struct twl6040_vibra_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device *twl6040_core_dev = pdev->dev.parent;
 	struct device_node *twl6040_core_node = NULL;
 	struct vibra_info *info;
-- 
1.7.10.4


