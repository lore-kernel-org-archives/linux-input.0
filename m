From: "Drews, Paul" <paul.drews@intel.com>
Subject: RE: [PATCH 1/5] HID: hid-multitouch: fix wrong protocol detection
Date: Fri, 18 May 2012 21:14:08 +0000
Message-ID: <6008DE3C35C7C04D85C2A4C813D36515481E5D29@ORSMSX101.amr.corp.intel.com>
References: <1336136030-18503-1-git-send-email-benjamin.tissoires@gmail.com>
 <1336136030-18503-2-git-send-email-benjamin.tissoires@gmail.com>
 <20120506190146.GA12571@polaris.bitmath.org>
 <CAN+gG=G9y_0Le-Mja2z68r76nBmz0De95Lc6671EkrrMZRSEHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAN+gG=G9y_0Le-Mja2z68r76nBmz0De95Lc6671EkrrMZRSEHw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
> owner@vger.kernel.org] On Behalf Of Benjamin Tissoires
> Sent: Wednesday, May 09, 2012 12:04 PM
> To: Henrik Rydberg
> Cc: Dmitry Torokhov; Jiri Kosina; Stephane Chatty; linux-input@vger.k=
ernel.org;
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 1/5] HID: hid-multitouch: fix wrong protocol dete=
ction
>=20

> On Sun, May 6, 2012 at 9:01 PM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
> > Hi Benjamin,
> >
> >> The previous implementation introduced a randomness in the splitti=
ng
> >> of the different touches reported by the device. This version is m=
ore
> >> robust as we don't rely on hi->input->absbit, but on our own struc=
ture.
> >>

> >> +
> >> =A0struct mt_device {
> >> =A0 =A0 =A0 struct mt_slot curdata; /* placeholder of incoming dat=
a */
> >> =A0 =A0 =A0 struct mt_class mtclass; =A0 =A0 =A0 =A0/* our mt devi=
ce class */
> >> + =A0 =A0 struct mt_fields *fields; =A0 =A0 =A0 /* temporary place=
holder for storing the
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0multitouch fields */
> >
> > Why not skip the pointer here?
>=20
> well, the idea was to keep the memory footprint low. As these values
> are only needed at init, then I freed them once I finished using them=
=2E
> I can of course skip the pointer, but in that case, wouldn't the
> struct declaration be worthless?
>=20
> >

> >>
> >> +static void mt_post_parse(struct mt_device *td)
> >> +{
> >> + =A0 =A0 struct mt_fields *f =3D td->fields;
> >> +
> >> + =A0 =A0 if (td->touches_by_report > 0) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 int field_count_per_touch =3D f->length =
/ td->touches_by_report;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D f->usages[field_=
count_per_touch - 1]->hid;
> >> + =A0 =A0 }
> >> +}
> >> +

It sounds as though:

() Reviewers are a little uncomfortable with the memory footprint and
    allocation/free
() The patch as it stands relies on the pattern of "usage" values repea=
ting
    for each touch, and deeming the last one in the repetition pattern =
to
    be the last-slot-field marker.

If this is the case, how about avoiding storing all the slot-field valu=
es
and just detecting the point of repetition to use the most-recently-see=
n
usage value as the last-slot-field marker.  I have been successfully us=
ing
the patch below based on this notion.  It took the failure rate from ab=
out
1-per-10 boots to 250+ boots with no failures on an Atmel MaXTouch.
I don't have others to try it with, including the "buggy" one that led
to all this trouble in the first place.

Patch follows:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=46rom 242f6773babe0fc0215764abbeeeff6510f3ca92 Mon Sep 17 00:00:00 200=
1
=46rom: Paul Drews <paul.drews@intel.com>
Date: Wed, 16 May 2012 11:15:00 -0700
Subject: [PATCH] Repair detection of last slot in multitouch reports

The logic for detecting the last per-touch slot in a
multitouch report erroneously used hid usage values (large
numbers such as 0xd0032) as indices into the smaller absbit
bitmap (with bit indexes up to 0x3f).  This caused
intermittent failures in the configuration of the last-slot
value leading to stale x,y coordinates being reported in
multi-touch input events.  It also carried the risk of a
segmentation fault due to the out-of-range bitmap index.

This patch takes a different approach of detecting the last
per-touch slot:  when the hid usage value wraps around to
the first hid usage value we have seen already, we must be
looking at the slots for the next touch of a multi-touch
report, so the last hid usage value we have seen so far must
be the last per-touch value.

Issue: AIA-446
Change-Id: Ic1872998502874298bb60705df9bd2fc70de1738
Signed-off-by: Paul Drews <paul.drews@intel.com>
---
 drivers/hid/hid-multitouch.c |   39 ++++++++++++++++++++++++++--------=
-----
 1 files changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.=
c
index 2e6d187..226f828 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -75,6 +75,9 @@ struct mt_device {
 	struct mt_class mtclass;	/* our mt device class */
 	unsigned last_field_index;	/* last field index of the report */
 	unsigned last_slot_field;	/* the last field of a slot */
+	bool last_slot_field_found;	/* last_slot_field has full init */
+	unsigned first_slot_field;
+	bool first_slot_field_found;	/* for detecting wrap to next touch */
 	__s8 inputmode;		/* InputMode HID feature, -1 if non-existent */
 	__s8 maxcontact_report_id;	/* Maximum Contact Number HID feature,
 				   -1 if non-existent */
@@ -275,11 +278,21 @@ static void set_abs(struct input_dev *input, unsi=
gned int code,
 	input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
 }
=20
-static void set_last_slot_field(struct hid_usage *usage, struct mt_dev=
ice *td,
-		struct hid_input *hi)
+static void update_last_slot_field(struct hid_usage *usage,
+		struct mt_device *td)
 {
-	if (!test_bit(usage->hid, hi->input->absbit))
-		td->last_slot_field =3D usage->hid;
+	if (!td->last_slot_field_found) {
+		if (td->first_slot_field_found) {
+			if (td->last_slot_field =3D=3D usage->hid)
+				td->last_slot_field_found =3D true; /* wrapped */
+			else
+				td->last_slot_field =3D usage->hid;
+		} else {
+			td->first_slot_field =3D usage->hid;
+			td->first_slot_field_found =3D true;
+			td->last_slot_field =3D usage->hid;
+		}
+	}
 }
=20
 static int mt_input_mapping(struct hid_device *hdev, struct hid_input =
*hi,
@@ -340,7 +353,7 @@ static int mt_input_mapping(struct hid_device *hdev=
, struct hid_input *hi,
 				cls->sn_move);
 			/* touchscreen emulation */
 			set_abs(hi->input, ABS_X, field, cls->sn_move);
-			set_last_slot_field(usage, td, hi);
+			update_last_slot_field(usage, td);
 			td->last_field_index =3D field->index;
 			return 1;
 		case HID_GD_Y:
@@ -350,7 +363,7 @@ static int mt_input_mapping(struct hid_device *hdev=
, struct hid_input *hi,
 				cls->sn_move);
 			/* touchscreen emulation */
 			set_abs(hi->input, ABS_Y, field, cls->sn_move);
-			set_last_slot_field(usage, td, hi);
+			update_last_slot_field(usage, td);
 			td->last_field_index =3D field->index;
 			return 1;
 		}
@@ -359,24 +372,24 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
 	case HID_UP_DIGITIZER:
 		switch (usage->hid) {
 		case HID_DG_INRANGE:
-			set_last_slot_field(usage, td, hi);
+			update_last_slot_field(usage, td);
 			td->last_field_index =3D field->index;
 			return 1;
 		case HID_DG_CONFIDENCE:
-			set_last_slot_field(usage, td, hi);
+			update_last_slot_field(usage, td);
 			td->last_field_index =3D field->index;
 			return 1;
 		case HID_DG_TIPSWITCH:
 			hid_map_usage(hi, usage, bit, max, EV_KEY, BTN_TOUCH);
 			input_set_capability(hi->input, EV_KEY, BTN_TOUCH);
-			set_last_slot_field(usage, td, hi);
+			update_last_slot_field(usage, td);
 			td->last_field_index =3D field->index;
 			return 1;
 		case HID_DG_CONTACTID:
 			if (!td->maxcontacts)
 				td->maxcontacts =3D MT_DEFAULT_MAXCONTACT;
 			input_mt_init_slots(hi->input, td->maxcontacts);
-			td->last_slot_field =3D usage->hid;
+			update_last_slot_field(usage, td);
 			td->last_field_index =3D field->index;
 			td->touches_by_report++;
 			return 1;
@@ -385,7 +398,7 @@ static int mt_input_mapping(struct hid_device *hdev=
, struct hid_input *hi,
 					EV_ABS, ABS_MT_TOUCH_MAJOR);
 			set_abs(hi->input, ABS_MT_TOUCH_MAJOR, field,
 				cls->sn_width);
-			set_last_slot_field(usage, td, hi);
+			update_last_slot_field(usage, td);
 			td->last_field_index =3D field->index;
 			return 1;
 		case HID_DG_HEIGHT:
@@ -395,7 +408,7 @@ static int mt_input_mapping(struct hid_device *hdev=
, struct hid_input *hi,
 				cls->sn_height);
 			input_set_abs_params(hi->input,
 					ABS_MT_ORIENTATION, 0, 1, 0, 0);
-			set_last_slot_field(usage, td, hi);
+			update_last_slot_field(usage, td);
 			td->last_field_index =3D field->index;
 			return 1;
 		case HID_DG_TIPPRESSURE:
@@ -406,7 +419,7 @@ static int mt_input_mapping(struct hid_device *hdev=
, struct hid_input *hi,
 			/* touchscreen emulation */
 			set_abs(hi->input, ABS_PRESSURE, field,
 				cls->sn_pressure);
-			set_last_slot_field(usage, td, hi);
+			update_last_slot_field(usage, td);
 			td->last_field_index =3D field->index;
 			return 1;
 		case HID_DG_CONTACTCOUNT:
--=20
1.7.3.4
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
