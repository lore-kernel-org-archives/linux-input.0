Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707805;
	b=gtT/024IytdqDMIrXULf/KcQ9gnHaXGotllQ4y4/321vLBJneFvGZex49ieaMjzt/3Po
	 yoNuV7AVN7nMU8sFfWxZ5fPRGzHuPJWnSbmMHzuV87naA1HTRSVSZ6yZMvDrXyr8Oc/5m
	 +Uo63Vfs0Rtcz0j8LmITZTRi2JsBZC70FOz8Z7lW4KtbFm99dQxXGJg0m2hcBIdzIwLHU
	 ohKws4wHVurCzXHD4eAkURtztHXkn8/DoRzTy+Mvzo7OtaOeID6bgzMmr4H+a8HmTviLD
	 h63HpikPPfsPygbA7b5CqLVTtr1fmR2GhWq7mZsfJfMfeqNxmNiytV7vShbo6P+c5zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707805;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/BlVBHSxJv2ET0qlQHANl+bMWvzegVT/jOOJmEetwnQ=;
	b=pDPOlQx8ZIfh1jU8cR0Y+Qc7KGGzwFjfrV+ujspNLAB5LJVw+0mkSDrVp20euAwCgDsa
	 A79u8dpTcoJ1hEJ6GpNmm/qePDbCFCZGC9gcaYBAK7Ht5EYuLJeRS5cV/S49QeYU+vmY7
	 YJIhFHpSwjMCljF2KQz6xF/kNQNrM4sodB1OCwTcc+wnOC6hiBCjEqcq+Qdu7oSPQ0ItN
	 OixjAnb+9LJ2w50zwnWyzqc9Abl0ggj4hCyJb7xNIzPonG9f4eNDN0p5RQugptEUxva6Z
	 vT/jsuZs+h9fUz/t0wf261nD2CI74T+KpuJeqwUwj7rW6LF2KCv7yytUuZzzTxEMf2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mz808wnL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC8C606A31E
	for <linux-input@vger.kernel.org>; Thu, 26 Nov 2026 15:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mz808wnL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3371F000C0;
	Thu, 26 Nov 2026 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707805;
	bh=/BlVBHSxJv2ET0qlQHANl+bMWvzegVT/jOOJmEetwnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mz808wnLDg7uTZdUUQvO4vgSpakW7mJwm52H8dXKnoJeOcbqIijUU3W4LHnkdz0se
	 V7sTZGAvESwJqDeKi8lRmD3qIV3GBwP7KLhMsV2thTgf08lpWcBM8llloMNDkqQsR4
	 7XwN9yiSAKD3iHj/qyU/3+tddtDu7tE29xpaQEz4rcvV5N6L2sBapLkf8X7XwlQIFX
	 j+FOmiXizsPSkY9sJ+qpua/aDnK0sYTR+ANSXY9FxO9ICt6NFp6DOgwoDrplxkPz4e
	 jp/NkhytqRf9Y4/Rtb1ow2fyjCGnO9OgFPRgqpSd7Cxt/ZM1mCOKKpQ9o2j9WpifjB
	 MuFmOx0Dyxzyw==
Message-ID: <sashiko-outbox-235837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] samples: uhid: use a non-zero version
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matteo Bruni" <mbruni@codeweavers.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261126153925.9488-2-mbruni@codeweavers.com>
References: <20261126153925.9488-1-mbruni@codeweavers.com>
 <20261126153925.9488-2-mbruni@codeweavers.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 15:43:24 +0000
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
- [Low] samples: uhid: missing commit message body explaining version
  change
--

commit b598874f0c3fc14bd39419791a866f90fe35b69e
Author: Matteo Bruni <mbruni@codeweavers.com>

> samples: uhid: use a non-zero version
>
> Signed-off-by: Matteo Bruni <mbruni@codeweavers.com>

[Severity: Low]
The commit message body is empty.  Could a short description be added
explaining why create() sets ev.u.create.version to 0x100 instead of 0?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126153925.9488=
-1-mbruni@codeweavers.com?part=3D2
