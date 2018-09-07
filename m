From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 8/7] HID: quirks: do not blacklist Logitech devices
Date: Fri,  7 Sep 2018 12:39:29 +0200
Message-ID: <20180907103929.14951-1-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Simon Wood <simon@mungewell.org>, Olivier Gay <ogay@logitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

I am actually suggesting people to not populate this list, and I should
probably start to apply my advices to myself.

The end result means that if your initrd is lacking hid-logitech-dj
or hid-logitech-hidpp, but still contains hid-generic, then your
keyboard will work during pre-init.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---

Oops, looks like I forgot to append this one to the series.

Cheers,
Benjamin

 drivers/hid/hid-quirks.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 249d49b6b16c..996febdf21ee 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -462,13 +462,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_SPACENAVIGATOR) },
 #endif
 #if IS_ENABLED(CONFIG_HID_LOGITECH_HIDPP)
-	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_T651) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL) },
 #endif
-#if IS_ENABLED(CONFIG_HID_LOGITECH_DJ)
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER) },
-	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2) },
-#endif
 #if IS_ENABLED(CONFIG_HID_MAGICMOUSE)
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICMOUSE) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE, USB_DEVICE_ID_APPLE_MAGICTRACKPAD) },
-- 
2.14.3
