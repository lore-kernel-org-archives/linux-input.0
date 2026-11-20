Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795187701;
	b=O3IbXQJuYHPgVBP5dvobd79tgYOb/a2mm6WMmb37rwiyuj7VrJJUrzZpxYW0Z0bj0pTb
	 05IEMmDwVC6inIXhsLk4HvtzY7rbNV59VZUM3wH0CASPbwn9SGCHbXBQ6DrvWiV6aSqLR
	 FWRofE0m2CNqddhGzzLNTu8QxNRwoCMAmzldqySSuqrF4qE13mEIriZWV1uU3bRrMNHQ+
	 oGd+rAGL4W04xcUTW/EGNdgeso8Z81hQxx8J4v/f6cWCax6cj3OKw5paruG9FkWRvBE81
	 eAcVA9ArU1GpSypcgqIKHvPZaohv4EUFJGHeVKV6PBY5TWoJH/G5HmiTL4JGAaIQg6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795187701;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BTVg64Op0q6C9ndfjZSeyDDbPDPodfwIL2/3SvvfmEM=;
	b=3JDSO3mvhEuLtOoY/8S1Mk1WZi2S/xaaGvm1LWIUx6SbJC8FRwVAarFRjYPLzt2FwUDj
	 nWUH6q1qkj/I4bzARvKUM81cCqncENe+fQOrZt1OMGlq1qTyFw9E3saODf6HsjcLtG69I
	 DPUpC+9GETQnAHCr7Eq1BJwoDD2PbI/p6Iu+hffifl+9uY+U8e7K++g1qQ0ssqeeaqHgt
	 T5Hco9SFxogrZLHqGYcKLOBQmwsoRpZnGcpf58GPLtCp9mWj2i/LYXUR04Gl9vyfvauFk
	 7cn4OWXZi9i4yadkd7glupfdaNH3mvHT07nZ8Xk9/nvgxR4ngViwL1atGScVackdG8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuTp10tM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2C9606A332
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:15:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA2C9606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WuTp10tM
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-38587f3de36so1155492eec.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:15:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795187700; cv=none;
        d=google.com; s=arc-20260327;
        b=HAZXjn5SYv1Y6+lLTXZE5WVR9tGm9DdRuMum0vOdAFwmB/qkPyKMI9u/yvl2F6VmUP
         rDazg6kehWjkOoBd0xiJOpuCfvRT/ONWVeV2qRVy0MetFU/OqDJ5cFjLJ4Ji3i8ne+wu
         fPITdHoBnkVEG7IETcsPxRWiKpXkbr3VhJlI0gkDD7qHjY5wnWeYszGeM2OJttyKL6pN
         uxUPfUKycfPL7W9aGdTrXEIBR0c6L73GwMIR+93x2wnVIp+yPH3HNrvPhuy5WD9B44d8
         DYoq7C7jcvTV39Mn2FrHZNzlUtPp6QFssQfrM0Hjz7gsFhovdqtxA52bxkMwKG/uxEbn
         PoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BTVg64Op0q6C9ndfjZSeyDDbPDPodfwIL2/3SvvfmEM=;
        fh=O644RWqeUBz6qVypFMni1gvhB+zjlahA9pFRhZ72Rzk=;
        b=h4oYf6PmYyn0h2GFx/nAnPZrUYv/dBNw46tX5kI+nZAhjo9KtRbFottdGIGGQE6hDk
         MaNhLlXXvy8ax+kFZ+0smeCt61AmyIjO7yzjBiHXqP4Aw9ax1UmsCiFaLgX0QVa2VmN6
         m1rfybFs9vEWbgQdn/KN5yw3gBsTj53wKELH22qGSuZK/7oII8jUO1sLKYZj4Kdg8Wps
         Fu4t/MavhnJbjfBZ36zwiPONiuO0xfdtIW9Et8v5qIfw0ZzHNXo3jbFQrfFSOfS+atc5
         RxnkmPMjSi3fFT4hcQ+aWZQcwg6Q/hJCjdnwAIgunaBrEri2KLpcMnwR1W14nAQS2JFN
         QsrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795187700; x=1795792500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BTVg64Op0q6C9ndfjZSeyDDbPDPodfwIL2/3SvvfmEM=;
        b=WuTp10tMLt6quTLDUoIPlzwBypkOMQJNj+vf4TTfECZ/GqWqCsgs3AYI8wpAJ4SZx4
         MUuOzaDkO5uh5MZbFAOlrs8i8pZPQ6DS5JytlD7LMXxu+MjlhfSaM1gl+n6M3xhybkAz
         I6DVJtTZlrfQFu4Xj33bsQAhE3hVTCEvGP2suhCDp6l/8JKo8WXlhqEJCBun9SGSSXvC
         r0DI1bP62/E6NgoLI+h1+Hc3gmBR55Of/S0qPGWtxsE7gMYMn30DJ1Z4qnVOEeN4u9FM
         h2RpwA3/3BbD66QkA+HQkuuO0twdCZOWGVATOmbIEmdhKik1BikdQ6l8YXriWEXupjBK
         SKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795187700; x=1795792500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BTVg64Op0q6C9ndfjZSeyDDbPDPodfwIL2/3SvvfmEM=;
        b=axre50qgYaEIVTMi/va8EVZphC6UTqhaTDF9tetRajYnXpUgBEUqViYcXgHeHECjr2
         rlNGz9qokTBXwj3ZxKcdrehSYtM/iWLy6OmdvFRY70vn70vbt8JjEMlqm3nFEYzqO/G9
         UtMWhrVomq52ppFL0HF3ItYsZGHXzE/3QfhBRJGCLFl23Gg6K3J7XxLtfbN4v3CvddUA
         hJuE4mDFCIKDKshYTapWZJGH3ItzO1LI2fBBM30IhXoGde+XYGoP7tkFdaDjZgRteFBi
         huPTgR325qlBhwawrTmABjc0t1mkIzPjecPE4cHSIwIBnUa0e8EURRACtr4F2Dqkrwyb
         8Qdw==
X-Forwarded-Encrypted: i=1; AL+hErGugxMBVDswzuSaYev4Z487wzh8gI9o2Soy3NDuMu2xc/RctscFTEoYYAqkpulpzvojBBinliz1xMlYtQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/z+k5LMRzKk9DFjJkw66k5dWV7kVUFsyqSxU13x4GcvLsJsUOA
	TDbyZXIQ9Mp2jq9w7e84xdMtmoBsM5nLY3SEsq3YYaw+LLLNHJfM5p77Hh0MBIO5V2M02PwMfQ9
	D1GyNyxcFApLiJ5GflvTjCSkgLa3vYRs=
X-Gm-Gg: AZFdTZdjkOWdd3Lup8EitN2N+ZsdZVx8LnB8pztEHfLlZL1G7gqAw1G5K4E7znErnAo
	Qj5s7Sm2e2cpTgWzuD33suzMX0g6xgAnP4DBh84YPY50U2GA1xw1m5DJXgtAfgEMx/WOTbGIy+c
	pGZ4Z+6cWavMBS6dPXy3h92wc76Qxzi+1AXTMAr8yKJYauznJyq05TZssZSCeJzTWGIaz4UHpp/
	7+lBZVRXuJyZZW9YzyTbdIViZWIQuJ4p3qXPflQ+D1kba9U2s7ANkOxoOPsVh8F3W+BJsASPsDm
	8tMZHg4aLMI8msCNWI9vFX51iX6xEuYVqL2rB5Sv8+/pgL3iVryR56UTxPB4Gl0W5+xIiXKn9IA
	whsXiuQymFv0XUzrtopko20e0m9JCsXeMLAUcxjL/aoYMT1kp1lpyOytkCp0pSoKGGc4G6ekWf/
	Hccy0qqfGDIt0YwOHTRODaAkmwTmIF/8Zgj1vrt2JNOC2QvcKmr7Q=
X-Received: by 2002:a05:693c:4091:b0:384:483f:2ea0 with SMTP id
 5a478bee46e88-3856f65af07mr3934775eec.17.1795187699638; Fri, 20 Nov 2026
 07:14:59 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795095742.git.geert+renesas@glider.be> <CAPVz0n1+qXrO5P+rOBKOSOE86+WcmjNF0taWDZoWqerKrjVgJQ@mail.gmail.com>
 <CAMuHMdWPvKop0KAg_nff29ZeAELKprfmDtp8hDU2KPvJH5VVMQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWPvKop0KAg_nff29ZeAELKprfmDtp8hDU2KPvJH5VVMQ@mail.gmail.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 20 Nov 2026 17:14:48 +0200
X-Gm-Features: Aa3M54q53xAAi2-NE6j4-zP1TXb277cEgD_-5pZDZArGHR0nuFBgm3EHI75NcY8
Message-ID: <CAPVz0n3zsUixggHgKNzWsxtxDZ20GecHGa7qQf2RmzkoJ792KA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve MFD_ASUS_TRANSFORMER_EC dependencies
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 20 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 10:4=
5 Geert Uytterhoeven <geert@linux-m68k.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Hi Svyastoslav,
>
> On Thu, 19 Nov 2026 at 15:51, Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
> > =D1=87=D1=82, 19 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
15:52 Geert Uytterhoeven <geert+renesas@glider.be> =D0=BF=D0=B8=D1=88=D0=B5=
:
> > > This patch series improves dependencies for the MFD_ASUS_TRANSFORMER_=
EC
> > > MFD driver and its various subdrivers:
> > >   - The first patch adds a missing dependency for the MFD driver,
> > >   - The other patches enable compile-testing for the input, serio, an=
d
> > >     battery subdrivers.
> > >
> > > Note that compile-testing cannot be enabled for the LED and charger
> > > subdrivers, as they have a hard dependency on the MFD driver.
> > >
> > > Thanks for your comments!
> > >
> > > Geert Uytterhoeven (4):
> > >   mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
> >
> > Though this EC is designed for Tegra based devices, it does not have
> > any Tegra specific parts. It can be used by any other SoC.
>
> Sure, the dependency can be extended once the hardware appears in
> devices with other SoCs.  The question to ask is: does it make sense to
> ask about this driver when configuring a kernel for e.g PA-RISC or S390?
>

Restricting this device to Tegra, even though it is not part of the
Tegra SoC or Tegra-specific, seems plain wrong. If you want to
restrict it by architecture, restrict it to arm/arm64 instead. Your
logic is strange.

> > >   input: keyboard: Enable compile-testing for
> > >     KEYBOARD_ASUS_TRANSFORMER_EC
> > >   input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC
> > >   power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_=
EC
>
> As pointed out by Sashiko, I forgot to take into account the transitive
> dependency on I2C, so there will be a v2.
>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
