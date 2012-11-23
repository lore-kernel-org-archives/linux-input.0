From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 10/11] HID: hid-multitouch: fix protocol for 3 devices
Date: Fri, 23 Nov 2012 16:31:33 +0100
Message-ID: <1353684694-5723-11-git-send-email-benjamin.tissoires@gmail.com>
References: <1353684694-5723-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353684694-5723-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Cando 2087:0a02 was broken, this fixes it.
ActionStar and LG panels can be optimized by using the new default
class.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-multitouch.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5e0a4d7..b374a5a 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -997,7 +997,7 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_3M3266) },
 
 	/* ActionStar panels */
-	{ .driver_data = MT_CLS_NSMU,
+	{ .driver_data = MT_CLS_DEFAULT,
 		MT_USB_DEVICE(USB_VENDOR_ID_ACTIONSTAR,
 			USB_DEVICE_ID_ACTIONSTAR_1011) },
 
@@ -1017,7 +1017,7 @@ static const struct hid_device_id mt_devices[] = {
 	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
 		MT_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_MULTI_TOUCH) },
-	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
+	{ .driver_data = MT_CLS_DEFAULT,
 		MT_USB_DEVICE(USB_VENDOR_ID_CANDO,
 			USB_DEVICE_ID_CANDO_MULTI_TOUCH_10_1) },
 	{ .driver_data = MT_CLS_DUAL_INRANGE_CONTACTNUMBER,
@@ -1155,7 +1155,7 @@ static const struct hid_device_id mt_devices[] = {
 			USB_DEVICE_ID_IRTOUCH_INFRARED_USB) },
 
 	/* LG Display panels */
-	{ .driver_data = MT_CLS_NSMU,
+	{ .driver_data = MT_CLS_DEFAULT,
 		MT_USB_DEVICE(USB_VENDOR_ID_LG,
 			USB_DEVICE_ID_LG_MULTITOUCH) },
 
-- 
1.8.0
