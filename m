From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] dt-bindings: touchscreen: silead_gsl1680: Document
 touchscreen-fw-name
Date: Mon, 29 Aug 2016 07:18:34 +0200
Message-ID: <20160829051834.GW3165@lukather>
References: <1471964688-12188-1-git-send-email-hdegoede@redhat.com>
 <20160829003725.GA20749@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="L+ytD9kXoSFEJYhc"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:49540 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750730AbcH2FSi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 Aug 2016 01:18:38 -0400
Content-Disposition: inline
In-Reply-To: <20160829003725.GA20749@rob-hp-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>


--L+ytD9kXoSFEJYhc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Sun, Aug 28, 2016 at 07:37:25PM -0500, Rob Herring wrote:
> On Tue, Aug 23, 2016 at 05:04:48PM +0200, Hans de Goede wrote:
> > The driver has supported touchscreen-fw-name to specify the firmware to
> > load since day 0, but this was omitted from the binding, document this.
> >=20
> > Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> > ---
> >  Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt=
 | 1 +
> >  1 file changed, 1 insertion(+)
>=20
> I'd really like to deprecate in favor of a standard property name. We've=
=20
> somewhat agreed on 'firmware-name' though there is no common binding doc=
=20
> yet. But given this is in use:

This has been introduced in 4.8-rc1, so it hasn't been used in any
stable version yet, and we don't have any users in tree so far.

If you want to something else, it feels like now is the time to change
it.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--L+ytD9kXoSFEJYhc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXw8WqAAoJEBx+YmzsjxAg2RIQAJPc6UqXojIRHy2TF85VwVqx
wWxYAwfEnyI8ojm7VLMcoDobBE4LdUHqNfeH7wBizmxULavDUJIrQG+G64k/C3Q2
R+GAwDPKcapb/ISuBDYjS3wa15XP5sUoO6pLQ1qYlmxXPBAF0o7wAd85NN3SC6MT
bLc4kF59bmHIiU+RSAiBzn0b1AYj6XAzOJirl8JWMqAiGMi5qJOXIMRDa89TDyO6
SyoT61Xpmkvq2kqS3RNZTmTfcNGWdZPI1wuOLJFX1YkY9OuQwgsnK3elds/A70zw
8nZ/E/OJv65wEqr5FLk6OcPXL7VPiWyxD02MuNcFFPWaz59MD76UzG9/RJfHM2yx
JodVi5MYJec0YtIO1wpiposfscNbMjpdzDGuxSLSgXKQaU0JFPztKak2clcrVEY2
GQtFTT4LbyG0SWQRu5ovMtg6Pz385nIAvhU+l/APkuQRprCqZY0wDgSqnokfczI2
L1cNm1Wqp1hvOjsqSikMtKM23Wf+oxDZgTyU3sksMpwFr1T/VsyzPW0M9T3N2d1K
hi9ltqcW/TcKhQ7RqZM0HJTM5azxogJged1d8lxWi25R/9fQwc3fKkWUYrAksb80
VeeftHguBb5XCQGML3UP5RqpAA6H0DwBQiqYQxY4634zqVHW+5WbxuqFt5MAR2rr
s4EpRJeqj1c20hTB4WXx
=CHFH
-----END PGP SIGNATURE-----

--L+ytD9kXoSFEJYhc--
