Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164329;
	b=j+uxztwwOSFOqmBRYSGS8H9OToUJUSV9WJxzBO5NVUSduDlWY29UQgMYJ6xI16f43/Ba
	 FOZ5RkSyp+/79LLMvu8ArelWTQw2DajbtHu6A1kLCIOjDbQZBxiYJsf/Rmd0wh41NuQNM
	 TWpRam88/HSfQNA4bHqs1JgmViPNBv+X0CBBWpx9JMd7f6O8ccL424OkMTNPuN/HmsdvU
	 0Ln/mzIZLKvgd7KSnqo0Muob/fI+UQGAWJUu8ICyG0pTULEUatTLTmpV/kL5pv7mFZ8B2
	 BMOJGOgJ0DSUgJ8cP/LZjv1rOz2ALU/EzNT3fIgIqZ9tALKZzaJnCptOVdK9fttqq3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164329;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kKe/4cMcpovlVlLqvT7qtlmn5xNAbW7n/dTNm3KFNs8=;
	b=K7dydplcVonoO3wipCEsSUpPGHEquCHHrv89pZF/b/zn4iM8d1snihdKl9lEcgGXGGMP
	 gWh1Kd/HEF75WC9lvl4DH0CDoV2YuOYpLsaHL5CZzdvMtQqONK3vO00LwvJqed4bU93hD
	 5ynCIuKeFX7QoLatM533qPYERKJd5CC41Gw/a/SN/+QwbdMSgDmlyfNak9BK3t83nr81X
	 gtmO5fFrZd1ttJwEwPtqQ0KHbiSyQK8bpscgcBKDwfc3owoAlgO6nFUlYlYKL/GqL/eFG
	 ulLlokeU1QMHj5Lw+EEWXj9RccSyQb0WgZ6MrhdCvRxk7ywLoO93xls6eqCgQWl3dtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C571606B49F
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 08:45:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C571606B49F
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2b25786d9so336272137.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:45:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164328; x=1795769128;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kKe/4cMcpovlVlLqvT7qtlmn5xNAbW7n/dTNm3KFNs8=;
        b=wCwvD7PYqiJETSWalVUfha2CS1TP+tu3RaJCczYLiFS0CWZ4G6WZ5Gg9l4rgMUnA/K
         D5Ih70PtIiuBm8Gtom94qwP44smyEuYbjUfGafV/nzILOmyCQGdWMRPvwk+zpaK6/qOP
         Dpg34rAMLVXKZHPoIDDY/R+Pw5JGneBNL106dNrtyHOmcIzuGX3+xZjc9Cng+US1uYsY
         dg6jjXyywyJRjZngg/MO/BuxXlRMWl9Cj0uPpoYioOXzyX0fb6ng4aCbvLBbndWWYOFZ
         twnWz0uHrWWwgUvTf53bKX6SlJWkbz/w84U2u1c5nhLrHdJEo0rWNUshGa8Wzh5a/TMu
         0MGw==
X-Forwarded-Encrypted: i=1; AL+hErFjaLfNFNMBvH0ox0CF8Mm3g/eVc0B3KI7s6Fka0Oa0KMyT3pwA+WShtCSnVzcWTNiG19YXZvM5xhPhXQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/oCC0sH9m/J//vtgbZHowbbbQbkBDRbWpnKYLlT687mmHuIRFn
	LUg6etCwPALFOL2MQ5/GsFc5nwG93Qp+WPkEegjyIerCGSJtzq8Oyb2wF9JENib+
X-Gm-Gg: AZFdTZfqQLIwm2cYVyecwR38tnuxBtegUA6lJojkwaMJX80Cz9EtZ6rgCJorOvSY2y3
	Z93fA0km9N8grxcQxhQ8KCFwsxzlM09547XicbU8Tt3kCxyTvBce/dT6UmdJwsxJ+vKxFu52HIm
	5OEH99o1kk7A/TatZcXLfOhQ1tzhmbka41Ixk/moexHK6kIJM1Dv9q4XUNPdrzbot3v+QOytkNw
	ecnJLe2RlKPpcEz2hCE5uoLF3g6VznuYmY8+5ZO9Ww3YbhWVKvp5q/fPeYSaIUKUZqGtEyCiGEK
	c0XWwvchHS23xNYKBXsGfkJ1OKfxyhRMBqr+YmWDvjKiwR0BiPCBDB4lEUNn4RB1QOp+PiTIzd9
	NSj+7Eq7BAPRMow0jwiXKUBkSkfcWBu4a5jtbRftCUTT+hsvnGVYARoEQBMBqasIwMapTuEyW8u
	2FZI8YPf6CwrKUWmXupk4Qr5gDMT6eBCQvrmrBE3LVvVMWGRa1ZwoYm0f53m8l1Nf/ZLiRw5aB4
	GqzKzSISfZIBY34+vMyID+94Jcm6mKAo7EgpZN41p7g7Iz7vHo7mpaaTAru6aAc4KyHjd+A+RT6
	F/63DLRRqs1XONrWU5hT/SLfSlJ/bY3kbVkvmNkJsm13/5WJ2b0HoxG2j9/Q8g2Iy2k=
X-Received: by 2002:a05:6102:6e88:b0:7d6:6732:6cee with SMTP id ada2fe7eead31-7d73942ac6amr863731137.20.1795164328304;
        Fri, 20 Nov 2026 00:45:28 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7d784b3sm2315688137.2.2026.11.20.00.45.27
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 00:45:28 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-996eeadfbeaso380749241.3
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 00:45:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEkHeag+TZN/KElF6Wx5yJqrJbDHEcwUhXAkESDpI129U8V6kl551j3oXpMceE7l/GNNlKoj4IGb/7uag==@vger.kernel.org
X-Received: by 2002:a05:6102:6a83:b0:7cc:2c52:47aa with SMTP id
 ada2fe7eead31-7d71e35b5demr961144137.0.1795164327788; Fri, 20 Nov 2026
 00:45:27 -0800 (PST)
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
In-Reply-To: <CAPVz0n1+qXrO5P+rOBKOSOE86+WcmjNF0taWDZoWqerKrjVgJQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 09:45:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWPvKop0KAg_nff29ZeAELKprfmDtp8hDU2KPvJH5VVMQ@mail.gmail.com>
X-Gm-Features: Aa3M54rOiSTOIwRhd7pOhxBlMhXD66QjrOqwvbGtlwpHt8JjwbFg6d-mZpwSDxY
Message-ID: <CAMuHMdWPvKop0KAg_nff29ZeAELKprfmDtp8hDU2KPvJH5VVMQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve MFD_ASUS_TRANSFORMER_EC dependencies
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Svyastoslav,

On Thu, 19 Nov 2026 at 15:51, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> =D1=87=D1=82, 19 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15=
:52 Geert Uytterhoeven <geert+renesas@glider.be> =D0=BF=D0=B8=D1=88=D0=B5:
> > This patch series improves dependencies for the MFD_ASUS_TRANSFORMER_EC
> > MFD driver and its various subdrivers:
> >   - The first patch adds a missing dependency for the MFD driver,
> >   - The other patches enable compile-testing for the input, serio, and
> >     battery subdrivers.
> >
> > Note that compile-testing cannot be enabled for the LED and charger
> > subdrivers, as they have a hard dependency on the MFD driver.
> >
> > Thanks for your comments!
> >
> > Geert Uytterhoeven (4):
> >   mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
>
> Though this EC is designed for Tegra based devices, it does not have
> any Tegra specific parts. It can be used by any other SoC.

Sure, the dependency can be extended once the hardware appears in
devices with other SoCs.  The question to ask is: does it make sense to
ask about this driver when configuring a kernel for e.g PA-RISC or S390?

> >   input: keyboard: Enable compile-testing for
> >     KEYBOARD_ASUS_TRANSFORMER_EC
> >   input: serio: Enable compile-testing for SERIO_ASUS_TRANSFORMER_EC
> >   power: supply: Enable compile-testing for BATTERY_ASUS_TRANSFORMER_EC

As pointed out by Sashiko, I forgot to take into account the transitive
dependency on I2C, so there will be a v2.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
