From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v1] Input: rotary-encoder - Add gpio as push button
Date: Fri, 14 Jun 2019 16:51:58 +0200
Message-ID: <20190614145158.ic5n4jauzigvcpru@flea>
References: <20190614133651.28396-1-mylene.josserand@bootlin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zhhrocqtd54h66wd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190614133651.28396-1-mylene.josserand@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: dmitry.torokhov@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
List-Id: linux-input@vger.kernel.org


--zhhrocqtd54h66wd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Mylene,

On Fri, Jun 14, 2019 at 03:36:51PM +0200, Myl=E8ne Josserand wrote:
> Add the support of a gpio that can be defined as a push button.
> Thanks to that, it is possible to emit a keycode in case of a
> "push" event, if the rotary supports that.
>
> The keycode to emit is defined using "linux,code" property
> (such as in gpio-keys).
>
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand@bootlin.com>
> ---
>  .../devicetree/bindings/input/rotary-encoder.txt   |  5 +++
>  drivers/input/misc/rotary_encoder.c                | 50 ++++++++++++++++=
++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/rotary-encoder.txt b=
/Documentation/devicetree/bindings/input/rotary-encoder.txt
> index a644408b33b8..1cfce5d0b5c4 100644
> --- a/Documentation/devicetree/bindings/input/rotary-encoder.txt
> +++ b/Documentation/devicetree/bindings/input/rotary-encoder.txt
> @@ -22,6 +22,9 @@ Optional properties:
>  - wakeup-source: Boolean, rotary encoder can wake up the system.
>  - rotary-encoder,encoding: String, the method used to encode steps.
>    Supported are "gray" (the default and more common) and "binary".
> +- push-gpio: a gpio to be used as a detection of a push from the rotary.

According to Documentation/devicetree/bindings/gpio/gpio.txt, GPIO
properties with a -gpio suffix are now deprecated in favor of the
-gpios suffix.

> +- linux,code: keycode to emit with the push-gpio of this rotary encoder.
> +  Required property in case "push-gpio"'s one is used.

I guess we should make it clear in the property name that it's the
keycode emitted at push. Otherwise, it will be ambiguous between the
rotary itself, or the button.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zhhrocqtd54h66wd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXQO0jQAKCRDj7w1vZxhR
xfa/APwNihQsA19qm8pkGRWL3Qlt9LOqUvcojAJKnBgw5Ey79gD/an1E5acjkg+i
vYdRBFvAGVoRBhf+EhuKBQMgH/N2mww=
=iSqL
-----END PGP SIGNATURE-----

--zhhrocqtd54h66wd--
