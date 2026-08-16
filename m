Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C357333CE9A;
	Sun, 16 Aug 2026 07:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786863891; cv=none; b=QfeMeT+RBxgM7CiCUWR20omDc2mZYfLPTxSDb959WcSeB+OlN1kfx0X3v/njtc/Lgs31cVsL9qgd5scp1+p0q0VhHMJ23lt7P2YKs4f7Dm0i9JYEoSPFpxmBRAmZX46dNFlJrA2WmerDay/9CWsN6Cq6s6sNuji21Z3vuUjykwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786863891; c=relaxed/simple;
	bh=umSxNNhx6O6I/O3YfUKvyhJJ7o0ZhYnB9LLBKcLTSTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k63CRBMo+HfLD/1sfHFXfaP0Uop9/0xuOmMISw61mLYkuh0bdVk++AHwUnApWINI0SR1f9s5CDaGijXKf+myYQxSBxQBf12o5jWKXp6vp8qfVi90WYHDUrXnvzWKTzwfkvelNzZJtRHgi3MMzoeDbDfWf+U2ihfKj68mAnEOwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2yUfIq0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2yUfIq0"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 90E4A1F000E9;
	Sun, 16 Aug 2026 07:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786863890;
	bh=umSxNNhx6O6I/O3YfUKvyhJJ7o0ZhYnB9LLBKcLTSTQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f2yUfIq0T7SdCQI/jpZgW58n7dEqEcMqFU74sovc7Rc72Oezw+uYCBE0gIr+Wittc
	 VSBsp+4Q/sc+8LJyRsfTn5hYyPWH0OFhKOzdmtgIPG3CcNNOs1bGUJ6XCVP31F1Mlq
	 7DvWkQd7JaAg8PIqMShqlIlDMn1Pno9CTjoOwn9tk7h1NBM4csCBT2SXNSblCs4bkY
	 WVSn0p8BjNo0ZG1rtkBfwdX6+YEO1R4uErPFW03drpRWIawH9R2iesn+nugHNE1I3J
	 2iw76WYsQmztaqSDI0zcqvMmxeqIa55OWKsasmjEjDkevDSGftPW0udxED2hQm/LLF
	 LwgnErISKV7+Q==
Date: Sun, 16 Aug 2026 09:04:47 +0200
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
Subject: Re: [PATCH v5 01/13] notifier: add device-managed registration APIs
Message-ID: <aoFgF2E4p4DqYLGG@monoceros>
References: <20260816060648.4030-1-farbere@amazon.com>
 <20260816060648.4030-2-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="onpq2odccwuwli4t"
Content-Disposition: inline
In-Reply-To: <20260816060648.4030-2-farbere@amazon.com>


--onpq2odccwuwli4t
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v5 01/13] notifier: add device-managed registration APIs
MIME-Version: 1.0

Hello,

I already replied to Sashiko's review and only noticed afterwards that
this way most recipients are stripped. So here again for the wide
audience:

I suggested to add "Must be called in process context." to the kdoc for
devm_atomic_notifier_chain_register() as this is a relevant difference
to atomic_notifier_chain_register() and create an immutable branch for
it as a base for subsystems to apply their follow-up patches. I'd wait
till Wednesday for concerns and review tags to tickle in.

Best regards
Uwe

--onpq2odccwuwli4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqBYQwACgkQj4D7WH0S
/k7skgf8C5Wzbv3n8obmaaNWbEaCkUDjzqae3xgk7u64wEFfxeRUOYTWzeQZVOnq
oQjiSoq6sPHfjWRz1jt3M7nnxPptJpOO7wuHkNWi5wVzcVaR7XjyQJBi3EhQGFtW
b0Ykm/EHwSuUL5F4ITNOmyjx4+8ViM6+PlWCXJEvjEgCYkC7MVJKvuJZPgW8zsWK
MbbzQZKUTrtrFc4rTiUsNXiFqsz9TG5XBgSrBoC5fq/9kQa7wunYMwpDI5rOvKf/
S0NiJIIFkOu/s+ZQZCBDbqE1T6RGlb7lOgKI9GRg/d2pkXusFqa/Ie2vIUQD6BUz
XgkLX+yXJp4OVU/+dENxKEs1CqBGbA==
=59T7
-----END PGP SIGNATURE-----

--onpq2odccwuwli4t--
