From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH 1/1] Revert "HID: fix unit exponent parsing"
Date: Tue,  8 Oct 2013 21:59:51 +0300
Message-ID: <1381258791-24966-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:58961 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752667Ab3JHTAE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 8 Oct 2013 15:00:04 -0400
Received: by mail-we0-f181.google.com with SMTP id t60so3729543wes.26
        for <linux-input@vger.kernel.org>; Tue, 08 Oct 2013 12:00:02 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>

From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>

Revert "HID: fix unit exponent parsing" as it is based on incorrect
understanding of the HID specification and breaks resolution
calculation at least on graphics tablets.

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

This reverts commit 774638386826621c984ab6994439f474709cac5e.
---

Jiri, I've had the HID specification thoroughly read WRT report descriptors
when implementing hidrd [1] and would be happy to help reviewing any patches
touching that area. Please CC me if there's any need.

[1] https://sf.net/apps/mediawiki/digimend?title=Hidrd

 drivers/hid/hid-core.c  | 16 +---------------
 drivers/hid/hid-input.c | 13 ++++---------
 include/linux/hid.h     |  1 -
 3 files changed, 5 insertions(+), 25 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index b8470b1..94350b7 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -319,7 +319,6 @@ static s32 item_sdata(struct hid_item *item)
 
 static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 {
-	__u32 raw_value;
 	switch (item->tag) {
 	case HID_GLOBAL_ITEM_TAG_PUSH:
 
@@ -370,14 +369,7 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_UNIT_EXPONENT:
-		/* Units exponent negative numbers are given through a
-		 * two's complement.
-		 * See "6.2.2.7 Global Items" for more information. */
-		raw_value = item_udata(item);
-		if (!(raw_value & 0xfffffff0))
-			parser->global.unit_exponent = hid_snto32(raw_value, 4);
-		else
-			parser->global.unit_exponent = raw_value;
+		parser->global.unit_exponent = item_sdata(item);
 		return 0;
 
 	case HID_GLOBAL_ITEM_TAG_UNIT:
@@ -983,12 +975,6 @@ static s32 snto32(__u32 value, unsigned n)
 	return value & (1 << (n - 1)) ? value | (-1 << n) : value;
 }
 
-s32 hid_snto32(__u32 value, unsigned n)
-{
-	return snto32(value, n);
-}
-EXPORT_SYMBOL_GPL(hid_snto32);
-
 /*
  * Convert a signed 32-bit integer to a signed n-bit integer.
  */
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
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 31b9d29..96f3432 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -766,7 +766,6 @@ int hid_connect(struct hid_device *hid, unsigned int connect_mask);
 void hid_disconnect(struct hid_device *hid);
 const struct hid_device_id *hid_match_id(struct hid_device *hdev,
 					 const struct hid_device_id *id);
-s32 hid_snto32(__u32 value, unsigned n);
 
 /**
  * hid_device_io_start - enable HID input during probe, remove
-- 
1.8.4.rc3

