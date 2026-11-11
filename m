Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355573;
	b=Ul2bYylyWtUKqDZtS6ztQgOPSTWnyFJ46JvuPAOYGObBuNWKdTJpn9NvbwqeRpi9Zblg
	 qrP+6abjNY5h91qsjzBY8YSP25bl06s66/zlv1zVA/BNe2nJk1RVULaLY8ks+gBY9oP+0
	 bZXCSa08xPLOeYw8vnO4QLpBUdMe3VtFKfwxjSxJpkyjWKBmEunVShdYbYwDQcAK5rxM3
	 qGWvK1lDjpUD7RuGe6Iyb2Ocg0Z5HL5HEcTNfoxmTmJXjWc9+z4csOOeReYK9kg3UaTEN
	 28uY4+1w1MxJOuxXtQGU/EvWQSTNuwoNgRWpO0so4V8ukWw/jdSxKPv444spNPu1XCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NLZ1WD3jYOS7elxx3BMoba1XKaw7SRiEiA7ccNV4Mjs=;
	b=IwDEF8mBZgfA8Ul1TK3jjRF6mr2hwQs8iKn3Cbo5g3TymEy9ACrNRuM8IvtDaopoUyok
	 tmOPzlbwopP8cCQ6+/fzbVpFcow7SC2WvQdC+EP8KRrTbtAstX7CZnV1eDAYlj09/5gFV
	 7lV4eL4q4A+Ip4Yc67gmQyvK3xsH+8veLMovptUUyasaty5iqr1ahl1ru/JSTQAuMUTF2
	 tcoyYf5jpMmRsmmkJlpFAyaLMIIvqXm6WiWxURdUq8KySVXnsnfzOjKpCu/HZ2vrdnFcL
	 5jNxBh69GvtOZaxODXgxrN3Qlo30Ktd4clrJDWxOOW+5XFSd4QPPrWRnvibRvmxmpUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+FkDHo2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3D460A3814
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 00:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+FkDHo2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157B51F00A04;
	Wed, 11 Nov 2026 00:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355573;
	bh=NLZ1WD3jYOS7elxx3BMoba1XKaw7SRiEiA7ccNV4Mjs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+FkDHo2xyFL2qxysPkK9QLfGBmAcj6whYWXcsJvsHhiP/cyKoK4SYxZPBM6DBYKc
	 KA/CPQ7M5bPcdVrq2ymtguKtDPsHoWtwLaF/Tak6TscmnShGcTMw+ZHX2VbVRMuKMC
	 S2m4joGrKepc6D+C8aAAYmC06QL6AwZetg3bIbI8tGiILnlViJGCZvS3sttq13XkUq
	 Hv4/DLgCc/1qVZuV3FdVrNkSIWQGhpx0IyDUVVVt/AdLS7l+RgcpjLn7mJk2ZRZuLS
	 aO5HWtE9upGQfYK1I9DAAmGZMNwW4GCQeX7sfo1pTNpiX5lzTV0Mkc5upoAUIEZlyS
	 102xrpo0LyanQ==
Message-ID: <sashiko-outbox-207997@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/9] HID: haptic, multitouch: Fix haptic device
 double-free and unnecessary allocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rong Zhang" <i@rong.moe>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261110-hid-haptic-kmod-v2-4-b835a067cb62@rong.moe>
References: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
 <20261110-hid-haptic-kmod-v2-4-b835a067cb62@rong.moe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 00:06:12 +0000
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
- [Low] HID: multitouch: Fixes trailer cites wrong commit for td->haptic
  allocation
--

commit d6cf865be3d7088ec7c4976c069b5aabfd168691
Author: Rong Zhang <i@rong.moe>

> HID: haptic, multitouch: Fix haptic device double-free and unnecessary al=
location
>
> The haptic device is allocated by devm_kzalloc(), which will be freed by
> devres on HID device release. At that time, the ff core has already
> freed it on input device release previously, causing double-free.
>
> Allocate the haptic device using kzalloc_obj() to ensure its release can
> be safely delegates to the ff core.
>
> The allocation code is also moved to hid-haptic.h, so that it can be
> replaced by a stub in !CONFIG_HID_HAPTIC builds, eliminating the
> meaningless alloc-and-free sequence.
>
> Fixes: 344ff3584957 ("HID: haptic: initialize haptic device")
> Signed-off-by: Rong Zhang <i@rong.moe>

[Severity: Low]
Should the Fixes: tag reference 8d0bf7908b5a ("HID: multitouch: add
haptic multitouch support") instead, or in addition to 344ff3584957
("HID: haptic: initialize haptic device")?

344ff3584957 ("HID: haptic: initialize haptic device") only added
hid_haptic_init() in hid-haptic, whereas 8d0bf7908b5a ("HID: multitouch:
add haptic multitouch support") introduced the devm_kzalloc() allocation
of td->haptic and the hid_haptic_init() call in mt_probe().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-hid-haptic=
-kmod-v2-0-b835a067cb62@rong.moe?part=3D4
