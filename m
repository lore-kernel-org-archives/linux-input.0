Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794518499;
	b=fEK9+Gn3VdL8QqNHofe0PxzaoyLSeZSukPEOzXNVa/wx+nTFzbPLfzcP1iwngvYGkaeL
	 BkFICXgGx6bwTL/wevdqXK2kar+j044LoHIFqIN5hzUpY55RrrjplLpZ2m54B6rajV6Bm
	 hxoSG8Gb8ZuLlp2c5osbem4K37gAJe/sCKG4F33KMjGBtKoJQbh+9ep0iZ5CfbRW+NNJX
	 ZLmZQP2rvqjCq1jalwuE7Q+4Uv3IrYM+64LMlnHRyNIv86yL3zWsAc16t0inneyqFAchQ
	 mQe6TnS6qsQ/XPSHx+giipg6Zokm9JgA7jaLClz0QcDFC/LicvrFL1pJRl2riFM+vSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518499;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4eqgGqhIANhj0nYQ+5ubzZJVoiDxk2sGBwrmrqN3BXk=;
	b=tLx1wApSlg4bJUO9uf7C1C6rTkQcmjVy/3wNE7gUhlfRup/6J61ABW86KN47alzidxBE
	 ZUIQRJUcu22Lcc0FqYDttD8u+qTxr0wxJncJIxYRUjwXf3ThepgRBFWFTkl4phoyp/rQf
	 XIAYOHaLvnsZ+Tk/jpt0mhK1DEscNAa2v4sciIsjqZcCXDAaafZFXto9U7Zw6EUGjJvt0
	 KperC5PKeLQl9olOW9OWgLavs5/LweGzd750dD9IyQeFCJWRHipJPIOoB4XuIBs8YivBu
	 HAaClYzu/u3lDr/eK5xegBUenzflQoXzH5AudO7YB2m+UiZDu7RGNu2pFMYA0gws/Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVPMOnnS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3E8606A31C;
	Thu, 12 Nov 2026 21:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVPMOnnS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1061F000C4;
	Thu, 12 Nov 2026 21:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794518499;
	bh=4eqgGqhIANhj0nYQ+5ubzZJVoiDxk2sGBwrmrqN3BXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UVPMOnnSNBD6Ajg0ijIcJ/fQ8stFM0AIVKJJH8IDsiZzZTe1bjDhpTRO5gjXfWZBy
	 tbLgVlsFFdOtWlI1fwzMngfZmTXoyQUp4+FtjDCsrCBUiyWE6RtU6djOT5soTVPhGA
	 z44Tp1slG9Io7EsVPtphu9+vrdqP0A53Tjq4L1PfJ+FlX1pkKc8FT0cZZ0bZqc6GBy
	 wITMK3Q1uR84p33Ib10kpe1TTxPhoQW6RBCpR0nS/yS91mkvisDMNkWIjQdNKlOvM1
	 eKyE1FzJrh8kpbv13WGkXCVVNI8I+nhzttgq4ZQF3nL95sU0Ih44GzsaTp87Atdg80
	 vB+ANY8QfWfUA==
Date: Thu, 12 Nov 2026 22:21:35 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Mariia Nikitash <nikitash.mariiaw@gmail.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, justinstitt@google.com, 
	morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <avYtm-vs_V0dPfyR@devuan>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
 <20261105112813.13210334@pumpkin>
 <202611121026.23C58B347@keescook>
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
	protocol="application/pgp-signature"; boundary="ahzol4ylc7553tv5"
Content-Disposition: inline
In-Reply-To: <202611121026.23C58B347@keescook>


--ahzol4ylc7553tv5
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>, 
	Mariia Nikitash <nikitash.mariiaw@gmail.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, justinstitt@google.com, 
	morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <avYtm-vs_V0dPfyR@devuan>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
 <20261105112813.13210334@pumpkin>
 <202611121026.23C58B347@keescook>
MIME-Version: 1.0
In-Reply-To: <202611121026.23C58B347@keescook>

Hi Kees, Mariia,

> Date: 2026-11-12 10:27:58-0800
> From: Kees Cook <kees@kernel.org>
>
> On Thu, Nov 05, 2026 at 11:28:13AM +0000, David Laight wrote:
> > On Tue,  3 Nov 2026 22:23:18 -0800
> > Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:
> >=20
> > > In preparation for removing the deprecated strlcat() API[1], use
> > > strscpy() to initialize the mouse device name.
> > >=20
> > > The destination is zero-initialized, and the constant string fits
> > > within the buffer. Since the return value is unused, this preserves
> > > the existing behavior.
> > >=20
> > > Link: https://github.com/KSPP/linux/issues/370 [1]
> > > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> > > ---
> > >  drivers/input/mouse/vsxxxaa.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxx=
xaa.c
> > > index 042a17fe81db..b3a0d7ff5738 100644
> > > --- a/drivers/input/mouse/vsxxxaa.c
> > > +++ b/drivers/input/mouse/vsxxxaa.c
> > > @@ -463,8 +463,8 @@ static int vsxxxaa_connect(struct serio *serio, s=
truct serio_driver *drv)
> > > =20
> > >  	mouse->dev =3D input_dev;
> > >  	mouse->serio =3D serio;
> > > -	strlcat(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> > > -		 sizeof(mouse->name));
> > > +	strscpy(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> > > +		sizeof(mouse->name));
> >=20
> > You might as well use the 2 argument form.
>=20
> I'd agree: this is a true array, so the sizeof() can be dropped. But
> it's also exactly the same binary output, so I'm fine either way:

Indeed, the 2-arg strscpy() call would be much safer.  I'd prefer using
it, since we can.


Have a lovely night!
Alex

>=20
> Reviewed-by: Kees Cook <kees@kernel.org>
>=20
> And I echo the surprise over strlcat being used on an empty string. :P
>=20
> --=20
> Kees Cook
>=20

--=20
<https://www.alejandro-colomar.es>

--ahzol4ylc7553tv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmr2LdkACgkQ64mZXMKQ
wqlb/Q//Z+6oJ6b4j7TzZmc0/KZODa14tNbJCvi4tcZTLjMM9TBSIC5RD8NdQNac
Y3ePfMFpvVnwmlRjl/pSkHH+bj6+IW4TP9BD0eT/DSG2x/LlUp1cO2+IBz9R2KZL
H5A33gGL43Rmw80rJZWHctuqS+w1tzVv/9QA5bgUqkDsGok0pgdpZ1iw9LkIVzR7
xPHxni0VR3sRBwWTisKnY37O2Io5QnWhHqU6SF0kx6JyqOUQQIRYt7/RcBxP4XPO
+tvvUxCvAbckY57k+uEwo1hF56sWhSBQOWX/4rfegox/74NkWrB8qrhSzXmNUBCu
Ptjg7CVUgL0EkJ/PisFsK5aJK34UJkTLBqctbcyUYvPjHzrlaugYD2yBmexacket
aAYLCGatrRzx6SnFBe48FFyavPZy+RpmN9B2PvmLrRv9b59t6xOl5zzl4bYueOen
OrCWJ3xkNoFS/uv12lOVq/b8g2kePxnUdBRIx1+LZfqssAh9UepkLFE5oh2TT2pf
rofdPWFWUUe+c7dXENeBTcIV0fJxbvI5Ed1conjA9mxKlOO0qT3dJB8FMR323kba
mNIzKeexa5Yc/D1iLNDYcbiCBAk1WzyXlKZvvvEqa6dkIMmvVleJ89pEh5oN891p
pjb/XXRRYQzwpjFFAUVJMxq/zFa+epmbXWAAY4ZavbwgL8/YkoQ=
=a/wb
-----END PGP SIGNATURE-----

--ahzol4ylc7553tv5--
