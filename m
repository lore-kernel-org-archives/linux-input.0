From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/3] Input: tsc2005 - add OF device table
Date: Fri, 10 Feb 2017 16:06:21 -0800
Message-ID: <20170211000623.33663-1-dmitry.torokhov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Michael Welling <mwelling@ieee.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

To be prepared for SPI module loading using full compatible strings from
device tree, let's add OF module device table data.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2005.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index f2c5f0e47f77..e02b69f40ad8 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -18,8 +18,9 @@
  * GNU General Public License for more details.
  */
 
-#include <linux/module.h>
 #include <linux/input.h>
+#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/spi/spi.h>
 #include <linux/regmap.h>
 #include "tsc200x-core.h"
@@ -77,9 +78,18 @@ static int tsc2005_remove(struct spi_device *spi)
 	return tsc200x_remove(&spi->dev);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id tsc2005_of_match[] = {
+	{ .compatible = "ti,tsc2005" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, tsc2005_of_match);
+#endif
+
 static struct spi_driver tsc2005_driver = {
 	.driver	= {
 		.name	= "tsc2005",
+		.of_match_table = of_match_ptr(tsc2005_of_match),
 		.pm	= &tsc200x_pm_ops,
 	},
 	.probe	= tsc2005_probe,
-- 
2.11.0.483.g087da7b7c-goog
