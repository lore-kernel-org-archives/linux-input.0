From: yuen@klacno.sk
Subject: Convert HID debugging messages to pr_debug
Date: Tue, 29 Mar 2011 19:22:11 +0200 (CEST)
Message-ID: <59133.10.125.50.141.1301419331.squirrel@webmail.klacno.sk>
Mime-Version: 1.0
Content-Type: multipart/mixed;boundary="----=_20110329192211_81315"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gs1.klacno.sk ([188.123.104.170]:42356 "EHLO gs1.klacno.sk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751212Ab1C2Rum (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2011 13:50:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz

------=_20110329192211_81315
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi, first patch removes hid_debug module parameter and replace remaining
debug messages with pr_debug. Debugging messages can by turned on with
standard ways as compile parameter or with dynamic printk().

Second patch converts some special HID drivers to use dev_dbg() instead o=
f
pr_debug().
------=_20110329192211_81315
Content-Type: text/x-patch; name="01hid-convert-to-pr_debug.patch"
Content-Disposition: attachment; filename="01hid-convert-to-pr_debug.patch"
Content-Transfer-Encoding: quoted-printable

diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-axff.c linux-2.6.38.2.new/drivers/hid/hid-axff.c
--- linux-2.6.38.2/drivers/hid/hid-axff.c	2011-03-29 18:00:58.111851493 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-axff.c	2011-03-29 18:01:34.3016554=
27 +0200
@@ -50,7 +50,7 @@ static int axff_play(struct input_dev *d
 	left =3D effect->u.rumble.strong_magnitude;
 	right =3D effect->u.rumble.weak_magnitude;
=20
-	dbg_hid("called with 0x%04x 0x%04x", left, right);
+	HID_DBG("called with 0x%04x 0x%04x", left, right);
=20
 	left =3D left * 0xff / 0xffff;
 	right =3D right * 0xff / 0xffff;
@@ -59,7 +59,7 @@ static int axff_play(struct input_dev *d
 	axff->report->field[1]->value[0] =3D right;
 	axff->report->field[2]->value[0] =3D left;
 	axff->report->field[3]->value[0] =3D right;
-	dbg_hid("running with 0x%02x 0x%02x", left, right);
+	HID_DBG("running with 0x%02x 0x%02x", left, right);
 	usbhid_submit_report(hid, axff->report, USB_DIR_OUT);
=20
 	return 0;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-core.c linux-2.6.38.2.new/drivers/hid/hid-core.c
--- linux-2.6.38.2/drivers/hid/hid-core.c	2011-03-29 18:00:58.111851493 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-core.c	2011-03-29 03:43:17.5000829=
01 +0200
@@ -44,11 +44,6 @@
 #define DRIVER_DESC "HID core driver"
 #define DRIVER_LICENSE "GPL"
=20
-int hid_debug =3D 0;
-module_param_named(debug, hid_debug, int, 0600);
-MODULE_PARM_DESC(debug, "toggle HID debugging messages");
-EXPORT_SYMBOL_GPL(hid_debug);
-
 /*
  * Register a new report for a device.
  */
@@ -89,7 +84,7 @@ static struct hid_field *hid_register_fi
 	struct hid_field *field;
=20
 	if (report->maxfield =3D=3D HID_MAX_FIELDS) {
-		dbg_hid("too many fields in report\n");
+		HID_DBG("too many fields in report\n");
 		return NULL;
 	}
=20
@@ -120,7 +115,7 @@ static int open_collection(struct hid_pa
 	usage =3D parser->local.usage[0];
=20
 	if (parser->collection_stack_ptr =3D=3D HID_COLLECTION_STACK_SIZE) {
-		dbg_hid("collection stack overflow\n");
+		HID_DBG("collection stack overflow\n");
 		return -1;
 	}
=20
@@ -128,7 +123,7 @@ static int open_collection(struct hid_pa
 		collection =3D kmalloc(sizeof(struct hid_collection) *
 				parser->device->collection_size * 2, GFP_KERNEL);
 		if (collection =3D=3D NULL) {
-			dbg_hid("failed to reallocate collection array\n");
+			HID_DBG("failed to reallocate collection array\n");
 			return -1;
 		}
 		memcpy(collection, parser->device->collection,
@@ -164,7 +159,7 @@ static int open_collection(struct hid_pa
 static int close_collection(struct hid_parser *parser)
 {
 	if (!parser->collection_stack_ptr) {
-		dbg_hid("collection stack underflow\n");
+		HID_DBG("collection stack underflow\n");
 		return -1;
 	}
 	parser->collection_stack_ptr--;
@@ -196,7 +191,7 @@ static unsigned hid_lookup_collection(st
 static int hid_add_usage(struct hid_parser *parser, unsigned usage)
 {
 	if (parser->local.usage_index >=3D HID_MAX_USAGES) {
-		dbg_hid("usage index exceeded\n");
+		HID_DBG("usage index exceeded\n");
 		return -1;
 	}
 	parser->local.usage[parser->local.usage_index] =3D usage;
@@ -221,12 +216,12 @@ static int hid_add_field(struct hid_pars
=20
 	report =3D hid_register_report(parser->device, report_type, parser->glo=
bal.report_id);
 	if (!report) {
-		dbg_hid("hid_register_report failed\n");
+		HID_DBG("hid_register_report failed\n");
 		return -1;
 	}
=20
 	if (parser->global.logical_maximum < parser->global.logical_minimum) {
-		dbg_hid("logical range invalid %d %d\n", parser->global.logical_minimu=
m, parser->global.logical_maximum);
+		HID_DBG("logical range invalid %d %d\n", parser->global.logical_minimu=
m, parser->global.logical_maximum);
 		return -1;
 	}
=20
@@ -306,7 +301,7 @@ static int hid_parser_global(struct hid_
 	case HID_GLOBAL_ITEM_TAG_PUSH:
=20
 		if (parser->global_stack_ptr =3D=3D HID_GLOBAL_STACK_SIZE) {
-			dbg_hid("global enviroment stack overflow\n");
+			HID_DBG("global enviroment stack overflow\n");
 			return -1;
 		}
=20
@@ -317,7 +312,7 @@ static int hid_parser_global(struct hid_
 	case HID_GLOBAL_ITEM_TAG_POP:
=20
 		if (!parser->global_stack_ptr) {
-			dbg_hid("global enviroment stack underflow\n");
+			HID_DBG("global enviroment stack underflow\n");
 			return -1;
 		}
=20
@@ -362,7 +357,7 @@ static int hid_parser_global(struct hid_
 	case HID_GLOBAL_ITEM_TAG_REPORT_SIZE:
 		parser->global.report_size =3D item_udata(item);
 		if (parser->global.report_size > 32) {
-			dbg_hid("invalid report_size %d\n",
+			HID_DBG("invalid report_size %d\n",
 					parser->global.report_size);
 			return -1;
 		}
@@ -371,7 +366,7 @@ static int hid_parser_global(struct hid_
 	case HID_GLOBAL_ITEM_TAG_REPORT_COUNT:
 		parser->global.report_count =3D item_udata(item);
 		if (parser->global.report_count > HID_MAX_USAGES) {
-			dbg_hid("invalid report_count %d\n",
+			HID_DBG("invalid report_count %d\n",
 					parser->global.report_count);
 			return -1;
 		}
@@ -380,13 +375,13 @@ static int hid_parser_global(struct hid_
 	case HID_GLOBAL_ITEM_TAG_REPORT_ID:
 		parser->global.report_id =3D item_udata(item);
 		if (parser->global.report_id =3D=3D 0) {
-			dbg_hid("report_id 0 is invalid\n");
+			HID_DBG("report_id 0 is invalid\n");
 			return -1;
 		}
 		return 0;
=20
 	default:
-		dbg_hid("unknown global tag 0x%x\n", item->tag);
+		HID_DBG("unknown global tag 0x%x\n", item->tag);
 		return -1;
 	}
 }
@@ -413,14 +408,14 @@ static int hid_parser_local(struct hid_p
 			 * items and the first delimiter set.
 			 */
 			if (parser->local.delimiter_depth !=3D 0) {
-				dbg_hid("nested delimiters\n");
+				HID_DBG("nested delimiters\n");
 				return -1;
 			}
 			parser->local.delimiter_depth++;
 			parser->local.delimiter_branch++;
 		} else {
 			if (parser->local.delimiter_depth < 1) {
-				dbg_hid("bogus close delimiter\n");
+				HID_DBG("bogus close delimiter\n");
 				return -1;
 			}
 			parser->local.delimiter_depth--;
@@ -430,7 +425,7 @@ static int hid_parser_local(struct hid_p
 	case HID_LOCAL_ITEM_TAG_USAGE:
=20
 		if (parser->local.delimiter_branch > 1) {
-			dbg_hid("alternative usage ignored\n");
+			HID_DBG("alternative usage ignored\n");
 			return 0;
 		}
=20
@@ -442,7 +437,7 @@ static int hid_parser_local(struct hid_p
 	case HID_LOCAL_ITEM_TAG_USAGE_MINIMUM:
=20
 		if (parser->local.delimiter_branch > 1) {
-			dbg_hid("alternative usage ignored\n");
+			HID_DBG("alternative usage ignored\n");
 			return 0;
 		}
=20
@@ -455,7 +450,7 @@ static int hid_parser_local(struct hid_p
 	case HID_LOCAL_ITEM_TAG_USAGE_MAXIMUM:
=20
 		if (parser->local.delimiter_branch > 1) {
-			dbg_hid("alternative usage ignored\n");
+			HID_DBG("alternative usage ignored\n");
 			return 0;
 		}
=20
@@ -464,14 +459,14 @@ static int hid_parser_local(struct hid_p
=20
 		for (n =3D parser->local.usage_minimum; n <=3D data; n++)
 			if (hid_add_usage(parser, n)) {
-				dbg_hid("hid_add_usage failed\n");
+				HID_DBG("hid_add_usage failed\n");
 				return -1;
 			}
 		return 0;
=20
 	default:
=20
-		dbg_hid("unknown local item tag 0x%x\n", item->tag);
+		HID_DBG("unknown local item tag 0x%x\n", item->tag);
 		return 0;
 	}
 	return 0;
@@ -505,7 +500,7 @@ static int hid_parser_main(struct hid_pa
 		ret =3D hid_add_field(parser, HID_FEATURE_REPORT, data);
 		break;
 	default:
-		dbg_hid("unknown main item tag 0x%x\n", item->tag);
+		HID_DBG("unknown main item tag 0x%x\n", item->tag);
 		ret =3D 0;
 	}
=20
@@ -520,7 +515,7 @@ static int hid_parser_main(struct hid_pa
=20
 static int hid_parser_reserved(struct hid_parser *parser, struct hid_ite=
m *item)
 {
-	dbg_hid("reserved item type, tag 0x%x\n", item->tag);
+	HID_DBG("reserved item type, tag 0x%x\n", item->tag);
 	return 0;
 }
=20
@@ -677,12 +672,12 @@ int hid_parse_report(struct hid_device *
 	while ((start =3D fetch_item(start, end, &item)) !=3D NULL) {
=20
 		if (item.format !=3D HID_ITEM_FORMAT_SHORT) {
-			dbg_hid("unexpected long global item\n");
+			HID_DBG("unexpected long global item\n");
 			goto err;
 		}
=20
 		if (dispatch_type[item.type](parser, &item)) {
-			dbg_hid("item %u %u %u %u parsing failed\n",
+			HID_DBG("item %u %u %u %u parsing failed\n",
 				item.format, (unsigned)item.size,
 				(unsigned)item.type, (unsigned)item.tag);
 			goto err;
@@ -690,11 +685,11 @@ int hid_parse_report(struct hid_device *
=20
 		if (start =3D=3D end) {
 			if (parser->collection_stack_ptr) {
-				dbg_hid("unbalanced collection at end of report description\n");
+				HID_DBG("unbalanced collection at end of report description\n");
 				goto err;
 			}
 			if (parser->local.delimiter_depth) {
-				dbg_hid("unbalanced delimiter at end of report description\n");
+				HID_DBG("unbalanced delimiter at end of report description\n");
 				goto err;
 			}
 			vfree(parser);
@@ -702,7 +697,7 @@ int hid_parse_report(struct hid_device *
 		}
 	}
=20
-	dbg_hid("item fetching failed at offset %d\n", (int)(end - start));
+	HID_DBG("item fetching failed at offset %d\n", (int)(end - start));
 err:
 	vfree(parser);
 	return ret;
@@ -872,7 +867,7 @@ static void hid_process_event(struct hid
 		ret =3D hdrv->event(hid, field, usage, value);
 		if (ret !=3D 0) {
 			if (ret < 0)
-				dbg_hid("%s's event failed with %d\n",
+				HID_DBG("%s's event failed with %d\n",
 						hdrv->name, ret);
 			return;
 		}
@@ -994,12 +989,12 @@ int hid_set_field(struct hid_field *fiel
 	hid_dump_input(field->report->device, field->usage + offset, value);
=20
 	if (offset >=3D field->report_count) {
-		dbg_hid("offset (%d) exceeds report_count (%d)\n", offset, field->repo=
rt_count);
+		HID_DBG("offset (%d) exceeds report_count (%d)\n", offset, field->repo=
rt_count);
 		return -1;
 	}
 	if (field->logical_minimum < 0) {
 		if (value !=3D snto32(s32ton(value, size), size)) {
-			dbg_hid("value %d is out of range\n", value);
+			HID_DBG("value %d is out of range\n", value);
 			return -1;
 		}
 	}
@@ -1020,7 +1015,7 @@ static struct hid_report *hid_get_report
=20
 	report =3D report_enum->report_id_hash[n];
 	if (report =3D=3D NULL)
-		dbg_hid("undefined report_id %u received\n", n);
+		HID_DBG("undefined report_id %u received\n", n);
=20
 	return report;
 }
@@ -1046,7 +1041,7 @@ void hid_report_raw_event(struct hid_dev
 	rsize =3D ((report->size - 1) >> 3) + 1;
=20
 	if (csize < rsize) {
-		dbg_hid("report %d is too short, (%d < %d)\n", report->id,
+		HID_DBG("report %d is too short, (%d < %d)\n", report->id,
 				csize, rsize);
 		memset(cdata + csize, 0, rsize - csize);
 	}
@@ -1090,7 +1085,7 @@ int hid_input_report(struct hid_device *
 	hdrv =3D hid->driver;
=20
 	if (!size) {
-		dbg_hid("empty report\n");
+		HID_DBG("empty report\n");
 		return -1;
 	}
=20
@@ -1996,10 +1991,6 @@ static int __init hid_init(void)
 {
 	int ret;
=20
-	if (hid_debug)
-		pr_warn("hid_debug is now used solely for parser and driver debugging.=
\n"
-			"debugfs is now used for inspecting the device (report descriptor, re=
ports)\n");
-
 	ret =3D bus_register(&hid_bus_type);
 	if (ret) {
 		pr_err("can't register hid bus\n");
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-drff.c linux-2.6.38.2.new/drivers/hid/hid-drff.c
--- linux-2.6.38.2/drivers/hid/hid-drff.c	2011-03-29 18:00:58.131851441 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-drff.c	2011-03-29 18:01:34.3016554=
27 +0200
@@ -51,7 +51,7 @@ static int drff_play(struct input_dev *d
 	strong =3D effect->u.rumble.strong_magnitude;
 	weak =3D effect->u.rumble.weak_magnitude;
=20
-	dbg_hid("called with 0x%04x 0x%04x", strong, weak);
+	HID_DBG("called with 0x%04x 0x%04x", strong, weak);
=20
 	if (strong || weak) {
 		strong =3D strong * 0xff / 0xffff;
@@ -78,7 +78,7 @@ static int drff_play(struct input_dev *d
=20
 	drff->report->field[0]->value[2] =3D 0x00;
 	drff->report->field[0]->value[4] =3D 0x00;
-	dbg_hid("running with 0x%02x 0x%02x", strong, weak);
+	HID_DBG("running with 0x%02x 0x%02x", strong, weak);
 	usbhid_submit_report(hid, drff->report, USB_DIR_OUT);
=20
 	return 0;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-emsff.c linux-2.6.38.2.new/drivers/hid/hid-emsff.c
--- linux-2.6.38.2/drivers/hid/hid-emsff.c	2011-03-29 18:00:58.131851441 =
+0200
+++ linux-2.6.38.2.new/drivers/hid/hid-emsff.c	2011-03-29 18:01:34.308322=
000 +0200
@@ -42,7 +42,7 @@ static int emsff_play(struct input_dev *
 	weak =3D effect->u.rumble.weak_magnitude;
 	strong =3D effect->u.rumble.strong_magnitude;
=20
-	dbg_hid("called with 0x%04x 0x%04x\n", strong, weak);
+	HID_DBG("called with 0x%04x 0x%04x\n", strong, weak);
=20
 	weak =3D weak * 0xff / 0xffff;
 	strong =3D strong * 0xff / 0xffff;
@@ -50,7 +50,7 @@ static int emsff_play(struct input_dev *
 	emsff->report->field[0]->value[1] =3D weak;
 	emsff->report->field[0]->value[2] =3D strong;
=20
-	dbg_hid("running with 0x%02x 0x%02x\n", strong, weak);
+	HID_DBG("running with 0x%02x 0x%02x\n", strong, weak);
 	usbhid_submit_report(hid, emsff->report, USB_DIR_OUT);
=20
 	return 0;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-gaff.c linux-2.6.38.2.new/drivers/hid/hid-gaff.c
--- linux-2.6.38.2/drivers/hid/hid-gaff.c	2011-03-29 18:00:58.131851441 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-gaff.c	2011-03-29 18:01:34.3083220=
00 +0200
@@ -50,7 +50,7 @@ static int hid_gaff_play(struct input_de
 	left =3D effect->u.rumble.strong_magnitude;
 	right =3D effect->u.rumble.weak_magnitude;
=20
-	dbg_hid("called with 0x%04x 0x%04x", left, right);
+	HID_DBG("called with 0x%04x 0x%04x", left, right);
=20
 	left =3D left * 0xfe / 0xffff;
 	right =3D right * 0xfe / 0xffff;
@@ -61,7 +61,7 @@ static int hid_gaff_play(struct input_de
 	gaff->report->field[0]->value[3] =3D 0;
 	gaff->report->field[0]->value[4] =3D left;
 	gaff->report->field[0]->value[5] =3D 0;
-	dbg_hid("running with 0x%02x 0x%02x", left, right);
+	HID_DBG("running with 0x%02x 0x%02x", left, right);
 	usbhid_submit_report(hid, gaff->report, USB_DIR_OUT);
=20
 	gaff->report->field[0]->value[0] =3D 0xfa;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-input.c linux-2.6.38.2.new/drivers/hid/hid-input.c
--- linux-2.6.38.2/drivers/hid/hid-input.c	2011-03-29 18:00:58.135184753 =
+0200
+++ linux-2.6.38.2.new/drivers/hid/hid-input.c	2011-03-29 03:45:46.525942=
224 +0200
@@ -174,7 +174,7 @@ static int hidinput_setkeycode(struct in
=20
 		clear_bit(*old_keycode, dev->keybit);
 		set_bit(usage->code, dev->keybit);
-		dbg_hid("Assigned keycode %d to HID usage code %x\n",
+		HID_DBG("Assigned keycode %d to HID usage code %x\n",
 			usage->code, usage->hid);
=20
 		/*
@@ -747,12 +747,12 @@ void hidinput_hid_event(struct hid_devic
 	}
=20
 	if (usage->hid =3D=3D (HID_UP_PID | 0x83UL)) { /* Simultaneous Effects =
Max */
-		dbg_hid("Maximum Effects - %d\n",value);
+		HID_DBG("Maximum Effects - %d\n",value);
 		return;
 	}
=20
 	if (usage->hid =3D=3D (HID_UP_PID | 0x7fUL)) {
-		dbg_hid("PID Pool Report\n");
+		HID_DBG("PID Pool Report\n");
 		return;
 	}
=20
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-lg4ff.c linux-2.6.38.2.new/drivers/hid/hid-lg4ff.c
--- linux-2.6.38.2/drivers/hid/hid-lg4ff.c	2011-03-29 18:00:58.135184753 =
+0200
+++ linux-2.6.38.2.new/drivers/hid/hid-lg4ff.c	2011-03-29 18:01:34.308322=
000 +0200
@@ -61,7 +61,7 @@ static int hid_lg4ff_play(struct input_d
 		report->field[0]->value[4] =3D 0x00;
 		report->field[0]->value[5] =3D 0x08;
 		report->field[0]->value[6] =3D 0x00;
-		dbg_hid("Autocenter, x=3D0x%02X\n", x);
+		HID_DBG("Autocenter, x=3D0x%02X\n", x);
=20
 		usbhid_submit_report(hid, report, USB_DIR_OUT);
 		break;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-lgff.c linux-2.6.38.2.new/drivers/hid/hid-lgff.c
--- linux-2.6.38.2/drivers/hid/hid-lgff.c	2011-03-29 18:00:58.135184753 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-lgff.c	2011-03-29 18:01:34.3083220=
00 +0200
@@ -96,7 +96,7 @@ static int hid_lgff_play(struct input_de
 		report->field[0]->value[1] =3D 0x08;
 		report->field[0]->value[2] =3D x;
 		report->field[0]->value[3] =3D y;
-		dbg_hid("(x, y)=3D(%04x, %04x)\n", x, y);
+		HID_DBG("(x, y)=3D(%04x, %04x)\n", x, y);
 		usbhid_submit_report(hid, report, USB_DIR_OUT);
 		break;
=20
@@ -111,7 +111,7 @@ static int hid_lgff_play(struct input_de
 		report->field[0]->value[1] =3D 0x00;
 		report->field[0]->value[2] =3D left;
 		report->field[0]->value[3] =3D right;
-		dbg_hid("(left, right)=3D(%04x, %04x)\n", left, right);
+		HID_DBG("(left, right)=3D(%04x, %04x)\n", left, right);
 		usbhid_submit_report(hid, report, USB_DIR_OUT);
 		break;
 	}
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-picolcd.c linux-2.6.38.2.new/drivers/hid/hid-picolcd.c
--- linux-2.6.38.2/drivers/hid/hid-picolcd.c	2011-03-29 18:00:58.13851806=
7 +0200
+++ linux-2.6.38.2.new/drivers/hid/hid-picolcd.c	2011-03-29 18:01:34.4049=
88261 +0200
@@ -1276,7 +1276,7 @@ static int picolcd_raw_keypad(struct pic
 		else
 			key_code =3D KEY_UNKNOWN;
 		if (key_code !=3D KEY_UNKNOWN) {
-			dbg_hid(PICOLCD_NAME " got key press for %u:%d",
+			HID_DBG(PICOLCD_NAME " got key press for %u:%d",
 					raw_data[i], key_code);
 			input_report_key(data->input_keys, key_code, 1);
 		}
@@ -1299,7 +1299,7 @@ key_already_down:
 		else
 			key_code =3D KEY_UNKNOWN;
 		if (key_code !=3D KEY_UNKNOWN) {
-			dbg_hid(PICOLCD_NAME " got key release for %u:%d",
+			HID_DBG(PICOLCD_NAME " got key release for %u:%d",
 					data->pressed_keys[j], key_code);
 			input_report_key(data->input_keys, key_code, 0);
 		}
@@ -2412,7 +2412,7 @@ static int picolcd_suspend(struct hid_de
 		return 0;
=20
 	picolcd_suspend_backlight(hid_get_drvdata(hdev));
-	dbg_hid(PICOLCD_NAME " device ready for suspend\n");
+	HID_DBG(PICOLCD_NAME " device ready for suspend\n");
 	return 0;
 }
=20
@@ -2421,7 +2421,7 @@ static int picolcd_resume(struct hid_dev
 	int ret;
 	ret =3D picolcd_resume_backlight(hid_get_drvdata(hdev));
 	if (ret)
-		dbg_hid(PICOLCD_NAME " restoring backlight failed: %d\n", ret);
+		HID_DBG(PICOLCD_NAME " restoring backlight failed: %d\n", ret);
 	return 0;
 }
=20
@@ -2430,16 +2430,16 @@ static int picolcd_reset_resume(struct h
 	int ret;
 	ret =3D picolcd_reset(hdev);
 	if (ret)
-		dbg_hid(PICOLCD_NAME " resetting our device failed: %d\n", ret);
+		HID_DBG(PICOLCD_NAME " resetting our device failed: %d\n", ret);
 	ret =3D picolcd_fb_reset(hid_get_drvdata(hdev), 0);
 	if (ret)
-		dbg_hid(PICOLCD_NAME " restoring framebuffer content failed: %d\n", re=
t);
+		HID_DBG(PICOLCD_NAME " restoring framebuffer content failed: %d\n", re=
t);
 	ret =3D picolcd_resume_lcd(hid_get_drvdata(hdev));
 	if (ret)
-		dbg_hid(PICOLCD_NAME " restoring lcd failed: %d\n", ret);
+		HID_DBG(PICOLCD_NAME " restoring lcd failed: %d\n", ret);
 	ret =3D picolcd_resume_backlight(hid_get_drvdata(hdev));
 	if (ret)
-		dbg_hid(PICOLCD_NAME " restoring backlight failed: %d\n", ret);
+		HID_DBG(PICOLCD_NAME " restoring backlight failed: %d\n", ret);
 	picolcd_leds_set(hid_get_drvdata(hdev));
 	return 0;
 }
@@ -2595,7 +2595,7 @@ static int picolcd_probe(struct hid_devi
 	struct picolcd_data *data;
 	int error =3D -ENOMEM;
=20
-	dbg_hid(PICOLCD_NAME " hardware probe...\n");
+	HID_DBG(PICOLCD_NAME " hardware probe...\n");
=20
 	/*
 	 * Let's allocate the picolcd data structure, set some reasonable
@@ -2658,7 +2658,7 @@ static int picolcd_probe(struct hid_devi
 	if (error)
 		goto err_cleanup_sysfs2;
=20
-	dbg_hid(PICOLCD_NAME " activated and initialized\n");
+	HID_DBG(PICOLCD_NAME " activated and initialized\n");
 	return 0;
=20
 err_cleanup_sysfs2:
@@ -2682,7 +2682,7 @@ static void picolcd_remove(struct hid_de
 	struct picolcd_data *data =3D hid_get_drvdata(hdev);
 	unsigned long flags;
=20
-	dbg_hid(PICOLCD_NAME " hardware remove...\n");
+	HID_DBG(PICOLCD_NAME " hardware remove...\n");
 	spin_lock_irqsave(&data->lock, flags);
 	data->status |=3D PICOLCD_FAILED;
 	spin_unlock_irqrestore(&data->lock, flags);
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-prodikeys.c linux-2.6.38.2.new/drivers/hid/hid-prodikeys.c
--- linux-2.6.38.2/drivers/hid/hid-prodikeys.c	2011-03-29 18:00:58.141851=
382 +0200
+++ linux-2.6.38.2.new/drivers/hid/hid-prodikeys.c	2011-03-29 16:06:35.53=
8474585 +0200
@@ -109,7 +109,7 @@ static ssize_t show_channel(struct devic
 	struct hid_device *hdev =3D container_of(dev, struct hid_device, dev);
 	struct pk_device *pk =3D (struct pk_device *)hid_get_drvdata(hdev);
=20
-	dbg_hid("pcmidi sysfs read channel=3D%u\n", pk->pm->midi_channel);
+	HID_DBG("pcmidi sysfs read channel=3D%u\n", pk->pm->midi_channel);
=20
 	return sprintf(buf, "%u (min:%u, max:%u)\n", pk->pm->midi_channel,
 		PCMIDI_CHANNEL_MIN, PCMIDI_CHANNEL_MAX);
@@ -125,7 +125,7 @@ static ssize_t store_channel(struct devi
 	unsigned channel =3D 0;
=20
 	if (sscanf(buf, "%u", &channel) > 0 && channel <=3D PCMIDI_CHANNEL_MAX)=
 {
-		dbg_hid("pcmidi sysfs write channel=3D%u\n", channel);
+		HID_DBG("pcmidi sysfs write channel=3D%u\n", channel);
 		pk->pm->midi_channel =3D channel;
 		return strlen(buf);
 	}
@@ -146,7 +146,7 @@ static ssize_t show_sustain(struct devic
 	struct hid_device *hdev =3D container_of(dev, struct hid_device, dev);
 	struct pk_device *pk =3D (struct pk_device *)hid_get_drvdata(hdev);
=20
-	dbg_hid("pcmidi sysfs read sustain=3D%u\n", pk->pm->midi_sustain);
+	HID_DBG("pcmidi sysfs read sustain=3D%u\n", pk->pm->midi_sustain);
=20
 	return sprintf(buf, "%u (off:%u, max:%u (ms))\n", pk->pm->midi_sustain,
 		PCMIDI_SUSTAIN_MIN, PCMIDI_SUSTAIN_MAX);
@@ -162,7 +162,7 @@ static ssize_t store_sustain(struct devi
 	unsigned sustain =3D 0;
=20
 	if (sscanf(buf, "%u", &sustain) > 0 && sustain <=3D PCMIDI_SUSTAIN_MAX)=
 {
-		dbg_hid("pcmidi sysfs write sustain=3D%u\n", sustain);
+		HID_DBG("pcmidi sysfs write sustain=3D%u\n", sustain);
 		pk->pm->midi_sustain =3D sustain;
 		pk->pm->midi_sustain_mode =3D
 			(0 =3D=3D sustain || !pk->pm->midi_mode) ? 0 : 1;
@@ -185,7 +185,7 @@ static ssize_t show_octave(struct device
 	struct hid_device *hdev =3D container_of(dev, struct hid_device, dev);
 	struct pk_device *pk =3D (struct pk_device *)hid_get_drvdata(hdev);
=20
-	dbg_hid("pcmidi sysfs read octave=3D%d\n", pk->pm->midi_octave);
+	HID_DBG("pcmidi sysfs read octave=3D%d\n", pk->pm->midi_octave);
=20
 	return sprintf(buf, "%d (min:%d, max:%d)\n", pk->pm->midi_octave,
 		PCMIDI_OCTAVE_MIN, PCMIDI_OCTAVE_MAX);
@@ -202,7 +202,7 @@ static ssize_t store_octave(struct devic
=20
 	if (sscanf(buf, "%d", &octave) > 0 &&
 		octave >=3D PCMIDI_OCTAVE_MIN && octave <=3D PCMIDI_OCTAVE_MAX) {
-		dbg_hid("pcmidi sysfs write octave=3D%d\n", octave);
+		HID_DBG("pcmidi sysfs write octave=3D%d\n", octave);
 		pk->pm->midi_octave =3D octave;
 		return strlen(buf);
 	}
@@ -319,7 +319,7 @@ static int pcmidi_handle_report1(struct=20
 	bit_mask =3D (bit_mask << 8) | data[2];
 	bit_mask =3D (bit_mask << 8) | data[3];
=20
-	dbg_hid("pcmidi mode: %d\n", pm->midi_mode);
+	HID_DBG("pcmidi mode: %d\n", pm->midi_mode);
=20
 	/*KEY_MAIL or octave down*/
 	if (pm->midi_mode && bit_mask =3D=3D 0x004000) {
@@ -327,7 +327,7 @@ static int pcmidi_handle_report1(struct=20
 		pm->midi_octave--;
 		if (pm->midi_octave < -2)
 			pm->midi_octave =3D -2;
-		dbg_hid("pcmidi mode: %d octave: %d\n",
+		HID_DBG("pcmidi mode: %d octave: %d\n",
 			pm->midi_mode, pm->midi_octave);
 		return 1;
 	}
@@ -421,15 +421,15 @@ static int pcmidi_handle_report4(struct=20
 			pcmidi_submit_output_report(pm, 0xc1);
 			pm->midi_mode ^=3D 0x01;
=20
-			dbg_hid("pcmidi mode: %d\n", pm->midi_mode);
+			HID_DBG("pcmidi mode: %d\n", pm->midi_mode);
 			continue;
 		case 0x100000: /* KEY_MESSENGER or octave up */
-			dbg_hid("pcmidi mode: %d\n", pm->midi_mode);
+			HID_DBG("pcmidi mode: %d\n", pm->midi_mode);
 			if (pm->midi_mode) {
 				pm->midi_octave++;
 				if (pm->midi_octave > 2)
 					pm->midi_octave =3D 2;
-				dbg_hid("pcmidi mode: %d octave: %d\n",
+				HID_DBG("pcmidi mode: %d octave: %d\n",
 					pm->midi_mode, pm->midi_octave);
 			    continue;
 			} else
@@ -576,14 +576,14 @@ static int pcmidi_in_open(struct snd_raw
 {
 	struct pcmidi_snd *pm =3D substream->rmidi->private_data;
=20
-	dbg_hid("pcmidi in open\n");
+	HID_DBG("pcmidi in open\n");
 	pm->in_substream =3D substream;
 	return 0;
 }
=20
 static int pcmidi_in_close(struct snd_rawmidi_substream *substream)
 {
-	dbg_hid("pcmidi in close\n");
+	HID_DBG("pcmidi in close\n");
 	return 0;
 }
=20
@@ -591,7 +591,7 @@ static void pcmidi_in_trigger(struct snd
 {
 	struct pcmidi_snd *pm =3D substream->rmidi->private_data;
=20
-	dbg_hid("pcmidi in trigger %d\n", up);
+	HID_DBG("pcmidi in trigger %d\n", up);
=20
 	pm->in_triggered =3D up;
 }
@@ -702,7 +702,7 @@ int pcmidi_snd_initialise(struct pcmidi_
 			 goto fail_register;
 	}
=20
-	dbg_hid("pcmidi_snd_initialise finished ok\n");
+	HID_DBG("pcmidi_snd_initialise finished ok\n");
 	return 0;
=20
 fail_register:
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-samsung.c linux-2.6.38.2.new/drivers/hid/hid-samsung.c
--- linux-2.6.38.2/drivers/hid/hid-samsung.c	2011-03-29 18:00:58.14185138=
2 +0200
+++ linux-2.6.38.2.new/drivers/hid/hid-samsung.c	2011-03-29 18:01:34.4116=
54893 +0200
@@ -108,7 +108,7 @@ static int samsung_kbd_mouse_input_mappi
 	if (1 !=3D ifnum || HID_UP_CONSUMER !=3D (usage->hid & HID_USAGE_PAGE))
 		return 0;
=20
-	dbg_hid("samsung wireless keyboard/mouse input mapping event [0x%x]\n",
+	HID_DBG("samsung wireless keyboard/mouse input mapping event [0x%x]\n",
 		usage->hid & HID_USAGE);
=20
 	switch (usage->hid & HID_USAGE) {
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-tmff.c linux-2.6.38.2.new/drivers/hid/hid-tmff.c
--- linux-2.6.38.2/drivers/hid/hid-tmff.c	2011-03-29 18:00:58.141851382 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-tmff.c	2011-03-29 18:01:34.4116548=
93 +0200
@@ -99,7 +99,7 @@ static int tmff_play(struct input_dev *d
 					ff_field->logical_minimum,
 					ff_field->logical_maximum);
=20
-		dbg_hid("(x, y)=3D(%04x, %04x)\n", x, y);
+		HID_DBG("(x, y)=3D(%04x, %04x)\n", x, y);
 		ff_field->value[0] =3D x;
 		ff_field->value[1] =3D y;
 		usbhid_submit_report(hid, tmff->report, USB_DIR_OUT);
@@ -113,7 +113,7 @@ static int tmff_play(struct input_dev *d
 					ff_field->logical_minimum,
 					ff_field->logical_maximum);
=20
-		dbg_hid("(left,right)=3D(%08x, %08x)\n", left, right);
+		HID_DBG("(left,right)=3D(%08x, %08x)\n", left, right);
 		ff_field->value[0] =3D left;
 		ff_field->value[1] =3D right;
 		usbhid_submit_report(hid, tmff->report, USB_DIR_OUT);
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-zpff.c linux-2.6.38.2.new/drivers/hid/hid-zpff.c
--- linux-2.6.38.2/drivers/hid/hid-zpff.c	2011-03-29 18:00:58.145184698 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-zpff.c	2011-03-29 18:01:34.4116548=
93 +0200
@@ -50,14 +50,14 @@ static int zpff_play(struct input_dev *d
=20
 	left =3D effect->u.rumble.strong_magnitude;
 	right =3D effect->u.rumble.weak_magnitude;
-	dbg_hid("called with 0x%04x 0x%04x\n", left, right);
+	HID_DBG("called with 0x%04x 0x%04x\n", left, right);
=20
 	left =3D left * 0x7f / 0xffff;
 	right =3D right * 0x7f / 0xffff;
=20
 	zpff->report->field[2]->value[0] =3D left;
 	zpff->report->field[3]->value[0] =3D right;
-	dbg_hid("running with 0x%02x 0x%02x\n", left, right);
+	HID_DBG("running with 0x%02x 0x%02x\n", left, right);
 	usbhid_submit_report(hid, zpff->report, USB_DIR_OUT);
=20
 	return 0;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-zydacron.c linux-2.6.38.2.new/drivers/hid/hid-zydacron.c
--- linux-2.6.38.2/drivers/hid/hid-zydacron.c	2011-03-29 18:00:58.1451846=
98 +0200
+++ linux-2.6.38.2.new/drivers/hid/hid-zydacron.c	2011-03-29 18:01:34.414=
988209 +0200
@@ -56,7 +56,7 @@ static int zc_input_mapping(struct hid_d
 	if ((usage->hid & HID_USAGE_PAGE) !=3D HID_UP_CONSUMER)
 		return 0;
=20
-	dbg_hid("zynacron input mapping event [0x%x]\n",
+	HID_DBG("zynacron input mapping event [0x%x]\n",
 		usage->hid & HID_USAGE);
=20
 	switch (usage->hid & HID_USAGE) {
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/usbhid/hid-core.c linux-2.6.38.2.new/drivers/hid/usbhid/hid-core.c
--- linux-2.6.38.2/drivers/hid/usbhid/hid-core.c	2011-03-29 18:00:58.1685=
17905 +0200
+++ linux-2.6.38.2.new/drivers/hid/usbhid/hid-core.c	2011-03-29 03:44:15.=
666434452 +0200
@@ -318,7 +318,7 @@ static int hid_submit_out(struct hid_dev
 		memcpy(usbhid->outbuf, raw_report, usbhid->urbout->transfer_buffer_len=
gth);
 		kfree(raw_report);
=20
-		dbg_hid("submitting out urb\n");
+		HID_DBG("submitting out urb\n");
=20
 		if (usb_submit_urb(usbhid->urbout, GFP_ATOMIC)) {
 			hid_err(hid, "usb_submit_urb(out) failed\n");
@@ -375,7 +375,7 @@ static int hid_submit_ctrl(struct hid_de
 		usbhid->cr->wIndex =3D cpu_to_le16(usbhid->ifnum);
 		usbhid->cr->wLength =3D cpu_to_le16(len);
=20
-		dbg_hid("submitting ctrl urb: %s wValue=3D0x%04x wIndex=3D0x%04x wLeng=
th=3D%u\n",
+		HID_DBG("submitting ctrl urb: %s wValue=3D0x%04x wIndex=3D0x%04x wLeng=
th=3D%u\n",
 			usbhid->cr->bRequest =3D=3D HID_REQ_SET_REPORT ? "Set_Report" : "Get_=
Report",
 			usbhid->cr->wValue, usbhid->cr->wIndex, usbhid->cr->wLength);
=20
@@ -618,7 +618,7 @@ int usbhid_wait_io(struct hid_device *hi
 				(!test_bit(HID_CTRL_RUNNING, &usbhid->iofl) &&
 				!test_bit(HID_OUT_RUNNING, &usbhid->iofl)),
 					10*HZ)) {
-		dbg_hid("timeout waiting for ctrl or out queue to clear\n");
+		HID_DBG("timeout waiting for ctrl or out queue to clear\n");
 		return -1;
 	}
=20
@@ -896,7 +896,7 @@ static int usbhid_parse(struct hid_devic
 	if (usb_get_extra_descriptor(interface, HID_DT_HID, &hdesc) &&
 	    (!interface->desc.bNumEndpoints ||
 	     usb_get_extra_descriptor(&interface->endpoint[0], HID_DT_HID, &hde=
sc))) {
-		dbg_hid("class descriptor not present\n");
+		HID_DBG("class descriptor not present\n");
 		return -ENODEV;
 	}
=20
@@ -908,12 +908,12 @@ static int usbhid_parse(struct hid_devic
 			rsize =3D le16_to_cpu(hdesc->desc[n].wDescriptorLength);
=20
 	if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
-		dbg_hid("weird size of report descriptor (%u)\n", rsize);
+		HID_DBG("weird size of report descriptor (%u)\n", rsize);
 		return -EINVAL;
 	}
=20
 	if (!(rdesc =3D kmalloc(rsize, GFP_KERNEL))) {
-		dbg_hid("couldn't allocate rdesc memory\n");
+		HID_DBG("couldn't allocate rdesc memory\n");
 		return -ENOMEM;
 	}
=20
@@ -922,7 +922,7 @@ static int usbhid_parse(struct hid_devic
 	ret =3D hid_get_class_descriptor(dev, interface->desc.bInterfaceNumber,
 			HID_DT_REPORT, rdesc, rsize);
 	if (ret < 0) {
-		dbg_hid("reading report descriptor failed\n");
+		HID_DBG("reading report descriptor failed\n");
 		kfree(rdesc);
 		goto err;
 	}
@@ -930,7 +930,7 @@ static int usbhid_parse(struct hid_devic
 	ret =3D hid_parse_report(hid, rdesc, rsize);
 	kfree(rdesc);
 	if (ret) {
-		dbg_hid("parsing report descriptor failed\n");
+		HID_DBG("parsing report descriptor failed\n");
 		goto err;
 	}
=20
@@ -1122,7 +1122,7 @@ static int usbhid_probe(struct usb_inter
 	size_t len;
 	int ret;
=20
-	dbg_hid("HID probe called for ifnum %d\n",
+	HID_DBG("HID probe called for ifnum %d\n",
 			intf->altsetting->desc.bInterfaceNumber);
=20
 	for (n =3D 0; n < interface->desc.bNumEndpoints; n++)
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/usbhid/hid-quirks.c linux-2.6.38.2.new/drivers/hid/usbhid/hid-quirk=
s.c
--- linux-2.6.38.2/drivers/hid/usbhid/hid-quirks.c	2011-03-29 18:00:58.17=
5184535 +0200
+++ linux-2.6.38.2.new/drivers/hid/usbhid/hid-quirks.c	2011-03-29 03:44:5=
1.856238394 +0200
@@ -126,7 +126,7 @@ static struct hid_blacklist *usbhid_exis
 	}
=20
 	if (bl_entry !=3D NULL)
-		dbg_hid("Found dynamic quirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\=
n",
+		HID_DBG("Found dynamic quirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\=
n",
 				bl_entry->quirks, bl_entry->idVendor,
 				bl_entry->idProduct);
=20
@@ -154,13 +154,13 @@ static int usbhid_modify_dquirk(const u1
 	int list_edited =3D 0;
=20
 	if (!idVendor) {
-		dbg_hid("Cannot add a quirk with idVendor =3D 0\n");
+		HID_DBG("Cannot add a quirk with idVendor =3D 0\n");
 		return -EINVAL;
 	}
=20
 	q_new =3D kmalloc(sizeof(struct quirks_list_struct), GFP_KERNEL);
 	if (!q_new) {
-		dbg_hid("Could not allocate quirks_list_struct\n");
+		HID_DBG("Could not allocate quirks_list_struct\n");
 		return -ENOMEM;
 	}
=20
@@ -275,7 +275,7 @@ static const struct hid_blacklist *usbhi
 			bl_entry =3D &hid_blacklist[n];
=20
 	if (bl_entry !=3D NULL)
-		dbg_hid("Found squirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
+		HID_DBG("Found squirk 0x%x for USB HID vendor 0x%hx prod 0x%hx\n",
 				bl_entry->quirks, bl_entry->idVendor,=20
 				bl_entry->idProduct);
 	return bl_entry;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/includ=
e/linux/hid.h linux-2.6.38.2.new/include/linux/hid.h
--- linux-2.6.38.2/include/linux/hid.h	2011-03-29 18:00:58.195184427 +020=
0
+++ linux-2.6.38.2.new/include/linux/hid.h	2011-03-29 14:41:04.036274317 =
+0200
@@ -884,11 +884,8 @@ int hid_pidff_init(struct hid_device *hi
 #define hid_pidff_init NULL
 #endif
=20
-#define dbg_hid(format, arg...)						\
-do {									\
-	if (hid_debug)							\
-		printk(KERN_DEBUG "%s: " format, __FILE__, ##arg);	\
-} while (0)
+#define HID_DBG(fmt, arg...)				\
+	pr_debug("%s: " fmt "\n" , __func__ , ##arg)
=20
 #define hid_printk(level, hid, fmt, arg...)		\
 	dev_printk(level, &(hid)->dev, fmt, ##arg)
------=_20110329192211_81315
Content-Type: text/x-patch;
      name="02hid-convert-misc-drivers-to-dev_dbg.patch"
Content-Disposition: attachment;
      filename="02hid-convert-misc-drivers-to-dev_dbg.patch"
Content-Transfer-Encoding: quoted-printable

diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-axff.c linux-2.6.38.2.new/drivers/hid/hid-axff.c
--- linux-2.6.38.2/drivers/hid/hid-axff.c	2011-03-29 16:58:21.614980857 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-axff.c	2011-03-29 15:08:11.1741248=
11 +0200
@@ -50,7 +50,7 @@ static int axff_play(struct input_dev *d
 	left =3D effect->u.rumble.strong_magnitude;
 	right =3D effect->u.rumble.weak_magnitude;
=20
-	HID_DBG("called with 0x%04x 0x%04x", left, right);
+	hid_dbg(hid, "called with 0x%04x 0x%04x", left, right);
=20
 	left =3D left * 0xff / 0xffff;
 	right =3D right * 0xff / 0xffff;
@@ -59,7 +59,7 @@ static int axff_play(struct input_dev *d
 	axff->report->field[1]->value[0] =3D right;
 	axff->report->field[2]->value[0] =3D left;
 	axff->report->field[3]->value[0] =3D right;
-	HID_DBG("running with 0x%02x 0x%02x", left, right);
+	hid_dbg(hid, "running with 0x%02x 0x%02x", left, right);
 	usbhid_submit_report(hid, axff->report, USB_DIR_OUT);
=20
 	return 0;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-drff.c linux-2.6.38.2.new/drivers/hid/hid-drff.c
--- linux-2.6.38.2/drivers/hid/hid-drff.c	2011-03-29 16:58:21.648314009 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-drff.c	2011-03-29 15:06:42.0646087=
87 +0200
@@ -51,7 +51,7 @@ static int drff_play(struct input_dev *d
 	strong =3D effect->u.rumble.strong_magnitude;
 	weak =3D effect->u.rumble.weak_magnitude;
=20
-	HID_DBG("called with 0x%04x 0x%04x", strong, weak);
+	hid_dbg(hid, "called with 0x%04x 0x%04x", strong, weak);
=20
 	if (strong || weak) {
 		strong =3D strong * 0xff / 0xffff;
@@ -78,7 +78,7 @@ static int drff_play(struct input_dev *d
=20
 	drff->report->field[0]->value[2] =3D 0x00;
 	drff->report->field[0]->value[4] =3D 0x00;
-	HID_DBG("running with 0x%02x 0x%02x", strong, weak);
+	hid_dbg(hid, "running with 0x%02x 0x%02x", strong, weak);
 	usbhid_submit_report(hid, drff->report, USB_DIR_OUT);
=20
 	return 0;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-emsff.c linux-2.6.38.2.new/drivers/hid/hid-emsff.c
--- linux-2.6.38.2/drivers/hid/hid-emsff.c	2011-03-29 16:58:21.648314009 =
+0200
+++ linux-2.6.38.2.new/drivers/hid/hid-emsff.c	2011-03-29 15:06:09.074784=
734 +0200
@@ -42,7 +42,7 @@ static int emsff_play(struct input_dev *
 	weak =3D effect->u.rumble.weak_magnitude;
 	strong =3D effect->u.rumble.strong_magnitude;
=20
-	HID_DBG("called with 0x%04x 0x%04x\n", strong, weak);
+	hid_dbg(hid, "called with 0x%04x 0x%04x\n", strong, weak);
=20
 	weak =3D weak * 0xff / 0xffff;
 	strong =3D strong * 0xff / 0xffff;
@@ -50,7 +50,7 @@ static int emsff_play(struct input_dev *
 	emsff->report->field[0]->value[1] =3D weak;
 	emsff->report->field[0]->value[2] =3D strong;
=20
-	HID_DBG("running with 0x%02x 0x%02x\n", strong, weak);
+	hid_dbg(hid, "running with 0x%02x 0x%02x\n", strong, weak);
 	usbhid_submit_report(hid, emsff->report, USB_DIR_OUT);
=20
 	return 0;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-gaff.c linux-2.6.38.2.new/drivers/hid/hid-gaff.c
--- linux-2.6.38.2/drivers/hid/hid-gaff.c	2011-03-29 16:58:21.648314009 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-gaff.c	2011-03-29 15:00:31.2266169=
22 +0200
@@ -50,7 +50,7 @@ static int hid_gaff_play(struct input_de
 	left =3D effect->u.rumble.strong_magnitude;
 	right =3D effect->u.rumble.weak_magnitude;
=20
-	HID_DBG("called with 0x%04x 0x%04x", left, right);
+	hid_dbg(hid, "called with 0x%04x 0x%04x", left, right);
=20
 	left =3D left * 0xfe / 0xffff;
 	right =3D right * 0xfe / 0xffff;
@@ -61,7 +61,8 @@ static int hid_gaff_play(struct input_de
 	gaff->report->field[0]->value[3] =3D 0;
 	gaff->report->field[0]->value[4] =3D left;
 	gaff->report->field[0]->value[5] =3D 0;
-	HID_DBG("running with 0x%02x 0x%02x", left, right);
+	hid_dbg(hid, "running with 0x%02x 0x%02x", left, right);
+=09
 	usbhid_submit_report(hid, gaff->report, USB_DIR_OUT);
=20
 	gaff->report->field[0]->value[0] =3D 0xfa;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-lg4ff.c linux-2.6.38.2.new/drivers/hid/hid-lg4ff.c
--- linux-2.6.38.2/drivers/hid/hid-lg4ff.c	2011-03-29 16:58:21.651647324 =
+0200
+++ linux-2.6.38.2.new/drivers/hid/hid-lg4ff.c	2011-03-29 15:00:44.336546=
873 +0200
@@ -61,7 +61,7 @@ static int hid_lg4ff_play(struct input_d
 		report->field[0]->value[4] =3D 0x00;
 		report->field[0]->value[5] =3D 0x08;
 		report->field[0]->value[6] =3D 0x00;
-		HID_DBG("Autocenter, x=3D0x%02X\n", x);
+		hid_dbg(hid, "Autocenter, x=3D0x%02X\n", x);
=20
 		usbhid_submit_report(hid, report, USB_DIR_OUT);
 		break;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-lgff.c linux-2.6.38.2.new/drivers/hid/hid-lgff.c
--- linux-2.6.38.2/drivers/hid/hid-lgff.c	2011-03-29 16:58:21.651647324 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-lgff.c	2011-03-29 15:04:46.5119002=
18 +0200
@@ -96,7 +96,7 @@ static int hid_lgff_play(struct input_de
 		report->field[0]->value[1] =3D 0x08;
 		report->field[0]->value[2] =3D x;
 		report->field[0]->value[3] =3D y;
-		HID_DBG("(x, y)=3D(%04x, %04x)\n", x, y);
+		hid_dbg(hid, "(x, y)=3D(%04x, %04x)\n", x, y);
 		usbhid_submit_report(hid, report, USB_DIR_OUT);
 		break;
=20
@@ -111,7 +111,7 @@ static int hid_lgff_play(struct input_de
 		report->field[0]->value[1] =3D 0x00;
 		report->field[0]->value[2] =3D left;
 		report->field[0]->value[3] =3D right;
-		HID_DBG("(left, right)=3D(%04x, %04x)\n", left, right);
+		hid_dbg(hid, "(left, right)=3D(%04x, %04x)\n", left, right);
 		usbhid_submit_report(hid, report, USB_DIR_OUT);
 		break;
 	}
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-picolcd.c linux-2.6.38.2.new/drivers/hid/hid-picolcd.c
--- linux-2.6.38.2/drivers/hid/hid-picolcd.c	2011-03-29 16:58:21.65498063=
9 +0200
+++ linux-2.6.38.2.new/drivers/hid/hid-picolcd.c	2011-03-29 16:43:43.5330=
71245 +0200
@@ -1276,8 +1276,9 @@ static int picolcd_raw_keypad(struct pic
 		else
 			key_code =3D KEY_UNKNOWN;
 		if (key_code !=3D KEY_UNKNOWN) {
-			HID_DBG(PICOLCD_NAME " got key press for %u:%d",
-					raw_data[i], key_code);
+			hid_dbg(report->device,=20
+				PICOLCD_NAME " got key press for %u:%d",
+				raw_data[i], key_code);
 			input_report_key(data->input_keys, key_code, 1);
 		}
 		input_sync(data->input_keys);
@@ -1299,8 +1300,9 @@ key_already_down:
 		else
 			key_code =3D KEY_UNKNOWN;
 		if (key_code !=3D KEY_UNKNOWN) {
-			HID_DBG(PICOLCD_NAME " got key release for %u:%d",
-					data->pressed_keys[j], key_code);
+			hid_dbg(report->device,=20
+				PICOLCD_NAME " got key release for %u:%d",
+				data->pressed_keys[j], key_code);
 			input_report_key(data->input_keys, key_code, 0);
 		}
 		input_sync(data->input_keys);
@@ -2412,7 +2414,7 @@ static int picolcd_suspend(struct hid_de
 		return 0;
=20
 	picolcd_suspend_backlight(hid_get_drvdata(hdev));
-	HID_DBG(PICOLCD_NAME " device ready for suspend\n");
+	hid_dbg(hdev, PICOLCD_NAME " device ready for suspend\n");
 	return 0;
 }
=20
@@ -2421,7 +2423,8 @@ static int picolcd_resume(struct hid_dev
 	int ret;
 	ret =3D picolcd_resume_backlight(hid_get_drvdata(hdev));
 	if (ret)
-		HID_DBG(PICOLCD_NAME " restoring backlight failed: %d\n", ret);
+		hid_dbg(hdev, PICOLCD_NAME " restoring backlight failed: %d\n",
+			ret);
 	return 0;
 }
=20
@@ -2430,16 +2433,19 @@ static int picolcd_reset_resume(struct h
 	int ret;
 	ret =3D picolcd_reset(hdev);
 	if (ret)
-		HID_DBG(PICOLCD_NAME " resetting our device failed: %d\n", ret);
+		hid_dbg(hdev, PICOLCD_NAME " resetting our device failed: %d\n",
+			ret);
 	ret =3D picolcd_fb_reset(hid_get_drvdata(hdev), 0);
 	if (ret)
-		HID_DBG(PICOLCD_NAME " restoring framebuffer content failed: %d\n", re=
t);
+		hid_dbg(hdev, PICOLCD_NAME
+			" restoring framebuffer content failed: %d\n", ret);
 	ret =3D picolcd_resume_lcd(hid_get_drvdata(hdev));
 	if (ret)
-		HID_DBG(PICOLCD_NAME " restoring lcd failed: %d\n", ret);
+		hid_dbg(hdev, PICOLCD_NAME " restoring lcd failed: %d\n", ret);
 	ret =3D picolcd_resume_backlight(hid_get_drvdata(hdev));
 	if (ret)
-		HID_DBG(PICOLCD_NAME " restoring backlight failed: %d\n", ret);
+		hid_dbg(hdev, PICOLCD_NAME " restoring backlight failed: %d\n",
+			ret);
 	picolcd_leds_set(hid_get_drvdata(hdev));
 	return 0;
 }
@@ -2595,7 +2601,7 @@ static int picolcd_probe(struct hid_devi
 	struct picolcd_data *data;
 	int error =3D -ENOMEM;
=20
-	HID_DBG(PICOLCD_NAME " hardware probe...\n");
+	hid_dbg(hdev, PICOLCD_NAME " hardware probe...\n");
=20
 	/*
 	 * Let's allocate the picolcd data structure, set some reasonable
@@ -2658,7 +2664,7 @@ static int picolcd_probe(struct hid_devi
 	if (error)
 		goto err_cleanup_sysfs2;
=20
-	HID_DBG(PICOLCD_NAME " activated and initialized\n");
+	hid_dbg(hdev, PICOLCD_NAME " activated and initialized\n");
 	return 0;
=20
 err_cleanup_sysfs2:
@@ -2682,7 +2688,7 @@ static void picolcd_remove(struct hid_de
 	struct picolcd_data *data =3D hid_get_drvdata(hdev);
 	unsigned long flags;
=20
-	HID_DBG(PICOLCD_NAME " hardware remove...\n");
+	hid_dbg(hdev, PICOLCD_NAME " hardware remove...\n");
 	spin_lock_irqsave(&data->lock, flags);
 	data->status |=3D PICOLCD_FAILED;
 	spin_unlock_irqrestore(&data->lock, flags);
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-samsung.c linux-2.6.38.2.new/drivers/hid/hid-samsung.c
--- linux-2.6.38.2/drivers/hid/hid-samsung.c	2011-03-29 16:58:21.66164727=
0 +0200
+++ linux-2.6.38.2.new/drivers/hid/hid-samsung.c	2011-03-29 14:59:33.4069=
30570 +0200
@@ -108,7 +108,8 @@ static int samsung_kbd_mouse_input_mappi
 	if (1 !=3D ifnum || HID_UP_CONSUMER !=3D (usage->hid & HID_USAGE_PAGE))
 		return 0;
=20
-	HID_DBG("samsung wireless keyboard/mouse input mapping event [0x%x]\n",
+	hid_dbg(hdev,=20
+		"samsung wireless keyboard/mouse input mapping event [0x%x]\n",
 		usage->hid & HID_USAGE);
=20
 	switch (usage->hid & HID_USAGE) {
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-tmff.c linux-2.6.38.2.new/drivers/hid/hid-tmff.c
--- linux-2.6.38.2/drivers/hid/hid-tmff.c	2011-03-29 16:58:21.664980586 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-tmff.c	2011-03-29 15:07:39.8276291=
80 +0200
@@ -99,7 +99,7 @@ static int tmff_play(struct input_dev *d
 					ff_field->logical_minimum,
 					ff_field->logical_maximum);
=20
-		HID_DBG("(x, y)=3D(%04x, %04x)\n", x, y);
+		hid_dbg(hid, "(x, y)=3D(%04x, %04x)\n", x, y);
 		ff_field->value[0] =3D x;
 		ff_field->value[1] =3D y;
 		usbhid_submit_report(hid, tmff->report, USB_DIR_OUT);
@@ -113,7 +113,7 @@ static int tmff_play(struct input_dev *d
 					ff_field->logical_minimum,
 					ff_field->logical_maximum);
=20
-		HID_DBG("(left,right)=3D(%08x, %08x)\n", left, right);
+		hid_dbg(hid, "(left,right)=3D(%08x, %08x)\n", left, right);
 		ff_field->value[0] =3D left;
 		ff_field->value[1] =3D right;
 		usbhid_submit_report(hid, tmff->report, USB_DIR_OUT);
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-zpff.c linux-2.6.38.2.new/drivers/hid/hid-zpff.c
--- linux-2.6.38.2/drivers/hid/hid-zpff.c	2011-03-29 16:58:21.664980586 +=
0200
+++ linux-2.6.38.2.new/drivers/hid/hid-zpff.c	2011-03-29 15:05:21.1417138=
58 +0200
@@ -50,14 +50,14 @@ static int zpff_play(struct input_dev *d
=20
 	left =3D effect->u.rumble.strong_magnitude;
 	right =3D effect->u.rumble.weak_magnitude;
-	HID_DBG("called with 0x%04x 0x%04x\n", left, right);
+	hid_dbg(hid, "called with 0x%04x 0x%04x\n", left, right);
=20
 	left =3D left * 0x7f / 0xffff;
 	right =3D right * 0x7f / 0xffff;
=20
 	zpff->report->field[2]->value[0] =3D left;
 	zpff->report->field[3]->value[0] =3D right;
-	HID_DBG("running with 0x%02x 0x%02x\n", left, right);
+	hid_dbg(hid, "running with 0x%02x 0x%02x\n", left, right);
 	usbhid_submit_report(hid, zpff->report, USB_DIR_OUT);
=20
 	return 0;
diff -uprN -X linux-2.6.38.2/Documentation/dontdiff linux-2.6.38.2/driver=
s/hid/hid-zydacron.c linux-2.6.38.2.new/drivers/hid/hid-zydacron.c
--- linux-2.6.38.2/drivers/hid/hid-zydacron.c	2011-03-29 16:58:21.6649805=
86 +0200
+++ linux-2.6.38.2.new/drivers/hid/hid-zydacron.c	2011-03-29 15:07:05.721=
147273 +0200
@@ -56,7 +56,7 @@ static int zc_input_mapping(struct hid_d
 	if ((usage->hid & HID_USAGE_PAGE) !=3D HID_UP_CONSUMER)
 		return 0;
=20
-	HID_DBG("zynacron input mapping event [0x%x]\n",
+	hid_dbg(hdev, "zynacron input mapping event [0x%x]\n",
 		usage->hid & HID_USAGE);
=20
 	switch (usage->hid & HID_USAGE) {
------=_20110329192211_81315--


