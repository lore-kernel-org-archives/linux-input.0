From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 2/8] mfd: AXP20x: Add bindings documentation
Date: Tue, 18 Mar 2014 09:45:05 +0100
Message-ID: <20140318084505.GT27873@lukather>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-3-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GGxZz/e2pmGePzrA"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBPERUCMQKGQEEDGHREI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394898225-28452-3-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--GGxZz/e2pmGePzrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2014 at 04:43:39PM +0100, Carlo Caione wrote:
> Bindings documentation for the AXP20x driver. In this file also two
> sub-nodes (PEK and regulators) are documented.

PEK doesn't look to be documented, either in this patch, or any other.

> Signed-off-by: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt   | 83 ++++++++++++++++=
++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +

I don't really know what the DT maintainers are expecting here, but I
would have done two patches.

>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documenta=
tion/devicetree/bindings/mfd/axp20x.txt
> new file mode 100644
> index 0000000..982aefe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -0,0 +1,83 @@
> +* axp20x device tree bindings
> +
> +The axp20x family current members :-
> +axp202 (X-Powers)
> +axp209 (X-Powers)
> +
> +Required properties:
> +- compatible 			: Should be "x-powers,axp202" or "x-powers,axp209"
> +- interrupt-controller 		: axp20x has its own internal IRQs
> +- #interrupt-cells 		: Should be set to 1
> +- interrupt-parent 		: The parent interrupt controller
> +- interrupts 			: Interrupt specifiers for interrupt sources
> +- reg 				: The I2C slave address for the AXP chip
> +
> +Sub-nodes:
> +* regulators : Contain the regulator nodes. The regulators are bound usi=
ng
> +	       their name as listed here: dcdc2, dcdc3, ldo1, ldo2, ldo3,
> +	       ldo4, ldo5.
> +	       The bindings details of individual regulator device can be found=
 in:
> +	       Documentation/devicetree/bindings/regulator/regulator.txt with t=
he
> +	       exception of:
> +
> +	- dcdc-freq		: defines the work frequency of DC-DC in KHz
> +				  (range: 750-1875). Default: 1.5MHz
> +	- dcdc-workmode		: Optional. 1 for PWM mode, 0 for AUTO mode
> +				  Default: AUTO mode

Those two are x-powers specific, or would it make sense to have them
in other drivers too?

If the former, please add the x-powers prefix.

> +
> +Example:
> +
> +axp: axp20x@34 {
> +	reg =3D <0x34>;
> +	interrupt-parent =3D <&nmi_intc>;
> +	interrupts =3D <0 8>;
> +
> +	compatible =3D "x-powers,axp209";
> +	interrupt-controller;
> +	#interrupt-cells =3D <1>;
> +
> +	regulators {

Do we really need that subnode ? it looks useless, and we already know
that we are defining regulators here.

> +		dcdc-freq =3D "1500";

That frequency is defined at the same level than the dcdc-workmode
property, yet they both seem to be placed at different levels.

> +
> +		axp_dcdc2: dcdc2 {
> +			regulator-min-microvolt =3D <700000>;
> +			regulator-max-microvolt =3D <2275000>;
> +			dcdc-workmode =3D <0>;
> +			regulator-always-on;
> +		};
> +
> +		axp_dcdc3: dcdc3 {
> +			regulator-min-microvolt =3D <700000>;
> +			regulator-max-microvolt =3D <3500000>;
> +			dcdc-workmode =3D <0>;

It looks like those are at their default values?

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--GGxZz/e2pmGePzrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTKAeRAAoJEBx+YmzsjxAguEwP/R3JqK898+Kluc3kCseUL5hO
2XdcsvTPeRiYiNdklqyIMyb0xk0io6OKtxKy7Cfy8ykexaDKxIppt3WVIAHHU/pi
Sea+ZNbdYmwFRcPN4hjRTb4q8spw2SPkPh0/vxzr3T9nxj7ZhhZ8ZO1yN6svgQVb
tQpbFw7Xbj5bmDU7ywMLR+Nhp/+l92JsYDEBhB3/yBonZUL2Wx92z79D2qRRP2k4
3SIkm/ZtQTXgA6MRBZjwZV05dDGXH2mLEpVEsmHDdvsTOveIngsPWiZ/ss+a7A8R
RxZa3j6msX0JA7aASeh3JVZ0zeQRBlQC5Gk8w79L6pdVcQbjmAnf2hAfilFVvFN+
/WIc0OTXHfz35Moq/x1JsjcPHGQF2sR2EDgsIjQ9tboLcjzVumoyZqE2n1RVKn/c
60+XfvA5HMTimihsne2T4MYtZKEc5h4F0MwOzFU+V17G3LLrSM/ty5Tr5RLCImJI
jrBEsv+KETXP5Ul8YAYtnyk+/DCF98rCyuxX6bXchxS8ALBw4oEGqCTSx++faJv+
JiCKlZDT6sBiT0K8Xx/+v5z1eaxCO15FK1WUOpRHWUkY34nKRbOq3FgZ4IK90kop
/TYWmJk5NxObF/20lKjxGlaB4qWUT0/dMQtZRdz5PZBjLxdRr0BZLRF/S/Lf25lr
d2zeNkceQEVjwWqwVmzp
=HrhY
-----END PGP SIGNATURE-----

--GGxZz/e2pmGePzrA--
