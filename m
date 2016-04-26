From: Rui Teng <rui.teng@linux.vnet.ibm.com>
Subject: [PATCH] drivers/input: Macros with complex values should be enclosed in parentheses
Date: Tue, 26 Apr 2016 10:52:50 +0800
Message-ID: <1461639170-1359-1-git-send-email-rui.teng@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Rui Teng <rui.teng@linux.vnet.ibm.com>
List-Id: linux-input@vger.kernel.org

The bitwise shift operator has lower priority than plus operator. So the values on macros
should be enclosed in parentheses.

For example, "(1 << 4 + 1)" means "(1 << (4 + 1))", but it is not expected by the macros.

And also fix other two coding style problems reported by scripts/checkpatch.pl.

Signed-off-by: Rui Teng <rui.teng@linux.vnet.ibm.com>
---
 drivers/input/keyboard/twl4030_keypad.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/twl4030_keypad.c b/drivers/input/keyboard/twl4030_keypad.c
index bbcccd6..8d061c0 100644
--- a/drivers/input/keyboard/twl4030_keypad.c
+++ b/drivers/input/keyboard/twl4030_keypad.c
@@ -61,9 +61,9 @@ struct twl4030_keypad {
 	unsigned short	keymap[TWL4030_KEYMAP_SIZE];
 	u16		kp_state[TWL4030_MAX_ROWS];
 	bool		autorepeat;
-	unsigned	n_rows;
-	unsigned	n_cols;
-	unsigned	irq;
+	unsigned int	n_rows;
+	unsigned int	n_cols;
+	unsigned int	irq;
 
 	struct device *dbg_dev;
 	struct input_dev *input;
@@ -110,7 +110,7 @@ struct twl4030_keypad {
 #define KEYP_CTRL_KBD_ON		BIT(6)
 
 /* KEYP_DEB, KEYP_LONG_KEY, KEYP_TIMEOUT_x*/
-#define KEYP_PERIOD_US(t, prescale)	((t) / (31 << (prescale + 1)) - 1)
+#define KEYP_PERIOD_US(t, prescale)	((t) / (31 << ((prescale) + 1)) - 1)
 
 /* KEYP_LK_PTV_REG Fields */
 #define KEYP_LK_PTV_PTV_SHIFT		5
@@ -263,7 +263,8 @@ static irqreturn_t do_kp_irq(int irq, void *_kp)
 	ret = twl4030_kpread(kp, &reg, KEYP_ISR1, 1);
 
 	/* Release all keys if I2C has gone bad or
-	 * the KEYP has gone to idle state */
+	 * the KEYP has gone to idle state
+	 */
 	if (ret >= 0 && (reg & KEYP_IMR1_KP))
 		twl4030_kp_scan(kp, false);
 	else
-- 
2.5.0
