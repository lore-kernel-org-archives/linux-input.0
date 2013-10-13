From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/1] HID: Fix unit exponent parsing again
Date: Sun, 13 Oct 2013 15:09:52 +0300
Message-ID: <1381666192-25309-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:54836 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752680Ab3JMMKN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 13 Oct 2013 08:10:13 -0400
Received: by mail-bk0-f43.google.com with SMTP id mz13so2191747bkb.2
        for <linux-input@vger.kernel.org>; Sun, 13 Oct 2013 05:10:12 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nikolai Kondrashov <spbnick@gmail.com>

Revert some changes done in 774638386826621c984ab6994439f474709cac5e.

Revert all changes done in hidinput_calc_abs_res as it mistakingly used
"Unit" item exponent nibbles to affect resolution value. This wasn't
breaking resolution calculation of relevant axes of any existing
devices, though, as they have only one dimension to their units and thus
1 in the corresponding nible.

Revert to reading "Unit Exponent" item value as a signed integer in
hid_parser_global to fix reading specification-complying values. This
fixes resolution calculation of devices complying to the HID standard,
including Huion, KYE, Waltop and UC-Logic graphics tablets which have
their report descriptors fixed by the drivers.

Explanations follow.

There are two "unit exponents" in HID specification and it is important
not to mix them. One is the global "Unit Exponent" item and another is
nibble values in the global "Unit" item. See 6.2.2.7 Global Items.

The "Unit Exponent" value is just a signed integer and is used to scale
the integer resolution unit values, so fractions can be expressed.

The nibbles of "Unit" value are used to select the unit system (nibble
0), and presence of a particular basic unit type in the unit formula and
its *exponent* (or power, nibbles 1-6). And yes, the latter is in two
complement and zero means absence of the unit type.

Taking the representation example of (integer) joules from the
specification:

[mass(grams)][length(centimeters)^2][time(seconds)^-2] * 10^-7

the "Unit Exponent" would be -7 (or 0xF9, if stored as a byte) and the
"Unit" value would be 0xE121, signifying:

Nibble  Part        Value   Meaning
-----   ----        -----   -------
0       System      1       SI Linear
1       Length      2       Centimeters^2
2       Mass        1       Grams
3       Time        -2      Seconds^-2

To give the resolution in e.g. hundredth of joules the "Unit Exponent"
item value should have been -9.

See also the examples of "Unit" values for some common units in the same
chapter.

However, there is a common misunderstanding about the "Unit Exponent"
value encoding, where it is assumed to be stored the same as nibbles in
"Unit" item. This is most likely due to the specification being a bit
vague and overloading the term "unit exponent". This also was and still
is proliferated by the official "HID Descriptor Tool", which makes this
mistake and stores "Unit Exponent" as such. This format is also
mentioned in books such as "USB Complete" and in Microsoft's hardware
design guides.

As a result many devices currently on the market use this encoding and
so the driver should support them.
---
 drivers/hid/hid-core.c  | 11 ++++++-----
 drivers/hid/hid-input.c | 13 ++++---------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b8470b1..013cad0 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -319,7 +319,7 @@ static s32 item_sdata(struct hid_item *item)
 
 static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 {
-	__u32 raw_value;
+	__s32 raw_value;
 	switch (item->tag) {
 	case HID_GLOBAL_ITEM_TAG_PUSH:
 
@@ -370,10 +370,11 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_UNIT_EXPONENT:
-		/* Units exponent negative numbers are given through a
-		 * two's complement.
-		 * See "6.2.2.7 Global Items" for more information. */
-		raw_value = item_udata(item);
+		/* Many devices provide unit exponent as a two's complement
+		 * nibble due to the common misunderstanding of HID
+		 * specification 1.11, 6.2.2.7 Global Items. Attempt to handle
+		 * both this and the standard encoding. */
+		raw_value = item_sdata(item);
 		if (!(raw_value & 0xfffffff0))
 			parser->global.unit_exponent = hid_snto32(raw_value, 4);
 		else
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 8741d95..d97f232 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -192,6 +192,7 @@ static int hidinput_setkeycode(struct input_dev *dev,
 	return -EINVAL;
 }
 
+
 /**
  * hidinput_calc_abs_res - calculate an absolute axis resolution
  * @field: the HID report field to calculate resolution for
@@ -234,23 +235,17 @@ __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
 	case ABS_MT_TOOL_Y:
 	case ABS_MT_TOUCH_MAJOR:
 	case ABS_MT_TOUCH_MINOR:
-		if (field->unit & 0xffffff00)		/* Not a length */
-			return 0;
-		unit_exponent += hid_snto32(field->unit >> 4, 4) - 1;
-		switch (field->unit & 0xf) {
-		case 0x1:				/* If centimeters */
+		if (field->unit == 0x11) {		/* If centimeters */
 			/* Convert to millimeters */
 			unit_exponent += 1;
-			break;
-		case 0x3:				/* If inches */
+		} else if (field->unit == 0x13) {	/* If inches */
 			/* Convert to millimeters */
 			prev = physical_extents;
 			physical_extents *= 254;
 			if (physical_extents < prev)
 				return 0;
 			unit_exponent -= 1;
-			break;
-		default:
+		} else {
 			return 0;
 		}
 		break;
-- 
1.8.4.rc3

