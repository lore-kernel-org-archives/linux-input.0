Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879404;
	b=2GVasFjSL9efANEyO9jvx5bl1zYhOmExFayhV31P3FG/0XAvTIHyLEOP3ebx8UXbVLQ5
	 Ycha9QLP0PUAZiRfvv2Y+XUFZiAyKON6dF0YuFwsN4KksittOJ5XdOAf6yMZEnJJIKsl2
	 lolDJ4qQxwFR7UyzWcrBdRou7pQeMYSlV8ezduCP/7gik3/8/FMhFuhc/rf9zbDusA/3V
	 SxlRm2c1qnratSU443uazQX0kIB0ceomIpbU/gzvLPdIETD1fo2WPoTyZ6SkgZVwR/DQ7
	 1KvCv9N0RJGxRoNbjtrQzud7ORfBgSIfBq5wyD51j9YLtQb07b+sr3FjseOyC7qWCIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879404;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=oDKfQDAIoGUbqzr7+NW0qlqn3XhkGoaI8l2e454ELsg=;
	b=JNNQYO+jo3FacfOF0NVhXSaqKKQHS1KFy40k7LFwfkpSHKP2ryxumHcaWAqJmbWu7n+a
	 /ooqRNEgIY3uKnUUbwhEXI1rRZfhLTs6xvFVZIN30mPTXR4rWVXA2CcB2E4rM+1ukHP6B
	 5HZ98e5AYoCG5SIcGsmd4KZkDVLpjwdZYxfucc+GsOcL/QKhJjNpox4l07gZjNW1RoCef
	 Ro6QGZV0Aamt1TH+MajjRPtv1wEguMQgjGWQ27B9rybKP7OXVlUtGBEosDBUp9UmBM9b9
	 mBpdCkK6FNV2xTGmloMYna22Y927xtYzeZpO8OjWWyl1zqoZvsNHl7ie0T7B8i70xTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTaO8neH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEC5606D819;
	Thu,  5 Nov 2026 11:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MTaO8neH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C997F1F00A20;
	Thu,  5 Nov 2026 11:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879403;
	bh=oDKfQDAIoGUbqzr7+NW0qlqn3XhkGoaI8l2e454ELsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MTaO8neHaewLBM/bDyKXSqHYZNXi63YLUP1tARtL9v7p35p4N4rT+Tj3p52qK6g95
	 hzAuCkpEpDggwkgzCAddPGZp2APD0vjNcP8no8G1SZzjJVblpMSw30JJhtbA933v+G
	 15roy3x4+JxFE967FILojGjNP/UXNfIkr5l0kmMyrLs36M7WR5X+LtORotz8ShSrcE
	 6/U2vUZ5XoToEVKzPFjfDUyUsPwHD3uhCeFYdZgR4yzRCMmi3qx8Ypg/WJD5pmgCYz
	 LZBbgpVRjrwS/7eWQpPbRCETxYTT7k+SO+aLdWq/mPpy5gLVsXERE4BPhULSSpQXBb
	 CDiWvU4LPSDTw==
Date: Thu, 5 Nov 2026 12:49:59 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <auxrRmyg50gvP1HE@devuan>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
 <20261105112813.13210334@pumpkin>
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
	protocol="application/pgp-signature"; boundary="r3dy3xcwqerpul3i"
Content-Disposition: inline
In-Reply-To: <20261105112813.13210334@pumpkin>


--r3dy3xcwqerpul3i
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <auxrRmyg50gvP1HE@devuan>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
 <20261105112813.13210334@pumpkin>
MIME-Version: 1.0
In-Reply-To: <20261105112813.13210334@pumpkin>

Hi David,

> Date: 2026-11-05 11:28:13+0000
> From: David Laight <david.laight.linux@gmail.com>
>
> On Tue,  3 Nov 2026 22:23:18 -0800
> Mariia Nikitash <nikitash.mariiaw@gmail.com> wrote:
>=20
> > In preparation for removing the deprecated strlcat() API[1], use
> > strscpy() to initialize the mouse device name.
> >=20
> > The destination is zero-initialized, and the constant string fits
> > within the buffer. Since the return value is unused, this preserves
> > the existing behavior.
> >=20
> > Link: https://github.com/KSPP/linux/issues/370 [1]
> > Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
> > ---
> >  drivers/input/mouse/vsxxxaa.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/input/mouse/vsxxxaa.c b/drivers/input/mouse/vsxxxa=
a.c
> > index 042a17fe81db..b3a0d7ff5738 100644
> > --- a/drivers/input/mouse/vsxxxaa.c
> > +++ b/drivers/input/mouse/vsxxxaa.c
> > @@ -463,8 +463,8 @@ static int vsxxxaa_connect(struct serio *serio, str=
uct serio_driver *drv)
> > =20
> >  	mouse->dev =3D input_dev;
> >  	mouse->serio =3D serio;
> > -	strlcat(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> > -		 sizeof(mouse->name));
> > +	strscpy(mouse->name, "DEC VSXXX-AA/-GA mouse or VSXXX-AB digitizer",
> > +		sizeof(mouse->name));
>=20
> You might as well use the 2 argument form.
> Moreover, if you use strcpy() you'll get a compile-time error if the
> string doesn't fit.
> strscpy() will truncate and return an errors.
>=20
> The other question is whether mouse->name even has to be char[].
>=20
> Personally I think that while there are issues with strlcat()
> (mostly to do with its return value), and that there are often
> much better (and faster - so sprintf is out) ways of getting
> the same result, the deprecation really needs to propose a
> sensible alternative (not inlined strlen() + strscpy()).

One alternative would be to add strscat(), with the obvious internal
strlen(3).  This would be a drop-in replacement, and wouldn't have the
issues of strlcat(3) --mainly, the DoS vulnerability which is
consequence of the return value, and also the more difficult error
handling of doing '>=3Dsizeof(...)' than '<0'--.

There's an implementation of strscat() in shadow-utils, where we call it
strtcat() --because what it does is Truncating the string, so a T feels
more appropriate--:
<https://github.com/shadow-maint/shadow/blob/214a2e6e0a5f81fa281b272be7cf9e=
9d3aff8f34/lib/string/strcpy/strtcat.h#L28>

Another alternative which would avoid the internal strlen(3) call, and
thus would be faster, would be to add a stpecpy() function, similar to
stpcpy(3), but which would take a pointer one-past-the-last element in
the buffer, to perform truncation.  This is fundamentally Plan9's
strecpy(2), except that Plan9's API has a bug.

There's an implementation of stpecpy() in shadow-utils:
<https://github.com/shadow-maint/shadow/blob/214a2e6e0a5f81fa281b272be7cf9e=
9d3aff8f34/lib/string/strcpy/stpecpy.h#L28>

We've been using stpecpy() quite extensively in shadow-utils, and it's
a great API.  Of course, there's also the decades-long experience in
Plan9, which apart from their bug --which I found, by comparing their
implementation to mine--, shows that it's a quite useful API.

And stpecpy() produces the simplest code of all truncating functions.


Have a lovely day!
Alex

> This case is, of course one of the 'better ways' cases.
>=20
> David
>=20
> >  	snprintf(mouse->phys, sizeof(mouse->phys), "%s/input0", serio->phys);
> > =20
> >  	input_dev->name =3D mouse->name;
>=20
>=20

--=20
<https://www.alejandro-colomar.es>

--r3dy3xcwqerpul3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrsbWIACgkQ64mZXMKQ
wqkq9Q//UW6QwkSie8ECdEChrKHPAnBCwiZw1qTwxY4XWzrHHNlPa0FYuC31kBbq
+qWM8MEQ+eolkMZxZibf9GRvHUJVyi4dR6uiLURvNRJ9PzSPqRftGrnFkFFMEge0
wqsXrJIFqW90ZaJINRVKtfqApEDIABnD9TWgA5ldyOgAvH8Qctw6rVWIchV0fg9u
y8HoYY0oeRWdXS4Xi1JjF3t2YbxcaNkgRvFe4IyOehrzITZVVw6V73KXJ7tk75qn
Zt4rM8Ge66zdPBJe3vyNG+o3Cd1+5jDVklD2fSYmQ7+cQickIJNAjf906GbBaZGH
URb5e3imbM/UXt2VpD6+sRjLtmo3SOKa3SnIvJnfUCs4RYYRd9G5N61aBsj8Lsm4
aGShVCJ7ruXIZgUHh4LarOWVfvZtBTirc0sYgg4s9OsV6yxtmI4MkzmvF5NH/XRD
qXVbWM/fWNgFL/7VBaoTMCQ13/3iDj321nTfbG76l+B1mkhyxdEe7nXtNXArTi4y
bsL+nFoc7trM7DBPBpr7TzOuLcg3eJhynRW9UU/vF+p3WZyLnHrl6Bhfsbomwo/+
k3IxB5EDufvzia2R5NXYd+tV6BUDnU/Gw1vxJZQyGagG3GCUBIyuwMoqoTR14taB
1CTBz9raaaEZLYFVLA6nnWXjGSYpCqtzKoOiipAIbc3kEc0qCSY=
=CGAl
-----END PGP SIGNATURE-----

--r3dy3xcwqerpul3i--
