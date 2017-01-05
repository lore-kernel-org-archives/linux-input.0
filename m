From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 3/3] HID: rmi: Support the Lenovo Thinkpad X1 Tablet dock using hid-rmi
Date: Thu,  5 Jan 2017 09:49:00 +0100
Message-ID: <20170105084900.15931-4-benjamin.tissoires@redhat.com>
References: <20170105084900.15931-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170105084900.15931-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Andrew Duggan <aduggan@synaptics.com>, Dennis Wassenberg <dennis.wassenberg@secunet.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Andrew Duggan <aduggan@synaptics.com>

Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v4

no changes in v3

no changes in v2
---
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 1 +
 drivers/hid/hid-rmi.c  | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 7e8b99e..bbbc04d 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2125,6 +2125,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_WIIMOTE2) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_14) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_CMEDIA, USB_DEVICE_ID_CM6533) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },
 	{ }
 };
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 1f79005..ce3ee97 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -627,6 +627,7 @@
 #define USB_DEVICE_ID_LENOVO_CUSBKBD	0x6047
 #define USB_DEVICE_ID_LENOVO_CBTKBD	0x6048
 #define USB_DEVICE_ID_LENOVO_TPPRODOCK	0x6067
+#define USB_DEVICE_ID_LENOVO_X1_COVER	0x6085
 
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
diff --git a/drivers/hid/hid-rmi.c b/drivers/hid/hid-rmi.c
index 8056edd..5b40c26 100644
--- a/drivers/hid/hid-rmi.c
+++ b/drivers/hid/hid-rmi.c
@@ -716,6 +716,7 @@ static void rmi_remove(struct hid_device *hdev)
 static const struct hid_device_id rmi_id[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_RAZER, USB_DEVICE_ID_RAZER_BLADE_14),
 		.driver_data = RMI_DEVICE_HAS_PHYS_BUTTONS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, USB_DEVICE_ID_LENOVO_X1_COVER) },
 	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_RMI, HID_ANY_ID, HID_ANY_ID) },
 	{ }
 };
-- 
2.9.3
