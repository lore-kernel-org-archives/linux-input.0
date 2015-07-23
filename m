From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Avoid unresponsive TSC-30 touch screen
Date: Thu, 23 Jul 2015 14:03:01 -0700
Message-ID: <20150723210301.GD12733@dtor-ws>
References: <6B919AC79333344DB0660E3FADEB2165057496DA51FD@BYTECEXCHGSRV.bytecexchg.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:32952 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018AbbGWVDG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jul 2015 17:03:06 -0400
Received: by pdbnt7 with SMTP id nt7so1981794pdb.0
        for <linux-input@vger.kernel.org>; Thu, 23 Jul 2015 14:03:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6B919AC79333344DB0660E3FADEB2165057496DA51FD@BYTECEXCHGSRV.bytecexchg.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bernhard Bender <Bernhard.Bender@bytecmed.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jakob Mustafa <Jakob.Mustafa@bytecmed.com>

On Thu, Jul 23, 2015 at 05:01:31PM +0200, Bernhard Bender wrote:
> From: Bernhard Bender <bernhard.bender@bytecmed.com>
>=20
> This patch fixes a problem in the usbtouchscreen driver for DMC TSC-3=
0 touch screen.
> Due to a missing delay between the RESET and SET_RATE commands, the t=
ouch screen may
> become unresponsive during system startup or driver loading.
>=20
> According to the DMC documentation, a delay is needed after the RESET=
 command to allow
> the chip to complete its internal initialization. As this delay is no=
t guaranteed, we
> had a system where the touch screen occasionally did not send any tou=
ch data. There was
> no other indication of the problem.
>=20
> The patch fixes the problem by adding a 150ms delay between the RESET=
 and SET_RATE commands.
>=20
>         Signed-off-by: Bernhard Bender <bernhard.bender@bytecmed.com>
>         Suggested-by: Jakob Mustafa <jakob.mustafa@bytecmed.com>

Applied, thank you.

>=20
> ---
> Bernhard Bender
> Entwicklung
>=20
> Bytec Medizintechnik GmbH
> Hermann-Hollerith-Str. 11
> 52249 Eschweiler, Germany
> Tel. +49 (2403) 7829-943
> www.bytecmed.com
>=20
> Handelsregister Aachen: HRB 11222
> Ust-ID: DE 121732719
> Gesch=E4ftsf=FChrer: Dipl.-Ing. Paul Willi Coenen
>=20
>=20
> diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/inp=
ut/touchscreen/usbtouchscreen.c
> old mode 100644
> new mode 100755
> index a096633..4ebff01
> --- a/drivers/input/touchscreen/usbtouchscreen.c
> +++ b/drivers/input/touchscreen/usbtouchscreen.c
> @@ -625,6 +625,9 @@ static int dmc_tsc10_init(struct usbtouch_usb *us=
btouch)
>                 goto err_out;
>         }
>=20
> +    /* TSC-25 data sheet specifies a delay after the RESET command *=
/
> +    msleep(150);
> +
>         /* set coordinate output rate */
>         buf[0] =3D buf[1] =3D 0xFF;
>         ret =3D usb_control_msg(dev, usb_rcvctrlpipe (dev, 0),
>=20
>=20
>=20
> Diese E-Mail enth=E4lt vertrauliche und/oder rechtlich gesch=FCtzte I=
nformationen. Wenn Sie nicht der richtige Adressat sind oder diese E-Ma=
il irrt=FCmlich erhalten haben, informieren Sie bitte sofort den Absend=
er unter info@bytecmed.com und l=F6schen Sie diese Mail. Das unerlaubte=
 Kopieren sowie die unbefugte Weitergabe dieser Mail ist nicht gestatte=
t.
>=20
> This message may contain privileged and confidential information inte=
nded only for the use of the addressee named above. If you are not the =
intended recipient of this message you are hereby notified that any use=
, dissemination, distribution of reproduction of this message is prohib=
ited. If you have received this message in error please notify info@byt=
ecmed.com  immediately.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
