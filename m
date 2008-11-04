From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 2/2] macintosh: add input handler to mac_hid module.
Date: Tue,  4 Nov 2008 12:31:28 +1030
Message-ID: <1225764088-10761-3-git-send-email-peter.hutterer@who-t.net>
References: <1225764088-10761-1-git-send-email-peter.hutterer@who-t.net>
 <1225764088-10761-2-git-send-email-peter.hutterer@who-t.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ipx-119-252-190-80.ipxserver.de ([80.190.252.119]:41908 "EHLO
	ipx10616.ipxserver.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751938AbYKDCC0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Nov 2008 21:02:26 -0500
In-Reply-To: <1225764088-10761-2-git-send-email-peter.hutterer@who-t.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Peter Hutterer <peter.hutterer@redhat.com>

From: Peter Hutterer <peter.hutterer@redhat.com>

Register an input handler on all devices for macintosh mouse button emulation.
If an event from another device passes as key event to trigger the mouse
button emulation, the button event is sent through the emulation device and
the original event is discarded by the filter.
This replaces the existing emulation code in keyboard.c.

Signed-off-by: Peter Hutterer <peter.hutterer@redhat.com>
---
 drivers/char/keyboard.c     |    5 --
 drivers/macintosh/mac_hid.c |   88 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 5 deletions(-)

diff --git a/drivers/char/keyboard.c b/drivers/char/keyboard.c
index 7b3a212..3d1f657 100644
--- a/drivers/char/keyboard.c
+++ b/drivers/char/keyboard.c
@@ -1170,11 +1170,6 @@ static void kbd_keycode(unsigned int keycode, int down, int hw_raw)
 
 	rep = (down == 2);
 
-#ifdef CONFIG_MAC_EMUMOUSEBTN
-	if (mac_hid_mouse_emulate_buttons(1, keycode, down))
-		return;
-#endif /* CONFIG_MAC_EMUMOUSEBTN */
-
 	if ((raw_mode = (kbd->kbdmode == VC_RAW)) && !hw_raw)
 		if (emulate_raw(vc, keycode, !down << 7))
 			if (keycode < BTN_MISC && printk_ratelimit())
diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index cc9f275..cfbe038 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/kbd_kern.h>
 
+#define mac_hid_MINOR_BASE 64
 
 static struct input_dev *emumousebtn;
 static int emumousebtn_input_register(void);
@@ -151,3 +152,90 @@ static int __init mac_hid_init(void)
 }
 
 device_initcall(mac_hid_init);
+
+static void mac_hid_event(struct input_handle *handle,
+			  unsigned int type, unsigned int code, int value)
+{
+	return;
+}
+
+
+static int mac_hid_filter(struct input_handle *handle, unsigned int type,
+			   unsigned int code, int value)
+{
+	return mac_hid_mouse_emulate_buttons(1, code, value);
+}
+
+static int mac_hid_connect(struct input_handler *handler, struct input_dev *dev,
+			   const struct input_device_id *id)
+{
+	struct input_handle *handle;
+	int error;
+
+	handle = kzalloc(sizeof(struct input_handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev = input_get_device(dev);
+	handle->handler = handler;
+	handle->name = "mac_hid";
+
+	error = input_register_handle(handle);
+	if (error)
+		goto err_free_handle;
+
+	error = input_open_device(handle);
+	if (error)
+		goto err_unregister_handle;
+
+	return 0;
+
+err_unregister_handle:
+	input_unregister_handle(handle);
+err_free_handle:
+	kfree(handle);
+	return error;
+}
+
+static void mac_hid_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+
+static const struct input_device_id mac_hid_ids[] = {
+	{ .driver_info = 1 },	/* Matches all devices */
+	{ },			/* Terminating zero entry */
+};
+
+MODULE_DEVICE_TABLE(input, mac_hid_ids);
+
+static struct input_handler mac_hid_handler = {
+	.event		= mac_hid_event,
+	.connect	= mac_hid_connect,
+	.disconnect	= mac_hid_disconnect,
+	.filter		= mac_hid_filter,
+	.fops		= NULL,
+	.minor		= mac_hid_MINOR_BASE,
+	.name		= "mac_hid",
+	.id_table	= mac_hid_ids,
+};
+
+static int __init mac_hid_init_ih(void)
+{
+	return input_register_handler(&mac_hid_handler);
+}
+
+static void __exit mac_hid_exit_ih(void)
+{
+	input_unregister_handler(&mac_hid_handler);
+}
+
+module_init(mac_hid_init_ih);
+module_exit(mac_hid_exit_ih);
+
+MODULE_AUTHOR("Peter Hutterer <peter.hutterer@redhat.com>");
+MODULE_DESCRIPTION("Mac HID fake device");
+MODULE_LICENSE("GPL");
-- 
1.6.0.3

