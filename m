From: =?UTF-8?q?Myl=C3=A8ne=20Josserand?=
        <mylene.josserand@free-electrons.com>
Subject: [PATCH 5/5] arm: dts: sun8i: a83t: a711: Add touchscreen node
Date: Fri,  8 Dec 2017 22:54:19 +0100
Message-ID: <20171208215419.30396-6-mylene.josserand@free-electrons.com>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:51836 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753504AbdLHVzD (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 8 Dec 2017 16:55:03 -0500
In-Reply-To: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, wens@csie.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Cc: simon.budig@kernelconcepts.de, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mylene.josserand@free-electrons.com, thomas.petazzoni@free-electrons.com

Tha A711 tablet has a FocalTech EDT-FT5x06 Polytouch touchscreen.
It is connected via I2C0 so add his node in i2c0's node.

The reset line is PD5, the interrupt line is PL7 and the power
supply is the ldo_io0 regulator.

Signed-off-by: Mylène Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 84cca1a48cea..738359917a34 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -110,6 +110,17 @@
 	pinctrl-0 = <&i2c0_pins>;
 	clock-frequency = <400000>;
 	status = "okay";
+
+	polytouch: edt-ft5x06@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&r_pio>;
+		interrupts = <0 7 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&pio 3 5 GPIO_ACTIVE_LOW>;
+		power-supply = <&reg_ldo_io0>;
+		touchscreen-size-x = <1024>;
+		touchscreen-size-y = <600>;
+	};
 };
 
 &mmc0 {
-- 
2.11.0

