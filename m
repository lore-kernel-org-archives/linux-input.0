From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: edt-ft5x06 question
Date: Fri, 17 Nov 2017 20:13:51 +0100
Message-ID: <1510946031.15053.30.camel@kernelconcepts.de>
References: <49b16b2c-772d-b9d6-993a-063c41e46200@micronovasrl.com>
         <2352100a-db85-e469-95b1-02d9180aba41@lucaceresoli.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-qjZDLedCuQcWRQI4K6AS"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([188.40.83.200]:60565 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933443AbdKQTOO (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 17 Nov 2017 14:14:14 -0500
In-Reply-To: <2352100a-db85-e469-95b1-02d9180aba41@lucaceresoli.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luca Ceresoli <luca@lucaceresoli.net>, Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: linux-input@vger.kernel.org


--=-qjZDLedCuQcWRQI4K6AS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Trimming down the CC list a bit...]

Hi all.

On Fri, 2017-11-17 at 18:16 +0100, Luca Ceresoli wrote:
> What about all the other registers? The datasheet lists a few dozen,
> not only 0x80. Are they implemented in the panel you are working on?
>=20
> > The point is that datasheet seems to be official by Focaltech,
> > like if they deliver that IC with a standard FW inside.
> > I can't find a way to safely probe if it's a standard FW or from
> > EDT M09
> > or M06.
>=20
> Since everything is based on the programmed firmware, and there's no
> "standard" way to detect firmware version, every firmware detection
> is
> bound to be a hack. But there's no better way I'm afraid. Thus device
> tree seems the only reliable way...
>=20
> However, did you check registers FIRMID, FT5201ID (CTPM Vendor ID)
> and ID_G_LIB_VERSION_H/L? According to their name they might hold
> interesting info.

When I tried to read them from a solomon/goldentek display/touch I did
get unreliable data, i.e. I got different values when I had a power
cycle inbetween the startups.

Basically the firwmare did not implement these registers on the i2c
registers and I believe I got whatever happened to sit in the RAM at
that point. And that was the point where I gave up on trying to
determine the vendor and product, unless I knew where to look for it
(mainly the EDT family of touches).

And that dubiousness extended to the other registers. At some point I
had arbitrary register access via sysfs, but I did not actually bother
to determine if they had any effect or provided useful values.

Trying to communicate with representatives from Solomon Goldentek (in
this case) proved to be incredibly frustrating, because they did not
even understand what I was asking for. You don't get a datasheet
describing the actual firmware in the chip, it always is the same
focaltec datasheet that seems to consist of a lot of wishful thinking.

Sometimes you get a linux driver that might even implement a firmware
update method, but the quality of the code typically is not that great.

Fortunately the "Generic" method implemented in the patch I referred to
earlier seems to work reasonably well for the Displays I have at hand.
You can configure the max. resolution via devicetree and that gets you
95% of the way.

I would not mind additional properties in the devicetree for certain
quirks of specific devices (but encoding the vendor of the touch seems
beyond the point to me). As for frequent recalibration I am not so
sure, but then I've not yet seen a touch device where this has to be
done.

(for the records: the "M12" series from EDT is based on a different IC,
but their firmware implements a M09-style protocol with a few
additions, mainly to identify the panel.)

Bye,
        Simon
--=20
     kernel concepts GmbH                 Simon Budig
     Sieghuetter Hauptweg 48              simon.budig@kernelconcepts.de
     D-57072 Siegen                       +49-271-771091-17
     http://www.kernelconcepts.de/
     HR Siegen, HR B 9613; Gesch=C3=A4ftsf=C3=BChrer: Ole Reinhardt
--=-qjZDLedCuQcWRQI4K6AS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQTPAwhwx6BA+WIUvUM7Y79Fd6yIcAUCWg807wAKCRA7Y79Fd6yI
cJ5TAJ91x9xXEb5y0TyHdLEDwxIIqppW/wCeJmur8zOBtw3ajPd3M2lGSu1IsK8=
=soyP
-----END PGP SIGNATURE-----

--=-qjZDLedCuQcWRQI4K6AS--

