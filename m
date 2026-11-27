Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792665;
	b=OXKHWp5D0v2XLEZ4puIHLGFLIy1nbxyAFE59ZEx8l5DXLcvEJCku4/PrxCizAi0jNLsa
	 nxI38tzae6PgieSYs+SJnci1ClCZBsSuSMKVFvKRt3Jnz92Zk96++QDf5xemFy1QN0Cp2
	 Oz/qAefqISFRduAEviZUD+2HFDrJ9Y6r4U8FGbszWFRafAH27xLdaLLula0xIWr5h0jig
	 3WNQwv6CXhWmIMd8TjttPzlqJn/nABn1SyxsN3pgZtJNK92bKG0ZHaptX0sKcuq2yxJtr
	 fM1YGGhZbTHuVwQBbHEVpvveDG7BLkKy0oW38Sa3fBXdGCmvvBYt+Tefh1dubojddhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792665;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=R2b+Lw/XyXwh7FY/V8jqObNTlnbbCMJ237MIUCcelZs=;
	b=UtqWHyw/N+lSS3/v2+zMIqZRIbjiCzH4IO2OkBcKzfG0bBVrTpEioFK7ABcQQDgtM7Qa
	 wWD7BbFHwV9zzELCMP0OKsZE5C/t+DtMDDF73ih6Aspi3NggSL15xDn61fbH+2zy584u2
	 O/r6P1Dqv98ZE4HcKKxW6B88yk0HttFc+DpF1ZaqVoffq7eoe4T6oR3Mpt+MGIbd7l9Ap
	 k6SBaNFMj+w8TUARco+M5Wj6HD+nqoVeT/J6YfdjqPQbgLTAhekouDsPaZ5QDXGnAztvj
	 voTeXKvxZy794vy6YhYwFY69CD49ca1l5u90+BqLhgKXX91He7FhjA1/VI2ZbcNmXdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddZQcbSi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA7606A31E;
	Fri, 27 Nov 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ddZQcbSi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5101F00897;
	Fri, 27 Nov 2026 15:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792664;
	bh=R2b+Lw/XyXwh7FY/V8jqObNTlnbbCMJ237MIUCcelZs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ddZQcbSiYcxWSMiVTpjqu2hKHdwhLBEPHwFVTaAzs133jrNBvj6AmnbPLDHNjAKAd
	 lVtf7hR03WkdXpmP1eFm7kEABXTEDpgl4JXLSaKIDkokk3+cOwLX4lM7vCaVL8JdaN
	 UT12EDyEmrwiPTETLwTbsoqVXkqvMayELRfoHV+VUKQFe56tpK7pq5BZ+rsbWUqDue
	 i8a+DAsPkaLZDgke5yf1LN727/XcvGTACzcfJXmhucFqHIrEbNeUgtpz/aI/DVictw
	 d9cTOJfg5nD4SvdtrbVfWd+ws/KLpHAYG9HjvejSAVdq2KaGXOluQFJpHCMPb8NBNQ
	 cMYiKlD5ONcGQ==
From: Lee Jones <lee@kernel.org>
To: =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Lee Jones <lee@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Sebastian Reichel <sre@kernel.org>, Geert Uytterhoeven <geert@kernel.org>
Cc: mfd@lists.linux.dev, linux-input@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Geert Uytterhoeven <geert+renesas@glider.be>
In-Reply-To: <ccc2e605282d3abc63cee49eaed4300992aa1416.1795355432.git.geert+renesas@glider.be>
References: <ccc2e605282d3abc63cee49eaed4300992aa1416.1795355432.git.geert+renesas@glider.be>
Subject: Re: (subset) [PATCH v2 1/4] mfd: MFD_ASUS_TRANSFORMER_EC should
 depend on ARCH_TEGRA
Message-Id: <179579266014.99049.13344015578911292612.b4-ty@b4>
Date: Fri, 27 Nov 2026 15:17:40 +0000
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c

On Sun, 22 Nov 2026 14:56:30 +0100, Geert Uytterhoeven wrote:
> The ASUS Transformer's Embedded Controller is currently only found in
> Tegra-based ASUS Transformer series tablets and mobile docks.  Hence add
> a dependency on ARCH_TEGRA, to prevent asking the user about this
> functionality when configuring a kernel without NVIDIA Tegra SoC
> support.
> 
> 
> [...]

Applied, thanks!

[1/4] mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
      commit: 35ea6237fcc2e0c2241aa8c870193c44558a5df5

--
Lee Jones [李琼斯]

