From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] Input: keyboard: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 07:18:37 -0700
Message-ID: <20171024141837.GA78013@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rakesh Iyer <riyer@nvidia.com>, Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Guenter Roeck <linux@roeck-us.net>, Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Geliang Tang <geliangtang@gmail.com>, linux-input@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rakesh Iyer <riyer@nvidia.com>
Cc: Laxman Dewangan <ldewangan@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Geliang Tang <geliangtang@gmail.com>
Cc: linux-input@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/input/keyboard/bf54x-keys.c  | 7 +++----
 drivers/input/keyboard/gpio_keys.c   | 7 +++----
 drivers/input/keyboard/imx_keypad.c  | 8 ++++----
 drivers/input/keyboard/locomokbd.c   | 7 +++----
 drivers/input/keyboard/omap-keypad.c | 6 +++---
 drivers/input/keyboard/snvs_pwrkey.c | 7 +++----
 drivers/input/keyboard/tegra-kbc.c   | 6 +++---
 7 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/input/keyboard/bf54x-keys.c b/drivers/input/keyboard/bf54x-keys.c
index 39bcbc38997f..8a07a426f88e 100644
--- a/drivers/input/keyboard/bf54x-keys.c
+++ b/drivers/input/keyboard/bf54x-keys.c
@@ -127,10 +127,9 @@ static inline void bfin_kpad_clear_irq(void)
 	bfin_write_KPAD_ROWCOL(0xFFFF);
 }
 
-static void bfin_kpad_timer(unsigned long data)
+static void bfin_kpad_timer(struct timer_list *t)
 {
-	struct platform_device *pdev =  (struct platform_device *) data;
-	struct bf54x_kpad *bf54x_kpad = platform_get_drvdata(pdev);
+	struct bf54x_kpad *bf54x_kpad = from_timer(bf54x_kpad, t, timer);
 
 	if (bfin_kpad_get_keypressed(bf54x_kpad)) {
 		/* Try again later */
@@ -298,7 +297,7 @@ static int bfin_kpad_probe(struct platform_device *pdev)
 
 	/* Init Keypad Key Up/Release test timer */
 
-	setup_timer(&bf54x_kpad->timer, bfin_kpad_timer, (unsigned long) pdev);
+	timer_setup(&bf54x_kpad->timer, bfin_kpad_timer, 0);
 
 	bfin_write_KPAD_PRESCALE(bfin_kpad_get_prescale(TIME_SCALE));
 
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index e9f0ebf3267a..87e613dc33b8 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -419,9 +419,9 @@ static irqreturn_t gpio_keys_gpio_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void gpio_keys_irq_timer(unsigned long _data)
+static void gpio_keys_irq_timer(struct timer_list *t)
 {
-	struct gpio_button_data *bdata = (struct gpio_button_data *)_data;
+	struct gpio_button_data *bdata = from_timer(bdata, t, release_timer);
 	struct input_dev *input = bdata->input;
 	unsigned long flags;
 
@@ -582,8 +582,7 @@ static int gpio_keys_setup_key(struct platform_device *pdev,
 		}
 
 		bdata->release_delay = button->debounce_interval;
-		setup_timer(&bdata->release_timer,
-			    gpio_keys_irq_timer, (unsigned long)bdata);
+		timer_setup(&bdata->release_timer, gpio_keys_irq_timer, 0);
 
 		isr = gpio_keys_irq_isr;
 		irqflags = 0;
diff --git a/drivers/input/keyboard/imx_keypad.c b/drivers/input/keyboard/imx_keypad.c
index 2165f3dd328b..d0220e82e018 100644
--- a/drivers/input/keyboard/imx_keypad.c
+++ b/drivers/input/keyboard/imx_keypad.c
@@ -184,9 +184,9 @@ static void imx_keypad_fire_events(struct imx_keypad *keypad,
 /*
  * imx_keypad_check_for_events is the timer handler.
  */
-static void imx_keypad_check_for_events(unsigned long data)
+static void imx_keypad_check_for_events(struct timer_list *t)
 {
-	struct imx_keypad *keypad = (struct imx_keypad *) data;
+	struct imx_keypad *keypad = from_timer(keypad, t, check_matrix_timer);
 	unsigned short matrix_volatile_state[MAX_MATRIX_KEY_COLS];
 	unsigned short reg_val;
 	bool state_changed, is_zero_matrix;
@@ -456,8 +456,8 @@ static int imx_keypad_probe(struct platform_device *pdev)
 	keypad->irq = irq;
 	keypad->stable_count = 0;
 
-	setup_timer(&keypad->check_matrix_timer,
-		    imx_keypad_check_for_events, (unsigned long) keypad);
+	timer_setup(&keypad->check_matrix_timer, imx_keypad_check_for_events,
+		    0);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	keypad->mmio_base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/input/keyboard/locomokbd.c b/drivers/input/keyboard/locomokbd.c
index 0d74312d5b02..30d610758595 100644
--- a/drivers/input/keyboard/locomokbd.c
+++ b/drivers/input/keyboard/locomokbd.c
@@ -210,9 +210,9 @@ static irqreturn_t locomokbd_interrupt(int irq, void *dev_id)
 /*
  * LoCoMo timer checking for released keys
  */
-static void locomokbd_timer_callback(unsigned long data)
+static void locomokbd_timer_callback(struct timer_list *t)
 {
-	struct locomokbd *locomokbd = (struct locomokbd *) data;
+	struct locomokbd *locomokbd = from_timer(locomokbd, t, timer);
 
 	locomokbd_scankeyboard(locomokbd);
 }
@@ -264,8 +264,7 @@ static int locomokbd_probe(struct locomo_dev *dev)
 
 	spin_lock_init(&locomokbd->lock);
 
-	setup_timer(&locomokbd->timer, locomokbd_timer_callback,
-		    (unsigned long)locomokbd);
+	timer_setup(&locomokbd->timer, locomokbd_timer_callback, 0);
 
 	locomokbd->suspend_jiffies = jiffies;
 
diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboard/omap-keypad.c
index 146b26f665f6..7bd107910a6e 100644
--- a/drivers/input/keyboard/omap-keypad.c
+++ b/drivers/input/keyboard/omap-keypad.c
@@ -41,7 +41,7 @@
 #undef NEW_BOARD_LEARNING_MODE
 
 static void omap_kp_tasklet(unsigned long);
-static void omap_kp_timer(unsigned long);
+static void omap_kp_timer(struct timer_list *);
 
 static unsigned char keypad_state[8];
 static DEFINE_MUTEX(kp_enable_mutex);
@@ -74,7 +74,7 @@ static irqreturn_t omap_kp_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static void omap_kp_timer(unsigned long data)
+static void omap_kp_timer(struct timer_list *unused)
 {
 	tasklet_schedule(&kp_tasklet);
 }
@@ -233,7 +233,7 @@ static int omap_kp_probe(struct platform_device *pdev)
 	col_idx = 0;
 	row_idx = 0;
 
-	setup_timer(&omap_kp->timer, omap_kp_timer, (unsigned long)omap_kp);
+	timer_setup(&omap_kp->timer, omap_kp_timer, 0);
 
 	/* get the irq and init timer*/
 	kp_tasklet.data = (unsigned long) omap_kp;
diff --git a/drivers/input/keyboard/snvs_pwrkey.c b/drivers/input/keyboard/snvs_pwrkey.c
index 7544888c4749..53c768b95939 100644
--- a/drivers/input/keyboard/snvs_pwrkey.c
+++ b/drivers/input/keyboard/snvs_pwrkey.c
@@ -45,9 +45,9 @@ struct pwrkey_drv_data {
 	struct input_dev *input;
 };
 
-static void imx_imx_snvs_check_for_events(unsigned long data)
+static void imx_imx_snvs_check_for_events(struct timer_list *t)
 {
-	struct pwrkey_drv_data *pdata = (struct pwrkey_drv_data *) data;
+	struct pwrkey_drv_data *pdata = from_timer(pdata, t, check_timer);
 	struct input_dev *input = pdata->input;
 	u32 state;
 
@@ -134,8 +134,7 @@ static int imx_snvs_pwrkey_probe(struct platform_device *pdev)
 	/* clear the unexpected interrupt before driver ready */
 	regmap_write(pdata->snvs, SNVS_LPSR_REG, SNVS_LPSR_SPO);
 
-	setup_timer(&pdata->check_timer,
-		    imx_imx_snvs_check_for_events, (unsigned long) pdata);
+	timer_setup(&pdata->check_timer, imx_imx_snvs_check_for_events, 0);
 
 	input = devm_input_allocate_device(&pdev->dev);
 	if (!input) {
diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
index edc1385ca00b..875205f445b5 100644
--- a/drivers/input/keyboard/tegra-kbc.c
+++ b/drivers/input/keyboard/tegra-kbc.c
@@ -251,9 +251,9 @@ static void tegra_kbc_set_fifo_interrupt(struct tegra_kbc *kbc, bool enable)
 	writel(val, kbc->mmio + KBC_CONTROL_0);
 }
 
-static void tegra_kbc_keypress_timer(unsigned long data)
+static void tegra_kbc_keypress_timer(struct timer_list *t)
 {
-	struct tegra_kbc *kbc = (struct tegra_kbc *)data;
+	struct tegra_kbc *kbc = from_timer(kbc, t, timer);
 	unsigned long flags;
 	u32 val;
 	unsigned int i;
@@ -655,7 +655,7 @@ static int tegra_kbc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	setup_timer(&kbc->timer, tegra_kbc_keypress_timer, (unsigned long)kbc);
+	timer_setup(&kbc->timer, tegra_kbc_keypress_timer, 0);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	kbc->mmio = devm_ioremap_resource(&pdev->dev, res);
-- 
2.7.4


-- 
Kees Cook
Pixel Security
