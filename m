Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792603256;
	b=C3nBPlFyUhGOrn75CbEO6A/3h44dqC8NzzpLPlvM8xB6wdUccS/10hudcDEnNaS32zSu
	 9GfiWPqgbDDugpTOB9aNmyIV4bdkKCNwfgWUCE4YP+HDp3yU0ZrRjqJAWexvgnM4tAiYT
	 ufYt9xHL74oXkPzF86TIKWTqIjlVMcyvAzJM7UJ+r7Ef0F4iEnet+q9yI9gBevdjuTFEA
	 +WkGzZyWJYLcK6gfQbMj66wSQWt1ltTAGhm9jF20VxzWiLb4gAhx7X50vPHzsokXdJYEc
	 KrK0BymYlUdvnU/aqNPN89Td+rUBkjzkpVBgzeKJ2FwgPAUDYjfGYa/pYFjzqmMKQ9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792603256;
	h=Received:DKIM-Signature:Date:From:To:List-Id:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k75LgZKXDTpx+P16r8FtDzNUxaEbMC1Ki8W37XZc2+0=;
	b=S10ElpUeXRh7OYgzwYj6TR/4N74xG8/vrNVehQT0VGdNutdBTw3lMZ/YhD8mmGVfvv1/
	 BVP3xHKF4pB3yBw4/5i8+0DTzz2BjFShRxGr6B+lXhVSDqs5MQ4SpX0TeESi4A7FXkeoe
	 ROgU6K5wNdRwBEYoDR7JxKs1HZe8hQprqNbYQJC3VfFEEhUJ12KSQX+Z84tlbGZKt88U/
	 9dr2vKJcaGw0Wryj5MN2S1nVxZCpPaS2zj98VgdeJwbS/AuxGGD4+4CJSRqzzqrlJqSEp
	 xsh17kZ0vHoy6h2Ku9VBEkRKKmLq+iX4CHrZ0KDbo58SDEoAp5dA6LxlHf2hjMOpNPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMI3WP3J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262A606A319;
	Wed, 21 Oct 2026 17:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JMI3WP3J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599C71F000C2;
	Wed, 21 Oct 2026 17:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792603256;
	bh=k75LgZKXDTpx+P16r8FtDzNUxaEbMC1Ki8W37XZc2+0=;
	h=Date:From:To:List-Id:Cc:Subject:References:In-Reply-To;
	b=JMI3WP3Jg8uCZJw5QdnFM3s7sbjxvkPUGrn7M74VmWsNFEBFpSfcZ0tzQIfCKxuao
	 NzhPtFSHv96P09nIl0pxyWCHZsIwvOdf7PLv8BOfGkmpsURE/BHaf/Qxipe0WqnKN4
	 wNpz33gFw2PMb7KpF03w4laT0i50szjuXJALQHpkfa4io+6nwqlbREP1LBdOnN/hgF
	 BHL2f7/K+nMrAwvC2dc43+DeVn0Rq00sU3DOzhLjeM+k4PmTTPdg6GmMWr0d/vjyL9
	 nlNL1qsuSdBUByWInDF1gpfcBBwzbzhHG6H01UNtaAG5RtlHcP5BYxTLP5sGgSNFYB
	 za8z73KjWSh3g==
Date: Wed, 21 Oct 2026 19:20:48 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Shihuang Liu <shlomojune6@gmail.com>, linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Ville Syrjala <syrjala@sci.fi>, 
	Henk Vergonet <Henk.Vergonet@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Message-ID: <atj0F7xJaHhs6u8D@debian>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-3-shlomojune6@gmail.com>
 <ati7yINv0_Z3yPMg@debian>
 <atjvKMOXQY_psYcF@google.com>
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
	protocol="application/pgp-signature"; boundary="ylesyc5enuodze6x"
Content-Disposition: inline
In-Reply-To: <atjvKMOXQY_psYcF@google.com>


--ylesyc5enuodze6x
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: <linux-hardening.lore.kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Shihuang Liu <shlomojune6@gmail.com>, linux-input@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Marcus Folkesson <marcus.folkesson@gmail.com>, Ville Syrjala <syrjala@sci.fi>, 
	Henk Vergonet <Henk.Vergonet@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] Input: joystick - use usb_make_subpath()
Message-ID: <atj0F7xJaHhs6u8D@debian>
References: <20261021123146.17202-1-shlomojune6@gmail.com>
 <20261021123146.17202-3-shlomojune6@gmail.com>
 <ati7yINv0_Z3yPMg@debian>
 <atjvKMOXQY_psYcF@google.com>
MIME-Version: 1.0
In-Reply-To: <atjvKMOXQY_psYcF@google.com>

Hi Dmitry,

> Date: 2026-10-21 10:00:26-0700
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
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
>=20
> Well, there is absolutely no performance concerns in this code, so
> another option is to simply leave it as is. I see no benefit here from
> using yet another variant of str*cat().

LGTM.


Have a lovely night!
Alex

>=20
> Thanks.
>=20
> --=20
> Dmitry

--=20
<https://www.alejandro-colomar.es>

--ylesyc5enuodze6x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrY9G8ACgkQ64mZXMKQ
wqmmqg//ZKhho/4ssKtchlbZHtRgj+vt0WjdMqK8QY1zBKI4AGCG2kGC3/+e+FGc
rpooP+MlS/mnbRCB4ueU+1tB78EzEgt+0caIKsdD93Ezt5cvFftWc3W+YCJXt8M1
XF72xyQ4QAV9LHCOZGcB0IBlUuPESy78a815f/ncDFJFhYT8VDcqc+HH2H5siIBF
xZQvccff+wgh/53/ps2OXul1M38gNfTQCponvxrJlT0l+l6RQYhnzgB3yhXX7RHz
y0ER9LhnvM09YSR5diFlReXUzlmuU8I83WNJuOLVTp/Zn8+CYg6+xW/sj9fK/XJo
inrUpacpljzlduHsPlGp5GahO1fkh2+Z2/D/Ej6MpmarhHzTnp29KY2rJKL1gFqh
4CYXMQhI+xAEYbkSBQfeG3vLQ0GM7swUsk50Hj2sBJl9beEYTbRe6yoNc7gO0Z4h
2jfTsnvWBJmAw5WX5PBkCTinGv9Qt/Lxfi1ZIIzwA5zMsQ/xafgJS1+sVIoc7TY4
E+mFnxjqkVGb6sq3W7HQ6kxmkqYNRQxJ9cpBEqorborRAgaGcY/etGOf04dFphTc
5rbjWYYqieRuX5VxTDYLeihiUzt9OsuSM6jfatk7LhBAIjWIn4zlr7eRQKGWVq28
2z46JikQmqihaRSm4OWZA+LChkw1hwc9f09Usf2WhCfv/vsXlDc=
=ndO4
-----END PGP SIGNATURE-----

--ylesyc5enuodze6x--
