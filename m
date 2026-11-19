Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795099902;
	b=E1oTpBz7BgniTuz0JnZKhMvjrVn0g2QYe6GI2nxygonaclY/GD5OWM6jOirmOIQ1nHbM
	 MA3NNohJODo+WDgtqDqTJ8JpIP/T6PiVN7j9juGhltzS1egbE8swSmDsvJVvwyoio4F3r
	 qzdF9bTvFT2HS/EBZfnAX9ofZ2C2k1crC+GvcY4EDAqj57tAd2lW6hTH8+HOa1Z0zporF
	 90Pvbx2n5QV0clXibJt+PHtvzdY55mGHY/xi6wFZvFn8EIMbeDuyHMrf24cIug+8ZsRJ4
	 G8xFdg47vh+vP8E1bjNaLS8ONttB3+VfuttDdNsndj+dKOHyaqLeI5yJEQPbeZ7bESA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795099902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rVz62QW1HjQ4+uCtzasNNB/vluTYkgnjHw0Yp9wwc8Q=;
	b=3F3dxOZCKKRG5kUqdbsKLvsXkP+SvuAgDL4Lle+IK78VEWa5xyLZ9QGOpnyvYMcG7aeg
	 flE7En5Ktzgx0C9n0p+2aBhQ84AD3AcCkuF3FoJnTMYDgKg5yn0gt3sZ5ZWe+vg5GOpJg
	 7Ej4SEfelMpOZauLTDSuFYdp3B+qHPRarxqBCrTbxofdPDk7UHQVhPFHi4HUR61DCFuR5
	 umwOtDAsPL66RVLWGdFeYWEHiaPvaRAH97LUrt87dKEGCljBuPNnDuuQeCxCTavOhgl69
	 sO9I6aw8uPjEsS9SzbniwGrqyPUTXX36nBqiC8NsbkBUxS3ltDELLvqNWKK52qM5x6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dWwy3UQV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7D606A33A
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 14:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86A7D606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dWwy3UQV
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-36f8cdd30beso3441473eec.1
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 06:51:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795099902; cv=none;
        d=google.com; s=arc-20260327;
        b=O78tBXFmaE4mJnH5klnvdmrZM/6p9QQzfzjmkHTFcernTk5mDWEO0/bWsVajfPGYvY
         oTBnN3SCEt5AL+gg4w570pFQjtfrjk3YeD4HZrjiu9ILFwjr9CODiPIMr4u6Q9xlVlKe
         r2T2TW6+DChlAkzohCSFZqtShAwmpH99y0Syr3Oh1+hEtFKRNAJ0EBYLRkBJqC/yxufX
         M9ZHEAvgzZgaAMJHFPbkdmcc2MW2t4FqtYP7ItZRmWhyr5nb0eoVJqyDL3DtZDe7kE71
         rFwSeXSMH8caZijiW38yVzEbSFYgSJleAbrKaOEGa2P8c7+X7CPix1uq1pPQeReZ+HDI
         YIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rVz62QW1HjQ4+uCtzasNNB/vluTYkgnjHw0Yp9wwc8Q=;
        fh=xSVPivfmb1HGCPVULrqxDJ4dT/DM/O3B75fLoAsJM88=;
        b=oH9AsQ95LeWxMp8tniRIMOHc1b1dPegI+NGpOH8J6U9mBT6v/JQH51GQuCB9OPfRCd
         zM/zl9UXZR02LcbDR+TdUDS9fsaZTdB/2tx64R0AYkPDFyyT2dJdrZ5fJHMMekTc3/kh
         d2oYu76d2Ct+oPZwdfonmuPwF+dmUSXmnRZVDfAHcrodNjvTKqMy6qROGlE5sec1Ksl8
         RALKuZ24y8ur19eDTGM1ReLetOedzWjhX1Ygd9K5fTbh5MunpXcGhk7rs4xyHZbD2ut2
         aydMNKb0ggygCyGKKuNi1O96Ch/NlR8JoPzAEA831lTFWxkHVVPG+upqsARNFVfGajnD
         feag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795099902; x=1795704702; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rVz62QW1HjQ4+uCtzasNNB/vluTYkgnjHw0Yp9wwc8Q=;
        b=dWwy3UQVVYQLiKDxkA3dgZkZebW32MqoCRtNCPSE9MpO7t7SCUIadQkRZJTN5a8w+V
         3+jB8/+GgdxSwPRLbMBhkMYZd+rZkYs/iaE4Vz9TPjtcDog5e+Pg1NWQZ9MRwGFq0e5w
         LzUZo90zMzoehE3eCLRA1ydOP5xUVZi3O9Y3OY+QKVU2moQ85xP9bsKJk27hvttgM9dT
         fwQe4YuYdrDTdwhpNG1TWYVeXvWAcgtl/oYi1d9P+TUGslnhSuGhgpfPhtggZ4SvwyLs
         osmrQ9/r+uYHVq6YAjvvC0hCJnG0WTpZnwR1CMffZO2NWqJPT7p9zd4sHKLVr+PL9l/g
         jfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795099902; x=1795704702;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rVz62QW1HjQ4+uCtzasNNB/vluTYkgnjHw0Yp9wwc8Q=;
        b=vJWvN9cBrFZT2EIcOIPFZU82badnPoqgyrdKWkODiZ6iudoc85ssb4yTJjsPXvxxPt
         WdeTvbrtDwZdHB9hiFchycAdhlBctiQq6VobK1nBgN0HL08aHNVpyIJSackpWqE6q7Jx
         RIqTOa2z2xBxzu2RqgErte/aWXjG83wP0MBOYEv3NYuW3z6A3CQs//ZgD+Dq4iEpkrMn
         v0PmKgWoGGwwKHuj+ycTYd865pS0CqLfIsOPvWT3iEonZd8MTHSQlqTedU77ObuTAm97
         oJ7Q08n4lLHRjAxAF+8Nv+SkaMUZ8vTyQ5w0mnol1W1EhZ1SPqEFk/B/FFSOcgTNRv6V
         5bLA==
X-Forwarded-Encrypted: i=1; AL+hErGi8LeHFv7yfmD66MV6Lhe1JTeX3hBokxUeOeTkYCOmAq041bSaUHytDlXKREHA1lD0mybHHwLJ70TRiQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/VPV0FwSHeR6oeQsSkpg7EzkSzREVupcLYBuY1WIt5JHw/AVGk
	3UT4ihaiMcIPUsbiOIjBqCLGtYUAu5LwTnVGg3cqEHOAO1QDpZCTLwJNIVaRSQDBPuLfd2RoR34
	QY9go1v+NDIXQDrrmqhnZ+oTSMmiPKwc=
X-Gm-Gg: AZFdTZcrMigf3ld1CK2ikI8fPVvwgPrabtQy/ydcKDnDJR1/t6YmtTCzpeAl0VltC+B
	OBwu3cYBoFZ2rNEIfpRTmRtp2aYUuOtrUe/edaz0+nvgIxPmak+dJTUwveSLQJ8iaDz17hGQ2Kb
	pc6TTN9aa7w/aTx94Tt9vepn/X9uM3fnEvE7X/rGstkNfQr9WB4yftGQOGx0fP+7UlBpuLvlP6S
	IvUDA6YUR/UIozRcyP7wqSvJopwq7mffYjFypDzQDKBzlDjc3XAenEJHMllwmQdCsN4/eXhvnit
	/MnmIunxKSNiR0zQkMfm6mAfyr2k9IPD3jt93FfVLjEGuOPJ2khjf9btbCwVbh1u47zzOJNiVzM
	Cfv7bDMCIO0+AluFvdW/7UfVL8dDtbPIhe/80ht+HrE1bqz7Bm86F79HyouZ5F9fGO02WgyM5Cc
	pEct6OTZQsajXrdXGabkVZJIXXmzMtzg==
X-Received: by 2002:a05:693c:8803:20b0:384:b001:4350 with SMTP id
 5a478bee46e88-384b00145cdmr1285277eec.24.1795099901356; Thu, 19 Nov 2026
 06:51:41 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795095742.git.geert+renesas@glider.be>
In-Reply-To: <cover.1795095742.git.geert+renesas@glider.be>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 19 Nov 2026 16:51:30 +0200
X-Gm-Features: Aa3M54oSpPPjIjBXKWbeu_LdZEGptwUS0dUMO0QTPqvZvvRh2xuuU1prMieCCXc
Message-ID: <CAPVz0n1+qXrO5P+rOBKOSOE86+WcmjNF0taWDZoWqerKrjVgJQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve MFD_ASUS_TRANSFORMER_EC dependencies
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 19 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15:5=
2 Geert Uytterhoeven <geert+renesas@glider.be> =D0=BF=D0=B8=D1=88=D0=B5:
>
>         Hi all,
>
> This patch series improves dependencies for the MFD_ASUS_TRANSFORMER_EC
> MFD driver and its various subdrivers:
>   - The first patch adds a missing dependency for the MFD driver,
>   - The other patches enable compile-testing for the input, serio, and
>     battery subdrivers.
>
> Note that compile-testing cannot be enabled for the LED and charger
> subdrivers, as they have a hard dependency on the MFD driver.
>
> Thanks for your comments!
>
> Geert Uytterhoeven (4):
>   mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA

Though this EC is designed for Tegra based devices, it does not have
any Tegra specific parts. It can be used by any other SoC.

>   input: keyboard: Enable compile-testing for
>     KEYBOARD_ASUS_TRANSFORMER_EC
>   input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC
>   power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_EC
>
>  drivers/input/keyboard/Kconfig | 2 +-
>  drivers/input/serio/Kconfig    | 2 +-
>  drivers/mfd/Kconfig            | 1 +
>  drivers/power/supply/Kconfig   | 2 +-
>  4 files changed, 4 insertions(+), 3 deletions(-)
>
> --
> 2.43.0
>
> Gr{oetje,eeting}s,
>
>                                                 Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                                             -- Linus Torv=
alds
