Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792499885;
	b=pkgBVBr4froH6K/LyWLuFaxs+XQfe6yWLyY7sLwd9I9rFe4nWXHb7WeD9AaxvwGxy8nD
	 6jkSgKnQ0VrgpLx3ebFHSjB63SVAW3stkbA+h7md0clahqnZj18MVPs+Pc+G/P2SIeUQJ
	 X7utHgqeioUmuS7a8TvCp/U+RFbjJQ3c1VekVANVbE/SDf7H+QO4L96NWLK8URrhGCnf3
	 RtGlsCpp1YixTti+rxrLGbPxvcgJsCT9xFyN8oh6yLJv91pRfT/wKHn2byTdNBf1ZkXB9
	 c9uBiXBNdx/ifOdavZVkM3/2ECXL6bhlAaKTlyJFbLH3vSzO6bB9F41bBPvNoGSBPQw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792499885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZckKNDFk7eaeqWm4nESk5tiNU0gn2sWrHYvs3EKsEOU=;
	b=KHKcESzi9nYqtsoq44ySma9Mu63yT+8pPYdFQi82USA/zZozLoVewwb7NPXavp9xGJMr
	 nLQqWadvYHbZWufRzrOmhm/ykHqYhRglKEZxCd9FQnv3/AoNhtyYJTA6hdqCbPUtqR1Pl
	 3QwzyGcsL0z7UtVNZHRK0pIaDHFjI9jx+pPa61pY+HEzQsfrmsrpnoaVDFO+KgnaJGH4T
	 i7JI1fQfnpOxwCvWCyTQ/3aHhVAOR2DSsoIY1R35TwaGfL/BFln8OSiN7yrL4ZkvFPRno
	 XTd2yWCuPUJAUaHLqBFcdNAmbC3DVqT7G6Sn+1l1D1OA7vSPXbtCfLfZSAiElj77/AQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmwbXUqD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647E6606A31D
	for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 12:38:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 647E6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jmwbXUqD
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33fb4680717so5995851eec.1
        for <linux-input@vger.kernel.org>; Tue, 20 Oct 2026 05:38:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792499884; cv=none;
        d=google.com; s=arc-20260327;
        b=WqN3fO1cUJwth9vIdF+SC5XfyEiXrwiI28Kzxa64kRz9C400OMIpQ4o9ddqJ3KVurU
         UfFUFv67UPaVIvq119VlkdAe5OAtU7LGjfPs67sQWWtE2kOQ06epWDEll6arzu2yl8Kt
         gdWw3sEHrIuzrdVxv0oM2skyMbUqUvkZgRuq+jEil10D5Oj2GEeEEOhW3f0Uoop6p36N
         Pef3d+gNi/pdm4Epth1Gdno8WMCqki0RNRgRAG1QsHs95B0ohNqqUI7b9HwSRUW7o5cL
         GKtyHknC76bY+0ygzrnbhWEu5eWXA1FqykAukDZqsSoiBOUQ6dCroi+cSmWESfwa7ZDz
         TU1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZckKNDFk7eaeqWm4nESk5tiNU0gn2sWrHYvs3EKsEOU=;
        fh=EQXCxc9CWV2sORDMF2rHriv9LyqYZdPUTbnAboGeXp8=;
        b=E7oH+ChU7h/oNauRXQXQzAZT652Zgo5TDu+vkCntZSR21hsVuLOSXyyUEcMnJ1Wj2R
         2JLVSJINGXN6NdTt0dZPPmyvr0WWXslguE4rZTuIL8Z4ELOaXOO10qcE7YRwGMQlbnUb
         pSYAROjPm1UNb2QQRG3EMTc8tCjlZfIbrJc5Yrl4umP4akHG7qq1ov7xui5uFjY7BTFB
         bUjcRv2fN+YW+aU2wz+f/y9BIAo+5Ad7TC9U/STRCP071yIcyDmjTlmaNiJrITIOOtmr
         gy2Japh7UUYRnQwVBVCisSXOs7SzsCrIgrZu0AhkPiLEtztuyuEAFPBS/rCEc7EuiJIM
         yJyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792499884; x=1793104684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZckKNDFk7eaeqWm4nESk5tiNU0gn2sWrHYvs3EKsEOU=;
        b=jmwbXUqDvmKk+mts4P8S4Qs0OykPCvL+ZlHj6qhWGIspF7//gQi87Ih8CsHjx/61yv
         wGlS2HpVAHZ3Lu2ZAPezB2Da+qfjRMgwpyxguCAQwdLYXpBwUdJpC53SL8i1C3AluBoz
         PqzIWp7iFtQ3nWEao5a48mvkJxBlgXCvnVIAufBOZw5diHqP7Uv+RTsrse9gVOp2u64n
         nYOWDbEr9XRZ0rVc7jU4+prj4inZNvasO8f+AIGIc9AouBH/JWrRm+lojVGH3yZn6mxl
         TAusewpHXJcE6mPh1y6HGwM6WdkqGXkCVqe0uVPsAZzpnXchYt+hz8SjLjcXT3/ExGSX
         1D3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792499884; x=1793104684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZckKNDFk7eaeqWm4nESk5tiNU0gn2sWrHYvs3EKsEOU=;
        b=OInt57hhSfEjXdpDjYrEr1QhTgnBIJ1Kl6rZZo/pnVBKHfnlzWrG8Js1Xa/SBFeo6T
         1l64yKJ6Hgn9utBYWfK1UZBCSJRHkNIYYZNEAzOLRrJyrHzJcRHol3UT1/+LW1weyOoA
         UNhYPYXJLv1E/o3TXrTIYYlHw+Ygp0vXaN5FaMXPxw2TO+CmsZIfDxpBXqxNL1R5Xr+B
         wjlXu6cvKUHQYK4aAn4DseqSWmeUkVKh/T0IOlJnaePlCcPTwf3C2VBPtc8fvWKS0pgk
         oa6zil8M55G8OS/eFtiP3Lvuv0hO8dUoq3gXlHynWR9qD4wlMIkMGqzwP+bLtqSq4iuN
         35pw==
X-Forwarded-Encrypted: i=1; AKwUvByCOt98jEZ0XZK+vAgykSPXa6CgklujZ1gQOaDzNkoiGHX6ERfxPVSi+zBd8yTj5ckBfP0qtvj/ZvdmXw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKUJAoYaP0SjfdOCMWV3/eHAbKsoL7U659E/r7aF8m5Sfb1rjfK
	UoEwBBIwo3LzOwLqWt0d+ojuV3aLG+HoLvPaNz7J4ue9jvIksn57Ce3qBvkx33I9avrm2QAgqv8
	tcAjn+rgYJMWpGmrSswKFrnZTOhwxAvU=
X-Gm-Gg: AYBFou0w3TZ53HfKToZNiPu+9VRfNbluf2g+ymKqNYYgxto3OjFxbtAQoMX1x+j9tlu
	+7DHwYY2pbsJwUCVd6IirfNSkYtDBcEJ3cmZgR5KA1o8Q0mAx6bMe4TvGXnZAvg/k6LpStY9obm
	RItdobMpN6mdGZSjEBHYX65ZcZw2tkjKTtdoFPpvr45LlJM3syMYFgVgvBDy0ncjCWBoJ/dkUmY
	tzz7IhSaGSGYII2Gb3VJ0lVLenvOJhXm8MJZWT55pM9ACqYJN1kalxXwHDchSMIt8UgRGKZ0r0x
	f44sGDxLgvu3yZLrW8bh66pT2Du/IJ6FmLIIp0Vymo6aNELUh6b3i8lk4XXSBd+58JAm1QYlncQ
	ayzKvFGwK3M8HJxU4YMrB/rM=
X-Received: by 2002:a05:7300:d10:b0:35a:84cc:d941 with SMTP id
 5a478bee46e88-361a341c8e6mr20929064eec.37.1792499883433; Tue, 20 Oct 2026
 05:38:03 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019100406.103687-1-clamor95@gmail.com> <20261019100406.103687-4-clamor95@gmail.com>
In-Reply-To: <20261019100406.103687-4-clamor95@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 20 Oct 2026 15:37:50 +0300
X-Gm-Features: AclHuK-m87BDNsd06OZo9qyUn54gIAUFrBH_nvo3N4yUY0ynQqrl04tZBGoSFNc
Message-ID: <CAPVz0n2qqMzhbMt+dTaGv1gmrp1xmxJP8ZdQV1EcSpKkneFALA@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] input: serio: Add driver for ASUS Transformer
 dock keyboard and touchpad
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Florian Krischer <florian.krischer@fkr.dev>, =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>, Sebastian Reichel <sre@kernel.org>, 
	Pavel Machek <pavel@kernel.org>, Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	mfd@lists.linux.dev, linux-leds@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 19 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:0=
4 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> From: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Add input driver for ASUS Transformer dock keyboard and touchpad.
>
> Some keys in ASUS Dock report keycodes that don't make sense according to
> their position, this patch modifies the incoming data that is sent to
> serio to send proper scancodes.
>
> Co-developed-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Ion Agorria <ion@agorria.com>
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/input/serio/Kconfig                   |  15 +
>  drivers/input/serio/Makefile                  |   1 +
>  drivers/input/serio/asus-transformer-ec-kbc.c | 264 ++++++++++++++++++
>  3 files changed, 280 insertions(+)
>  create mode 100644 drivers/input/serio/asus-transformer-ec-kbc.c
>

Hello Dmitry!

Would you mind to add your ACK/Review to input patches so this
patchset could be finally picked.

Thank you!

Best regards,
Svyatoslav R.
