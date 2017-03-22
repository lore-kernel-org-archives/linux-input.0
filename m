From: Jagan Teki <jagan@openedev.com>
Subject: [PATCH v8 3/3] ARM: dts: imx6q-icore: Add touchscreen node
Date: Thu, 23 Mar 2017 00:35:18 +0530
Message-ID: <1490209518-20790-3-git-send-email-jagan@openedev.com>
References: <1490209518-20790-1-git-send-email-jagan@openedev.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35468 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965877AbdCVTH7 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 22 Mar 2017 15:07:59 -0400
In-Reply-To: <1490209518-20790-1-git-send-email-jagan@openedev.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Jagan Teki <jagan@amarulasolutions.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Domenico Acri <domenico.acri@engicam.com>, Matteo Lisi <matteo.lisi@engicam.com>, Michael Trimarchi <michael@amarulasolutions.com>, Shawn Guo <shawnguo@kernel.org>

From: Jagan Teki <jagan@amarulasolutions.com>

max11801 touchscreen on Engicam iCoreM6 Quad module is
connected via i2c1, so add max11801: touchscreen@48 on i2c1.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Domenico Acri <domenico.acri@engicam.com>
Cc: Matteo Lisi <matteo.lisi@engicam.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
Changes for v8:
- Use IRQ_TYPE_EDGE_FALLING for interrupt trigger type. 
Changes for v7:
- add vendor prefix as maxim
Changes for v6:
- Replace the lable and name of the node
   ts: max11801 => max11801: touchscreen@48
Changes for v5:
- Newly added patch

 arch/arm/boot/dts/imx6q-icore.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-icore.dts b/arch/arm/boot/dts/imx6q-icore.dts
index 73f34d1..5613dd9 100644
--- a/arch/arm/boot/dts/imx6q-icore.dts
+++ b/arch/arm/boot/dts/imx6q-icore.dts
@@ -58,6 +58,15 @@
 	status = "okay";
 };
 
+&i2c1 {
+	max11801: touchscreen@48 {
+		compatible = "maxim,max11801";
+		reg = <0x48>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
 &ldb {
 	status = "okay";
 
-- 
1.9.1

