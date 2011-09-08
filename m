From: =?ISO-8859-1?Q?Richard_Sch=FCtz?= <r.schtz@t-online.de>
Subject: Re: elantech touchpad issues
Date: Thu, 08 Sep 2011 20:17:29 +0200
Message-ID: <4E6906B9.1080205@t-online.de>
References: <4E6633E5.6080108@t-online.de> <87sjo7oef3.fsf@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout02.t-online.de ([194.25.134.17]:49501 "EHLO
	mailout02.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932739Ab1IJOnQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Sep 2011 10:43:16 -0400
In-Reply-To: <87sjo7oef3.fsf@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: JJ Ding <jj_ding@emc.com.tw>
Cc: linux-input@vger.kernel.org, Aaron Huang <aaron_huang@emc.com.tw>, Tom Lin <tom_lin@emc.com.tw>

Am 08.09.2011 06:18, schrieb JJ Ding:
> Hi Richard,
>
> It turns out that v2 hardware has debounce packet, too. But with
> different signature compared to v3. To the best of my knowledge, I ca=
n
> only say some models of v2 hardware have this, and others don't. So w=
e
> always check for debounce.
>
> Please test this patch and see if it works for you.
> Please apply this on up of my v5 series.
>
> Thanks
> ---
> diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/ela=
ntech.c
> index 38fb155..1e5ea1d 100644
> --- a/drivers/input/mouse/elantech.c
> +++ b/drivers/input/mouse/elantech.c
> @@ -613,6 +613,13 @@ static int elantech_packet_check_v1(struct psmou=
se *psmouse)
>   	       etd->parity[packet[3]] =3D=3D p3;
>   }
>
> +static int elantech_check_debounce_v2(struct psmouse *psmouse)
> +{
> +	const u8 debounce_packet[] =3D { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff=
 };
> +	unsigned char *packet =3D psmouse->packet;
> +	return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
> +}
> +
>   static int elantech_packet_check_v2(struct psmouse *psmouse)
>   {
>   	struct elantech_data *etd =3D psmouse->private;
> @@ -708,6 +715,9 @@ static psmouse_ret_t elantech_process_byte(struct=
 psmouse *psmouse)
>   		break;
>
>   	case 2:
> +		if (elantech_check_debounce_v2(psmouse))
> +			return PSMOUSE_FULL_PACKET;
> +
>   		if (etd->paritycheck&&  !elantech_packet_check_v2(psmouse))
>   			return PSMOUSE_BAD_DATA;
> --
> jj

Yeah, this fixes the annoying issue with multiple fingers.

Now only the problem with the wrong axis ranges is remaining.

--=20
Regards,
Richard Sch=FCtz
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
