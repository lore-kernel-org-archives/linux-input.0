From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/2] Input: Mac button emulation - implement as input filter
Date: Thu, 10 Sep 2009 22:28:29 -0700
Message-ID: <20090911052829.26911.49515.stgit@localhost.localdomain>
References: <20090911052720.26911.67943.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:48865 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbZIKF22 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Sep 2009 01:28:28 -0400
Received: by mail-pz0-f184.google.com with SMTP id 14so651216pzk.1
        for <linux-input@vger.kernel.org>; Thu, 10 Sep 2009 22:28:32 -0700 (PDT)
In-Reply-To: <20090911052720.26911.67943.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: mjg@redhat.com

Current implementation of Mac mouse button emulation plugs into legacy
keyboard driver, converts certain keys into button events on a separate
device and suppresses the real events from reaching tty. This worked
well enough until user space started using evdev which was completely
unaware of this arrangement and kept sending original key presses to
its users. Change the implementation to use newly added input filter
framework so that original key presses are not transmitted to any
handlers.

As a bonus remove SYSCTL dependencies from the code and use Kconfig
instead; also do not create the emulated mouse device until user
activates emulation.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/char/keyboard.c     |    5 -
 drivers/macintosh/Kconfig   |    1 
 drivers/macintosh/mac_hid.c |  257 +++++++++++++++++++++++++++++++------------
 include/linux/kbd_kern.h    |    3 -
 4 files changed, 186 insertions(+), 80 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 737be95..83a1a9d 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1168,11 +1168,6 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 
 	rep = (down == 2);
 
-#ifdef CONFIG_MAC_EMUMOUSEBTN
-	if (mac_hid_mouse_emulate_buttons(1, keycode, down))
-		return;
-#endif /* CONFIG_MAC_EMUMOUSEBTN */
-
 	if ((raw_mode = (kbd->kbdmode == VC_RAW)) && !hw_raw)
 		if (emulate_raw(vc, keycode, !down << 7))
 			if (keycode < BTN_MISC && printk_ratelimit())
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 3d90683..aa3c27e 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -172,6 +172,7 @@ config INPUT_ADBHID
 
 config MAC_EMUMOUSEBTN
 	bool "Support for mouse button 2+3 emulation"
+	depends on SYSCTL
 	select INPUT
 	help
 	  This provides generic support for emulating the 2nd and 3rd mouse
diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index cc9f275..4c5d93d 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -13,17 +13,191 @@
 #include <linux/sysctl.h>
 #include <linux/input.h>
 #include <linux/module.h>
-#include <linux/kbd_kern.h>
 
-
-static struct input_dev *emumousebtn;
-static int emumousebtn_input_register(void);
 static int mouse_emulate_buttons;
 static int mouse_button2_keycode = KEY_RIGHTCTRL;	/* right control key */
 static int mouse_button3_keycode = KEY_RIGHTALT;	/* right option key */
-static int mouse_last_keycode;
 
-#if defined(CONFIG_SYSCTL)
+static struct input_dev *mac_hid_emumouse_dev;
+
+static int mac_hid_create_emumouse(void)
+{
+	static struct lock_class_key mac_hid_emumouse_dev_event_class;
+	static struct lock_class_key mac_hid_emumouse_dev_mutex_class;
+	int err;
+
+	mac_hid_emumouse_dev = input_allocate_device();
+	if (!mac_hid_emumouse_dev)
+		return -ENOMEM;
+
+	lockdep_set_class(&mac_hid_emumouse_dev->event_lock,
+			  &mac_hid_emumouse_dev_event_class);
+	lockdep_set_class(&mac_hid_emumouse_dev->mutex,
+			  &mac_hid_emumouse_dev_mutex_class);
+
+	mac_hid_emumouse_dev->name = "Macintosh mouse button emulation";
+	mac_hid_emumouse_dev->id.bustype = BUS_ADB;
+	mac_hid_emumouse_dev->id.vendor = 0x0001;
+	mac_hid_emumouse_dev->id.product = 0x0001;
+	mac_hid_emumouse_dev->id.version = 0x0100;
+
+	mac_hid_emumouse_dev->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
+	mac_hid_emumouse_dev->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_LEFT) |
+		BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT);
+	mac_hid_emumouse_dev->relbit[0] = BIT_MASK(REL_X) | BIT_MASK(REL_Y);
+
+	err = input_register_device(mac_hid_emumouse_dev);
+	if (err) {
+		input_free_device(mac_hid_emumouse_dev);
+		mac_hid_emumouse_dev = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+static void mac_hid_destroy_emumouse(void)
+{
+	input_unregister_device(mac_hid_emumouse_dev);
+	mac_hid_emumouse_dev = NULL;
+}
+
+static bool mac_hid_emumouse_filter(struct input_handle *handle,
+				    unsigned int type, unsigned int code,
+				    int value)
+{
+	unsigned int btn;
+
+	if (type != EV_KEY)
+		return false;
+
+	if (code == mouse_button2_keycode)
+		btn = BTN_MIDDLE;
+	else if (code == mouse_button3_keycode)
+		btn = BTN_RIGHT;
+	else
+		return false;
+
+	input_report_key(mac_hid_emumouse_dev, btn, value);
+	input_sync(mac_hid_emumouse_dev);
+
+	return true;
+}
+
+static int mac_hid_emumouse_connect(struct input_handler *handler,
+				    struct input_dev *dev,
+				    const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int error;
+
+	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = dev;
+	handle->handler = handler;
+	handle->name = "mac-btn-emul";
+
+	error = input_register_handle(handle);
+	if (error) {
+		printk(KERN_ERR
+			"mac_hid: Failed to register button emulation handle, "
+			"error %d\n", error);
+		goto err_free;
+	}
+
+	error = input_open_device(handle);
+	if (error) {
+		printk(KERN_ERR
+			"mac_hid: Failed to open input device, error %d\n",
+			error);
+		goto err_unregister;
+	}
+
+	return 0;
+
+ err_unregister:
+	input_unregister_handle(handle);
+ err_free:
+	kfree(handle);
+	return error;
+}
+
+static void mac_hid_emumouse_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static const struct input_device_id mac_hid_emumouse_ids[] = {
+	{
+		.flags = INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit = { BIT_MASK(EV_KEY) },
+	},
+	{ },
+};
+
+MODULE_DEVICE_TABLE(input, mac_hid_emumouse_ids);
+
+static struct input_handler mac_hid_emumouse_handler = {
+	.filter		= mac_hid_emumouse_filter,
+	.connect	= mac_hid_emumouse_connect,
+	.disconnect	= mac_hid_emumouse_disconnect,
+	.name		= "mac-btn-emul",
+	.id_table	= mac_hid_emumouse_ids,
+};
+
+static int mac_hid_start_emulation(void)
+{
+	int err;
+
+	err = mac_hid_create_emumouse();
+	if (err)
+		return err;
+
+	err = input_register_handler(&mac_hid_emumouse_handler);
+	if (err) {
+		mac_hid_destroy_emumouse();
+		return err;
+	}
+
+	return 0;
+}
+
+static void mac_hid_stop_emulation(void)
+{
+	mac_hid_destroy_emumouse();
+	input_unregister_handler(&mac_hid_emumouse_handler);
+}
+
+static int mac_hid_toggle_emumouse(ctl_table *table, int write,
+				   struct file *filp, void __user *buffer,
+				   size_t *lenp, loff_t *ppos)
+{
+	int *valp = table->data;
+	int old_val = *valp;
+	int rc;
+
+	rc = proc_dointvec(table, write, filp, buffer, lenp, ppos);
+
+	if (rc == 0 && write && *valp != old_val) {
+		if (*valp == 1)
+			rc = mac_hid_start_emulation();
+		else if (*valp == 0)
+			mac_hid_stop_emulation();
+		else
+			rc = -EINVAL;
+	}
+
+	/* Restore the old value in case of error */
+	if (rc)
+		*valp = old_val;
+
+	return rc;
+}
+
 /* file(s) in /proc/sys/dev/mac_hid */
 static ctl_table mac_hid_files[] = {
 	{
@@ -32,7 +206,7 @@ static ctl_table mac_hid_files[] = {
 		.data		= &mouse_emulate_buttons,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= mac_hid_toggle_emumouse,
 	},
 	{
 		.ctl_name	= DEV_MAC_HID_MOUSE_BUTTON2_KEYCODE,
@@ -40,7 +214,7 @@ static ctl_table mac_hid_files[] = {
 		.data		= &mouse_button2_keycode,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= proc_dointvec,
 	},
 	{
 		.ctl_name	= DEV_MAC_HID_MOUSE_BUTTON3_KEYCODE,
@@ -48,7 +222,7 @@ static ctl_table mac_hid_files[] = {
 		.data		= &mouse_button3_keycode,
 		.maxlen		= sizeof(int),
 		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
+		.proc_handler	= proc_dointvec,
 	},
 	{ .ctl_name = 0 }
 };
@@ -79,73 +253,12 @@ static ctl_table mac_hid_root_dir[] = {
 
 static struct ctl_table_header *mac_hid_sysctl_header;
 
-#endif /* endif CONFIG_SYSCTL */
-
-int mac_hid_mouse_emulate_buttons(int caller, unsigned int keycode, int down)
-{
-	switch (caller) {
-	case 1:
-		/* Called from keyboard.c */
-		if (mouse_emulate_buttons
-		    && (keycode == mouse_button2_keycode
-			|| keycode == mouse_button3_keycode)) {
-			if (mouse_emulate_buttons == 1) {
-				input_report_key(emumousebtn,
-						 keycode == mouse_button2_keycode ? BTN_MIDDLE : BTN_RIGHT,
-						 down);
-				input_sync(emumousebtn);
-				return 1;
-			}
-			mouse_last_keycode = down ? keycode : 0;
-		}
-		break;
-	}
-	return 0;
-}
-
-static struct lock_class_key emumousebtn_event_class;
-static struct lock_class_key emumousebtn_mutex_class;
-
-static int emumousebtn_input_register(void)
-{
-	int ret;
-
-	emumousebtn = input_allocate_device();
-	if (!emumousebtn)
-		return -ENOMEM;
-
-	lockdep_set_class(&emumousebtn->event_lock, &emumousebtn_event_class);
-	lockdep_set_class(&emumousebtn->mutex, &emumousebtn_mutex_class);
-
-	emumousebtn->name = "Macintosh mouse button emulation";
-	emumousebtn->id.bustype = BUS_ADB;
-	emumousebtn->id.vendor = 0x0001;
-	emumousebtn->id.product = 0x0001;
-	emumousebtn->id.version = 0x0100;
-
-	emumousebtn->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_REL);
-	emumousebtn->keybit[BIT_WORD(BTN_MOUSE)] = BIT_MASK(BTN_LEFT) |
-		BIT_MASK(BTN_MIDDLE) | BIT_MASK(BTN_RIGHT);
-	emumousebtn->relbit[0] = BIT_MASK(REL_X) | BIT_MASK(REL_Y);
-
-	ret = input_register_device(emumousebtn);
-	if (ret)
-		input_free_device(emumousebtn);
-
-	return ret;
-}
 
 static int __init mac_hid_init(void)
 {
-	int err;
-
-	err = emumousebtn_input_register();
-	if (err)
-		return err;
-
-#if defined(CONFIG_SYSCTL)
 	mac_hid_sysctl_header = register_sysctl_table(mac_hid_root_dir);
-#endif /* CONFIG_SYSCTL */
+	if (!mac_hid_sysctl_header)
+		return -ENOMEM;
 
 	return 0;
 }
diff --git a/include/linux/kbd_kern.h b/include/linux/kbd_kern.h
index 8bdb16b..506ad20 100644
--- a/include/linux/kbd_kern.h
+++ b/include/linux/kbd_kern.h
@@ -161,7 +161,4 @@ static inline void con_schedule_flip(struct tty_struct *t)
 	schedule_delayed_work(&t->buf.work, 0);
 }
 
-/* mac_hid.c */
-extern int mac_hid_mouse_emulate_buttons(int, unsigned int, int);
-
 #endif

