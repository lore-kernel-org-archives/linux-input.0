From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 3/3] HID: wacom: set stylus_in_proximity before checking
 touch_down
Date: Wed, 01 Apr 2015 11:59:52 -0700
Message-ID: <551C4028.5010605@gmail.com>
References: <1426888681-8755-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f170.google.com ([209.85.192.170]:35912 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752799AbbDAS7z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Apr 2015 14:59:55 -0400
Received: by pdea3 with SMTP id a3so12389693pde.3
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2015 11:59:55 -0700 (PDT)
In-Reply-To: <1426888681-8755-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, benjamin.tissoires@gmail.com, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On 3/20/2015 2:58 PM, Ping Cheng wrote:
> In wacom_bpt_pen, we checked touch_down before assigning new
> stylus_in_proximity value. This would cause stylus_in_proximity
> not updated properly if touch is down before pen is in proximity.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>
> ---
>   drivers/hid/wacom_wac.c | 35 ++++++++++++++++-------------------
>   1 file changed, 16 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 60d9ccb..63e767e 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -1752,9 +1752,6 @@ static int wacom_bpt_pen(struct wacom_wac *waco=
m)
>   		return 0;
>   	}
>
> -	if (wacom->shared->touch_down)
> -		return 0;
> -
>   	prox =3D (data[1] & 0x20) =3D=3D 0x20;
>
>   	/*
> @@ -1767,17 +1764,21 @@ static int wacom_bpt_pen(struct wacom_wac *wa=
com)
>   	 *
>   	 * Hardware does report zero in most out-of-prox cases but not all=
=2E
>   	 */
> -	if (prox) {
> -		if (!wacom->shared->stylus_in_proximity) {
> -			if (data[1] & 0x08) {
> -				wacom->tool[0] =3D BTN_TOOL_RUBBER;
> -				wacom->id[0] =3D ERASER_DEVICE_ID;
> -			} else {
> -				wacom->tool[0] =3D BTN_TOOL_PEN;
> -				wacom->id[0] =3D STYLUS_DEVICE_ID;
> -			}
> -			wacom->shared->stylus_in_proximity =3D true;
> +	if (!wacom->shared->stylus_in_proximity) {
> +		if (data[1] & 0x08) {
> +			wacom->tool[0] =3D BTN_TOOL_RUBBER;
> +			wacom->id[0] =3D ERASER_DEVICE_ID;
> +		} else {
> +			wacom->tool[0] =3D BTN_TOOL_PEN;
> +			wacom->id[0] =3D STYLUS_DEVICE_ID;
>   		}
> +	}
> +
> +	wacom->shared->stylus_in_proximity =3D prox;
> +	if (wacom->shared->touch_down)
> +		return 0;
> +
> +	if (prox) {
>   		x =3D le16_to_cpup((__le16 *)&data[2]);
>   		y =3D le16_to_cpup((__le16 *)&data[4]);
>   		p =3D le16_to_cpup((__le16 *)&data[6]);
> @@ -1793,7 +1794,8 @@ static int wacom_bpt_pen(struct wacom_wac *waco=
m)
>   		pen =3D data[1] & 0x01;
>   		btn1 =3D data[1] & 0x02;
>   		btn2 =3D data[1] & 0x04;
> -	}
> +	} else
> +		wacom->id[0] =3D 0;

Nitpick: Add braces around this final block. Otherwise:

Reviewed-by: Jason Gerecke <jason.gerecke@wacom.com>

---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....

>
>   	input_report_key(input, BTN_TOUCH, pen);
>   	input_report_key(input, BTN_STYLUS, btn1);
> @@ -1804,11 +1806,6 @@ static int wacom_bpt_pen(struct wacom_wac *wac=
om)
>   	input_report_abs(input, ABS_PRESSURE, p);
>   	input_report_abs(input, ABS_DISTANCE, d);
>
> -	if (!prox) {
> -		wacom->id[0] =3D 0;
> -		wacom->shared->stylus_in_proximity =3D false;
> -	}
> -
>   	input_report_key(input, wacom->tool[0], prox); /* PEN or RUBBER */
>   	input_report_abs(input, ABS_MISC, wacom->id[0]); /* TOOL ID */
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
