From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add lradc node
Date: Tue, 4 Jun 2019 16:59:07 +0200
Message-ID: <20190604145907.j3fp52gxupd3bkih@flea>
References: <20190604144252.26965-1-luca@z3ntu.xyz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zeywvuntmrvlmigf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190604144252.26965-1-luca@z3ntu.xyz>
Sender: linux-kernel-owner@vger.kernel.org
To: Luca Weiss <luca@z3ntu.xyz>
Cc: Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Chen-Yu Tsai <wens@csie.org>, "open list:SUN4I LOW RES ADC ATTACHED TABLET KEYS DRIVER" <linux-input@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "moderated list:ARM/Allwinner sunXi SoC support" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org


--zeywvuntmrvlmigf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Luca,

On Tue, Jun 04, 2019 at 04:42:53PM +0200, Luca Weiss wrote:
> Add a node describing the KEYADC on the A64.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

You should have a changelog detailing which changes you made to your
patch with the previous version, and why you made those changes (for
example because we looked at the a83t datasheet and found the two
controllers to be very similar).

> ---
>  .../devicetree/bindings/input/sun4i-lradc-keys.txt        | 1 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi             | 8 ++++++++
>  2 files changed, 9 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> index 496125c6bfb7..507b737612ea 100644
> --- a/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> +++ b/Documentation/devicetree/bindings/input/sun4i-lradc-keys.txt
> @@ -5,6 +5,7 @@ Required properties:
>   - compatible: should be one of the following string:
>  		"allwinner,sun4i-a10-lradc-keys"
>  		"allwinner,sun8i-a83t-r-lradc"
> +		"allwinner,sun50i-a64-lradc", "allwinner,sun8i-a83t-r-lradc"
>   - reg: mmio address range of the chip
>   - interrupts: interrupt to which the chip is connected
>   - vref-supply: powersupply for the lradc reference voltage
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 7734f70e1057..3a42352b5c9f 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -704,6 +704,14 @@
>  			status = "disabled";
>  		};
>
> +		lradc: lradc@1c21800 {
> +			compatible = "allwinner,sun50i-a64-lradc",
> +				     "allwinner,sun8i-a83t-r-lradc";
> +			reg = <0x01c21800 0x400>;
> +			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
> +			status = "disabled";
> +		};
> +

The bindings and the dt changes should be two different patches as
well.

Thanks!
Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zeywvuntmrvlmigf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPaHOwAKCRDj7w1vZxhR
xSCVAP9HifWQjLo0644GCGN5e5COuSQdxy0ZI0cNk9VMK0ez6wEAsx9jt6NTjM24
Trk40SgSkATAuyASrgr34Yguf/iQbQk=
=yHyP
-----END PGP SIGNATURE-----

--zeywvuntmrvlmigf--
