From: Haibo Chen <haibo.chen@freescale.com>
Subject: [PATCH 2/5] Documentation: Detail permitted DT properties for the imx6ul_tsc
Date: Mon, 27 Jul 2015 19:26:44 +0800
Message-ID: <1437996407-27266-3-git-send-email-haibo.chen@freescale.com>
References: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bn1bon0146.outbound.protection.outlook.com ([157.56.111.146]:42592
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752235AbbG0LYI (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Jul 2015 07:24:08 -0400
In-Reply-To: <1437996407-27266-1-git-send-email-haibo.chen@freescale.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, shawnguo@kernel.org, kernel@pengutronix.de, linux@arm.linux.org.uk, dmitry.torokhov@gmail.com
Cc: haibo.chen@freescale.com, hans.verkuil@cisco.com, hadess@hadess.net, mchehab@osg.samsung.com, mamlinav@gmail.com, arnd@arndb.de, jonathar@broadcom.com, hdegoede@redhat.com, christian.gmeiner@gmail.com, scott.liu@emc.com.tw, geert@linux-m68k.org, benjamin.tissoires@redhat.com, sebastien.szymanski@armadeus.com, sbranden@broadcom.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

Here we apply required documentation for the imx6ul touch screen
controller driver which describe available properties and how to
use them.

Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
---
 .../devicetree/bindings/input/touchscreen/imx6ul_tsc.txt   | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
new file mode 100644
index 0000000..e34d752
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/imx6ul_tsc.txt
@@ -0,0 +1,14 @@
+* Freescale i.MX6UL Touch Controller
+
+Required properties:
+- compatible: must be "fsl,imx6ul-tsc"
+
+Example:
+	&tsc {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_tsc>;
+		status = "okay";
+		xnur-gpio = <&gpio1 3 GPIO_ACTIVE_HIGH>;
+		measure_delay_time = <0xfff>;
+		pre_charge_time = <0xffff>;
+	};
-- 
1.9.1

