From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [Linuxwacom-devel] [PATCH 2/2] HID: wacom: Add reporting of wheel
 for Intuos4 WL
Date: Fri, 9 Mar 2012 09:37:06 -0800
Message-ID: <CANRwn3R5fFkujnsPhx++4PSQEwVNnWo_uXa9Zgb6m=SrJPtN0w@mail.gmail.com>
References: <1331299252-23699-1-git-send-email-przemo@firszt.eu>
	<1331299252-23699-2-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:47722 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932320Ab2CIRhI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Mar 2012 12:37:08 -0500
In-Reply-To: <1331299252-23699-2-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: jkosina@suse.cz, pinglinux@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net

On Fri, Mar 9, 2012 at 5:20 AM, Przemo Firszt <przemo@firszt.eu> wrote:
> This patch adds reporting of ABS_WHEEL event. Raported walues are 0..=
71
> and are related to absolute location of the finger on the wheel.
>
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> ---
> =C2=A0drivers/hid/hid-wacom.c | =C2=A0 19 +++++++++++++++++++
> =C2=A01 files changed, 19 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index 5c25036..6f65514 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -36,6 +36,7 @@
> =C2=A0struct wacom_data {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__u16 tool;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__u16 butstate;
> + =C2=A0 =C2=A0 =C2=A0 __u8 whlstate;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__u8 features;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 id;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 serial;
> @@ -322,6 +323,16 @@ static void wacom_i4_parse_button_report(struct =
wacom_data *wdata,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct input_dev *input, unsigned char *data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__u16 new_butstate;
> + =C2=A0 =C2=A0 =C2=A0 __u8 new_whlstate;
> + =C2=A0 =C2=A0 =C2=A0 __u8 sync =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 new_whlstate =3D data[1] & 0x7f;
> + =C2=A0 =C2=A0 =C2=A0 if (new_whlstate !=3D wdata->whlstate) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wdata->whlstate =3D=
 new_whlstate;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(i=
nput, BTN_TOUCH, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_abs(i=
nput, ABS_WHEEL, new_whlstate);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sync =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 }
>
The highest bit of data[1] is a "touched" flag that you'll want to
check to determine if the wheel is being used. If its unset, you'll
want to reset ABS_WHEEL and BTN_TOUCH to zero here.

> =C2=A0 =C2=A0 =C2=A0 =C2=A0new_butstate =3D (data[3] << 1) | (data[2]=
 & 0x01);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (new_butstate !=3D wdata->butstate) {
> @@ -335,6 +346,10 @@ static void wacom_i4_parse_button_report(struct =
wacom_data *wdata,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(input, BTN_6, new_butstate & 0x040);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(input, BTN_7, new_butstate & 0x080);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(input, BTN_8, new_butstate & 0x100);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sync =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (sync) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(input, BTN_TOOL_FINGER, 1);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_a=
bs(input, ABS_MISC, PAD_DEVICE_ID);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_event(in=
put, EV_MSC, MSC_SERIAL, 0xffffffff);
> @@ -354,6 +369,7 @@ static void wacom_i4_parse_pen_report(struct waco=
m_data *wdata,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_a=
bs(input, ABS_PRESSURE, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(input, BTN_STYLUS, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(input, BTN_STYLUS2, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_abs(i=
nput, ABS_WHEEL, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(input, wdata->tool, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_a=
bs(input, ABS_MISC, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_event(in=
put, EV_MSC, MSC_SERIAL, wdata->serial);
As mentioned above, this should be in wacom_i4_parse_button_report.
The pen's loss of proximity has no bearing on the wheel's state.

> @@ -512,6 +528,9 @@ static int wacom_input_mapped(struct hid_device *=
hdev, struct hid_input *hi,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_set_abs_=
params(input, ABS_DISTANCE, 0, 32, 0, 0);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH=
:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __set_bit(ABS_WHEE=
L, input->absbit);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_set_abs_para=
ms(input, ABS_WHEEL, 0, 71, 0, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_set_capabili=
ty(input, EV_MSC, MSC_SERIAL);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__set_bit(ABS_=
MISC, input->absbit);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__set_bit(BTN_=
2, input->keybit);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__set_bit(BTN_=
3, input->keybit);
> --
> 1.7.6.4
>
>
> ---------------------------------------------------------------------=
---------
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Linuxwacom-devel mailing list
> Linuxwacom-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linuxwacom-devel

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
