From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH RFC] HID: cp2112: add IRQ chip handling
Date: Mon, 21 Nov 2016 12:07:54 +0100
Message-ID: <1479726474-31532-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753240AbcKULH6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 21 Nov 2016 06:07:58 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ellen Wang <ellen@cumulusnetworks.com>, Antonio Borneo <borneo.antonio@gmail.com>, David Barksdale <dbarksdale@uplogix.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

The GPIO part doesn't provide interrupts when GPIO are toggled.
So use a polling mechanism if someone requests a GPIO as an IRQ.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

I am currently running this patch in my local tree.
It allows to attach a SMBus device completely on the CP2112, with a simple
definition at the end of probe:

	{
		struct i2c_client *client;
		struct i2c_hid_platform_data pdata = {
			.hid_descriptor_address = 0x20,
		};
		struct i2c_board_info synaptics_info = {
			I2C_BOARD_INFO("hid", 0x2c),
			.platform_data = &pdata,
		};
		int irq = cp2112_allocate_irq(dev, 2);

		if (irq <= 0) {
			dev_err(dev->gc.parent, "Failed to translate GPIO to IRQ\n");
			goto err_sysfs_remove;
		}

		synaptics_info.irq = irq;
		irq_set_irq_type(irq, IRQ_TYPE_LEVEL_LOW);

		hid_device_io_start(hdev);

		/* give time for the device to initialize */
		msleep(500);

		client = i2c_new_device(&dev->adap, &synaptics_info);
		if (!client)
			hid_err(hdev, "failed allocating Synaptics device\n");

	}

I wonder if we want to consider this upstream, given that the driver is only
used for development.

Note: this patch applies on top of https://patchwork.kernel.org/patch/9439225/

Cheers,
Benjamin

 drivers/hid/hid-cp2112.c | 205 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 60d3020..f31a778 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -24,6 +24,7 @@
  *   http://www.silabs.com/Support%20Documents/TechnicalDocs/AN495.pdf
  */
 
+#include <linux/gpio.h>
 #include <linux/gpio/driver.h>
 #include <linux/hid.h>
 #include <linux/i2c.h>
@@ -168,6 +169,12 @@ struct cp2112_device {
 	struct gpio_chip gc;
 	u8 *in_out_buffer;
 	spinlock_t lock;
+
+	struct gpio_desc *desc[8];
+	bool gpio_poll;
+	struct delayed_work gpio_poll_worker;
+	unsigned long irq_mask;
+	u8 gpio_prev_state;
 };
 
 static int gpio_push_pull = 0xFF;
@@ -233,7 +240,7 @@ static void cp2112_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
 	spin_unlock_irqrestore(&dev->lock, flags);
 }
 
-static int cp2112_gpio_get(struct gpio_chip *chip, unsigned offset)
+static int cp2112_gpio_get_all(struct gpio_chip *chip)
 {
 	struct cp2112_device *dev = gpiochip_get_data(chip);
 	struct hid_device *hdev = dev->hdev;
@@ -252,7 +259,7 @@ static int cp2112_gpio_get(struct gpio_chip *chip, unsigned offset)
 		goto exit;
 	}
 
-	ret = (buf[1] >> offset) & 1;
+	ret = buf[1];
 
 exit:
 	spin_unlock_irqrestore(&dev->lock, flags);
@@ -260,6 +267,17 @@ static int cp2112_gpio_get(struct gpio_chip *chip, unsigned offset)
 	return ret;
 }
 
+static int cp2112_gpio_get(struct gpio_chip *chip, unsigned int offset)
+{
+	int ret;
+
+	ret = cp2112_gpio_get_all(chip);
+	if (ret < 0)
+		return ret;
+
+	return (ret >> offset) & 1;
+}
+
 static int cp2112_gpio_direction_output(struct gpio_chip *chip,
 					unsigned offset, int value)
 {
@@ -1041,6 +1059,166 @@ static void chmod_sysfs_attrs(struct hid_device *hdev)
 	}
 }
 
+static void cp2112_gpio_irq_ack(struct irq_data *d)
+{
+}
+
+static void cp2112_gpio_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct cp2112_device *dev = gpiochip_get_data(gc);
+
+	__clear_bit(d->hwirq, &dev->irq_mask);
+}
+
+static void cp2112_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct cp2112_device *dev = gpiochip_get_data(gc);
+
+	__set_bit(d->hwirq, &dev->irq_mask);
+}
+
+static void cp2112_gpio_poll_callback(struct work_struct *work)
+{
+	struct cp2112_device *dev = container_of(work, struct cp2112_device,
+						 gpio_poll_worker.work);
+	struct irq_data *d;
+	u8 gpio_mask;
+	u8 virqs = (u8)dev->irq_mask;
+	u32 irq_type;
+	int irq, virq, ret;
+
+	ret = cp2112_gpio_get_all(&dev->gc);
+	if (ret == -ENODEV) /* the hardware has been disconnected */
+		return;
+	if (ret < 0)
+		goto exit;
+
+	gpio_mask = ret;
+
+	while (virqs) {
+		virq = ffs(virqs) - 1;
+		virqs &= ~BIT(virq);
+
+		if (!dev->gc.to_irq)
+			break;
+
+		irq = dev->gc.to_irq(&dev->gc, virq);
+
+		d = irq_get_irq_data(irq);
+		if (!d)
+			continue;
+
+		irq_type = irqd_get_trigger_type(d);
+
+		if (gpio_mask & BIT(virq)) {
+			/* Level High */
+
+			if (irq_type & IRQ_TYPE_LEVEL_HIGH)
+				handle_nested_irq(irq);
+
+			if ((irq_type & IRQ_TYPE_EDGE_RISING) &&
+			    !(dev->gpio_prev_state & BIT(virq)))
+				handle_nested_irq(irq);
+		} else {
+			/* Level Low */
+
+			if (irq_type & IRQ_TYPE_LEVEL_LOW)
+				handle_nested_irq(irq);
+
+			if ((irq_type & IRQ_TYPE_EDGE_FALLING) &&
+			    (dev->gpio_prev_state & BIT(virq)))
+				handle_nested_irq(irq);
+		}
+	}
+
+	dev->gpio_prev_state = gpio_mask;
+
+exit:
+	if (dev->gpio_poll)
+		schedule_delayed_work(&dev->gpio_poll_worker, 10);
+}
+
+
+static unsigned int cp2112_gpio_irq_startup(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct cp2112_device *dev = gpiochip_get_data(gc);
+
+	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
+
+	cp2112_gpio_direction_input(gc, d->hwirq);
+
+	if (!dev->gpio_poll) {
+		dev->gpio_poll = true;
+		schedule_delayed_work(&dev->gpio_poll_worker, 0);
+	}
+
+	cp2112_gpio_irq_unmask(d);
+	return 0;
+}
+
+static void cp2112_gpio_irq_shutdown(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct cp2112_device *dev = gpiochip_get_data(gc);
+
+	cancel_delayed_work_sync(&dev->gpio_poll_worker);
+}
+
+static int cp2112_gpio_irq_type(struct irq_data *d, unsigned int type)
+{
+	return 0;
+}
+
+static struct irq_chip cp2112_gpio_irqchip = {
+	.name = "cp2112-gpio",
+	.irq_startup = cp2112_gpio_irq_startup,
+	.irq_shutdown = cp2112_gpio_irq_shutdown,
+	.irq_ack = cp2112_gpio_irq_ack,
+	.irq_mask = cp2112_gpio_irq_mask,
+	.irq_unmask = cp2112_gpio_irq_unmask,
+	.irq_set_type = cp2112_gpio_irq_type,
+};
+
+static int __maybe_unused cp2112_allocate_irq(struct cp2112_device *dev,
+					      int pin)
+{
+	int ret;
+
+	if (dev->desc[pin])
+		return -EINVAL;
+
+	dev->desc[pin] = gpiochip_request_own_desc(&dev->gc, pin,
+						   "HID/I2C:Event");
+	if (IS_ERR(dev->desc[pin])) {
+		dev_err(dev->gc.parent, "Failed to request GPIO\n");
+		return PTR_ERR(dev->desc[pin]);
+	}
+
+	ret = gpiochip_lock_as_irq(&dev->gc, pin);
+	if (ret) {
+		dev_err(dev->gc.parent, "Failed to lock GPIO as interrupt\n");
+		goto err_desc;
+	}
+
+	ret = gpiod_to_irq(dev->desc[pin]);
+	if (ret < 0) {
+		dev_err(dev->gc.parent, "Failed to translate GPIO to IRQ\n");
+		goto err_lock;
+	}
+
+	return ret;
+
+err_lock:
+	gpiochip_unlock_as_irq(&dev->gc, pin);
+err_desc:
+	gpiochip_free_own_desc(dev->desc[pin]);
+	dev->desc[pin] = NULL;
+	return ret;
+}
+
 static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	struct cp2112_device *dev;
@@ -1163,8 +1341,17 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	chmod_sysfs_attrs(hdev);
 	hid_hw_power(hdev, PM_HINT_NORMAL);
 
+	ret = gpiochip_irqchip_add(&dev->gc, &cp2112_gpio_irqchip, 0,
+				   handle_simple_irq, IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(dev->gc.parent, "failed to add IRQ chip\n");
+		goto err_sysfs_remove;
+	}
+
 	return ret;
 
+err_sysfs_remove:
+	sysfs_remove_group(&hdev->dev.kobj, &cp2112_attr_group);
 err_gpiochip_remove:
 	gpiochip_remove(&dev->gc);
 err_free_i2c:
@@ -1181,10 +1368,22 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void cp2112_remove(struct hid_device *hdev)
 {
 	struct cp2112_device *dev = hid_get_drvdata(hdev);
+	int i;
 
 	sysfs_remove_group(&hdev->dev.kobj, &cp2112_attr_group);
-	gpiochip_remove(&dev->gc);
 	i2c_del_adapter(&dev->adap);
+
+	if (dev->gpio_poll) {
+		dev->gpio_poll = false;
+		cancel_delayed_work_sync(&dev->gpio_poll_worker);
+	}
+
+	for (i = 0; i < ARRAY_SIZE(dev->desc); i++) {
+		gpiochip_unlock_as_irq(&dev->gc, i);
+		gpiochip_free_own_desc(dev->desc[i]);
+	}
+
+	gpiochip_remove(&dev->gc);
 	/* i2c_del_adapter has finished removing all i2c devices from our
 	 * adapter. Well behaved devices should no longer call our cp2112_xfer
 	 * and should have waited for any pending calls to finish. It has also
-- 
2.7.4

