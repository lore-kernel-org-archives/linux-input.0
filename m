From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: input: elantech.c: adding more Fujtisu notebooks to force
 crc_enabled
Date: Tue, 27 Jan 2015 15:27:52 -0800
Message-ID: <20150127232752.GA24529@dtor-ws>
References: <54C74A69.7060105@ts.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:38258 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753549AbbA0X15 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 18:27:57 -0500
Received: by mail-ie0-f177.google.com with SMTP id vy18so18431035iec.8
        for <linux-input@vger.kernel.org>; Tue, 27 Jan 2015 15:27:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <54C74A69.7060105@ts.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, jeff.chuang7178@gmail.com, james.chen@emc.com.tw, herman.lin@emc.com.tw, Duson Lin <dusonlin@emc.com.tw>

On Tue, Jan 27, 2015 at 09:20:57AM +0100, Rainer Koenig wrote:
> Extending the patch from November 2014 with two more Fujitsu LIFEBOOK
> models that also ship the Elantech touchpad and don't work with
> crc_disabled.
>=20
> Signed-off-by: Rainer Koenig <Rainer.Koenig@ts.fujitsu.com>

Applied, thank you.

However I am not happy with the direction we are going - the fact that
we need to add more and more laptops to the quirk.  It would be better
if we could detect whether we need CRC or not by querying the touchpad
somehow. Elantech folks, could you help us here?

Thanks!

>=20
> ---
> My responsibility is enabling Linux on Fujitsu desktops and sometimes
> also notebooks. Stumbled into this issue during investigation of a
> customer project and successfully tested the patch on both machines.
>=20
> diff -uNr old/drivers/input/mouse/elantech.c new/drivers/input/mouse/=
elantech.c
> --- old/drivers/input/mouse/elantech.c	2015-01-27 08:51:18.101122218 =
+0100
> +++ new/drivers/input/mouse/elantech.c	2015-01-27 08:51:00.880921663 =
+0100
> @@ -1475,6 +1475,20 @@
>  			DMI_MATCH(DMI_PRODUCT_NAME, "CELSIUS H730"),
>  		},
>  	},
> +	{
> +		/* Fujitsu LIFEBOOK E554  does not work with crc_enabled =3D=3D 0 =
*/
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E554"),
> +		},
> +	},
> +	{
> +		/* Fujitsu LIFEBOOK E544  does not work with crc_enabled =3D=3D 0 =
*/
> +		.matches =3D {
> +			DMI_MATCH(DMI_SYS_VENDOR, "FUJITSU"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "LIFEBOOK E544"),
> +		},
> +	},
>  #endif
>  	{ }
>  };
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

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
