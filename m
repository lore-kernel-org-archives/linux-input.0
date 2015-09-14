From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 6/6] ARM: dts: set up trigger type for edt-ft5x06
 interrupts
Date: Mon, 14 Sep 2015 16:24:26 -0500
Message-ID: <20150914212426.GA9968@saruman.tx.rr.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
 <2adcbfd1d5b237598d37edcbeec4a8dbd443f36f.1442079408.git.dmitry.torokhov@gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55641 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751357AbbINVZT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2015 17:25:19 -0400
Content-Disposition: inline
In-Reply-To: <2adcbfd1d5b237598d37edcbeec4a8dbd443f36f.1442079408.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Franklin S Cooper Jr <fcooper@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2015 at 10:45:51AM -0700, Dmitry Torokhov wrote:
> Now that the driver respects IRQ trigger settings from device tree, let's
> fix them up in individual DTSes (note that the driver is still compatible
> with older DTSes).
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  arch/arm/boot/dts/am437x-sk-evm.dts   | 2 +-
>  arch/arm/boot/dts/imx28-tx28.dts      | 3 ++-
>  arch/arm/boot/dts/imx53-tx53-x03x.dts | 3 ++-
>  arch/arm/boot/dts/imx6qdl-tx6.dtsi    | 3 ++-
>  4 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am43=
7x-sk-evm.dts
> index c17097d..d83fdcd 100644
> --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> @@ -471,7 +471,7 @@
> =20
>  		reg =3D <0x38>;
>  		interrupt-parent =3D <&gpio0>;
> -		interrupts =3D <31 0>;
> +		interrupts =3D <31 IRQ_TYPE_EDGE_FALLING>;

for AM437x SK:

Acked-by: Felipe Balbi <balbi@ti.com>

Seems like there are no changes considering driver was always using
IRQF_TRIGGER_FALLING.

--=20
balbi

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV9zsKAAoJEIaOsuA1yqREr4YQAIOiMHv5lyPytZQypFVO9xgy
8nGjrXg/ewp4cdEbWTUA5U9blFk+/eFt6MEYK8+5enCsTTV952mjGh/To6L+sei9
pqqVW6giDg7IUawnCwtwDysgotM/Ry3K5KaghSugN0gisgSdndgtTV16lRsR8BCO
z2zmAHRtVRz56/l54LgA+jYaLtnuu049be/1722RGTHckCFEPe40CKNfut0wN7hq
v9MEXZbYjSkcKR1RGq4f7JzqEhFFLt0qF3AtyFH5o3eNebV0fHAyh5PEIyTXQRvf
bDAgg2tmCqWRmamWFXiD3ki3dGJPsfvoVrx2fd9KGpuSO3urufZobHlOG1GOyQUn
JQ5jzMyoMScSZ3Uh8CkLfU8VSndk11qE12NtPZFNtK2ftg1pIf4fsjMuShPiMjXk
pPUa0+ZUHxOb2VRVP4ckNbYru94ZPSZo/DujdMobo4NqTSUh10JpeYstcM9wrnyq
8JwJbzvSrAMt0iREiPOdHXsCtCapVaKIF8AsoT0462dSliFhzCC3VsBk8ZShbVS6
vj5MGT4MWpL0255mhsBEYNPRzvqQjRpI6N/7YMk/M4K1C7ayvN3p0ugB3BBDQ0Zj
VYvxMtGSCikw4ASPLGhNuRV5zGlIYnGaWlxRHzBpZjywx+j28q3V44cim/YHBT7K
j/nryKg5grdGuDsdVO3c
=rSt+
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
