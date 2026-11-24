Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795510508;
	b=YibX+8MCI5BizQ3VL0lTpz9f9z762ILcDQlNVgRGV9IcE4mEWqTOzOnen1nfcCpthG0h
	 9jYXMvR1RPq6seLPMcC3Pt4EqMBSlGzzpiyorR0MfSi99/FJRdUZz178vmxnaJdReA8hr
	 XukzlfNbyR5u+tmEptBcPs1tL7OUzYJ3HR14rJ0Ge+1v7Jhm8bXxHC6e6FKBDCTvvwdr2
	 l5IUZAV3ZsLQDDuR5Mv/ymHLXFilVh4HTSoTbDc4byhQvKDshFr1Wln6LHb4za5DAcULa
	 2YryHFkJYGXDIZX5WOdd3MK1JifvWcDmyMaOg55Vw925c8gu34xouvu9hvqyhJlopzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510508;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9wIYpuAFMh3kCRP2N3Kgfhsm7i96RfGsv76juHkza2E=;
	b=YOvqBFuxw5/GIg5pVNflrl0xCIVob/g3y5dKuSr7iWKcZI8iftgaw4k+TRlpHVlRZU4V
	 +aR2c0EdOmIZYckrbXaGx1trBJT+jvFSlrKat2oDlOXjapbDlq/+a5jRaJGhW+U2bBipN
	 6baiQWpFMRf8bE1JdO6V+o/aD7kCNBeNm8eAl13I7bvFv5d8sassRdAVMsVfoUkpK5yu+
	 viosxPvcmSjVXNFuUucONEFniAu7s612TfOYxCH2Cqu2Tq2wbg+qMW6Tmt+IccdxusRgE
	 KS0LQ9gSi9Jbba+hSwnAu6OalexAipNTxDG1UDfZLPczPMkXdl/8qlIRzF/S2oPS0nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XvZC5Wh/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048B2606A335
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XvZC5Wh/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8234E1F000C6;
	Tue, 24 Nov 2026 08:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795510507;
	bh=9wIYpuAFMh3kCRP2N3Kgfhsm7i96RfGsv76juHkza2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XvZC5Wh/xznHg3xPt6xVGkNaavfrh4ZNOUlGWCcmSozvcnTIbbEZcOnYr4gncVKoh
	 qIq3lUXWLXDM0+pal0KQuHcDrNthTl0MYb3X3DF4owUYmOGAbIYEO2t4E0W+48+3RS
	 74z1v0DPfnJNCgCslpfl9W0+W6ZZSB0rr+NUNgz2YyqnvP7b5SE7PP72F/yXMqbVVD
	 bciQo6vBq60F7gXoIj6RckSEStroPVGqRj+DtGTAMMOnmMrWfORasPEudJ/ViVWuxX
	 JST3cSBmbEdMxB9KcyxfS6wi9B9irLc8oklTchEGkHMrW4WR2Q8sOPy0hqtaE+XwyX
	 y3znYUxh06d4w==
Message-ID: <sashiko-outbox-230752@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] Input: goodix - sync the irq controller while
 starting firmware
Reply-To: sashiko-reviews@lists.linux.dev
To: "Luca Leonardo Scorcia" <l.scorcia@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261124085058.128173-1-l.scorcia@gmail.com>
References: <20261124085058.128173-1-l.scorcia@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 08:55:07 +0000
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
- [Low] Input: goodix - missing Fixes: trailer for commit 09182ed20c04
--

commit d918ba5a6383fc7860788d1a29ce075f8dc1159e
Author: Luca Leonardo Scorcia <l.scorcia@gmail.com>

> Input: goodix - sync the irq controller while starting firmware
>
> On the Lenovo Tab E7 (TB-7104F), which has a Goodix GT-912 touch screen,
> the touch screen fails to come online after loading firmware, printing
> the error "Error reading 1 bytes from 0x8041: -6".
>
> Comparing the upstream code with the Android stock sources, the existing
> call to goodix_int_sync should be moved between the upload of the firmware
> and the watchdog restart. With this change the touchscreen is correctly
> detected and working.
>
> Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>

[Severity: Low]
This fixes the firmware startup sequence introduced when flashless
controller support was added.  Should it include a Fixes: tag?

  Fixes: 09182ed20c04 ("Input: goodix - add support for controllers without=
 flash")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124085058.1281=
73-1-l.scorcia@gmail.com?part=3D1
