From: Fernando D S Lima <fernandodsl@gmail.com>
Subject: [PATCH v1] HID: sensor-hub: Fixup for Lenovo ThinkPad Helix 2 sensor hub report
Date: Thu,  3 Sep 2015 12:56:31 -0300
Message-ID: <1441295896-23314-1-git-send-email-fernandodsl@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Fernando D S Lima <fernandodsl@gmail.com>, Jiri Kosina <jkosina@suse.com>, Jonathan Cameron <jic23@kernel.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There is an error in the report descriptor of the Thinkpad Helix 2 where
logical minimum value (557376) is greater than logical maximum (491200)
for all of the magnetic flux axis data fields. This error results in a
report descriptor parsing failure that causes the sensors attached to the
hub not to be detected.

dmesg excerpt:
[   19.866905] drivers/hid/hid-core.c: logical range invalid 0x88140 0x77ec0
[   19.866914] hid-sensor-hub 0018:2047:0855.0007: item 0 1 0 8 parsing failed
[   19.866926] hid-sensor-hub 0018:2047:0855.0007: parse failed
[   19.866933] hid-sensor-hub: probe of 0018:2047:0855.0007 failed with error -22

Add a report fixup to change magnetic flux logical minimums to -557376
for the parsing to succeed and the sensors to get detected.
After applying the fix the sensors get detected, with corresponding drivers
(hid-accel-3d,hid-gyro-3d,etc) loaded, and its possible to read their values.

Signed-off-by: Fernando D S Lima <fernandodsl@gmail.com>
---
 drivers/hid/hid-sensor-hub.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 090a1ba..6c94257 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -593,6 +593,20 @@ static __u8 *sensor_hub_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 		}
 	}
 
+	/* Checks if the report descriptor of Thinkpad Helix 2 has a logical
+	 * minimum for magnetic flux axis greater than the maximum */
+	if (hdev->product == USB_DEVICE_ID_TEXAS_INSTRUMENTS_LENOVO_YOGA &&
+		*rsize == 2558 && rdesc[913] == 0x17 && rdesc[914] == 0x40 &&
+		rdesc[915] == 0x81 && rdesc[916] == 0x08 &&
+		rdesc[917] == 0x00 && rdesc[918] == 0x27 &&
+		rdesc[921] == 0x07 && rdesc[922] == 0x00) {
+		/* Sets negative logical minimum for mag x, y and z */
+		rdesc[914] = rdesc[935] = rdesc[956] = 0xc0;
+		rdesc[915] = rdesc[936] = rdesc[957] = 0x7e;
+		rdesc[916] = rdesc[937] = rdesc[958] = 0xf7;
+		rdesc[917] = rdesc[938] = rdesc[959] = 0xff;
+	}
+
 	return rdesc;
 }
 
-- 
1.9.1
