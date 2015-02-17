From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 1/2] HID: huion: enable button mode reporting
Date: Tue, 17 Feb 2015 17:54:12 -0500
Message-ID: <1424213653-5970-2-git-send-email-benjamin.tissoires@redhat.com>
References: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1424213653-5970-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>, Jiri Kosina <jkosina@suse.cz>
Cc: Peter Hutterer <peter.hutterer@who-t.net>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The Huion tablets currently report keyboard shortcuts when the user
hits the various buttons available on the pad.
These shortcuts are rather cumbersome because they contain "Alt-F4",
"Ctrl-C" and other widely used shortcuts.

The Windows driver switches the tablet into a no shortcuts mode, but this
mode violates the HID report descriptor. The buttons are sent through
the report ID 7, and they are not described in the report descriptor
(neither the one given by the hardware, nor the overwritten one).

To solve this, we create a new collection in the report descriptor with
a new report ID. When we see a button event in .raw_event(), we simply
change the report ID to this new collection and we can then rely on
hid-core to properly parse the buttons.

Developed and tested on a H610 Pro.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-huion.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-huion.c b/drivers/hid/hid-huion.c
index 61b68ca..50fbda4 100644
--- a/drivers/hid/hid-huion.c
+++ b/drivers/hid/hid-huion.c
@@ -34,6 +34,9 @@ enum huion_ph_id {
 	HUION_PH_ID_NUM
 };
 
+/* header of a button report sent through the Pen report */
+static const u8 button_report[]  = {0x07, 0xa0, 0x01, 0x01};
+
 /* Report descriptor template placeholder */
 #define HUION_PH(_ID) HUION_PH_HEAD, HUION_PH_ID_##_ID
 
@@ -81,6 +84,31 @@ static const __u8 huion_tablet_rdesc_template[] = {
 	HUION_PH(PRESSURE_LM),  /*          Logical Maximum (PLACEHOLDER),  */
 	0x81, 0x02,             /*          Input (Variable),               */
 	0xC0,                   /*      End Collection,                     */
+	0x05, 0x01,             /*      Usage Page (Desktop)                */
+	0x09, 0x07,             /*      Usage (Keypad)                      */
+	0xa1, 0x01,             /*      Collection (Application)            */
+	0x85, 0x08,             /*          Report ID (8)                   */
+	0x05, 0x0d,             /*          Usage Page (Digitizers)         */
+	0x09, 0x22,             /*          Usage (Finger)                  */
+	0xa0,                   /*          Collection (Physical)           */
+	0x14,                   /*              Logical Minimum (0)         */
+	0x25, 0x01,             /*              Logical Maximum (1)         */
+	0x75, 0x08,             /*              Report Size (8)             */
+	0x95, 0x03,             /*              Report Count (3)            */
+	0x81, 0x03,             /*              Input (Cnst,Var,Abs)        */
+	0x05, 0x09,             /*              Usage Page (Button)         */
+	0x19, 0x01,             /*              Usage Minimum (1)           */
+	0x29, 0x08,             /*              Usage Maximum (8)           */
+	0x14,                   /*              Logical Minimum (0)         */
+	0x25, 0x01,             /*              Logical Maximum (1)         */
+	0x75, 0x01,             /*              Report Size (1)             */
+	0x95, 0x08,             /*              Report Count (8)            */
+	0x81, 0x02,             /*              Input (Data,Var,Abs)        */
+	0x75, 0x08,             /*              Report Size (8)             */
+	0x95, 0x03,             /*              Report Count (3)            */
+	0x81, 0x03,             /*              Input (Cnst,Var,Abs)        */
+	0xc0,                   /*          End Collection                  */
+	0xc0,                   /*      End Collection                      */
 	0xC0                    /*  End Collection                          */
 };
 
@@ -205,6 +233,25 @@ static int huion_tablet_enable(struct hid_device *hdev)
 		}
 	}
 
+	/* switch to the button mode reporting */
+	rc = usb_control_msg(usb_dev, usb_rcvctrlpipe(usb_dev, 0),
+				USB_REQ_GET_DESCRIPTOR, USB_DIR_IN,
+				(USB_DT_STRING << 8) + 0x7b,
+				0x0409, buf, len,
+				USB_CTRL_GET_TIMEOUT);
+	if (rc == -EPIPE) {
+		hid_err(hdev, "button mode switch not found\n");
+		rc = -ENODEV;
+		goto cleanup;
+	} else if (rc < 0) {
+		hid_err(hdev, "failed to switch to button mode: %d\n", rc);
+		rc = -ENODEV;
+		goto cleanup;
+	} else if (rc != len) {
+		hid_err(hdev, "invalid button mode switch\n");
+		rc = -ENODEV;
+		goto cleanup;
+	}
 	rc = 0;
 
 cleanup:
@@ -262,10 +309,16 @@ static int huion_raw_event(struct hid_device *hdev, struct hid_report *report,
 	/* If this is a pen input report */
 	if (intf->cur_altsetting->desc.bInterfaceNumber == 0 &&
 	    report->type == HID_INPUT_REPORT &&
-	    report->id == 0x07 && size >= 2)
+	    report->id == 0x07 && size >= 2) {
 		/* Invert the in-range bit */
 		data[1] ^= 0x40;
 
+		/* check for buttons events and change the report ID */
+		if (size >= sizeof(button_report) &&
+		    !memcmp(data, button_report, sizeof(button_report)))
+			data[0] = 0x08;
+	}
+
 	return 0;
 }
 
-- 
2.1.0
