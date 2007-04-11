From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 4/6 RESEND] usbhid: add support for dynamically-created quirks
Date: Wed, 11 Apr 2007 13:09:11 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704111307040.28726@utopia.booyaka.com>
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

Add internal support for dynamically-allocated HID quirks, "dquirks"
(for "dynamic quirks").  Includes several functions to add/modify quirks
from the list.  This code is used by the next patch to implement quirk
modification upon module load.


Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  drivers/hid/usbhid/hid-quirks.c |  147 ++++++++++++++++++++++++++++++++++++++--
  include/linux/hid-quirks.h      |    2
  2 files changed, 145 insertions(+), 4 deletions(-)

Index: hid/drivers/hid/usbhid/hid-quirks.c
===================================================================
--- hid.orig/drivers/hid/usbhid/hid-quirks.c
+++ hid/drivers/hid/usbhid/hid-quirks.c
@@ -39,7 +39,9 @@
  #include "usbhid.h"

  static const struct hid_blacklist *usbhid_exists_squirk(const u16 idVendor, const u16 idProduct);
-
+static struct hid_blacklist *usbhid_exists_dquirk(const u16 idVendor, const u16 idProduct);
+static void usbhid_remove_all_dquirks(void);
+

  #define USB_VENDOR_ID_A4TECH		0x09da
  #define USB_DEVICE_ID_A4TECH_WCP32PU	0x0006
@@ -470,6 +472,16 @@ static const struct hid_blacklist {



+/* Dynamic HID quirks list - specified at runtime	 */
+struct quirks_list_struct {
+	struct hid_blacklist hid_bl_item;
+	struct list_head node;
+};
+
+static LIST_HEAD(dquirks_list);
+static DECLARE_RWSEM(dquirks_rwsem);
+
+
  /**
   * usbhid_lookup_quirk: return any quirks associated with a USB HID device
   * @idVendor: the 16-bit USB vendor ID, in native byteorder
@@ -495,9 +507,16 @@ u32 usbhid_lookup_quirk(const u16 idVend
  		    idProduct <= USB_DEVICE_ID_CODEMERCS_IOW_LAST)
  			return 0;

-	ble = usbhid_exists_squirk(idVendor, idProduct);
-	if (ble)
-		quirks = ble->quirks;
+	down_read(&dquirks_rwsem);
+
+ 	ble = usbhid_exists_dquirk(idVendor, idProduct);
+ 	if (!ble)
+ 		ble = usbhid_exists_squirk(idVendor, idProduct);
+
+ 	if (ble)
+ 		quirks = ble->quirks;
+
+ 	up_read(&dquirks_rwsem);

  	return quirks;
  }
@@ -534,3 +553,123 @@ static const struct hid_blacklist *usbhi
  	return ble;
  }

+
+/* Runtime ("dynamic") quirks manipulation functions */
+
+/**
+ * usbhid_exists_dquirk: find any dynamic quirks for a USB HID device
+ * @idVendor: the 16-bit USB vendor ID, in native byteorder
+ * @idProduct: the 16-bit USB product ID, in native byteorder
+ *
+ * Description:
+ *         Scans dquirks_list for a matching dynamic quirk and returns
+ *         the pointer to the relevant struct hid_blacklist if found.
+ *         Must be called with a read lock held on dquirks_rwsem.
+ *
+ * Returns: NULL if no quirk found, struct hid_blacklist * if found.
+ */
+static struct hid_blacklist *usbhid_exists_dquirk(const u16 idVendor,
+						  const u16 idProduct)
+{
+	struct quirks_list_struct *q;
+	struct hid_blacklist *ble = NULL;
+
+	WARN_ON(idVendor == 0);
+
+	list_for_each_entry(q, &dquirks_list, node) {
+		if (q->hid_bl_item.idVendor == idVendor &&
+		    q->hid_bl_item.idProduct == idProduct) {
+			ble = &q->hid_bl_item;
+			break;
+		}
+	}
+
+	if (ble != NULL)
+		dbg("Found dynamic quirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
+		    ble->quirks, ble->idVendor,  ble->idProduct);
+
+	return ble;
+}
+
+
+/**
+ * usbhid_modify_dquirk: add/replace a HID quirk
+ * @idVendor: the 16-bit USB vendor ID, in native byteorder
+ * @idProduct: the 16-bit USB product ID, in native byteorder
+ * @quirks: the u32 quirks value to add/replace
+ *
+ * Description:
+ *         If an dynamic quirk exists in memory for this (idVendor,
+ *         idProduct) pair, replace its quirks value with what was
+ *         provided.  Otherwise, add the quirk to the dynamic quirks list.
+ *
+ * Returns: 0 OK, -error on failure.
+ */
+int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct,
+			 const u32 quirks)
+{
+	struct quirks_list_struct *q_new, *q;
+	int list_edited = 0;
+
+	if (!idVendor) {
+		dbg("Cannot add a quirk with idVendor = 0");
+		return -EINVAL;
+	}
+
+	q_new = kmalloc(sizeof(struct quirks_list_struct), GFP_KERNEL);
+	if (!q_new) {
+		dbg("Could not allocate quirks_list_struct");
+		return -ENOMEM;
+	}
+
+	q_new->hid_bl_item.idVendor = idVendor;
+	q_new->hid_bl_item.idProduct = idProduct;
+	q_new->hid_bl_item.quirks = quirks;
+
+	down_write(&dquirks_rwsem);
+
+	list_for_each_entry(q, &dquirks_list, node) {
+
+		if (q->hid_bl_item.idVendor == idVendor &&
+		    q->hid_bl_item.idProduct == idProduct) {
+
+			list_replace(&q->node, &q_new->node);
+			kfree(q);
+			list_edited = 1;
+			break;
+
+		}
+
+	}
+
+	if (!list_edited)
+		list_add_tail(&q_new->node, &dquirks_list);
+
+	up_write(&dquirks_rwsem);
+
+	return 0;
+}
+
+
+/**
+ * usbhid_remove_all_dquirks: remove all runtime HID quirks from memory
+ *
+ * Description:
+ *         Free all memory associated with dynamic quirks - called before
+ *         module unload.
+ *
+ */
+static void usbhid_remove_all_dquirks(void)
+{
+	struct quirks_list_struct *q, *temp;
+
+	down_write(&dquirks_rwsem);
+	list_for_each_entry_safe(q, temp, &dquirks_list, node) {
+		list_del(&q->node);
+		kfree(q);
+	}
+	up_write(&dquirks_rwsem);
+
+}
+
+
Index: hid/include/linux/hid-quirks.h
===================================================================
--- hid.orig/include/linux/hid-quirks.h
+++ hid/include/linux/hid-quirks.h
@@ -31,6 +31,8 @@

  u32 usbhid_lookup_quirk(const u16 idVendor, const u16 idProduct);

+int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct, const u32 quirks);
+


  #endif /* __HID_QUIRKS_H */
