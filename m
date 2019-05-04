From: Colin King <colin.king@canonical.com>
Subject: [PATCH] HID: uclogic: fix dereferences of hdev before null check on hdev
Date: Sat,  4 May 2019 18:22:22 +0100
Message-ID: <20190504172222.1260-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently hdev is being dereferenced when using macro hid_to_usb_dev
before hdev is being null checked, hence there is a potential null
pointer dereference.  Fix this by only dereferencing hdev after it has
been null checked.

Fixes: 9614219e9310 ("HID: uclogic: Extract tablet parameter discovery into a module")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hid/hid-uclogic-params.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-uclogic-params.c b/drivers/hid/hid-uclogic-params.c
index 0187c9f8fc22..bc5a2f860501 100644
--- a/drivers/hid/hid-uclogic-params.c
+++ b/drivers/hid/hid-uclogic-params.c
@@ -65,7 +65,7 @@ static int uclogic_params_get_str_desc(__u8 **pbuf, struct hid_device *hdev,
 					__u8 idx, size_t len)
 {
 	int rc;
-	struct usb_device *udev = hid_to_usb_dev(hdev);
+	struct usb_device *udev;
 	__u8 *buf = NULL;
 
 	/* Check arguments */
@@ -73,6 +73,7 @@ static int uclogic_params_get_str_desc(__u8 **pbuf, struct hid_device *hdev,
 		rc = -EINVAL;
 		goto cleanup;
 	}
+	udev = hid_to_usb_dev(hdev);
 
 	buf = kmalloc(len, GFP_KERNEL);
 	if (buf == NULL) {
@@ -449,7 +450,7 @@ static int uclogic_params_frame_init_v1_buttonpad(
 {
 	int rc;
 	bool found = false;
-	struct usb_device *usb_dev = hid_to_usb_dev(hdev);
+	struct usb_device *usb_dev;
 	char *str_buf = NULL;
 	const size_t str_len = 16;
 
@@ -458,6 +459,7 @@ static int uclogic_params_frame_init_v1_buttonpad(
 		rc = -EINVAL;
 		goto cleanup;
 	}
+	usb_dev = hid_to_usb_dev(hdev);
 
 	/*
 	 * Enable generic button mode
@@ -705,7 +707,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 				     struct hid_device *hdev)
 {
 	int rc;
-	struct usb_device *udev = hid_to_usb_dev(hdev);
+	struct usb_device *udev;
 	struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
 	__u8 bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
 	bool found;
@@ -720,6 +722,7 @@ static int uclogic_params_huion_init(struct uclogic_params *params,
 		rc = -EINVAL;
 		goto cleanup;
 	}
+	udev = hid_to_usb_dev(hdev);
 
 	/* If it's not a pen interface */
 	if (bInterfaceNumber != 0) {
@@ -832,10 +835,9 @@ int uclogic_params_init(struct uclogic_params *params,
 			struct hid_device *hdev)
 {
 	int rc;
-	struct usb_device *udev = hid_to_usb_dev(hdev);
-	__u8  bNumInterfaces = udev->config->desc.bNumInterfaces;
-	struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
-	__u8 bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
+	struct usb_device *udev;
+	struct usb_interface *iface;
+	__u8 bNumInterfaces, bInterfaceNumber;
 	bool found;
 	/* The resulting parameters (noop) */
 	struct uclogic_params p = {0, };
@@ -846,6 +848,10 @@ int uclogic_params_init(struct uclogic_params *params,
 		rc = -EINVAL;
 		goto cleanup;
 	}
+	udev = hid_to_usb_dev(hdev);
+	bNumInterfaces = udev->config->desc.bNumInterfaces;
+	iface = to_usb_interface(hdev->dev.parent);
+	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
 
 	/*
 	 * Set replacement report descriptor if the original matches the
-- 
2.20.1
