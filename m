From: Sushaanth Srirangapathi <sushaanth.s@ti.com>
Subject: [PATCH 2/3] Input: tps6507x-ts - Add device tree support
Date: Mon, 1 Feb 2016 11:58:49 +0530
Message-ID: <1454308130-12452-4-git-send-email-sushaanth.s@ti.com>
References: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: devicetree@vger.kernel.org, Sushaanth Srirangapathi <sushaanth.s@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Add device tree support for TPS6507x touchscreen input device.

Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
---
 drivers/input/touchscreen/tps6507x-ts.c |   51 ++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index a340bfc..4c28369 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -19,6 +19,7 @@
 #include <linux/input.h>
 #include <linux/input-polldev.h>
 #include <linux/platform_device.h>
+#include <linux/of.h>
 #include <linux/mfd/tps6507x.h>
 #include <linux/input/tps6507x-ts.h>
 #include <linux/delay.h>
@@ -32,6 +33,10 @@
 					 TPS6507X_ADCONFIG_INPUT_REAL_TSC)
 #define	TPS6507X_ADCONFIG_POWER_DOWN_TS (TPS6507X_ADCONFIG_INPUT_REAL_TSC)
 
+#define TPS6507X_VENDOR 0
+#define TPS6507X_PRODUCT 65070
+#define TPS6507X_VERSION 0x100
+
 struct ts_event {
 	u16	x;
 	u16	y;
@@ -199,6 +204,44 @@ done:
 	tps6507x_adc_standby(tsc);
 }
 
+static struct tps6507x_board *tps6507x_ts_parse_dt_reg_data(
+		struct platform_device *pdev) {
+	struct tps6507x_board *tps_board;
+	struct device_node *np = pdev->dev.parent->of_node;
+	struct touchscreen_init_data *reg_data;
+	struct device_node *touchscreen;
+	u32 min_pressure;
+
+	tps_board = devm_kzalloc(&pdev->dev, sizeof(*tps_board),
+				GFP_KERNEL);
+	if (!tps_board)
+		return NULL;
+
+	touchscreen = of_get_child_by_name(np, "touchscreen");
+	if (!touchscreen) {
+		dev_err(&pdev->dev, "touchscreen node not found\n");
+		return NULL;
+	}
+
+	reg_data = devm_kzalloc(&pdev->dev, sizeof(struct touchscreen_init_data),
+				GFP_KERNEL);
+	if (!reg_data)
+		return NULL;
+
+	reg_data->poll_period = TSC_DEFAULT_POLL_PERIOD;
+	reg_data->vendor = TPS6507X_VENDOR;
+	reg_data->product = TPS6507X_PRODUCT;
+	reg_data->version = TPS6507X_VERSION;
+	if (!of_property_read_u32(touchscreen, "ti,min-pressure",
+				&min_pressure))
+		reg_data->min_pressure = min_pressure;
+	else
+		reg_data->min_pressure = TPS_DEFAULT_MIN_PRESSURE;
+	tps_board->tps6507x_ts_init_data = reg_data;
+
+	return tps_board;
+}
+
 static int tps6507x_ts_probe(struct platform_device *pdev)
 {
 	struct tps6507x_dev *tps6507x_dev = dev_get_drvdata(pdev->dev.parent);
@@ -214,10 +257,10 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 	 * coming from the board-evm file.
 	 */
 	tps_board = dev_get_platdata(tps6507x_dev->dev);
-	if (!tps_board) {
-		dev_err(tps6507x_dev->dev,
-			"Could not find tps6507x platform data\n");
-		return -ENODEV;
+
+	if (IS_ENABLED(CONFIG_OF) && !tps_board &&
+			tps6507x_dev->dev->of_node) {
+		tps_board = tps6507x_ts_parse_dt_reg_data(pdev);
 	}
 
 	/*
-- 
1.7.9.5
