From: Roland Stigge <stigge@antcom.de>
Subject: [PATCH v3 4/10] ARM: LPC32xx: clock.c dma adjustment
Date: Wed, 18 Apr 2012 15:36:09 +0200
Message-ID: <1334756176-25144-5-git-send-email-stigge@antcom.de>
References: <1334756176-25144-1-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <1334756176-25144-1-git-send-email-stigge@antcom.de>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
	<mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: devel-bounces@linuxdriverproject.org
To: arm@kernel.org, linux-arm-kernel@lists.infradead.org, thierry.reding@avionic-design.de, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, axel.lin@gmail.com, broonie@opensource.wolfsonmicro.com, marek.vasut@gmail.com, devel@driverdev.osuosl.org, kevin.wells@nxp.com, srinivas.bakki@nxp.com, dan.carpenter@oracle.com
Cc: Roland Stigge <stigge@antcom.de>
List-Id: linux-input@vger.kernel.org

This patch adjusts the DMA clock of the LPC32xx to "pl08xdmac" to be picked up
correctly by the AMBA dmaengine driver.

Signed-off-by: Roland Stigge <stigge@antcom.de>

---
 arch/arm/mach-lpc32xx/clock.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-2.6.orig/arch/arm/mach-lpc32xx/clock.c
+++ linux-2.6/arch/arm/mach-lpc32xx/clock.c
@@ -1109,7 +1109,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_INIT(NULL, "timer2_ck", &clk_timer2),
 	CLKDEV_INIT(NULL, "timer3_ck", &clk_timer3),
 	CLKDEV_INIT(NULL, "vfp9_ck", &clk_vfp9),
-	CLKDEV_INIT(NULL, "clk_dmac", &clk_dma),
+	CLKDEV_INIT("pl08xdmac", NULL, &clk_dma),
 	CLKDEV_INIT("pnx4008-watchdog", NULL, &clk_wdt),
 	CLKDEV_INIT(NULL, "uart3_ck", &clk_uart3),
 	CLKDEV_INIT(NULL, "uart4_ck", &clk_uart4),
