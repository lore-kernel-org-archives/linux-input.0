From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 2/2] HID: wacom: Add reporting of wheel for Intuos4 WL
Date: Thu, 15 Mar 2012 19:09:55 -0500
Message-ID: <CAGzDe_Y99tQhW_0oUwQGqwkTJM8gwZ5Ckxph0XEDztbMgJS-mQ@mail.gmail.com>
References: <1331754904-8927-1-git-send-email-przemo@firszt.eu>
	<1331754904-8927-2-git-send-email-przemo@firszt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331754904-8927-2-git-send-email-przemo@firszt.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Przemo Firszt <przemo@firszt.eu>
Cc: jkosina@suse.cz, pinglinux@gmail.com, killertofu@gmail.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linuxwacom-devel@lists.sourceforge.net
List-Id: linux-input@vger.kernel.org

=46or both patches:

Reviewed-by: Chris Bagwell <chris@cnpbagwell.com>

On Wed, Mar 14, 2012 at 2:55 PM, Przemo Firszt <przemo@firszt.eu> wrote=
:
> This patch adds reporting of ABS_WHEEL event. Raported walues are 0..=
71
> and are related to absolute location of the finger on the wheel.
>
> Signed-off-by: Przemo Firszt <przemo@firszt.eu>
> Reviewed-by: Jason Gerecke <killertofu@gmail.com>
> ---
> =A0drivers/hid/hid-wacom.c | =A0 24 ++++++++++++++++++++++++
> =A01 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index d04e2aa..067e296 100644
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
> @@ -510,6 +532,7 @@ static int wacom_input_mapped(struct hid_device *=
hdev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(input, ABS_DISTAN=
CE, 0, 32, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0case USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(ABS_WHEEL, input->absbit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(ABS_MISC, input->absbit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_2, input->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_3, input->keybit);
> @@ -518,6 +541,7 @@ static int wacom_input_mapped(struct hid_device *=
hdev, struct hid_input *hi,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_6, input->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_7, input->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_8, input->keybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input, ABS_WHEEL, =
0, 71, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(input, ABS_X, 0, =
40640, 4, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(input, ABS_Y, 0, =
25400, 4, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(input, ABS_PRESSU=
RE, 0, 2047, 0, 0);
> --
> 1.7.6.4
>
