Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914783;
	b=rgFbmHiGwksZUpn5RX0O+QCi/4jeXfltkTU6NXW2u/uvJdYh6RYplvdCWra1mawKOZZH
	 7EiFSOkd1iflsswrGwLa2C+PB1GaYguzbMAfow0dIv/4zh0yTn1Yz2UHkrEWcSYS8bFY3
	 FOMAg2IaeMzPPRjsQN8s8QByuGgZwOXac26lvIIyz8KJmdF2KViBr5kvlpqe40o6+YYZl
	 YKlk7QYtl/QDwL7M3xIL3piPCVI9onUNkDor+FCBYnmDozmRkUAzkd+VlAtk3Z8AHKC8q
	 WcdqnsLCjCrUCzt9HlHI/tTqipxiP2PmaNybL3unD6u3I7JFq6D0PlIbvWiTXcWuPuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914783;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=4uSDodCcgcYDH1ty4ZcJJW34BiY+PpPXgdxxUZKLRO8=;
	b=TwuGkjeZW5hRd3RlIho9x3SV2joev07E4/8xziToxAAo6R8GfRSN/2cKgHg1Ajfj4GA7
	 JOZXyDNf1A1xieqKp2Z/0IBnz6zhj7KIB51XDRGUT6DLj+DZsRo9bgqN0gly45U4hvW1B
	 2LKH1yiL75bM3d5kVDyB7H/1b2Wp8GBFPuAKntS415ESfwOm5Q79WkY2jZfGje/qkzI/Z
	 W7O1VSnqOCTCYSLYzJXu2np+2hsimraErstn2W8auADgZ3n0+CT7iSFvs++ta9xymBqst
	 sCBcRRAMCnVk6vx/Nhav7GZ8w9N0T1IdzNBYNr6lzXKDhhsnIJfsP+tezZZjJ520yCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z3poS2/d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4B606A32C;
	Thu,  5 Nov 2026 21:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z3poS2/d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1CF1F0089F;
	Thu,  5 Nov 2026 21:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914782;
	bh=4uSDodCcgcYDH1ty4ZcJJW34BiY+PpPXgdxxUZKLRO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z3poS2/dx8gpVGvc+K5PHUiHPBIB8w0BzSbY7tZVQX5egSFjZqhg+9O8rKZVAz0BY
	 4oet+NrcYj83moN3He0+UmHjJVJFKaQ/t6kV+5NZhbJGwFzTmMGQH+13WPzgX/MbB4
	 mW6DD0Zo5NTcWqnI6rfZL1wV3JfFHugvncx2PVOQZv5e6riQtrwOilE8RwEPfTx7ls
	 kHWg8h+duxUUitlPglVEQl+3Up/MZ1EJItDaFbYsGFJrI1TgP7AGmXHqmub9kx+Kuj
	 bUtwNzV3CUUJAk9Fm732smd7gGEpYFgTqce5Y/hemmxnN1MX+0H1zvfczKbLAKtL13
	 5EsI/I6BWiNQw==
Date: Thu, 5 Nov 2026 22:39:38 +0100
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <auz0ONYzkWIETv8T@devuan>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
 <20261105112813.13210334@pumpkin>
 <auxrRmyg50gvP1HE@devuan>
 <20261105205321.7b303231@pumpkin>
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
	protocol="application/pgp-signature"; boundary="texyoxswryydtnzk"
Content-Disposition: inline
In-Reply-To: <20261105205321.7b303231@pumpkin>


--texyoxswryydtnzk
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Mariia Nikitash <nikitash.mariiaw@gmail.com>, 
	dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kees@kernel.org, justinstitt@google.com, morbo@google.com
Subject: Re: [PATCH] Input: mouse: vsxxxaa: Replace strlcat() with strscpy()
Message-ID: <auz0ONYzkWIETv8T@devuan>
References: <20261104062319.288360-1-nikitash.mariiaw@gmail.com>
 <20261105112813.13210334@pumpkin>
 <auxrRmyg50gvP1HE@devuan>
 <20261105205321.7b303231@pumpkin>
MIME-Version: 1.0
In-Reply-To: <20261105205321.7b303231@pumpkin>

Hi David,

> Date: 2026-11-05 20:53:21+0000
> From: David Laight <david.laight.linux@gmail.com>
>
> On Thu, 5 Nov 2026 12:49:59 +0100
> Alejandro Colomar <alx+linux-hardening@kernel.org> wrote:
>=20
> > > Personally I think that while there are issues with strlcat()
> > > (mostly to do with its return value), and that there are often
> > > much better (and faster - so sprintf is out) ways of getting
> > > the same result, the deprecation really needs to propose a
> > > sensible alternative (not inlined strlen() + strscpy()). =20
> >=20
> > One alternative would be to add strscat(), with the obvious internal
> > strlen(3).  This would be a drop-in replacement, and wouldn't have the
> > issues of strlcat(3) --mainly, the DoS vulnerability which is
> > consequence of the return value, and also the more difficult error
> > handling of doing '>=3Dsizeof(...)' than '<0'--.
>=20
> I've had thoughts of a more general function - but I've not tried to
> write it.
>=20
> int str_append(char *dest, size_t dest_sz, size_t dest_off, const char *s=
rc, size_t src_max_len);
>=20
> Where dest_sz is usually sizeof(*dest) and the header can substitute that=
 for
>   a constant zero.
> dest_off would similarly default to strlen(dest), if -ve the function wou=
ld
>   return that value immediately.
> src_max_len would be used for an effective strnlen(src, src_max_len).
>=20
> The idea would be that calls like:
> 	char tgt[100];
> 	len =3D str_append(tgt, 0, strscpy(tgt, src_1), src_2, 0);
> would append src_1 and src_2 in tgt returning -ve on overflow.
> (Further chaining would then work.)
>=20
> But, as I said, I've not tried to write it or see what it would look like=
 in use.

I think it's too complex for what it does.  See how stpecpy() works:

	char  tgt[100];
	char  *p, *e;

	e =3D tgt + _Countof(tgt);
	p =3D tgt;
	p =3D stpecpy(p, e, src_1);
	p =3D stpecpy(p, e, src_2);
	p =3D stpecpy(p, e, src_3);
	p =3D stpecpy(p, e, src_4);
	p =3D stpecpy(p, e, src_5);
	...
	p =3D stpecpy(p, e, src_9);
	if (p =3D=3D NULL)
		goto truncated;

	// 'p - tgt' is the length of the string.
	// In other words, 'p' points to the '\0'.

It copies all the strings into tgt, with truncation.  If any of the 5
calls resulted in truncation, it will be reported as a NULL.

You can also do the chain in a single line:

	p =3D stpecpy(stpecpy(stpecpy(p, e, src_1), e, src_2), e, src_3);

But IMO it reads better one per line.

Then, strscpy(9) is trivially implementable as:

	ssize_t
	strscpy(char *dst, const char *src, size_t dsize)
	{
		char  *p;

		BUG_ON(dsize =3D=3D 0);
		p =3D stpecpy(dst, dst + dsize, src);
		return p ? p - dst : -E2BIG;
	}

And a hypothetical strscat() would be:

	ssize_t
	strscat(char *dst, const char *src, size_t dsize)
	{
		char  *p;

		BUG_ON(dsize =3D=3D 0);
		p =3D stpecpy(dst + strlen(dst), dst + dsize, src);
		return p ? p - dst : -E2BIG;
	}

I have been working literally years on this API, and believe it has
reached perfection.  It includes some feedback I got from Doug McIlroy
about the design, which improved the usability and safety.


Have a lovely night!
Alex

>=20
> David

--=20
<https://www.alejandro-colomar.es>

--texyoxswryydtnzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrs95QACgkQ64mZXMKQ
wqnt8hAArQKkrFf3cPneOOUukZQn7yuE1roHjBZJO4iCuSSkG1LCHJvvA8IwZtJo
ZvFpo+MsKge+JhY0WSKaxZ+01uxMbxKwDJbMSVXwfGhcJe6p6jmI6pLyxa4ZgBPq
ro9fgQFydaj2Ve0Tu048+JKiv4hDzW4/KSgVVPamlcqXn4uH4RMKHpuQ/D0xHggi
E89XbZLSJiBqDk3s5vbxDLUsqnspEQlvWCEDlaoRfM7+EzdDyDQGWKK8QKmFODue
HiUIXkcbyCOyOGL2q8X+LT8x1caEouMzRKGV/N2l8PBa9nNCYjwFwKduNXm1KLlj
ZqBsmjAewEPdFvhP0S68VN9kczJqbPcg0kJzKoFaNhunEPYajJ5gJ81N5tIvCD/p
KLHqZFG9PEu/Yas3GhfALtrTSqsK89Oa3c6w9b+gioRW1WZVtwNkzpFoF0ZbaA06
SYdxXaMVzcrHXt1xot4UZ/YNx5ZOerX2teOxSUKI0a0Ly6TcTBqucOqtDg6Tb/SA
Hnxxg5OTh7VAlfYi8WqFfMiteHmOkakt1Alc0z9icZbpV8h/C6TJu5w1+ttl//9K
lAbJqNF3HtRJb0q+RJTv3sdx2jZa7RjTC5d625VRSDL7wQVagcf+AFilGsdRg6B+
q3gTlVz7brjCf24YSdoiACniz1CobI1iNEvy/f9iipmdvNx6TD4=
=NSFj
-----END PGP SIGNATURE-----

--texyoxswryydtnzk--
