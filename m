From: Vladimir Zapolskiy <vz@mleia.com>
Subject: [PATCH 3/3] ARM: dts: lpc32xx: reparent keypad controller to SIC1
Date: Sat, 26 Jan 2019 16:29:21 +0200
Message-ID: <20190126142921.16041-4-vz@mleia.com>
References: <20190126142921.16041-1-vz@mleia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190126142921.16041-1-vz@mleia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sylvain Lemieux <slemieux.tyco@gmail.com>
List-Id: linux-input@vger.kernel.org

After switching to a new interrupt controller scheme by separating SIC1
and SIC2 from MIC interrupt controller just one SoC keypad controller
was not taken into account, fix it now:

  WARNING: CPU: 0 PID: 1 at kernel/irq/irqdomain.c:524 irq_domain_associate+0x50/0x1b0
  error: hwirq 0x36 is too large for interrupt-controller@40008000
  ...
  lpc32xx_keys 40050000.key: failed to get platform irq
  lpc32xx_keys: probe of 40050000.key failed with error -22

Fixes: 9b8ad3fb81ae ("ARM: dts: lpc32xx: reparent SIC1 and SIC2 interrupts from MIC")
Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
---
 arch/arm/boot/dts/lpc32xx.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/lpc32xx.dtsi b/arch/arm/boot/dts/lpc32xx.dtsi
index d4368eeff1b9..4f8f671c3343 100644
--- a/arch/arm/boot/dts/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/lpc32xx.dtsi
@@ -463,7 +463,8 @@
 				compatible = "nxp,lpc3220-key";
 				reg = <0x40050000 0x1000>;
 				clocks = <&clk LPC32XX_CLK_KEY>;
-				interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+				interrupt-parent = <&sic1>;
+				interrupts = <22 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
 
-- 
2.20.1
