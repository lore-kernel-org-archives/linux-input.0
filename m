Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588897;
	b=3p1tODEhjQat1Yl9AdAUuKDisqnFMC1Dya10y+k11xpV5YU3h/X3PyaGtpAsh918u0B6
	 pD4icNtesNVtuBl/y0GkGHg0Zz+GFn4jOzEGNYmmgQdvF3tXqWRd4t9/ApD4JNJ+n7OQa
	 In/Q4n9GrtuEg1FzjOauVoxYjtAg+nRlWppxd9v3q4z/MMQIbC/7A2II1z1phtqGhllZg
	 OqvWKnJMwBj/OWxHM74WmnGWBvuOzwqeGvu3BBQKJWXEnVm/haXU9hv8U3QkrP+C9XDYa
	 k9kMStvl8Fq9kPDOg2Q8+OQXcoLMstjcq/GPJonwSNe5SQLI6Etj5IxI/k/0UkHCqQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588897;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=x4h5kE+S61gNfgfp7dSlkNy6fJzrNZu9bf6ZqONC3wM=;
	b=z/XYPEvuF+h5h+A9QJeuH5qwRvU30s1g8zU1eiCnN4FASCz/tfJpiBhr1nQq+yWCzIwz
	 RCI5AsuB7sEls0opSQSBTsfifB9Vcbv4NzKPWpzvuJpPl66G74ZvtAiCRbLzzBQXNhutv
	 p8v3v4XUvGgTrPVON7CeZm9wfPWF8WFWvTNOkC3g5pRP53VhdXKb80qvK/j5OktuM1eiw
	 KqO8bnanUp7fOCPwRJql5Rpo3a7kUgb/rBjU28lh7Qbk35OaXir+DpoVVdVe6JPzwazXS
	 Tx1/inUUlu/8goZ2sgtBaXEPhxRi8La/eTVEPtTOJh1JiHUpuFInJpznNSLIuNpT8Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOz5EhnZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2054A606A319;
	Wed, 21 Oct 2026 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OOz5EhnZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 750441F000C4;
	Wed, 21 Oct 2026 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588896;
	bh=x4h5kE+S61gNfgfp7dSlkNy6fJzrNZu9bf6ZqONC3wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OOz5EhnZ2xah57azAtoOqNsETu4shI1NQAjIinIFdZGbAwwrgiDOIsAmsFnkat1sW
	 fNAT5xuovv58yZkuF01AUBAXOkzvjeQwrFuYs0bqJr38qOClaNyPuJ+tha5HQTWNb1
	 arJzOUPvCJNIPxDv5vCYwFmMziolJXkIhmH+iT7n8+VY3e5M9WmFFEXaf6LNP28G2t
	 5u+aWxfH1VwXEFhOEcUeQSfawIE1lJAX8FhzbOgTYE39BY5SNzAGBoNyYpCpXN0P/V
	 a4ktOrRX/ratIMH8gv7xiEG7iUcUJ/ZvQYaaVa6FxZTR1K8RSvEJgMmHMhf8YjCF2U
	 +Fe8AoUyXrRhg==
Date: Wed, 21 Oct 2026 15:21:28 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Message-ID: <ati7yINv0_Z3yPMg@debian>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-3-shlomojune6@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vv2co7kgh7mconel"
Content-Disposition: inline
In-Reply-To: <20261021123146.17202-3-shlomojune6@gmail.com>


--vv2co7kgh7mconel
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Message-ID: <ati7yINv0_Z3yPMg@debian>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-3-shlomojune6@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20261021123146.17202-3-shlomojune6@gmail.com>

Hi Shihuang,

> Date: 2026-10-21 20:31:42+0800
> From: Shihuang Liu <shlomojune6@gmail.com>
>
> The pxrc and xpad drivers build their input device physical paths
> by appending "/input0" with strlcat() after usb_make_path().
>=20
> In preparation for removing the deprecated strlcat() API [1],
> replace each pair of calls with usb_make_subpath(). The helper
> formats the USB path and the "input0" subpath in one call,
> avoiding a separate buffer scan and append operation.
>=20
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> ---
>  drivers/input/joystick/pxrc.c | 3 +--
>  drivers/input/joystick/xpad.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> index 52d9eab667b7a..1a11e73d7cd04 100644
> --- a/drivers/input/joystick/pxrc.c
> +++ b/drivers/input/joystick/pxrc.c
> @@ -169,8 +169,7 @@ static int pxrc_probe(struct usb_interface *intf,
> =20
>  	pxrc->input->name =3D "PXRC Flight Controller Adapter";
> =20
> -	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
> -	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
> +	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");

To be honest, I think the composed approach is more readable.  You don't
need to learn a new _subpath function with all the details it has.

Everyone knows what a str*cat() (or str*cpy, FWIW) function does.

I'd rather improve this by adding strscat().  The reason for removing
strlcat(3) is that it is vulnerable to DoS, and that it is inefficient,
but it is good at producing readable code, and a replacement should not
degrade that.


Have a lovely day!
Alex

>  	pxrc->input->phys =3D pxrc->phys;
> =20
>  	usb_to_input_id(udev, &pxrc->input->id);
> diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
> index feb8f368f834e..0f7ca5adaeee7 100644
> --- a/drivers/input/joystick/xpad.c
> +++ b/drivers/input/joystick/xpad.c
> @@ -2059,8 +2059,7 @@ static int xpad_probe(struct usb_interface *intf, c=
onst struct usb_device_id *id
>  	if (!xpad)
>  		return -ENOMEM;
> =20
> -	usb_make_path(udev, xpad->phys, sizeof(xpad->phys));
> -	strlcat(xpad->phys, "/input0", sizeof(xpad->phys));
> +	usb_make_subpath(udev, xpad->phys, sizeof(xpad->phys), "input0");
> =20
>  	xpad->idata =3D usb_alloc_coherent(udev, XPAD_PKT_LEN,
>  					 GFP_KERNEL, &xpad->idata_dma);
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--vv2co7kgh7mconel
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrYvFgACgkQ64mZXMKQ
wqnfLA//TQzUh8oI+7WSy72n9mO3Ix+vhVOXV8V3j/V8xW2Cn8UIThuVaS8vkM1m
uCtMjHTg+naQRMPW60rIsneuky/TWUE6TM8s1zWYx5LSbdXfRGi6ymsKAQZESkMD
zzNBFPJSWJwbEcY9TM4J3xQJgUyWPrNLRzYD4WXtvOHFOyeWKaOH7NS0SpLIzx/k
7Vegs/XT5Cij9twaM3NC+2xTlwbzxQptBKQ3GSsSiTSaxe/UUjKMzpDguSadXUvQ
rdOlyOUNgCUFmikzH8N53optE1Srwvf4hzAOpn1OSBZp0Mv1P+ww8rqqvmQqDzel
QoOISoeyRZ3U7rE8LZMpKeA9++fKeMFB7Ht8ky9qB0n3uTdTW096bKRtbdn6gL7q
gOrPpBLDuSUo2lRa98CMdmR+ieMDFINHsByzjDCa1S5eT6oSdkRMoe+e7jshzkS7
zcgOBzzNx+R6PYFYh+EhadR7bXZMUrybl8goP6um2iFrD8QWesL18eu4GZqd6bOf
8/S/3aSnPwuBCGRUrSvtkLVcUTHek4s2JKbcWUCtDHwqo+L24H41KGY6ImJdWPR7
SQqmFPVQHb3hxbm5+IXm6m+CCxVUH9vxjuvlDPv/a0Jt16aalHydqfD074nRIzsj
yk3jsnOLhOdeshLM4BER2AOHL2tiBrNuWQBa8pZFMUs7fTFMYCc=
=b1h/
-----END PGP SIGNATURE-----

--vv2co7kgh7mconel--
