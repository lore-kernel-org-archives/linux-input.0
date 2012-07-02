From: Shiraz Hashim <shiraz.hashim@st.com>
Subject: [PATCH 6/6] input/spear_keyboard: reconfigure operating frequency on suspend
Date: Mon, 2 Jul 2012 12:20:14 +0530
Message-ID: <1341211814-15173-6-git-send-email-shiraz.hashim@st.com>
References: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:41801 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752176Ab2GBGut (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Jul 2012 02:50:49 -0400
In-Reply-To: <1341211814-15173-1-git-send-email-shiraz.hashim@st.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: spear-devel@list.st.com, linux-input@vger.kernel.org, Shiraz Hashim <shiraz.hashim@st.com>

On some platform it may happen that the input clock to keyboard may
change thus impacting its wakeup capability.

There is no means for keyboard driver to know this frequency before
hand. Hence introduce a platform data 'suspended_rate' which indicates
the frequency during suspend at which keyboard operates.

Accordingly reprogram keyboard while going into suspend and restore
original configuration at the time of resume.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
---
 arch/arm/plat-spear/include/plat/keyboard.h |    2 ++
 drivers/input/keyboard/spear-keyboard.c     |   44 +++++++++++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-spear/include/plat/keyboard.h b/arch/arm/plat-spear/include/plat/keyboard.h
index 0562f13..9248e3a 100644
--- a/arch/arm/plat-spear/include/plat/keyboard.h
+++ b/arch/arm/plat-spear/include/plat/keyboard.h
@@ -149,6 +149,7 @@ int _name[] = { \
  * keymap: pointer to keymap data (table and size)
  * rep: enables key autorepeat
  * mode: choose keyboard support(9x9, 6x6, 2x2)
+ * suspended_rate: rate at which keyboard would operate in suspended mode
  *
  * This structure is supposed to be used by platform code to supply
  * keymaps to drivers that implement keyboards.
@@ -157,6 +158,7 @@ struct kbd_platform_data {
 	const struct matrix_keymap_data *keymap;
 	bool rep;
 	unsigned int mode;
+	unsigned int suspended_rate;
 };
 
 #endif /* __PLAT_KEYBOARD_H */
diff --git a/drivers/input/keyboard/spear-keyboard.c b/drivers/input/keyboard/spear-keyboard.c
index ae1132e..9333a35 100644
--- a/drivers/input/keyboard/spear-keyboard.c
+++ b/drivers/input/keyboard/spear-keyboard.c
@@ -64,6 +64,8 @@ struct spear_kbd {
 	unsigned short last_key;
 	unsigned short keycodes[NUM_ROWS * NUM_COLS];
 	bool rep;
+	unsigned int suspended_rate;
+	u32 mode_ctl_reg;
 };
 
 static irqreturn_t spear_kbd_interrupt(int irq, void *dev_id)
@@ -150,7 +152,7 @@ static int __devinit spear_kbd_parse_dt(struct platform_device *pdev,
 {
 	struct device_node *np = pdev->dev.of_node;
 	int error;
-	u32 val;
+	u32 val, suspended_rate;
 
 	if (!np) {
 		dev_err(&pdev->dev, "Missing DT data\n");
@@ -160,6 +162,9 @@ static int __devinit spear_kbd_parse_dt(struct platform_device *pdev,
 	if (of_property_read_bool(np, "autorepeat"))
 		kbd->rep = true;
 
+	if (of_property_read_u32(np, "suspended_rate", &suspended_rate))
+		kbd->suspended_rate = suspended_rate;
+
 	error = of_property_read_u32(np, "st,mode", &val);
 	if (error) {
 		dev_err(&pdev->dev, "DT: Invalid or missing mode\n");
@@ -217,6 +222,7 @@ static int __devinit spear_kbd_probe(struct platform_device *pdev)
 	} else {
 		kbd->mode = pdata->mode;
 		kbd->rep = pdata->rep;
+		kbd->suspended_rate = pdata->suspended_rate;
 	}
 
 	kbd->res = request_mem_region(res->start, resource_size(res),
@@ -318,17 +324,47 @@ static int spear_kbd_suspend(struct device *dev)
 	struct platform_device *pdev = to_platform_device(dev);
 	struct spear_kbd *kbd = platform_get_drvdata(pdev);
 	struct input_dev *input_dev = kbd->input;
+	unsigned int rate = 0, mode_ctl_reg, val;
 
 	mutex_lock(&input_dev->mutex);
 
+	/* explicitly enable clock as we may program device */
+	clk_enable(kbd->clk);
+
+	mode_ctl_reg = readl_relaxed(kbd->io_base + MODE_CTL_REG);
+
 	if (device_may_wakeup(&pdev->dev)) {
 		if (!enable_irq_wake(kbd->irq))
 			kbd->irq_wake = 1;
+
+		/*
+		 * reprogram the keyboard operating frequency as on some
+		 * platform it may change during system suspended
+		 */
+		if (kbd->suspended_rate)
+			rate = kbd->suspended_rate / 1000000 - 1;
+
+		val = mode_ctl_reg &
+			~(MODE_CTL_PCLK_FREQ_MSK << MODE_CTL_PCLK_FREQ_SHIFT);
+		val |= (rate & MODE_CTL_PCLK_FREQ_MSK)
+			<< MODE_CTL_PCLK_FREQ_SHIFT;
+		writel_relaxed(val, kbd->io_base + MODE_CTL_REG);
+
 	} else {
-		if (input_dev->users)
+		if (input_dev->users) {
+			writel_relaxed(mode_ctl_reg & ~MODE_CTL_START_SCAN,
+					kbd->io_base + MODE_CTL_REG);
 			clk_disable(kbd->clk);
+		}
 	}
 
+	/* store current configuration */
+	if (input_dev->users)
+		kbd->mode_ctl_reg = mode_ctl_reg;
+
+	/* restore previous clk state */
+	clk_disable(kbd->clk);
+
 	mutex_unlock(&input_dev->mutex);
 
 	return 0;
@@ -352,6 +388,10 @@ static int spear_kbd_resume(struct device *dev)
 			clk_enable(kbd->clk);
 	}
 
+	/* restore current configuration */
+	if (input_dev->users)
+		writel_relaxed(kbd->mode_ctl_reg, kbd->io_base + MODE_CTL_REG);
+
 	mutex_unlock(&input_dev->mutex);
 
 	return 0;
-- 
1.7.10

