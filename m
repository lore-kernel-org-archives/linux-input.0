From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: [PATCH 4/6] input/spear_keyboard: rename bit definitions to reflect register
Date: Mon, 2 Jul 2012 12:20:12 +0530
Message-ID: <1341211814-15173-4-git-send-email-shiraz.hashim@st.com>
References: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog113.obsmtp.com ([207.126.144.135]:53965 "EHLO
	eu1sys200aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176Ab2GBGuk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Jul 2012 02:50:40 -0400
In-Reply-To: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: spear-devel@list.st.com, linux-input@vger.kernel.org, Shiraz Hashim <shiraz.hashim@st.com>

Rename bit definition macros to reflect keyboard registers clearly thus
being more readable.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 drivers/input/keyboard/spear-keyboard.c |   52 ++++++++++++++++---------------
 1 file changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index 36c145a..70f43c2 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -27,7 +27,7 @@
 #include <plat/keyboard.h>
 
 /* Keyboard Registers */
-#define MODE_REG	0x00
+#define MODE_CTL_REG	0x00
 #define STATUS_REG	0x0C
 #define DATA_REG	0x10
 #define INTR_MASK	0x54
@@ -38,22 +38,23 @@
  * control register as 1010010(82MHZ)
  */
 #define PCLK_FREQ_MSK	0xA400	/* 82 MHz */
-#define START_SCAN	0x0100
-#define SCAN_RATE_10	0x0000
-#define SCAN_RATE_20	0x0004
-#define SCAN_RATE_40	0x0008
-#define SCAN_RATE_80	0x000C
-#define MODE_KEYBOARD	0x0002
-#define DATA_AVAIL	0x2
-
-#define KEY_MASK	0xFF000000
-#define KEY_VALUE	0x00FFFFFF
-#define ROW_MASK	0xF0
-#define COLUMN_MASK	0x0F
 #define NUM_ROWS	16
 #define NUM_COLS	16
 
-#define KEY_MATRIX_SHIFT	6
+#define MODE_CTL_KEYBOARD	(0x2 << 0)
+#define MODE_CTL_SCAN_RATE_10	(0x0 << 2)
+#define MODE_CTL_SCAN_RATE_20	(0x1 << 2)
+#define MODE_CTL_SCAN_RATE_40	(0x2 << 2)
+#define MODE_CTL_SCAN_RATE_80	(0x3 << 2)
+#define MODE_CTL_KEYNUM_SHIFT	6
+#define MODE_CTL_START_SCAN	(0x1 << 8)
+
+#define STATUS_DATA_AVAIL	(0x1 << 1)
+
+#define DATA_ROW_MASK		0xF0
+#define DATA_COLUMN_MASK	0x0F
+
+#define ROW_SHIFT		4
 
 struct spear_kbd {
 	struct input_dev *input;
@@ -76,7 +77,7 @@ static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
 	u32 sts, val;
 
 	sts = readl_relaxed(kbd->io_base + STATUS_REG);
-	if (!(sts & DATA_AVAIL))
+	if (!(sts & STATUS_DATA_AVAIL))
 		return IRQ_NONE;
 
 	if (kbd->last_key != KEY_RESERVED) {
@@ -85,7 +86,8 @@ static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
 	}
 
 	/* following reads active (row, col) pair */
-	val = readl_relaxed(kbd->io_base + DATA_REG);
+	val = readl_relaxed(kbd->io_base + DATA_REG) &
+		(DATA_ROW_MASK | DATA_COLUMN_MASK);
 	key = kbd->keycodes[val];
 
 	input_event(input, EV_MSC, MSC_SCAN, val);
@@ -113,15 +115,15 @@ static int spear_kbd_open(struct input_dev *dev)
 		return error;
 
 	/* program keyboard */
-	val = SCAN_RATE_80 | MODE_KEYBOARD | PCLK_FREQ_MSK |
-		(kbd->mode << KEY_MATRIX_SHIFT);
-	writel_relaxed(val, kbd->io_base + MODE_REG);
+	val = MODE_CTL_SCAN_RATE_80 | MODE_CTL_KEYBOARD | PCLK_FREQ_MSK |
+		(kbd->mode << MODE_CTL_KEYNUM_SHIFT);
+	writel_relaxed(val, kbd->io_base + MODE_CTL_REG);
 	writel_relaxed(1, kbd->io_base + STATUS_REG);
 
 	/* start key scan */
-	val = readl_relaxed(kbd->io_base + MODE_REG);
-	val |= START_SCAN;
-	writel_relaxed(val, kbd->io_base + MODE_REG);
+	val = readl_relaxed(kbd->io_base + MODE_CTL_REG);
+	val |= MODE_CTL_START_SCAN;
+	writel_relaxed(val, kbd->io_base + MODE_CTL_REG);
 
 	return 0;
 }
@@ -132,9 +134,9 @@ static void spear_kbd_close(struct input_dev *dev)
 	u32 val;
 
 	/* stop key scan */
-	val = readl_relaxed(kbd->io_base + MODE_REG);
-	val &= ~START_SCAN;
-	writel_relaxed(val, kbd->io_base + MODE_REG);
+	val = readl_relaxed(kbd->io_base + MODE_CTL_REG);
+	val &= ~MODE_CTL_START_SCAN;
+	writel_relaxed(val, kbd->io_base + MODE_CTL_REG);
 
 	clk_disable(kbd->clk);
 
-- 
1.7.10

