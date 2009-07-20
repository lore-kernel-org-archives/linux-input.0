From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add support for generic GPIO-based matrix keypad
Date: Mon, 20 Jul 2009 16:13:23 +0530
Message-ID: <5d5443650907200343l3f1f4f9clac79b60847830209@mail.gmail.com>
References: <f17812d70905070100u406614cag1ea1ea913577bbd8@mail.gmail.com>
	 <5d5443650906120601g2e0a563eq270095d5a001d0a1@mail.gmail.com>
	 <f17812d70906120626o4220fb04ra96037014e77aaab@mail.gmail.com>
	 <20090629162619.GB24533@dtor-d630.eng.vmware.com>
	 <4A55BC78.6010206@gmail.com> <4A602D6D.1090707@teltonika.lt>
	 <5d5443650907170132rfea7649o31bb3a84d3c7c79c@mail.gmail.com>
	 <4A60425D.9@teltonika.lt>
	 <5d5443650907200012o4c84b0fm4a03cfb18f7fd738@mail.gmail.com>
	 <4A6448D0.6050002@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.24]:17154 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751970AbZGTKnY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2009 06:43:24 -0400
Received: by qw-out-2122.google.com with SMTP id 8so809454qwh.37
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2009 03:43:23 -0700 (PDT)
In-Reply-To: <4A6448D0.6050002@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Uli Luckas <u.luckas@road.de>, linux-input@vger.kernel.org

Hi Eric,

On Mon, Jul 20, 2009 at 4:07 PM, Eric Miao<eric.y.miao@gmail.com> wrote=
:
>
>>>> Did you tried assigning max_keypmap_size in platform data to
>>>> MATRIX_MAX_COLS * MATRIX_MAX_ROWS ?
>>>>
>>> Yes, this fixes crashes. But this is just workaround for bug in dri=
ver.
>>>
>>
>> As you have access to h/w, care to submit a patch which fixes this?
>>
>
> Dmitry & Trilok,
>
> How about this? =A0Due to the fact that we are not able to sort out t=
he
> proper solution for a dynamic maximum of columns/rows, let's simplify
> the fix to the patch below:
>
>
> From 61ea1bd16a3636f526fb12619e84a75fa16b7f38 Mon Sep 17 00:00:00 200=
1
> From: Eric Miao <eric.y.miao@gmail.com>
> Date: Mon, 20 Jul 2009 11:31:08 +0800
> Subject: [PATCH] input: matrix keymap size fixed to maximum
>
> Introduced KEY_IDX(), merged keymap_data into 'matrix_keypad_platform=
_data'.
>
> Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
> ---
> =A0drivers/input/keyboard/matrix_keypad.c | =A0 22 ++++++------------=
----
> =A0include/linux/input/matrix_keypad.h =A0 =A0| =A0 21 +++++---------=
-------
> =A02 files changed, 11 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/k=
eyboard/matrix_keypad.c
> index e9b2e7c..a0ba134 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -136,7 +136,7 @@ static void matrix_keypad_scan(struct work_struct=
 *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((bits_changed & (1=
 << row)) =3D=3D 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0contin=
ue;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D (row << 4) + c=
ol;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 code =3D KEY_IDX(row, c=
ol);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_event(input_dev,=
 EV_MSC, MSC_SCAN, code);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_key(input=
_dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 keypad->keycodes[code],
> @@ -313,7 +313,6 @@ err_free_cols:
> =A0static int __devinit matrix_keypad_probe(struct platform_device *p=
dev)
> =A0{
> =A0 =A0 =A0 =A0const struct matrix_keypad_platform_data *pdata;
> - =A0 =A0 =A0 const struct matrix_keymap_data *keymap_data;
> =A0 =A0 =A0 =A0struct matrix_keypad *keypad;
> =A0 =A0 =A0 =A0struct input_dev *input_dev;
> =A0 =A0 =A0 =A0unsigned short *keycodes;
> @@ -326,20 +325,13 @@ static int __devinit matrix_keypad_probe(struct=
 platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 keymap_data =3D pdata->keymap_data;
> - =A0 =A0 =A0 if (!keymap_data) {
> + =A0 =A0 =A0 if (!pdata->keymap) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&pdev->dev, "no keymap data de=
fined\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (!keymap_data->max_keymap_size) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "invalid keymap dat=
a supplied\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0keypad =3D kzalloc(sizeof(struct matrix_keypad), GFP_K=
ERNEL);
> - =A0 =A0 =A0 keycodes =3D kzalloc(keymap_data->max_keymap_size *
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(=
keypad->keycodes),
> + =A0 =A0 =A0 keycodes =3D kzalloc(sizeof(keypad->keycodes) * MATRIX_=
MAX_KEYS,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 GFP_KERNEL);
> =A0 =A0 =A0 =A0input_dev =3D input_allocate_device();
> =A0 =A0 =A0 =A0if (!keypad || !keycodes || !input_dev) {
> @@ -362,16 +354,14 @@ static int __devinit matrix_keypad_probe(struct=
 platform_device *pdev)
> =A0 =A0 =A0 =A0input_dev->close =A0 =A0 =A0 =A0=3D matrix_keypad_stop=
;
>
> =A0 =A0 =A0 =A0input_dev->keycode =A0 =A0 =A0=3D keycodes;
> - =A0 =A0 =A0 input_dev->keycodesize =A0=3D sizeof(*keycodes);
> - =A0 =A0 =A0 input_dev->keycodemax =A0 =3D keymap_data->max_keymap_s=
ize;
>
> - =A0 =A0 =A0 for (i =3D 0; i < keymap_data->keymap_size; i++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int key =3D keymap_data->keyma=
p[i];
> + =A0 =A0 =A0 for (i =3D 0; i < pdata->keymap_size; i++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int key =3D pdata->keymap[i];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int row =3D KEY_ROW(key);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int col =3D KEY_COL(key);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned short code =3D KEY_VAL(key);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 keycodes[(row << 4) + col] =3D code;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 keycodes[KEY_IDX(row, col)] =3D code;


How about just doing like this

keycodes[(row << ((fls(MATRIX_MAX_COLS) - 1))) + col] ?

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
