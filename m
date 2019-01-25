From: =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 2/3] input: misc: bma150: Add support for device tree
Date: Fri, 25 Jan 2019 19:43:59 +0100
Message-ID: <20190125184400.17669-3-pawel.mikolaj.chmiel@gmail.com>
References: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190125184400.17669-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: robh+dt@kernel.org, mark.rutland@arm.com, pawel.mikolaj.chmiel@gmail.com, xc-racer2@live.ca, devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

Add basic of_match table to enable bma150 to be probed via DT

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 drivers/input/misc/bma150.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/misc/bma150.c b/drivers/input/misc/bma150.c
index d101bb0a33d6..c26a118d89fa 100644
--- a/drivers/input/misc/bma150.c
+++ b/drivers/input/misc/bma150.c
@@ -31,6 +31,7 @@
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 #include <linux/pm.h>
 #include <linux/pm_runtime.h>
 #include <linux/bma150.h>
@@ -628,6 +629,14 @@ static int bma150_resume(struct device *dev)
 
 static UNIVERSAL_DEV_PM_OPS(bma150_pm, bma150_suspend, bma150_resume, NULL);
 
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id bma150_of_match[] = {
+	{ .compatible = "bosch,bma150" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bma150_of_match);
+#endif
+
 static const struct i2c_device_id bma150_id[] = {
 	{ "bma150", 0 },
 	{ "smb380", 0 },
@@ -640,6 +649,7 @@ MODULE_DEVICE_TABLE(i2c, bma150_id);
 static struct i2c_driver bma150_driver = {
 	.driver = {
 		.name	= BMA150_DRIVER,
+		.of_match_table = of_match_ptr(bma150_of_match),
 		.pm	= &bma150_pm,
 	},
 	.class		= I2C_CLASS_HWMON,
-- 
2.17.1
