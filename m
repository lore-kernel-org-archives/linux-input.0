From: <Frank.Li@freescale.com>
Subject: [PATCH 1/7] arm: imx: power-off: change to syscon to access register
Date: Fri, 15 May 2015 01:18:47 +0800
Message-ID: <1431623933-3473-2-git-send-email-Frank.Li@freescale.com>
References: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1431623933-3473-1-git-send-email-Frank.Li@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lznuaa@gmail.com, shawn.guo@linaro.org, dmitry.torokhov@gmail.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, Frank Li <Frank.Li@freescale.com>, rtc-linux@googlegroups.com, linux-pm@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

From: Frank Li <Frank.Li@freescale.com>

snvs is MFP device, which included rtc, ON/OFF key, power off

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/power/reset/imx-snvs-poweroff.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/power/reset/imx-snvs-poweroff.c b/drivers/power/reset/imx-snvs-poweroff.c
index ad6ce50..b4881d7 100644
--- a/drivers/power/reset/imx-snvs-poweroff.c
+++ b/drivers/power/reset/imx-snvs-poweroff.c
@@ -22,21 +22,30 @@
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
 
-static void __iomem *snvs_base;
+static struct regmap *snvs;
+
+#define SNVS_LPCR 0x38
 
 static void do_imx_poweroff(void)
 {
-	u32 value = readl(snvs_base);
-
 	/* set TOP and DP_EN bit */
-	writel(value | 0x60, snvs_base);
+	regmap_update_bits(snvs, SNVS_LPCR, 0x60, 0x60);
 }
 
 static int imx_poweroff_probe(struct platform_device *pdev)
 {
-	snvs_base = of_iomap(pdev->dev.of_node, 0);
-	if (!snvs_base) {
+	struct device_node *nd;
+
+	nd = of_get_parent(pdev->dev.of_node);
+	if (!nd)
+		return -ENODEV;
+	snvs = syscon_node_to_regmap (nd);
+	of_node_put(nd);
+
+	if (!snvs) {
 		dev_err(&pdev->dev, "failed to get memory\n");
 		return -ENODEV;
 	}
-- 
1.9.1
