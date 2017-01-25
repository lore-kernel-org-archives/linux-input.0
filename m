From: Aaron Armstrong Skomra <skomra@gmail.com>
Subject: [PATCH 5/8] HID: wacom: generic: add support for touchring
Date: Wed, 25 Jan 2017 12:08:39 -0800
Message-ID: <1485374922-3417-6-git-send-email-skomra@gmail.com>
References: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35680 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbdAYUJf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 25 Jan 2017 15:09:35 -0500
Received: by mail-pg0-f65.google.com with SMTP id 204so20532497pge.2
        for <linux-input@vger.kernel.org>; Wed, 25 Jan 2017 12:09:35 -0800 (PST)
In-Reply-To: <1485374922-3417-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, jkosina@suse.cz, benjamin.tissoires@redhat.com, pinglinux@gmail.com, killertofu@gmail.com
Cc: Aaron Armstrong Skomra <skomra@gmail.com>, Aaron Skomra <aaron.skomra@wacom.com>

Add support for the touchring to the generic code path in
support of the second generation Intuos Pro.

We also add checks for usage->type to ensure that we
handle the usage before we report it, or change the
inrange_state based on it.

Signed-off-by: Aaron Skomra <aaron.skomra@wacom.com>
---
 drivers/hid/wacom_wac.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index f6825d2..636c4a1 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1733,6 +1733,10 @@ static void wacom_wac_pad_usage_mapping(struct hid_device *hdev,
 		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
 		features->device_type |= WACOM_DEVICETYPE_PAD;
 		break;
+	case WACOM_HID_WD_TOUCHRINGSTATUS:
+		wacom_map_usage(input, usage, field, EV_ABS, ABS_WHEEL, 0);
+		features->device_type |= WACOM_DEVICETYPE_PAD;
+		break;
 	}
 
 	switch (equivalent_usage & 0xfffffff0) {
@@ -1775,12 +1779,22 @@ static void wacom_wac_pad_event(struct hid_device *hdev, struct hid_field *field
 	struct input_dev *input = wacom_wac->pad_input;
 	unsigned equivalent_usage = wacom_equivalent_usage(usage->hid);
 
+	/*
+	 * Avoid reporting this event and setting inrange_state if this usage
+	 * hasn't been mapped.
+	 */
+	if (!usage->type)
+		return;
+
 	if (wacom_equivalent_usage(field->physical) == HID_DG_TABLETFUNCTIONKEY) {
-		wacom_wac->hid_data.inrange_state |= value;
+		if (usage->hid != WACOM_HID_WD_TOUCHRING)
+			wacom_wac->hid_data.inrange_state |= value;
 	}
 
 	switch (equivalent_usage) {
 	case WACOM_HID_WD_TOUCHRINGSTATUS:
+		if (!value)
+			input_event(input, usage->type, usage->code, 0);
 		break;
 
 	default:
@@ -2288,6 +2302,9 @@ void wacom_wac_event(struct hid_device *hdev, struct hid_field *field,
 	if (wacom->wacom_wac.features.type != HID_GENERIC)
 		return;
 
+	if (value > field->logical_maximum || value < field->logical_minimum)
+		return;
+
 	if (WACOM_PAD_FIELD(field)) {
 		wacom_wac_pad_battery_event(hdev, field, usage, value);
 		if (wacom->wacom_wac.pad_input)
-- 
2.7.4

