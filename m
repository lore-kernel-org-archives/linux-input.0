From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/7] HID: logitech-hidpp: create a name based on the type if non available
Date: Fri,  7 Sep 2018 12:34:48 +0200
Message-ID: <20180907103450.13890-6-benjamin.tissoires@redhat.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Simon Wood <simon@mungewell.org>, Olivier Gay <ogay@logitech.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Some low cost devices don't even have a name (nor a serial) registered
in the receiver. In those case, create a better name that "Logitech
USB Receiver" or even "Logitech  " if we try to get their name.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 5f96e63dbd87..a09509fdb746 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -802,6 +802,9 @@ static char *hidpp_unifying_get_name(struct hidpp_device *hidpp_dev, int index)
 	if (2 + len > sizeof(response.rap.params))
 		return NULL;
 
+	if (len < 4) /* logitech devices are usually at least Xddd */
+		return NULL;
+
 	name = kzalloc(len + 1, GFP_KERNEL);
 	if (!name)
 		return NULL;
@@ -838,7 +841,8 @@ static int hidpp_unifying_get_serial(struct hidpp_device *hidpp, int index,
 }
 
 static int hidpp_unifying_get_name_and_uniq(struct hidpp_device *hidpp,
-		int device_index, u16 quadid, char name[128], char uniq[64])
+		int device_index, u16 quadid, u8 type, char name[128],
+		char uniq[64])
 {
 	const char *hidpp_name;
 	u32 serial;
@@ -853,8 +857,29 @@ static int hidpp_unifying_get_name_and_uniq(struct hidpp_device *hidpp,
 		device_index);
 
 	hidpp_name = hidpp_unifying_get_name(hidpp, device_index);
-	if (!hidpp_name)
-		return -EIO;
+	if (!hidpp_name) {
+		switch (type) {
+		case 0x01:
+			snprintf(name, 128, "Logitech Wireless Keyboard");
+			break;
+		case 0x02:
+			snprintf(name, 128, "Logitech Wireless Mouse");
+			break;
+		case 0x03:
+			snprintf(name, 128, "Logitech Wireless Numpad");
+			break;
+		case 0x04:
+			snprintf(name, 128, "Logitech Wireless Presenter");
+			break;
+		case 0x08:
+			snprintf(name, 128, "Logitech Wireless Trackball");
+			break;
+		case 0x09:
+			snprintf(name, 128, "Logitech Wireless Touchpad");
+			break;
+		}
+		return 0;
+	}
 
 	snprintf(name, 128, "%s", hidpp_name);
 	dbg_hid("HID++ Unifying: Got name: '%s' for device %d\n", name,
@@ -899,7 +924,8 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 			 */
 			if (i == 1) {
 				ret = hidpp_unifying_get_name_and_uniq(hidpp, i,
-							q, hidpp->shared->name,
+							q, type,
+							hidpp->shared->name,
 							hidpp->shared->uniq);
 				if (ret)
 					return ret;
@@ -910,7 +936,7 @@ static int hidpp_unifying_init(struct hidpp_device *hidpp)
 
 	if (device_index != 1) {
 		ret = hidpp_unifying_get_name_and_uniq(hidpp, device_index,
-						       quadid, hdev->name,
+						       quadid, type, hdev->name,
 						       hdev->uniq);
 		if (ret)
 			return ret;
-- 
2.14.3
