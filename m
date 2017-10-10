From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH 1/3] edt-ft5x06: fix reset pin behaviour
Date: Tue, 10 Oct 2017 12:25:56 +0200
Message-ID: <1507631156.5466.14.camel@kernelconcepts.de>
References: <1507217501.7345.9.camel@kernelconcepts.de>
         <20171005153508.32127-1-simon.budig@kernelconcepts.de>
         <20171010035801.GC4601@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-shZLZtt0nJt/eHSqhuaz"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([188.40.83.200]:60594 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755272AbdJJK0D (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Oct 2017 06:26:03 -0400
In-Reply-To: <20171010035801.GC4601@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


--=-shZLZtt0nJt/eHSqhuaz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry.

On Mon, 2017-10-09 at 20:58 -0700, Dmitry Torokhov wrote:
> On Thu, Oct 05, 2017 at 05:35:06PM +0200, simon.budig@kernelconcepts.
> de wrote:
> > From: Simon Budig <simon.budig@kernelconcepts.de>
> >=20
> > For some reason the reset pin no longer gets toggeled when
> > initializing
> > the touch. Fix that and restore the old behaviour.
>=20
> Hmm, the GPIO is requested as GPIOD_OUT_HIGH, so it should be driven
> low
> to being with and then released... I am not sure why we need to drive
> it
> low explicitly again.

It is possible that I misinterpreted something here - at some point I
did have the GPIO pin wrongly registered in the devicetree.

However, API-wise it is not clear to me, that GPIOD_OUT_HIGH results in
an actual low state of the Pin. That might be different if the constant
was called GPIOD_OUT_ACTIVE or something, since this would refer to the
"low_active" state of the pin.

*If* that is actually the case (i.e. requesting an pin specified as
GPIO_ACTIVE_LOW in the devicetree with the GPIOD_OUT_HIGH flag results
in 0V on this pin) then this patch should probably be dropped, although
I don't like how this code reads then.

I also reread the focaltec datasheet and I've messed up the delays in
this patch, so if the above does *not* happen then I'd need to rework
this...

Bye,
        Simon

--=20
     kernel concepts GmbH                 Simon Budig
     Sieghuetter Hauptweg 48              simon.budig@kernelconcepts.de
     D-57072 Siegen                       +49-271-771091-17
     http://www.kernelconcepts.de/
     HR Siegen, HR B 9613; Gesch=C3=A4ftsf=C3=BChrer: Ole Reinhardt
--=-shZLZtt0nJt/eHSqhuaz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQTPAwhwx6BA+WIUvUM7Y79Fd6yIcAUCWdygNAAKCRA7Y79Fd6yI
cAABAKC9OYYtehP8b5Qed9clKNAf6/JpPgCeMYRpu+7DuxIviu3+DD8bnupY+40=
=7Bmj
-----END PGP SIGNATURE-----

--=-shZLZtt0nJt/eHSqhuaz--

