Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82B2585973;
	Wed,  9 Sep 2026 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987528; cv=none; b=MVEzzThu8XtLRBoAF54XW1wP3MRVCXFvT5E/y0K+5jYrVWpOpfezo2RcCAR5nAC8mtnEqra34HEki47yhdENcwztvy2FyCEunB0DEfGTkfaN2Fe0RXwavLUkCWIoYHR7lWPlS4LTKOchPdXh2g+zrcM8nGwJCYZHg2SFaXasas8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987528; c=relaxed/simple;
	bh=T4YX0/YeQKFu1n2aj/247Lr1iHLs459EJU1boZffqjM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=doOdHudwq7g5l+Ar+T194f37cl52/lWwkE6qOl5+F1TXTDuIlo4akGhJSbblCZ47QLr8/32PSBY4kDW3xzAo3UHleJG+fW1krvlPzN/IpXfjXQgtliYFmWKRueL0ORjk4Bx5xkVKQdZVzTZqlBeDx/e0OQxu/uQd6uGcUJ35MJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUySngUE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUySngUE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30BAE1F000FF;
	Wed,  9 Sep 2026 20:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987521;
	bh=WLf3bD3M9fRfofQ2lgVpxSYxYNW4K7cyzG/C6m0f6Os=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=bUySngUElKIVPPaeTsPeuasSjPmvMwFvrL4fRY+oiz2Wl3PQfKeDyzDhLyLLvT7Rj
	 94WzEjIKOMh4BEymKPe+/31nvX0Bl9tj6E2KamIN4PIYlQszRuTnLMsCEbmWMr4j2d
	 jiUhuY/rzes8whqR+VYRU5WmVU0gqgWXOWMQAp3JUIajiUsOqWXlqlnIOnNGk7+VA4
	 McJtZLrzfHS75zp7QAaLUXQrdI32oU+mJ69AtOA3mFjWSZKUoQ1B0sDpmUeASUZmup
	 8XrEH+Yk7rUsGxCTnYXlcmAgaCeg9MTPnLDxo1AdF3EUYDp+mO7mtCRPMpd/aBDvyJ
	 5PWnoNuJWMxLg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id A408E198003A;
	Wed,  9 Sep 2026 16:58:38 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 09 Sep 2026 16:58:38 -0400
X-ME-Sender: <xms:fMihalj6z86RbPxvjDox6iD5bH0aV2RlX6LrnphgQyijY6BsngWvQQ>
    <xme:fMihak17J95UeADfFCejG71IZoWTCZMfnHSsb2KBT3IQgNKZWQbpMudbb2HQ2TOD7
    -6ZBP_JE5z4aDZ5C7zzA3gSFqAm3dWBKwqpE4wJH1o4y5HzVgD2RoUx>
X-ME-Proxy-Cause: dmFkZTEI0PP4Scmd59mEKuYPT6WYIAftppxw0Cj0RtyYPVhFKLGQ6ZQ4za+D8viqR+5YWb
    o0cbMra2wRzr1pAXHSzJkGhZFez5/oSm+iAvmk+3h85Tw4naH3TaedqTiKJSMx9+Hjw14j
    FS7Aadri1gFiGJffqeMrNoC5Z88Befo+G/vxIh3QrnPD7Ekyywl7SaBXt1wt//+VaoKfZc
    0MRq1SmAgFPC8r+2+i4AHH2Hk2GuTLsR1GMnsBjUlzji1oH7HxSg/MBYyp88HjmjvI7VOY
    c64EhYKOPh2PycyCMH4Jn4WScLwzrup1UJKoow8FZMfFzEpMQgZxHRp+Q2rHWFjUiD/sTI
    3EsQS/WKKn0b9/4zUQsJSPQyiWBz8Xi38OPH++J8VZMhP7thapItUFUuW1a9IeOxABSAWr
    4fJW7HMh+FwD3Y2y72ImuE5tcw4vKqg1wCzBG0JSYUZETyL4ucSIMDNy4TgUweGW7xBRHl
    HwM5kcnNn2d6ykTsQSNKs1lLm0Iz4TKR9GURzgarxhRh5Nvze8lNuU269Q3wHTqAmD7qSc
    0/0YbHbk4IqvvUqYY4HwH7+RK9I8c+B1eUcqsD+ALGBH2bPEzVicZWdIJy7JLSgnhJ91+D
    2D5vWn0QL9blWAKKe+FvV+hESeNM4pKPva7KPl1TvAgvIShdvLORULj/nWsw
X-ME-Proxy: <xmx:fsihaggEPEQCHOd8lC1odW-IPQOygNL7XpZ5RrHQRyKknY8vw_x50Q>
    <xmx:fsihalWxDk5Z4HrO9WtnzaVwFsb89o8jn9M_v7Cuxxmx6Dbn-fSsTw>
    <xmx:fsihapuB5Vn8cDP_balfG5dTsVmCHpkXiCmM_BioR2DmFrR1dVBHVg>
    <xmx:fsihauYvUqcyWCYejcMu4PKDy0-q_tGJ25JfIB_wzvFXHv5n9siWsQ>
    <xmx:fsihai6l8HNDuvTZEN9Uc9PpKXSn9m0KY62mtSjJU7iTiDyeLvYXg3Lj>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5362D32A007B; Wed,  9 Sep 2026 16:58:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A9f0ba5DxpVF
Date: Wed, 09 Sep 2026 22:58:16 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: media-ci@linuxtv.org, "Lee Jones" <lee@kernel.org>,
 "Rob Herring" <robh@kernel.org>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>, linux-rtc@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-input@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-watchdog@vger.kernel.org,
 mfd@lists.linux.dev, "Alexandre Belloni" <alexandre.belloni@bootlin.com>,
 "Conor Dooley" <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org
Message-Id: <786e24af-cf9b-452b-9ef4-4cc8952d4c8c@app.fastmail.com>
In-Reply-To: <20260909134355.5ED151F00A3A@smtp.kernel.org>
References: <20260909132153.1596191-1-arnd@kernel.org>
 <20260909132153.1596191-15-arnd@kernel.org>
 <20260909134355.5ED151F00A3A@smtp.kernel.org>
Subject: Re: [PATCH 14/14] mfd: remove unused iPaq micro driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Sep 9, 2026, at 15:43, sashiko-bot@kernel.org wrote:

> For example, arch/arm/mach-sa1100/Kconfig still selects this symbol for
> SA1100_H3600:
>
>     select MFD_IPAQ_MICRO
>
> This causes unmet dependency warnings during the build.
>
> Additionally, child drivers like KEYBOARD_IPAQ_MICRO in
> drivers/input/keyboard/Kconfig still depend on it:
>
>     depends on MFD_IPAQ_MICRO
>
> which turns them into unselectable dead code.

The platform patch has to come first, yes.

> Should the child driver source files and headers be removed as well?
> In drivers/leds/leds-ipaq-micro.c, micro_leds_brightness_set() attempts to
> call a function from the MFD core that has just been removed:

I have separate patches for the other ones in this case but could fold
them in here if necessary.

>     return ipaq_micro_tx_msg_sync(micro, &msg);
>
> The header include/linux/mfd/ipaq-micro.h also remains, declaring APIs like
> ipaq_micro_tx_msg() that no longer have an implementation.

Removing that file as well now.

    Arnd
