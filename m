From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: BUG: hid-multitouch causes 10 second delay and error
Date: Fri, 28 Oct 2011 15:19:06 +0200
Message-ID: <CAN+gG=EiJJR464q_eoJuJYpWOPMsk61W6sAKD18SdT+2tQfmQA@mail.gmail.com>
References: <20111026213705.GA32664@pequod.mess.org>
	<CAN+gG=E0sUd3WOzAuT1LOTz_U9jLrGg2Bq_jRjha8Dcptk6Zcw@mail.gmail.com>
	<4EA9466F.4000508@gmail.com>
	<20111028111605.GA23693@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53916 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932493Ab1J1NTI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Oct 2011 09:19:08 -0400
Received: by wyg36 with SMTP id 36so3874014wyg.19
        for <linux-input@vger.kernel.org>; Fri, 28 Oct 2011 06:19:07 -0700 (PDT)
In-Reply-To: <20111028111605.GA23693@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Sean Young <sean@mess.org>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>

Hi Henrik,

well, most of the comments you in-lined addressed the fact that I
tried to make the smallest patch possible.

On Fri, Oct 28, 2011 at 13:16, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> Hi Benjamin,
>
>> Hi Sean, can you test the following patch please:
>>
>>
>> From 488272baf9bc95718dba2b9a0f62fe3309ca578f Mon Sep 17 00:00:00 20=
01
>> From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
>> Date: Thu, 27 Oct 2011 13:36:05 +0200
>> Subject: [PATCH 1/2] hid-multitouch: fix interaction with other hid =
drivers
>
> I took this patch, fixed it up, applied it to jikos/multitouch, and
> did a "git diff HEAD~3" to see the actual changes applied so far for
> generic hid-mt support. That diff is quite small, so I would recommen=
d
> rewinding the tree once things settle down. I have commented on the
> diff below, and at the end there are three alternative (untested)
> patches, as a suggestion.
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 956f849..78253ae 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1212,6 +1212,11 @@ int hid_connect(struct hid_device *hdev, unsig=
ned int connect_mask)
> =A0 =A0 =A0 =A0if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput=
_connect(hdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0connec=
t_mask & HID_CONNECT_HIDINPUT_FORCE))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hdev->claimed |=3D HID_CLAIMED_INPUT;
> + =A0 =A0 =A0 if (hdev->quirks & HID_QUIRK_MULTITOUCH) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this device should be handled by hid=
-multitouch, skip it */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if ((connect_mask & HID_CONNECT_HIDDEV) && hdev->hidde=
v_connect &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!hdev->hiddev_connect(=
hdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0connec=
t_mask & HID_CONNECT_HIDDEV_FORCE))
>
> The regret here is that hid-core needs to know about hit-mt at
> all. What it needs to know is whether the device should be dropped.
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 6559e2e..f333139 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -474,6 +474,10 @@ static void hidinput_configure_usage(struct hid_=
input *hidinput, struct hid_fiel
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0map_key_clear(BTN_STYL=
US2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x51: /* ContactID */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device->quirks |=3D HID=
_QUIRK_MULTITOUCH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unknown;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default: =A0goto unknown;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> So in addition to the detection here,
>
> @@ -978,6 +982,13 @@ int hidinput_connect(struct hid_device *hid, uns=
igned int force)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (hid->quirks & HID_QUIRK_MULTITOUCH) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* generic hid does not know how to han=
dle multitouch devices */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hidinput)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_cleanup;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_unwind;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (hidinput && input_register_device(hidinput->input)=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_cleanup;
>
> One could instead drop handling based on a quirk designed for that
> purpose (HID_QUIRK_HIDINPUT_DROP).
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index f1c909f..28f8ff2 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -291,6 +291,7 @@ static int mt_input_mapping(struct hid_device *hd=
ev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_slot_field =3D=
 usage->hid;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_field_index =3D=
 field->index;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0td->last_mt_collection=
 =3D usage->collection_index;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 hdev->quirks &=3D ~HID_=
QUIRK_MULTITOUCH;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return 1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case HID_DG_WIDTH:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid_map_usage(hi, usag=
e, bit, max,
>
> Although correct per se, it is clearer to reset this flag in mt_probe=
().
>
> @@ -535,6 +536,12 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
> =A0 =A0 =A0 =A0struct mt_device *td;
> =A0 =A0 =A0 =A0struct mt_class *mtclass =3D mt_classes; /* MT_CLS_DEF=
AULT */
>
> + =A0 =A0 =A0 if (!id->driver_data && !(hdev->quirks & HID_QUIRK_MULT=
ITOUCH))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* cought by HID_USB_DEVICE(HID_ANY_ID,=
 HID_ANY_ID),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and either in hid_have_special_dri=
ver
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* or not detected as multitouch by h=
id-core */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> =A0 =A0 =A0 =A0for (i =3D 0; mt_classes[i].name ; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (id->driver_data =3D=3D mt_classes[=
i].name) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mtclass =3D &(mt_class=
es[i]);
>
> Very neat solution indeed!
>
> @@ -542,10 +549,6 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* This allows the driver to correctly support devices
> - =A0 =A0 =A0 =A0* that emit events over several HID messages.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 hdev->quirks |=3D HID_QUIRK_NO_INPUT_SYNC;
>
> =A0 =A0 =A0 =A0td =3D kzalloc(sizeof(struct mt_device), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!td) {
>
> It seems there is no longer any reason to move this line around, sinc=
e
> we now only come here when the device is really meant for this driver=
=2E
>
> @@ -561,10 +564,16 @@ static int mt_probe(struct hid_device *hdev, co=
nst struct hid_device_id *id)
> =A0 =A0 =A0 =A0if (ret !=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
>
> + =A0 =A0 =A0 hdev->quirks |=3D HID_QUIRK_MULTITOUCH;
>
> This is unnecessary and makes the logic blurred.
>
> =A0 =A0 =A0 =A0ret =3D hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto fail;
>
> + =A0 =A0 =A0 /* This allows the driver to correctly support devices
> + =A0 =A0 =A0 =A0* that emit events over several HID messages.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 hdev->quirks |=3D HID_QUIRK_NO_INPUT_SYNC;
> +
> =A0 =A0 =A0 =A0td->slots =3D kzalloc(td->maxcontacts * sizeof(struct =
mt_slot),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KE=
RNEL);
> =A0 =A0 =A0 =A0if (!td->slots) {
>
> In addition to not needing to be moved, this line introduces a race
> with hid-input, since the device has already started when this line i=
s
> executed.

Well, we should use instead the new input_register callback to avoid an=
y races.
I've got the patch, I've tested it, but I never sent it.... shame on me=
=2E

>
> @@ -758,6 +767,9 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_XAT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_XAT_CSR)=
 },
>
> + =A0 =A0 =A0 /* Rest of the world */
> + =A0 =A0 =A0 { HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID) },
> +
> =A0 =A0 =A0 =A0{ }
> =A0};
> =A0MODULE_DEVICE_TABLE(hid, mt_devices);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 9cf8e7a..6fb743d 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -312,6 +312,7 @@ struct hid_item {
> =A0#define HID_QUIRK_BADPAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x00000020
> =A0#define HID_QUIRK_MULTI_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x00000040
> =A0#define HID_QUIRK_HIDINPUT_FORCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00080
> +#define HID_QUIRK_MULTITOUCH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0000100
> =A0#define HID_QUIRK_SKIP_OUTPUT_REPORTS =A0 =A0 =A0 =A0 =A00x0001000=
0
> =A0#define HID_QUIRK_FULLSPEED_INTERVAL =A0 =A0 =A0 =A0 =A0 0x1000000=
0
> =A0#define HID_QUIRK_NO_INIT_REPORTS =A0 =A0 =A0 =A0 =A0 =A0 =A00x200=
00000
>
> As an alternative, here are three untested and uncommited patches
> which implements the comments above.
>

Except a comment in the second patch, I've tested it, and it worked
without any surprises ;-)

But I'm not sure we can rewind the tree as those patches are in
for-next since nearly a month.
I'll let you do the reverts, because on my local trees, it was quite
difficult (and I'm still on a 3.0.x, so I can not test against
for-next)


> --
>
> From defdac444919b99a932368ee1a8ad290dc724933 Mon Sep 17 00:00:00 200=
1
> From: Henrik Rydberg <rydberg@euromail.se>
> Date: Fri, 28 Oct 2011 11:36:36 +0200
> Subject: [PATCH 1/3] hid: Allow an input device to be dropped after p=
arsing
>
> Some devices need a special driver based on the input mapping of the
> device. This patch enables a mechanism where hidinput can set
> HID_QUIRK_HIDINPUT_DROP to leave a device to be picked up by a specia=
l
> driver which intercepts the input mapping.
> ---
> =A0drivers/hid/hid-core.c =A0| =A0 =A03 +++
> =A0drivers/hid/hid-input.c | =A0 =A06 ++++++
> =A0include/linux/hid.h =A0 =A0 | =A0 =A01 +
> =A03 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 956f849..2628f9c 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1212,6 +1212,9 @@ int hid_connect(struct hid_device *hdev, unsign=
ed int connect_mask)
> =A0 =A0 =A0 =A0if ((connect_mask & HID_CONNECT_HIDINPUT) && !hidinput=
_connect(hdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0connec=
t_mask & HID_CONNECT_HIDINPUT_FORCE))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hdev->claimed |=3D HID_CLAIMED_INPUT;
> + =A0 =A0 =A0 if (hdev->quirks & HID_QUIRK_HIDINPUT_DROP)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> =A0 =A0 =A0 =A0if ((connect_mask & HID_CONNECT_HIDDEV) && hdev->hidde=
v_connect &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0!hdev->hiddev_connect(=
hdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0connec=
t_mask & HID_CONNECT_HIDDEV_FORCE))
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 6559e2e..aa3ce2e 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -978,6 +978,12 @@ int hidinput_connect(struct hid_device *hid, uns=
igned int force)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (hid->quirks & HID_QUIRK_HIDINPUT_DROP) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (hidinput)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_cleanup;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out_unwind;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (hidinput && input_register_device(hidinput->input)=
)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_cleanup;
>
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 9cf8e7a..4028a27 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -312,6 +312,7 @@ struct hid_item {
> =A0#define HID_QUIRK_BADPAD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 0x00000020
> =A0#define HID_QUIRK_MULTI_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x00000040
> =A0#define HID_QUIRK_HIDINPUT_FORCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00080
> +#define HID_QUIRK_HIDINPUT_DROP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x00000100
> =A0#define HID_QUIRK_SKIP_OUTPUT_REPORTS =A0 =A0 =A0 =A0 =A00x0001000=
0
> =A0#define HID_QUIRK_FULLSPEED_INTERVAL =A0 =A0 =A0 =A0 =A0 0x1000000=
0
> =A0#define HID_QUIRK_NO_INIT_REPORTS =A0 =A0 =A0 =A0 =A0 =A0 =A00x200=
00000
> --
> 1.7.7
>
> From 5f4fe6ef4cab9721c6b277f57d5374d6b549359d Mon Sep 17 00:00:00 200=
1
> From: Henrik Rydberg <rydberg@euromail.se>
> Date: Fri, 28 Oct 2011 11:42:39 +0200
> Subject: [PATCH 2/3] hid-input: Drop generic handling of hid-mt multi=
touch
> =A0devices
>
> The hid-mt devices are recognized by the ContactID field. This patch
> sets HID_QUIRK_MULTITOUCH accordingly, and leaves the device to be
> picked up by any driver which intercepts the ContactID field.
>
> All in-tree hid-mt drivers intercept the ContactID, so this patch has
> no other effect than to skip generic handling of hid-mt devices.

Please add here the link to
http://www.microsoft.com/whdc/device/input/DigitizerDrvs_touch.mspx
to keep the origin of this statement: ContactID means multitouch

Cheers,
Benjamin

> ---
> =A0drivers/hid/hid-input.c | =A0 =A06 ++++++
> =A0include/linux/hid.h =A0 =A0 | =A0 =A01 +
> =A02 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index aa3ce2e..108830fc 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -474,6 +474,12 @@ static void hidinput_configure_usage(struct hid_=
input *hidinput, struct hid_fiel
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0map_key_clear(BTN_STYL=
US2);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x51: /* ContactID */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device->quirks |=3D HID=
_QUIRK_MULTITOUCH;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* hid-mt is not handle=
d by generic hid */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device->quirks |=3D HID=
_QUIRK_HIDINPUT_DROP;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unknown;
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default: =A0goto unknown;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 4028a27..b9c4296 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -313,6 +313,7 @@ struct hid_item {
> =A0#define HID_QUIRK_MULTI_INPUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x00000040
> =A0#define HID_QUIRK_HIDINPUT_FORCE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x000=
00080
> =A0#define HID_QUIRK_HIDINPUT_DROP =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A00x00000100
> +#define HID_QUIRK_MULTITOUCH =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x0=
0000200
> =A0#define HID_QUIRK_SKIP_OUTPUT_REPORTS =A0 =A0 =A0 =A0 =A00x0001000=
0
> =A0#define HID_QUIRK_FULLSPEED_INTERVAL =A0 =A0 =A0 =A0 =A0 0x1000000=
0
> =A0#define HID_QUIRK_NO_INIT_REPORTS =A0 =A0 =A0 =A0 =A0 =A0 =A00x200=
00000
> --
> 1.7.7
>
> From 6b1ecc88b3f5cca7c9178e3900c6766544db0798 Mon Sep 17 00:00:00 200=
1
> From: Henrik Rydberg <rydberg@euromail.se>
> Date: Fri, 28 Oct 2011 12:01:08 +0200
> Subject: [PATCH 3/3] hid-multitouch: Pick up all hid-mt devices
>
> This patch adds a catch-all device entry, which "undrops" all devices
> that have been identified as hid-mt by the hid core.
> ---
> =A0drivers/hid/hid-multitouch.c | =A0 12 ++++++++++++
> =A01 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index f1c909f..1f051eb 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -535,6 +535,15 @@ static int mt_probe(struct hid_device *hdev, con=
st struct hid_device_id *id)
> =A0 =A0 =A0 =A0struct mt_device *td;
> =A0 =A0 =A0 =A0struct mt_class *mtclass =3D mt_classes; /* MT_CLS_DEF=
AULT */
>
> + =A0 =A0 =A0 if (!id->driver_data && !(hdev->quirks & HID_QUIRK_MULT=
ITOUCH))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* cought by HID_USB_DEVICE(HID_ANY_ID,=
 HID_ANY_ID),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* and either in hid_have_special_dri=
ver
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* or not detected as multitouch by h=
id-core */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> +
> + =A0 =A0 =A0 /* pick up the device that was dropped by hid-core */
> + =A0 =A0 =A0 hdev->quirks &=3D ~HID_QUIRK_HIDINPUT_DROP;
> +
> =A0 =A0 =A0 =A0for (i =3D 0; mt_classes[i].name ; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (id->driver_data =3D=3D mt_classes[=
i].name) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mtclass =3D &(mt_class=
es[i]);
> @@ -758,6 +767,9 @@ static const struct hid_device_id mt_devices[] =3D=
 {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0HID_USB_DEVICE(USB_VENDOR_ID_XAT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0USB_DEVICE_ID_XAT_CSR)=
 },
>
> + =A0 =A0 =A0 /* Rest of the world */
> + =A0 =A0 =A0 { HID_USB_DEVICE(HID_ANY_ID, HID_ANY_ID) },
> +
> =A0 =A0 =A0 =A0{ }
> =A0};
> =A0MODULE_DEVICE_TABLE(hid, mt_devices);
> --
> 1.7.7
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
