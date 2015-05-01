From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 2/3] HID: wacom: Discover device_type from HID descriptor for all devices
Date: Thu, 30 Apr 2015 17:51:54 -0700
Message-ID: <1430441515-30122-2-git-send-email-killertofu@gmail.com>
References: <1430441515-30122-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430441515-30122-1-git-send-email-killertofu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

Currently, we assume a device_type of BTN_TOOL_PEN before scanning the
HID descriptor and then change the device_type if what we discover
proves that assumption wrong. This way of doing things makes it more
difficult to figure out if a device (particularly a HID_GENERIC device)
actually does tablet/touch input or is something completley different.

This patch leaves device_type at its initial value of 0 and then calls
'wacom_parse_hid' for every device (not just those that have touch).
As we map the usages, we can set the device_type as before. After we're
finished, we can then check if the value is still zero and do whatever
is most appropriate.

Detecting the pen can be a little tricky on most Wacom devices because
the descriptors describe opaque blobs. Fortunately, older Wacom tablets
have the HID_DG_DIGITIZER usage on the pen's application collection and
newer tablets seem to have a similar vendor-defined usage that we can
trigger on.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 23 +++++++++++++----------
 drivers/hid/wacom_wac.c |  8 +++++---
 drivers/hid/wacom_wac.h |  6 +++++-
 3 files changed, 23 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 222baf5..157aa7a 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -181,7 +181,11 @@ static void wacom_usage_mapping(struct hid_device *hdev,
 	* X/Y values and some cases of invalid Digitizer X/Y
 	* values commonly reported.
 	*/
-	if (!pen && !finger)
+	if (pen)
+		features->device_type = BTN_TOOL_PEN;
+	else if (finger)
+		features->device_type = BTN_TOOL_FINGER;
+	else
 		return;
 
 	/*
@@ -198,14 +202,11 @@ static void wacom_usage_mapping(struct hid_device *hdev,
 	case HID_GD_X:
 		features->x_max = field->logical_maximum;
 		if (finger) {
-			features->device_type = BTN_TOOL_FINGER;
 			features->x_phy = field->physical_maximum;
 			if (features->type != BAMBOO_PT) {
 				features->unit = field->unit;
 				features->unitExpo = field->unit_exponent;
 			}
-		} else {
-			features->device_type = BTN_TOOL_PEN;
 		}
 		break;
 	case HID_GD_Y:
@@ -425,7 +426,6 @@ static void wacom_retrieve_hid_descriptor(struct hid_device *hdev,
 	struct usb_interface *intf = wacom->intf;
 
 	/* default features */
-	features->device_type = BTN_TOOL_PEN;
 	features->x_fuzz = 4;
 	features->y_fuzz = 4;
 	features->pressure_fuzz = 0;
@@ -446,10 +446,6 @@ static void wacom_retrieve_hid_descriptor(struct hid_device *hdev,
 		}
 	}
 
-	/* only devices that support touch need to retrieve the info */
-	if (features->type < BAMBOO_PT)
-		return;
-
 	wacom_parse_hid(hdev, features);
 }
 
@@ -1529,8 +1525,15 @@ static int wacom_probe(struct hid_device *hdev,
 
 	/* Retrieve the physical and logical size for touch devices */
 	wacom_retrieve_hid_descriptor(hdev, features);
-
 	wacom_setup_device_quirks(wacom);
+
+	if (!features->device_type && features->type != WIRELESS) {
+		dev_warn(&hdev->dev, "Unknown device_type for '%s'. %s.",
+			 hdev->name, "Assuming pen");
+
+		features->device_type = BTN_TOOL_PEN;
+	}
+
 	wacom_calculate_res(features);
 
 	wacom_update_name(wacom);
diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index dff99ff..a52fc25 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2186,13 +2186,15 @@ void wacom_setup_device_quirks(struct wacom *wacom)
 
 			features->x_max = 4096;
 			features->y_max = 4096;
-		} else {
-			features->device_type = BTN_TOOL_PEN;
 		}
 	}
 
 	/*
-	 * Same thing for Bamboo PAD
+	 * Raw Wacom-mode pen and touch events both come from interface
+	 * 0, whose HID descriptor has an application usage of 0xFF0D
+	 * (i.e., WACOM_VENDORDEFINED_PEN). We route pen packets back
+	 * out through the HID_GENERIC device created for interface 1,
+	 * so rewrite this one to be of type BTN_TOOL_FINGER.
 	 */
 	if (features->type == BAMBOO_PAD)
 		features->device_type = BTN_TOOL_FINGER;
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index f5a5f68..9a5ee62 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -72,10 +72,14 @@
 #define WACOM_QUIRK_MONITOR		0x0004
 #define WACOM_QUIRK_BATTERY		0x0008
 
+#define WACOM_VENDORDEFINED_PEN		0xff0d0001
+
 #define WACOM_PEN_FIELD(f)	(((f)->logical == HID_DG_STYLUS) || \
 				 ((f)->physical == HID_DG_STYLUS) || \
 				 ((f)->physical == HID_DG_PEN) || \
-				 ((f)->application == HID_DG_PEN))
+				 ((f)->application == HID_DG_PEN) || \
+				 ((f)->application == HID_DG_DIGITIZER) || \
+				 ((f)->application == WACOM_VENDORDEFINED_PEN))
 #define WACOM_FINGER_FIELD(f)	(((f)->logical == HID_DG_FINGER) || \
 				 ((f)->physical == HID_DG_FINGER) || \
 				 ((f)->application == HID_DG_TOUCHSCREEN))
-- 
2.3.5
