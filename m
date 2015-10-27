From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 1/3] input: Add keyreset driver.
Date: Tue, 27 Oct 2015 09:32:33 +0100
Message-ID: <1445934753-5627-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35344 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbbJ0Ico (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Oct 2015 04:32:44 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>

Add a platform device in the board file to specify a reset key-combo.
The first time the key-combo is detected a work function that syncs
the filesystems is scheduled. If all the keys are released and then
pressed again, it calls panic. Reboot on panic should be set for
this to work.

Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/input/Kconfig    |    9 ++
 drivers/input/Makefile   |    1 +
 drivers/input/keyreset.c |  239 ++++++++++++++++++++++++++++++++++++++=
++++++++
 include/linux/keyreset.h |   28 ++++++
 4 files changed, 277 insertions(+)
 create mode 100644 drivers/input/keyreset.c
 create mode 100644 include/linux/keyreset.h

diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index a35532e..47a5143 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -187,6 +187,15 @@ config INPUT_APMPOWER
	  To compile this driver as a module, choose M here: the
	  module will be called apm-power.

+config INPUT_KEYRESET
+	tristate "Reset key"
+	depends on INPUT
+	---help---
+	  Say Y here if you want to reboot when some keys are pressed;
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called keyreset.
+
 comment "Input Device Drivers"

 source "drivers/input/keyboard/Kconfig"
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 0c9302c..f3749d5 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_INPUT_TOUCHSCREEN)	+=3D touchscreen/
 obj-$(CONFIG_INPUT_MISC)	+=3D misc/

 obj-$(CONFIG_INPUT_APMPOWER)	+=3D apm-power.o
+obj-$(CONFIG_INPUT_KEYRESET)	+=3D keyreset.o
diff --git a/drivers/input/keyreset.c b/drivers/input/keyreset.c
new file mode 100644
index 0000000..36208fe
--- /dev/null
+++ b/drivers/input/keyreset.c
@@ -0,0 +1,239 @@
+/* drivers/input/keyreset.c
+ *
+ * Copyright (C) 2008 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/input.h>
+#include <linux/keyreset.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/reboot.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+
+
+struct keyreset_state {
+	struct input_handler input_handler;
+	unsigned long keybit[BITS_TO_LONGS(KEY_CNT)];
+	unsigned long upbit[BITS_TO_LONGS(KEY_CNT)];
+	unsigned long key[BITS_TO_LONGS(KEY_CNT)];
+	spinlock_t lock;
+	int key_down_target;
+	int key_down;
+	int key_up;
+	int restart_disabled;
+	int (*reset_fn)(void);
+};
+
+int restart_requested;
+static void deferred_restart(struct work_struct *dummy)
+{
+	restart_requested =3D 2;
+	sys_sync();
+	restart_requested =3D 3;
+	kernel_restart(NULL);
+}
+static DECLARE_WORK(restart_work, deferred_restart);
+
+static void keyreset_event(struct input_handle *handle, unsigned int t=
ype,
+			   unsigned int code, int value)
+{
+	unsigned long flags;
+	struct keyreset_state *state =3D handle->private;
+
+	if (type !=3D EV_KEY)
+		return;
+
+	if (code >=3D KEY_MAX)
+		return;
+
+	if (!test_bit(code, state->keybit))
+		return;
+
+	spin_lock_irqsave(&state->lock, flags);
+	if (!test_bit(code, state->key) =3D=3D !value)
+		goto done;
+	__change_bit(code, state->key);
+	if (test_bit(code, state->upbit)) {
+		if (value) {
+			state->restart_disabled =3D 1;
+			state->key_up++;
+		} else
+			state->key_up--;
+	} else {
+		if (value)
+			state->key_down++;
+		else
+			state->key_down--;
+	}
+	if (state->key_down =3D=3D 0 && state->key_up =3D=3D 0)
+		state->restart_disabled =3D 0;
+
+	pr_debug("reset key changed %d %d new state %d-%d-%d\n", code, value,
+		 state->key_down, state->key_up, state->restart_disabled);
+
+	if (value && !state->restart_disabled &&
+	    state->key_down =3D=3D state->key_down_target) {
+		state->restart_disabled =3D 1;
+		if (restart_requested)
+			panic("keyboard reset failed, %d", restart_requested);
+		if (state->reset_fn) {
+			restart_requested =3D state->reset_fn();
+		} else {
+			pr_info("keyboard reset\n");
+			schedule_work(&restart_work);
+			restart_requested =3D 1;
+		}
+	}
+done:
+	spin_unlock_irqrestore(&state->lock, flags);
+}
+
+static int keyreset_connect(struct input_handler *handler,
+					  struct input_dev *dev,
+					  const struct input_device_id *id)
+{
+	int i;
+	int ret;
+	struct input_handle *handle;
+	struct keyreset_state *state =3D
+		container_of(handler, struct keyreset_state, input_handler);
+
+	for (i =3D 0; i < KEY_MAX; i++) {
+		if (test_bit(i, state->keybit) && test_bit(i, dev->keybit))
+			break;
+	}
+	if (i =3D=3D KEY_MAX)
+		return -ENODEV;
+
+	handle =3D kzalloc(sizeof(*handle), GFP_KERNEL);
+	if (!handle)
+		return -ENOMEM;
+
+	handle->dev =3D dev;
+	handle->handler =3D handler;
+	handle->name =3D "keyreset";
+	handle->private =3D state;
+
+	ret =3D input_register_handle(handle);
+	if (ret)
+		goto err_input_register_handle;
+
+	ret =3D input_open_device(handle);
+	if (ret)
+		goto err_input_open_device;
+
+	pr_info("using input dev %s for key reset\n", dev->name);
+
+	return 0;
+
+err_input_open_device:
+	input_unregister_handle(handle);
+err_input_register_handle:
+	kfree(handle);
+	return ret;
+}
+
+static void keyreset_disconnect(struct input_handle *handle)
+{
+	input_close_device(handle);
+	input_unregister_handle(handle);
+	kfree(handle);
+}
+
+static const struct input_device_id keyreset_ids[] =3D {
+	{
+		.flags =3D INPUT_DEVICE_ID_MATCH_EVBIT,
+		.evbit =3D { BIT_MASK(EV_KEY) },
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(input, keyreset_ids);
+
+static int keyreset_probe(struct platform_device *pdev)
+{
+	int ret;
+	int key, *keyp;
+	struct keyreset_state *state;
+	struct keyreset_platform_data *pdata =3D pdev->dev.platform_data;
+
+	if (!pdata)
+		return -EINVAL;
+
+	state =3D kzalloc(sizeof(*state), GFP_KERNEL);
+	if (!state)
+		return -ENOMEM;
+
+	spin_lock_init(&state->lock);
+	keyp =3D pdata->keys_down;
+	while ((key =3D *keyp++)) {
+		if (key >=3D KEY_MAX)
+			continue;
+		state->key_down_target++;
+		__set_bit(key, state->keybit);
+	}
+	if (pdata->keys_up) {
+		keyp =3D pdata->keys_up;
+		while ((key =3D *keyp++)) {
+			if (key >=3D KEY_MAX)
+				continue;
+			__set_bit(key, state->keybit);
+			__set_bit(key, state->upbit);
+		}
+	}
+
+	if (pdata->reset_fn)
+		state->reset_fn =3D pdata->reset_fn;
+
+	state->input_handler.event =3D keyreset_event;
+	state->input_handler.connect =3D keyreset_connect;
+	state->input_handler.disconnect =3D keyreset_disconnect;
+	state->input_handler.name =3D KEYRESET_NAME;
+	state->input_handler.id_table =3D keyreset_ids;
+	ret =3D input_register_handler(&state->input_handler);
+	if (ret) {
+		kfree(state);
+		return ret;
+	}
+	platform_set_drvdata(pdev, state);
+	return 0;
+}
+
+int keyreset_remove(struct platform_device *pdev)
+{
+	struct keyreset_state *state =3D platform_get_drvdata(pdev);
+	input_unregister_handler(&state->input_handler);
+	kfree(state);
+	return 0;
+}
+
+
+struct platform_driver keyreset_driver =3D {
+	.driver.name =3D KEYRESET_NAME,
+	.probe =3D keyreset_probe,
+	.remove =3D keyreset_remove,
+};
+
+static int __init keyreset_init(void)
+{
+	return platform_driver_register(&keyreset_driver);
+}
+
+static void __exit keyreset_exit(void)
+{
+	return platform_driver_unregister(&keyreset_driver);
+}
+
+module_init(keyreset_init);
+module_exit(keyreset_exit);
diff --git a/include/linux/keyreset.h b/include/linux/keyreset.h
new file mode 100644
index 0000000..a2ac49e
--- /dev/null
+++ b/include/linux/keyreset.h
@@ -0,0 +1,28 @@
+/*
+ * include/linux/keyreset.h - platform data structure for resetkeys dr=
iver
+ *
+ * Copyright (C) 2008 Google, Inc.
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, an=
d
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _LINUX_KEYRESET_H
+#define _LINUX_KEYRESET_H
+
+#define KEYRESET_NAME "keyreset"
+
+struct keyreset_platform_data {
+	int (*reset_fn)(void);
+	int *keys_up;
+	int keys_down[]; /* 0 terminated */
+};
+
+#endif /* _LINUX_KEYRESET_H */
--
1.7.9.5
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
