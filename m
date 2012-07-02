From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: [PATCH 3/6] input/spear_keyboard: use correct io accessors
Date: Mon, 2 Jul 2012 12:20:11 +0530
Message-ID: <1341211814-15173-3-git-send-email-shiraz.hashim@st.com>
References: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog114.obsmtp.com ([207.126.144.137]:48506 "EHLO
	eu1sys200aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176Ab2GBGuh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Jul 2012 02:50:37 -0400
In-Reply-To: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: spear-devel@list.st.com, linux-input@vger.kernel.org, Shiraz Hashim <shiraz.hashim@st.com>

All SPEAr keyboard registers are 32 bit wide and are word aligned. This
patch aligns all io access to be word size using relaxed version of
readl/writel.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 drivers/input/keyboard/spear-keyboard.c |   30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index ef147f3..36c145a 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -27,9 +27,9 @@
 #include <plat/keyboard.h>
 
 /* Keyboard Registers */
-#define MODE_REG	0x00	/* 16 bit reg */
-#define STATUS_REG	0x0C	/* 2 bit reg */
-#define DATA_REG	0x10	/* 8 bit reg */
+#define MODE_REG	0x00
+#define STATUS_REG	0x0C
+#define DATA_REG	0x10
 #define INTR_MASK	0x54
 
 /* Register Values */
@@ -73,9 +73,9 @@ static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
 	struct spear_kbd *kbd = dev_id;
 	struct input_dev *input = kbd->input;
 	unsigned int key;
-	u8 sts, val;
+	u32 sts, val;
 
-	sts = readb(kbd->io_base + STATUS_REG);
+	sts = readl_relaxed(kbd->io_base + STATUS_REG);
 	if (!(sts & DATA_AVAIL))
 		return IRQ_NONE;
 
@@ -85,7 +85,7 @@ static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
 	}
 
 	/* following reads active (row, col) pair */
-	val = readb(kbd->io_base + DATA_REG);
+	val = readl_relaxed(kbd->io_base + DATA_REG);
 	key = kbd->keycodes[val];
 
 	input_event(input, EV_MSC, MSC_SCAN, val);
@@ -95,7 +95,7 @@ static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
 	kbd->last_key = key;
 
 	/* clear interrupt */
-	writeb(0, kbd->io_base + STATUS_REG);
+	writel_relaxed(0, kbd->io_base + STATUS_REG);
 
 	return IRQ_HANDLED;
 }
@@ -104,7 +104,7 @@ static int spear_kbd_open(struct input_dev *dev)
 {
 	struct spear_kbd *kbd = input_get_drvdata(dev);
 	int error;
-	u16 val;
+	u32 val;
 
 	kbd->last_key = KEY_RESERVED;
 
@@ -115,13 +115,13 @@ static int spear_kbd_open(struct input_dev *dev)
 	/* program keyboard */
 	val = SCAN_RATE_80 | MODE_KEYBOARD | PCLK_FREQ_MSK |
 		(kbd->mode << KEY_MATRIX_SHIFT);
-	writew(val, kbd->io_base + MODE_REG);
-	writeb(1, kbd->io_base + STATUS_REG);
+	writel_relaxed(val, kbd->io_base + MODE_REG);
+	writel_relaxed(1, kbd->io_base + STATUS_REG);
 
 	/* start key scan */
-	val = readw(kbd->io_base + MODE_REG);
+	val = readl_relaxed(kbd->io_base + MODE_REG);
 	val |= START_SCAN;
-	writew(val, kbd->io_base + MODE_REG);
+	writel_relaxed(val, kbd->io_base + MODE_REG);
 
 	return 0;
 }
@@ -129,12 +129,12 @@ static int spear_kbd_open(struct input_dev *dev)
 static void spear_kbd_close(struct input_dev *dev)
 {
 	struct spear_kbd *kbd = input_get_drvdata(dev);
-	u16 val;
+	u32 val;
 
 	/* stop key scan */
-	val = readw(kbd->io_base + MODE_REG);
+	val = readl_relaxed(kbd->io_base + MODE_REG);
 	val &= ~START_SCAN;
-	writew(val, kbd->io_base + MODE_REG);
+	writel_relaxed(val, kbd->io_base + MODE_REG);
 
 	clk_disable(kbd->clk);
 
-- 
1.7.10

