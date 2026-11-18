Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795035421;
	b=HaTk9KWV/iN+GA/ZxzQL9Gv3w4ddy02aFIfvTBfIPalkrI0g8wpz1+hkUcDzn3FC0isp
	 P9SihhDPCdXwO9tcDyfw/hF2VOdLeSFIvDWlrQD+TINbhUUq6KwHd3g7s1oG6miSG4b+I
	 XIPNQhnE4ka/611Go/0Zrk+b1XdOqvIEw9MTLyQY2J792CNBrpIk7671rsGMZD8TI2qCw
	 VkXVQCJiH4nt6htyiGuWeSXy0jSesA/MjeXqwi9Ttd2hSBphZMFnxiQ8R6EJqlLBzHCXJ
	 1Ur9DIbYabtte8V5+yQVYAe2Pvmq1oa3oRMcI/EyFxEwjVeTJSPOpvdveFdNkZW8O9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795035421;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f3GNnuqRISLu8fzYE97bR6SxD+k6/PUka28NAKwn36Y=;
	b=jUwZUQqbz3dER0d9in68NWMPz8jMSqGYLP0owo4QSZeTRZPRv8KZ30mEew8gMkaG0QCd
	 LY2dTAUd6oCSuHvuYlYicNth6ZTTdhe8Mt2Wf5Z7aOzYCAbSnQKwHulyAmK1Xr8CG50yB
	 XugAQvS7HM2KU4gkCNr3X9AZQLlO3d2DWVab59rVSyQU+KDzwyWhnvH8BG0DsCA6Haapj
	 +aY4BJxoyJs8qPChGLfOOjearsWy7M1mD0rW2vJXRi9Tid17zHUC/WK/RL5MxLJZIco4Y
	 4CuHoNh6iifUFEBVtkjZyphhO8S/IUB1kab0xnGOwgA5hrFp7MpNSyM6COz+x9mo2YA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypaA5fWt;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483D9606A325
	for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 20:57:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 483D9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ypaA5fWt
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb72b44a97so12524575e9.0
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2026 12:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795035420; x=1795640220; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f3GNnuqRISLu8fzYE97bR6SxD+k6/PUka28NAKwn36Y=;
        b=ypaA5fWtJcjY8vKmt6s6c+LO679nTEiOgmTbOKI92SmEDCzccPSsdZDznc3SYcjYul
         Lp315c8Z/0aLU5uH17V2gXGOOXzy7jch4VgWkJEixjuwdTQOFqRodGMjoY9mv+Ce5ogJ
         mjHjbB99afM1lD98oH1XKLpl/S3Kn7Yp1C7trsB9OQ/tMvx4fFKS80EA91HbXrUwNvAr
         e0cTIap6+2qoJQy5PN4ZOsF2Tw0l/bfKj7HmKbOLj1jNtceUZZuk/Jl3jeIMQBNJpvCY
         gpFpQerh68pep3rHkhXphr1VoYjesezupb/J2+5MARrk+nPqFnx8Skae4DXtpeBNHJHM
         1S1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795035420; x=1795640220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f3GNnuqRISLu8fzYE97bR6SxD+k6/PUka28NAKwn36Y=;
        b=hXX+b5Zg94kTIaN1B0PYYwLyVeNj+AFKdW59YGPQByT61uBIQubsHlsbIc0BFONnUB
         8C3pIMjNijxQxVsGt9ZVSt66rrdCAetMmWAgvOopFg5+hpEgNtTXUwLJhMQCYwUUfyLG
         RcTp+kiOLuRmTu3KhWqhkkjmROyJI4/+bTxI1eRFjkIhP+ww4Ts7aHS+aY6TjMb8tAc4
         hFk/J7GXMjTAMr4ggkqjz/a3YKlO1slt2ZCr4PIBKkuA+zfoMbmbunMJXVOPwHNiYbF1
         Q1+wIhJ6AcJyfpwOsWEhg7IVGWtK0KNkQ2KTIOEEQVmYxdKt7p03QR2cLUUe+Mre/+nJ
         boqA==
X-Forwarded-Encrypted: i=1; AL+hErFARDOTs93RXM/0/BDug+lMk5JeTJ7l0RDL2zn/TRadsnzDcNQRsXMbscKyDreLGrmU93j6RujrFXWoVA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+lvfDbSMDfFhrOiXqPmsh3ktW0ztsuQrieEyT8Zz7hyoCM6Sn4
	TDgnssdeMGIMVLoW78qimk2iEe1sa9a0biGaPGOyoC44pWFVG46skfQ8
X-Gm-Gg: AYBFou3by224gZ7SLEpIKygU6EHi52+U8glYm9/NRzsIyeSPpId8E5Pa3a8B62PWzKF
	n2K7SzCYn0OFUlB0yND7q47bnr2l8CF9Lw48sgfhuT72DjnCoEJKJoQk5psTjoFTvk2RjInLCFn
	AGwduP6+WDt7UflPOXxeNMnGg/2ShL2iqMeG49eaUMy1sgLoriNoOZwNgYstaoYNdLWzZRdetfd
	OPvNWtwyOdTpClLSN0jk91gu+2gUlyBsYGZzpCRVjM/lOdavhYyAYPxi2wcecjP2upjnyxxSd6p
	qGPwGQ0iW4omp/CoJr8JnE5DkYXaYfgSiJDi5Ba/3iuipgFdYs2NKnOPZ+U1sPGip4rd3fCbMkZ
	mFLtpWy/PvyQfGgxz5LHtXWquz6HV3okY8RA5+6F++0qDfPEb2421793UEa1ZJfNIoxOosa87iG
	m3tY02BYcH4TiSo1KbZVgcndezTeIm9/bWsK49MecRv0rLTpzIprcEwuzJS8rpU9qKGcX6hJOQm
	UW54edxSH0HyPYdIqbm5mP5A/VW0bNGa0kW5QnsqSp4g4Wy1nnhE0BRLIyjlkbi/1YVUMB6fH5z
	viZWF8ZbE1UEZBFB9U7GpdmRzNjp
X-Received: by 2002:a05:600c:1d2a:b0:4a2:d99:3171 with SMTP id 5b1f17b1804b1-4bb7da34cc8mr92969645e9.23.1795035419433;
        Wed, 18 Nov 2026 12:56:59 -0800 (PST)
Received: from m2.. ([37.142.154.208])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4bb832625b5sm18265795e9.11.2026.11.18.12.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 12:56:58 -0800 (PST)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH v4 03/16] HID: ft260: add GPIO support
Date: Wed, 18 Nov 2026 22:56:48 +0200
Message-ID: <20261118205650.49046-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <sashiko-outbox-219595@kernel.org>
References: <sashiko-outbox-219595@kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 17, 2026 at 08:23:52PM +0000, sashiko-bot@kernel.org wrote:
> Is dev->gpio (along with this FT260_GPIO feature report read in
> ft260_gpio_init()) still needed now that ft260_gpio_set() and
> ft260_gpio_direction_set() read FT260_GPIO from the chip before modifying a
> pin?

No. v5 removes dev->gpio and the FT260_GPIO read in ft260_gpio_init(),
which only fills it.

> Also, FT260_GPIOCHIP and FT260_GPIO_WAKEUP are unused because
> ft260_gpio_init() formats dev->gc.label with devm_kasprintf() and checks
> enable_wakeup_int with FT260_GPIO_3 directly.

Right. v5 removes both macros.
