From: Roland Stigge <stigge@antcom.de>
Subject: [PATCH v3 6/10] input: Device tree support for LPC32xx touchscreen
Date: Wed, 18 Apr 2012 15:36:11 +0200
Message-ID: <1334756176-25144-7-git-send-email-stigge@antcom.de>
References: <1334756176-25144-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1334756176-25144-1-git-send-email-stigge@antcom.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: arm@kernel.org, linux-arm-kernel@lists.infradead.org, thierry.reding@avionic-design.de, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, axel.lin@gmail.com, broonie@opensource.wolfsonmicro.com, marek.vasut@gmail.com, devel@driverdev.osuosl.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, dan.carpenter@oracle.com
Cc: Roland Stigge <stigge@antcom.de>
List-Id: linux-input@vger.kernel.org

This patch adds device tree support for the LPC32xx SoC's touchscreen
controller.

Signed-off-by: Roland Stigge <stigge@antcom.de>
Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>

---

Applies to v3.4-rc3

 Documentation/devicetree/bindings/input/touchscreen/lpc32xx-tsc.txt |   16 ++++++++++
 drivers/input/touchscreen/lpc32xx_ts.c                              |   10 ++++++
 2 files changed, 26 insertions(+)

--- /dev/null
+++ linux-2.6/Documentation/devicetree/bindings/input/touchscreen/lpc32xx-tsc.txt
@@ -0,0 +1,16 @@
+* NXP LPC32xx SoC Touchscreen Controller (TSC)
+
+Required properties:
+- compatible: must be "nxp,lpc32xx-tsc"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: The TSC/ADC interrupt
+
+Example:
+
+	tsc@40048000 {
+		compatible = "nxp,lpc32xx-tsc";
+		reg = <0x40048000 0x1000>;
+		interrupt-parent = <&mic>;
+		interrupts = <39 0>;
+	};
--- linux-2.6.orig/drivers/input/touchscreen/lpc32xx_ts.c
+++ linux-2.6/drivers/input/touchscreen/lpc32xx_ts.c
@@ -22,6 +22,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 /*
  * Touchscreen controller register offsets
@@ -383,6 +384,14 @@ static const struct dev_pm_ops lpc32xx_t
 #define LPC32XX_TS_PM_OPS NULL
 #endif
 
+#ifdef CONFIG_OF
+static struct of_device_id lpc32xx_tsc_of_match[] = {
+	{ .compatible = "nxp,lpc32xx-tsc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, lpc32xx_tsc_of_match);
+#endif
+
 static struct platform_driver lpc32xx_ts_driver = {
 	.probe		= lpc32xx_ts_probe,
 	.remove		= __devexit_p(lpc32xx_ts_remove),
@@ -390,6 +399,7 @@ static struct platform_driver lpc32xx_ts
 		.name	= MOD_NAME,
 		.owner	= THIS_MODULE,
 		.pm	= LPC32XX_TS_PM_OPS,
+		.of_match_table = of_match_ptr(lpc32xx_tsc_of_match),
 	},
 };
 module_platform_driver(lpc32xx_ts_driver);
