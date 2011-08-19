From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 3/6] Input: elantech - packet checking for v2 hardware
Date: Fri, 19 Aug 2011 14:22:46 +0200
Message-ID: <4E4E5596.9070001@tudelft.nl>
References: <1313632629-23603-1-git-send-email-jj_ding@emc.com.tw> <1313632629-23603-4-git-send-email-jj_ding@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:58330 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754002Ab1HSMWs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 19 Aug 2011 08:22:48 -0400
In-Reply-To: <1313632629-23603-4-git-send-email-jj_ding@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Seth Forshee <seth.forshee@canonical.com>, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>, Daniel Kurtz <djkurtz@chromium.org>, Chase Douglas <chase.douglas@canonical.com>, Henrik Rydberg <rydberg@euromail.se>, Alessandro Rubini <rubini@cvml.unipv.it>

Op 18-08-11 03:57, JJ Ding schreef:
> For v2 hardware, there is no real parity check, but we can still chec=
k
> some constant bits for data integrity.
>
> Signed-off-by: JJ Ding<jj_ding@emc.com.tw>
If you add some comments, as suggest by Dmitry, it looks perfect :-)

Signed-off-by: =C3=89ric Piel <eric.piel@tremplin-utc.net>

=C3=89ric

> ---
>   drivers/input/mouse/elantech.c |   26 +++++++++++++++++++++++---
>   1 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index cf41f23..032181c 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -376,6 +376,25 @@ static int elantech_check_parity_v1(struct psmou=
se *psmouse)
>   	       etd->parity[packet[3]] =3D=3D p3;
>   }
>
> +static int packet_simple_check_v2(struct psmouse *psmouse)
> +{
> +	struct elantech_data *etd =3D psmouse->private;
> +	unsigned char *packet =3D psmouse->packet;
> +
> +	if (etd->reports_pressure)
> +		return (packet[0]&  0x0c) =3D=3D 0x04&&
> +		       (packet[3]&  0x0f) =3D=3D 0x02;
> +
> +	if ((packet[0]&  0xc0) =3D=3D 0x80)
> +		return (packet[0]&  0x0c) =3D=3D 0x0c&&
> +		       (packet[3]&  0x0e) =3D=3D 0x08;
> +
> +	return (packet[0]&  0x3c) =3D=3D 0x3c&&
> +	       (packet[1]&  0xf0) =3D=3D 0x00&&
> +	       (packet[3]&  0x3e) =3D=3D 0x38&&
> +	       (packet[4]&  0xf0) =3D=3D 0x00;
> +}
> +
>   /*
>    * Process byte stream from mouse and handle complete packets
>    */
> @@ -398,7 +417,9 @@ static psmouse_ret_t elantech_process_byte(struct=
 psmouse *psmouse)
>   		break;
>
>   	case 2:
> -		/* We don't know how to check parity in protocol v2 */
> +		if (etd->paritycheck&&  !packet_simple_check_v2(psmouse))
> +			return PSMOUSE_BAD_DATA;
> +
>   		elantech_report_absolute_v2(psmouse);
>   		break;
>   	}
> @@ -799,8 +820,7 @@ int elantech_init(struct psmouse *psmouse)
>   		etd->hw_version =3D 2;
>   		/* For now show extra debug information */
>   		etd->debug =3D 1;
> -		/* Don't know how to do parity checking for version 2 */
> -		etd->paritycheck =3D 0;
> +		etd->paritycheck =3D 1;
>
>   		if (etd->fw_version>=3D 0x020800)
>   			etd->reports_pressure =3D true;

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
