Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985562;
	b=ztJXI1GPZ4Nw9RfZIVtS0X8JZhp99K7DGzTkuMsdk9lf4q0hFPEswVsZ23Bria5tmCot
	 TZyGH7KcGwo9ME88C+6Oe+98bceOkEQmEnAWTsv3BpivbhlX/hO+3Uu4vkEQbrRC22dxm
	 sw/BXYfHQs/3nNVpNN73fEjfkk4EQyeh5IQ0NQhxO9OT8GLMQmk7bdZtCzHR3WuUZWPO4
	 bL/EBh6aYn0IhPN/FjXfuIQel1wSPMedsNnhTqWbFJVaKJZqk2SXNsOrG+7vIaQ5wrBk1
	 oYv6cd3NEoeQLk2+rt/tas2c10rShWK/hShGghPxASOL4Vud/fm062fxFvfPvhvUuGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985562;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CymQonWFYCQ77NhQYH0iaDwl4K5oygBmO1SVq0VoGNw=;
	b=Z5tM3ln7QLddv/mY4Q7NKOAkr3/hEGYgGjZD0tV2psIHWPcVFVmfkjBf3aNONyMPJoYj
	 hVu1oWQJj8Yq7BYBN+X+8vhe0oIROHEivXWzcFVHjI9SE5jcTj0gpdyGqfh2VhtSDzdkW
	 Rg+gHfA9g/ZnIdVFbgaOP9ZtN+mKQUsmGlqD4wd6qQ3NpWTwI3D5jceTvxq10o/V9Kqso
	 6+0UgMClNkfGkIhSJ4V8Jx1WiY2rOnxi5xiXa19MbuIrKK4qNTw0KSkI7PlLNWsKqqCS6
	 p0IbU9VnD76mhWUpYTM0kSlUP4YLvnetY9H9zf0/uS9LonNC3OB3q7jrnkBxRmjufmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eTrgT/hU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FF4606A31C
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 07:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTrgT/hU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFA41F000C5;
	Wed, 18 Nov 2026 07:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794985562;
	bh=CymQonWFYCQ77NhQYH0iaDwl4K5oygBmO1SVq0VoGNw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eTrgT/hUjGnAU8rUl2VQc/oMj0+9RH/whsWQTl0D0L3mtvy1HLw+ZtB4yFkPKASuk
	 aNzIsFhI4u18z7N+Hc4jO4DBbwJNYJjWJqhlh1k6H82jBx5WRSGBveGbrnztaioTDZ
	 l2nowKorpXdBoxssvwzuwB0wZuZYewFAncAPaOHIDgEcibNXncXoOSqnw7bji/lWwC
	 GEVoEocZ95862bjmP5ugR3G4nG/xQGYPJyrRk63cRvShWQjeqgN3miuOOSCfCE1LeI
	 54y6xHvuzwmZraViT6Ms+Nwc8t8DpXZy6HrnzW6CJ0KzhgT7jo3FpxGIJkpZQDpKqg
	 GWZGFNOKsIESw==
Message-ID: <sashiko-outbox-220287@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] HID: intel-thc-hid: intel-thc: raw spinlocks for
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emfox Zhou" <emfox@debian.org>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <20261118065704.672557-1-emfox@debian.org>
References: <20261118065704.672557-1-emfox@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 07:06:01 +0000
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
- [Low] HID: intel-thc-hid: missing Fixes trailer for thc_regmap_cfg raw
  spinlock fix
--

commit 68e15b8b74f173320164f31790193df2ee43dccc
Author: Emfox Zhou <emfox@debian.org>

> HID: intel-thc-hid: intel-thc: raw spinlocks for registers
>
> The primary interrupt handlers of intel-quickspi, intel-quicki2c and
> intel-ipts reach the registers from hardirq context. The map is a fast_io
> one, so its lock is a spinlock_t, which on PREEMPT_RT is a sleeping lock:
> taking it there is an invalid wait context.
>
> Ask for a raw spinlock instead. The accessors only touch MMIO, and the map
> is fast_io precisely because it is used where sleeping is not possible, so
> nothing else changes.
>
> Signed-off-by: Emfox Zhou <emfox@debian.org>

[Severity: Low]
Since this fixes an invalid wait context when accessing thc_regmap_cfg
from hardirq handlers, should this include a Fixes tag?

  Fixes: 1b2d05384c29 ("HID: intel-thc-hid: Add basic THC driver skeleton")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118065704.6725=
57-1-emfox@debian.org?part=3D1
