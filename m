From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH] HID: wacom: Add reporting of wheel for Intuos4 WL
Date: Fri, 9 Mar 2012 16:40:19 -0600
Message-ID: <CAGzDe_Y=vcKrdqSpwudSwWJKPU4hnSboDA3j81gOY7BZnBax2w@mail.gmail.com>
References: <1331324862-15989-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:53970 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758397Ab2CIWkV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 9 Mar 2012 17:40:21 -0500
Received: by lahj13 with SMTP id j13so2170045lah.19
        for <linux-input@vger.kernel.org>; Fri, 09 Mar 2012 14:40:19 -0800 (PST)
In-Reply-To: <1331324862-15989-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: killertofu@gmail.com, pinglinux@gmail.com, jkosina@suse.cz, linuxwacom-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Mar 9, 2012 at 2:27 PM, Przemo Firszt <przemo@firszt.eu> wrote:
> This patch adds reporting of ABS_WHEEL event. Raported walues are 0..=
71
> and are related to absolute location of the finger on the wheel.
>
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> Reviewed-by: Jason Gerecke <killertofu@gmail.com>
> ---
> =A0drivers/hid/hid-wacom.c | =A0 25 +++++++++++++++++++++++++
> =A01 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index 5c25036..dab7588 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -36,6 +36,7 @@
> =A0struct wacom_data {
> =A0 =A0 =A0 =A0__u16 tool;
> =A0 =A0 =A0 =A0__u16 butstate;
> + =A0 =A0 =A0 __u8 whlstate;
> =A0 =A0 =A0 =A0__u8 features;
> =A0 =A0 =A0 =A0__u32 id;
> =A0 =A0 =A0 =A0__u32 serial;
> @@ -322,6 +323,23 @@ static void wacom_i4_parse_button_report(struct =
wacom_data *wdata,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct input_dev *inpu=
t, unsigned char *data)
> =A0{
> =A0 =A0 =A0 =A0__u16 new_butstate;
> + =A0 =A0 =A0 __u8 new_whlstate;
> + =A0 =A0 =A0 __u8 sync =3D 0;
> +
> + =A0 =A0 =A0 new_whlstate =3D data[1];
> + =A0 =A0 =A0 if (new_whlstate !=3D wdata->whlstate) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wdata->whlstate =3D new_whlstate;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (new_whlstate & 0x80) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_TOUCH, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_WHEEL, (new_whlstate & 0x7f));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_TOOL_FINGER, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_TOUCH, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input,=
 ABS_WHEEL, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_key(input,=
 BTN_TOOL_FINGER, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync =3D 1;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0new_butstate =3D (data[3] << 1) | (data[2] & 0x01);
> =A0 =A0 =A0 =A0if (new_butstate !=3D wdata->butstate) {
> @@ -336,6 +354,10 @@ static void wacom_i4_parse_button_report(struct =
wacom_data *wdata,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_key(input, BTN_7, new_but=
state & 0x080);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_key(input, BTN_8, new_but=
state & 0x100);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_key(input, BTN_TOOL_FINGE=
R, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sync =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (sync) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_MISC, PAD_=
DEVICE_ID);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_event(input, EV_MSC, MSC_SERIAL,=
 0xffffffff);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_sync(input);
> @@ -512,6 +534,9 @@ static int wacom_input_mapped(struct hid_device *=
hdev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(input, ABS_DISTAN=
CE, 0, 32, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(ABS_WHEEL, input->absbit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input, ABS_WHEEL, =
0, 71, 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_capability(input, EV_MSC, MSC=
_SERIAL);

Is this input_set_capability MSC_SERIAL line to fix the next line
thats above case statement?

         __set_bit(MSC_SERIAL, input->mscbit);

Should the original line be deleted/replaced?

Chris

> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(ABS_MISC, input->absbit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_2, input->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_3, input->keybit);
> --
> 1.7.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
