From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 1/5] arm: dts: sun8i: a83t: Add I2C0 node
Date: Mon, 11 Dec 2017 08:15:13 +0100
Message-ID: <20171211071513.xgni3t6ihmeeebre@flea.lan>
References: <20171208215419.30396-1-mylene.josserand@free-electrons.com>
 <20171208215419.30396-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7mew5amzvozgr3w3"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171208215419.30396-2-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, simon.budig-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--7mew5amzvozgr3w3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 08, 2017 at 10:54:15PM +0100, Myl=E8ne Josserand wrote:
> Add I2C0 node for A83T.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-=
a83t.dtsi
> index 19acae1b4089..848cf3f19962 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -177,6 +177,17 @@
>  			#dma-cells =3D <1>;
>  		};
> =20
> +		i2c0: i2c@01c2ac00 {

Drop the leading 0, it generates a warning in dtc.

> +			compatible =3D "allwinner,sun6i-a31-i2c";

Can you add a SoC-specific compatible there please?

> +			reg =3D <0x01c2ac00 0x400>;

And you should order your nodes by physical address.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--7mew5amzvozgr3w3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlouMG4ACgkQ0rTAlCFN
r3SFSQ//SmWtanFavf2njXBSWdiV4WzofrO19jkgxy9m15Q2N6QsqlXG55CdFyWZ
YiH2PCVExuXs2g9011yDp83RcL3FxM/C9K17ouSw4F8DB+tCEHVB+KV/tlzTHXJN
XZ74+yBlFSnZA+T/S2s1j/cNU5sLIOE0O+E8unkhA30h52rGGB6A/UGVGY5iQFpU
+iu8UsFKWHueHxp/i+elXVjomGMXdImcSmnGczaIg9dU+hrtyPuEOdpGElMkOEiG
2Gsyy1jXsovlXgY3TDWPAdfQUWZiSmHnhXkE2hX6r1lRhvitdEJbtMBjhqGgb/OJ
kjtNEO7R9ktWkIomusLjBT1VxDODbdntPMClez4ZaUNPsK9hOyBQ9aG3fULeSLLK
wbqozA97PGAwq7pm32vM91inyfUbSoY1P3oYglK1O1NfVfCYTOn1o54WLoT4wiZh
Dc/AZASek2fGkxhqxn9IXw06lWkJsPo2HuQ3/wNuQ12KEngTNEBdC9KrsbZAUXSp
GeqcXPGnuEDkltT0ZC5saUg6ClGUqtJcWgd8Xrwaw5m750IYFbNJsFSPg6eUlktC
Cs254EEvsqMDJAdnMniIz6LgnV8WH/3LSAaf+ma6buaMek3ygk0JOWL9MnlzZNVq
VzUezZRsX6IpAMyoaC5ruEGwz1zgvnDzCEF4c/kv3dv67N1+N5w=
=0jog
-----END PGP SIGNATURE-----

--7mew5amzvozgr3w3--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
