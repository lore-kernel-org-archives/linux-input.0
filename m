From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH v2 2/2] Input: gpio-keys - added support for disabling gpios through sysfs
Date: Mon, 23 Nov 2009 14:39:40 +0200
Message-ID: <8dd6fc865863ea9323f61f7de6bceda069a55c24.1258976669.git.ext-mika.1.westerberg@nokia.com>
References: <20091120084054.GC3009@core.coreip.homeip.net>
 <cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
 <8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:59035 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188AbZKWMoL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Nov 2009 07:44:11 -0500
In-Reply-To: <8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1258976669.git.ext-mika.1.westerberg@nokia.com>
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
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 Documentation/ABI/testing/sysfs-platform-gpio-keys |   44 +++
 drivers/input/keyboard/gpio_keys.c                 |  312 +++++++++++++++++++-
 2 files changed, 349 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-gpio-keys

diff --git a/Documentation/ABI/testing/sysfs-platform-gpio-keys b/Documentation/ABI/testing/sysfs-platform-gpio-keys
new file mode 100644
index 0000000..4477323
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-gpio-keys
@@ -0,0 +1,44 @@
+What:		/sys/devices/platform/gpio-keys/keys
+Date:		November 2009
+KernelVersion:	2.6.33
+Contact:	Mika Westerberg <ext-mika.1.westerberg@nokia.com>
+Description:
+		This file lists gpio keys (EV_KEY) by key code
+		which can be disabled. These are formatted as
+		ASCII encoded bitmap. For example if we have keys
+		152, 212, 528 that can be disabled, the file
+		contains:
+			152,212,528
+		Consecutive bits are shown as hyphen separated
+		numbers. For example keys 9, 10, 11 are shown
+		as:
+			9-11
+
+What:		/sys/devices/platform/gpio-keys/switches
+Date:		November 2009
+KernelVersion:	2.6.33
+Contact:	Mika Westerberg <ext-mika.1.westerberg@nokia.com>
+Description:
+		This file lists gpio switches (EV_SW) by switch
+		code which can be disabled. These are formatted
+		in similar manner than keys.
+
+What:		/sys/devices/platform/gpio-keys/disabled_keys
+Date:		November 2009
+KernelVersion:	2.6.33
+Contact:	Mika Westerberg <ext-mika.1.westerberg@nokia.com>
+Description:
+		This file lists gpio keys (EV_KEY) by key code
+		which are currently disabled and cannot generate
+		interrupts. Format is similar than in previous
+		files. Writing to this file disables given keys.
+
+What:		/sys/devices/platform/gpio-keys/disabled_switches
+Date:		November 2009
+KernelVersion:	2.6.33
+Contact:	Mika Westerberg <ext-mika.1.westerberg@nokia.com>
+Description:
+		This file lists gpio switches (EV_SW) by switch code
+		which are currently disabled and cannot generate
+		interrupts. Format is similar than in previous
+		files. Writing to this file disables given switches.
diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 6ed5a18..bf15652 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -30,13 +30,290 @@ struct gpio_button_data {
 	struct input_dev *input;
 	struct timer_list timer;
 	struct work_struct work;
+	bool can_disable;
+	bool disabled;
 };
 
 struct gpio_keys_drvdata {
 	struct input_dev *input;
+	struct mutex disable_lock;
+	unsigned int n_buttons;
 	struct gpio_button_data data[0];
 };
 
+/*
+ * SYSFS interface for enabling/disabling keys and switches:
+ *
+ * There are 4 attributes under /sys/devices/platform/gpio-keys/
+ *	keys [ro]              - bitmap of keys (EV_KEY) which can be
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
+ *	SW_FRONT_PROXIMITY = 11
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
+ * We can disable only those keys which don't allow sharing the irq.
+ */
+
+/**
+ * get_n_events_by_type() - returns maximum number of events per @type
+ * @type: type of button (%EV_KEY, %EV_SW)
+ *
+ * Return value of this function can be used to allocate bitmap
+ * large enough to hold all bits for given type.
+ */
+static inline int get_n_events_by_type(int type)
+{
+	BUG_ON(type != EV_SW && type != EV_KEY);
+
+	return (type == EV_KEY) ? KEY_CNT : SW_CNT;
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
+	if (!bdata->disabled) {
+		/*
+		 * Disable IRQ and possible debouncing timer.
+		 */
+		disable_irq(gpio_to_irq(bdata->button->gpio));
+		if (bdata->button->debounce_interval)
+			del_timer_sync(&bdata->timer);
+
+		bdata->disabled = true;
+	}
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
+	if (bdata->disabled) {
+		enable_irq(gpio_to_irq(bdata->button->gpio));
+		bdata->disabled = false;
+	}
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
+					  char *buf, unsigned int type,
+					  bool only_disabled)
+{
+	int n_events = get_n_events_by_type(type);
+	unsigned long *bits;
+	ssize_t ret;
+	int i;
+
+	bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
+	if (!bits)
+		return -ENOMEM;
+
+	for (i = 0; i < ddata->n_buttons; i++) {
+		struct gpio_button_data *bdata = &ddata->data[i];
+
+		if (bdata->button->type != type)
+			continue;
+
+		if (only_disabled && !bdata->disabled)
+			continue;
+
+		__set_bit(bdata->button->code, bits);
+	}
+
+	ret = bitmap_scnlistprintf(buf, PAGE_SIZE - 2, bits, n_events);
+	buf[ret++] = '\n';
+	buf[ret] = '\0';
+
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
+					   const char *buf, unsigned int type)
+{
+	int n_events = get_n_events_by_type(type);
+	unsigned long *bits;
+	ssize_t error;
+	int i;
+
+	bits = kcalloc(BITS_TO_LONGS(n_events), sizeof(*bits), GFP_KERNEL);
+	if (!bits)
+		return -ENOMEM;
+
+	error = bitmap_parselist(buf, bits, n_events);
+	if (error)
+		goto out;
+
+	/* First validate */
+	for (i = 0; i < ddata->n_buttons; i++) {
+		struct gpio_button_data *bdata = &ddata->data[i];
+
+		if (bdata->button->type != type)
+			continue;
+
+		if (test_bit(bdata->button->code, bits) &&
+		    !bdata->can_disable) {
+			error = -EINVAL;
+			goto out;
+		}
+	}
+
+	mutex_lock(&ddata->disable_lock);
+
+	for (i = 0; i < ddata->n_buttons; i++) {
+		struct gpio_button_data *bdata = &ddata->data[i];
+
+		if (bdata->button->type != type)
+			continue;
+
+		if (test_bit(bdata->button->code, bits))
+			gpio_keys_disable_button(bdata);
+		else
+			gpio_keys_enable_button(bdata);
+	}
+
+	mutex_unlock(&ddata->disable_lock);
+
+out:
+	kfree(bits);
+	return error;
+}
+
+#define ATTR_SHOW_FN(name, type, only_disabled)				\
+static ssize_t gpio_keys_show_##name(struct device *dev,		\
+				     struct device_attribute *attr,	\
+				     char *buf)				\
+{									\
+	struct platform_device *pdev = to_platform_device(dev);		\
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);	\
+									\
+	return gpio_keys_attr_show_helper(ddata, buf,			\
+					  type, only_disabled);		\
+}
+
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
+	ssize_t error;							\
+									\
+	error = gpio_keys_attr_store_helper(ddata, buf, type);		\
+	if (error)							\
+		return error;						\
+									\
+	return count;							\
+}
+
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
 static void gpio_keys_report_event(struct work_struct *work)
 {
 	struct gpio_button_data *bdata =
@@ -73,11 +350,12 @@ static irqreturn_t gpio_keys_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static int __devinit gpio_keys_setup_key(struct device *dev,
+static int __devinit gpio_keys_setup_key(struct platform_device *pdev,
 					 struct gpio_button_data *bdata,
 					 struct gpio_keys_button *button)
 {
 	char *desc = button->desc ? button->desc : "gpio_keys";
+	struct device *dev = &pdev->dev;
 	unsigned long irqflags;
 	int irq, error;
 
@@ -112,6 +390,12 @@ static int __devinit gpio_keys_setup_key(struct device *dev,
 			   IRQF_SHARED;
 	} else {
 		irqflags = button->irqflags;
+		/*
+		 * If platform doesn't allow sharing the IRQ we
+		 * can then disable the button through sysfs.
+		 */
+		if ((irqflags & IRQF_SHARED) == 0)
+			bdata->can_disable = true;
 	}
 
 	error = request_irq(irq, gpio_keys_isr, irqflags, desc, bdata);
@@ -148,6 +432,10 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		goto fail1;
 	}
 
+	ddata->input = input;
+	ddata->n_buttons = pdata->nbuttons;
+	mutex_init(&ddata->disable_lock);
+
 	platform_set_drvdata(pdev, ddata);
 
 	input->name = pdev->name;
@@ -163,8 +451,6 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 	if (pdata->rep)
 		__set_bit(EV_REP, input->evbit);
 
-	ddata->input = input;
-
 	for (i = 0; i < pdata->nbuttons; i++) {
 		struct gpio_keys_button *button = &pdata->buttons[i];
 		struct gpio_button_data *bdata = &ddata->data[i];
@@ -173,7 +459,7 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		bdata->input = input;
 		bdata->button = button;
 
-		error = gpio_keys_setup_key(dev, bdata, button);
+		error = gpio_keys_setup_key(pdev, bdata, button);
 		if (error)
 			goto fail2;
 
@@ -183,17 +469,26 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		input_set_capability(input, type, button->code);
 	}
 
-	error = input_register_device(input);
+	error = sysfs_create_group(&pdev->dev.kobj, &gpio_keys_attr_group);
 	if (error) {
-		dev_err(dev, "Unable to register input device, "
-			"error: %d\n", error);
+		dev_err(dev, "Unable to export keys/switches, error: %d\n",
+			error);
 		goto fail2;
 	}
 
+	error = input_register_device(input);
+	if (error) {
+		dev_err(dev, "Unable to register input device, error: %d\n",
+			error);
+		goto fail3;
+	}
+
 	device_init_wakeup(&pdev->dev, wakeup);
 
 	return 0;
 
+ fail3:
+	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
  fail2:
 	while (--i >= 0) {
 		free_irq(gpio_to_irq(pdata->buttons[i].gpio), &ddata->data[i]);
@@ -218,10 +513,13 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 	struct input_dev *input = ddata->input;
 	int i;
 
+	sysfs_remove_group(&pdev->dev.kobj, &gpio_keys_attr_group);
+
 	device_init_wakeup(&pdev->dev, 0);
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int irq = gpio_to_irq(pdata->buttons[i].gpio);
+
 		free_irq(irq, &ddata->data[i]);
 		if (pdata->buttons[i].debounce_interval)
 			del_timer_sync(&ddata->data[i].timer);
-- 
1.5.6.5

