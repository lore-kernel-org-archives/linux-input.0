From: Roland Stigge <stigge@antcom.de>
Subject: [PATCH] Input: lpc32xx_ts - fix device tree compatible string
Date: Mon, 23 Apr 2012 10:02:21 +0200
Message-ID: <1335168141-10970-1-git-send-email-stigge@antcom.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.work-microwave.de ([62.245.205.51]:43836 "EHLO
	work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752180Ab2DWIDW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 04:03:22 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, devicetree-discuss@lists.ozlabs.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Roland Stigge <stigge@antcom.de>

During the device tree integration of the various LPC32xx drivers, we agreed on
using non-wildcard "compatible" strings. This patch fixes the lpc32xx_ts
touchscreen driver to use "nxp,lpc3220-tsc".

Signed-off-by: Roland Stigge <stigge@antcom.de>
---
 .../bindings/input/touchscreen/lpc32xx-tsc.txt     |    4 ++--
 drivers/input/touchscreen/lpc32xx_ts.c             |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lpc32xx-tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/lpc32xx-tsc.txt
index d0c68e3..41cbf4b 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/lpc32xx-tsc.txt
+++ b/Documentation/devicetree/bindings/input/touchscreen/lpc32xx-tsc.txt
@@ -1,7 +1,7 @@
 * NXP LPC32xx SoC Touchscreen Controller (TSC)
 
 Required properties:
-- compatible: must be "nxp,lpc32xx-tsc"
+- compatible: must be "nxp,lpc3220-tsc"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: The TSC/ADC interrupt
@@ -9,7 +9,7 @@ Required properties:
 Example:
 
 	tsc@40048000 {
-		compatible = "nxp,lpc32xx-tsc";
+		compatible = "nxp,lpc3220-tsc";
 		reg = <0x40048000 0x1000>;
 		interrupt-parent = <&mic>;
 		interrupts = <39 0>;
diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
index e8fccbc..4c2b8ed 100644
--- a/drivers/input/touchscreen/lpc32xx_ts.c
+++ b/drivers/input/touchscreen/lpc32xx_ts.c
@@ -386,7 +386,7 @@ static const struct dev_pm_ops lpc32xx_ts_pm_ops = {
 
 #ifdef CONFIG_OF
 static struct of_device_id lpc32xx_tsc_of_match[] = {
-	{ .compatible = "nxp,lpc32xx-tsc", },
+	{ .compatible = "nxp,lpc3220-tsc", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, lpc32xx_tsc_of_match);
-- 
1.7.9

