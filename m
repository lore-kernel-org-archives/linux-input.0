From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 4/7] usbhid: add hid_quirks module parameter
Date: Sun, 18 Mar 2007 22:22:00 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0703182042480.21893@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-input@atrey.karlin.mff.cuni.cz
List-Id: linux-input@vger.kernel.org

From: Paul Walmsley <paul@booyaka.com>

Add a new module parameter, usbhid.hid_quirks, which can be used to
modify the HID quirks list.

Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  dev/drivers/usb/input/hid-core.c |  131 +++++++++++++++++++++++++++++++++++++++
  1 file changed, 131 insertions(+)

Index: linux/dev/drivers/usb/input/hid-core.c
===================================================================
--- linux.orig/dev/drivers/usb/input/hid-core.c
+++ linux/dev/drivers/usb/input/hid-core.c
@@ -55,6 +55,31 @@ module_param_named(mousepoll, hid_mousep
  MODULE_PARM_DESC(mousepoll, "Polling interval of mice");

  /*
+ * MAX_USBHID_QUIRK_LEN: maximum length limit for a single HID quirk entry.
+ * 3 16-bit hex numbers and 1 32-bit hex number, each prefixed with 0x
+ * and space-separated, terminated by a newline or comma
+ */
+#define MAX_USBHID_QUIRK_LEN (3*(2+4+1)+1*(2+8)+1)
+/*
+ * Increase this if you need to configure lots of HID quirks at boot
+ */
+static char param_hid_quirks[MAX_USBHID_QUIRK_LEN * 4];
+/*
+ * Example of hid_quirks usage: passing "hid_quirks=0xcd5:0x1:0xffff:0x4" at
+ * boot tells the USB HID driver to ignore (0x4) vendor ID 0x0cd5, product
+ * ID 0x0001.  The 0xffff is a mask that is ANDed with the product ID
+ * before testing.  0xffff will match against only one product ID, but
+ * lesser values will cause the quirk to cover multiple products by the
+ * same vendor. HID quirk values are defined in include/linux/hid.h
+ */
+module_param_string(hid_quirks, param_hid_quirks, sizeof(param_hid_quirks), 0);
+MODULE_PARM_DESC(hid_quirks, "Modify USB HID quirks by specifying "
+		 " hid_quirks=vendorID:productID:productMask:quirks"
+		 "[,v:p:m:q ...] where vendorID, productID, productMask,"
+		 " and quirks are all in 0x-prefixed hexadecimal");
+
+
+/*
   * Input submission and I/O error handler.
   */

@@ -1070,6 +1095,94 @@ static void hid_fixup_s510_descriptor(un
  }

  /**
+ * modify_quirk_list: add/replace/remove a HID quirk from the quirks list
+ * @quirk_buf: a text string describing the HID quirk
+ *
+ * Description:
+ *     Given a string containing a HID quirk description -
+ *     a 16-bit hexadecimal vendor ID prefixed by 0x, a colon,
+ *     a 16-bit hexadecimal product ID prefixed by 0x,  a colon, and
+ *     a 16-bit hexadecimal product ID mask prefixed by 0x,  a colon, and
+ *     a 32-bit hexadecimal quirks bitfield prefixed by 0x -
+ *     test to see if it exists in the quirks_list.  If not, the
+ *     new quirk data is added.  Otherwise, if the quirks bitfield is 0,
+ *     remove the quirk from the list; if the quirks bitfield is non-zero,
+ *     replace the existing quirk information with the user-specified
+ *     quirks.
+ *
+ * Returns: 0 OK, -error on failure.
+ */
+static int modify_quirk_list(const char *quirk_buf)
+{
+	struct quirks_list_struct *q_new, *q;
+	int list_edited = 0, m = 0;
+	char c;
+
+	/* Allocate space for the quirks_list_struct */
+	q_new = kmalloc(sizeof(struct quirks_list_struct), GFP_KERNEL);
+	if (!q_new) {
+		dbg("Could not allocate quirks_list_struct");
+		return -ENOMEM;
+	}
+
+	/* Parse the quirk_buf string into a quirks_list_struct */
+	m = sscanf(quirk_buf, "0x%hx%c0x%hx%c0x%hx%c0x%x",
+		   &q_new->hid_bl_item.idVendor, &c,
+		   &q_new->hid_bl_item.idProduct, &c,
+		   &q_new->hid_bl_item.idProductMask, &c,
+		   &q_new->hid_bl_item.quirks);
+	if (m != 7) {
+		dbg("modify_quirk_list parse error");
+		kfree(q_new);
+		return -EINVAL;
+	}
+
+	/* Iterate through the list looking for this (idVendor, idProduct,
+	 * idProductMask) triple.  If we find it, delete or replace the list
+	 * entry (depending on the contents of quirks).  Otherwise, add the
+	 * entry at the end of the list.
+	 */
+	down_write(&quirks_list_rwsem);
+	list_for_each_entry(q, &quirks_list, node) {
+		if (q->hid_bl_item.idVendor == q_new->hid_bl_item.idVendor &&
+		    q->hid_bl_item.idProduct == q_new->hid_bl_item.idProduct &&
+		    q->hid_bl_item.idProductMask == q_new->hid_bl_item.idProductMask) {
+			/*
+			 * This entry already exists in the list -
+			 * delete or replace the old entry
+			 */
+			if (q_new->hid_bl_item.quirks == 0) {
+				list_del(&q->node);
+				kfree(q_new);
+			} else {
+				list_replace(&q->node, &q_new->node);
+			}
+
+			kfree(q);
+			list_edited = 1;
+			break;
+		}
+	}
+
+	/* If we didn't edit the list, we mustn't have found an existing
+	 * entry, so add the new quirk to the end of the list
+	 */
+	if (!list_edited)
+		if (q_new->hid_bl_item.quirks != 0) {
+			list_add_tail(&q_new->node, &quirks_list);
+		} else {
+			/* Cannot add a quirk of 0x0 */
+			kfree(q_new);
+			return -EINVAL;
+		}
+
+	up_write(&quirks_list_rwsem);
+
+	return 0;
+}
+
+
+/**
   * usbhid_quirks_init: copy the hid_blacklist[] into the quirks_list
   *
   * Description:
@@ -1081,6 +1194,8 @@ static void hid_fixup_s510_descriptor(un
  static int usbhid_quirks_init(void)
  {
  	struct quirks_list_struct *q;
+	char *quirk_buf = param_hid_quirks;
+	char *next_quirk_buf = param_hid_quirks;
  	int i;

  	for (i = 0; hid_blacklist[i].idVendor != 0; i++) {
@@ -1097,6 +1212,22 @@ static int usbhid_quirks_init(void)
  		list_add_tail(&q->node, &quirks_list);
  	}

+	/*
+	 * Read the hid_quirks module parameter list and modify quirks
+	 * appropriately
+	 */
+	while (*quirk_buf != '\0') {
+		if (modify_quirk_list(quirk_buf) != 0)
+			printk("Could not parse HID quirk module parameter\n");
+
+		/* Find next comma */
+		next_quirk_buf = strchr(quirk_buf, ',');
+		if (!next_quirk_buf)
+			break;
+
+		quirk_buf = next_quirk_buf + 1;
+	}
+
  	return 0;
  }
