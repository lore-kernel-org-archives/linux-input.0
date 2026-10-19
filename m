Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428065;
	b=dwPeUYfL4D86GZOi/le1GqM+OFNF6gEq44EBKKfRCuDi/Qj4F5WLNhiphBN8a/D4dy6O
	 HFfxpg4Zp0clFYDCVpOBfUKEqs5fgLZQ7U1f7mNCwKXY8EOxsFpCmODYqHHQb9XDeG6wX
	 yEl3XMDD4QCnHtUEBbNtCNutA5LQNFuC2xH834rfOWRTlecgm+o8h3eIVXPpVMneVwbtW
	 tlKDV9A4XCHCUDJj2IWmMITiZmLjkR+VRji8Bi5lav8W1S8bpFQbAxswL489opuYoouqw
	 n7jrUePny7qV6E0QI7RNov2SLDUCWIg96FIz4tyiC8THRE9BAYNcx4ot2MS6oH++dNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428065;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EqbCX2PynKZyYQvAfIZnP+Bps9+5fzXRpmCYaTVr/Aw=;
	b=AYam10Ck/8IWXFlg5wuv4a9J74PR7w/cFKiBBe73yqO4vTkLA0bB2RgL8tftMpfZQUjk
	 FS2UiHn0oLQCl4qdoUhwcw+jgEZooCF/+ORxMRuY63RGF+ocbmYNWoIu+eLr0Xm/uei9N
	 sVtLpx67NB9b80eBRuAfILYSK20t2A21NSjhMOm/LW0ekhFSwcj/1lHNDZIlU+udEdlje
	 bXAcxHSfUNbLfiGGqoPlRS3uUfj4UbU2Al9ZMzLn3MYc+OvlMdeKmPbRiYJAtt6dNvIYb
	 7+9/SBN4EY9DgPp8gob+5RdRGQbOPBC4fB+DuXgGQuu5GK3NLLH4a4eh2ArTe6UwRjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTgwfAom;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB48606A322;
	Mon, 19 Oct 2026 16:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aTgwfAom
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4661F000C4;
	Mon, 19 Oct 2026 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428064;
	bh=EqbCX2PynKZyYQvAfIZnP+Bps9+5fzXRpmCYaTVr/Aw=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=aTgwfAomzzrJqfJ2uCrHsP8//DjnKY6R19/351ZhtXCkDXo5DID+LQckjQMbbv7DV
	 xNu7LzhJqUXT62lsc/bymwx3McY68SlY2xPvQOGAbQv+lmmRRricO6ysoKiKLqxtUm
	 qKDtP5xQGYSrdRhvaTFgiRlEfzccecMd8iHmcJaRwjRFUr2mhBYK6n5XZde1Bu2UjB
	 dTGZq6/H3byDKYkMdZtBylL2rLtIcr4NieqRs4ITGF+Fv72nnpTV8zS1cYNByRDpp4
	 xLBlBx9/bR3geXed54YB3p0rKeorj4/mbgQiu3RY7SKDtTWD6ydYi5vkSWQrEi1Lrj
	 mRxXS0pcqnOTA==
Date: Mon, 19 Oct 2026 18:40:56 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shihuang Liu <shlomojune6@gmail.com>, 
	linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Ville Syrjala <syrjala@sci.fi>, 
	Henk Vergonet <Henk.Vergonet@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: joystick - replace strlcat() with strscpy()
Message-ID: <atZHH60l9JAkLl2D@debian>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
 <20261016170411.51025-2-shlomojune6@gmail.com>
 <30bc6e07072076b0591fd416f50f4fc3@gmail.com>
 <2026101727-ebay-five-72f8@gregkh>
 <atXLrTZYBazVZVHr@debian>
 <2026101951-undusted-laziness-d40f@gregkh>
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
	protocol="application/pgp-signature"; boundary="duwbzjxdrzhdpi4y"
Content-Disposition: inline
In-Reply-To: <2026101951-undusted-laziness-d40f@gregkh>


--duwbzjxdrzhdpi4y
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Greg KH <greg@kroah.com>
List-Id: <linux-hardening.lore.kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shihuang Liu <shlomojune6@gmail.com>, 
	linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Ville Syrjala <syrjala@sci.fi>, 
	Henk Vergonet <Henk.Vergonet@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] Input: joystick - replace strlcat() with strscpy()
Message-ID: <atZHH60l9JAkLl2D@debian>
References: <20261016170411.51025-1-shlomojune6@gmail.com>
 <20261016170411.51025-2-shlomojune6@gmail.com>
 <30bc6e07072076b0591fd416f50f4fc3@gmail.com>
 <2026101727-ebay-five-72f8@gregkh>
 <atXLrTZYBazVZVHr@debian>
 <2026101951-undusted-laziness-d40f@gregkh>
MIME-Version: 1.0
In-Reply-To: <2026101951-undusted-laziness-d40f@gregkh>

Hi Greg,

> Date: 2026-10-19 10:44:22+0200
> From: Greg KH <greg@kroah.com>
>
[...]
> > > I'm all for that too, and putting it in the USB core for everyone to =
use
> > > would be great.
> >=20
> > You might be interested in <https://lore.kernel.org/linux-hardening/cov=
er.1751747518.git.alx@kernel.org/>.
> > I was working on something like that, but actually much simpler.
> > It is meant to replace strscpy()/snprintf() by versions more similar to
> > Plan9's strecpy(2)/seprint(2), but without some important flaw that the
> > Plan9 APIs have (about handling NULL).
>=20
> Look at the patches from Kees on the hardening list for the seqbuf
> stuff, that ideally will replace these types of string functions
> entirely over time.

I have looked at them.  I personally think some of them are a bit
unnecessarily complex, by being designed around lengths instead of
offset pointers.

Essentially, his API is a wrapper around the usual strscpy()/snprintf(3)
operations, but because those fundamental operations are themselves
flawed, their wrapper is inherently flawed too.  stpecpy()/seprintf()
are the same, but are simpler to use raw, and by being simpler to use,
their wrappers would naturally because also simpler.

I'm trying to convince Kees of this.  :-)


Have a lovely night!
Alex

>=20
> thanks,
>=20
> greg k-h

--=20
<https://www.alejandro-colomar.es>

--duwbzjxdrzhdpi4y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrWSBcACgkQ64mZXMKQ
wql9cQ/7B9c56V5Rts0YPbBCQLxAJpaXvjSVThCP4Pi9CFv8Ong56WsmD+E//dnf
F9QSMqye8QGaloWRCcrxGejEkAQHFBu3qik1sWyRpQfUoh6b/TaYRXxA3fRzTp1u
wdPIYv1Rps0B/OBBXujUrnqyrbZiKndMKy1FIqFXiJIN8fsUiDfsTinV8W4aYn5v
g0W1dVfhfvOhMRHOAylEW00wVxcDpe99/ro7U47M2csc70RNDtcb43GWqa4AqzBR
ZBl2wFvfg9Viufu6ojzsWmIEevSv55RDJkfsTMsj/Xcs+cV9GtRMMey8anu/tQKi
QlDOsowEIkE9St6v8WjBYYbQFcuA1mXR2kecP2UitS0JLX64feponTU3YANFfXVw
VgKjOey6cQMfe2or6B3e2zkomuDnHG08e8KpqOaN0DtpMyngAJVvC4S9BbjqMWIi
bGdDTIgdqFEJyh9oP0oSlCsgx/ev3r45D2rmrf2v0BL+Gml19AHgcunL8f5YQ32j
AYMjcI2EbAZkeRuP5bf/TLukwkhNRV/WzV/DezCrznzt0CAEHkpMbvZDDSm+hW4H
oQIn1xfiLs69wB9TOeiPkj6KiJ+YwqhdaO9g/Z9OKqADx3me/3mIcg4AXrteSk+r
yPdjDKysxSDhAfUZQyL+azM9e5IqtPfpDm9Oqn66McZOLqKDsfs=
=gsYD
-----END PGP SIGNATURE-----

--duwbzjxdrzhdpi4y--
