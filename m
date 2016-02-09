From: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Subject: [PATCH 3/3] ARM: dts: use syscon in cygnus touchscreen dt node
Date: Tue,  9 Feb 2016 14:27:57 +0530
Message-ID: <1455008277-8312-4-git-send-email-raveendra.padasalagi@broadcom.com>
References: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1455008277-8312-1-git-send-email-raveendra.padasalagi@broadcom.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>, linux-kernel@vger.kernel.org, Jonathan Richardson <jonathar@broadcom.com>, Rob Herring <robh+dt@kernel.org>, bcm-kernel-feedback-list@broadcom.com, Kumar Gala <galak@codeaurora.org>
List-Id: linux-input@vger.kernel.org

In cygnus touch screen controller registers are shared with ADC
and flex timer. Using readl/writel could lead to race condition.
In such cases we need to support register access using syscon
framework based API's. So Added dt changes to use syscon.

Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 3878793..9190224 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -351,9 +351,16 @@
 					<&pinctrl 142 10 1>;
 		};
 
+		ts_adc_syscon: ts_adc_syscon@0x180a6000 {
+			compatible = "syscon";
+			reg = <0x180a6000 0xc30>;
+		};
+
 		touchscreen: tsc@180a6000 {
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
