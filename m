From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 3/8] HID: sony: Comply to Linux gamepad spec for DS4
Date: Wed, 23 Nov 2016 14:07:08 -0800
Message-ID: <1479938833-26424-4-git-send-email-roderick@gaikai.com>
References: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f173.google.com ([209.85.161.173]:34396 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934057AbcKWWIM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Nov 2016 17:08:12 -0500
Received: by mail-yw0-f173.google.com with SMTP id t125so23657106ywc.1
        for <linux-input@vger.kernel.org>; Wed, 23 Nov 2016 14:08:12 -0800 (PST)
In-Reply-To: <1479938833-26424-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

The DS4 side of hid-sony used the hid-core layer to assign buttons
and axes based on the HID report descriptors. The default mapping
was strange e.g. right stick using ABS_Z/ABS_RZ or the physical
'south button' being reported as BTN_EAST etcetera.

This patch makes the DS4 side ofi the hid-sony driver comply to
the Linux game controller spec as suggested in a discussion with
Dmitry on the linux-input list.

Currently the main user of the DS4 is the SDL2 library, which has
a mapping table using vendor/device/version as a key. In order to
not break SDL2 we discussed adjusting the version number, so it
can have both mappings. This was discust on linux-input and we
discussed privately with SDL2 developers.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 995b5cf..d8889d6 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -977,6 +977,32 @@ static const unsigned int buzz_keymap[] = {
 	[20] = BTN_TRIGGER_HAPPY20,
 };
 
+static const unsigned int ds4_absmap[] = {
+	[0x30] = ABS_X,
+	[0x31] = ABS_Y,
+	[0x32] = ABS_RX, /* right stick X */
+	[0x33] = ABS_Z, /* L2 */
+	[0x34] = ABS_RZ, /* R2 */
+	[0x35] = ABS_RY, /* right stick Y */
+};
+
+static const unsigned int ds4_keymap[] = {
+	[0x1] = BTN_WEST, /* Square */
+	[0x2] = BTN_SOUTH, /* Cross */
+	[0x3] = BTN_EAST, /* Circle */
+	[0x4] = BTN_NORTH, /* Triangle */
+	[0x5] = BTN_TL, /* L1 */
+	[0x6] = BTN_TR, /* R1 */
+	[0x7] = BTN_TL2, /* L2 */
+	[0x8] = BTN_TR2, /* R2 */
+	[0x9] = BTN_SELECT, /* Share */
+	[0xa] = BTN_START, /* Options */
+	[0xb] = BTN_THUMBL, /* L3 */
+	[0xc] = BTN_THUMBR, /* R3 */
+	[0xd] = BTN_MODE, /* PS */
+};
+
+
 static enum power_supply_property sony_battery_props[] = {
 	POWER_SUPPLY_PROP_PRESENT,
 	POWER_SUPPLY_PROP_CAPACITY,
@@ -1143,6 +1169,37 @@ static int ps3remote_mapping(struct hid_device *hdev, struct hid_input *hi,
 	return 1;
 }
 
+static int ds4_mapping(struct hid_device *hdev, struct hid_input *hi,
+		       struct hid_field *field, struct hid_usage *usage,
+		       unsigned long **bit, int *max)
+{
+	if ((usage->hid & HID_USAGE_PAGE) == HID_UP_BUTTON) {
+		unsigned int key = usage->hid & HID_USAGE;
+
+		if (key >= ARRAY_SIZE(ds4_keymap))
+			return -1;
+
+		key = ds4_keymap[key];
+		hid_map_usage_clear(hi, usage, bit, max, EV_KEY, key);
+		return 1;
+	} else if ((usage->hid & HID_USAGE_PAGE) == HID_UP_GENDESK) {
+		unsigned int abs = usage->hid & HID_USAGE;
+
+		/* Let the HID parser deal with the HAT. */
+		if (usage->hid == HID_GD_HATSWITCH)
+			return 0;
+
+		if (abs >= ARRAY_SIZE(ds4_absmap))
+			return -1;
+
+		abs = ds4_absmap[abs];
+		hid_map_usage_clear(hi, usage, bit, max, EV_ABS, abs);
+		return 1;
+	}
+
+	return 0;
+}
+
 static u8 *sony_report_fixup(struct hid_device *hdev, u8 *rdesc,
 		unsigned int *rsize)
 {
@@ -1416,6 +1473,10 @@ static int sony_mapping(struct hid_device *hdev, struct hid_input *hi,
 	if (sc->quirks & PS3REMOTE)
 		return ps3remote_mapping(hdev, hi, field, usage, bit, max);
 
+
+	if (sc->quirks & DUALSHOCK4_CONTROLLER)
+		return ds4_mapping(hdev, hi, field, usage, bit, max);
+
 	/* Let hid-core decide for the others */
 	return 0;
 }
@@ -2578,6 +2639,15 @@ static int sony_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	else if (sc->quirks & SIXAXIS_CONTROLLER)
 		connect_mask |= HID_CONNECT_HIDDEV_FORCE;
 
+	/* Patch the hw version on DS4 compatible devices, so applications can
+	 * distinguish between the default HID mappings and the mappings defined
+	 * by the Linux game controller spec. This is important for the SDL2
+	 * library, which has a game controller database, which uses device ids
+	 * in combination with version as a key.
+	 */
+	if (sc->quirks & DUALSHOCK4_CONTROLLER)
+		hdev->version |= 0x8000;
+
 	ret = hid_hw_start(hdev, connect_mask);
 	if (ret) {
 		hid_err(hdev, "hw start failed\n");
-- 
2.7.4

