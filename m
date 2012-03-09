From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH] HID: wacom: Add reporting of wheel for Intuos4 WL
Date: Fri, 9 Mar 2012 11:36:06 -0800
Message-ID: <CANRwn3RpQcfBxT+JR=bcOmnzuVD+F3q3sVwj5csNLz5s0dXFdQ@mail.gmail.com>
References: <1331317000-9036-1-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38243 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754662Ab2CITgI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Mar 2012 14:36:08 -0500
In-Reply-To: <1331317000-9036-1-git-send-email-przemo@firszt.eu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: jkosina@suse.cz, pinglinux@gmail.com, linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Mar 9, 2012 at 10:16 AM, Przemo Firszt <przemo@firszt.eu> wrote=
:
> This patch adds reporting of ABS_WHEEL event. Raported walues are 0..=
71
> and are related to absolute location of the finger on the wheel.
>
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> ---
> =C2=A0drivers/hid/hid-wacom.c | =C2=A0 25 +++++++++++++++++++++++++
> =C2=A01 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index 5c25036..925d4a7 100644
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
> @@ -322,6 +323,23 @@ static void wacom_i4_parse_button_report(struct =
wacom_data *wdata,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct input_dev *input, unsigned char *data)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0__u16 new_butstate;
> + =C2=A0 =C2=A0 =C2=A0 __u8 new_whlstate;
> + =C2=A0 =C2=A0 =C2=A0 __u8 sync =3D 0;
> +
> + =C2=A0 =C2=A0 =C2=A0 new_whlstate =3D data[1];
> + =C2=A0 =C2=A0 =C2=A0 if (new_whlstate !=3D wdata->whlstate) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 wdata->whlstate =3D=
 new_whlstate;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (new_whlstate &=
 0x10) {
Should be 0x80 to get the highest bit. Aside from that issue though:

Reviewed-by: Jason Gerecke <killertofu@gmail.com>

Jason

---
Day xee-nee-svsh duu-'ushtlh-ts'it;
nuu-wee-ya' duu-xan' 'vm-nvshtlh-ts'it.
Huu-chan xuu naa~-gha.

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 input_report_key(input, BTN_TOUCH, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 input_report_abs(input, ABS_WHEEL, (new_whlstate & 0x7f));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 input_report_key(input, BTN_TOOL_FINGER, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 input_report_key(input, BTN_TOUCH, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 input_report_abs(input, ABS_WHEEL, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 input_report_key(input, BTN_TOOL_FINGER, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sync =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 }
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0new_butstate =3D (data[3] << 1) | (data[2]=
 & 0x01);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (new_butstate !=3D wdata->butstate) {
> @@ -336,6 +354,10 @@ static void wacom_i4_parse_button_report(struct =
wacom_data *wdata,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(input, BTN_7, new_butstate & 0x080);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(input, BTN_8, new_butstate & 0x100);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_k=
ey(input, BTN_TOOL_FINGER, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sync =3D 1;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 if (sync) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_report_a=
bs(input, ABS_MISC, PAD_DEVICE_ID);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_event(in=
put, EV_MSC, MSC_SERIAL, 0xffffffff);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_sync(inp=
ut);
> @@ -512,6 +534,9 @@ static int wacom_input_mapped(struct hid_device *=
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
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
