From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH 2/2] Input: gpio-keys: added support for disabling gpios through sysfs
Date: Thu, 19 Nov 2009 09:23:46 +0200
Message-ID: <ea1b603995c4ff63d26cb55bf93fd34097b049a7.1258614931.git.ext-mika.1.westerberg@nokia.com>
References: <1257935192.21596.1004.camel@localhost>
 <cover.1258614931.git.ext-mika.1.westerberg@nokia.com>
 <dacbc701ebdd15c48ebb32920bf70fd42aa14baa.1258614931.git.ext-mika.1.westerberg@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:23108 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbZKSH2Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 02:28:25 -0500
In-Reply-To: <dacbc701ebdd15c48ebb32920bf70fd42aa14baa.1258614931.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1258614931.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1258614931.git.ext-mika.1.westerberg@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Now gpio-keys input driver exports 4 new attributes to userland through
sysfs:
	/sys/devices/platform/gpio-keys/keys [ro]
	/sys/devices/platform/gpio-keys/switches [ro]
	/sys/devices/platform/gpio-keys/disabled_keys [rw]
	/sys/devices/platform/gpio-keys/disables_switches [rw]

With these attributes, userland program can read which keys and
switches can be disabled and then disable/enable them as needed.
Keys and switches are exported as stringified bitmap of codes
(keycodes or switch codes). For example keys 15, 89, 100, 101,
102 are exported as: '15,89,100-102'.

Description of the attributes:
	keys - bitmap of keys which can be disabled
	switches - bitmap of switches which can be disabled
	disabled_keys - bitmap of currently disabled keys
	                (bit 1 means disabled, 0 enabled)
	disabled_switches - bitmap of currently disabled switches
	                (bit 1 means disabled, 0 enabled)

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 drivers/input/keyboard/gpio_keys.c |  358 +++++++++++++++++++++++++++++++++++-
 1 files changed, 356 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 113d187..41dcc9e 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -14,6 +14,7 @@
 #include <linux/fs.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/list.h>
 #include <linux/sched.h>
 #include <linux/pm.h>
 #include <linux/sysctl.h>
@@ -30,13 +31,336 @@ struct gpio_button_data {
 	struct input_dev *input;
 	struct timer_list timer;
 	struct work_struct work;
+	struct list_head node;
+	/* protects button from concurrent disables/enables */
+	struct mutex disable_lock;
+	bool disabled;
 };
 
 struct gpio_keys_drvdata {
 	struct input_dev *input;
+	/*
+	 * NOTE: currently these lists are filled in when module is
+	 *       initialized and never changed after that. This means
+	 *       that no locking is needed when accessing these. If
+	 *       this changes then we obviously need to protect these
+	 *       from concurrent accesses.
+	 */
+	struct list_head keys;     /* list of keys that can be disabled */
+	struct list_head switches; /* list of switches that can be disabled */
 	struct gpio_button_data data[0];
 };
 
+/*
+ * SYSFS interface for enabling/disabling keys and switches:
+ *
+ * There are 4 attributes under /sys/devices/platform/gpio-keys/
+ * 	keys [ro]              - bitmap of keys (EV_KEY) which can be
+ *	                         disabled
+ *	switches [ro]          - bitmap of switches (EV_SW) which can be
+ *	                         disabled
+ *	disabled_keys [rw]     - bitmap of keys currently disabled
+ *	disabled_switches [rw] - bitmap of switches currently disabled
+ *
+ * Userland can change these values and hence disable event generation
+ * for each key (or switch). Disabling a key means its interrupt line
+ * is disabled.
+ *
+ * For example, if we have following switches set up as gpio-keys:
+ *	SW_DOCK = 5
+ *	SW_CAMERA_LENS_COVER = 9
+ *	SW_KEYPAD_SLIDE = 10
+ * 	SW_FRONT_PROXIMITY = 11
+ * This is read from switches:
+ *	11-9,5
+ * Next we want to disable proximity (11) and dock (5), we write:
+ *	11,5
+ * to file disabled_switches. Now proximity and dock IRQs are disabled.
+ * This can be verified by reading the file disabled_switches:
+ *	11,5
+ * If we now want to enable proximity (11) switch we write:
+ *	5
+ * to disabled_switches.
+ *
+ * Note that we allow user to specify other bits that are allowed (as
+ * long as she doesn't try to use bits higher than KEY_CNT or SW_CNT).
+ * User can disable bunch of keys for example like this:
+ *	echo 0-600 > disabled_keys
+ * and we only disable those keys that can be disabled.
+ *
+ * We can disable only those keys who have specified 'exclusive_irq = 1'
+ * in their platform data (e.g shared IRQs cannot be disabled).
+ */
+
+/**
+ * get_nkeys_by_type() - returns maximum number of keys per @type
+ * @type: type of button (%EV_KEY, %EV_SW)
+ *
+ * Return value of this function can be used to allocate bitmap
+ * large enough to hold all bits for given type.
+ */
+static inline int get_nkeys_by_type(int type)
+{
+	BUG_ON(type != EV_SW && type != EV_KEY);
+
+	return (type == EV_KEY) ? KEY_CNT : SW_CNT;
+}
+
+/**
+ * get_button_list_by_type() - returns correct button list per @type
+ * @ddata: driver data containing the lists
+ * @type: type of button which list we want (%EV_KEY, %EV_SW)
+ */
+static inline struct list_head *get_button_list_by_type(
+	struct gpio_keys_drvdata *ddata, int type)
+{
+	BUG_ON(type != EV_SW && type != EV_KEY);
+
+	return (type == EV_KEY) ? &ddata->keys : &ddata->switches;
+}
+
+/**
+ * gpio_keys_disable_button() - disables given GPIO button
+ * @bdata: button data for button to be disabled
+ *
+ * Disables button pointed by @bdata. This is done by masking
+ * IRQ line. After this function is called, button won't generate
+ * input events anymore. Note that one can only disable buttons
+ * that don't share IRQs.
+ *
+ * Make sure that @bdata->disable_lock is locked when entering
+ * this function to avoid races when concurrent threads are
+ * disabling buttons at the same time.
+ */
+static void gpio_keys_disable_button(struct gpio_button_data *bdata)
+{
+	BUG_ON(bdata->button->exclusive_irq == 0);
+
+	if (bdata->disabled)
+		return;
+
+	/*
+	 * Disable IRQ and possible debouncing timer.
+	 */
+	disable_irq(gpio_to_irq(bdata->button->gpio));
+	if (bdata->button->debounce_interval)
+		(void) del_timer_sync(&bdata->timer);
+
+	bdata->disabled = true;
+}
+
+/**
+ * gpio_keys_enable_button() - enables given GPIO button
+ * @bdata: button data for button to be disabled
+ *
+ * Enables given button pointed by @bdata.
+ *
+ * Make sure that @bdata->disable_lock is locked when entering
+ * this function to avoid races with concurrent threads trying
+ * to enable the same button at the same time.
+ */
+static void gpio_keys_enable_button(struct gpio_button_data *bdata)
+{
+	if (!bdata->disabled)
+		return;
+
+	enable_irq(gpio_to_irq(bdata->button->gpio));
+	bdata->disabled = false;
+}
+
+/**
+ * gpio_keys_attr_show_helper() - fill in stringified bitmap of buttons
+ * @ddata: pointer to drvdata
+ * @buf: buffer where stringified bitmap is written
+ * @type: button type (%EV_KEY, %EV_SW)
+ * @only_disabled: does caller want only those buttons that are
+ *                 currently disabled or all buttons that can be
+ *                 disabled
+ *
+ * This function writes buttons that can be disabled to @buf. If
+ * @only_disabled is true, then @buf contains only those buttons
+ * that are currently disabled. Returns 0 on success or negative
+ * errno on failure.
+ */
+static ssize_t gpio_keys_attr_show_helper(struct gpio_keys_drvdata *ddata,
+					  char *buf, int type,
+					  bool only_disabled)
+{
+	struct list_head *button_list, *pbtn;
+	unsigned long *bits;
+	ssize_t ret;
+	int nkeys;
+
+	nkeys = get_nkeys_by_type(type);
+	bits = kzalloc(sizeof(*bits) * BITS_TO_LONGS(nkeys), GFP_KERNEL);
+	if (!bits)
+		return -ENOMEM;
+
+	button_list = get_button_list_by_type(ddata, type);
+	list_for_each(pbtn, button_list) {
+		struct gpio_button_data *bdata;
+
+		bdata = list_entry(pbtn, struct gpio_button_data, node);
+		if (only_disabled && !bdata->disabled)
+			continue;
+		set_bit(bdata->button->code, bits);
+	}
+
+	ret = bitmap_scnlistprintf(buf, PAGE_SIZE - 1, bits, nkeys);
+	buf[ret++] = '\n';
+	kfree(bits);
+
+	return ret;
+}
+
+/**
+ * gpio_keys_attr_store_helper() - enable/disable buttons based on given bitmap
+ * @ddata: pointer to drvdata
+ * @buf: buffer from userspace that contains stringified bitmap
+ * @type: button type (%EV_KEY, %EV_SW)
+ *
+ * This function parses stringified bitmap from @buf and disables/enables
+ * GPIO buttons accordinly. Returns 0 on success and negative error
+ * on failure.
+ */
+static ssize_t gpio_keys_attr_store_helper(struct gpio_keys_drvdata *ddata,
+					   const char *buf, int type)
+{
+	struct list_head *button_list, *pbtn;
+	unsigned long *bits;
+	ssize_t error;
+	int nkeys;
+
+	nkeys = get_nkeys_by_type(type);
+	bits = kzalloc(sizeof(*bits) * BITS_TO_LONGS(nkeys), GFP_KERNEL);
+	if (!bits)
+		return -ENOMEM;
+
+	error = bitmap_parselist(buf, bits, nkeys);
+	if (error)
+		goto out;
+
+	button_list = get_button_list_by_type(ddata, type);
+	list_for_each(pbtn, button_list) {
+		struct gpio_button_data *bdata;
+		int bit;
+
+		bdata = list_entry(pbtn, struct gpio_button_data, node);
+		bit = test_bit(bdata->button->code, bits);
+
+		mutex_lock(&bdata->disable_lock);
+
+		if (bdata->disabled && !bit)
+			gpio_keys_enable_button(bdata);
+		else if (!bdata->disabled && bit)
+			gpio_keys_disable_button(bdata);
+
+		mutex_unlock(&bdata->disable_lock);
+	}
+
+out:
+	kfree(bits);
+	return error;
+}
+
+#define ATTR_SHOW_FN(name, type, only_disabled)				\
+static ssize_t gpio_keys_show_##name(struct device *dev,		\
+			      struct device_attribute *attr,		\
+			      char *buf)				\
+{									\
+	struct platform_device *pdev = to_platform_device(dev);		\
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);	\
+									\
+	(void)attr;							\
+	return gpio_keys_attr_show_helper(ddata, buf, (type),		\
+					  (only_disabled));		\
+}
+ATTR_SHOW_FN(keys, EV_KEY, false);
+ATTR_SHOW_FN(switches, EV_SW, false);
+ATTR_SHOW_FN(disabled_keys, EV_KEY, true);
+ATTR_SHOW_FN(disabled_switches, EV_SW, true);
+
+/*
+ * ATTRIBUTES:
+ *
+ * /sys/devices/platform/gpio-keys/keys [ro]
+ * /sys/devices/platform/gpio-keys/switches [ro]
+ */
+static DEVICE_ATTR(keys, S_IRUGO, gpio_keys_show_keys, NULL);
+static DEVICE_ATTR(switches, S_IRUGO, gpio_keys_show_switches, NULL);
+
+#define ATTR_STORE_FN(name, type)					\
+static ssize_t gpio_keys_store_##name(struct device *dev,		\
+				      struct device_attribute *attr,	\
+				      const char *buf,			\
+				      size_t count)			\
+{									\
+	struct platform_device *pdev = to_platform_device(dev);		\
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);	\
+	ssize_t ret;							\
+									\
+	(void)attr;							\
+	ret = gpio_keys_attr_store_helper(ddata, buf, (type));		\
+	if (ret)							\
+		return ret;						\
+	return count;							\
+}
+ATTR_STORE_FN(disabled_keys, EV_KEY);
+ATTR_STORE_FN(disabled_switches, EV_SW);
+
+/*
+ * ATTRIBUTES:
+ *
+ * /sys/devices/platform/gpio-keys/disabled_keys [rw]
+ * /sys/devices/platform/gpio-keys/disables_switches [rw]
+ */
+static DEVICE_ATTR(disabled_keys, S_IWUSR | S_IRUGO,
+		   gpio_keys_show_disabled_keys,
+		   gpio_keys_store_disabled_keys);
+static DEVICE_ATTR(disabled_switches, S_IWUSR | S_IRUGO,
+		   gpio_keys_show_disabled_switches,
+		   gpio_keys_store_disabled_switches);
+
+static struct attribute *gpio_keys_attrs[] = {
+	&dev_attr_keys.attr,
+	&dev_attr_switches.attr,
+	&dev_attr_disabled_keys.attr,
+	&dev_attr_disabled_switches.attr,
+	NULL,
+};
+
+static struct attribute_group gpio_keys_attr_group = {
+	.attrs = gpio_keys_attrs,
+};
+
+/**
+ * gpio_keys_export - export gpio key/switch information through sysfs
+ * @pdev: platform_device whose keys/switches are exported
+ *
+ * This function creates 4 new attributes under gpio-keys sysfs
+ * entry: keys, switches, disabled_keys and disabled_switches.
+ * Userland can use these files to enable/disable gpios by
+ * specifying keycode or switchcode.
+ *
+ * Returns 0 on success and negative error on failure.
+ */
+static int gpio_keys_export(struct platform_device *pdev)
+{
+	return sysfs_create_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+}
+
+/**
+ * gpio_keys_unexport - unexports gpio key/switch information
+ * @pdev: platform_device whose keys/switches are unexported
+ *
+ * This function removes exported gpio keys sysfs attributes from
+ * sysfs.
+ */
+static void gpio_keys_unexport(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+}
+
 static void gpio_keys_report_event(struct work_struct *work)
 {
 	struct gpio_button_data *bdata =
@@ -73,16 +397,19 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit gpio_keys_setup_key(struct device *dev,
+static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
 					 struct gpio_button_data *bdata,
 					 struct gpio_keys_button *button)
 {
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
 	char *desc = button->desc ? button->desc : "gpio_keys";
+	struct device *dev = &pdev->dev;
 	unsigned long irqflags;
 	int irq, error;
 
 	setup_timer(&bdata->timer, gpio_keys_timer, (unsigned long)bdata);
 	INIT_WORK(&bdata->work, gpio_keys_report_event);
+	mutex_init(&bdata->disable_lock);
 
 	error = gpio_request(button->gpio, desc);
 	if (error < 0) {
@@ -114,6 +441,21 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
 	 */
 	if (!button->exclusive_irq)
 		irqflags |= IRQF_SHARED;
+	else {
+		/*
+		 * GPIOs which don't share their IRQ can be disabled
+		 * so we add them to appropriate lists depending
+		 * on type.
+		 */
+		switch (button->type) {
+		case EV_KEY:
+			list_add_tail(&bdata->node, &ddata->keys);
+			break;
+		case EV_SW:
+			list_add_tail(&bdata->node, &ddata->switches);
+			break;
+		}
+	}
 
 	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
 	if (error) {
@@ -149,6 +491,9 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		goto fail1;
 	}
 
+	INIT_LIST_HEAD(&ddata->keys);
+	INIT_LIST_HEAD(&ddata->switches);
+
 	platform_set_drvdata(pdev, ddata);
 
 	input->name = pdev->name;
@@ -174,7 +519,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		bdata->input = input;
 		bdata->button = button;
 
-		error = gpio_keys_setup_key(dev, bdata, button);
+		error = gpio_keys_setup_key(pdev, bdata, button);
 		if (error)
 			goto fail2;
 
@@ -191,6 +536,13 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		goto fail2;
 	}
 
+	error = gpio_keys_export(pdev);
+	if (error) {
+		pr_err("gpio-keys: Unable to export keys/switches, "
+			"error: %d\n", error);
+		goto fail2;
+	}
+
 	device_init_wakeup(&pdev->dev, wakeup);
 
 	return 0;
@@ -205,6 +557,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	}
 
 	platform_set_drvdata(pdev, NULL);
+	gpio_keys_unexport(pdev);
  fail1:
 	input_free_device(input);
 	kfree(ddata);
@@ -219,6 +572,7 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 	struct input_dev *input = ddata->input;
 	int i;
 
+	gpio_keys_unexport(pdev);
 	device_init_wakeup(&pdev->dev, 0);
 
 	for (i = 0; i < pdata->nbuttons; i++) {
-- 
1.5.6.5

