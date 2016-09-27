From: Ioan-Adrian Ratiu <adi@adirat.com>
Subject: [PATCH v2 2/2] hid: hid-dr: add input mapping for axis selection
Date: Tue, 27 Sep 2016 21:41:38 +0300
Message-ID: <20160927184138.3009-2-adi@adirat.com>
References: <20160927184138.3009-1-adi@adirat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34175 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755445AbcI0Slr (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 27 Sep 2016 14:41:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id l132so2451994wmf.1
        for <linux-input@vger.kernel.org>; Tue, 27 Sep 2016 11:41:47 -0700 (PDT)
In-Reply-To: <20160927184138.3009-1-adi@adirat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: benjamin.tissoires@redhat.com, jikos@kernel.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, spbnick@gmail.com

Commit 79346d620e9d ("HID: input: force generic axis to be mapped to their
user space axis") made mapping generic axes to their userspace equivalents
mandatory and some lower end gamepads which were depending on the previous
behaviour suffered severe regressions because they were reusing axes and
expecting hid-input to multiplex their map to the respective userspace axis
by always searching for and using the next available axis.

One solution is to add a hid quirk for this type of "previous" behaviour in
hid-input to bypass the new axes policy in favour of the old one, but since
only one hardware vendor seems to be affected negatively we're better off
making and exception and mapping in the driver for now; if more vendors or
drivers turn out to experience the problem we should reconsider the quirk
solution.

Signed-off-by: Ioan-Adrian Ratiu <adi@adirat.com>
---
 drivers/hid/hid-dr.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/hid/hid-dr.c b/drivers/hid/hid-dr.c
index 2523f8a..818ea7d9 100644
--- a/drivers/hid/hid-dr.c
+++ b/drivers/hid/hid-dr.c
@@ -248,6 +248,30 @@ static __u8 *dr_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 	return rdesc;
 }
 
+#define map_abs(c)      hid_map_usage(hi, usage, bit, max, EV_ABS, (c))
+#define map_rel(c)      hid_map_usage(hi, usage, bit, max, EV_REL, (c))
+
+static int dr_input_mapping(struct hid_device *hdev, struct hid_input *hi,
+			    struct hid_field *field, struct hid_usage *usage,
+			    unsigned long **bit, int *max)
+{
+	switch (usage->hid) {
+	/*
+	 * revert to the old hid-input behavior where axes
+	 * can be randomly assigned when hid->usage is reused.
+	 */
+	case HID_GD_X: case HID_GD_Y: case HID_GD_Z:
+	case HID_GD_RX: case HID_GD_RY: case HID_GD_RZ:
+		if (field->flags & HID_MAIN_ITEM_RELATIVE)
+			map_rel(usage->hid & 0xf);
+		else
+			map_abs(usage->hid & 0xf);
+		return 1;
+	}
+
+	return 0;
+}
+
 static int dr_probe(struct hid_device *hdev, const struct hid_device_id *id)
 {
 	int ret;
@@ -294,6 +318,7 @@ static struct hid_driver dr_driver = {
 	.id_table = dr_devices,
 	.report_fixup = dr_report_fixup,
 	.probe = dr_probe,
+	.input_mapping = dr_input_mapping,
 };
 module_hid_driver(dr_driver);
 
-- 
2.10.0

