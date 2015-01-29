From: ulrik.debie-os@e2big.org
Subject: Re: input: elantech.c: adding comment lines for Fujitsu notebooks
Date: Thu, 29 Jan 2015 23:35:22 +0100
Message-ID: <20150129223521.GA7563@lantern>
References: <54CA259B.8050602@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:43746 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759214AbbA2XM7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Jan 2015 18:12:59 -0500
Content-Disposition: inline
In-Reply-To: <54CA259B.8050602@ts.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, dmitry.torokhov@gmail.com


Thanks Rainer,

According to the top bit of the first byte of the caps, the Fujitsu LIF=
EBOOK
E544 reports a trackpoint, the Fujitsu LIFEBOOK E554 does not.

This would mean that if you equip the E544 with a trackpoint, the track=
point=20
will work with the next kernel release, but the trackpoint of the E554,=
 when=20
the laptop is equipped with a trackpoint, will not.

I wonder if you can make the trackpoint work on the E554 when equipped
with trackpoint when you force the if test=20
       /* The MSB indicates the presence of the trackpoint */
        if ((etd->capabilities[0] & 0x80) =3D=3D 0x80) {
to always succeed ?

Thanks,
Kind regards,
Ulrik

On Thu, Jan 29, 2015 at 01:20:43PM +0100, Rainer Koenig wrote:
> Ulrik asked me to add some comment lines for the patch I submitted on=
 January 27.
>=20
> Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
> ---
>=20
> diff -uNr old/drivers/input/mouse/elantech.c new/drivers/input/mouse/=
elantech.c
> --- old/drivers/input/mouse/elantech.c	2015-01-29 13:10:04.628549594 =
+0100
> +++ new/drivers/input/mouse/elantech.c	2015-01-29 13:12:38.574624972 =
+0100
> @@ -1097,6 +1097,8 @@
>   * Asus UX31               0x361f00        20, 15, 0e      clickpad
>   * Asus UX32VD             0x361f02        00, 15, 0e      clickpad
>   * Avatar AVIU-145A2       0x361f00        ?               clickpad
> + * Fujitsu LIFEBOOK E544   0x470f00        d0, 12, 09      2 hw butt=
ons
> + * Fujitsu LIFEBOOK E554   0x570f01        40, 14, 0c      2 hw butt=
ons
>   * Fujitsu H730            0x570f00        c0, 14, 0c      3 hw butt=
ons (**)
>   * Gigabyte U2442          0x450f01        58, 17, 0c      2 hw butt=
ons
>   * Lenovo L430             0x350f02        b9, 15, 0c      2 hw butt=
ons (*)
>=20
> --=20
> Dipl.-Inf. (FH) Rainer Koenig
> Project Manager Linux Clients
> Dept. PDG WPS R&D SW OSE
>=20
> Fujitsu Technology Solutions
> B=FCrgermeister-Ullrich-Str. 100
> 86199 Augsburg
> Germany
>=20
> Telephone: +49-821-804-3321
> Telefax:   +49-821-804-2131
> Mail:      mailto:Rainer.Koenig@ts.fujitsu.com
>=20
> Internet         ts.fujtsu.com
> Company Details  ts.fujitsu.com/imprint.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
