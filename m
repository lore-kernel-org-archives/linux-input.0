Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734E47B438;
	Thu, 23 Jul 2026 12:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808982; cv=none; b=Ke1261YmOAna01EKXREVjogwZb2va49Qka2Ik+rBSgtenS3qkALix/bsiGnzQI08BZy8E2I8s4lsZZRkrNC7Jm0kfJKoyclKhZ/4QfYj+p8tonEdilXuRmeWysZbodlDfemOA1oIce4V41D9T3v2cwcvrIsoxGXw1BK1ryZ7z0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808982; c=relaxed/simple;
	bh=acq9QW+tCPQn2F9KVZyz2gGwmTePtG0W0d6OAWN/S7o=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=hXdqRvJ/7hHDxhsL47j89m0EBFg6NXts6yp3i8g7QhMLNsEeHai2+LSEjtFRzKABG0enSz22CesflKJta3Qd9uZKi7rPQmTZW6hZHwGfoYh12MC1lqNve2i1PJ0WTb8YxE9NGn5dWLpTpiJWw4RerXbUTOKUltVh7k/Q4d0/hwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Cb9wKw27; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y8oEfnvp; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Cb9wKw27";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y8oEfnvp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 599EB7A011B;
	Thu, 23 Jul 2026 08:16:16 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Thu, 23 Jul 2026 08:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784808976;
	 x=1784895376; bh=14t1TMjpilEolEOjic5EqK38UqnN04B3EYUwaj3d87M=; b=
	Cb9wKw27mVzrxMFrlU4fyVHuF+S2gETLiFEsK+pMgEoJ9LWyKrCqmXgvP7E9As43
	j5yYnVJRkTRHKmJHFzld883AEq38VL70oQEPkpj1dl4FMLZ8DZ5W+x+7/QLHgdQ4
	XLJSWX+gz9eijQu5+tipUJquuJtWCpYBgBvFGoG10EikEAguXJVD0aNXpOOSwThe
	sYQDNkQ0B+c6r7ercUzdN32h4FQDJJce4RLTpKaxB4HCKJ/bAdZRAyT7zcClwmd8
	xG7rCTmeYKwU6HjMNJmH9x9/M7uiVgnTh7BU4V7brswwfA/lLvrGcpEahWJ+L1ZV
	AvSZX4TvNJ6iSbdYihlrbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784808976; x=
	1784895376; bh=14t1TMjpilEolEOjic5EqK38UqnN04B3EYUwaj3d87M=; b=Y
	8oEfnvpgVhxyu3UK7FO2qxvMsTow68OmxmJZeOl/Kyc5041IXfJii8Hjs3MGIVbo
	fxcsWyZ5CEcADix++OGI9yhoIWtoffH0khbnybkTDyLSMFSehkv3JFXMrXyczidI
	3PMSllmBVTWbFMBbEKtQUvGcR46hkNAx8UL+NWksDc8LvvP7SdZtlmTuyZhpBSmQ
	hesWwvaHsDNLwV9h3BrBIrf85Dj7c8S2ZRabljl/bDP//KD0+SzTefVh3ERi4W+E
	ZwHvJBAcZgjb4yu8cJZbbeXQk86qTXrRAsG1BPrD1YIVpxLfYmt5LYjHS1rowWjm
	alzlAZM7ycsYiff+pM7dQ==
X-ME-Sender: <xms:DwZiajWo49ll-8k1pScNhkNWd_w-_8V4xd7aQilAfgqdoK4SXKNdZg>
    <xme:DwZiamYQeTG3g4jRv9vxey5YsKVKrPDkxckHpC8JeGN_9kC2DmHJ2f6vQxzf45sQA
    ZUELL-D1-cJgV9s2uBjBy2vJESsbdsimIewVfqmq3_og8mMSmsTgw>
X-ME-Proxy-Cause: dmFkZTGolp6pP6uLBUPW9eYTPUJ1Al3jJBVJgTCYLowGe3BUjsCn/s7NVePCr6l4BHwKKh
    BCKTY8DQoFb0j4Gkgnz1c0H/rT51jisr3iR0e7xuxyjVus6hCEA4uTbA4VybZoowj75P2O
    oBUsqw5DNxCXdFRRmNdRpkFjQ5Vww58ppvmty0/U3Ktx9XPF+0M3dgsoAyiK45mCRmqZTf
    aA8Tr3EK9wrsNR72sdhXo7W5B2t33K8p89SOVVjySSaRVjpClcThz5oVqjH5QU84nxfsnK
    /TyAR2Kgy9gEblFCWLGYi8l+ymCPObp90D0LYFGsIcCEiz8zzttzC5sTcCLXVe5ZXXodCJ
    JaEz2ZAxe+dsElqu1q37hSCuvp1Xq5g8R3pE7oyAlu/b+ivmgA4zJ7yEAbPjQiIYOMg5M+
    LLDTriYxG/iWV4TodUBsHGIk16fHlk+hTmPWYtZCC2YkO0M00vZ2g3QguGBSvCwRqFQi9R
    vucUlc9wvojzUbeKLlKS+vXRQUjfcKF/xSlGGOZ2XsZCy76tfSJeO0zESECEzyC/HKLG0h
    oW1wHvjMc9dvWsssjSboolk427q7mC09vDC1u/aybJw60HBrAuSL2kcEbEvZVeYxHX06Qn
    wo47gHARjgcawkGTKm8oQg+WstnEqMsqqVnhTxxPUJMaGscTQPrH1686rLxA
X-ME-Proxy: <xmx:DwZiaqH58u8u-O0Ta3wy492IALWYOnZjxwTLVvXZdaq9oCXVgiCxrA>
    <xmx:DwZiary2k1BQoGq--nBa9M7Coom7YdIBHcMc2sgrQBGho18MkRaPqQ>
    <xmx:DwZiapn5H1eNB0NcMabLo519JgZP2abrjsoPlzSozkoGWHC2PZmXSA>
    <xmx:DwZiaiATIbCAjw8L6jsyL9v9qplFDAKDWge6M7E6xW_aO7GyG8Y5kQ>
    <xmx:EAZiauxjKgivSxsmrlW3rPOtgrjizYqm7zuKuZQoDomwOyyp4ce3a2MP>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 35272182007E; Thu, 23 Jul 2026 08:16:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ahg3N6R0HDM7
Date: Thu, 23 Jul 2026 14:14:51 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Lee Jones" <lee@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "Linus Walleij" <linusw@kernel.org>, "Bartosz Golaszewski" <brgl@kernel.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Dmitry Torokhov" <dmitry.torokhov@gmail.com>,
 "Pavel Machek" <pavel@kernel.org>, linux-sh@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 linux-leds@vger.kernel.org,
 "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>,
 "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Message-Id: <f3d89b2d-c56e-49e8-8fdb-8749ca2cf09f@app.fastmail.com>
In-Reply-To: <20260723114045.GE3363113@google.com>
References: <20260710211854.1371746-1-arnd@kernel.org>
 <20260710211854.1371746-4-arnd@kernel.org>
 <20260723114045.GE3363113@google.com>
Subject: Re: [PATCH 3/6] [v6] leds: gpio: make legacy gpiolib interface optional
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Jul 23, 2026, at 13:40, Lee Jones wrote:

>> ---
>>  drivers/leds/leds-gpio.c | 52 +++++++++++++++++++++++++++-------------
>>  include/linux/leds.h     |  2 ++
>>  2 files changed, 37 insertions(+), 17 deletions(-)
>
> Any deps?

No, linux-7.1 is enough as a base.

     Arnd
