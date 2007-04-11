From: Paul Walmsley <paul@booyaka.com>
Subject: [PATCH 5/7] usbhid: add support for dynamically-created quirks
Date: Wed, 11 Apr 2007 00:50:11 -0600 (MDT)
Message-ID: <Pine.LNX.4.64.0704110035380.28726@utopia.booyaka.com>
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

Add internal support for dynamically-allocated HID quirks, "equirks"
(for "extra quirks").  Includes several functions to add/modify quirks
from the list.  This code is used by the next patch to implement quirk
modification upon module load.


Signed-off-by: Paul Walmsley <paul@booyaka.com>

---
  drivers/usb/input/hid-quirks.c |  147 +++++++++++++++++++++++++++++++++++++++--
  include/linux/hid-quirks.h     |    2
  2 files changed, 145 insertions(+), 4 deletions(-)

Index: dev/drivers/usb/input/hid-quirks.c
===================================================================
--- dev.orig/drivers/usb/input/hid-quirks.c
+++ dev/drivers/usb/input/hid-quirks.c
@@ -39,6 +39,8 @@
  #include "usbhid.h"

  static struct hid_blacklist *usbhid_exists_squirk(const u16 idVendor, const u16 idProduct);
+static struct hid_blacklist *usbhid_exists_equirk(const u16 idVendor, const u16 idProduct);
+static void usbhid_remove_all_equirks(void);


  #define USB_VENDOR_ID_PANJIT		0x134c
@@ -455,6 +457,16 @@ static struct hid_blacklist {
  };


+/* Extra HID quirks list - specified at runtime  */
+struct quirks_list_struct {
+        struct hid_blacklist hid_bl_item;
+        struct list_head node;
+};
+
+static LIST_HEAD(equirks_list);
+static DECLARE_RWSEM(equirks_rwsem);
+
+
  /**
   * usbhid_lookup_any_quirk: return any quirks associated with a USB HID device
   * @idVendor: the 16-bit USB vendor ID, in native byteorder
@@ -480,10 +492,17 @@ u32 usbhid_lookup_any_quirk(const u16 id
  		    idProduct <= USB_DEVICE_ID_CODEMERCS_IOW_LAST)
  			return 0;

-	ble = usbhid_exists_squirk(idVendor, idProduct);
-	if (ble)
-		quirks = ble->quirks;
-
+	down_read(&equirks_rwsem);
+
+ 	ble = usbhid_exists_equirk(idVendor, idProduct);
+ 	if (!ble)
+ 		ble = usbhid_exists_squirk(idVendor, idProduct);
+
+ 	if (ble)
+ 		quirks = ble->quirks;
+
+ 	up_read(&equirks_rwsem);
+
  	return quirks;
  }

@@ -519,3 +538,123 @@ static struct hid_blacklist *usbhid_exis
  	return ble;
  }

+
+/* Runtime ("extra") quirks manipulation functions */
+
+/**
+ * usbhid_exists_equirk: find any extra quirks for a USB HID device
+ * @idVendor: the 16-bit USB vendor ID, in native byteorder
+ * @idProduct: the 16-bit USB product ID, in native byteorder
+ *
+ * Description:
+ *         Scans equirks_list for a matching extra quirk and returns
+ *         the pointer to the relevant struct hid_blacklist if found.
+ *         Must be called with a read lock held on equirks_rwsem.
+ *
+ * Returns: NULL if no quirk found, struct hid_blacklist * if found.
+ */
+static struct hid_blacklist *usbhid_exists_equirk(const u16 idVendor,
+						  const u16 idProduct)
+{
+	struct quirks_list_struct *q;
+	struct hid_blacklist *ble = NULL;
+
+	WARN_ON(idVendor == 0);
+
+        list_for_each_entry(q, &equirks_list, node) {
+		if (q->hid_bl_item.idVendor == idVendor &&
+		    q->hid_bl_item.idProduct == idProduct) {
+			ble = &q->hid_bl_item;
+			break;
+		}
+        }
+
+	if (ble != NULL)
+		dbg("Found extra quirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
+		    ble->quirks, ble->idVendor,  ble->idProduct);
+
+	return ble;
+}
+
+
+/**
+ * usbhid_modify_equirk: add/replace a HID quirk
+ * @idVendor: the 16-bit USB vendor ID, in native byteorder
+ * @idProduct: the 16-bit USB product ID, in native byteorder
+ * @quirks: the u32 quirks value to add/replace
+ *
+ * Description:
+ *         If an extra quirk exists in memory for this (idVendor,
+ *         idProduct) pair, replace its quirks value with what was
+ *         provided.  Otherwise, add the quirk to the extra quirks list.
+ *
+ * Returns: 0 OK, -error on failure.
+ */
+int usbhid_modify_equirk(const u16 idVendor, const u16 idProduct,
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
+	down_write(&equirks_rwsem);
+
+	list_for_each_entry(q, &equirks_list, node) {
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
+		list_add_tail(&q_new->node, &equirks_list);
+
+	up_write(&equirks_rwsem);
+
+	return 0;
+}
+
+
+/**
+ * usbhid_remove_all_equirks: remove all runtime HID quirks from memory
+ *
+ * Description:
+ *         Free all memory associated with extra quirks - called before
+ *         module unload.
+ *
+ */
+static void usbhid_remove_all_equirks(void)
+{
+	struct quirks_list_struct *q, *temp;
+
+	down_write(&equirks_rwsem);
+	list_for_each_entry_safe(q, temp, &equirks_list, node) {
+		list_del(&q->node);
+		kfree(q);
+	}
+	up_write(&equirks_rwsem);
+
+}
+
+
Index: dev/include/linux/hid-quirks.h
===================================================================
--- dev.orig/include/linux/hid-quirks.h
+++ dev/include/linux/hid-quirks.h
@@ -30,6 +30,8 @@

  u32 usbhid_lookup_any_quirk(const u16 idVendor, const u16 idProduct);

+int usbhid_modify_equirk(const u16 idVendor, const u16 idProduct, const u32 quirks);
+


  #endif /* __HID_QUIRKS_H */
