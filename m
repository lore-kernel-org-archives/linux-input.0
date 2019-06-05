From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 4/4] HID: logitech-dj: Fix 064d:c52f receiver support
Date: Wed,  5 Jun 2019 14:44:08 +0200
Message-ID: <20190605124408.8637-5-benjamin.tissoires@redhat.com>
References: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190605124408.8637-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

The c52f nano receiver is a mouse only receiver. This means that it needs
some special handling compared to the c534 nano receiver:

1) It sends unnumbered mouse reports with a size of 8 bytes, so we need
   to extend the unnumbered mouse report handling to support reports upto
   8 bytes large

2) It mouse reports have the same high-resolution format as those from the
   gaming mouse receivers

3) It can report consumer/multimedia buttons on its second interface, since
   this is a mouse-only receiver these must be forwarded to the mouse child
   device and not to the keyboard child-device (which will not exist)

Link: https://bugzilla.kernel.org/show_bug.cgi?id=203619
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-dj.c | 42 ++++++++++++++++++++++-------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 41baa4dbbfcc..c48e7030d3c9 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -128,6 +128,7 @@ enum recvr_type {
 	recvr_type_dj,
 	recvr_type_hidpp,
 	recvr_type_gaming_hidpp,
+	recvr_type_mouse_only,
 	recvr_type_27mhz,
 	recvr_type_bluetooth,
 };
@@ -879,9 +880,12 @@ static void logi_dj_recv_queue_notification(struct dj_receiver_dev *djrcv_dev,
 	schedule_work(&djrcv_dev->work);
 }
 
-static void logi_hidpp_dev_conn_notif_equad(struct hidpp_event *hidpp_report,
+static void logi_hidpp_dev_conn_notif_equad(struct hid_device *hdev,
+					    struct hidpp_event *hidpp_report,
 					    struct dj_workitem *workitem)
 {
+	struct dj_receiver_dev *djrcv_dev = hid_get_drvdata(hdev);
+
 	workitem->type = WORKITEM_TYPE_PAIRED;
 	workitem->device_type = hidpp_report->params[HIDPP_PARAM_DEVICE_INFO] &
 				HIDPP_DEVICE_TYPE_MASK;
@@ -895,6 +899,8 @@ static void logi_hidpp_dev_conn_notif_equad(struct hidpp_event *hidpp_report,
 		break;
 	case REPORT_TYPE_MOUSE:
 		workitem->reports_supported |= STD_MOUSE | HIDPP;
+		if (djrcv_dev->type == recvr_type_mouse_only)
+			workitem->reports_supported |= MULTIMEDIA;
 		break;
 	}
 }
@@ -938,7 +944,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
 	case 0x01:
 		device_type = "Bluetooth";
 		/* Bluetooth connect packet contents is the same as (e)QUAD */
-		logi_hidpp_dev_conn_notif_equad(hidpp_report, &workitem);
+		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
 		if (!(hidpp_report->params[HIDPP_PARAM_DEVICE_INFO] &
 						HIDPP_MANUFACTURER_MASK)) {
 			hid_info(hdev, "Non Logitech device connected on slot %d\n",
@@ -952,18 +958,18 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
 		break;
 	case 0x03:
 		device_type = "QUAD or eQUAD";
-		logi_hidpp_dev_conn_notif_equad(hidpp_report, &workitem);
+		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
 		break;
 	case 0x04:
 		device_type = "eQUAD step 4 DJ";
-		logi_hidpp_dev_conn_notif_equad(hidpp_report, &workitem);
+		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
 		break;
 	case 0x05:
 		device_type = "DFU Lite";
 		break;
 	case 0x06:
 		device_type = "eQUAD step 4 Lite";
-		logi_hidpp_dev_conn_notif_equad(hidpp_report, &workitem);
+		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
 		break;
 	case 0x07:
 		device_type = "eQUAD step 4 Gaming";
@@ -973,11 +979,11 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
 		break;
 	case 0x0a:
 		device_type = "eQUAD nano Lite";
-		logi_hidpp_dev_conn_notif_equad(hidpp_report, &workitem);
+		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
 		break;
 	case 0x0c:
 		device_type = "eQUAD Lightspeed";
-		logi_hidpp_dev_conn_notif_equad(hidpp_report, &workitem);
+		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
 		workitem.reports_supported |= STD_KEYBOARD;
 		break;
 	}
@@ -1330,7 +1336,8 @@ static int logi_dj_ll_parse(struct hid_device *hid)
 	if (djdev->reports_supported & STD_MOUSE) {
 		dbg_hid("%s: sending a mouse descriptor, reports_supported: %llx\n",
 			__func__, djdev->reports_supported);
-		if (djdev->dj_receiver_dev->type == recvr_type_gaming_hidpp)
+		if (djdev->dj_receiver_dev->type == recvr_type_gaming_hidpp ||
+		    djdev->dj_receiver_dev->type == recvr_type_mouse_only)
 			rdcat(rdesc, &rsize, mse_high_res_descriptor,
 			      sizeof(mse_high_res_descriptor));
 		else if (djdev->dj_receiver_dev->type == recvr_type_27mhz)
@@ -1573,15 +1580,19 @@ static int logi_dj_raw_event(struct hid_device *hdev,
 			data[0] = data[1];
 			data[1] = 0;
 		}
-		/* The 27 MHz mouse-only receiver sends unnumbered mouse data */
+		/*
+		 * Mouse-only receivers send unnumbered mouse data. The 27 MHz
+		 * receiver uses 6 byte packets, the nano receiver 8 bytes.
+		 */
 		if (djrcv_dev->unnumbered_application == HID_GD_MOUSE &&
-		    size == 6) {
-			u8 mouse_report[7];
+		    size <= 8) {
+			u8 mouse_report[9];
 
 			/* Prepend report id */
 			mouse_report[0] = REPORT_TYPE_MOUSE;
-			memcpy(mouse_report + 1, data, 6);
-			logi_dj_recv_forward_input_report(hdev, mouse_report, 7);
+			memcpy(mouse_report + 1, data, size);
+			logi_dj_recv_forward_input_report(hdev, mouse_report,
+							  size + 1);
 		}
 
 		return false;
@@ -1652,6 +1663,7 @@ static int logi_dj_probe(struct hid_device *hdev,
 	case recvr_type_dj:		no_dj_interfaces = 3; break;
 	case recvr_type_hidpp:		no_dj_interfaces = 2; break;
 	case recvr_type_gaming_hidpp:	no_dj_interfaces = 3; break;
+	case recvr_type_mouse_only:	no_dj_interfaces = 2; break;
 	case recvr_type_27mhz:		no_dj_interfaces = 2; break;
 	case recvr_type_bluetooth:	no_dj_interfaces = 2; break;
 	}
@@ -1825,10 +1837,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
 	{HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 		USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2),
 	 .driver_data = recvr_type_dj},
-	{ /* Logitech Nano (non DJ) receiver */
+	{ /* Logitech Nano mouse only receiver */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER),
-	 .driver_data = recvr_type_hidpp},
+	 .driver_data = recvr_type_mouse_only},
 	{ /* Logitech Nano (non DJ) receiver */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2),
-- 
2.19.2
