Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E6C33D6D6;
	Fri, 21 Aug 2026 14:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321242; cv=none; b=kjZOgjamGuyQyhMyqf1CStcg2f+am6tZOCRI7UiQpiXeotRR2vwrw/2GzPRutlbRpTHKc3TQcZfPG8S/L+oHYVc7Nsn6iPiq5gaWYv/6c29Z9RbQ8hwC4GHpdTTG+LxSbUutmi0ryzv2bsQ747TRm4fPVIVpglFyEbVfV5Ci1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321242; c=relaxed/simple;
	bh=GjecpBH1xTn94qIZgQWgjmpZwS1YB4z2vSwqNMDIB9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IcmZwmWFwWeKZJf6pjzoUHaLcvrh9Cdk5CUFFNeVn0LkxdwBwN9n2o3O1yleF5YZ8u0Qd03PNoeLxfPwt53w/1XqAmD5kxE7TRvAOXvip3hI59A/v54j/511+og8Y4odwtG/FN0wfPiOm9e1mQDKtXmZ07VSDTOr92LUM4lDIuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKBS6jEV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKBS6jEV"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3D2841F00A3A;
	Fri, 21 Aug 2026 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787321240;
	bh=IeSQymyuwP8rOsJyZKQXQI2AMDhLlQ28DVhVHVPw+0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bKBS6jEVw6/sSA2BHkrWFKGb21GeWSyTGNm57uKVKZqRRDPbk0Jmq2CuW1l0mqT3R
	 ofKqQRg8aoLhWupvC3fZtYHMn6qjHEm/U3mmgCt+QNtqaHG/f+wGDbKbPQDleKikPP
	 M3YTMU+1w3mHaO/tFvtTYg+zw8vyHLbbhDasghfQXpk9NhCZFKxC/LFsK2gSLm4lsi
	 U7qe+c8hckUGSu8y0f9Zf6kEA1D4pXx4E6zGXCcOJnsjeUIMZfRW/P4qkpp5PQba5c
	 7wvvuGRMXBT/Y6Np1UHsD6WGyLQpF6RdDr/stvO84r/6RacKVD9C63eB4cnmDOeTc2
	 Y0IQhHJa7JGmQ==
Date: Fri, 21 Aug 2026 16:07:18 +0200
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
Subject: [GIT PULL] Base commit for
 devm_{atomic,blocking}_notifier_chain_register()
Message-ID: <aohZHuN68wIyaxWy@monoceros>
References: <20260816060648.4030-1-farbere@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qmfh2vthygwjdtsx"
Content-Disposition: inline
In-Reply-To: <20260816060648.4030-1-farbere@amazon.com>


--qmfh2vthygwjdtsx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [GIT PULL] Base commit for
 devm_{atomic,blocking}_notifier_chain_register()
MIME-Version: 1.0

Hello,

On Sun, Aug 16, 2026 at 06:05:59AM +0000, Eliav Farber wrote:
> Many drivers repeat the same boilerplate when registering notifiers with
> device lifetime:
>=20
>   1. Register the notifier with *_notifier_chain_register()
>   2. Check for error
>   3. Register a devm action to unregister on teardown
>   4. Implement a per-driver static unregister callback
>=20
> This series adds devm_atomic_notifier_chain_register() and
> devm_blocking_notifier_chain_register() that automatically unregister
> the notifier when the device is unbound, then converts 11 drivers to use
> them.

I applied the first patch on top of v7.2 for you to merge into your
subsystem trees as base for applying the patch(es) from this series that
should go via your tree.

Find it at

  https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git tags/d=
evm_notifier_chain_register-for-7.3

This tag only contains this single commit e38b9eda475f ("notifier: add
device-managed registration APIs"). I intend to include it in my PR for
v7.3-rc1, feel free to do the same.

Best regards
Uwe

--qmfh2vthygwjdtsx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqIW5MACgkQj4D7WH0S
/k52lQf/SSaOWkSYXKMtLPhk2tniUdDRYaQQKqCM8eM7DNAYMQ5ny4RwcPBa2HPx
kCeG2UF9tQ00N0UP7yOClWXul0KviSa6sc7/9IQHJrg7Irl6KGpEU78U9KBlzhbX
8qXTKxd37NjyBiNtSgMrDOWk1kM2L0t3ZI05sFohC9iwBzBnMlZ7HMFDmEX5F2EJ
bUmPO4bgSbIltqDIBHmIJbU9Z/4qtNjlnS//NuyvLc8bxe/eFT+TBaX1EMB+GEqx
J/NJlI5kzXTVpxqqBaLQprxG5+PgmFLucMLIhUJWCXU/6PeitD1+nd96cXei6Xfx
dE6APgTbM4m0zIOzE2+7vOOf9+kvMQ==
=rDi/
-----END PGP SIGNATURE-----

--qmfh2vthygwjdtsx--
