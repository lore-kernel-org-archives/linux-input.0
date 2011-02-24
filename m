From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: Re: [PATCH] hid: Do not create input devices for feature reports
Date: Thu, 24 Feb 2011 20:50:55 +0100
Message-ID: <AANLkTi=VfSbbV5xwpacC+8yDUfjR3-S8OW47YPvtZwFX@mail.gmail.com>
References: <1298572259-18173-1-git-send-email-rydberg@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:55233 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755533Ab1BXTu7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Feb 2011 14:50:59 -0500
In-Reply-To: <1298572259-18173-1-git-send-email-rydberg@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?ISO-8859-1?Q?St=E9phane_Chatty?= <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Henrik,

Thanks for spotting this. BTW, I'm not happy with your solution.

You are sending the feature report before creating the struct
hid_input. To be consistent with the rest, we have to keep the same
signature. Today, the code does not make any use of it. But I use it
in my devel branch to auto-detect the maximum contact count of the
device. This was the safest place to call input_mt_init_slots.

How about adding hidinput as an argument to report_features

and calling it after the " for (k =3D HID_INPUT_REPORT; k <=3D
HID_OUTPUT_REPORT; k++) {" loop with

list_for_each_entry_safe(hidinput, next, &hid->inputs, list)
    report_features(hid, hidinput);

I did not even try to compile it right now (I don't have any
multitouch device right now) but I'll be able to make further tests
tomorrow.

Cheers,
Benjamin


On Thu, Feb 24, 2011 at 19:30, Henrik Rydberg <rydberg@euromail.se> wro=
te:
> When the multi input quirk is set, there is a new input device
> created for every feature report. Since the idea is to present
> features per hid device, not per input device, revert back to
> the original report loop and change the feature_mapping() callback
> to not take the input device as argument.
>
> Signed-off-by: Henrik Rydberg <rydberg@euromail.se>
> ---
> Hi Jiri, Benjamin,
>
> It seems the feature report callback was a bit intrusive, after all;
> for some devices such as ntrig, with multi input, there are additiona=
l
> input devices created. The following patch seems to fix the problem,
> but it has not been tested on any device using the hid-multitouch
> driver.
>
> Thanks,
> Henrik
>
> =A0drivers/hid/hid-input.c =A0 =A0 =A0| =A0 30 +++++++++++++++++++++-=
--------
> =A0drivers/hid/hid-multitouch.c | =A0 =A02 +-
> =A0include/linux/hid.h =A0 =A0 =A0 =A0 =A0| =A0 =A02 +-
> =A03 files changed, 23 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 7f552bf..ebcc02a 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -290,14 +290,6 @@ static void hidinput_configure_usage(struct hid_=
input *hidinput, struct hid_fiel
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto ignore;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (field->report_type =3D=3D HID_FEATURE_REPORT) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (device->driver->feature_mapping) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device->driver->feature=
_mapping(device, hidinput, field,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 usage);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto ignore;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0if (device->driver->input_mapping) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int ret =3D device->driver->input_mapp=
ing(device, hidinput, field,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0usage,=
 &bit, &max);
> @@ -835,6 +827,24 @@ static void hidinput_close(struct input_dev *dev=
)
> =A0 =A0 =A0 =A0hid_hw_close(hid);
> =A0}
>
> +static void report_features(struct hid_device *hid)
> +{
> + =A0 =A0 =A0 struct hid_driver *drv =3D hid->driver;
> + =A0 =A0 =A0 struct hid_report_enum *rep_enum;
> + =A0 =A0 =A0 struct hid_report *rep;
> + =A0 =A0 =A0 int i, j;
> +
> + =A0 =A0 =A0 if (!drv->feature_mapping)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 rep_enum =3D &hid->report_enum[HID_FEATURE_REPORT];
> + =A0 =A0 =A0 list_for_each_entry(rep, &rep_enum->report_list, list)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < rep->maxfield; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (j =3D 0; j < rep->=
field[i]->maxusage; j++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv->fe=
ature_mapping(hid, rep->field[i],
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rep->field[i]->usage + j);
> +}
> +
> =A0/*
> =A0* Register the input device; print a message.
> =A0* Configure the input layer interface
> @@ -863,7 +873,9 @@ int hidinput_connect(struct hid_device *hid, unsi=
gned int force)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 for (k =3D HID_INPUT_REPORT; k <=3D HID_FEATURE_REPORT;=
 k++) {
> + =A0 =A0 =A0 report_features(hid);
> +
> + =A0 =A0 =A0 for (k =3D HID_INPUT_REPORT; k <=3D HID_OUTPUT_REPORT; =
k++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (k =3D=3D HID_OUTPUT_REPORT &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0hid->quirks & HID_QUIR=
K_SKIP_OUTPUT_REPORTS)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouc=
h.c
> index 07d3183..2bbc954 100644
> --- a/drivers/hid/hid-multitouch.c
> +++ b/drivers/hid/hid-multitouch.c
> @@ -122,7 +122,7 @@ struct mt_class mt_classes[] =3D {
> =A0 =A0 =A0 =A0{ }
> =A0};
>
> -static void mt_feature_mapping(struct hid_device *hdev, struct hid_i=
nput *hi,
> +static void mt_feature_mapping(struct hid_device *hdev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct hid_field *field, struct hid_us=
age *usage)
> =A0{
> =A0 =A0 =A0 =A0if (usage->hid =3D=3D HID_DG_INPUTMODE) {
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index d91c25e..fc5faf6 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -638,7 +638,7 @@ struct hid_driver {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct hid_input *hidi=
nput, struct hid_field *field,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct hid_usage *usag=
e, unsigned long **bit, int *max);
> =A0 =A0 =A0 =A0void (*feature_mapping)(struct hid_device *hdev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_input *hidin=
put, struct hid_field *field,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct hid_field *field=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct hid_usage *usag=
e);
> =A0#ifdef CONFIG_PM
> =A0 =A0 =A0 =A0int (*suspend)(struct hid_device *hdev, pm_message_t m=
essage);
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
