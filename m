From: Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: [PATCH] Generic, platform independent matrix keyboard support
Date: Sun, 26 Aug 2007 20:48:07 +0200
Message-ID: <200708262048.08421.pisa@cmp.felk.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: David Brownell <david-b@pacbell.net>, Dmitry Torokhov <dtor@mail.ru>
List-Id: linux-input@vger.kernel.org

The genmatrix_kbd module provides support for matrix keyboard
where switches interconnects return lines with port driven
scan lines. Actual version code allow to register concrete
hardware described by platform device. Hardware can be described
by list of output and input pins and manipulation can be delegated
to GPIO layer or hardware specific setup(), release(), activate_all()
deactivate_all() and scan_single() functions can be defined.

Code is written as much independent on platform device, so providing
support for keyboard matrix driven by ports on PCI or AMBA bus
should require add only thin piece of code.

Key activation can be noticed by interrupt or if it is not available,
simple poll mode can be used. Additional logic provides noise
filtering and glitches filtering.

Signed-off-by: Pavel Pisa <pisa@cmp.felk.cvut.cz>
---

Our board specific part registering device for generic
matrix keyboard driver can be found there

 http://rtime.felk.cvut.cz/repos/ppisa-linux-devel/kernel-patches/current/pimx1-board-kbd.patch

It has been tested in IRQ and non-IRQ driven mode with i.MX
optimized functions and in generic platform independent GPIO
support. Unfortunately generic GPIO does not provide ability
to control internal pullups for input, so there has been one
line modification necessary in gpiomatrix_setup().

The discussion about this patch would be more interresting
for embedded targets people (for example on ARM list), but
due to not-crosspost rule I am sending it to input list
only for now. I want to know, if something like this driver
is acceptable for mainline in some timeframe.

Best wishes

            Pavel Pisa

 drivers/input/keyboard/Kconfig         |   12 
 drivers/input/keyboard/Makefile        |    2 
 drivers/input/keyboard/genmatrix_kbd.c |  693 +++++++++++++++++++++++++++++++++
 include/linux/genmatrix_kbd.h          |   34 +
 4 files changed, 740 insertions(+), 1 deletion(-)

Index: linux-2.6.23-git/drivers/input/keyboard/Kconfig
===================================================================
--- linux-2.6.23-git.orig/drivers/input/keyboard/Kconfig
+++ linux-2.6.23-git/drivers/input/keyboard/Kconfig
@@ -253,4 +253,16 @@ config KEYBOARD_GPIO
 	  To compile this driver as a module, choose M here: the
 	  module will be called gpio-keys.
 
+config KEYBOARD_GENMATRIX
+	tristate "Generic matrix keyboard"
+	default n
+	help
+	  Say Y here to enable the generic scanned matrix keyboard
+	  on your platform. This is platform driver, which
+	  can be used by any platform device providing calls
+	  for actual key scanning.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called genmatrix_kbd.
+
 endif
Index: linux-2.6.23-git/drivers/input/keyboard/Makefile
===================================================================
--- linux-2.6.23-git.orig/drivers/input/keyboard/Makefile
+++ linux-2.6.23-git/drivers/input/keyboard/Makefile
@@ -21,4 +21,4 @@ obj-$(CONFIG_KEYBOARD_OMAP)		+= omap-key
 obj-$(CONFIG_KEYBOARD_PXA27x)		+= pxa27x_keyboard.o
 obj-$(CONFIG_KEYBOARD_AAED2000)		+= aaed2000_kbd.o
 obj-$(CONFIG_KEYBOARD_GPIO)		+= gpio_keys.o
-
+obj-$(CONFIG_KEYBOARD_GENMATRIX)	+= genmatrix_kbd.o
Index: linux-2.6.23-git/drivers/input/keyboard/genmatrix_kbd.c
===================================================================
--- /dev/null
+++ linux-2.6.23-git/drivers/input/keyboard/genmatrix_kbd.c
@@ -0,0 +1,693 @@
+/*
+ *  Generic matrix keyboard driver for embedded platforms
+ *
+ *  Copyright (c) 2007 Pavel Pisa
+ *
+ *  Based on PiKRON's COLAMI keyboard code and corgikbd.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/init.h>
+#include <linux/input.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+
+#include <linux/genmatrix_kbd.h>
+
+/* Some sane defaults */
+#define KEY_PUSH_T      20
+#define KEY_RELEASE_T   10
+#define KEY_PUSHCHECK_T  20
+
+/* Individual key states */
+#define KEY_STATE_IDLE     0
+#define KEY_STATE_PUSH     1
+#define KEY_STATE_RELEASE  2
+#define KEY_STATE_PUSHED   4
+#define KEY_STATE_NOISE    8
+#define KEY_STATE_BUSY     (KEY_STATE_PUSH|KEY_STATE_RELEASE)
+
+/* Bit flags */
+#define GENMATRIX_FLG_WITH_IRQ_b 0
+#define GENMATRIX_FLG_IRQ_EN_b   1
+
+typedef unsigned genmatrix_retmask_t;
+
+struct genmatrix_kbd {
+	struct input_dev   *input;
+	struct device      *hw_dev;
+	char   *phys;
+	unsigned long      flags;
+
+	/* Platform specific information */
+	unsigned           scan_cnt;
+	unsigned           ret_cnt;
+
+	int  (*setup)(struct device *dev);
+	void (*release)(struct device *dev);
+	unsigned (*activate_all)(struct device *dev, int setup_irq);
+	void (*deactivate_all)(struct device *dev, int disable_irq);
+	unsigned (*scan_single)(struct device *dev, unsigned scannr);
+
+	/* State of keyboard matrix and key press reporting */
+	genmatrix_retmask_t *down_arr;	/* array of size scan_cnt */
+	genmatrix_retmask_t *chng_arr;	/* array of size scan_cnt */
+	unsigned char      key_hit;
+	int                key_last_changed;
+
+	/* Internal state for repeat processing */
+	int                key_state;
+	unsigned long      check_time;
+
+	unsigned long      push_time;
+	unsigned long      release_time;
+	unsigned long      pushcheck_time;
+
+	spinlock_t         lock;
+	struct timer_list  timer;
+
+	/* Scancode to key translation */
+	unsigned           keycode_cnt;
+	unsigned char      *keycode;
+
+	int                suspended;
+};
+
+/**
+ * genmatrix_scan - Scan keyboard matrix and report requests for state change
+ *
+ * Scans keyboard matrix connected row by row by calling function
+ * mx1_kbd_onerow(). Number of scanned output lines is defined
+ * by %KBD_SCAN_CNT. Checks read keyboard state against @down_arr
+ * and updates @key_change_arr array. The @down_arr state is
+ * left unchanged. It is changed later by kbd_down() function.
+ * Returns 0, if no keyboard activity is found. Returns 1
+ * if at least one key is pressed. Returns 2 or 3 in case
+ * of detected change.
+ */
+static int genmatrix_scan(struct genmatrix_kbd *kbd)
+{
+	int i, ret=0;
+	genmatrix_retmask_t val, chng;
+	for(i=0; i<kbd->scan_cnt; i++) {
+		val = kbd->scan_single(kbd->hw_dev, i);
+		chng = val ^ kbd->down_arr[i];
+		kbd->chng_arr[i] = chng;
+		if (val)
+			ret |= 1;
+		if (chng)
+			ret |= 2;
+	}
+	return ret;
+}
+
+/**
+ * genmatrix_down - Detects changed key scancode and applies changes to matrix state
+ *
+ * Functions check @chng_arr and process changes.
+ * It updates its internal state @key_state, does
+ * noise cancellation and repeat timing, then updates
+ * @down_arr, stores detected scancode to @key_last_changed
+ * and calls modifiers processing kbd_scan2mod().
+ * Return value is zero if no change is detected.
+ * In other case evaluated scancode is returned.
+ * Variable @key_hit signals by value 1 pressed key, by value
+ * 2 key release.
+ */
+static int genmatrix_down(struct genmatrix_kbd *kbd)
+{
+	int si, ri=0;
+	unsigned char val;
+	unsigned long act_time = jiffies;
+
+        if (!(kbd->key_state & KEY_STATE_BUSY)){
+		for(si=0; si < kbd->scan_cnt; si++) {
+			if (!(val = kbd->chng_arr[si])) continue;
+			ri = fls(val) - 1;
+			kbd->key_last_changed = si * kbd->ret_cnt + ri;
+			if (kbd->down_arr[si] & (1 << ri)) {
+				kbd->check_time = act_time + kbd->push_time;
+				kbd->key_state = KEY_STATE_RELEASE;
+			}else{
+				kbd->check_time = act_time + kbd->release_time;
+				kbd->key_state = KEY_STATE_PUSH;
+			}
+			break;
+		}
+		if (kbd->key_state == KEY_STATE_IDLE)
+			return 0;
+	} else {
+		if (kbd->key_last_changed < 0){
+			kbd->key_state = KEY_STATE_IDLE;
+	  		return 0;
+		}
+		si = (kbd->key_last_changed) / kbd->ret_cnt;
+		ri = (kbd->key_last_changed) % kbd->ret_cnt;
+		if (!(kbd->chng_arr[si] & (1 << ri))){
+			/* Noise detected */
+			if (!(kbd->key_state & KEY_STATE_NOISE)){
+			        kbd->check_time = act_time + kbd->release_time;
+			        kbd->key_state |= KEY_STATE_NOISE;
+			}
+		}
+	}
+
+	if (!time_after(jiffies, kbd->check_time))
+		return 0;
+
+	if (kbd->key_state == KEY_STATE_PUSH) {
+		kbd->down_arr[si] |= 1 << ri;
+		kbd->key_state = KEY_STATE_PUSHED;
+		kbd->check_time = act_time + kbd->pushcheck_time;
+		kbd->key_hit = 1;
+		input_report_key(kbd->input, kbd->keycode[kbd->key_last_changed], 1);
+		return 1;
+	} else if (kbd->key_state == KEY_STATE_PUSHED) {
+		kbd->check_time = act_time + kbd->pushcheck_time;
+		return 0;
+	} else if (kbd->key_state == KEY_STATE_RELEASE) {
+		kbd->down_arr[si] &= ~(1<<ri);
+	        kbd->key_state = KEY_STATE_IDLE;
+		kbd->key_hit = 2;
+		input_report_key(kbd->input, kbd->keycode[kbd->key_last_changed], 0);
+		return 2;
+	}
+	kbd->key_state = KEY_STATE_IDLE;
+	return 0;
+}
+
+void genmatrix_report_irq(struct device *dev)
+{
+	int res;
+	struct genmatrix_kbd *kbd = dev_get_drvdata(dev);
+	res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
+	kbd->deactivate_all(kbd->hw_dev, res);
+	mod_timer(&kbd->timer, jiffies + 1);
+}
+
+EXPORT_SYMBOL(genmatrix_report_irq);
+
+static void genmatrix_timer(unsigned long context)
+{
+	struct genmatrix_kbd *kbd = (struct genmatrix_kbd *)context;
+	int res;
+	unsigned long ticks;
+
+	if (test_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags)) {
+		res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
+		kbd->deactivate_all(kbd->hw_dev, res);
+	}
+
+	res = genmatrix_scan(kbd);
+	if (res & 2)
+		dev_dbg(kbd->hw_dev, "genmatrix_scan returned %d, state %d, last %d\n",
+			res, kbd->key_state, kbd->key_last_changed);
+
+	if (res || (kbd->key_state != KEY_STATE_IDLE)) {
+		res = genmatrix_down(kbd);
+		if (res)
+			dev_dbg(kbd->hw_dev, "genmatrix_down returned %d, last %d\n",
+				res, kbd->key_last_changed);
+	}
+
+	if (test_bit(GENMATRIX_FLG_WITH_IRQ_b, &kbd->flags) &&
+		(kbd->key_state == KEY_STATE_IDLE)) {
+
+		res = test_and_set_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
+		kbd->activate_all(kbd->hw_dev, !res);
+		if (res || !test_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags))
+			mod_timer(&kbd->timer, jiffies + kbd->pushcheck_time);
+	} else {
+		res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
+		kbd->deactivate_all(kbd->hw_dev, res);
+
+		ticks = kbd->check_time - jiffies;
+		if((long)ticks <= kbd->pushcheck_time / 4)
+			ticks = (kbd->pushcheck_time + 3) / 4;
+		if(ticks > kbd->pushcheck_time)
+			ticks = kbd->pushcheck_time;
+
+		mod_timer(&kbd->timer, jiffies + ticks);
+	}
+}
+
+#ifdef CONFIG_PM
+static int genmatrix_suspend(struct device *dev, pm_message_t state)
+{
+	int res;
+	struct genmatrix_kbd *kbd = dev_get_drvdata(dev);
+
+	kbd->suspended = 1;
+
+	res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
+	kbd->deactivate_all(kbd->hw_dev, res);
+
+	return 0;
+}
+
+static int genmatrix_resume(struct device *dev)
+{
+	struct genmatrix_kbd *kbd = dev_get_drvdata(dev);
+
+	kbd->suspended = 0;
+
+	mod_timer(&kbd->timer, jiffies + kbd->pushcheck_time);
+	return 0;
+}
+
+#endif
+
+const char genmatrix_input_name[] = "genmatrixkbd/input";
+
+static int genmatrix_probe_common(struct device *dev, struct genmatrix_kbd *kbd)
+{
+	struct input_dev   *input_dev;
+	int    err = -ENOMEM;
+	int    i;
+
+	/* Initialize spin-lock and timer */
+	spin_lock_init(&kbd->lock);
+	setup_timer(&kbd->timer, genmatrix_timer, (unsigned long)kbd);
+
+	/* State of keyboard matrix and key press reporting */
+	kbd->key_hit = 0;
+	kbd->key_last_changed = 0;
+
+	kbd->down_arr = kzalloc(kbd->scan_cnt * sizeof(kbd->down_arr[0]), GFP_KERNEL);
+	if (!kbd->down_arr)
+		goto fail_arr_alloc;
+	kbd->chng_arr = kzalloc(kbd->scan_cnt * sizeof(kbd->down_arr[0]), GFP_KERNEL);
+	if (!kbd->chng_arr)
+		goto fail_arr_alloc;
+
+	/* Internal state for repeat processing */
+	kbd->key_state = KEY_STATE_IDLE;
+	kbd->check_time = jiffies;
+
+	kbd->push_time = msecs_to_jiffies(KEY_PUSH_T);
+	kbd->release_time = msecs_to_jiffies(KEY_RELEASE_T);
+	kbd->pushcheck_time = msecs_to_jiffies(KEY_PUSHCHECK_T);
+
+	input_dev = input_allocate_device();
+	if (!input_dev)
+		goto fail_arr_alloc;
+
+	kbd->input = input_dev;
+	kbd->hw_dev = dev;
+	dev_set_drvdata(dev, kbd);
+
+	/* Setup input device */
+	input_dev->name = "GenMatrix Keyboard";
+	input_dev->phys = kbd->phys;
+	input_dev->dev.parent = dev;
+
+	input_dev->id.bustype = BUS_HOST;
+	input_dev->id.vendor = 0x0001;
+	input_dev->id.product = 0x0001;
+	input_dev->id.version = 0x0100;
+
+	input_dev->evbit[0] = BIT(EV_KEY) | BIT(EV_REP); /* BIT(EV_PWR) | BIT(EV_SW); */
+	input_dev->keycode = kbd->keycode;
+	input_dev->keycodesize = sizeof(*kbd->keycode);
+	input_dev->keycodemax = kbd->keycode_cnt;
+
+	for (i = 0; i < kbd->keycode_cnt; i++)
+		set_bit(kbd->keycode[i], input_dev->keybit);
+	clear_bit(0, input_dev->keybit);
+	/*
+	set_bit(SW_LID, input_dev->swbit);
+	set_bit(SW_TABLET_MODE, input_dev->swbit);
+	set_bit(SW_HEADPHONE_INSERT, input_dev->swbit);
+	*/
+
+	err = kbd->setup(kbd->hw_dev);
+	if (err) {
+		dev_err(kbd->hw_dev, "low-level hardware setup failed\n");
+		goto fail;
+	}
+
+	err = input_register_device(input_dev);
+	if (err) {
+		dev_err(kbd->hw_dev, "input device registration\n");
+		goto fail_to_register;
+	}
+
+	mod_timer(&kbd->timer, jiffies + 1);
+
+	return 0;
+
+fail_to_register:
+	kbd->release(kbd->hw_dev);
+	del_timer_sync(&kbd->timer);
+fail:
+	input_free_device(input_dev);
+
+fail_arr_alloc:
+	kfree(kbd->phys);
+	kfree(kbd->down_arr);
+	kfree(kbd->chng_arr);
+	kfree(kbd->keycode);
+
+	kbd->phys = NULL;
+	kbd->down_arr = NULL;
+	kbd->chng_arr = NULL;
+	kbd->keycode = NULL;
+
+	return err;
+}
+
+static int genmatrix_remove(struct device *dev)
+{
+	struct genmatrix_kbd *kbd = dev_get_drvdata(dev);
+	int res;
+
+	del_timer_sync(&kbd->timer);
+
+	res = test_and_clear_bit(GENMATRIX_FLG_IRQ_EN_b, &kbd->flags);
+	kbd->deactivate_all(kbd->hw_dev, res);
+
+	del_timer_sync(&kbd->timer);
+
+	kbd->release(kbd->hw_dev);
+
+	input_unregister_device(kbd->input);
+
+	dev_set_drvdata(dev, NULL);
+
+	kfree(kbd->phys);
+	kfree(kbd->down_arr);
+	kfree(kbd->chng_arr);
+	kfree(kbd->keycode);
+
+	kfree(kbd);
+
+	return 0;
+}
+
+
+/*============================================================================*/
+/* Part of the driver specific to GPIO and platform devices */
+/*
+ *  If it is possible without nasty exports, imports and exposing internals,
+ *  this should be moved to separate file
+ */
+
+#ifdef CONFIG_GENERIC_GPIO
+
+#include <linux/interrupt.h>
+#include <asm/arch/gpio.h>
+
+static inline struct genmatrix_platform_data *
+gpiomatrix_devdata(struct device *dev)
+{
+	return dev->platform_data;
+}
+
+static int gpiomatrix_irq(int irq, void *id)
+{
+	struct device *dev = (struct device *)id;
+	genmatrix_report_irq(dev);
+	return IRQ_HANDLED;
+}
+
+static int gpiomatrix_setup(struct device *dev)
+{
+	struct genmatrix_platform_data *data = gpiomatrix_devdata(dev);
+	int si, ri;
+	int ret;
+	unsigned pin;
+
+	for(si = 0; si < data->scan_cnt; si++) {
+		pin = data->scan_pin[si];
+		ret = gpio_request(pin, "gpio-kbd-scan-out");
+		if (ret) {
+			dev_err(dev, "scan pin allocation failed %d\n",
+				pin);
+			goto scan_rq_fail;
+		}
+		if(data->emulate_oc)
+			gpio_direction_input(pin);
+		else
+			gpio_direction_output(pin, 1);
+	}
+
+	for(ri = 0; ri < data->ret_cnt; ri++) {
+		pin = data->ret_pin[ri];
+		ret = gpio_request(pin, "gpio-kbd-ret-in");
+		if (ret) {
+			dev_err(dev, "ret pin allocation failed %d\n",
+				pin);
+			goto ret_rq_fail;
+		}
+		gpio_direction_input(pin);
+	}
+
+	if (!data->with_irq)
+		return 0;
+
+	for(ri = 0; ri < data->ret_cnt; ri++) {
+		pin = data->ret_pin[ri];
+		if (request_irq(gpio_to_irq(pin), gpiomatrix_irq,
+		    IRQF_TRIGGER_FALLING, "gpio-kbd", dev)) {
+			dev_err(dev, "cannot request irq %d\n",
+				pin);
+			ret = -ENXIO;
+			goto irq_rq_fail;
+		}
+		disable_irq(gpio_to_irq(pin));
+	}
+
+	return 0;
+
+irq_rq_fail:
+	while(ri--)
+		free_irq(gpio_to_irq(data->ret_pin[ri]), dev);
+
+	ri = data->ret_cnt;
+
+ret_rq_fail:
+	while(ri--)
+		gpio_free(data->ret_pin[ri]);
+scan_rq_fail:
+	while(si--) {
+		gpio_free(data->scan_pin[si]);
+	}
+
+	return ret;
+}
+
+static void gpiomatrix_release(struct device *dev)
+{
+	/*struct platform_device *pdev = to_platform_device(dev);*/
+	struct genmatrix_platform_data *data = gpiomatrix_devdata(dev);
+	int si, ri;
+
+	if (data->with_irq) {
+		for(ri = data->ret_cnt; ri-- ; )
+			free_irq(gpio_to_irq(data->ret_pin[ri]), dev);
+	}
+
+	for(ri = data->ret_cnt; ri-- ; )
+		gpio_free(data->ret_pin[ri]);
+
+	for(si = data->scan_cnt; si-- ; )
+		gpio_free(data->scan_pin[si]);
+}
+
+static unsigned gpiomatrix_activate_all(struct device *dev, int setup_irq)
+{
+	struct genmatrix_platform_data *data = gpiomatrix_devdata(dev);
+	int si, ri;
+	unsigned ret;
+
+	if (setup_irq) {
+		for(ri = 0; ri < data->ret_cnt; ri++)
+			enable_irq(gpio_to_irq(data->ret_pin[ri]));
+	}
+
+	for(si = 0; si < data->scan_cnt; si++)
+		if (data->emulate_oc)
+			gpio_direction_output(data->scan_pin[si], 0);
+		else
+			gpio_set_value(data->scan_pin[si], 0);
+
+	for(ri = data->ret_cnt, ret = 0; ri-- ; ) {
+		ret <<= 1;
+		ret |= gpio_get_value(data->ret_pin[ri]) ? 0 : 1;
+	}
+
+	return ret;
+}
+
+static void gpiomatrix_deactivate_all(struct device *dev, int disable_irq)
+{
+	struct genmatrix_platform_data *data = gpiomatrix_devdata(dev);
+	int si, ri;
+
+	if (disable_irq) {
+		for(ri = 0; ri < data->ret_cnt; ri++)
+			disable_irq_nosync(gpio_to_irq(data->ret_pin[ri]));
+	}
+
+	for(si = 0; si < data->scan_cnt; si++) {
+		if (data->emulate_oc)
+			gpio_direction_input(data->scan_pin[si]);
+		else
+			gpio_set_value(data->scan_pin[si], 1);
+	}
+}
+
+static unsigned gpiomatrix_scan_single(struct device *dev, unsigned scannr)
+{
+	struct genmatrix_platform_data *data = gpiomatrix_devdata(dev);
+	int ri;
+	unsigned ret;
+
+	if (data->emulate_oc)
+		gpio_direction_output(data->scan_pin[scannr], 0);
+	else
+		gpio_set_value(data->scan_pin[scannr], 0);
+
+	udelay(5);
+
+	for(ri = data->ret_cnt, ret = 0; ri-- ; ) {
+		ret <<= 1;
+		ret |= gpio_get_value(data->ret_pin[ri]) ? 0 : 1;
+	}
+
+	if (data->emulate_oc)
+		gpio_direction_input(data->scan_pin[scannr]);
+	else
+		gpio_set_value(data->scan_pin[scannr], 1);
+
+	return ret;
+}
+
+#endif /* CONFIG_GENERIC_GPIO */
+
+
+#ifdef CONFIG_PM
+
+static int genmatrix_plat_suspend(struct platform_device *dev, pm_message_t state)
+{
+	return genmatrix_suspend(&dev->dev, state);
+}
+
+static int genmatrix_plat_resume(struct platform_device *dev)
+{
+	return genmatrix_resume(&dev->dev);
+}
+
+#else
+#define genmatrix_plat_suspend	NULL
+#define genmatrix_plat_resume	NULL
+#endif
+
+static int genmatrix_plat_probe(struct platform_device *dev)
+{
+	struct genmatrix_platform_data *pdata;
+	struct genmatrix_kbd *kbd;
+	unsigned keycode_tab_size;
+	int    err = -ENOMEM;
+	int    res;
+
+	kbd = kzalloc(sizeof(*kbd), GFP_KERNEL);
+	if (!kbd)
+		goto fail_kbd_alloc;
+
+	/* Platform specific information */
+	pdata = dev->dev.platform_data;
+	kbd->phys = kzalloc(sizeof(genmatrix_input_name)+4, GFP_KERNEL);
+	if (!kbd->phys)
+		goto fail_other;
+	strcpy(kbd->phys, genmatrix_input_name);
+	kbd->phys[strlen(kbd->phys)] = '0';
+
+	kbd->scan_cnt = pdata->scan_cnt;
+	kbd->ret_cnt = pdata->ret_cnt;
+
+	kbd->setup = pdata->setup;
+	kbd->release = pdata->release;
+	kbd->activate_all = pdata->activate_all;
+	kbd->deactivate_all = pdata->deactivate_all;
+	kbd->scan_single = pdata->scan_single;
+
+
+#ifdef CONFIG_GENERIC_GPIO
+	if(kbd->setup == NULL)
+		kbd->setup = gpiomatrix_setup;
+	if(kbd->release == NULL)
+		kbd->release = gpiomatrix_release;
+	if(kbd->activate_all == NULL)
+		kbd->activate_all = gpiomatrix_activate_all;
+	if(kbd->deactivate_all == NULL)
+		kbd->deactivate_all = gpiomatrix_deactivate_all;
+	if(kbd->scan_single == NULL)
+		kbd->scan_single = gpiomatrix_scan_single;
+#endif /* CONFIG_GENERIC_GPIO */
+
+	/* Scancode to key translation */
+	kbd->keycode_cnt = pdata->keycode_cnt;
+	keycode_tab_size = sizeof(*kbd->keycode) * kbd->keycode_cnt;
+	kbd->keycode = kzalloc(keycode_tab_size, GFP_KERNEL);;
+	if (!kbd->keycode)
+		goto fail_other;
+	memcpy(kbd->keycode, pdata->keycode, keycode_tab_size);
+	if(pdata->with_irq)
+		set_bit(GENMATRIX_FLG_WITH_IRQ_b, &kbd->flags);
+
+	res = genmatrix_probe_common(&dev->dev, kbd);
+
+	if (!res)
+		return 0;
+
+fail_other:
+	kfree(kbd->keycode);
+	kfree(kbd->phys);
+
+	kfree(kbd);
+fail_kbd_alloc:
+	dev_err(&dev->dev, "keyboard inicialization failed (ret = %d)\n", err);
+	return err;
+}
+
+static int genmatrix_plat_remove(struct platform_device *dev)
+{
+	return genmatrix_remove(&dev->dev);
+}
+
+static struct platform_driver genmatrix_driver = {
+	.probe		= genmatrix_plat_probe,
+	.remove		= genmatrix_plat_remove,
+	.suspend	= genmatrix_plat_suspend,
+	.resume		= genmatrix_plat_resume,
+	.driver		= {
+		.name	= "genmatrix-keyboard",
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init genmatrix_init(void)
+{
+	return platform_driver_register(&genmatrix_driver);
+}
+
+static void __exit genmatrix_exit(void)
+{
+	platform_driver_unregister(&genmatrix_driver);
+}
+
+module_init(genmatrix_init);
+module_exit(genmatrix_exit);
+
+MODULE_DESCRIPTION("Generic Matrix Keyboard Device");
+MODULE_AUTHOR("Pavel Pisa, PiKRON");
+MODULE_LICENSE("GPL");
Index: linux-2.6.23-git/include/linux/genmatrix_kbd.h
===================================================================
--- /dev/null
+++ linux-2.6.23-git/include/linux/genmatrix_kbd.h
@@ -0,0 +1,34 @@
+/*
+ *  Generic matrix keyboard driver for embedded platforms
+ *
+ *  Copyright (c) 2007 Pavel Pisa
+ *
+ *  Based on PiKRON's COLAMI keyboard code and corgikbd.c
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ */
+
+struct device ;
+
+void genmatrix_report_irq(struct device *dev);
+
+struct genmatrix_platform_data {
+	unsigned           scan_cnt;
+	unsigned           ret_cnt;
+	unsigned           *scan_pin;
+	unsigned           *ret_pin;
+
+	int  (*setup)(struct device *dev);
+	void (*release)(struct device *dev);
+	unsigned (*activate_all)(struct device *dev, int setup_irq);
+	void (*deactivate_all)(struct device *dev, int disable_irq);
+	unsigned (*scan_single)(struct device *dev, unsigned scannr);
+
+	unsigned           keycode_cnt;
+	unsigned char      *keycode;
+	char               with_irq;
+	char               emulate_oc;
+};
