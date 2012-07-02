From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: [PATCH 5/6] input/spear_keyboard: generalize keyboard frequency configuration
Date: Mon, 2 Jul 2012 12:20:13 +0530
Message-ID: <1341211814-15173-5-git-send-email-shiraz.hashim@st.com>
References: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:57108 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176Ab2GBGuo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Jul 2012 02:50:44 -0400
In-Reply-To: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: spear-devel@list.st.com, linux-input@vger.kernel.org, Shiraz Hashim <shiraz.hashim@st.com>

Current implementation hard coded keyboard frequency configuration
assuming input clock as fixed APB (83 MHz). Generalize the configuration
using clock framework APIs.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 drivers/input/keyboard/spear-keyboard.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 70f43c2..ae1132e 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -33,13 +33,10 @@
 #define INTR_MASK	0x54
 
 /* Register Values */
-/*
- * pclk freq mask = (APB FEQ -1)= 82 MHZ.Programme bit 15-9 in mode
- * control register as 1010010(82MHZ)
- */
-#define PCLK_FREQ_MSK	0xA400	/* 82 MHz */
 #define NUM_ROWS	16
 #define NUM_COLS	16
+#define MODE_CTL_PCLK_FREQ_SHIFT	9
+#define MODE_CTL_PCLK_FREQ_MSK		0x7F
 
 #define MODE_CTL_KEYBOARD	(0x2 << 0)
 #define MODE_CTL_SCAN_RATE_10	(0x0 << 2)
@@ -114,8 +111,12 @@ static int spear_kbd_open(struct input_dev *dev)
 	if (error)
 		return error;
 
+	/* keyboard rate to be programmed is input clock (in MHz) - 1 */
+	val = clk_get_rate(kbd->clk) / 1000000 - 1;
+	val = (val & MODE_CTL_PCLK_FREQ_MSK) << MODE_CTL_PCLK_FREQ_SHIFT;
+
 	/* program keyboard */
-	val = MODE_CTL_SCAN_RATE_80 | MODE_CTL_KEYBOARD | PCLK_FREQ_MSK |
+	val = MODE_CTL_SCAN_RATE_80 | MODE_CTL_KEYBOARD | val |
 		(kbd->mode << MODE_CTL_KEYNUM_SHIFT);
 	writel_relaxed(val, kbd->io_base + MODE_CTL_REG);
 	writel_relaxed(1, kbd->io_base + STATUS_REG);
-- 
1.7.10

