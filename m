From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH v2 7/8] ARM: LPC32xx: DTS files for device tree conversion
Date: Wed, 18 Apr 2012 07:46:15 +0200
Message-ID: <20120418054615.GB17506@avionic-0098.adnet.avionic-design.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <1334682507-15055-8-git-send-email-stigge@antcom.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MfFXiAuoTsnnDAfZ"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1334682507-15055-8-git-send-email-stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Cc: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org
List-Id: linux-input@vger.kernel.org


--MfFXiAuoTsnnDAfZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Roland Stigge wrote:
[...]
> --- /dev/null
> +++ linux-2.6/arch/arm/boot/dts/lpc32xx.dtsi
> @@ -0,0 +1,303 @@
> +/*
> + * NXP LPC32xx SoC
> + *
> + * Copyright 2012 Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	compatible = "nxp,lpc32xx";
> +
> +	cpus {
> +		cpu@0 {
> +			compatible = "arm,arm926ejs";
> +		};
> +	};
> +
> +	ahb {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "simple-bus";
> +		ranges = <0x20000000 0x20000000 0x30000000>;
> +
> +		slc: flash@20020000 {
> +			compatible = "nxp,nand-slc";
> +			reg = <0x20020000 0x1000>;
> +			status = "disable";
> +		};
> +
> +		mlc: flash@200B0000 {
> +			compatible = "nxp,nand-mlc";
> +			reg = <0x200B0000 0x1000>;
> +			status = "disable";
> +		};
> +
> +		dma@31000000 {
> +			compatible = "arm,pl080", "arm,primecell";
> +			reg = <0x31000000 0x1000>;
> +			interrupt-parent = <&mic>;

Most platforms define the interrupt parent somewhere in the top-level node
and have it inherited for child devices instead of having to repeat it for
each device. But I guess it's also okay to make it explicit.

[...]
> +			/*
> +			 * MIC Interrupt controller includes:
> +			 *   MIC @40008000
> +			 *   SIC1 @4000C000
> +			 *   SIC2 @40010000
> +			 */
> +			mic: interrupt-controller@40008000 {
> +				compatible = "nxp,lpc32xx-mic";
> +				interrupt-controller;
> +				interrupt-parent;

I /think/ in this case you can leave this out. At least there doesn't seem to
be any other such usage in the tree.

Thierry

--MfFXiAuoTsnnDAfZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAk+OVScACgkQZ+BJyKLjJp/+9wCgqaNqeJvdY9/+vc48JNRs3lGp
josAnjaYrWXh5YY6WRM/mUHvVlIhj1kX
=rxOt
-----END PGP SIGNATURE-----

--MfFXiAuoTsnnDAfZ--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
