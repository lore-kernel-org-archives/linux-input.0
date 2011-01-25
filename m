From: Ping Cheng <pinglinux@gmail.com>
Subject: Re: [v2] input: wacom - Pass touch resolution to clients through input_absinfo
Date: Tue, 25 Jan 2011 09:59:09 -0800
Message-ID: <AANLkTi=Nd+gLu-c_vwPdEoGKRauFHL8Q3JCuUPxm61gj@mail.gmail.com>
References: <1295910373-2450-1-git-send-email-pinglinux@gmail.com>
	<20110125100238.GA5837@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51974 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab1AYR7K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 25 Jan 2011 12:59:10 -0500
Received: by wyb28 with SMTP id 28so47520wyb.19
        for <linux-input@vger.kernel.org>; Tue, 25 Jan 2011 09:59:09 -0800 (PST)
In-Reply-To: <20110125100238.GA5837@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com

On Tue, Jan 25, 2011 at 2:02 AM, Henrik Rydberg <rydberg@euromail.se> w=
rote:
> On Mon, Jan 24, 2011 at 11:06:13PM -0000, Ping Cheng wrote:
>> Fixed the workaround used for kernels older than 2.6.35.
>>
>> Signed-off-by: Ping Cheng <pingc@wacom.com>
>>
>> ---
>> drivers/input/tablet/wacom_wac.c | =A0 12 ++++++++++--
>> =A01 files changed, 10 insertions(+), 2 deletions(-)
>
> A define or a function would have been nicer than "100", but since
> this wasn't obvious from the comments,

I'll make a version 3 to add a function with comments since I need to
remove RX/RY from this patch anyway.

> Reviewed-by: Henrik Rydberg <rydberg@euromail.se>

Thank you.

Ping
>
> Thanks,
> Henrik
>
>>
>> diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet=
/wacom_wac.c
>> index f44c822..12d5ccf 100644
>> --- a/drivers/input/tablet/wacom_wac.c
>> +++ b/drivers/input/tablet/wacom_wac.c
>> @@ -1228,8 +1228,11 @@ void wacom_setup_input_capabilities(struct in=
put_dev *input_dev,
>> =A0 =A0 =A0 case TABLETPC:
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (features->device_type =3D=3D BTN_TOO=
L_DOUBLETAP ||
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 features->device_type =3D=3D BTN=
_TOOL_TRIPLETAP) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input=
_dev, ABS_RX, 0, features->x_phy, 0, 0);
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(input=
_dev, ABS_RY, 0, features->y_phy, 0, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set touch resolution in=
 points/mm */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_de=
v, ABS_X,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 100 * feat=
ures->x_max / features->x_phy);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_de=
v, ABS_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 100 * feat=
ures->y_max / features->y_phy);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_DOUBL=
ETAP, input_dev->keybit);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> @@ -1272,6 +1275,11 @@ void wacom_setup_input_capabilities(struct in=
put_dev *input_dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_set_abs_params(inp=
ut_dev, ABS_MT_PRESSURE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A00, features->pressure_max,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0features->pressure_fuzz, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set touch resolution in=
 points/mm */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_de=
v, ABS_X,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 100 * feat=
ures->x_max / features->x_phy);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_abs_set_res(input_de=
v, ABS_Y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 100 * feat=
ures->y_max / features->y_phy);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (features->device_type =3D=3D =
BTN_TOOL_PEN) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_RUBBE=
R, input_dev->keybit);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(BTN_TOOL_PEN, =
input_dev->keybit);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
