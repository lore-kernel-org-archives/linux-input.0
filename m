Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795347056;
	b=dAntKB4sZCIB5PUD4wZITY69OgunOW9IcYCOTS6nBuqP8mUGGkq1MsEB31FXkGSvolk3
	 M6b2OJ8szWMMUbRmQ5V3ApBBb+jqZhuFmE7c4hXLwaSJ68OaKI0HrelVJDSYM3LG1DGKq
	 bxRxYarf5evI4enZMyU33bfngEqYnfxRCXEqpdTcWv510d6wfFRLPpOV/A/UwFjeaXYwl
	 lqqyDIEuMCZe1mV5jZKbhqFWtzNLznNyRENNbWWtYInRTZoTRDoCR7VIGg0LEqyJZvlO5
	 zb5AqJTW6W0WdoSnTseFy3fTnUZrhFh8snA38HJGhSiUjgWgwfp0UF6YHWDV4e37YrA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795347056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HTIrhwJl/9ipJcdFd57QjcFO8vQHJXUr0hmcwxLC+cc=;
	b=bSh1CPc1+WDEHEmLGx9k0Qco3cURGp51tHXesw7WZOGiDcuoxkpe48rWFqcPmHjRA+ma
	 dyhRny2D/L13wyhEVGYTqLSs57wx3wJt+v+CzLYtbpQ6ouABxNmGTWXA/11ys75LozanN
	 R4fhOX72G27wJvR6uqZAIT+dQakfz/h7yh4b86hCtlv+Ojj7Hu9cdcxOGUIgapEHd4KcR
	 N1sNDWs0NoImOO4dA3QHdnWjFHXLbt7pOJEs/CJGVm7PuiTB0ex8ctRTOdNN7/2Vkg4/b
	 8f2MeTHUHmzPOLu/Dic4YYuEYaMQMVFaGz2DfutInhjLQ3oufL6WVMvH0f/mM0iPBSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Re6I7jHK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE69606A330
	for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 11:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE69606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Re6I7jHK
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3acd523a802so21384051fa.2
        for <linux-input@vger.kernel.org>; Sun, 22 Nov 2026 03:30:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795347055; cv=none;
        d=google.com; s=arc-20260327;
        b=mv+4+pjOCgz40WguPN1shHzPNNwTL3FqNTuDtujARPLHXd48SVnr6LdiRRbGiCea//
         lPvpEpYvvJPD6YnXuMzNibAoxPesSjm2kVfOO9EiSnGdn6tb+0vT3CiJppPLvPm7eQQy
         seDybx++iAeZ3TvbW0yaDpfRwYroWRgqRHweGcPuUsJyoiXx1AJ4G8LW96FyVcNowBPI
         WZAiuerf7gLGvgTSvjZx46YkvVEosDQDI3zsqw3J9D6TyQMk1pRzz434dGCgGte35sCe
         BWA3L0XyrIWumuEpCC3ds7XJ+Zc8EFRhs+2Fo/QgMiAFF08H3mjJ0P1VydRjn3OTcbaC
         VusQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HTIrhwJl/9ipJcdFd57QjcFO8vQHJXUr0hmcwxLC+cc=;
        fh=MCcSqvRAChdBY99IB0jO9Mmxs6vUOBcuUq4jOEnomIA=;
        b=kkAap05wR6gXAGA7vH3bz55kl/kmhkbJsKKAzlmxKMEimNpfj9dtfbvo2Wm4Bisdr7
         GwXWPXxNjWd4sZBJBfsr47LVZHTFYw/LFT5ECxsSJnfvgao4l8Zj/oXS1L6LecvkGcrp
         A2fxjg3VzNkIB0VdSIx00vWOhLKUZNvr64Ez6+JTnG4CzhL2CgL142CWVNPaoyztSf/Q
         CSje3lrBwQh+W59JHt+zJkVYcAIFGulvWHhrW3p/l+wFhmZim96prunYxImn2zFQ4+0w
         +xmYNyIaonloB56vkE9dGym3lVmm5/KkbOuutV/j4ZAKM+nqeJ7IwPGPa057TgGTHDCz
         lQUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795347055; x=1795951855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HTIrhwJl/9ipJcdFd57QjcFO8vQHJXUr0hmcwxLC+cc=;
        b=Re6I7jHK9+vdc0lUYaTP7u5shUce1zWoTNliKBzI29xJ1G0YpcCBwSl3NB810ns/j4
         thf7iOUognRvFMB6YS5SSTzTMbeb2bYFYL7HTKo2zHRSv835Wk1p2QlfvF/6ndXHkL+L
         hJ5/JEmbt+Dp7xqaUab7+nByfRsYddAXTgP3BJYjyiupy+ixStpqCjaJOL7k3OS022yv
         4chmwOwNaJxQhjNvdyItIe6ybl/H58EjUROgx7fnIsMqrTI4HbHH8Lc0ykBth3vkkoxI
         7oPbLCQjDDjrqL9v19yciwvehcL2dKkM557aO+qoJduIUfcsDT8ObclkWApiGGCkCEuE
         wnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795347055; x=1795951855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HTIrhwJl/9ipJcdFd57QjcFO8vQHJXUr0hmcwxLC+cc=;
        b=i59sDhxG91NNVah7GQShu/M7mrjG/HfQAYQH+Vl2DdeW4m7Bt//qI9/Hnm2zxIoonU
         sh+dgT9B/Kdd6+r1K2JXycZlDdwomIMgCdXemuqfaTvKqYO6K5kxWYzjrHMeql4dJPb4
         VGGyrRyrPp1va7YAljmNJcdpNiQtuoEDsCWdtBBFoZJ4lDn+U/S4wObevEZfyzLbtRor
         87YYR26pxPe9n9pq0S5Kt5vsIr9aPdl+tJSkUNyKcz4Bwssb+1l3dsHfjub0dnatj5zZ
         IHKGHTsXtN+aT4X7zDcwVW4egHtP2oSlSVHbV5cgmvnuGpRyEcuJ6e6wAF9LJZ5bFLV0
         uAuw==
X-Forwarded-Encrypted: i=1; AL+hErHWNVGaxgIT6vF+IDXF6ECWY/oBeVjVfm0LpfOGJaQyc78YPqhfdFuEJuA5gCwA+76WKWXmsGa09EcL6Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z+XvfTAimN47JGFS2VaXzZKNrmiSwsQ04JwMfQwLjSoNM4go+yJ
	pJ42CFhQiIWbHXjuHqU6GliEAxz7R+Ax/0M467hRA0RE3Hd8r1gz56x4NefTQnDPVK/FTMLchha
	Diuc5+A8LSrBvRmAGPh1XU6Unn9N8PbSYzA==
X-Gm-Gg: AZFdTZfCOf6Hy9EGsxXleCOm3ULwA67M6WfM8VfX5GZ+YMG9xJGE7kwy1XCNBWlkmPT
	Dn0ngcORvVI641ttz09d2eGb+5YXrlGFvdJNiAsjPfyc1X2My+orPp3bE0Xuz6BSEkvZSvGyoRg
	W8/CrUjn4s02yTU7n+Ujd/x6zAMiRq3vg2V3y5au2BJiDkbCds94tImx0LbIYiXh4I5MVkOK2dU
	fIsCLXnNwHwA2zjrkW5gB2SEHvfwTwGHlQqKHMM6AK+2wIXWtivG1FyMngreDmq9cvj+m2WPl5g
	YIG6cQzNLHF2kLgQ8MAXK6RsGuyHdRTs3WJwt2itEyWwImCIQ+Gey2TyUDzB+2KiQ2mVtmIUi4b
	R6A1BXMaItDzkcx6Qc3WdIPaFev6+Jq8ayZIwGqBlRj1B66V4GY1HUlsZO45r2nInKC9c7nUUoj
	uN44B1zb5rFx3+by35z3qp/ib6hA9agHMGqNxAlQgoNkOc+Rs=
X-Received: by 2002:a05:651c:a32f:b0:3ad:fb2d:a757 with SMTP id
 38308e7fff4ca-3ae7fa45871mr24883491fa.24.1795347054437; Sun, 22 Nov 2026
 03:30:54 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261119134041.16611-1-festevam@gmail.com> <20261121231726.71aa1aba@jic23-hlaptop>
In-Reply-To: <20261121231726.71aa1aba@jic23-hlaptop>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 22 Nov 2026 08:30:41 -0300
X-Gm-Features: Aa3M54qp-5FUOe8r1ZuLPebMgOZXGH2Yo_N6UQqWLwX2mQ0uaPQ4PbhpovaTi3g
Message-ID: <CAOMZO5Dp6KYkd6=hsK366x_83ji9tdumq9k5tWXJGvW0EeRpDg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: mfd: mxs-lradc: Fix interrupt order
To: Jonathan Cameron <jic23@kernel.org>
Cc: lee@kernel.org, maz@kernel.org, andy@kernel.org, dmitry.torokhov@gmail.com, 
	linux-input@vger.kernel.org, mfd@lists.linux.dev, linux-iio@vger.kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, crofts@kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Nov 21, 2026 at 8:17=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> This bit belongs below the --- with the change log.
> I'll fix up if you don't have to do a v6 for other reasons.

Please fix it up. For now, I don't plan to do a v6.

Thanks
