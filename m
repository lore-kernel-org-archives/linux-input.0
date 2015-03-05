From: Jason Gerecke <killertofu@gmail.com>
Subject: Re: [PATCH 1/2] HID: wacom: do not send pen events before touch is
 up/forced out
Date: Wed, 04 Mar 2015 16:27:44 -0800
Message-ID: <54F7A300.4090307@gmail.com>
References: <1424471158-4668-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33284 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752649AbbCEA1t (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 Mar 2015 19:27:49 -0500
Received: by pdev10 with SMTP id v10so15132318pde.0
        for <linux-input@vger.kernel.org>; Wed, 04 Mar 2015 16:27:49 -0800 (PST)
In-Reply-To: <1424471158-4668-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

On 2/20/2015 2:25 PM, Ping Cheng wrote:
> If pen comes in proximity while touch is down, we force touch up
> before sending pen events. Otherwise, there can be unfinished
> touch events compete with pen events. This idea has been fully
> implemented for Tablet PCs. But other tablets that support both
> pen and touch are not fully considered.
>
> Signed-off-by: Ping Cheng <pingc@wacom.com>

Acked-by: Jason Gerecke <killertofu@gmail.com>

--=20
Jason
---
Now instead of four in the eights place /
you=92ve got three, =91Cause you added one /
(That is to say, eight) to the two, /
But you can=92t take seven from three, /
So you look at the sixty-fours....

> ---
>   drivers/hid/wacom_wac.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 046351c..69827c9 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -554,6 +554,9 @@ static int wacom_intuos_inout(struct wacom_wac *w=
acom)
>   	if (features->quirks & WACOM_QUIRK_MULTI_INPUT)
>   		wacom->shared->stylus_in_proximity =3D true;
>
> +	if (wacom->shared->touch_down)
> +		return 1;
> +
>   	/* in Range while exiting */
>   	if (((data[1] & 0xfe) =3D=3D 0x20) && wacom->reporting_data) {
>   		input_report_key(input, BTN_TOUCH, 0);
> @@ -1759,6 +1762,9 @@ static int wacom_bpt_pen(struct wacom_wac *waco=
m)
>   		return 0;
>   	}
>
> +	if (wacom->shared->touch_down)
> +		return 0;
> +
>   	prox =3D (data[1] & 0x20) =3D=3D 0x20;
>
>   	/*
>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
