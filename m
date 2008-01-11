From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: rfkill-input understanding help
Date: Fri, 11 Jan 2008 03:23:37 +0000
Message-ID: <200801110323.38279.carlos@strangeworlds.co.uk>
References: <200712110333.40946.carlos@strangeworlds.co.uk> <200712310100.18764.carlos@strangeworlds.co.uk> <200801022010.21109.IvDoorn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:36293 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760103AbYAKDXm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Jan 2008 22:23:42 -0500
In-Reply-To: <200801022010.21109.IvDoorn@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ivo van Doorn <ivdoorn@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Well, the good news is that the code I have appears to work. But, I have 
something very strange going on with my kernel (latest ACPI git tree + 
acer-wmi on top) and rfkill-input.

Basically, if I either:

1) Build rfkill-input into the kernel

or

2) Build rfkill-input as a module, and use kmod to load it from acer-wmi

Then rfkill-input doesn't work.

If I load rfkill-input manually (or if already loaded by kmod; unload and
then reload), everything works as expected. The (in progress) code to add
rfkill support to acer-wmi is here (in case the problem is something wrong
with the code) - as you can see, it's mostly based on the b43 work.

My kernel config is here, in case I'm missing something obvious:
http://files.strangeworlds.co.uk/config-acpi-git-20080111

For reference, the patch series that this ('acpi-wmi-rfkill') is part of
(of which only 'wmi' and 'acpi-wmi' are relevant) is here:
http://files.strangeworlds.co.uk/wmi/

-Carlos
---
acer-wmi: Add rfkill support

From: Carlos Corbacho <carlos@strangeworlds.co.uk>

Add initial rfkill support for acer-wmi
---

 drivers/misc/acer-wmi.c |  215 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 214 insertions(+), 1 deletions(-)


diff --git a/drivers/misc/acer-wmi.c b/drivers/misc/acer-wmi.c
index 6150120..5f6adc0 100644
--- a/drivers/misc/acer-wmi.c
+++ b/drivers/misc/acer-wmi.c
@@ -34,6 +34,9 @@
 #include <linux/platform_device.h>
 #include <linux/acpi.h>
 #include <linux/i8042.h>
+#include <linux/rfkill.h>
+#include <linux/input-polldev.h>
+#include <linux/kmod.h>
 
 #include <acpi/acpi_drivers.h>
 
@@ -710,6 +713,213 @@ static void __init acer_commandline_init(void)
 }
 
 /*
+ * RF Kill devices
+ */
+struct acer_rfkill {
+	struct rfkill *wireless;
+	u32 wcap;
+	struct rfkill *bluetooth;
+	u32 bcap;
+};
+
+static struct acer_rfkill acer_rfk;
+
+struct acer_input {
+	struct input_polled_dev *wireless;
+	struct input_polled_dev *bluetooth;
+};
+
+static struct acer_input acer_poll;
+
+static void acer_rfkill_poll(struct input_polled_dev *poll_dev)
+{
+	struct rfkill *rfk = poll_dev->private;
+	u32 cap = *((u32 *) rfk->data);
+	u32 enabled, keycode, *state;
+
+	get_u32(&enabled, cap);
+
+	switch (cap) {
+	case ACER_CAP_WIRELESS:
+		keycode = KEY_WLAN;
+		state = &interface->data.wireless;
+		break;
+	case ACER_CAP_BLUETOOTH:
+		keycode = KEY_BLUETOOTH;
+		state = &interface->data.bluetooth;
+		break;
+	default:
+		return;
+	}
+
+	if (unlikely(enabled != *state)) {
+		printk(ACER_INFO "Radio state changed\n");
+		*state = enabled;
+		input_report_key(poll_dev->input, keycode, 1);
+		input_report_key(poll_dev->input, keycode, 0);
+	}
+}
+
+static int acer_rfkill_toggle(void *data, enum rfkill_state rfk_state)
+{
+	u32 cap = *((u32 *) data);
+	u32 *state;
+
+	printk(ACER_INFO "Setting cap for %u\n", cap);
+
+	switch (cap) {
+	case ACER_CAP_WIRELESS:
+		state = &interface->data.wireless;
+		break;
+	case ACER_CAP_BLUETOOTH:
+		state = &interface->data.bluetooth;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	switch (rfk_state) {
+	case RFKILL_STATE_ON:
+		printk(ACER_INFO "Turning on\n");
+		set_u32(1, cap);
+		*state = 1;
+		break;
+	case RFKILL_STATE_OFF:
+		printk(ACER_INFO "Turning off\n");
+		set_u32(0, cap);
+		*state = 0;
+		break;
+	}
+
+	return 0;
+}
+
+static int acer_rfkill_init_device(struct device **dev, struct rfkill **rfk_dev,
+struct input_polled_dev **rfk_poll_dev, u32 cap, u32 type, char *name)
+{
+	int err;
+	u32 *data;
+	u32 keycode = 0;
+	struct rfkill *rfk;
+	struct input_polled_dev *rfk_poll;
+
+	printk(ACER_INFO "Allocating rfkill device\n");
+	rfk = rfkill_allocate(*dev, type);
+	if (!rfk_dev)
+		goto error;
+
+	rfk->name = name;
+	rfk->state = RFKILL_STATE_ON;
+	rfk->toggle_radio = acer_rfkill_toggle;
+	data = kzalloc(sizeof(u32), GFP_KERNEL);
+	if (!data)
+		goto error_free_rfk;
+
+	*data = cap;
+	rfk->data = data;
+
+	printk(ACER_INFO "Allocating polled device\n");
+	rfk_poll = input_allocate_polled_device();
+	if (!rfk_poll)
+		goto error_free_rfk;
+
+	rfk_poll->private = rfk;
+	rfk_poll->poll = acer_rfkill_poll;
+	rfk_poll->poll_interval = 1000;
+
+	rfk_poll->input->name = rfk->name;
+	rfk_poll->input->id.bustype = BUS_HOST;
+	rfk_poll->input->evbit[0] = BIT(EV_KEY);
+
+	switch (cap) {
+	case ACER_CAP_WIRELESS:
+		keycode = KEY_WLAN;
+		break;
+	case ACER_CAP_BLUETOOTH:
+		keycode = KEY_BLUETOOTH;
+		break;
+	}
+	set_bit(keycode, rfk_poll->input->keybit);
+
+	printk(ACER_INFO "Registering rfkill device\n");
+	err = rfkill_register(rfk);
+	if (err)
+		goto error_free_polldev;
+
+	err = input_register_polled_device(rfk_poll);
+	if (err)
+		goto error_unreg_rfk;
+
+	*rfk_dev = rfk;
+	*rfk_poll_dev = rfk_poll;
+
+	return 0;
+
+error_unreg_rfk:
+	rfkill_unregister(*rfk_dev);
+error_free_polldev:
+	input_free_polled_device(*rfk_poll_dev);
+error_free_rfk:
+	kfree(data);
+	rfkill_free(*rfk_dev);
+error:
+	return -ENODEV;
+}
+
+static int acer_rfkill_init(struct device *dev)
+{
+	int err;
+
+	printk(ACER_INFO "Initialising RFKILL devices\n");
+
+	if (has_cap(ACER_CAP_WIRELESS)) {
+		err = acer_rfkill_init_device(&dev, &acer_rfk.wireless,
+			&acer_poll.wireless, ACER_CAP_WIRELESS,
+			RFKILL_TYPE_WLAN, "acer-wireless");
+		if (err)
+			return -ENODEV;
+	}
+
+	if (has_cap(ACER_CAP_BLUETOOTH)) {
+		err = acer_rfkill_init_device(&dev, &acer_rfk.bluetooth,
+			&acer_poll.bluetooth, ACER_CAP_BLUETOOTH,
+			RFKILL_TYPE_BLUETOOTH, "acer-bluetooth");
+		if (err)
+			return -ENODEV;
+	}
+
+#ifdef CONFIG_RFKILL_INPUT_MODULE
+	/* acer-wmi RF-kill isn't useful without the rfkill-input subsystem.
+	 * Try to load the module. */
+	err = request_module("rfkill-input");
+	if (err)
+		printk(ACER_INFO "Failed to load the rfkill-input module. "
+			"The built-in radio LED will not work.\n");
+#endif /* CONFIG_RFKILL_INPUT */
+
+	return 0;
+}
+
+static void acer_rfkill_exit_device(struct rfkill *rfk_dev,
+struct input_polled_dev *rfk_poll_dev)
+{
+	input_unregister_polled_device(rfk_poll_dev);
+	rfkill_unregister(rfk_dev);
+	input_free_polled_device(rfk_poll_dev);
+	kfree(rfk_dev->data);
+	rfkill_free(rfk_dev);
+}
+
+static void acer_rfkill_exit(void)
+{
+	if (has_cap(ACER_CAP_WIRELESS))
+		acer_rfkill_exit_device(acer_rfk.wireless, acer_poll.wireless);
+
+	if (has_cap(ACER_CAP_BLUETOOTH))
+		acer_rfkill_exit_device(acer_rfk.bluetooth, acer_poll.bluetooth);
+}
+
+/*
  * LED device (Mail LED only, no other LEDs known yet)
  */
 static void mail_led_set(struct led_classdev *led_cdev,
@@ -842,7 +1052,8 @@ static int __devinit acer_platform_probe(struct platform_device *device)
 		acer_led_init(&device->dev);
 	if (has_cap(ACER_CAP_BRIGHTNESS))
 		acer_backlight_init(&device->dev);
-	return 0;
+
+	return acer_rfkill_init(&device->dev);
 }
 
 static int acer_platform_remove(struct platform_device *device)
@@ -851,6 +1062,8 @@ static int acer_platform_remove(struct platform_device *device)
 		acer_led_exit();
 	if (has_cap(ACER_CAP_BRIGHTNESS))
 		acer_backlight_exit();
+
+	acer_rfkill_exit();
 	return 0;
 }
 
