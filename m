From: Jianhong Chen <chenjh@rock-chips.com>
Subject: [PATCH v6 07/12] mfd: dt-bindings: Add RK805 device tree bindings document
Date: Thu,  8 Jun 2017 15:28:49 +0800
Message-ID: <1496906929-5897-1-git-send-email-chenjh@rock-chips.com>
References: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.132]:58512 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751563AbdFHHae (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 03:30:34 -0400
In-Reply-To: <1496905959-29202-1-git-send-email-chenjh@rock-chips.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gnurou@gmail.com, linus.walleij@linaro.org, dmitry.torokhov@gmail.com
Cc: linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, huangtao@rock-chips.com, tony.xie@rock-chips.com, zhangqing@rock-chips.com, devicetree@vger.kernel.org, w.egorov@phytec.de, lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

Add device tree bindings documentation for Rockchip's RK805 PMIC.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
---
 Documentation/devicetree/bindings/mfd/rk808.txt | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
index 9636ae8..91b6522 100644
--- a/Documentation/devicetree/bindings/mfd/rk808.txt
+++ b/Documentation/devicetree/bindings/mfd/rk808.txt
@@ -1,11 +1,14 @@
 RK8XX Power Management Integrated Circuit
 
 The rk8xx family current members:
+rk805
 rk808
 rk818
 
 Required properties:
-- compatible: "rockchip,rk808", "rockchip,rk818"
+- compatible: "rockchip,rk805"
+- compatible: "rockchip,rk808"
+- compatible: "rockchip,rk818"
 - reg: I2C slave address
 - interrupt-parent: The parent interrupt controller.
 - interrupts: the interrupt outputs of the controller.
@@ -18,6 +21,14 @@ Optional properties:
 - rockchip,system-power-controller: Telling whether or not this pmic is controlling
   the system power.
 
+Optional RK805 properties:
+- vcc1-supply:  The input supply for DCDC_REG1
+- vcc2-supply:  The input supply for DCDC_REG2
+- vcc3-supply:  The input supply for DCDC_REG3
+- vcc4-supply:  The input supply for DCDC_REG4
+- vcc5-supply:  The input supply for LDO_REG1 and LDO_REG2
+- vcc6-supply:  The input supply for LDO_REG3
+
 Optional RK808 properties:
 - vcc1-supply:  The input supply for DCDC_REG1
 - vcc2-supply:  The input supply for DCDC_REG2
@@ -56,6 +67,15 @@ by a child node of the 'regulators' node.
 		/* standard regulator bindings here */
 	};
 
+Following regulators of the RK805 PMIC regulators are supported. Note that
+the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
+number as described in RK805 datasheet.
+
+	- DCDC_REGn
+		- valid values for n are 1 to 4.
+	- LDO_REGn
+		- valid values for n are 1 to 3
+
 Following regulators of the RK808 PMIC block are supported. Note that
 the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
 number as described in RK808 datasheet.
-- 
1.9.1


