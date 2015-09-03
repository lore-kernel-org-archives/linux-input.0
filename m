From: Maciej Zuk <gzmlke@gmail.com>
Subject: [PATCH 4.2] hid_dr: Fixed HID Descriptor
Date: Thu,  3 Sep 2015 21:46:39 +0200
Message-ID: <1441309599-17421-1-git-send-email-gzmlke@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:35840 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755381AbbICTqq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 15:46:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Maciej Zuk <gzmlke@gmail.com>

From: Maciej Zuk <gzmlke@gmail.com>

Fixed HID descriptor for DragonRise Joystick.
Replaced default descriptor which doubles Z axis 
and causes mixing values of X and Z axes.

Signed-off-by: Maciej Zuk <gzmlke@gmail.com>
---
 drivers/hid/hid-dr.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
index ce06444..7d07690 100644
--- a/drivers/hid/hid-dr.c
+++ b/drivers/hid/hid-dr.c
@@ -234,6 +234,58 @@ static __u8 pid0011_rdesc_fixed[] = {
 	0xC0                /*  End Collection                  */
 };
 
+static __u8 pid0006_rdesc_fixed[] = {
+	0x05, 0x01,        /* Usage Page (Generic Desktop)	*/
+	0x09, 0x04,        /* Usage (Joystick)			*/
+	0xA1, 0x01,        /* Collection (Application)		*/
+	0xA1, 0x02,        /*   Collection (Logical)		*/
+	0x75, 0x08,        /*     Report Size (8)		*/
+	0x95, 0x05,        /*     Report Count (5)		*/
+	0x15, 0x00,        /*     Logical Minimum (0)		*/
+	0x26, 0xFF, 0x00,  /*     Logical Maximum (255)		*/
+	0x35, 0x00,        /*     Physical Minimum (0)		*/
+	0x46, 0xFF, 0x00,  /*     Physical Maximum (255)	*/
+	0x09, 0x30,        /*     Usage (X)			*/
+	0x09, 0x33,        /*     Usage (Ry)			*/
+	0x09, 0x32,        /*     Usage (Z)			*/
+	0x09, 0x31,        /*     Usage (Y)			*/
+	0x09, 0x34,        /*     Usage (Ry)			*/
+	0x81, 0x02,        /*     Input (Variable)		*/
+	0x75, 0x04,        /*     Report Size (4)		*/
+	0x95, 0x01,        /*     Report Count (1)		*/
+	0x25, 0x07,        /*     Logical Maximum (7)		*/
+	0x46, 0x3B, 0x01,  /*     Physical Maximum (315)	*/
+	0x65, 0x14,        /*     Unit (Centimeter)		*/
+	0x09, 0x39,        /*     Usage (Hat switch)		*/
+	0x81, 0x42,        /*     Input (Variable)		*/
+	0x65, 0x00,        /*     Unit (None)			*/
+	0x75, 0x01,        /*     Report Size (1)		*/
+	0x95, 0x0C,        /*     Report Count (12)		*/
+	0x25, 0x01,        /*     Logical Maximum (1)		*/
+	0x45, 0x01,        /*     Physical Maximum (1)		*/
+	0x05, 0x09,        /*     Usage Page (Button)		*/
+	0x19, 0x01,        /*     Usage Minimum (0x01)		*/
+	0x29, 0x0C,        /*     Usage Maximum (0x0C)		*/
+	0x81, 0x02,        /*     Input (Variable)		*/
+	0x06, 0x00, 0xFF,  /*     Usage Page (Vendor Defined)	*/
+	0x75, 0x01,        /*     Report Size (1)		*/
+	0x95, 0x08,        /*     Report Count (8)		*/
+	0x25, 0x01,        /*     Logical Maximum (1)		*/
+	0x45, 0x01,        /*     Physical Maximum (1)		*/
+	0x09, 0x01,        /*     Usage (0x01)			*/
+	0x81, 0x02,        /*     Input (Variable)		*/
+	0xC0,              /*   End Collection			*/
+	0xA1, 0x02,        /*   Collection (Logical)		*/
+	0x75, 0x08,        /*     Report Size (8)		*/
+	0x95, 0x07,        /*     Report Count (7)		*/
+	0x46, 0xFF, 0x00,  /*     Physical Maximum (255)	*/
+	0x26, 0xFF, 0x00,  /*     Logical Maximum (255)		*/
+	0x09, 0x02,        /*     Usage (0x02)			*/
+	0x91, 0x02,        /*     Output (Variable)		*/
+	0xC0,              /*   End Collection			*/
+	0xC0               /* End Collection			*/
+};
+
 static __u8 *dr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				unsigned int *rsize)
 {
@@ -244,6 +296,12 @@ static __u8 *dr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 			*rsize = sizeof(pid0011_rdesc_fixed);
 		}
 		break;
+	case 0x0006:
+		if (*rsize == sizeof(pid0006_rdesc_fixed)) {
+			rdesc = pid0006_rdesc_fixed;
+			*rsize = sizeof(pid0006_rdesc_fixed);
+		}
+		break;
 	}
 	return rdesc;
 }
-- 
2.5.1


