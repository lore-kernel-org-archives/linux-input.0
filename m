From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] HID: wacom: Correct logical maximum Y for 2nd-gen Intuos Pro large
Date: Tue, 12 Jun 2018 13:42:46 -0700
Message-ID: <20180612204246.6623-1-killertofu@gmail.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, stable@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>
List-Id: linux-input@vger.kernel.org

The HID descriptor for the 2nd-gen Intuos Pro large (PTH-860) contains
a typo which defines an incorrect logical maximum Y value. This causes
a small portion of the bottom of the tablet to become unusable (both
because the area is below the "bottom" of the tablet and because
'wacom_wac_event' ignores out-of-range values). It also results in a
skewed aspect ratio.

To fix this, we add a quirk to 'wacom_usage_mapping' which overwrites
the data with the correct value.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
CC: stable@vger.kernel.org # v4.10+
---
 drivers/hid/wacom_sys.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index ee7a37eb159a..545986cfb978 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -395,6 +395,14 @@ static void wacom_usage_mapping(struct hid_device *hdev,
 		}
 	}
 
+	/* 2nd-generation Intuos Pro Large has incorrect Y maximum */
+	if (hdev->vendor == USB_VENDOR_ID_WACOM &&
+	    hdev->product == 0x0358 &&
+	    WACOM_PEN_FIELD(field) &&
+	    wacom_equivalent_usage(usage->hid) == HID_GD_Y) {
+		field->logical_maximum = 43200;
+	}
+
 	switch (usage->hid) {
 	case HID_GD_X:
 		features->x_max = field->logical_maximum;
-- 
2.17.1
