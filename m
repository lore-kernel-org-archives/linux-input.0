From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH v4 3/3] ARM: dts: use syscon in cygnus touchscreen dt node
Date: Sat, 27 Feb 2016 12:29:56 +0530
Message-ID: <1456556396-4759-4-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1456556396-4759-1-git-send-email-raveendra.padasalagi@broadcom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 5520-maca-inet1-outside.broadcom.com ([216.31.211.11]:35773
	"EHLO mail-irv-18.broadcom.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756174AbcB0HAZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 27 Feb 2016 02:00:25 -0500
In-Reply-To: <1456556396-4759-1-git-send-email-raveendra.padasalagi@broadcom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Jonathan Richardson <jonathar@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Anup Patel <anup.patel@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>

In Cygnus SOC touch screen controller registers are shared
with ADC and flex timer. Using readl/writel could lead to
race condition. So touchscreen driver is enhanced to support
syscon based register access to take care of mutually exclusive
access.

This patch enables syscon support in touchscreen driver
by adding necessary properties in touchscreen dt node and
in addition to this renamed existing "tsc" touchscreen node
name to "touchscreen".

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 3878793..b42fe55 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -351,9 +351,16 @@
 					<&pinctrl 142 10 1>;
 		};
 
-		touchscreen: tsc@180a6000 {
+		ts_adc_syscon: ts_adc_syscon@180a6000 {
+			compatible = "brcm,iproc-ts-adc-syscon", "syscon";
+			reg = <0x180a6000 0xc30>;
+		};
+
+		touchscreen: touchscreen@180a6000 {
 			compatible = "brcm,iproc-touchscreen";
-			reg = <0x180a6000 0x40>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ts_syscon = <&ts_adc_syscon>;
 			clocks = <&asiu_clks BCM_CYGNUS_ASIU_ADC_CLK>;
 			clock-names = "tsc_clk";
 			interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1

