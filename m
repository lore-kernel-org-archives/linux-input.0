From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 14/15] HID: logitech-hidpp: retrieve the HID++ device name when available
Date: Thu,  2 Feb 2017 15:12:28 +0100
Message-ID: <20170202141229.17322-15-benjamin.tissoires@redhat.com>
References: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170202141229.17322-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

hidpp->name can't be null.
Only HID++ 2.0 and above device supports the query.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

new in v2
---
 drivers/hid/hid-logitech-hidpp.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 416d9e6..28ce443 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2744,6 +2744,22 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 			 hidpp->protocol_major, hidpp->protocol_minor);
 	}
 
+	if (hidpp->name == hdev->name && hidpp->protocol_major >= 2) {
+		name = hidpp_get_device_name(hidpp);
+		if (!name) {
+			hid_err(hdev,
+				"unable to retrieve the name of the device");
+			return;
+		}
+
+		devm_name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "%s", name);
+		kfree(name);
+		if (!devm_name)
+			return;
+
+		hidpp->name = devm_name;
+	}
+
 	hidpp_initialize_battery(hidpp);
 
 	/* forward current battery state */
@@ -2761,22 +2777,6 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 		/* if HID created the input nodes for us, we can stop now */
 		return;
 
-	if (!hidpp->name || hidpp->name == hdev->name) {
-		name = hidpp_get_device_name(hidpp);
-		if (!name) {
-			hid_err(hdev,
-				"unable to retrieve the name of the device");
-			return;
-		}
-
-		devm_name = devm_kasprintf(&hdev->dev, GFP_KERNEL, "%s", name);
-		kfree(name);
-		if (!devm_name)
-			return;
-
-		hidpp->name = devm_name;
-	}
-
 	input = hidpp_allocate_input(hdev);
 	if (!input) {
 		hid_err(hdev, "cannot allocate new input device: %d\n", ret);
-- 
2.9.3
