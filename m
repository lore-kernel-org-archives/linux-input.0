Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028F279DAD;
	Sat, 22 Aug 2026 06:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787380835; cv=none; b=I+4hSjglhrkmKhKBQVRiOpbSxq0bAF3Bu83x5Vg2yXoYWktHh/BNkn9GOC5Z7V0jffquCts74/tuyieHXd1T4OovRdIzJlUmociZ2g44Rc5Mh6Uf3S3GvbKGiVva1W/0Q+jUSScnxrgfLSJgsjTenL7EZyExcdJoQgn49UrRcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787380835; c=relaxed/simple;
	bh=qZkd17jLTIsuEtUmzqytNAQFcY186okXdfGYQCVGJ4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QSSBG1HBks0gqCaXGxJAYDzmMDUwqfroFipXi7ogYAZywhjBQMXBzA3UBeryfrbMlj9FQQt0D7Z58dSHgWgJwkZdh4bBRZYiVh65GabsurnhnsUZbGvZYh+/ypb19YJSDW6QcQItdMDIBd4pV2reJid8cQ/kJfOaI07fQIn6ULs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nM5QaFv2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nM5QaFv2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8DA7D1F000E9;
	Sat, 22 Aug 2026 06:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787380834;
	bh=qZkd17jLTIsuEtUmzqytNAQFcY186okXdfGYQCVGJ4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nM5QaFv2aCwbCLEOMmG+sLiwLMaQfQmvbrhxVZNZe0xUGNIslbIGSEP5KljIaq7wr
	 h1jyAN0GItwW/5uMEEpf76Fpi/t7sLmQ5wAo0OnTQ8IBZAO+980W0Df5dzgxu3btVo
	 HKTAhWaEhYVQ/9wMoA14B3I1OQ+wVXzHj5zQowkgz4scdyjdaX+SDqjhNatGJ9YFzB
	 oWBogUZhQXCHTeAatvhtXEXzNH3TYj8TTqDnaM1gS7ko9Sxp57O6Mk/YdgsbWQOYC7
	 trYabRN2zIz3z81RIic77uf9fggE5RqhZJ/ivnH4H8427LGRdkm6iI+RVXYlTf4KBD
	 eRJ4BQMOIRSYw==
Date: Sat, 22 Aug 2026 08:40:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Eliav Farber <farbere@amazon.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, 
	guohanjun@huawei.com, mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, brgl@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, dmitry.torokhov@gmail.com, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, saket.dumbre@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 02/13] pwm: iqs620a: use
 devm_blocking_notifier_chain_register()
Message-ID: <aolDEG78ituBiOJ1@monoceros>
References: <20260816060648.4030-1-farbere@amazon.com>
 <20260816060648.4030-3-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nrfqtiliged5ifm7"
Content-Disposition: inline
In-Reply-To: <20260816060648.4030-3-farbere@amazon.com>


--nrfqtiliged5ifm7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 02/13] pwm: iqs620a: use
 devm_blocking_notifier_chain_register()
MIME-Version: 1.0

Hello,

On Sun, Aug 16, 2026 at 06:06:01AM +0000, Eliav Farber wrote:
> Replace the blocking_notifier_chain_register() +
> devm_add_action_or_reset() pattern with a single call to
> devm_blocking_notifier_chain_register(), removing the
> iqs620_pwm_notifier_unregister() callback.
>=20
> Signed-off-by: Eliav Farber <farbere@amazon.com>

I applied this to

https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-=
nexxt

(with $Subject ~=3D s/use/Use/ to match the usual style in pwm land) as
7.4 material. Note this branch isn't stable and I intend to rebase it to
7.3-rc1 once that is available. Until then it will also not be part of
linux-next.

Best regards
Uwe

--nrfqtiliged5ifm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqJRFsACgkQj4D7WH0S
/k59nAf/Urr3Y3nH3NI+Hm+30xQ/Jz/rUTKErXPz5OypJYZYBbpT7bay8ktBMsbk
Z/lbIfZlBUVJI6CJg89mJXA3ndOSblnjx1Rhio5fRYPxdNcWEkPnYW9i+iPcobyx
FmkZFljB2hw/8mvSiKsstaSws8Webyn88JXMnjt0lVEOuSnlKbPC0v4JtBD/7RqX
EBExbufnb4FuX8ScrUjDDzOYFP19GvuKbQeGQ36e61vmUIdsIM/tpJjVQWuE8GxB
4ZH6GfUFa4nAOyxCXkvY988ZAGVzErcmjL13RX3ktOKEEib7DncfpCvsY45mXtiW
g1rtYBdBeigjbuxIeBV/o2dxEhOLww==
=A2iZ
-----END PGP SIGNATURE-----

--nrfqtiliged5ifm7--
