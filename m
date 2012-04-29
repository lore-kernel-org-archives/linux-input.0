From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v3 2/2] ARM: LPC32xx: Make platform use key driver
Date: Sun, 29 Apr 2012 21:28:01 +0200
Message-ID: <1335727681-17656-2-git-send-email-stigge@antcom.de>
References: <1335727681-17656-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1335727681-17656-1-git-send-email-stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, riyer-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Cc: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patch connects the lpc32xx-key driver to the LPC32xx platform (via
lpc32xx.dtsi), and more specifically to the reference board via its dts file.
The clock.c file needs to be changed to match the automatic device name to its
clock.

Signed-off-by: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>

---
Applies to v3.4-rc4 + LPC32xx DT patches

Please pick this patch for the arm-soc subsystem.

Changes since v2:
* DT: Use "keypad,num-rows", "keypad,num-columns" and "linux,keymap" properties

 arch/arm/boot/dts/lpc32xx.dtsi |    2 ++
 arch/arm/boot/dts/phy3250.dts  |    9 +++++++++
 arch/arm/mach-lpc32xx/clock.c  |    2 +-
 3 files changed, 12 insertions(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/boot/dts/lpc32xx.dtsi
+++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
@@ -285,6 +285,8 @@
 			key@40050000 {
 				compatible = "nxp,lpc3220-key";
 				reg = <0x40050000 0x1000>;
+				interrupts = <54 0>;
+				status = "disable";
 			};
 
 		};
--- linux-2.6.orig/arch/arm/boot/dts/phy3250.dts
+++ linux-2.6/arch/arm/boot/dts/phy3250.dts
@@ -124,6 +124,15 @@
 			tsc@40048000 {
 				status = "okay";
 			};
+
+			key@40050000 {
+				status = "okay";
+				keypad,num-rows = <1>;
+				keypad,num-columns = <1>;
+				nxp,debounce-delay-ms = <3>;
+				nxp,scan-delay-ms = <34>;
+				linux,keymap = <0x00000002>;
+			};
 		};
 	};
 
--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -1131,7 +1131,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_INIT("31020300.i2c", NULL, &clk_i2c2),
 	CLKDEV_INIT("dev:ssp0", NULL, &clk_ssp0),
 	CLKDEV_INIT("dev:ssp1", NULL, &clk_ssp1),
-	CLKDEV_INIT("lpc32xx_keys.0", NULL, &clk_kscan),
+	CLKDEV_INIT("40050000.key", NULL, &clk_kscan),
 	CLKDEV_INIT("lpc32xx-nand.0", "nand_ck", &clk_nand),
 	CLKDEV_INIT("200b0000.flash", "nand_ck_mlc", &clk_nand_mlc),
 	CLKDEV_INIT("40048000.adc", NULL, &clk_adc),
