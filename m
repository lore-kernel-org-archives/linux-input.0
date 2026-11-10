Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321490;
	b=cvzY1PfUivoEwU9iq6FuDvkfo73XhIP46KUMJfN9rgj8MWbB3eqyoG//vd45/eZk/kEK
	 nhqY+3txFO642WeMyawmthgveIqyNb6c5uptv4RBVCmmFzCa6syAA7giT3QBGZubYW3im
	 wi4zf4HR8sbk4RqvwdOZPXz5hEStTXJq7ahSsYpqJznP+Wnr83Ji616jDGfOcxsdIz8qS
	 +/j6aynr70NMIz+vcNKBzh94vgTL2bJ717ic0XPtELJY4V98J+cCXtHZicc3aI6piVsZT
	 YupZiBd6AXtEedxRKVUS9m+hZ9xyjzh0yXqHGiXxVw3bS0qb6+t2KZO3SMCdT790nvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321490;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XCQ4BpmbSEaUSr01Uk+YaKL7h9w454CVbTPcasGsk4k=;
	b=W0htm9wCEDH4MV6GO4R9aScj19WwWnQMaXm39Z6N40CWy9ONW1ChI3tTHj6h6thBO00g
	 gSnDTlwquqx+flvqx0f0gTUwGWFnIMG/cPqGT8ykc0Xv4UCjXiUOpIrHcVRRApclJq/SV
	 GUGQCstCxiSIVt00chYPlOqmJbZ+OItcjlQ3Nq5WHxBZ6x22VdSm2ogKs9PheDnCMYVUC
	 k2pzHuEYpJsXH/4TL0zaL1VlEN8jUb9tIxceELmDdVidqTX5NfaE/0YN6x3Joe1FRVshg
	 LP4rk/gS2WXmPm/EbZTFZuUPFKD/dpRElkOtmvDVW5WlY9KcLyTvhy1KpXyIdcYRaDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nu9TwdKD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD26606A326;
	Tue, 10 Nov 2026 14:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nu9TwdKD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206DC1F008A2;
	Tue, 10 Nov 2026 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794321489;
	bh=XCQ4BpmbSEaUSr01Uk+YaKL7h9w454CVbTPcasGsk4k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nu9TwdKDDj4ZLDpngm0UBd3cXjDCHagZoIYopSe/FcT85cn8osmuetduIBWlhcg8i
	 y6gXzK4iSofa7BuQaZhgTOBLu+XJzIvAhDdhCq9Zj7BwIdtUyGnO0e/5nsm5BHv6M8
	 VRgi2rV5oN5zYPdgRJrcbJ5dQtGp5ZQKNprky9aDehtwxHBceFUWM27ijWktWE613T
	 ivcvLi7t3xxzR+Dmy4AEA+7XSd417AG0H+6z7J06/EV7Sg7jc3QOZfTamrupq/lrim
	 OE/h6oh0ZF+39Cgk8iJ9SDP1upGQPD3KaYwGJcfW5l6J0JMCdtQG2vXu8kAG57e1Og
	 5V94jXISgnHng==
Message-ID: <sashiko-outbox-207200@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] mfd: mxs-lradc: Pass parent IRQs to child
 drivers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fabio Estevam" <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, mfd@lists.linux.dev, devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org, dmitry.torokhov@gmail.com, lee@kernel.org
In-Reply-To: <20261110141934.42490-2-festevam@gmail.com>
References: <20261110141934.42490-1-festevam@gmail.com>
 <20261110141934.42490-2-festevam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 14:38:06 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] mfd: mxs-lradc: Fixes trailer cites driver-core warning commit
--

commit fbb3c430756f909de04d8f2ea7a88e5473612cd3
Author: Fabio Estevam <festevam@gmail.com>

> mfd: mxs-lradc: Pass parent IRQs to child drivers
>=20
> The MFD driver stores raw DT interrupt indices in IRQ resources but
> registers its child devices without an IRQ domain or IRQ base. The child
> drivers consequently receive the indices as if they were mapped Linux
> IRQ numbers. IRQ index 0 triggers the platform_get_irq_byname() warning:
>=20
>   0 is an invalid IRQ number
>=20
> The children then try to recover the indices from their resources and
> map them against the parent OF node. Besides duplicating IRQ names in
> the parent and children, this relies on invalid platform IRQ resources
> and fails when IRQ 0 is rejected.
>=20
> Resolve the interrupts with platform_get_irq() in the MFD parent and
> store the mapped IRQs in the shared LRADC data. Drop the child IRQ
> resources and duplicated name arrays, and have both child drivers
> request the mapped IRQs directly. Use the MFD memory base support to
> translate a single relative memory resource shared by both cells.
>=20
> Tested on an i.MX28 EVK. The mxs-lradc-ts driver probes successfully,
> touch events are reported, and the touch-detect and LRADC channel 7
> interrupt counters increase as expected.
>=20
> Cc: stable@vger.kernel.org
> Suggested-by: Lee Jones <lee@kernel.org>
> Closes: https://lore.kernel.org/linux-input/CAOMZO5CgTzo6GuXptD4mFTN=3DUs=
JJqpkixDW1Q64gqZGrij8+uQ@mail.gmail.com/
> Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invali=
d")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

[Severity: Low]
Commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
invalid") only added a warning in the platform driver core when an
IORESOURCE_IRQ resource has start =3D=3D 0.  The unmapped DT interrupt indi=
ces
in the MFD cell resources and the irq_of_parse_and_map() workaround in the
child drivers were introduced when the driver was split in ead25133e935
("mfd: mxs-lradc: Add support for mxs-lradc"), 6dd112b9f85e ("iio: adc:
mxs-lradc: Add support for ADC driver"), and d81ca730e3e4 ("input:
touchscreen: mxs-lradc: Add support for touchscreen").

Should the Fixes: tag reference those commits instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110141934.4249=
0-1-festevam@gmail.com?part=3D2
