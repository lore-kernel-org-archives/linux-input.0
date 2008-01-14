From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH, RFC] HP WMI hotkey driver, RFKill query?
Date: Mon, 14 Jan 2008 17:41:07 +0000
Message-ID: <20080114174107.GA14494@srcf.ucam.org>
References: <20071218235137.12838.75397.stgit@localhost> <20071226224812.GA32652@srcf.ucam.org> <d120d5000801030858o7a1f5112g1041186636852ab7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:43005 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYANRuh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jan 2008 12:50:37 -0500
Content-Disposition: inline
In-Reply-To: <d120d5000801030858o7a1f5112g1041186636852ab7@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, linux-input@vger.kernel.org

On Thu, Jan 03, 2008 at 11:58:02AM -0500, Dmitry Torokhov wrote:

> There is no sysfs device to attach the input device to, by any chance?

Not as far as I can tell, but I may be misinterpreting this. Carlos?

I've fixed up the other bits and updated it to match the latest WMI 
code. I've also added a couple of extra key events. The main one I'm 
worried about is KEY_WLAN. The button automatically disables the 
hardware, so it's not required that userspace do anything - however, it 
would be nice for network-manager to get the additional notification. Is 
KEY_WLAN the correct thing to be sending here? There's the added 
confusion of it also triggering the removal of the bluetooth hardware, 
but since the entire device vanishes in that case I think userspace will 
already notice.

Signed-off-by: Matthew Garrett <mjg59@srcf.ucam.org>

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 8f5c7b9..6a6dd9a 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -183,4 +183,13 @@ config HP_SDC_RTC
 	  Say Y here if you want to support the built-in real time clock
 	  of the HP SDC controller.
 
+config INPUT_HP_WMI
+       tristate "HP WMI hotkey interface"
+       depends on ACPI_WMI
+       help
+         Say Y here if you want to support WMI-based hotkeys on HP laptops.
+
+	 To compile this driver as a module, choose M here: the module will
+	 be called hp_wmiinput.
+
 endif
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 3585b50..8a3bf11 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -18,3 +18,4 @@ obj-$(CONFIG_INPUT_POWERMATE)		+= powermate.o
 obj-$(CONFIG_INPUT_YEALINK)		+= yealink.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_UINPUT)		+= uinput.o
+obj-$(CONFIG_INPUT_HP_WMI)		+= hp_wmiinput.o
\ No newline at end of file
diff --git a/drivers/input/misc/hp_wmiinput.c b/drivers/input/misc/hp_wmiinput.c
new file mode 100644
index 0000000..85da258
--- /dev/null
+++ b/drivers/input/misc/hp_wmiinput.c
@@ -0,0 +1,191 @@
+/*
+ * HP WMI hotkeys
+ *
+ * Copyright (C) 2007 Matthew Garrett <mjg59@srcf.ucam.org>
+ *
+ * Portions based on wistron_btns.c:
+ * Copyright (C) 2005 Miloslav Trmac <mitr@volny.cz>
+ * Copyright (C) 2005 Bernhard Rosenkraenzer <bero@arklinux.org>
+ * Copyright (C) 2005 Dmitry Torokhov <dtor@mail.ru>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/input.h>
+#include <acpi/acpi_drivers.h>
+
+MODULE_AUTHOR("Matthew Garrett");
+MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
+MODULE_LICENSE("GPL");
+
+MODULE_ALIAS("wmi:95F24279-4D7B-4334-9387-ACCDC67EF61C");
+
+#define HPWMI_GUID "95F24279-4D7B-4334-9387-ACCDC67EF61C"
+
+struct key_entry {
+        char type;              /* See KE_* below */
+        u8 code;
+        union {
+                u16 keycode;            /* For KE_KEY */
+                struct {                /* For KE_SW */
+                        u8 code;
+                        u8 value;
+                } sw;
+        };
+};
+
+enum {KE_KEY, KE_END };
+
+static struct key_entry hp_wmi_keymap[] = {
+	/* 0x01 seems to be docking stations? */
+	{ KE_KEY, 0x02, {KEY_BRIGHTNESSUP} },
+	{ KE_KEY, 0x03, {KEY_BRIGHTNESSDOWN} },
+	{ KE_KEY, 0x04, {KEY_HELP} },
+	{ KE_KEY, 0x05, {KEY_WLAN} },
+	{ KE_END, 0 }
+};
+
+static struct input_dev *hp_wmi_input_dev;
+
+static struct key_entry *hp_wmi_get_entry_by_scancode (int code)
+{
+	struct key_entry *key;
+
+        for (key = hp_wmi_keymap; key->type != KE_END; key++)
+                if (code == key->code)
+                        return key;
+
+        return NULL;
+}
+
+static struct key_entry *hp_wmi_get_entry_by_keycode(int keycode)
+{
+        struct key_entry *key;
+
+        for (key = hp_wmi_keymap; key->type != KE_END; key++)
+                if (key->type == KE_KEY && keycode == key->keycode)
+                        return key;
+
+        return NULL;
+}
+
+static int hp_wmi_getkeycode(struct input_dev *dev, int scancode, int *keycode)
+{
+	struct key_entry *key = hp_wmi_get_entry_by_scancode(scancode);
+
+        if (key && key->type == KE_KEY) {
+                *keycode = key->keycode;
+                return 0;
+        }
+
+        return -EINVAL;
+}
+
+static int hp_wmi_setkeycode(struct input_dev *dev, int scancode, int keycode)
+{
+	struct key_entry *key;
+
+        int old_keycode;
+
+        if (keycode < 0 || keycode > KEY_MAX)
+                return -EINVAL;
+
+        key = hp_wmi_get_entry_by_scancode(scancode);
+        if (key && key->type == KE_KEY) {
+                old_keycode = key->keycode;
+                key->keycode = keycode;
+                set_bit(keycode, dev->keybit);
+                if (!hp_wmi_get_entry_by_keycode(old_keycode))
+                        clear_bit(old_keycode, dev->keybit);
+                return 0;
+        }
+
+        return -EINVAL;
+}	
+
+void hp_wmi_notify (u32 value, void* context)
+{
+	struct acpi_buffer response = { ACPI_ALLOCATE_BUFFER, NULL };
+	static struct key_entry *key;
+	union acpi_object *obj;
+
+	wmi_get_event_data (value, &response);
+	
+	obj = (union acpi_object *) response.pointer;
+
+	if (obj && obj->type == ACPI_TYPE_BUFFER && obj->buffer.length == 8) {
+		int eventcode = *((u8 *) obj->buffer.pointer);
+		key = hp_wmi_get_entry_by_scancode (eventcode);
+		if (key) {
+			input_report_key (hp_wmi_input_dev, key->keycode, 1);
+			input_sync (hp_wmi_input_dev);
+			input_report_key (hp_wmi_input_dev, key->keycode, 0);
+			input_sync (hp_wmi_input_dev);
+		} else
+			printk (KERN_INFO "HP WMI: Unknown key pressed - %x\n",
+				eventcode);
+	} else
+		printk (KERN_INFO "HP WMI: Unknown response received\n");
+}
+
+static int __init hp_wmi_init(void)
+{
+	int err;
+	const struct key_entry *key;
+
+	if (!wmi_has_guid(HPWMI_GUID)) {
+		printk ("Unable to locate guid\n");
+		return -ENODEV;
+	}
+
+	err = wmi_install_notify_handler (HPWMI_GUID, hp_wmi_notify, NULL);
+	if (err)
+		return err;
+	
+	hp_wmi_input_dev = input_allocate_device();
+
+	hp_wmi_input_dev->name = "HP WMI hotkeys";
+	hp_wmi_input_dev->phys = "wmi/input0";
+	hp_wmi_input_dev->id.bustype = BUS_HOST;
+	hp_wmi_input_dev->getkeycode = hp_wmi_getkeycode;
+	hp_wmi_input_dev->setkeycode = hp_wmi_setkeycode;
+	
+	for (key = hp_wmi_keymap; key->type != KE_END; key++) {
+		set_bit(EV_KEY, hp_wmi_input_dev->evbit);
+		set_bit(key->keycode, hp_wmi_input_dev->keybit);
+	}
+	
+	err = input_register_device (hp_wmi_input_dev);
+
+	if (err) {
+		input_free_device (hp_wmi_input_dev);
+		return err;
+	}
+
+	return 0;
+}
+
+static void __exit hp_wmi_exit(void)
+{
+	wmi_remove_notify_handler(HPWMI_GUID);
+	input_unregister_device (hp_wmi_input_dev);
+}
+
+module_init(hp_wmi_init);
+module_exit(hp_wmi_exit);

-- 
Matthew Garrett | mjg59@srcf.ucam.org
