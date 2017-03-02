From: Joe Perches <joe@perches.com>
Subject: [PATCH] HID: usbhid: Use pr_<level> and remove unnecessary OOM messages
Date: Wed,  1 Mar 2017 17:35:07 -0800
Message-ID: <17564e41463d71d65783b11cb0b337363f90eecc.1488418441.git.joe@perches.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay0054.hostedemail.com ([216.40.44.54]:42645 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753827AbdCBBfT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 1 Mar 2017 20:35:19 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Use a more common logging style and remove the unnecessary
OOM messages as there is default dump_stack when OOM.

Miscellanea:

o Hoist an assignment in an if
o Realign arguments
o Realign a deeply indented if descendent above a printk

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/hid/usbhid/hid-core.c   | 16 +++++++---------
 drivers/hid/usbhid/hid-quirks.c | 11 ++++-------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index 961bc6fdd2d9..cd98db6cf94f 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -1004,10 +1004,9 @@ static int usbhid_parse(struct hid_device *hid)
 		return -EINVAL;
 	}
 
-	if (!(rdesc = kmalloc(rsize, GFP_KERNEL))) {
-		dbg_hid("couldn't allocate rdesc memory\n");
+	rdesc = kmalloc(rsize, GFP_KERNEL);
+	if (!rdesc)
 		return -ENOMEM;
-	}
 
 	hid_set_idle(dev, interface->desc.bInterfaceNumber, 0, 0);
 
@@ -1077,8 +1076,8 @@ static int usbhid_start(struct hid_device *hid)
 		if (hid->quirks & HID_QUIRK_FULLSPEED_INTERVAL &&
 		    dev->speed == USB_SPEED_HIGH) {
 			interval = fls(endpoint->bInterval*8);
-			printk(KERN_INFO "%s: Fixing fullspeed to highspeed interval: %d -> %d\n",
-			       hid->name, endpoint->bInterval, interval);
+			pr_info("%s: Fixing fullspeed to highspeed interval: %d -> %d\n",
+				hid->name, endpoint->bInterval, interval);
 		}
 
 		/* Change the polling interval of mice. */
@@ -1456,10 +1455,9 @@ static int hid_post_reset(struct usb_interface *intf)
 	 * the size of the HID report descriptor has not changed.
 	 */
 	rdesc = kmalloc(hid->dev_rsize, GFP_KERNEL);
-	if (!rdesc) {
-		dbg_hid("couldn't allocate rdesc memory (post_reset)\n");
+	if (!rdesc)
 		return -ENOMEM;
-	}
+
 	status = hid_get_class_descriptor(dev,
 				interface->desc.bInterfaceNumber,
 				HID_DT_REPORT, rdesc, hid->dev_rsize);
@@ -1637,7 +1635,7 @@ static int __init hid_init(void)
 	retval = usb_register(&hid_driver);
 	if (retval)
 		goto usb_register_fail;
-	printk(KERN_INFO KBUILD_MODNAME ": " DRIVER_DESC "\n");
+	pr_info(KBUILD_MODNAME ": " DRIVER_DESC "\n");
 
 	return 0;
 usb_register_fail:
diff --git a/drivers/hid/usbhid/hid-quirks.c b/drivers/hid/usbhid/hid-quirks.c
index d6847a664446..9287ab03e117 100644
--- a/drivers/hid/usbhid/hid-quirks.c
+++ b/drivers/hid/usbhid/hid-quirks.c
@@ -237,10 +237,8 @@ static int usbhid_modify_dquirk(const u16 idVendor, const u16 idProduct,
 	}
 
 	q_new = kmalloc(sizeof(struct quirks_list_struct), GFP_KERNEL);
-	if (!q_new) {
-		dbg_hid("Could not allocate quirks_list_struct\n");
+	if (!q_new)
 		return -ENOMEM;
-	}
 
 	q_new->hid_bl_item.idVendor = idVendor;
 	q_new->hid_bl_item.idProduct = idProduct;
@@ -306,10 +304,9 @@ int usbhid_quirks_init(char **quirks_param)
 				&idVendor, &idProduct, &quirks);
 
 		if (m != 3 ||
-				usbhid_modify_dquirk(idVendor, idProduct, quirks) != 0) {
-			printk(KERN_WARNING
-					"Could not parse HID quirk module param %s\n",
-					quirks_param[n]);
+		    usbhid_modify_dquirk(idVendor, idProduct, quirks) != 0) {
+			pr_warn("Could not parse HID quirk module param %s\n",
+				quirks_param[n]);
 		}
 	}
 
-- 
2.10.0.rc2.1.g053435c

