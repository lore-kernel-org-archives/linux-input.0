From: Luotao Fu <l.fu@pengutronix.de>
Subject: [PATCH 5/6] mfd/stmpexxx: fix stmpe811 enable hook
Date: Thu, 24 Jun 2010 13:13:40 +0200
Message-ID: <1277378021-16802-6-git-send-email-l.fu@pengutronix.de>
References: <20100622135635.GA30720@bnru02.bnr.st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100622135635.GA30720@bnru02.bnr.st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rabin VINCENT <rabin.vincent@stericsson.com>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus WALLEIJ <linus.walleij@stericsson.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, Luotao Fu <l.fu@pengutronix.de>
List-Id: linux-input@vger.kernel.org

Fix the stmpe811 enable hook so that we can activate the needed clocks for the
touchscreen controller.

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
---
 drivers/mfd/stmpe-devices.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/stmpe-devices.c b/drivers/mfd/stmpe-devices.c
index 3e21c26..25941ea 100644
--- a/drivers/mfd/stmpe-devices.c
+++ b/drivers/mfd/stmpe-devices.c
@@ -117,8 +117,9 @@ static int stmpe811_enable(struct stmpe *stmpe, unsigned int blocks,
 	if (blocks & STMPE_BLOCK_ADC)
 		mask |= STMPE811_SYS_CTRL2_ADC_OFF;
 
-	if (blocks & STMPE_BLOCK_KEYPAD)
-		mask |= STMPE811_SYS_CTRL2_TSC_OFF;
+	if (blocks & STMPE_BLOCK_TOUCHSCREEN)
+		mask |= STMPE811_SYS_CTRL2_ADC_OFF
+			| STMPE811_SYS_CTRL2_TSC_OFF;
 
 	return stmpe_set_bits(stmpe, STMPE811_REG_SYS_CTRL2, mask,
 			      enable ? 0 : mask);
-- 
1.7.1
