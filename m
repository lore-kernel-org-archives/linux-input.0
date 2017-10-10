From: Simon Budig <simon.budig@kernelconcepts.de>
Subject: Re: [PATCH 1/3] edt-ft5x06: fix reset pin behaviour
Date: Tue, 10 Oct 2017 12:39:12 +0200
Message-ID: <1507631952.5466.20.camel@kernelconcepts.de>
References: <1507217501.7345.9.camel@kernelconcepts.de>
         <20171005153508.32127-1-simon.budig@kernelconcepts.de>
         <20171010035801.GC4601@dtor-ws>
         <1507631156.5466.14.camel@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
        boundary="=-LULWO80GVbVw7wr2QiKR"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernelconcepts.de ([188.40.83.200]:60605 "EHLO
        mail.kernelconcepts.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbdJJKjU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 10 Oct 2017 06:39:20 -0400
In-Reply-To: <1507631156.5466.14.camel@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


--=-LULWO80GVbVw7wr2QiKR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-10-10 at 12:25 +0200, Simon Budig wrote:
> *If* that is actually the case (i.e. requesting an pin specified as
> GPIO_ACTIVE_LOW in the devicetree with the GPIOD_OUT_HIGH flag
> results in 0V on this pin) then this patch should probably be
> dropped, although I don't like how this code reads then.

Ok, I've traced the code in the gpio-subsystem and indeed, requesting
with the GPIOD_OUT_HIGH flag results in a LOW leveGPIOD_OUT_HIGH upon
request when the GPIO_ACTIVE_LOW is set on that pin.

That constant really should've been called GPIOD_OUT_ACTIVE or
something. That reads confusing as heck.

Anyway, please drop this patch. It doesn't actually do any good.

Thanks,
        Simon

--=20
     kernel concepts GmbH                 Simon Budig
     Sieghuetter Hauptweg 48              simon.budig@kernelconcepts.de
     D-57072 Siegen                       +49-271-771091-17
     http://www.kernelconcepts.de/
     HR Siegen, HR B 9613; Gesch=C3=A4ftsf=C3=BChrer: Ole Reinhardt
--=-LULWO80GVbVw7wr2QiKR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQTPAwhwx6BA+WIUvUM7Y79Fd6yIcAUCWdyjUAAKCRA7Y79Fd6yI
cA+jAKCAYjhNhll0Jj24QydZn2v1S6TpCgCdHNosTC8+vOQqUEi0rbJyl28keaQ=
=MVqg
-----END PGP SIGNATURE-----

--=-LULWO80GVbVw7wr2QiKR--

