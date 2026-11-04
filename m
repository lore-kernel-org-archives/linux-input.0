Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791270;
	b=bG02A5eIz8uF+QgziEbLm0ZFDQgyc+5pbupgcSBfeyw/V0OBu7i0feJAzTTVJ7y6PghZ
	 wGUgDp6OXSeOJljNUJuUtdcDaecwDZHRcvPUjAiHj5WpF4cVNlNReCOJDLmBqhfCULtxi
	 2/35w8TB90ttyKtPzI97qxpL7PJSUe1svF0qLKGLluhqHYrzMWEnunxCDWMhDvAnIrxB5
	 BGccZ9LQ0C2WG5RBw9zcory6Dot4qFU7oKnbhYOUfUhJ0JMlKKcihZNXnfsWsnys+fWXz
	 u8Nv4AicsHoysy8J24eEYg4kd1bCQKOVaVJcOkgHDUjbdHUESKkgDV0BcLtZGMsfQJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791270;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4dVe52eKIL/Wm59MN+NsZYYyw2EDEGnNvFkS/L+MVsE=;
	b=OGgd7hiljqom5HSD9vaYB+ZSsn/prIxvQ78dyxjDXGnhW4tMKhW2U3XkJssyxV62QoDu
	 56VFbnGfkehY+eSkS0nqi/M5naJRprjcrXL9Hegn/JZEiUlSBwUijUetMbh5QS+awuk8n
	 wrA4IqJaRmZfKrWwqPw4lEdxvCux0bt2egZRkqjOcMMSkIzTCVCQki8ai7k/ktuciht5R
	 ssFsZX7p7Fzejv/m6zt5RmqC7b1UnFlQfXceRb765BVUukPOdLFSnzV0TT6iIHD0pHhIp
	 oOh2mT5lgm9DfGH7lLEvEh+ZMn39EIyXY3H+lLRZKX8vjShP34RvzpdNBGhbPwx6bGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avReivgF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D724606A31B;
	Wed,  4 Nov 2026 11:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=avReivgF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A891F000C1;
	Wed,  4 Nov 2026 11:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793791270;
	bh=4dVe52eKIL/Wm59MN+NsZYYyw2EDEGnNvFkS/L+MVsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=avReivgFtI14XS6r47cDCZGUjiJF2p9T14/LJ4kqbxL2/hC9gPn2HcUEERj1AZlc9
	 ARm8VPIlnkR+DDAj0edF3x8BKdGIpjEZ8V5JCDsYe24UCNnpRP1MaPUqQX2rdV3007
	 RcFDXumcgoJrm5EdJzQmiF3VltiYVzzd3G0TGIe0kZ7HV1TQp+fmtJ7poKeZBhO0Zg
	 vhNcU1P4Ppk5cKhnu9jcB0wI6mbi58kYWLw40ItFqvU8bPwHlI6mGz7HnGPXq8FxGg
	 afhGqp/DZ5CC8M1rP+e/2AE3nttlmoXvEgNY8xIXOlfRGAq2D5uQX/vSnNDoRaA6DG
	 QrB6S345tyykA==
Date: Wed, 4 Nov 2026 12:21:06 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <ausU2w4G7qluP0FU@devuan>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
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
	protocol="application/pgp-signature"; boundary="pp3a5jmmznjqn6wj"
Content-Disposition: inline
In-Reply-To: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>


--pp3a5jmmznjqn6wj
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, kees@kernel.org, 
	justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <ausU2w4G7qluP0FU@devuan>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>

Hi Mariia,

> Date: 2026-11-03 22:23:18-0800
> From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
>
> In preparation for removing the deprecated strlcat() API[1], use
> strscpy() to initialize the mouse device name.
>=20
> The destination is zero-initialized, and the constant string fits
> within the buffer. Since the return value is unused, this preserves
> the existing behavior.

Huh!  Indeed, it was very weird that it was using strlcat(3), when
strlcpy(3) would have been okay.  The commit that added strlcat(3) was
obviously confused: 08ffce4560e0 (2006-06-26; "Input: fix potential
overflows in driver/input/mouse").

>=20
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>

Reviewed-by: Alejandro Colomar <alx@kernel.org>


Have a lovely day!
Alex

> ---
>  drivers/input/mouse/vsxxxaa.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxaa.c
> index 042a17fe81db..b3a0d7ff5738 100644
> --- a/drivers/input/mouse/vsxxxaa.c
> +++ b/drivers/input/mouse/vsxxxaa.c
> @@ -463,8 +463,8 @@ static int vsxxxaa_connect(struct serio *serio, struc=
t serio_driver *drv)
> =20
>  	mouse->dev =3D input_dev;
>  	mouse->serio =3D serio;
> -	strlcat(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> -		 sizeof(mouse->name));
> +	strscpy(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> +		sizeof(mouse->name));
>  	snprintf(mouse->phys, sizeof(mouse->phys), "%s/input0", serio->phys);
> =20
>  	input_dev->name =3D mouse->name;
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--pp3a5jmmznjqn6wj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrrFSEACgkQ64mZXMKQ
wqnq6w/+IBkkiue9TgSvhdK2C325RbtJzKEnFVjDUUCmQL/iD0TG2FfdeCJmGCn7
rLi8Rx0NzAUEzW4fWasZyNEWz+xv+wNV1Drwc9bZK1oqOnuDXonUjYsVdGZcnWCd
UQTUE/EgAkdLoMCkDBUcOe+Qrdt7ASCBw+MuQmrX7NMT0Jm9fiXQN2bND68hM6Ts
zWEBA5HH+z9OzcDIEftpt3qC8TzLCJCdXE/z5lkhBllROUFg1Ps++Y2Xv2c+oggv
2Xs97BU4BlBZugQ8fCiNM2/XQuSW52kpbHOOAk3OIp2B2Yn9DrwXrc5eVZQVNJqr
CHX19j5yQAHYxwH2I2JXvMQCuEuuFioXiUzKn8laSl4jYX3S+One/QPuHhoowtDK
sTMbuvlkPJS0sf8JIA9CtxgnEhsIC39LdLkmuDa09P7I8nwXm4e2+YzhQ6p3hMLZ
lTfwx35Dwu348p9WzMGWM0MhqnPKs4IOT6HfkpNueqIYIdh0/5a+huxwL05LXnJs
YEKXe8MgX+5Z/4qVZvTQr2YTuUKcUaFen/u8OmEh41egm2HKfgFqyvJRPgbWpM4I
mBOQt8h+8/6GXEq9JxS2I/DPA5v74j87FZkLr/jbwP/F7NfGbeGnBEc3+SUEUwA+
TF6HPEamC2JQkdbHTy933sPBh+iBaHiF08nX+HVUAAsAlfGgpvg=
=yi8L
-----END PGP SIGNATURE-----

--pp3a5jmmznjqn6wj--
