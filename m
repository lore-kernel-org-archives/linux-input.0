From: Qiao Zhou <zhouqiao@marvell.com>
Subject: [PATCH V7 2/4] mfd: workaround: add companion chip in 88pm80x
Date: Tue, 10 Jul 2012 17:17:36 +0800
Message-ID: <1341911858-10851-3-git-send-email-zhouqiao@marvell.com>
References: <1341911858-10851-1-git-send-email-zhouqiao@marvell.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:37323 "HELO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753274Ab2GJJR6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Jul 2012 05:17:58 -0400
In-Reply-To: <1341911858-10851-1-git-send-email-zhouqiao@marvell.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-input@vger.kernel.org
Cc: Qiao Zhou <zhouqiao@marvell.com>

in hw design, 800 is mainly for pmic control, while 805 for audio.
but there are 3 registers which controls class D speaker property,
and they are defined in 800 i2c client domain. so 805 codec driver
needs to use 800 i2c client to access class D speaker reg for
audio path management. so add this workaround for the purpose to
let 805 access 800 i2c in some scenario.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/88pm80x.c       |   28 ++++++++++++++++++++++++++++
 include/linux/mfd/88pm80x.h |    1 +
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/88pm80x.c b/drivers/mfd/88pm80x.c
index 5d73531..62da342 100644
--- a/drivers/mfd/88pm80x.c
+++ b/drivers/mfd/88pm80x.c
@@ -18,6 +18,12 @@
 #include <linux/uaccess.h>
 #include <linux/err.h>
 
+/*
+ * workaround: some registers needed by pm805 are defined in pm800, so
+ * need to use this global variable to maintain the relation between
+ * pm800 and pm805. would remove it after HW chip fixes the issue.
+ */
+static struct pm80x_chip *g_pm80x_chip;
 
 const struct regmap_config pm80x_regmap_config = {
 	.reg_bits = 8,
@@ -62,6 +68,19 @@ int __devinit pm80x_init(struct i2c_client *client,
 
 	device_init_wakeup(&client->dev, 1);
 
+	/*
+	 * workaround: set g_pm80x_chip to the first probed chip. if the
+	 * second chip is probed, just point to the companion to each
+	 * other so that pm805 can access those specific register. would
+	 * remove it after HW chip fixes the issue.
+	 */
+	if (!g_pm80x_chip)
+		g_pm80x_chip = chip;
+	else {
+		chip->companion = g_pm80x_chip->client;
+		g_pm80x_chip->companion = chip->client;
+	}
+
 	return 0;
 
 err_chip_id:
@@ -76,6 +95,15 @@ int __devexit pm80x_deinit(struct i2c_client *client)
 {
 	struct pm80x_chip *chip = i2c_get_clientdata(client);
 
+	/*
+	 * workaround: clear the dependency between pm800 and pm805.
+	 * would remove it after HW chip fixes the issue.
+	 */
+	if (g_pm80x_chip->companion)
+		g_pm80x_chip->companion = NULL;
+	else
+		g_pm80x_chip = NULL;
+
 	regmap_exit(chip->regmap);
 	devm_kfree(&client->dev, chip);
 
diff --git a/include/linux/mfd/88pm80x.h b/include/linux/mfd/88pm80x.h
index 6c126e9..103f06d 100644
--- a/include/linux/mfd/88pm80x.h
+++ b/include/linux/mfd/88pm80x.h
@@ -295,6 +295,7 @@ struct pm80x_chip {
 	struct pm80x_subchip *subchip;
 	struct device *dev;
 	struct i2c_client *client;
+	struct i2c_client *companion;
 	struct regmap *regmap;
 	struct regmap_irq_chip *regmap_irq_chip;
 	struct regmap_irq_chip_data *irq_data;
-- 
1.7.0.4

