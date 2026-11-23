Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795459366;
	b=YorcTUxQnJX3KEI2ame+Q9CxTmHCR0Sfj1LO5lfIM+s/I7To3BKZUbginFgFghj4utb9
	 5pwEy+rSfQ+QptcJOK8RsE42n97x/gnPf0nh9uduthsdozoZCLET+rphBhC+/4jHvGckL
	 DJGiXYJyjnaUBt/2fnaSEyuIUJE5ddkQaISbsh25aqE8cqTuU5HxNmd4qyePFBNMhjlM3
	 EcwNosyyFB67O55qhiuvGZARbFuDmhKu6cl7EjTNq1FMIgjyFPtmj5eeMuUzO5mjzRg9n
	 p2LkR1lw4jj9TYyvVkrkvMysw35SMqlzuaymezBUID0s/tZiTe4of9e+fz+1Z+rYeAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795459366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7WsB1+VjhTHPtF4UIEaDojbgif6u1UgUpBxjIi1un+I=;
	b=ERJTwBGZ+DS2WceTeoqaI34U1t6TfQJg6tQjQdF56TeQoO/ehpXkL4Ab7dCLzlLW69Ga
	 R0NlJwMhy6XnUu7jRth2CNqXhqEVeE8exkz1ausPuMEKLBQszSi2ShKTL/pMZzE810Jvj
	 8s52Y2nwJKmiYBokH+2IMnw01HjafpRh1GXRjYA2aA/MNtNbctbHrcIP9q6xRW4Vhrpo/
	 pdFIq66KvJYyFd1Yrks2hmrKTSJZoLaJIZLatsjSJRStak7saHttyMu0FTCkfOqbXulsh
	 LA8WHCJWs+5EFfxE2tqMvj8RDgbyQmPr2HywNkexGbYSsnSV0Ht7P8oNltHh12o1wJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iy7hSwyd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C1A606A31F
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 18:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iy7hSwyd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D291F000CA;
	Mon, 23 Nov 2026 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795459366;
	bh=7WsB1+VjhTHPtF4UIEaDojbgif6u1UgUpBxjIi1un+I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iy7hSwydipRM900sJIj0G50tzghFgTXVUc34JqQfRLTj9rNxHqugU3lPSP1Aib3oc
	 kC75dG7X4TRYyZlCwpdraJoJ4Aba5qSLy0ayxWSPOpwkZ59ja1wjmBPKwl4YL0at4O
	 p0oaq8ErOu6H7TQ4Zpvy3wQBiei0ICMbN+kDx66AfYpX+56GbSRJ85LM7WcDc7Hhw4
	 IXlL3meTofVzCkPofkXV7AuexE8oWzZcxWdmF0r+mJeUiOO/6+LhpdxJ9RMgXL0BZ8
	 JYwpk3qEQLLanY0eh+zDLVWnMuTBd5ufijgLQXI9zZwwUkEfx1dH7ln5H3bZ1deasY
	 ozyO56CmXIJ/g==
Message-ID: <sashiko-outbox-229858@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/10] Input: matrix_keypad - only stop and start active
 device across sleep
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lee Jones" <lee@kernel.org>, linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com
In-Reply-To: <20261123183200.3900004-5-lee@kernel.org>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-5-lee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 18:42:45 +0000
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
- [Low] Input: matrix_keypad - Fixes trailer cites 7d0f351da460 instead
  of bab7614d6d1b
--

commit 6307b7026ba23f150e88470188dcf8ceefd4969d
Author: Lee Jones <lee@kernel.org>

> Input: matrix_keypad - only stop and start active device across sleep
>
> matrix_keypad_suspend() and matrix_keypad_resume() unconditionally call
> matrix_keypad_stop() and matrix_keypad_start() without holding
> input_dev->mutex or checking whether the input device is active.
>
> When the keypad has no open users (or is inhibited), row interrupts are
> already disabled and keypad->stopped is true.  Suspending calls
> disable_row_irqs() a second time, unbalancing the IRQ disable depth, and
> resuming clears keypad->stopped and schedules keypad->work.  If the
> device is subsequently unbound while still unopened, Input core skips
> the close callback (matrix_keypad_stop()) during unregistration, leaving
> keypad->work pending or running after devres frees struct matrix_keypad.
>
> Acquire input_dev->mutex in both sleep callbacks and only stop or start
> scanning when input_device_enabled() is true.
>
> Fixes: 7d0f351da460 ("Input: matrix_keypad - switch to using managed reso=
urces")
> Closes: https://sashiko.dev/#/bug/linux-340f2a74-becb-415d-b1c2-6da8f05a8=
bd8
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

[Severity: Low]
Should the Fixes tag reference bab7614d6d1b ("Input: add support for
generic GPIO-based matrix keypad") instead?

7d0f351da460 ("Input: matrix_keypad - switch to using managed resources")
only converted allocations to devm_* and removed matrix_keypad_remove(),
which never stopped or flushed keypad->work for an unopened device anyway.
The unconditional matrix_keypad_stop() and matrix_keypad_start() calls in
the suspend and resume paths have been present since the driver was added
in bab7614d6d1b ("Input: add support for generic GPIO-based matrix
keypad").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123183200.3900=
004-1-lee@kernel.org?part=3D4
