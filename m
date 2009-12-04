From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 1/9] Input: add generic support for sparse keymaps
Date: Thu, 03 Dec 2009 22:11:58 -0800
Message-ID: <20091204061158.28288.17664.stgit@localhost.localdomain>
References: <20091204060701.28288.91430.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:55857 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbZLDGLy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Dec 2009 01:11:54 -0500
In-Reply-To: <20091204060701.28288.91430.stgit@localhost.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>, Harald Welte <laforge@gnumonks.org>, Corentin Chary <corentincj@iksaif.net>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Wu Zhangjin <wuzhangjin@gmail.com>, Anisse Astier <anisse@astier.eu>

More and more devices choose to reimplement support for sparse keymaps
first introduced by wistron driver. Move it into a library module so it
can be easily used by interested parties.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 Documentation/DocBook/device-drivers.tmpl |    4 
 drivers/input/Kconfig                     |   28 ++-
 drivers/input/Makefile                    |    1 
 drivers/input/input-polldev.c             |   14 +-
 drivers/input/sparse-keymap.c             |  251 +++++++++++++++++++++++++++++
 include/linux/input/sparse-keymap.h       |   62 +++++++
 6 files changed, 348 insertions(+), 12 deletions(-)
 create mode 100644 drivers/input/sparse-keymap.c
 create mode 100644 include/linux/input/sparse-keymap.h

diff --git a/Documentation/DocBook/device-drivers.tmpl b/Documentation/DocBook/device-drivers.tmpl
index e994d1d..f9a6e2c 100644
--- a/Documentation/DocBook/device-drivers.tmpl
+++ b/Documentation/DocBook/device-drivers.tmpl
@@ -306,6 +306,10 @@ X!Idrivers/video/console/fonts.c
      <sect1><title>Matrix keyboars/keypads</title>
 !Iinclude/linux/input/matrix_keypad.h
      </sect1>
+     <sect1><title>Sparse keymap support</title>
+!Iinclude/linux/input/sparse-keymap.h
+!Edrivers/input/sparse-keymap.c
+     </sect1>
   </chapter>
 
   <chapter id="spi">
diff --git a/drivers/input/Kconfig b/drivers/input/Kconfig
index cd50c00..50af91e 100644
--- a/drivers/input/Kconfig
+++ b/drivers/input/Kconfig
@@ -8,7 +8,7 @@ menu "Input device support"
 config INPUT
 	tristate "Generic input layer (needed for keyboard, mouse, ...)" if EMBEDDED
 	default y
-	---help---
+	help
 	  Say Y here if you have any input device (mouse, keyboard, tablet,
 	  joystick, steering wheel ...) connected to your system and want
 	  it to be available to applications. This includes standard PS/2
@@ -27,8 +27,7 @@ if INPUT
 
 config INPUT_FF_MEMLESS
 	tristate "Support for memoryless force-feedback devices"
-	default n
-	---help---
+	help
 	  Say Y here if you have memoryless force-feedback input device
 	  such as Logitech WingMan Force 3D, ThrustMaster FireStorm Dual
 	  Power 2, or similar. You will also need to enable hardware-specific
@@ -52,12 +51,25 @@ config INPUT_POLLDEV
 	  To compile this driver as a module, choose M here: the
 	  module will be called input-polldev.
 
+config INPUT_SPARSEKMAP
+	tristate "Sparse keymap support library"
+	help
+	  Say Y here if you are using a driver for an input
+	  device that uses sparse keymap. This option is only
+	  useful for out-of-tree drivers since in-tree drivers
+	  select it automatically.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sparse-keymap.
+
 comment "Userland interfaces"
 
 config INPUT_MOUSEDEV
 	tristate "Mouse interface" if EMBEDDED
 	default y
-	---help---
+	help
 	  Say Y here if you want your mouse to be accessible as char devices
 	  13:32+ - /dev/input/mouseX and 13:63 - /dev/input/mice as an
 	  emulated IntelliMouse Explorer PS/2 mouse. That way, all user space
@@ -73,7 +85,7 @@ config INPUT_MOUSEDEV_PSAUX
 	bool "Provide legacy /dev/psaux device"
 	default y
 	depends on INPUT_MOUSEDEV
-	---help---
+	help
 	  Say Y here if you want your mouse also be accessible as char device
 	  10:1 - /dev/psaux. The data available through /dev/psaux is exactly
 	  the same as the data from /dev/input/mice.
@@ -103,7 +115,7 @@ config INPUT_MOUSEDEV_SCREEN_Y
 
 config INPUT_JOYDEV
 	tristate "Joystick interface"
-	---help---
+	help
 	  Say Y here if you want your joystick or gamepad to be
 	  accessible as char device 13:0+ - /dev/input/jsX device.
 
@@ -125,7 +137,7 @@ config INPUT_EVDEV
 
 config INPUT_EVBUG
 	tristate "Event debugging"
-	---help---
+	help
 	  Say Y here if you have a problem with the input subsystem and
 	  want all events (keypresses, mouse movements), to be output to
 	  the system log. While this is useful for debugging, it's also
@@ -140,7 +152,7 @@ config INPUT_EVBUG
 config INPUT_APMPOWER
 	tristate "Input Power Event -> APM Bridge" if EMBEDDED
 	depends on INPUT && APM_EMULATION
-	---help---
+	help
 	  Say Y here if you want suspend key events to trigger a user
 	  requested suspend through APM. This is useful on embedded
 	  systems where such behaviour is desired without userspace
diff --git a/drivers/input/Makefile b/drivers/input/Makefile
index 4c9c745..7ad212d 100644
--- a/drivers/input/Makefile
+++ b/drivers/input/Makefile
@@ -9,6 +9,7 @@ input-core-objs := input.o input-compat.o ff-core.o
 
 obj-$(CONFIG_INPUT_FF_MEMLESS)	+= ff-memless.o
 obj-$(CONFIG_INPUT_POLLDEV)	+= input-polldev.o
+obj-$(CONFIG_INPUT_SPARSEKMAP)	+= sparse-keymap.o
 
 obj-$(CONFIG_INPUT_MOUSEDEV)	+= mousedev.o
 obj-$(CONFIG_INPUT_JOYDEV)	+= joydev.o
diff --git a/drivers/input/input-polldev.c b/drivers/input/input-polldev.c
index 6a2eb39..aa6713b 100644
--- a/drivers/input/input-polldev.c
+++ b/drivers/input/input-polldev.c
@@ -212,7 +212,7 @@ EXPORT_SYMBOL(input_allocate_polled_device);
  * @dev: device to free
  *
  * The function frees memory allocated for polling device and drops
- * reference to the associated input device (if present).
+ * reference to the associated input device.
  */
 void input_free_polled_device(struct input_polled_dev *dev)
 {
@@ -258,6 +258,15 @@ int input_register_polled_device(struct input_polled_dev *dev)
 		return error;
 	}
 
+	/*
+	 * Take extra reference to the underlying input device so
+	 * that it survives call to input_unregister_polled_device()
+	 * and is deleted only after input_free_polled_device()
+	 * has been invoked. This is needed to ease task of freeing
+	 * sparse keymaps.
+	 */
+	input_get_device(input);
+
 	return 0;
 }
 EXPORT_SYMBOL(input_register_polled_device);
@@ -269,8 +278,6 @@ EXPORT_SYMBOL(input_register_polled_device);
  * The function unregisters previously registered polled input
  * device from input layer. Polling is stopped and device is
  * ready to be freed with call to input_free_polled_device().
- * Callers should not attempt to access dev->input pointer
- * after calling this function.
  */
 void input_unregister_polled_device(struct input_polled_dev *dev)
 {
@@ -278,7 +285,6 @@ void input_unregister_polled_device(struct input_polled_dev *dev)
 			   &input_polldev_attribute_group);
 
 	input_unregister_device(dev->input);
-	dev->input = NULL;
 }
 EXPORT_SYMBOL(input_unregister_polled_device);
 
diff --git a/drivers/input/sparse-keymap.c b/drivers/input/sparse-keymap.c
new file mode 100644
index 0000000..4655c56
--- /dev/null
+++ b/drivers/input/sparse-keymap.c
@@ -0,0 +1,251 @@
+/*
+ * Generic support for sparse keymaps
+ *
+ * Copyright (c) 2009 Dmitry Torokhov
+ *
+ * Derived from wistron button driver:
+ * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
+ * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
+ * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#include <linux/input.h>
+#include <linux/input/sparse-keymap.h>
+
+MODULE_AUTHOR("Dmitry Torokhov <dtor@mail.ru>");
+MODULE_DESCRIPTION("Generic support for sparse keymaps");
+MODULE_LICENSE("GPL v2");
+MODULE_VERSION("0.1");
+
+/**
+ * sparse_keymap_entry_from_scancode - perform sparse keymap lookup
+ * @dev: Input device using sparse keymap
+ * @code: Scan code
+ *
+ * This function is used to perform &struct key_entry lookup in an
+ * input device using sparse keymap.
+ */
+struct key_entry *sparse_keymap_entry_from_scancode(struct input_dev *dev,
+						    unsigned int code)
+{
+	struct key_entry *key;
+
+	for (key = dev->keycode; key->type != KE_END; key++)
+		if (code == key->code)
+			return key;
+
+	return NULL;
+}
+EXPORT_SYMBOL(sparse_keymap_entry_from_scancode);
+
+/**
+ * sparse_keymap_entry_from_keycode - perform sparse keymap lookup
+ * @dev: Input device using sparse keymap
+ * @keycode: Key code
+ *
+ * This function is used to perform &struct key_entry lookup in an
+ * input device using sparse keymap.
+ */
+struct key_entry *sparse_keymap_entry_from_keycode(struct input_dev *dev,
+						   unsigned int keycode)
+{
+	struct key_entry *key;
+
+	for (key = dev->keycode; key->type != KE_END; key++)
+		if (key->type == KE_KEY && keycode == key->keycode)
+			return key;
+
+	return NULL;
+}
+EXPORT_SYMBOL(sparse_keymap_entry_from_keycode);
+
+static int sparse_keymap_getkeycode(struct input_dev *dev,
+				    int scancode, int *keycode)
+{
+	const struct key_entry *key =
+			sparse_keymap_entry_from_scancode(dev, scancode);
+
+	if (key && key->type == KE_KEY) {
+		*keycode = key->keycode;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int sparse_keymap_setkeycode(struct input_dev *dev,
+				    int scancode, int keycode)
+{
+	struct key_entry *key;
+	int old_keycode;
+
+	if (keycode < 0 || keycode > KEY_MAX)
+		return -EINVAL;
+
+	key = sparse_keymap_entry_from_scancode(dev, scancode);
+	if (key && key->type == KE_KEY) {
+		old_keycode = key->keycode;
+		key->keycode = keycode;
+		set_bit(keycode, dev->keybit);
+		if (!sparse_keymap_entry_from_keycode(dev, old_keycode))
+			clear_bit(old_keycode, dev->keybit);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+EXPORT_SYMBOL(sparse_keymap_setkeycode);
+
+/**
+ * sparse_keymap_setup - set up sparse keymap for an input device
+ * @dev: Input device
+ * @keymap: Keymap in form of array of &key_entry structures ending
+ *	with %KE_END type entry
+ * @setup: Function that can be used to adjust keymap entries
+ *	depending on device's deeds, may be %NULL
+ *
+ * The function calculates size and allocates copy of the original
+ * keymap after which sets up input device event bits appropriately.
+ * Before detsroying input device allocated keymap should be freed
+ * with a call to sparse_keymap_free().
+ */
+int sparse_keymap_setup(struct input_dev *dev,
+			const struct key_entry *keymap,
+			int (*setup)(struct input_dev *, struct key_entry *))
+{
+	size_t map_size = 1; /* to account for the last KE_END entry */
+	const struct key_entry *e;
+	struct key_entry *map, *entry;
+	int i;
+	int error;
+
+	for (e = keymap; e->type != KE_END; e++)
+		map_size++;
+
+	map = kcalloc(map_size, sizeof (struct key_entry), GFP_KERNEL);
+	if (!map)
+		return -ENOMEM;
+
+	memcpy(map, keymap, map_size * sizeof (struct key_entry));
+
+	for (i = 0; i < map_size; i++) {
+		entry = &map[i];
+
+		if (setup) {
+			error = setup(dev, entry);
+			if (error)
+				goto err_out;
+		}
+
+		switch (entry->type) {
+		case KE_KEY:
+			__set_bit(EV_KEY, dev->evbit);
+			__set_bit(entry->keycode, dev->keybit);
+			break;
+
+		case KE_SW:
+			__set_bit(EV_SW, dev->evbit);
+			__set_bit(entry->sw.code, dev->swbit);
+			break;
+		}
+	}
+
+	dev->keycode = map;
+	dev->keycodemax = map_size;
+	dev->getkeycode = sparse_keymap_getkeycode;
+	dev->setkeycode = sparse_keymap_setkeycode;
+
+	return 0;
+
+ err_out:
+	kfree(keymap);
+	return error;
+
+}
+EXPORT_SYMBOL(sparse_keymap_setup);
+
+/**
+ * sparse_keymap_free - free memory allocated for sparse keymap
+ * @dev: Input device using sparse keymap
+ *
+ * This function is used to free memory allocated by sparse keymap
+ * in an input device that was set up by sparse_keymap_setup().
+ */
+void sparse_keymap_free(struct input_dev *dev)
+{
+	kfree(dev->keycode);
+	dev->keycode = NULL;
+	dev->keycodemax = 0;
+	dev->getkeycode = NULL;
+	dev->setkeycode = NULL;
+}
+EXPORT_SYMBOL(sparse_keymap_free);
+
+/**
+ * sparse_keymap_report_event - report event corresponding to given key entry
+ * @dev: Input device for which event should be reported
+ * @ke: key entry describing event
+ * @value: Value that should be reported (ignored by %KE_SW entries)
+ * @autorelease: Signals whether release event should be emitted for %KE_KEY
+ *	entries right after reporting press event, ignored by all other
+ *	entries
+ *
+ * This function is used to report input event described by given
+ * &struct key_entry.
+ */
+void sparse_keymap_report_entry(struct input_dev *dev, const struct key_entry *ke,
+				unsigned int value, bool autorelease)
+{
+	switch (ke->type) {
+	case KE_KEY:
+		input_report_key(dev, ke->keycode, value);
+		input_sync(dev);
+		if (value && autorelease) {
+			input_report_key(dev, ke->keycode, 0);
+			input_sync(dev);
+		}
+		break;
+
+	case KE_SW:
+		value = ke->sw.value;
+		/* fall through */
+
+	case KE_VSW:
+		input_report_switch(dev, ke->sw.code, value);
+		break;
+	}
+}
+EXPORT_SYMBOL(sparse_keymap_report_entry);
+
+/**
+ * sparse_keymap_report_event - report event corresponding to given scancode
+ * @dev: Input device using sparse keymap
+ * @code: Scan code
+ * @value: Value that should be reported (ignored by %KE_SW entries)
+ * @autorelease: Signals whether release event should be emitted for %KE_KEY
+ *	entries right after reporting press event, ignored by all other
+ *	entries
+ *
+ * This function is used to perform lookup in an input device using sparse
+ * keymap and report corresponding event. Returns %true if lookup was
+ * successful and %false otherwise.
+ */
+bool sparse_keymap_report_event(struct input_dev *dev, unsigned int code,
+				unsigned int value, bool autorelease)
+{
+	const struct key_entry *ke =
+		sparse_keymap_entry_from_scancode(dev, code);
+
+	if (ke) {
+		sparse_keymap_report_entry(dev, ke, value, autorelease);
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL(sparse_keymap_report_event);
+
diff --git a/include/linux/input/sparse-keymap.h b/include/linux/input/sparse-keymap.h
new file mode 100644
index 0000000..52db620
--- /dev/null
+++ b/include/linux/input/sparse-keymap.h
@@ -0,0 +1,62 @@
+#ifndef _SPARSE_KEYMAP_H
+#define _SPARSE_KEYMAP_H
+
+/*
+ * Copyright (c) 2009 Dmitry Torokhov
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+#define KE_END		0	/* Indicates end of keymap */
+#define KE_KEY		1	/* Ordinary key/button */
+#define KE_SW		2	/* Switch (predetermined value) */
+#define KE_VSW		3	/* Switch (value supplied at runtime) */
+#define KE_IGNORE	4	/* Known entry that should be ignored */
+#define KE_LAST		KE_IGNORE
+
+/**
+ * struct key_entry - keymap entry for use in sparse keymap
+ * @type: Type of the key entry (KE_KEY, KE_SW, KE_VSW, KE_END);
+ *	drivers are allowed to extend the list with their own
+ *	private definitions.
+ * @code: Device-specific data identifying the button/switch
+ * @keycode: KEY_* code assigned to a key/button
+ * @sw.code: SW_* code assigned to a switch
+ * @sw.value: Value that should be sent in an input even when KE_SW
+ *	switch is toggled. KE_VSW switches ignore this field and
+ *	expect driver to supply value for the event.
+ *
+ * This structure defines an entry in a sparse keymap used by some
+ * input devices for which traditional table-based approach is not
+ * suitable.
+ */
+struct key_entry {
+	int type;		/* See KE_* above */
+	u32 code;
+	union {
+		u16 keycode;		/* For KE_KEY */
+		struct {		/* For KE_SW, KE_VSW */
+			u8 code;
+			u8 value;	/* For KE_SW, ignored by KE_VSW */
+		} sw;
+	};
+};
+
+struct key_entry *sparse_keymap_entry_from_scancode(struct input_dev *dev,
+						    unsigned int code);
+struct key_entry *sparse_keymap_entry_from_keycode(struct input_dev *dev,
+						   unsigned int code);
+int sparse_keymap_setup(struct input_dev *dev,
+			const struct key_entry *keymap,
+			int (*setup)(struct input_dev *, struct key_entry *));
+void sparse_keymap_free(struct input_dev *dev);
+
+void sparse_keymap_report_entry(struct input_dev *dev, const struct key_entry *ke,
+				unsigned int value, bool autorelease);
+
+bool sparse_keymap_report_event(struct input_dev *dev, unsigned int code,
+				unsigned int value, bool autorelease);
+
+#endif /* _SPARSE_KEYMAP_H */

