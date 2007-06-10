From: "Giel de Nijs" <giel@caffeinetrip.com>
Subject: [PATCH] input: fix broken behaviour of Dell Latitude special keys
Date: Sun, 10 Jun 2007 19:42:20 +0200
Message-ID: <929318d30706101042q25418f9aif7c1a609fd792830@mail.gmail.com>
Reply-To: giel@caffeinetrip.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-kernel@vger.kernel.org
Cc: linux-input@atrey.karlin.mff.cuni.cz, Dmitry Torokhov <dtor@insightbb.com>, Vojtech Pavlik <vojtech@suse.cz>, Matthew Garrett <mjg59@srcf.ucam.org>, Matt Domsch <matt_domsch@dell.com>, Rezwanul Kabir <rezwanul_kabir@dell.com>
List-Id: linux-input@vger.kernel.org

Hi,

Following up on http://thread.gmane.org/gmane.linux.kernel.input/1375 here's
a new patch to fix the fact that most Fn+F? special keys on (at least) the
Dell Latitude laptops don't generate a key release event.

This time, everything is contained in atkbd.c and it's strictly an in-kernel
hack for these specific laptops. The added infrastructure is also used to
implement the already present hack for the HANJA and HANGEUL keys.

A configuration option is added to avoid userspace breakage in the case that
something is depending on this broken behaviour.

Although I think the previously posted implementation is better because it is
completely configurable from userspace and thus provides a solution for
all current and future laptops with this peculiarty (I don't know if there're
more than just the Latitudes and I don't even know if all Latitudes exhibit
the same behaviour), I care more about the inclusion of any working solution
than I care about flexibility. Hence this version :).

Greetings,
Giel


Signed-off-by: Giel de Nijs <giel@caffeinetrip.com>
---

Index: linux-2.6.21.1/drivers/input/keyboard/atkbd.c
===================================================================
--- linux-2.6.21.1.orig/drivers/input/keyboard/atkbd.c	2007-06-10
19:21:46.000000000 +0200
+++ linux-2.6.21.1/drivers/input/keyboard/atkbd.c	2007-06-10
19:22:46.000000000 +0200
@@ -28,6 +28,9 @@
 #include <linux/workqueue.h>
 #include <linux/libps2.h>
 #include <linux/mutex.h>
+#ifdef CONFIG_KEYBOARD_ATKBD_DELL_SOFT_RELEASE
+#include <linux/dmi.h>
+#endif

 #define DRIVER_DESC	"AT and PS/2 keyboard driver"

@@ -126,6 +129,31 @@
          19, 25, 57, 81, 83, 92, 95, 98, 99,100,101,103,104,106,109,110
 };

+#ifdef CONFIG_KEYBOARD_ATKBD_DELL_SOFT_RELEASE
+struct soft_release_entry {
+	unsigned int length;
+	u8 *scancodes;
+};
+
+static struct soft_release_entry dell_latitude_soft_release_map = {
+	.length = 7,
+	.scancodes = (u8[]){
+		0x85, 0x86, 0x87, 0x8a, 0x8b, 0x8f, 0x93
+	}
+};
+
+static struct dmi_system_id dell_latitude_dmi_table[] = {
+	{
+		.ident = "Dell Latitude series",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Latitude"),
+		},
+	},
+	{ }
+};
+#endif
+
 #define ATKBD_CMD_SETLEDS	0x10ed
 #define ATKBD_CMD_GSCANSET	0x11f0
 #define ATKBD_CMD_SSCANSET	0x10f0
@@ -201,6 +229,7 @@

 	unsigned short id;
 	unsigned char keycode[512];
+	DECLARE_BITMAP(soft_release_mask, 512);
 	unsigned char set;
 	unsigned char translated;
 	unsigned char extra;
@@ -281,6 +310,24 @@
 	ATKBD_RET_NAK, ATKBD_RET_HANJA, ATKBD_RET_HANGEUL,
 };

+#ifdef CONFIG_KEYBOARD_ATKBD_DELL_SOFT_RELEASE
+int set_soft_release_mask(struct atkbd *atkbd, struct soft_release_entry *map)
+{
+	unsigned int l = map->length;
+	u8 *scancode = map->scancodes;
+
+	while (l) {
+		set_bit(*scancode, atkbd->soft_release_mask);
+		if (--l)
+			scancode++;
+	}
+
+	scancode = NULL;
+
+	return 0;
+}
+#endif
+
 /*
  * Checks if we should mangle the scancode to extract 'release' bit
  * in translated mode.
@@ -412,14 +459,6 @@
 			       "Some program might be trying access hardware directly.\n",
 			       data == ATKBD_RET_ACK ? "ACK" : "NAK", serio->phys);
 			goto out;
-		case ATKBD_RET_HANGEUL:
-		case ATKBD_RET_HANJA:
-			/*
-			 * These keys do not report release and thus need to be
-			 * flagged properly
-			 */
-			add_release_event = 1;
-			break;
 		case ATKBD_RET_ERR:
 			atkbd->err_count++;
 #ifdef ATKBD_DEBUG
@@ -438,6 +477,9 @@
 	if (keycode != ATKBD_KEY_NULL)
 		input_event(dev, EV_MSC, MSC_SCAN, code);

+	if (test_bit(code, atkbd->soft_release_mask))
+		add_release_event = 1;
+
 	switch (keycode) {
 		case ATKBD_KEY_NULL:
 			break;
@@ -832,6 +874,7 @@
 	int i, j;

 	memset(atkbd->keycode, 0, sizeof(atkbd->keycode));
+	bitmap_zero(atkbd->soft_release_mask, 512);

 	if (atkbd->translated) {
 		for (i = 0; i < 128; i++) {
@@ -854,6 +897,16 @@

 	atkbd->keycode[atkbd_compat_scancode(atkbd, ATKBD_RET_HANGEUL)] = KEY_HANGUEL;
 	atkbd->keycode[atkbd_compat_scancode(atkbd, ATKBD_RET_HANJA)] = KEY_HANJA;
+
+	set_bit(atkbd_compat_scancode(atkbd, ATKBD_RET_HANGEUL),
+		atkbd->soft_release_mask);
+	set_bit(atkbd_compat_scancode(atkbd, ATKBD_RET_HANJA),
+		atkbd->soft_release_mask);
+
+#ifdef CONFIG_KEYBOARD_ATKBD_DELL_SOFT_RELEASE
+	if (dmi_check_system(dell_latitude_dmi_table))
+		set_soft_release_mask(atkbd, &dell_latitude_soft_release_map);
+#endif
 }

 /*
Index: linux-2.6.21.1/drivers/input/keyboard/Kconfig
===================================================================
--- linux-2.6.21.1.orig/drivers/input/keyboard/Kconfig	2007-06-10
19:21:46.000000000 +0200
+++ linux-2.6.21.1/drivers/input/keyboard/Kconfig	2007-06-10
19:22:16.000000000 +0200
@@ -68,6 +68,17 @@
 	  right-hand column will be interpreted as the key shown in the
 	  left-hand column.

+config KEYBOARD_ATKBD_DELL_SOFT_RELEASE
+	bool "Use soft release for Dell Latitude laptops"
+	depends on DMI && KEYBOARD_ATKBD
+	default y
+	help
+	  Say Y here if you have a Dell Latitude and you want the special
+	  keys (Fn+F?) to behave as normal keys (ie, return a key press and a
+	  key release event).
+
+	  Say N if you don't want release events to be added for these keys.
+
 config KEYBOARD_SUNKBD
 	tristate "Sun Type 4 and Type 5 keyboard"
 	select SERIO
