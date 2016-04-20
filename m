From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 02/14] ARM: dts: omap5-board-common: DT spelling s/interrupt-name/interrupt-names/
Date: Wed, 20 Apr 2016 17:32:07 +0200
Message-ID: <1461166339-11109-3-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pci-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>, Tony Lindgren <tony@atomide.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Joe Perches <joe@perches.com>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-input@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/omap5-board-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5-board-common.dtsi b/arch/arm/boot/dts/omap5-board-common.dtsi
index 902657d6713b073d..cdd144acbd3fbb53 100644
--- a/arch/arm/boot/dts/omap5-board-common.dtsi
+++ b/arch/arm/boot/dts/omap5-board-common.dtsi
@@ -395,7 +395,7 @@
 			compatible = "ti,palmas-pmic";
 			interrupt-parent = <&palmas>;
 			interrupts = <14 IRQ_TYPE_NONE>;
-			interrupt-name = "short-irq";
+			interrupt-names = "short-irq";
 
 			ti,ldo6-vibrator;
 
-- 
1.9.1
