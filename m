Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663390;
	b=ufVQKYrIK8CjX9z6U2aY7XavcEPR6Bqfk2vZIzo0Y4VJQSHin9wlpSf057OL1whkCpHM
	 Jjf1bKtsC8tsiIjnY1gqESXIG/QI+DC0BBTLFMtbfOy/iB11tZYjgIFUmd3C4bBl+85IH
	 m7foioA7SXjeh7Zxlf/J0liRjLvO9inF6svo6q31LcLSdpwWSU5qYxx8stNDRBz4DtoM7
	 oFj3oJTym1Vrmr+b7LSyuv+fkJelvuhfGZwyzudiXLQv+3IJm9oWT29sVDeP8jnCRMgl8
	 RhPbqyLpHO/7Lx446IMpvgGzMZ7QVUpp5YvBP/YVi6Yqc/grEBvUUOeRqSIMu6a134w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663390;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+AENzdw6XfuWtm9cO8etUQLawy/5tzmLiPlOGidmMtc=;
	b=1xcDadBVB3tHgiU6KUDIv9UZgdXH3CwJYnWNXPXdP//+faO6wecXl5yJy5knhJ5LTN/W
	 AAUg++EkxcSop8Tn/XlCRua4Y2wj3jRFaRKzsd7sSHO0ZYx4uEDYQYx23l9vJZB/FdGrI
	 udHVmDO+ydGiSCRRl3mDEDZptTO5Z5MWnRNWQ+cRYVCvTQWJ+/qfYF6YsmPNlddkSJwhy
	 W1xnDeDDFyAMZkjtGbAkKaKe0UiJ/TNes3KSOnNby61CqYjCKAwxGSlB8nuMws0v0xnpj
	 WWA38oc6KrEEp5+5SLQEDC3LZJjXEtAbeEnjI6/hnj+MiKlyLudEXWPlzHZgCPpvpYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aemAhwUW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2387606A319;
	Thu, 22 Oct 2026 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aemAhwUW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407F31F000C1;
	Thu, 22 Oct 2026 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792663390;
	bh=+AENzdw6XfuWtm9cO8etUQLawy/5tzmLiPlOGidmMtc=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=aemAhwUWC+fBzpD1YYpWHWzmSDuXIguLrJcch3m5OzAL+xh/bX8BXwLiuOn99cdq8
	 w8eJ10TXH/laANWESC4DqEmL6n9HurykUE5cDaZ4hn+CwYZPR2xERIh2RxdNiRAbKV
	 +FrMBRy6RbUL7HTW6b60RTwq/UyvU01aV9pd9cSwLMrIW2bcyktuy2YPW+3aBdcF9f
	 6X7aitiE4SCcr0FfvBdb8Rm43/MuL0p3TeETGMEZhhz8Kj5jEzAuhaTKmBJ0EOrR+j
	 jhuMS1Q3gymAqnWyKoLosjfbchhv8XdA4qw2IqMr2QQv3IvlvIwLqQHuRJyviiaoMx
	 sO3bhqGb8kOYw==
Date: Thu, 22 Oct 2026 12:03:02 +0200
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Message-ID: <atnepCUZOnMJatgG@debian>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-3-shlomojune6@gmail.com>
 <ati7yINv0_Z3yPMg@debian>
 <5wdnvsf6bepzpxzfizt4fs3325denwzeeksg3b3hpmzu3257tk@ms7kh4fcgz2k>
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
	protocol="application/pgp-signature"; boundary="oiz7nkqt33u2chgd"
Content-Disposition: inline
In-Reply-To: <5wdnvsf6bepzpxzfizt4fs3325denwzeeksg3b3hpmzu3257tk@ms7kh4fcgz2k>


--oiz7nkqt33u2chgd
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx+linux-hardening@kernel.org>
To: linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Ville Syrjala <syrjala@sci.fi>, Henk Vergonet <Henk.Vergonet@gmail.com>, 
	Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Message-ID: <atnepCUZOnMJatgG@debian>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-3-shlomojune6@gmail.com>
 <ati7yINv0_Z3yPMg@debian>
 <5wdnvsf6bepzpxzfizt4fs3325denwzeeksg3b3hpmzu3257tk@ms7kh4fcgz2k>
MIME-Version: 1.0
In-Reply-To: <5wdnvsf6bepzpxzfizt4fs3325denwzeeksg3b3hpmzu3257tk@ms7kh4fcgz2k>

Hi Shihuang,

> Date: 2026-10-22 15:36:39+0800
> From: Shihuang Liu <shlomojune6@gmail.com>
>
[...]
> > > -	usb_make_path(udev, pxrc->phys, sizeof(pxrc->phys));
> > > -	strlcat(pxrc->phys, "/input0", sizeof(pxrc->phys));
> > > +	usb_make_subpath(udev, pxrc->phys, sizeof(pxrc->phys), "input0");
> >=20
> > To be honest, I think the composed approach is more readable.  You don't
> > need to learn a new _subpath function with all the details it has.
> >=20
> > Everyone knows what a str*cat() (or str*cpy, FWIW) function does.
> >=20
> > I'd rather improve this by adding strscat().  The reason for removing
> > strlcat(3) is that it is vulnerable to DoS, and that it is inefficient,
> > but it is good at producing readable code, and a replacement should not
> > degrade that.
> >=20
> >=20
> > Have a lovely day!
> > Alex
> >=20
> Besides that, strscat() has other issues:
>=20
> - The `sizeof(buf) - len` arithmetic is a classic source of
> off-by-one bugs.
> - any future change means re-deriving the offsets all over again.

The whole point of str*cat() functions is that you don't need to derive
the offsets at all.  Just look at the strlcat(3) code above: it doesn't
do any length calculations.

> I'd prefer to avoid strscat() here.
>=20
> Thanks
> Shihuang


Cheers,
Alex

--=20
<https://www.alejandro-colomar.es>

--oiz7nkqt33u2chgd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrZ31YACgkQ64mZXMKQ
wqlt1Q/9HPEJOrpPsY+t8FSbJ4tc3JjefAIVWkf0RT6brghBxjyhJL6S2dWjbaif
SFVjF84h40QhTMuqddk085VNPJ91FPB5AyXJPVm1E/6sSJ76ee9ltcpwe/VjBtQA
9dBf0lUki3z/ppLL2zwoU46KtoFPWpZoGgJ8JnNsZmclQK+1p9sYXgdyUFLNJst8
wIkAmcMkSpmRXpgnyeC5u3XbXfEhUgZOk/0+7zTfd7vs+ot7MUsjZedIbVZgGEJc
aRxKeR61corBA5kK2wnvAeSWboZESlCOyeP2Vt0l7TcQb/8PMrjUnPWFMQz11/f6
L7n/eEQKMmBRfUAX8S10cEBpPbHUvP6dAnNz4r9QSYdORR/Xo7Hel4dKVvu84G8B
uxe1A7DFCPFWwfOK9n3YzLNePxub/9HgBguDfYw8iZrjjTcwCPr1RiYWmwYqtMXQ
j3y05iId6ITqsDrNMjTTbiUse69DkDTX27kCSqyR/u0EFTIS78TRLjcrZkK2OMUx
hq6/pfIeZ75WqOmsyflXeMW4uUpN4FPQVmWi7na4UFFNg9oD4k56eGV6qz+8eAIL
gXIA1hmaJEJi+opB1O0OWLVnHP+19mDIUNxaSzOLVdVRL5h0HBQ2cTIXjWXYFfXk
OFNWn+eG1L1Taoaz36djZC2gk5utce1dCrcmTD+iMG/BnpjW/jc=
=IbjK
-----END PGP SIGNATURE-----

--oiz7nkqt33u2chgd--
