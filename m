Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633755695;
	Sat, 22 Aug 2026 06:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787380307; cv=none; b=mX2KDp3bZsb/khqI05RTVoE7OpcfTQjn0IsPXAhhkU0ls4Izx/N16BtOnYN4SScZdxjBtnO0mj73E2D0DRMucNzbhw6sKfXp/VsTJSnlsh8hbIxNWITuSmp9y5k83lsP146h7tBIwcRJ9ILSun6YHrTRC1NmOJ06AuKqJnaq8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787380307; c=relaxed/simple;
	bh=06ShQr22+Mv3tkCvQ5CnmYEUc3wr87P+zY3ZUu64T8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ObmBwvPHDFmd0MNDVTOqEvuDGkZui1sXkOI5ndi3XPvYfSdhmPZjVZpTGKP+8+CMVsNRDi1R6EFpsovW94Bz7sduJntUcUBA9TL83MltTduhUPbqnKDCFCkAVce5xsbw7Xb1u1eiMkg4NAptkC1VmlKWa0iu2uHfvhfAwc7eUlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/PHgpG2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/PHgpG2"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 932571F000E9;
	Sat, 22 Aug 2026 06:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787380306;
	bh=R9sVHw5FU4Bh8AKC2R5yfA5vR9BNlZNhimXLNPJPBA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k/PHgpG28J5nrHMNy2VGXDoCYnAwZqf0WJGNuXY+FE7tEkLeJa8WgWondVBEcV9QK
	 RL2mDtaizjnwnlkaPRUNiMTXiER3bdbMYPwe3ucC+BFHLyqQb9bhHLnuBdpUsJH6xj
	 j/gs14GaCEU9qpyUya/ZrWYtSKfbki2eo5HC5CNUsSNQ/oLc0GuRl8smfBzjGjERU4
	 sJ//iQhB/wg8DaFepxPYl6heQ9/q+2Y02KXoBDOAzFmocYOuv/aO+jllHGA7cJhTmj
	 ocHBhkaMZScRw3I8Ts+EnJfBlS2uX8m5QHJIeoLEQu8aRGu0luVkNgMSaa/DWNrYOm
	 4mXEggP5DD/FA==
Date: Sat, 22 Aug 2026 08:31:41 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kees Cook <kees@kernel.org>, Armin Wolf <W_Armin@gmx.de>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Eliav Farber <farbere@amazon.com>, tony.luck@intel.com, bp@alien8.de, 
	guohanjun@huawei.com, mchehab@kernel.org, xueshuai@linux.alibaba.com, lenb@kernel.org, 
	laurent.pinchart@ideasonboard.com, linusw@kernel.org, orsonzhai@gmail.com, 
	baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, fabio.m.de.francesco@linux.intel.com, kaihengf@nvidia.com, 
	ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, paulmck@kernel.org, 
	frederic@kernel.org, saket.dumbre@intel.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	acpica-devel@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] Base commit for
 devm_{atomic,blocking}_notifier_chain_register()
Message-ID: <aolA9ZV4eDN2uNVe@monoceros>
References: <20260816060648.4030-1-farbere@amazon.com>
 <aohZHuN68wIyaxWy@monoceros>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pb2liudaw3te6hmi"
Content-Disposition: inline
In-Reply-To: <aohZHuN68wIyaxWy@monoceros>


--pb2liudaw3te6hmi
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [GIT PULL] Base commit for
 devm_{atomic,blocking}_notifier_chain_register()
MIME-Version: 1.0

On Fri, Aug 21, 2026 at 04:07:18PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> On Sun, Aug 16, 2026 at 06:05:59AM +0000, Eliav Farber wrote:
> > Many drivers repeat the same boilerplate when registering notifiers with
> > device lifetime:
> >=20
> >   1. Register the notifier with *_notifier_chain_register()
> >   2. Check for error
> >   3. Register a devm action to unregister on teardown
> >   4. Implement a per-driver static unregister callback
> >=20
> > This series adds devm_atomic_notifier_chain_register() and
> > devm_blocking_notifier_chain_register() that automatically unregister
> > the notifier when the device is unbound, then converts 11 drivers to use
> > them.
>=20
> I applied the first patch on top of v7.2 for you to merge into your
> subsystem trees as base for applying the patch(es) from this series that
> should go via your tree.
>=20
> Find it at
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags=
/devm_notifier_chain_register-for-7.3
>=20
> This tag only contains this single commit e38b9eda475f ("notifier: add
> device-managed registration APIs"). I intend to include it in my PR for
> v7.3-rc1, feel free to do the same.

While I tried to pick up the pwm patch in this series I noticed my
Arithmetic error here =F0=9F=99=84. It should be 7.4 of course. I created

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/de=
vm_notifier_chain_register-for-7.4

with a fixed tag message and dropped the 7.3 tag. (Even is someone
already pulled it, nothing bad happens as it points to the same commit.)

Sorry for the confusion.
Uwe

--pb2liudaw3te6hmi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqJQksACgkQj4D7WH0S
/k631Af9HnbvYBW34E2hi/rCdPLfdqmD+ReFFb5Is+xyDnSW0UAUmvCloPf6QKKQ
E4K8KqnIztkgI5Q96G79DDjEaWzqhnPfyC6cyByCpmdUh9R093TgR3zk15TXLBlS
y4v1jTqQvsnN194uYGXOZNZWaneYxQamJO+j7KgAzGRfWnPrJ5yZT0rnngYTluHJ
U+9zpO5JSc0KEHqLd9Ut9pgQshqpH3zA5c6eH/ZrosIHZMjk2eXjtP+UgoktdtGQ
Y/qm5UfncradKTexlH2pNh5euQCooFO3fueiYEPgqiddaMl+iF9e5znDvbwSZgsh
TSvmbdhspJJJz6j0IFJs2kzKgZohWA==
=4Uhe
-----END PGP SIGNATURE-----

--pb2liudaw3te6hmi--
