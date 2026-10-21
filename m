Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792588685;
	b=BGKbdxeBVJ6jbFYj5fIVv8P1ObujPCF9Mh+IOB0A3TCQLKWSDyHPMYCU8VbXNhirNBWn
	 WtuHuQyLjZmi0HgxfHIUCs8hZ0x+pqyb2dN+s4Fg5ldS747XTpgn1j8f9XLacG/LWt3qS
	 sA0jnljgPd8kZ1ftXAlmZYAgjEyQCRBbp4uAB/Hmbt5eqsxkXkouZ6RrP/roIdkpMba+v
	 zX5xd/ONC2pIG9iCJhM2ErKn6VwquWH5xDPb5c3CGW9oA0/0hrbIt6jHk05GMtDaMelgx
	 w1bJ0CC6xXAjKh5GtN6wL4qZvQrGCDAOOBccvrJweJfj01JkZIdq6CLyJrg4ZxZqIsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792588685;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=uP6ALv8m4b+dkPS99FBOBMEFTwaHIYfJnx0Qeznp9+Q=;
	b=C0YtfZHSka54gVmKNCEnAViqkkqjTJii6DGiFqAZETpzXLE4P9CFhjmKEOYCeKqwvs7H
	 acxuroOZxL+yzUJ8nIdP0xo6/mT2ytxhQxMmvUm2d4EODi/QxiggJAGPyTvRKHxOlKh4h
	 QTvhxZQdzdGJ+ywqBLpGzSTLwy1bc9AY49gvDPYAvMXKvi2TydizeTwT2Xu8i6YBQ+2L8
	 3k5DXY+AClNPiVcAy1P2tNt0Cb3PqwB9Hd9i46NTqVNGbcpJWFEDXowYy4JMt3Ne/wmKf
	 D1yCorm2wZvQriviDot/dDzyu2S5FYS5Oovb3AGGjCLNS6uJ5e4OKY4uZVq6cglOtUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXvp9dE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006F8606A31B;
	Wed, 21 Oct 2026 13:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HXvp9dE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A28A1F000C5;
	Wed, 21 Oct 2026 13:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792588684;
	bh=uP6ALv8m4b+dkPS99FBOBMEFTwaHIYfJnx0Qeznp9+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HXvp9dE1dD9ZY7ekVL6x64HjLGGj8M5yvnCnycv7SLMa3FtEh2skwBKvZLWF1AhS9
	 5wgMJ9qnoLCHc2Yhoa9Pl0fP4M3zD987YY/vw7DoflPAVghPMSnD2Cewf7yZ1CjnDd
	 CMBxOY8TRR65xjMZ4TXAMp3jyK2sz9YLssw+aa0c2PxW4dqEuRW9LZLhlt0HDtLwCs
	 JmtHWovOKrKZTEVKIPPCMJJ1kR2CpaDD/MiNfUpdWm2WEe/ppJDEGGKT6hpz6JTq2w
	 o5Va29QWBRV2rt6d1+9uyS6L+uDHZTs075BrekpIc0fxMIZQgkU8MTPR7Zpmf8OHpv
	 VsTdVWcm5Siuw==
Date: Wed, 21 Oct 2026 15:17:56 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device
 subpaths
Message-ID: <ati7RlrVvmzMjzNr@debian>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-2-shlomojune6@gmail.com>
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
	protocol="application/pgp-signature"; boundary="fpxw4ogerp5lsd5f"
Content-Disposition: inline
In-Reply-To: <20261021123146.17202-2-shlomojune6@gmail.com>


--fpxw4ogerp5lsd5f
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] USB: add usb_make_subpath() for formatted device
 subpaths
Message-ID: <ati7RlrVvmzMjzNr@debian>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-2-shlomojune6@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20261021123146.17202-2-shlomojune6@gmail.com>

Hi Shihuang,

> Date: 2026-10-21 20:31:41+0800
> From: Shihuang Liu <shlomojune6@gmail.com>
>
> USB drivers often build device paths by calling usb_make_path() :and
> then appending a subpath. Several callers use the deprecated strlcat()
> API for this.
>=20
> In preparation for removing the deprecated strlcat() API[1], add
> usb_make_subpath() to format the USB device path.
>=20
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> ---
>  include/linux/usb.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>=20
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index 1da4ad1610bca..c90ccea0cdbf6 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -14,6 +14,7 @@
>  #include <linux/errno.h>        /* for -ENODEV */
>  #include <linux/delay.h>	/* for mdelay() */
>  #include <linux/interrupt.h>	/* for in_interrupt() */
> +#include <linux/stdarg.h>	/* for va_list */
>  #include <linux/list.h>		/* for struct list_head */
>  #include <linux/kref.h>		/* for struct kref */
>  #include <linux/device.h>	/* for struct device */
> @@ -987,6 +988,34 @@ static inline int usb_make_path(struct usb_device *d=
ev, char *buf, size_t size)
>  	return (actual >=3D (int)size) ? -1 : actual;
>  }
> =20
> +/**
> + * usb_make_subpath - returns a stable device path and formatted subpath
> + * @dev: the device whose path is being constructed
> + * @buf: where to put the string
> + * @size: how big is "buf"?
> + * @fmt: format string for the subpath, without the leading slash
> + * @...: arguments for @fmt
> + *
> + * Return: Length of the string (> 0) or negative if size was too small.
> + */
> +static inline __printf(4, 5)
> +int usb_make_subpath(struct usb_device *dev, char *buf, size_t size,
> +		     const char *fmt, ...)
> +{
> +	struct va_format vaf;
> +	va_list args;
> +	int actual;
> +
> +	va_start(args, fmt);
> +	vaf.fmt =3D fmt;
> +	vaf.va =3D &args;
> +	actual =3D snprintf(buf, size, "usb-%s-%s/%pV", dev->bus->bus_name,
> +			  dev->devpath, &vaf);
> +	va_end(args);
> +
> +	return (actual >=3D (int)size) ? -1 : actual;

Why are you open-coding usb_make_path() here instead of calling it?


Have a lovely day!
Alex

> +}
> +
>  /*----------------------------------------------------------------------=
---*/
> =20
>  #define USB_DEVICE_ID_MATCH_DEVICE \
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--fpxw4ogerp5lsd5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrYu4QACgkQ64mZXMKQ
wqkPNg/3U1a2m9q8Hnb/Yse0fQn7S7KsAc4hL0Nvp6DFn1XH2PNP4+fId7JuAgqL
GrckdDFKvNdtlNVF8kGKM9Lg1EX2D/sa/2QVhml7golGBGVWJ+OV/DGvxZbSz5iy
1Lj/E2t8HTzcBXRpT1rBz3P/c2RzwBrcx5+PMBqsCkl2hmaduIPVtNxufnbe3U58
LBxP64zXQtHN32nzBOqhoWFszNo5GdgzyniqVXRHRu6CVlBcgS/u5aUWzfsh5mY9
bBxTVToRKvqHKE0vV8QTYDHOgXtdGZcJ9cMPyTREn9UmR0IDu0SCNIKTWDwXj5Yr
JC8XURzZPYqD6YV4W1UMLvUBT6aMUSFC/HWWEVggM96T6urDge1Fhh9FXCHTSF+k
kKOzup0kBl1vrRvi8zNx6DMQ4FBt9QYpLNu+oNaNHAMCG1/vH2AW/hlKdZg86e1Y
RGaYQNU+gOW6z+OVb7DITJbgJ1LSfET/p9rcbxh6OSirWIT4Gwa7D4/e+5OVo1dI
YfUaoqqENbI3SI7qtO9nrzjwVG2yg4clzEIiNnEun5bsovFBiRwOIGN+1MkUvOqX
t5ld5R0sUzfHBdQCOUINj6P955tXOGL9r6PYwKe+RZLiqcGs1dgP/4KsABx2iD9V
OAFkUjlIPCLjeCxZKRDStzz4a77xm+J4VuchipCPRLilQfsJdw==
=ilT9
-----END PGP SIGNATURE-----

--fpxw4ogerp5lsd5f--
