Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794562440;
	b=Z6as2yr6XG+tKt7W2fmcbDAxYrAjKG9g3NRhQpCwMa0UDHSjN+4zrLSHFmtZRhHh2zVQ
	 CvCA28UKu2Tk/iQELc7Tho8AbOxInjHk4eVH6wYMRn5pzYbTH3k0AvhW9LdNVD9ZNUGgU
	 9VhqY+IPLjzV551Rzm+r2NW9/1RBbN2tKSMBbxLXnXXwIbXZyy9+Uws3DnNEJ27QlXZ7x
	 aros1p/jrqXOK+X5pY4VzLHKp6RZBps/TIjOtlcnMuBZK+qLNAT2fx5ed7ZGSAusHJQ+i
	 17N3oOtAr8eioq0ocLd2aLChDccF/auPvjtizxIDIoXwirJh1bA8OqupxR0bDVjVyIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794562440;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=u1d+jX7pv4+dKm+uv9IHJgxQaYN/oZbwj0UPraCdJI8=;
	b=CWZXV3GOdXY2jXM/WymC+xLUifxmadETIoM6w43w3VQDKyfnKRHOhlwP+bFWuUmYTCwY
	 icleeTSuMu1HNSxXmkR9f07o9n3seZBa88HgOTRjZvBacr9ktVJ0L6U/ESPUxsOviuxoD
	 uUO+NKH+1iOVTxdSg7TUNWrIlznaGWcT8RFl84bUSc0U+jI7wT6wNzDQVZro/93u/kqRA
	 FS5X9B7fgQ5614QtYFs1pFVOtp5/+mJ/1tjIQHQox8QccQp3l6PA07dez/cStqO8cRMjB
	 tiXb9f+Gif6YtR/mcqg702x5O5SDbM7qWkpEJroOYz5o7aVD4c4JCDf0jmuqRs339gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMsRLejE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71F606A323
	for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 09:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC71F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EMsRLejE
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b3acec6677so829105c88.1
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 01:33:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794562439; cv=none;
        d=google.com; s=arc-20260327;
        b=QNvDvZuyrIxWj6adwLSSgqScORDm3GaIz2AQc34hKHgj9Bl7UQnt5yzk9KXvnwQBxW
         8dEYRunhDzJhABbY5w7u8kx1T5aYJS3sg5cO3wOBLXRoBZ34F0FWZ9+jWKckGWItXJkV
         tMS7JnUSULh8PQoSb2CYBtQzbKp+wAhPbmt+Duqa/WKubJeS3tfcSjHRzDpD17jKPR0t
         YS140ZjlYpQGor5KVqcXWsUe5Y9d5IXO+VmFUUrjq3bm8wxsVp9MXgW6NDQg54/hVBjP
         EkDygOWuekCHJtB4CkDNHeRgrosvTI8w2kijjHWuGKD8p2uSrqnk7FTuwB817Zaz7Y1J
         lqoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u1d+jX7pv4+dKm+uv9IHJgxQaYN/oZbwj0UPraCdJI8=;
        fh=aV0fB5A8PJ+5tWJJ8aCYAoGTRzUwvop71l1EV8IhZ3M=;
        b=Z/AgRAPkjHBLHQZrXT+5oHWvHgfEsmtrgmifM6tJffR3Garh7tf1SETYXayVz40wzh
         /d0ZTUpw3HjBAtGGXbvucNCWrxCwZhJOiDdoeJdRevrKhOTooTuUbf5ApSrI6l5OY/72
         FTNwjt5jFAa9Kb2y4jp5qBRGuCBA0ss6rFAau5POzR6fE9SVsIeXj+kNV80HvYBrvPoY
         5DqL+frJ+OCkaQPbzfBjRRSQGrnZfb2dlDYMI7GOwzZ7drTr4f1SThhxLLDUdLoeO3dY
         lCLq0uUN1C7g7VWaeOhfAalmkTB8AhVQSEIskyHVqZKSfYNrYaVI6DUQA7Fm7/0dk+Dc
         nb6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794562439; x=1795167239; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=u1d+jX7pv4+dKm+uv9IHJgxQaYN/oZbwj0UPraCdJI8=;
        b=EMsRLejECSKve5zKyT/fELnBt1G4eF4EJJaz9wjZ9eLa4XZLaFKjeSAFAVLOiDDy3l
         qEk7iL3pEx4uUb34yWk7dB4gA8hZe0l5s17QOpD3UuaW3NZsTtuieQmmSxMe2HYRww/n
         bsmek53GV53JKg/pZQNNe72dK7/wO1xZX4slOORcTELuVpmyIYeIHw5XO++wfw5m51oD
         OdmQ9ERKMF5QLpAB0u5YmMbJfYz0MGc0JHOgnEnWBHjzoloSpM8W1At3OSlx6EqvweMq
         n3JCH9+TRb5s89yUI2gGtpVabLKgMjc5GjxbX0KaDFhunntNALuGrxwJn0RUptNsYeOq
         Wb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794562439; x=1795167239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u1d+jX7pv4+dKm+uv9IHJgxQaYN/oZbwj0UPraCdJI8=;
        b=mgs8HHJW3m/NSmG5SUHnxWJ1lTao2D/z0UosLbM9PrLkdisHxjfsYAdT+94cmgFSXd
         9ZuEfq6ETPxHapp/yEZR+D5Un7cbFafqtuMVz60PepCJzwNoQunEUGLP8Ue1LVpEfDjA
         jN6TB1duWsxQzTm1PBpdQNrP0q98vJJWgP//+V8DbruEW6eToZDuPyqrVoVE6Ef9Myh/
         ioNIC4X+yIUuxTfI7oKux9+O+B/AanLlyK9IKVFGfK6YzzKpAdn8MgLh2LAryMB9VUnK
         BVYn4w3uHOXTAIDYwZa+CGo3Xt7PGUCzrhrMi47chWjh/9NmuL3wW0B/OUVJb9GSMb0b
         ghaw==
X-Forwarded-Encrypted: i=1; AL+hErG2SsveHvUF2Ey+OVBwLAy/s+J9T9hCz7AzDWRuJh9eo2FNEpe08roW6xqxW2E8uzOriL/ATXbcSCWR6g==@vger.kernel.org
X-Gm-Message-State: APuU4Z9w441s1CaCEp1szrExQ9ctaaypTLMAsDm2/BjYW94VK6v0RrCN
	QpZ7Q5QOuJDpY4K5+Wbwwe4HTxMTKLbVNY2QId9u1cMz5C+xXPMkCe+ZQIaS/9/YbHLIO6Kh3BX
	ScPCozSTHgCmEWEvT2MCfPjzPacSDad8=
X-Gm-Gg: AYBFou2yetSnKFixjDtKPEmG6bjPJIffgyLoHinKx+Cxvx3UuDjtYSML3Bz1+9MqNFn
	KUqrR07kVJcyJdmu953FZo2F0nKsfwC3WZh+xSYtITvvCGnVbit+djg3+PtNlVWBKj5TJ1JoJFe
	md51xlamByDAKNCLJq8yRMi4OMB1CIO8YJsIA8BaC52uB+E4pRrmOejdES15r4PbwdumOvFsr+v
	LCbnBKIjSxCRim4MJP/F09vTZB6P2k5JA194mmEGC/PMAiC6NaBP3m6cW3w8uAIuYmDODH1zwIt
	MYZHP3ChCrR8/C/mij2iKYV9VXR0rpbaKULcGj/Q+I4Blu26/qTX+9LYBg48puKuc/vA1GBPg7B
	aoyvLsQEvC9w1o/T7jg1GuriJfEOd6ZYThJTq6pTjM79IeHLgsK0U+f5LVNyV+UEvSgAA7vweBH
	6RSG0x6MD3lM3CNctfBLHnSk3MFkmiLQ==
X-Received: by 2002:a05:693c:811b:b0:358:dfed:d0fe with SMTP id
 5a478bee46e88-37964b0992emr1888359eec.5.1794562438756; Fri, 13 Nov 2026
 01:33:58 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 13 Nov 2026 11:33:46 +0200
X-Gm-Features: AclHuK-f5iEwYMAt0ScbOlLfsX82RSmp1G8_ulBxjHo5JqdIzy0PJiY4cj272gw
Message-ID: <CAPVz0n25-LyOFFu-h7Sc0iUcjLMk0njOuAAHr-NepQbnZU6gxg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Input: tsc2007 - drop platform data support and cleanups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "H . Nikolaus Schaller" <hns@goldelico.com>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Andreas Kemnade <andreas@kemnade.info>, Johannes Kirchmair <johannes.kirchmair@skidata.com>, 
	Yuki Horii <yuuki198708@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-input@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 12 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 08:5=
0 Dmitry Torokhov <dmitry.torokhov@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Now that all in-tree boards using tsc2007 (including SuperH ecovec24)
> have been converted to generic device properties, this series drops
> legacy platform data support and its header file, removes redundant
> memory barriers, fixes minor coding style issues, skips registering a
> non-functional input device when no interrupt is wired (when the chip is
> used purely as an IIO ADC), and uses IRQF_NO_AUTOEN when requesting the
> threaded interrupt.
>
> Thanks.
>
> Dmitry Torokhov (5):
>   Input: tsc2007 - drop platform data support
>   Input: tsc2007 - remove unneeded memory barriers
>   Input: tsc2007 - fix minor coding style issues
>   Input: tsc2007 - do not register input device without IRQ
>   Input: tsc2007 - use IRQF_NO_AUTOEN when requesting interrupt
>
>  arch/sh/boards/mach-ecovec24/setup.c     |   1 -
>  drivers/input/touchscreen/tsc2007.h      |   5 +-
>  drivers/input/touchscreen/tsc2007_core.c | 183 ++++++++---------------
>  include/linux/platform_data/tsc2007.h    |  23 ---
>  4 files changed, 60 insertions(+), 152 deletions(-)
>  delete mode 100644 include/linux/platform_data/tsc2007.h
>
> --
> 2.56.0.567.gdb80ae8cd5-goog
>

Hello Dmitry!

I have tested this series on top of the latest next/master on the LG
Optimus Vu P895. My device uses this chip as an ADC for battery
temperature measurements.

Your patches works as expected. Input device was no longer registered,
ADC part was present and worked as intended. Thank you!

All series

Tested-by: Svyatoslav Ryhel <clamor95@gmail.com> # LG P895
