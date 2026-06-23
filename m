Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E428364953
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 09:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208050; cv=none; b=YWToq+Zj0G8LdqNCP3VqQtwivS7HoaPROAksKU/QCDwGduGjRHI7YYjX0RNqtFLKpFthrqxzFe33ZCh8x0rnYXUrs2JHG0mzNm/X+Ve/MJXwqkVFnfWd4fbrVAoFSYWibUVZE80BfyuiN8e4FkjVZpw9gyo6xdiIb1HKNhbK+SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208050; c=relaxed/simple;
	bh=QsfZxOCYLJWHViiXddxykd6pe4c6t/Mgqo9JIJHYIVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjTUHIeuxjiaBgusDHCehBNtqwGCRQ7nj+KCFQBiq7Lst3ryMrWnt1DqZG0TxhBkBo3HbSr/Se46nMz+ixB0axaefn4jR6k3Ya4xf745od5n4yI3giw+uKj2ZS163v8ye84GnmGitrl4qyQHskkBpK+tyfEwhXZqlIoaA67Oxxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZJQAUj4W; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZJQAUj4W"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A7C32C6B382;
	Tue, 23 Jun 2026 09:47:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 305EC601C2;
	Tue, 23 Jun 2026 09:47:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58FFE106C836A;
	Tue, 23 Jun 2026 11:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782208045; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=svsFrqtxSjp3C0yInI8YXCcDmQTS9+zcNrmpSt8j/lA=;
	b=ZJQAUj4WYpKiXwM1Lh2zuSl2zjVUGkvlGUi/hINcYDl3nq3od6Mmqm5kaaTReqwnadylXd
	4rNL8iat8yqlgv+EWAMnsMk3F1baN9K8fRS4pk+yZ4UXMohTlII+F25TwL4Nu9YSrJAMWD
	CebgLxa/7ZZqIQB7h7dHuCAjo7kcP+2hmiGfZ6Y82rSkJYDV/ADGDelifIOVGyQi5Yb3ed
	lMYCwnNnknuFADiHDBry/gDZpsrp5FRm1nRk38lh15FsOA4FbffKDKqhtwM5SsTeynUXCG
	qt8ze3+n0Xgost3SqnXjFO/w2gDc/UA2FNvJ+PszAXIkRBYcbOiNkpy8KqwbyA==
Date: Tue, 23 Jun 2026 11:47:20 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, kernel@collabora.com,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v3 0/4] ROCK 4D audio enablement
Message-ID: <202606230947201406cc92@mail.local>
References: <20260408-rock4d-audio-v3-0-49e43c3c2a68@collabora.com>
 <wE1x9P2vQlC8kihOSm9uOA@collabora.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wE1x9P2vQlC8kihOSm9uOA@collabora.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Nicolas,

I guess Dmitry is the one that would take patches 1 to 3. You should
probably resend once the merge window has closed.

On 11/05/2026 18:21:40+0200, Nicolas Frattaroli wrote:
> Hi Alexandre, and other maintainers,
> 
> On Wednesday, 8 April 2026 19:49:38 Central European Summer Time Nicolas Frattaroli wrote:
> > The ROCK 4D uses an ADC input to distinguish between a headphone (i.e.,
> > no mic) and a headset (i.e., with mic). After some searching, it appears
> > that the closest we can get to modelling this is by sending a particular
> > switch input event.
> > 
> > So this series modifies the adc-keys bindings, extends the adc-keys
> > driver to allow sending other input types as well, and then adds the
> > analog audio nodes to ROCK 4D's device tree.
> > 
> > It should be noted that analog capture from the TRRS jack currently
> > results in completely digitally silent audio for me, i.e. no data other
> > than 0xFF. There's a few reasons why this could happen, chief among them
> > that my SAI driver is broken or that the ES8328 codec driver is once
> > again broken. The DAPM routes when graphed out look fine though. So the
> > DTS part is correct, and I can fix the broken capture in a separate
> > follow-up patch that doesn't have to include DT people.
> > 
> > Another possibility is that my phone headset, despite being 4 rings and
> > having a little pin hole at the back of the volume doodad, does not
> > actually have a microphone, but in that case I'd still expect some noise
> > in the PCM. Maybe it's just shy.
> > 
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > ---
> > Changes in v3:
> > - bindings: use unevaluatedProperties instead of explicitly mentioning
> >   linux,input-type.
> > - Link to v2: https://lore.kernel.org/r/20251215-rock4d-audio-v2-0-82a61de39b4c@collabora.com
> > 
> > Changes in v2:
> > - Drop HDMI audio patch, as it was already merged.
> > - adc-keys: rename "keycode" to "code".
> > - adc-keys: make the keycode (now "code") local a u32 instead of an int
> > - adc-keys: only allow EV_KEY and EV_SW for now. Rename patch
> >   accordingly.
> > - adc-keys: Add another patch to rework probe function error logging.
> > - Link to v1: https://lore.kernel.org/r/20250630-rock4d-audio-v1-0-0b3c8e8fda9c@collabora.com
> > 
> > ---
> > Nicolas Frattaroli (4):
> >       dt-bindings: input: adc-keys: allow all input properties
> >       Input: adc-keys - support EV_SW as well, not just EV_KEY.
> >       Input: adc-keys - Use dev_err_probe in probe function
> >       arm64: dts: rockchip: add analog audio to ROCK 4D
> > 
> >  .../devicetree/bindings/input/adc-keys.yaml        | 17 ++--
> >  arch/arm64/boot/dts/rockchip/rk3576-rock-4d.dts    | 90 ++++++++++++++++++++++
> >  drivers/input/keyboard/adc-keys.c                  | 88 ++++++++++-----------
> >  3 files changed, 147 insertions(+), 48 deletions(-)
> > ---
> > base-commit: 8de395f35e79d9168a78504fed495578ec7bac52
> > change-id: 20250627-rock4d-audio-cfc07f168a08
> > 
> > Best regards,
> > --  
> > Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> > 
> > 
> 
> What's the path forward here? All the patches are reviewed, but it
> has been almost a month without them being applied now.
> 
> Which tree(s) would this be applied to, and who should I poke?
> 
> Thanks :)
> 
> Kind regards,
> Nicolas Frattaroli
> 
> 
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
