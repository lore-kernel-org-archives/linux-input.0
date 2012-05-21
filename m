From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/5] HID: hid-multitouch: fix wrong protocol detection
Date: Mon, 21 May 2012 18:43:29 +0200
Message-ID: <CAN+gG=G4+Jbcw_KBeV=tVsXaqG--acioA9y2x4YgUsVrmcEwfw@mail.gmail.com>
References: <1336136030-18503-1-git-send-email-benjamin.tissoires@gmail.com>
	<1336136030-18503-2-git-send-email-benjamin.tissoires@gmail.com>
	<20120506190146.GA12571@polaris.bitmath.org>
	<CAN+gG=G9y_0Le-Mja2z68r76nBmz0De95Lc6671EkrrMZRSEHw@mail.gmail.com>
	<6008DE3C35C7C04D85C2A4C813D36515481E5D29@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gh0-f174.google.com ([209.85.160.174]:61323 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826Ab2EUQna convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 May 2012 12:43:30 -0400
In-Reply-To: <6008DE3C35C7C04D85C2A4C813D36515481E5D29@ORSMSX101.amr.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Drews, Paul" <paul.drews@intel.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@enac.fr>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Paul,

On Fri, May 18, 2012 at 11:14 PM, Drews, Paul <paul.drews@intel.com> wr=
ote:
>
>
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-
>> owner@vger.kernel.org] On Behalf Of Benjamin Tissoires
>> Sent: Wednesday, May 09, 2012 12:04 PM
>> To: Henrik Rydberg
>> Cc: Dmitry Torokhov; Jiri Kosina; Stephane Chatty; linux-input@vger.=
kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 1/5] HID: hid-multitouch: fix wrong protocol det=
ection
>>
>
>> On Sun, May 6, 2012 at 9:01 PM, Henrik Rydberg <rydberg@euromail.se>=
 wrote:
>> > Hi Benjamin,
>> >
>> >> The previous implementation introduced a randomness in the splitt=
ing
>> >> of the different touches reported by the device. This version is =
more
>> >> robust as we don't rely on hi->input->absbit, but on our own stru=
cture.
>> >>
>
>> >> +
>> >> =A0struct mt_device {
>> >> =A0 =A0 =A0 struct mt_slot curdata; /* placeholder of incoming da=
ta */
>> >> =A0 =A0 =A0 struct mt_class mtclass; =A0 =A0 =A0 =A0/* our mt dev=
ice class */
>> >> + =A0 =A0 struct mt_fields *fields; =A0 =A0 =A0 /* temporary plac=
eholder for storing the
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0multitouch fields */
>> >
>> > Why not skip the pointer here?
>>
>> well, the idea was to keep the memory footprint low. As these values
>> are only needed at init, then I freed them once I finished using the=
m.
>> I can of course skip the pointer, but in that case, wouldn't the
>> struct declaration be worthless?
>>
>> >
>
>> >>
>> >> +static void mt_post_parse(struct mt_device *td)
>> >> +{
>> >> + =A0 =A0 struct mt_fields *f =3D td->fields;
>> >> +
>> >> + =A0 =A0 if (td->touches_by_report > 0) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 int field_count_per_touch =3D f->length=
 / td->touches_by_report;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D f->usages[field=
_count_per_touch - 1]->hid;
>> >> + =A0 =A0 }
>> >> +}
>> >> +
>
> It sounds as though:
>
> () Reviewers are a little uncomfortable with the memory footprint and
> =A0 =A0allocation/free
> () The patch as it stands relies on the pattern of "usage" values rep=
eating
> =A0 =A0for each touch, and deeming the last one in the repetition pat=
tern to
> =A0 =A0be the last-slot-field marker.
>
> If this is the case, how about avoiding storing all the slot-field va=
lues
> and just detecting the point of repetition to use the most-recently-s=
een
> usage value as the last-slot-field marker. =A0I have been successfull=
y using
> the patch below based on this notion. =A0It took the failure rate fro=
m about
> 1-per-10 boots to 250+ boots with no failures on an Atmel MaXTouch.
> I don't have others to try it with, including the "buggy" one that le=
d
> to all this trouble in the first place.

Thank you very much for this patch. However, Jiri already applied mine
with the allocation/free mechanism.

You're idea is good but it has one big problem with Win8 devices:
As we can have 2 X and 2 Y per touch report, if these dual-X reporting
or dual-Y reporting is present in the report, we will stop at the
second X or the second Y seen, which will lead to a buggy touchscreen
(the first touch won't get it's second coordinate). However, without
this particularity, the patch would have worked ;-)

If the Win8 norm has came earlier, the initial implementation that
relies on the collection would have suffice, but some hardware makers
made a bad use of it, leading us to stop using this, and relying on a
more brutal approach.

I found a little problem in the patch too:

>
> Patch follows:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> From 242f6773babe0fc0215764abbeeeff6510f3ca92 Mon Sep 17 00:00:00 200=
1
> From: Paul Drews <paul.drews@intel.com>
> Date: Wed, 16 May 2012 11:15:00 -0700
> Subject: [PATCH] Repair detection of last slot in multitouch reports
>
> The logic for detecting the last per-touch slot in a
> multitouch report erroneously used hid usage values (large
> numbers such as 0xd0032) as indices into the smaller absbit
> bitmap (with bit indexes up to 0x3f). =A0This caused
> intermittent failures in the configuration of the last-slot
> value leading to stale x,y coordinates being reported in
> multi-touch input events. =A0It also carried the risk of a
> segmentation fault due to the out-of-range bitmap index.
>
> This patch takes a different approach of detecting the last
> per-touch slot: =A0when the hid usage value wraps around to
> the first hid usage value we have seen already, we must be
> looking at the slots for the next touch of a multi-touch
> report, so the last hid usage value we have seen so far must
> be the last per-touch value.
>
> Issue: AIA-446
> Change-Id: Ic1872998502874298bb60705df9bd2fc70de1738
> Signed-off-by: Paul Drews <paul.drews@intel.com>
> ---
> =A0drivers/hid/hid-multitouch.c | =A0 39 ++++++++++++++++++++++++++--=
-----------
> =A01 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 2e6d187..226f828 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -75,6 +75,9 @@ struct mt_device {
> =A0 =A0 =A0 =A0struct mt_class mtclass; =A0 =A0 =A0 =A0/* our mt devi=
ce class */
> =A0 =A0 =A0 =A0unsigned last_field_index; =A0 =A0 =A0/* last field in=
dex of the report */
> =A0 =A0 =A0 =A0unsigned last_slot_field; =A0 =A0 =A0 /* the last fiel=
d of a slot */
> + =A0 =A0 =A0 bool last_slot_field_found; =A0 =A0 /* last_slot_field =
has full init */
> + =A0 =A0 =A0 unsigned first_slot_field;
> + =A0 =A0 =A0 bool first_slot_field_found; =A0 =A0/* for detecting wr=
ap to next touch */
> =A0 =A0 =A0 =A0__s8 inputmode; =A0 =A0 =A0 =A0 /* InputMode HID featu=
re, -1 if non-existent */
> =A0 =A0 =A0 =A0__s8 maxcontact_report_id; =A0 =A0 =A0/* Maximum Conta=
ct Number HID feature,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -=
1 if non-existent */
> @@ -275,11 +278,21 @@ static void set_abs(struct input_dev *input, un=
signed int code,
> =A0 =A0 =A0 =A0input_set_abs_params(input, code, fmin, fmax, fuzz, 0)=
;
> =A0}
>
> -static void set_last_slot_field(struct hid_usage *usage, struct mt_d=
evice *td,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_input *hi)
> +static void update_last_slot_field(struct hid_usage *usage,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mt_device *td)
> =A0{
> - =A0 =A0 =A0 if (!test_bit(usage->hid, hi->input->absbit))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D usage->hid;
> + =A0 =A0 =A0 if (!td->last_slot_field_found) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (td->first_slot_field_found) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (td->last_slot_field=
 =3D=3D usage->hid)

I'm sure you wanted to put here:
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (td->first_slot_field =3D=
=3D usage->hid)

Cheers,
Benjamin

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->las=
t_slot_field_found =3D true; /* wrapped */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->las=
t_slot_field =3D usage->hid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->first_slot_field =3D=
 usage->hid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->first_slot_field_fo=
und =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D=
 usage->hid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static int mt_input_mapping(struct hid_device *hdev, struct hid_in=
put *hi,
> @@ -340,7 +353,7 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cls->s=
n_move);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* touchscreen emulati=
on */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_abs(hi->input, ABS=
_X, field, cls->sn_move);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usa=
ge, td, hi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_last_slot_field(=
usage, td);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_field_index =3D=
 field->index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_GD_Y:
> @@ -350,7 +363,7 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cls->s=
n_move);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* touchscreen emulati=
on */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_abs(hi->input, ABS=
_Y, field, cls->sn_move);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usa=
ge, td, hi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_last_slot_field(=
usage, td);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_field_index =3D=
 field->index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -359,24 +372,24 @@ static int mt_input_mapping(struct hid_device *=
hdev, struct hid_input *hi,
> =A0 =A0 =A0 =A0case HID_UP_DIGITIZER:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0switch (usage->hid) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_INRANGE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usa=
ge, td, hi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_last_slot_field(=
usage, td);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_field_index =3D=
 field->index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_CONFIDENCE:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usa=
ge, td, hi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_last_slot_field(=
usage, td);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_field_index =3D=
 field->index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_TIPSWITCH:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_map_usage(hi, usag=
e, bit, max, EV_KEY, BTN_TOUCH);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_capability(h=
i->input, EV_KEY, BTN_TOUCH);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usa=
ge, td, hi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_last_slot_field(=
usage, td);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_field_index =3D=
 field->index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_CONTACTID:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!td->maxcontacts)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->ma=
xcontacts =3D MT_DEFAULT_MAXCONTACT;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_mt_init_slots(hi=
->input, td->maxcontacts);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 td->last_slot_field =3D=
 usage->hid;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_last_slot_field(=
usage, td);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_field_index =3D=
 field->index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->touches_by_report+=
+;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> @@ -385,7 +398,7 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0EV_ABS, ABS_MT_TOUCH_MAJOR);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_abs(hi->input, ABS=
_MT_TOUCH_MAJOR, field,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cls->s=
n_width);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usa=
ge, td, hi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_last_slot_field(=
usage, td);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_field_index =3D=
 field->index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_HEIGHT:
> @@ -395,7 +408,7 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cls->s=
n_height);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(h=
i->input,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0ABS_MT_ORIENTATION, 0, 1, 0, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usa=
ge, td, hi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_last_slot_field(=
usage, td);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_field_index =3D=
 field->index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_TIPPRESSURE:
> @@ -406,7 +419,7 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* touchscreen emulati=
on */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_abs(hi->input, ABS=
_PRESSURE, field,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cls->s=
n_pressure);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_last_slot_field(usa=
ge, td, hi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 update_last_slot_field(=
usage, td);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_field_index =3D=
 field->index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_CONTACTCOUNT:
> --
> 1.7.3.4
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
