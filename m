From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [PATCH] Input: wacom - Add POINTER and DIRECT device properties
Date: Thu, 1 Sep 2011 12:31:09 -0700
Message-ID: <CAF8JNhKAZRoB07sSn7mvuDN-9yMJgdCLWSsBrT4vAVWtq=7Dqg@mail.gmail.com>
References: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:52353 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756087Ab1IATbK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Sep 2011 15:31:10 -0400
Received: by ywf7 with SMTP id 7so1656655ywf.19
        for <linux-input@vger.kernel.org>; Thu, 01 Sep 2011 12:31:09 -0700 (PDT)
In-Reply-To: <1314892843-1475-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, jeffbrown@google.com

On Thu, Sep 1, 2011 at 9:00 AM, Jason Gerecke <killertofu@gmail.com> wr=
ote:
>
> Adds INPUT_PROP_POINTER or INPUT_PROP_DIRECT as necessary to the
> hardware supported by the Wacom driver. The DIRECT property is
> assigned to devices with an embedded screen (i.e. touchscreens
> and display tablets). The POINTER property is assigned to those
> without embedded screens.
>
> Signed-off-by: Jason Gerecke <killertofu@gmail.com>

Reviewed-by: Ping Cheng <pingc@wacom.com>

Ping

> ---
> =A0drivers/hid/hid-wacom.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 =A02=
 ++
> =A0drivers/input/tablet/wacom_wac.c =A0 =A0 =A0 =A0| =A0 25 +++++++++=
+++++++++++++++-
> =A0drivers/input/touchscreen/wacom_w8001.c | =A0 =A02 ++
> =A03 files changed, 28 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
> index 0688832..5b9267d 100644
> --- a/drivers/hid/hid-wacom.c
> +++ b/drivers/hid/hid-wacom.c
> @@ -383,6 +383,8 @@ move_on:
> =A0 =A0 =A0 =A0hidinput =3D list_entry(hdev->inputs.next, struct hid_=
input, list);
> =A0 =A0 =A0 =A0input =3D hidinput->input;
>
> + =A0 =A0 =A0 __set_bit(INPUT_PROP_POINTER, input->propbit);
> +
> =A0 =A0 =A0 =A0/* Basics */
> =A0 =A0 =A0 =A0input->evbit[0] |=3D BIT(EV_KEY) | BIT(EV_ABS) | BIT(E=
V_REL);
>
> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/=
wacom_wac.c
> index 87b0e0d..a28d48c 100644
> --- a/drivers/input/tablet/wacom_wac.c
> +++ b/drivers/input/tablet/wacom_wac.c
> @@ -1098,6 +1098,8 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_MOUSE, input_dev->k=
eybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_STYLUS, input_dev->keybi=
t);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_STYLUS2, input_dev->keyb=
it);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_POINTER, input_dev=
->propbit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case WACOM_21UX2:
> @@ -1126,6 +1128,9 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(input_dev, ABS_Z,=
 -900, 899, 0, 0);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_DIRECT, input_dev-=
>propbit);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_setup_cintiq(wacom_wac);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> @@ -1150,6 +1155,8 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
>
> =A0 =A0 =A0 =A0case INTUOS:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_POINTER, input_dev=
->propbit);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_setup_intuos(wacom_wac);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> @@ -1165,6 +1172,8 @@ void wacom_setup_input_capabilities(struct inpu=
t_dev *input_dev,
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_set_abs_params(input_dev, ABS_Z,=
 -900, 899, 0, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wacom_setup_intuos(wacom_wac);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_POINTER, input_dev=
->propbit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case TABLETPC2FG:
> @@ -1183,14 +1192,24 @@ void wacom_setup_input_capabilities(struct in=
put_dev *input_dev,
> =A0 =A0 =A0 =A0case TABLETPC:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__clear_bit(ABS_MISC, input_dev->absbi=
t);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_DIRECT, input_dev-=
>propbit);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->device_type !=3D BTN_TOO=
L_PEN)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break; =A0/* no need t=
o process stylus stuff */
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
>
> =A0 =A0 =A0 =A0case PL:
> - =A0 =A0 =A0 case PTU:
> =A0 =A0 =A0 =A0case DTU:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_PEN, input_dev->keyb=
it);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_RUBBER, input_dev->k=
eybit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_STYLUS, input_dev->keybit=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_STYLUS2, input_dev->keybi=
t);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_DIRECT, input_dev-=
>propbit);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case PTU:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_STYLUS2, input_dev->keyb=
it);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* fall through */
>
> @@ -1198,11 +1217,15 @@ void wacom_setup_input_capabilities(struct in=
put_dev *input_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_PEN, input_dev->key=
bit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_TOOL_RUBBER, input_dev->=
keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_STYLUS, input_dev->keybi=
t);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_POINTER, input_dev=
->propbit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> =A0 =A0 =A0 =A0case BAMBOO_PT:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__clear_bit(ABS_MISC, input_dev->absbi=
t);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(INPUT_PROP_POINTER, input_dev=
->propbit);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (features->device_type =3D=3D BTN_T=
OOL_DOUBLETAP) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_LEFT, in=
put_dev->keybit);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__set_bit(BTN_FORWARD,=
 input_dev->keybit);
> diff --git a/drivers/input/touchscreen/wacom_w8001.c b/drivers/input/=
touchscreen/wacom_w8001.c
> index c14412e..9941d39 100644
> --- a/drivers/input/touchscreen/wacom_w8001.c
> +++ b/drivers/input/touchscreen/wacom_w8001.c
> @@ -383,6 +383,8 @@ static int w8001_setup(struct w8001 *w8001)
> =A0 =A0 =A0 =A0dev->evbit[0] =3D BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> =A0 =A0 =A0 =A0strlcat(w8001->name, "Wacom Serial", sizeof(w8001->nam=
e));
>
> + =A0 =A0 =A0 __set_bit(INPUT_PROP_DIRECT, dev->propbit);
> +
> =A0 =A0 =A0 =A0/* penabled? */
> =A0 =A0 =A0 =A0error =3D w8001_command(w8001, W8001_CMD_QUERY, true);
> =A0 =A0 =A0 =A0if (!error) {
> --
> 1.7.6
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
