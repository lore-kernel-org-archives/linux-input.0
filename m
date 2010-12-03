From: Sundar Iyer <sundar.iyer@stericsson.com>
Subject: [PATCH 18/20] mach-ux500: explicit enable MTU TCR in the kernel
Date: Fri, 3 Dec 2010 20:35:51 +0530
Message-ID: <1291388753-14662-19-git-send-email-sundar.iyer@stericsson.com>
References: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1291388753-14662-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, dmitry.torokhov@gmail.com, sameo@linux.intel.com, ben-linux@fluff.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Sundar Iyer <sundar.iyer@stericsson.com>
List-Id: linux-input@vger.kernel.org

PRCM_TCR enables the various timers in the system. This must be achieved
before any of the MTUs are usable for kernel usage. Explicit enabling of
this in the kernel makes it independent of bootloader actions.

Signed-off-by: Sundar Iyer <sundar.iyer@stericsson.com>
---
 arch/arm/mach-ux500/clock.c |   49 ++++++++-----------------------------------
 1 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-ux500/clock.c b/arch/arm/mach-ux500/clock.c
index 531de5c..6657b05 100644
--- a/arch/arm/mach-ux500/clock.c
+++ b/arch/arm/mach-ux500/clock.c
@@ -132,7 +132,7 @@ static unsigned long clk_mtu_get_rate(struct clk *clk)
 {
 	void __iomem *addr = __io_address(UX500_PRCMU_BASE)
 		+ PRCM_TCR;
-	u32 tcr = readl(addr);
+	u32 tcr;
 	int mtu = (int) clk->data;
 	/*
 	 * One of these is selected eventually
@@ -143,6 +143,14 @@ static unsigned long clk_mtu_get_rate(struct clk *clk)
 	unsigned long mturate;
 	unsigned long retclk;
 
+	/*
+	 * On a startup, always conifgure the TCR to the doze mode;
+	 * bootloaders do it for us. Do this in the kernel too.
+	 */
+	writel(PRCM_TCR_DOZE_MODE, addr);
+
+	tcr = readl(addr);
+
 	/* Get the rate from the parent as a default */
 	if (clk->parent_periph)
 		mturate = clk_get_rate(clk->parent_periph);
@@ -152,45 +160,6 @@ static unsigned long clk_mtu_get_rate(struct clk *clk)
 		/* We need to be connected SOMEWHERE */
 		BUG();
 
-	/*
-	 * Are we in doze mode?
-	 * In this mode the parent peripheral or the fixed 32768 Hz
-	 * clock is fed into the block.
-	 */
-	if (!(tcr & PRCM_TCR_DOZE_MODE)) {
-		/*
-		 * Here we're using the clock input from the APE ULP
-		 * clock domain. But first: are the timers stopped?
-		 */
-		if (tcr & PRCM_TCR_STOPPED) {
-			clk32k = 0;
-			mturate = 0;
-		} else {
-			/* Else default mode: 0 and 2.4 MHz */
-			clk32k = 0;
-			if (cpu_is_u5500())
-				/* DB5500 divides by 8 */
-				mturate /= 8;
-			else if (cpu_is_u8500ed()) {
-				/*
-				 * This clocking setting must not be used
-				 * in the ED chip, it is simply not
-				 * connected anywhere!
-				 */
-				mturate = 0;
-				BUG();
-			} else
-				/*
-				 * In this mode the ulp38m4 clock is divided
-				 * by a factor 16, on the DB8500 typically
-				 * 38400000 / 16 ~ 2.4 MHz.
-				 * TODO: Replace the constant with a reference
-				 * to the ULP source once this is modeled.
-				 */
-				mturate = 38400000 / 16;
-		}
-	}
-
 	/* Return the clock selected for this MTU */
 	if (tcr & (1 << mtu))
 		retclk = clk32k;
-- 
1.7.2.dirty
