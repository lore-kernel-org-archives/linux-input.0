Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5A423EA2;
	Tue, 18 Aug 2026 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787041616; cv=none; b=mMqLKQBWNytxT5DsboPIsyBdiUx+ZDb67H1xk/GZbdp4xheAcB0Z/dD1wa9HxfbTlvziWI/J5B1OYAYgC2bsHAEKRmbsaDaDJ8jkX6NDZ1zBSUxsVcgAiB/6ceccNH7m76uI3xefVMKz0BMpRDBbYq2tvY3fNhCx4SOM5If+lVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787041616; c=relaxed/simple;
	bh=4phCkJfenRg107fZkQ7iErF8Bl7JZhhxA3UMBCXdsDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bavtO4DsUUfXSCh0GqsF9gggPjf7r534yigBwhull4JbIocPfdtWwmNLH08rPnQd9A4aEAQ5lggnbjn+wc4UuXsOAv3pE9BnxFX8h5Wmt9+9RW0R2PW2Unj7nRpT4agQnecTttcHu3f3tWLw+FHJ0VYsobBrc/v/gHNc7KuhVZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yk8utEmC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yk8utEmC"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8D4181F000E9;
	Tue, 18 Aug 2026 08:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787041615;
	bh=4phCkJfenRg107fZkQ7iErF8Bl7JZhhxA3UMBCXdsDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yk8utEmCxy96+toKCErkoYApQaMdiPS/mCchSNuianQYv5m27/NqvByr5wIHg/m/V
	 JYPws0OalIunJ4Yd2Snp/HnkIw1rSMOTd/6QctDhGAOp0jvQrHwF0n9PaeAGt00qC0
	 saa1+8NO9+GG/Co8K7GGanrbgXB+dSdO7Oxcz2iFPdZC6CEgC3Yj9aPfTOcd+dIN8Z
	 +LT3Vfdjc4SKL6Lbp/+x2xuv4GH2gVaRlGE3hHt8WEvPCMdOBXAxXd0WAG3L93H+O5
	 nZwX4r8hyUboRXsOUUNS71jbX+QUFn7K0le4nTVH+Oymi6Gwb5Ng2kBuVnesHYQesU
	 PTDG5N+c0BpDA==
Date: Tue, 18 Aug 2026 10:26:52 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Linus Walleij <linusw@kernel.org>
Cc: Eliav Farber <farbere@amazon.com>, rafael@kernel.org, 
	tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, mchehab@kernel.org, 
	xueshuai@linux.alibaba.com, lenb@kernel.org, laurent.pinchart@ideasonboard.com, 
	brgl@kernel.org, orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, 
	zhang.lyra@gmail.com, jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, dmitry.torokhov@gmail.com, hansg@kernel.org, 
	ilpo.jarvinen@linux.intel.com, W_Armin@gmx.de, fabio.m.de.francesco@linux.intel.com, 
	kaihengf@nvidia.com, ankita@nvidia.com, leitao@debian.org, pedro.pbg@usp.br, 
	paulmck@kernel.org, frederic@kernel.org, kees@kernel.org, saket.dumbre@intel.com, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH v5 01/13] notifier: add device-managed registration APIs
Message-ID: <aoQWOsPeyU9o3Ahn@monoceros>
References: <20260816060648.4030-1-farbere@amazon.com>
 <20260816060648.4030-2-farbere@amazon.com>
 <aoFgF2E4p4DqYLGG@monoceros>
 <CAD++jLk+MMH=-ifdSs=Vm4G9RO5-yVs8NLUb4AE1wYH5FQrmjg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="atk2on2uarby33p4"
Content-Disposition: inline
In-Reply-To: <CAD++jLk+MMH=-ifdSs=Vm4G9RO5-yVs8NLUb4AE1wYH5FQrmjg@mail.gmail.com>


--atk2on2uarby33p4
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v5 01/13] notifier: add device-managed registration APIs
MIME-Version: 1.0

Hello Linus,

On Mon, Aug 17, 2026 at 02:10:13PM +0200, Linus Walleij wrote:
> On Sun, Aug 16, 2026 at 9:04=E2=80=AFAM Uwe Kleine-K=C3=B6nig <ukleinek@k=
ernel.org> wrote:
>=20
> > I suggested to add "Must be called in process context." to the kdoc for
> > devm_atomic_notifier_chain_register() as this is a relevant difference
> > to atomic_notifier_chain_register() and create an immutable branch for
> > it as a base for subsystems to apply their follow-up patches. I'd wait
> > till Wednesday for concerns and review tags to tickle in.
>=20
> I think this is a good approach, but we are in the merge window,
> don't you wanna wait for v7.3-rc1 and create the immutable branch
> based on that?

My thought was to base on v7.2, and then consider the topic done for me.
=20
> (But Bartosz will be the one pulling the immutable branch...)

It shouldn't make a difference for him if the branch's base is v7.2 or
v7.3-rc1, still more given that there are no changes staged in next to
the affected files (`git log v7.2..next/master --
include/linux/notifier.h kernel/notifier.c`).

Best regards
Uwe

--atk2on2uarby33p4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqEF0QACgkQj4D7WH0S
/k6+ewf/TQPKKAWHFqB2guxJQb4tJtqqrt9CfxNlHgpRy98IQr+Wzsclp/2b55PD
+Vt8rK1QzYpoCbHNgn48yp+ZwOgUgZLGuFt1oOMJuz4TML4VoRQW/KQBjYb8RH6h
bZwXKf20jhh0jcWWdq+Oloo7khDa3AfPjzRMezSt63HtWnFWyDBFmk+Hpj2iK5wV
ydEynNxomqrfrzujN4nShzkby6/nearXk+4xXCvj02C50nfaHCtzBWc07ic2TP90
xDPXfb0bl2EHmQ7jRNKDBne2D3J7gm+NVDzSblze4JXAuRSbDl51QXnnQ49Me8pn
JJE4fMKe0QjKuFoPX4pzR1Up39HZcg==
=T8Ew
-----END PGP SIGNATURE-----

--atk2on2uarby33p4--
