From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/6] HID: wacom: reuse wacom_parse_and_register() in wireless_work
Date: Fri, 12 Feb 2016 17:27:43 +0100
Message-ID: <1455294465-13694-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1455294465-13694-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org
Cc: Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, Aaron Skomra <skomra@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Removes duplicated code.
The only difference is that we now need to stop and start the attached hid
device, but this is a small cost.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 61 +++++++++++++------------------------------------
 1 file changed, 16 insertions(+), 45 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 78e9e25..5cb8528 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1525,7 +1525,7 @@ static size_t wacom_compute_pktlen(struct hid_device *hdev)
 	return size;
 }
 
-static void wacom_update_name(struct wacom *wacom)
+static void wacom_update_name(struct wacom *wacom, const char *suffix)
 {
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct wacom_features *features = &wacom_wac->features;
@@ -1561,14 +1561,14 @@ static void wacom_update_name(struct wacom *wacom)
 
 	/* Append the device type to the name */
 	snprintf(wacom_wac->pen_name, sizeof(wacom_wac->pen_name),
-		"%s Pen", name);
+		"%s%s Pen", name, suffix);
 	snprintf(wacom_wac->touch_name, sizeof(wacom_wac->touch_name),
-		"%s Finger", name);
+		"%s%s Finger", name, suffix);
 	snprintf(wacom_wac->pad_name, sizeof(wacom_wac->pad_name),
-		"%s Pad", name);
+		"%s%s Pad", name, suffix);
 }
 
-static int wacom_parse_and_register(struct wacom *wacom)
+static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 {
 	struct wacom_wac *wacom_wac = &wacom->wacom_wac;
 	struct wacom_features *features = &wacom_wac->features;
@@ -1622,7 +1622,7 @@ static int wacom_parse_and_register(struct wacom *wacom)
 
 	wacom_calculate_res(features);
 
-	wacom_update_name(wacom);
+	wacom_update_name(wacom, wireless ? " (WL)" : "");
 
 	error = wacom_add_shared_data(hdev);
 	if (error)
@@ -1649,8 +1649,10 @@ static int wacom_parse_and_register(struct wacom *wacom)
 		goto fail_hw_start;
 	}
 
-	/* Note that if query fails it is not a hard failure */
-	wacom_query_tablet_data(hdev, features);
+	if (!wireless) {
+		/* Note that if query fails it is not a hard failure */
+		wacom_query_tablet_data(hdev, features);
+	}
 
 	/* touch only Bamboo doesn't support pen */
 	if ((features->type == BAMBOO_TOUCH) &&
@@ -1745,22 +1747,10 @@ static void wacom_wireless_work(struct work_struct *work)
 		/* Stylus interface */
 		wacom_wac1->features =
 			*((struct wacom_features *)id->driver_data);
-		wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PEN;
-		wacom_set_default_phy(&wacom_wac1->features);
-		wacom_calculate_res(&wacom_wac1->features);
-		snprintf(wacom_wac1->pen_name, WACOM_NAME_MAX, "%s (WL) Pen",
-			 wacom_wac1->features.name);
-		if (wacom_wac1->features.type < BAMBOO_PEN ||
-		    wacom_wac1->features.type > BAMBOO_PT) {
-			snprintf(wacom_wac1->pad_name, WACOM_NAME_MAX,
-				 "%s (WL) Pad", wacom_wac1->features.name);
-			wacom_wac1->features.device_type |= WACOM_DEVICETYPE_PAD;
-		}
-		wacom_wac1->shared->touch_max = wacom_wac1->features.touch_max;
-		wacom_wac1->shared->type = wacom_wac1->features.type;
+
 		wacom_wac1->pid = wacom_wac->pid;
-		error = wacom_allocate_inputs(wacom1) ||
-			wacom_register_inputs(wacom1);
+		hid_hw_stop(hdev1);
+		error = wacom_parse_and_register(wacom1, true);
 		if (error)
 			goto fail;
 
@@ -1770,30 +1760,11 @@ static void wacom_wireless_work(struct work_struct *work)
 		    wacom_wac1->features.type <= BAMBOO_PT)) {
 			wacom_wac2->features =
 				*((struct wacom_features *)id->driver_data);
-			wacom_wac2->features.pktlen = WACOM_PKGLEN_BBTOUCH3;
-			wacom_set_default_phy(&wacom_wac2->features);
-			wacom_wac2->features.x_max = wacom_wac2->features.y_max = 4096;
-			wacom_calculate_res(&wacom_wac2->features);
-			snprintf(wacom_wac2->touch_name, WACOM_NAME_MAX,
-				 "%s (WL) Finger", wacom_wac2->features.name);
-			if (wacom_wac1->features.touch_max)
-				wacom_wac2->features.device_type |= WACOM_DEVICETYPE_TOUCH;
-			if (wacom_wac1->features.type >= INTUOSHT &&
-			    wacom_wac1->features.type <= BAMBOO_PT) {
-				snprintf(wacom_wac2->pad_name, WACOM_NAME_MAX,
-					 "%s (WL) Pad", wacom_wac2->features.name);
-				wacom_wac2->features.device_type |= WACOM_DEVICETYPE_PAD;
-			}
 			wacom_wac2->pid = wacom_wac->pid;
-			error = wacom_allocate_inputs(wacom2) ||
-				wacom_register_inputs(wacom2);
+			hid_hw_stop(hdev2);
+			error = wacom_parse_and_register(wacom2, true);
 			if (error)
 				goto fail;
-
-			if ((wacom_wac1->features.type == INTUOSHT ||
-			    wacom_wac1->features.type == INTUOSHT2) &&
-			    wacom_wac1->features.touch_max)
-				wacom_wac->shared->touch_input = wacom_wac2->touch_input;
 		}
 
 		error = wacom_initialize_battery(wacom);
@@ -1855,7 +1826,7 @@ static int wacom_probe(struct hid_device *hdev,
 		goto fail_parse;
 	}
 
-	error = wacom_parse_and_register(wacom);
+	error = wacom_parse_and_register(wacom, false);
 	if (error)
 		goto fail_parse;
 
-- 
2.5.0
