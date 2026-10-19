Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB5E48E0C8;
	Mon, 19 Oct 2026 07:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396113; cv=none; b=fT5aYLPnUmrOzpYEsYrtbimEoWffAJPQdJx6MQ5ObJHN9j2jxrf3lJUyrskghat8rzNFzrzmxqC4F7b+mulcfHMNPVbKGKSrQsnYA/TPxJAjQ7xFZNFz1E+iYQVsqDmbE7WISJMx+5w3h61YpmYQO4htwB0WuaVleWprq3CTwNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396113; c=relaxed/simple;
	bh=HwvIyERcTboKVk5ALtRMpcsMVGSoX9OJsNLH4jPAD9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1gu5BD8iJwOlj27qu2zujujiUGqLplWr+mf2feSt1dNteFgoMa0dHHIB7OsdMdiroIbGx3WcpqqCphEv7AXwEoPfrOrQ1w2JYedqwLbfO2DQ2gvs/H+XES7TQYl7xheGi0JvlTx7Uhuzf55wop7ej0HkY5hJN+0NkJeE9KrIRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtLPwN45; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtLPwN45"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2171E1F000C5;
	Mon, 19 Oct 2026 07:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792396111;
	bh=UFe0OkQtMoIoH7uDUZIBKfcLV2DCg3uzYEgFzr/ymTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KtLPwN45x/L2gyztWYH+o//fEXM9H/MYD6fMyepvBVwvRxpM63Oe1mtD7RnWNwvOD
	 PKEQ7eFUw3ia0fL+NndH7UHvXplQUANE5tPcxlbsvLK0+3ul6LHr7rDt/UJR0MTfxC
	 iIbCqN5id65LYAbtMZBJziezij1wjne62DCBTdobHW9Kx+Y08JcahECxP+0Iez5iUq
	 xWVWAcHGJgMRAiJwPKLDnSmjTnFS+l/PaAst07LM+H64Hq6zKVBbeuUZNTM39pERAV
	 rdio4KXkGKzvRuOTGLnNkfQjrboZ0y9GGlyJ3FEM7UwaiYqkptp+QRCaJsSIT0p0KU
	 dXQtujp3GPwIA==
Date: Mon, 19 Oct 2026 09:48:26 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: misc - replace strlcat() with strscpy()
Message-ID: <atXHuHxCqqkIuV2w@debian>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
 <20261016170411.51025-3-shlomojune6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="do6dlx2k7e2qhtqq"
Content-Disposition: inline
In-Reply-To: <20261016170411.51025-3-shlomojune6@gmail.com>


--do6dlx2k7e2qhtqq
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Shihuang Liu <shlomojune6@gmail.com>
Cc: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] Input: misc - replace strlcat() with strscpy()
Message-ID: <atXHuHxCqqkIuV2w@debian>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
 <20261016170411.51025-3-shlomojune6@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20261016170411.51025-3-shlomojune6@gmail.com>

Hi Shihuang,

> Date: 2026-10-17 01:04:08+0800
> From: Shihuang Liu <shlomojune6@gmail.com>
>
> The ati_remote2, cm109, ims-pcu, keyspan_remote, powermate and
> yealink drivers build the physical path by appending a constant
> "/input0" suffix with strlcat() after usb_make_path().
>=20
> In preparation for removing the deprecated strlcat() API[1],
> replace it with strnlen() followed by strscpy() into the remainder
> of the buffer, as commit 34b228b739f5 ("HID: usbhid: replace
> strlcat with better alternatives") did for the usbhid drivers.
>=20
> Link: https://github.com/KSPP/linux/issues/370 [1]
> Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>
> ---
>
>  drivers/input/misc/ati_remote2.c    | 4 +++-
>  drivers/input/misc/cm109.c          | 4 +++-
>  drivers/input/misc/ims-pcu.c        | 8 ++++++--
>  drivers/input/misc/keyspan_remote.c | 4 +++-
>  drivers/input/misc/powermate.c      | 4 +++-
>  drivers/input/misc/yealink.c        | 4 +++-
>  6 files changed, 21 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/input/misc/ati_remote2.c b/drivers/input/misc/ati_re=
mote2.c
> index 8db2dca84975c..929163f52177e 100644
> --- a/drivers/input/misc/ati_remote2.c
> +++ b/drivers/input/misc/ati_remote2.c
> @@ -767,6 +767,7 @@ static int ati_remote2_probe(struct usb_interface *in=
terface, const struct usb_d
>  	struct usb_device *udev =3D interface_to_usbdev(interface);
>  	struct usb_host_interface *alt =3D interface->cur_altsetting;
>  	struct ati_remote2 *ar2;
> +	size_t len;
>  	int r;
> =20
>  	if (alt->desc.bInterfaceNumber)
> @@ -823,7 +824,8 @@ static int ati_remote2_probe(struct usb_interface *in=
terface, const struct usb_d
>  		goto fail3;
> =20
>  	usb_make_path(udev, ar2->phys, sizeof(ar2->phys));
> -	strlcat(ar2->phys, "/input0", sizeof(ar2->phys));
> +	len =3D strnlen(ar2->phys, sizeof(ar2->phys));

Why strnlen(3)?  ar2->phys should be a string, right?  If it is not,
then we'd already have a buffer overread in strlcat(3), and then the
commit should be reporting a bug fix.  This should use strlen(3)
instead.

> +	strscpy(ar2->phys + len, "/input0", sizeof(ar2->phys) - len);

NAKing this.  This is precisely what strlcat(3)'s documentation in
OpenBSD says you shouldn't do:

	Since it is known how many characters were copied the first
	time, things can be sped up a bit by using a copy instead of an
	append:

		char *dir, *file, pname[PATH_MAX];
		size_t n;

		...

		n =3D strlcpy(pname, dir, sizeof(pname));
		if (n >=3D sizeof(pname))
			goto toolong;
		if (strlcpy(pname + n, file, sizeof(pname) - n) >=3D sizeof(pname) - n)
			goto toolong;

	However, one may question the validity of such optimizations, as
	they defeat the whole purpose of strlcpy() and strlcat().  As a
	matter of fact, the first version of this manual page got it
	wrong.

<https://man.openbsd.org/strlcpy>

The right approach is to have a function that does the right thing.
There are two viable alternatives:

-  Write strscat().  It would take the strlen() internally, and so it
   would be unnecessarily inefficient.  Prefer the next one.

-  Write stpecpy().  It returns a pointer, which allows chaining easily.

Here's a viable implementation of stpecpy():

	char *
	stpecpy(char *dst, const char end[0], const char *restrict src)
	{
		ssize_t  dlen;

		if (dst =3D=3D NULL)
			return NULL;

		dlen =3D strscpy(dst, src, end - dst);
		if (dlen < 0)
			return NULL;

		return dst + dlen;
	}

This would need to be accompanied by a seprintf() too, which would be
used by usb_make_path() to produce a pointer suitable for chaining.
I've been working on adding those.

If you want to keep it easy, I'd do strscat().  We can modify it later
to be more efficient.  After all, we already have the inefficiency of
calling strlcat(3) now.


Have a lovely day!
Alex

>  	strlcat(ar2->name, "ATI Remote Wonder II", sizeof(ar2->name));
> =20
> diff --git a/drivers/input/misc/cm109.c b/drivers/input/misc/cm109.c
> index 353d3c1d347d5..d3aee3c498702 100644
> --- a/drivers/input/misc/cm109.c
> +++ b/drivers/input/misc/cm109.c
> @@ -685,6 +685,7 @@ static int cm109_usb_probe(struct usb_interface *intf,
>  	struct input_dev *input_dev =3D NULL;
>  	int ret, pipe, i;
>  	int error =3D -ENOMEM;
> +	size_t len;
> =20
>  	interface =3D intf->cur_altsetting;
> =20
> @@ -766,7 +767,8 @@ static int cm109_usb_probe(struct usb_interface *intf,
> =20
>  	/* find out the physical bus location */
>  	usb_make_path(udev, dev->phys, sizeof(dev->phys));
> -	strlcat(dev->phys, "/input0", sizeof(dev->phys));
> +	len =3D strnlen(dev->phys, sizeof(dev->phys));
> +	strscpy(dev->phys + len, "/input0", sizeof(dev->phys) - len);
> =20
>  	/* register settings for the input device */
>  	input_dev->name =3D nfo->name;
> diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
> index b1a0edcc49b4e..697813fb11da8 100644
> --- a/drivers/input/misc/ims-pcu.c
> +++ b/drivers/input/misc/ims-pcu.c
> @@ -205,6 +205,7 @@ static int ims_pcu_setup_buttons(struct ims_pcu *pcu,
>  	struct input_dev *input;
>  	int i;
>  	int error;
> +	size_t len;
> =20
>  	input =3D input_allocate_device();
>  	if (!input) {
> @@ -216,7 +217,8 @@ static int ims_pcu_setup_buttons(struct ims_pcu *pcu,
>  		 "IMS PCU#%d Button Interface", pcu->device_no);
> =20
>  	usb_make_path(pcu->udev, buttons->phys, sizeof(buttons->phys));
> -	strlcat(buttons->phys, "/input0", sizeof(buttons->phys));
> +	len =3D strnlen(buttons->phys, sizeof(buttons->phys));
> +	strscpy(buttons->phys + len, "/input0", sizeof(buttons->phys) - len);
> =20
>  	memcpy(buttons->keymap, keymap, sizeof(*keymap) * keymap_len);
> =20
> @@ -286,6 +288,7 @@ static int ims_pcu_setup_gamepad(struct ims_pcu *pcu)
>  	struct ims_pcu_gamepad *gamepad;
>  	struct input_dev *input;
>  	int error;
> +	size_t len;
> =20
>  	gamepad =3D kzalloc_obj(*gamepad);
>  	input =3D input_allocate_device();
> @@ -302,7 +305,8 @@ static int ims_pcu_setup_gamepad(struct ims_pcu *pcu)
>  		 "IMS PCU#%d Gamepad Interface", pcu->device_no);
> =20
>  	usb_make_path(pcu->udev, gamepad->phys, sizeof(gamepad->phys));
> -	strlcat(gamepad->phys, "/input1", sizeof(gamepad->phys));
> +	len =3D strnlen(gamepad->phys, sizeof(gamepad->phys));
> +	strscpy(gamepad->phys + len, "/input1", sizeof(gamepad->phys) - len);
> =20
>  	input->name =3D gamepad->name;
>  	input->phys =3D gamepad->phys;
> diff --git a/drivers/input/misc/keyspan_remote.c b/drivers/input/misc/key=
span_remote.c
> index 70cd6586459ef..f0f31f2823d57 100644
> --- a/drivers/input/misc/keyspan_remote.c
> +++ b/drivers/input/misc/keyspan_remote.c
> @@ -430,6 +430,7 @@ static int keyspan_probe(struct usb_interface *interf=
ace, const struct usb_devic
>  	struct usb_keyspan *remote;
>  	struct input_dev *input_dev;
>  	int i, error;
> +	size_t len;
> =20
>  	error =3D usb_find_int_in_endpoint(interface->cur_altsetting, &endpoint=
);
>  	if (error)
> @@ -482,7 +483,8 @@ static int keyspan_probe(struct usb_interface *interf=
ace, const struct usb_devic
>  			 le16_to_cpu(udev->descriptor.idProduct));
> =20
>  	usb_make_path(udev, remote->phys, sizeof(remote->phys));
> -	strlcat(remote->phys, "/input0", sizeof(remote->phys));
> +	len =3D strnlen(remote->phys, sizeof(remote->phys));
> +	strscpy(remote->phys + len, "/input0", sizeof(remote->phys) - len);
>  	memcpy(remote->keymap, keyspan_key_table, sizeof(remote->keymap));
> =20
>  	input_dev->name =3D remote->name;
> diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermat=
e.c
> index 754379d2625cf..dbf9f06f3059e 100644
> --- a/drivers/input/misc/powermate.c
> +++ b/drivers/input/misc/powermate.c
> @@ -299,6 +299,7 @@ static int powermate_probe(struct usb_interface *intf=
, const struct usb_device_i
>  	struct input_dev *input_dev;
>  	int pipe, maxp;
>  	int error =3D -ENOMEM;
> +	size_t len;
> =20
>  	interface =3D intf->cur_altsetting;
>  	if (interface->desc.bNumEndpoints < 1)
> @@ -334,7 +335,8 @@ static int powermate_probe(struct usb_interface *intf=
, const struct usb_device_i
>  	pm->input =3D input_dev;
> =20
>  	usb_make_path(udev, pm->phys, sizeof(pm->phys));
> -	strlcat(pm->phys, "/input0", sizeof(pm->phys));
> +	len =3D strnlen(pm->phys, sizeof(pm->phys));
> +	strscpy(pm->phys + len, "/input0", sizeof(pm->phys) - len);
> =20
>  	spin_lock_init(&pm->lock);
> =20
> diff --git a/drivers/input/misc/yealink.c b/drivers/input/misc/yealink.c
> index 560f895a00cda..1a3bebc8c3513 100644
> --- a/drivers/input/misc/yealink.c
> +++ b/drivers/input/misc/yealink.c
> @@ -812,6 +812,7 @@ static int usb_probe(struct usb_interface *intf, cons=
t struct usb_device_id *id)
>  	struct yealink_dev *yld;
>  	struct input_dev *input_dev;
>  	int ret, pipe, i;
> +	size_t len;
> =20
>  	interface =3D intf->cur_altsetting;
> =20
> @@ -891,7 +892,8 @@ static int usb_probe(struct usb_interface *intf, cons=
t struct usb_device_id *id)
> =20
>  	/* find out the physical bus location */
>  	usb_make_path(udev, yld->phys, sizeof(yld->phys));
> -	strlcat(yld->phys,  "/input0", sizeof(yld->phys));
> +	len =3D strnlen(yld->phys, sizeof(yld->phys));
> +	strscpy(yld->phys + len, "/input0", sizeof(yld->phys) - len);
> =20
>  	/* register settings for the input device */
>  	input_dev->name =3D nfo->name;
> --=20
> 2.43.0
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--do6dlx2k7e2qhtqq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrVy0MACgkQ64mZXMKQ
wqlUZQ//deuCQGNox42bGafpkmWhvIKhu/fXy9q79P/UJIslTrRblWKaYgfEMkZm
qA0ZSvG7IBr6O8FL7FSe5gUDJ+TEneE8b3xzYYsqlgKl9gQcdtvXEHudSH1fePBr
PtdBD05LNMWbnEvd4RLM5/JSA6Dv1Z5k+NJ6YHJbfcvvdnHwEsoz7GYqcbKmqJiR
ZZLMpBcCPp0EubIHvod15e6nCkw1E+skQSgbrFSo3L5ujPkAirc07RB1jSvk1Pax
BX45AoEfIFRdvp9BQ7F4rT13gLFZK0JGIiYHsAmagDoxBD15S3ulUcAkShgoWuvs
Xcz0ukRbrIxRdv9sJ+HakOhA0O94I0BOLQwIgz4TRc+DYd9E8izF2c5BPhIDXAjv
N3ozMJn5XIJVM3SbzP1Flfc/e9K94s7z7OJRsg3hEHt/0Yak5fxVgTJfZBtyG+u1
X2v0ErXjIOkpHpT7m2nc+/wM628SBj2QJzUMEP8X4tIzNxhKne/uAgGIU2BSAWrc
krk5PrKmk64njRYMr9nVH8KN+t56X1y5r35d1GtzGbSl0eeJJDvNqvlI9SqDKGjN
VU8OtX3aUfW9ngHi/iZJtXlfpkmfvUqWTQFwd8JAB57c2E23YLamhXypetvhrPOT
uI5HU+sSUiOBJFdTn2JEZKNF4aKRHkayGv8l/uW+JO1QkJUos+Q=
=aYCm
-----END PGP SIGNATURE-----

--do6dlx2k7e2qhtqq--
