From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 3/3] omap3evm: Configure GPIO175 for touchscreen PEN_IRQ
Date: Fri,  5 Feb 2010 14:14:12 +0530
Message-ID: <1265359452-18718-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-input@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>
List-Id: linux-input@vger.kernel.org

GPIO175 is used for PEN_IRQ on the EVM. This patch
sets the mux settings for the same.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/mach-omap2/board-omap3evm.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index c8e1208..00bfe9b 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -430,7 +430,9 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP3_MUX(SYS_NIRQ, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLUP |
 				OMAP_PIN_OFF_INPUT_PULLUP |
 				OMAP_PIN_OFF_WAKEUPENABLE),
-
+	OMAP3_MUX(MCSPI1_CS1, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP |
+				OMAP_PIN_OFF_INPUT_PULLUP |
+				OMAP_PIN_OFF_WAKEUPENABLE),
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
 #else
-- 
1.6.2.2

