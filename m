From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] atlas_btns - add loadable kemap support
Date: Tue, 18 Sep 2007 01:05:11 -0400
Message-ID: <200709180105.12315.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
Cc: jayakumar.acpi@gmail.com
List-Id: linux-input@vger.kernel.org

Hi,

The following patch adds support for loadable keymaps to atlas_btns
driver. If anyone has this hardware I woudl appreciate if you could
test the patch.

I think the easiest way to test is with keyfuzz:

	http://0pointer.de/lennart/projects/keyfuzz/

This driver uses 0-15 range of "scancodes".

Thank you.

-- 
Dmitry


Input: atlas_btns - add support for loadable keymaps

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/input/misc/atlas_btns.c |   37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

Index: linux/drivers/input/misc/atlas_btns.c
===================================================================
--- linux.orig/drivers/input/misc/atlas_btns.c
+++ linux/drivers/input/misc/atlas_btns.c
@@ -29,9 +29,10 @@
 #include <asm/uaccess.h>
 #include <acpi/acpi_drivers.h>
 
-#define ACPI_ATLAS_NAME			"Atlas ACPI"
-#define ACPI_ATLAS_CLASS		"Atlas"
+#define ACPI_ATLAS_NAME		"Atlas ACPI"
+#define ACPI_ATLAS_CLASS	"Atlas"
 
+static unsigned short atlas_keymap[16];
 static struct input_dev *input_dev;
 
 /* button handling code */
@@ -50,12 +51,15 @@ static acpi_status acpi_atlas_button_han
 		      void *handler_context, void *region_context)
 {
 	acpi_status status;
-	int keycode;
 
 	if (function == ACPI_WRITE) {
-		keycode = KEY_F1 + (address & 0x0F);
-		input_report_key(input_dev, keycode, !(address & 0x10));
+		int code = address & 0x0f;
+		int key_down = !(address & 0x10);
+
+		input_event(input_dev, EV_MSC, MSC_SCAN, code);
+		input_report_key(input_dev, atlas_keymap[code], key_down);
 		input_sync(input_dev);
+
 		status = 0;
 	} else {
 		printk(KERN_WARNING "atlas: shrugged on unexpected function"
@@ -70,6 +74,7 @@ static acpi_status acpi_atlas_button_han
 static int atlas_acpi_button_add(struct acpi_device *device)
 {
 	acpi_status status;
+	int i;
 	int err;
 
 	input_dev = input_allocate_device();
@@ -81,17 +86,19 @@ static int atlas_acpi_button_add(struct 
 	input_dev->name = "Atlas ACPI button driver";
 	input_dev->phys = "ASIM0000/atlas/input0";
 	input_dev->id.bustype = BUS_HOST;
-	input_dev->evbit[LONG(EV_KEY)] = BIT(EV_KEY);
+	input_dev->keycode = atlas_keymap;
+	input_dev->keycodesize = sizeof(unsigned short);
+	input_dev->keycodemax = ARRAY_SIZE(atlas_keymap);
 
-	set_bit(KEY_F1, input_dev->keybit);
-	set_bit(KEY_F2, input_dev->keybit);
-	set_bit(KEY_F3, input_dev->keybit);
-	set_bit(KEY_F4, input_dev->keybit);
-	set_bit(KEY_F5, input_dev->keybit);
-	set_bit(KEY_F6, input_dev->keybit);
-	set_bit(KEY_F7, input_dev->keybit);
-	set_bit(KEY_F8, input_dev->keybit);
-	set_bit(KEY_F9, input_dev->keybit);
+	input_set_capability(input_dev, EV_MSC, MSC_SCAN);
+	__set_bit(EV_KEY, input_dev->evbit);
+	for (i = 0; i < ARRAY_SIZE(atlas_keymap); i++) {
+		if (i < 9) {
+			atlas_keymap[i] = KEY_F1 + i;
+			__set_bit(KEY_F1 + i, input_dev->keybit);
+		} else
+			atlas_keymap[i] = KEY_RESERVED;
+	}
 
 	err = input_register_device(input_dev);
 	if (err) {
