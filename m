From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information through sysfs
Date: Fri, 23 Oct 2009 15:15:46 +0300
Message-ID: <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:61964 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbZJWMTs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 23 Oct 2009 08:19:48 -0400
In-Reply-To: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com>
In-Reply-To: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>

In some embedded devices gpio lines are used as keys/buttons
through input layer and gpio-keys.  It is, however, impossible
to disable gpio lines separately from waking up the cpu.  For
example when device is locked we don't want accidental camera
button press to cause the device to wakeup just to notice that
it should continue sleeping.

This patch exports gpio-keys through sysfs and allows userland
to control whether single gpio line should wakeup the cpu or not.

Sysfs interface is accessible via:

	/sys/class/input/gpio-keys/input/input0/gpio-key.N/

Following attributes are exported per gpio key:

	/code    ... input event code (ro)
	/type    ... input event type (ro)
	/desc    ... description of the button (ro)
	/disable ... enable/disable gpio line (rw)

Userspace should be able to find out what key to disable/enable
by investigating {code, type, desc} tuple.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 drivers/input/keyboard/gpio_keys.c |  162 ++++++++++++++++++++++++++++++++++++
 1 files changed, 162 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index a88aff3..76e7c5c 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -31,6 +31,8 @@ struct gpio_button_data {
 	struct input_dev *input;
 	struct timer_list timer;
 	struct work_struct work;
+	struct device *dev;	/* device used to export button to sysfs */
+	bool disable;		/* is this gpio button disabled */
 };
 
 struct gpio_keys_drvdata {
@@ -38,6 +40,159 @@ struct gpio_keys_drvdata {
 	struct gpio_button_data data[0];
 };
 
+/*
+ * gpio-keys sysfs interface
+ *
+ * Following interface is export to userspace through
+ * sysfs.  This interface can be used to enable/disable
+ * single GPIO lines from generating events.
+ *
+ * /sys/class/input/gpio-keys/input/input0/gpio-key.N/
+ * 	/code	 ... input event code (ro)
+ *	/type	 ... input event type (ro)
+ *	/desc	 ... description of the button (ro)
+ *	/disable ... enable/disable gpio line from
+ *	             generating events (rw)
+ *
+ * Userspace program can enumerate these keys and based
+ * on {code,type,desc} tuple disable or enable the line
+ * depending on the system state.
+ */
+
+static ssize_t gpio_keys_code_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	const struct gpio_button_data *bdata = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", bdata->button->code);
+}
+
+static DEVICE_ATTR(code, S_IRUGO, gpio_keys_code_show, NULL);
+
+static ssize_t gpio_keys_type_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	const struct gpio_button_data *bdata = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", bdata->button->type);
+}
+
+static DEVICE_ATTR(type, S_IRUGO, gpio_keys_type_show, NULL);
+
+static ssize_t gpio_keys_desc_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	const struct gpio_button_data *bdata = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", bdata->button->desc);
+}
+
+static DEVICE_ATTR(desc, S_IRUGO, gpio_keys_desc_show, NULL);
+
+static ssize_t gpio_keys_disable_show(struct device *dev,
+	struct device_attribute *attr, char *buf)
+{
+	const struct gpio_button_data *bdata = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n", (int)bdata->disable);
+}
+
+static ssize_t gpio_keys_disable_store(struct device *dev,
+	struct device_attribute *attr, const char *buf, size_t size)
+{
+	struct gpio_button_data *bdata = dev_get_drvdata(dev);
+	int val;
+
+	if (sscanf(buf, "%d", &val) != 1)
+		return -EINVAL;
+
+	val = !!val;
+	if (bdata->disable == val)
+		return size;
+
+	if (val) {
+		disable_irq(gpio_to_irq(bdata->button->gpio));
+	} else {
+		enable_irq(gpio_to_irq(bdata->button->gpio));
+	}
+
+	bdata->disable = val;
+	return size;
+}
+
+static DEVICE_ATTR(disable, S_IWUSR | S_IRUGO,
+	gpio_keys_disable_show, gpio_keys_disable_store);
+
+static struct attribute *gpio_keys_attrs[] = {
+	&dev_attr_code.attr,
+	&dev_attr_type.attr,
+	&dev_attr_desc.attr,
+	&dev_attr_disable.attr,
+	NULL,
+};
+
+static const struct attribute_group gpio_keys_attr_group = {
+	.attrs = gpio_keys_attrs,
+};
+
+static void gpio_keys_unexport(struct platform_device *pdev)
+{
+	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		struct gpio_button_data *bdata = &ddata->data[i];
+
+		if (bdata->dev != NULL) {
+			sysfs_remove_group(&bdata->dev->kobj,
+				&gpio_keys_attr_group);
+			device_unregister(bdata->dev);
+			bdata->dev = NULL;
+		}
+	}
+}
+
+static int gpio_keys_export(struct platform_device *pdev)
+{
+	struct gpio_keys_platform_data *pdata = pdev->dev.platform_data;
+	struct gpio_keys_drvdata *ddata = platform_get_drvdata(pdev);
+	struct input_dev *input = ddata->input;
+	int i, error = 0;
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		struct gpio_button_data *bdata = &ddata->data[i];
+		struct device *dev;
+
+		/*
+		 * We create one "device" per gpio line that is used
+		 * as input gpio key device.
+		 */
+		dev = device_create(input->dev.class, &input->dev,
+			MKDEV(0, 0), bdata, "gpio-key.%d", i);
+		if (dev == NULL) {
+			error = -ENOMEM;
+			break;
+		}
+
+		error = sysfs_create_group(&dev->kobj, &gpio_keys_attr_group);
+		if (error != 0) {
+			device_unregister(dev);
+			break;
+		}
+
+		bdata->disable = false;
+		bdata->dev = dev;
+	}
+
+	if (error != 0) {
+		/* something failed, clean up all entries */
+		gpio_keys_unexport(pdev);
+	}
+
+	return error;
+}
+
 static void gpio_keys_report_event(struct work_struct *work)
 {
 	struct gpio_button_data *bdata =
@@ -170,6 +325,12 @@ static int __devinit gpio_keys_probe(struct platform_device *pdev)
 		goto fail2;
 	}
 
+	error = gpio_keys_export(pdev);
+	if (error) {
+		pr_warning("gpio-keys: Unable to export gpio-keys to sysfs, "
+			" error %d", error);
+	}
+
 	device_init_wakeup(&pdev->dev, wakeup);
 
 	return 0;
@@ -199,6 +360,7 @@ static int __devexit gpio_keys_remove(struct platform_device *pdev)
 	int i;
 
 	device_init_wakeup(&pdev->dev, 0);
+	gpio_keys_unexport(pdev);
 
 	for (i = 0; i < pdata->nbuttons; i++) {
 		int irq = gpio_to_irq(pdata->buttons[i].gpio);
-- 
1.5.6.5

