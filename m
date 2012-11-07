From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH v3 06/13] HID: hid-multitouch: get maxcontacts also from logical_max value
Date: Wed,  7 Nov 2012 17:37:29 +0100
Message-ID: <1352306256-12180-7-git-send-email-benjamin.tissoires@gmail.com>
References: <1352306256-12180-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352306256-12180-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "benjamin.tissoires" <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Win8 devices are required to present the feature "Maximum Contact Number".
Fortunately all win7 devices I've seen presents this feature.
If the current value is 0, then, the driver can get the actual supported
contact count by refering to the logical_max.
This win8 specification ensures that logical_max may not be above 250.
This also allows us to detect when devices like irtouch or stantum reports
an obviously wrong value of 255.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Acked-by: Henrik Rydberg <rydberg@euromail.se>
---
 drivers/hid/hid-multitouch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index a6a4e0a..ae57b8f 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -121,6 +121,7 @@ struct mt_device {
 #define MT_CLS_GENERALTOUCH_PWT_TENFINGERS	0x0109
 
 #define MT_DEFAULT_MAXCONTACT	10
+#define MT_MAX_MAXCONTACT	250
 
 #define MT_USB_DEVICE(v, p)	HID_DEVICE(BUS_USB, HID_GROUP_MULTITOUCH, v, p)
 #define MT_BT_DEVICE(v, p)	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_MULTITOUCH, v, p)
@@ -283,6 +284,9 @@ static void mt_feature_mapping(struct hid_device *hdev,
 	case HID_DG_CONTACTMAX:
 		td->maxcontact_report_id = field->report->id;
 		td->maxcontacts = field->value[0];
+		if (!td->maxcontacts &&
+		    field->logical_maximum <= MT_MAX_MAXCONTACT)
+			td->maxcontacts = field->logical_maximum;
 		if (td->mtclass.maxcontacts)
 			/* check if the maxcontacts is given by the class */
 			td->maxcontacts = td->mtclass.maxcontacts;
-- 
1.7.11.7
