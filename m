From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 2/5] Input: elantech - add helper function elantech_is_buttonpad()
Date: Fri, 12 Oct 2018 16:24:10 +0200
Message-ID: <20181012142413.26107-3-benjamin.tissoires@redhat.com>
References: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012142413.26107-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

We check for this bit all over the code, better have it defined once
for all.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1628715
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/elantech.c | 89 ++++++++++++++++++++++--------------------
 1 file changed, 47 insertions(+), 42 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 577c795cbe82..78ac732e8188 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -229,6 +229,50 @@ static void elantech_packet_dump(struct psmouse *psmouse)
 		       psmouse->pktsize, psmouse->packet);
 }
 
+/*
+ * Advertise INPUT_PROP_BUTTONPAD for clickpads. The testing of bit 12 in
+ * fw_version for this is based on the following fw_version & caps table:
+ *
+ * Laptop-model:           fw_version:     caps:           buttons:
+ * Acer S3                 0x461f00        10, 13, 0e      clickpad
+ * Acer S7-392             0x581f01        50, 17, 0d      clickpad
+ * Acer V5-131             0x461f02        01, 16, 0c      clickpad
+ * Acer V5-551             0x461f00        ?               clickpad
+ * Asus K53SV              0x450f01        78, 15, 0c      2 hw buttons
+ * Asus G46VW              0x460f02        00, 18, 0c      2 hw buttons
+ * Asus G750JX             0x360f00        00, 16, 0c      2 hw buttons
+ * Asus TP500LN            0x381f17        10, 14, 0e      clickpad
+ * Asus X750JN             0x381f17        10, 14, 0e      clickpad
+ * Asus UX31               0x361f00        20, 15, 0e      clickpad
+ * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
+ * Avatar AVIU-145A2       0x361f00        ?               clickpad
+ * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
+ * Fujitsu LIFEBOOK E546   0x470f00        50, 12, 09      2 hw buttons
+ * Fujitsu LIFEBOOK E547   0x470f00        50, 12, 09      2 hw buttons
+ * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
+ * Fujitsu LIFEBOOK E557   0x570f01        40, 14, 0c      2 hw buttons
+ * Fujitsu T725            0x470f01        05, 12, 09      2 hw buttons
+ * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw buttons (**)
+ * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw buttons
+ * Lenovo L430             0x350f02        b9, 15, 0c      2 hw buttons (*)
+ * Lenovo L530             0x350f02        b9, 15, 0c      2 hw buttons (*)
+ * Samsung NF210           0x150b00        78, 14, 0a      2 hw buttons
+ * Samsung NP770Z5E        0x575f01        10, 15, 0f      clickpad
+ * Samsung NP700Z5B        0x361f06        21, 15, 0f      clickpad
+ * Samsung NP900X3E-A02    0x575f03        ?               clickpad
+ * Samsung NP-QX410        0x851b00        19, 14, 0c      clickpad
+ * Samsung RC512           0x450f00        08, 15, 0c      2 hw buttons
+ * Samsung RF710           0x450f00        ?               2 hw buttons
+ * System76 Pangolin       0x250f01        ?               2 hw buttons
+ * (*) + 3 trackpoint buttons
+ * (**) + 0 trackpoint buttons
+ * Note: Lenovo L430 and Lenovo L530 have the same fw_version/caps
+ */
+static inline int elantech_is_buttonpad(struct elantech_device_info *info)
+{
+	return info->fw_version & 0x001000;
+}
+
 /*
  * Interpret complete data packets and report absolute mode input events for
  * hardware version 1. (4 byte packets)
@@ -526,7 +570,7 @@ static void elantech_report_absolute_v3(struct psmouse *psmouse,
 	input_report_key(dev, BTN_TOOL_TRIPLETAP, fingers == 3);
 
 	/* For clickpads map both buttons to BTN_LEFT */
-	if (etd->info.fw_version & 0x001000)
+	if (elantech_is_buttonpad(&etd->info))
 		input_report_key(dev, BTN_LEFT, packet[0] & 0x03);
 	else
 		psmouse_report_standard_buttons(dev, packet[0]);
@@ -544,7 +588,7 @@ static void elantech_input_sync_v4(struct psmouse *psmouse)
 	unsigned char *packet = psmouse->packet;
 
 	/* For clickpads map both buttons to BTN_LEFT */
-	if (etd->info.fw_version & 0x001000)
+	if (elantech_is_buttonpad(&etd->info))
 		input_report_key(dev, BTN_LEFT, packet[0] & 0x03);
 	else
 		psmouse_report_standard_buttons(dev, packet[0]);
@@ -1020,51 +1064,12 @@ static int elantech_get_resolution_v4(struct psmouse *psmouse,
 	return 0;
 }
 
-/*
- * Advertise INPUT_PROP_BUTTONPAD for clickpads. The testing of bit 12 in
- * fw_version for this is based on the following fw_version & caps table:
- *
- * Laptop-model:           fw_version:     caps:           buttons:
- * Acer S3                 0x461f00        10, 13, 0e      clickpad
- * Acer S7-392             0x581f01        50, 17, 0d      clickpad
- * Acer V5-131             0x461f02        01, 16, 0c      clickpad
- * Acer V5-551             0x461f00        ?               clickpad
- * Asus K53SV              0x450f01        78, 15, 0c      2 hw buttons
- * Asus G46VW              0x460f02        00, 18, 0c      2 hw buttons
- * Asus G750JX             0x360f00        00, 16, 0c      2 hw buttons
- * Asus TP500LN            0x381f17        10, 14, 0e      clickpad
- * Asus X750JN             0x381f17        10, 14, 0e      clickpad
- * Asus UX31               0x361f00        20, 15, 0e      clickpad
- * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
- * Avatar AVIU-145A2       0x361f00        ?               clickpad
- * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw buttons
- * Fujitsu LIFEBOOK E546   0x470f00        50, 12, 09      2 hw buttons
- * Fujitsu LIFEBOOK E547   0x470f00        50, 12, 09      2 hw buttons
- * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw buttons
- * Fujitsu LIFEBOOK E557   0x570f01        40, 14, 0c      2 hw buttons
- * Fujitsu T725            0x470f01        05, 12, 09      2 hw buttons
- * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw buttons (**)
- * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw buttons
- * Lenovo L430             0x350f02        b9, 15, 0c      2 hw buttons (*)
- * Lenovo L530             0x350f02        b9, 15, 0c      2 hw buttons (*)
- * Samsung NF210           0x150b00        78, 14, 0a      2 hw buttons
- * Samsung NP770Z5E        0x575f01        10, 15, 0f      clickpad
- * Samsung NP700Z5B        0x361f06        21, 15, 0f      clickpad
- * Samsung NP900X3E-A02    0x575f03        ?               clickpad
- * Samsung NP-QX410        0x851b00        19, 14, 0c      clickpad
- * Samsung RC512           0x450f00        08, 15, 0c      2 hw buttons
- * Samsung RF710           0x450f00        ?               2 hw buttons
- * System76 Pangolin       0x250f01        ?               2 hw buttons
- * (*) + 3 trackpoint buttons
- * (**) + 0 trackpoint buttons
- * Note: Lenovo L430 and Lenovo L530 have the same fw_version/caps
- */
 static void elantech_set_buttonpad_prop(struct psmouse *psmouse)
 {
 	struct input_dev *dev = psmouse->dev;
 	struct elantech_data *etd = psmouse->private;
 
-	if (etd->info.fw_version & 0x001000) {
+	if (elantech_is_buttonpad(&etd->info)) {
 		__set_bit(INPUT_PROP_BUTTONPAD, dev->propbit);
 		__clear_bit(BTN_RIGHT, dev->keybit);
 	}
-- 
2.14.3
