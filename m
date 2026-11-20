Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795188815;
	b=AYDvMkjFmP0VjRMMQQlGWKw8kl4XmaXNF2urAo1j63rm5cvJuU/YJzWf0XAOpARSbZDC
	 CvrPlBLsY6XHsXcxPa/kusihYY3aA+TzzxzQR2cLbBMtWw7LWOdxtAtpQ54EEc3dfM0oh
	 8pD5sTPxd+gHGgf/tUfbAaYzzGo63cqmon9I6SGNeH5Th+fKlwrW1/1day9/pTUP78MZJ
	 SEovz7Z1PQCuRg6iRp7DCJ94Nu0FU3iWDmfvfAA62q18QmfCtc/pO/gg2yNtwvNnETUVb
	 jozF2MxBSfaYdLJeoeWIstafD83NuBe1vbD5zZ8PPCgT1kjDd7wMu76yztC/9XfcPmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188815;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=cn3lpGNrKpPmr2WW+2DRITn4KazHE8yVcfU/4bT7oXM=;
	b=2iXkxNGn9e0jUSPxMIU3J48uFcIXkqMgWLiTk/4hEIqwz0sbvx5GuhzK62nFMPI5xdPW
	 WzhnR2wEXpkMUZlSDCKZGVHvYku17h7Bgi3THNijjGB9rF+NqoUZsJ6L/Z6jlFO0seAIP
	 KRKp2AiPtzbbGeR6vSjbUr+qtl3KXTMPAZfzfYw/C7vdIBxYIhVhYc1dG8v2Any3RMEuf
	 qi90wPpg+a1EZr6ccTY498nWnzSjclK8i9JiTA31youKF6Nwm4CTqJhJnlfGWF/RxhgE8
	 hIlx9w9WLHmfiJEnd0k0XF5i24u9PbBpGqLK7IvH0Kt3PY8g1gB+BlBTC64751dTd/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55808606A32A
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 15:33:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55808606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b4efdc8c20so7050517b3.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795188814; x=1795793614;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cn3lpGNrKpPmr2WW+2DRITn4KazHE8yVcfU/4bT7oXM=;
        b=qGXbPNDgLLXHX6qD7UGF5cq24zSTJLNV3IwxvkD8TqXVYiJRh6hRTcIFpzHSn6x6TA
         zfMXwMkeyddK7+45aq600anK5AxeX3RL6IE72ovIeTpx44HsMgeLPSrS6p92h+qzNZu3
         jIgzYzTTJrjUJMrSxRi+iiYg5mGowFi1/Aw8M+zs9K+6LaSK2EV/ZEISc3NCPuaHytnI
         KKjJfpOi0WNJ27mRL/aQ1VNhlX3DnGsijb5GG3KQsv4NZEecbpziPeZFkF55V+CAMk4h
         Al4leJN9XMRZQaflM1kK3/Xe5O/b9P2gc8sdrE5ptyz750uX4gSrkm90wEGd4Jt9WsXw
         pYVA==
X-Forwarded-Encrypted: i=1; AL+hErFcrWzduKvaTkBpUcniVw2ph7Ut9zS16q3Nv1gbaJM4tIzLtZSJ5IATWsJqfAlIFOfy5vi4FwY4G4cvGA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9mXA2lJL7XTeLAjx28YEECcwE5m0zqBodd7tTsIYN8619AtNEC
	iIXbaVlqxoIBWQvJPbhaxEHgFKcuhEea4RkWYRIf5JS9knz3UV6QD8irF4W705bY
X-Gm-Gg: AZFdTZeQ/QoyNz4pArH7GzWbWcLnjRX6d0FuieJbca0zkuHPcQSpziYuKEUFhHpqFv9
	3zeT/UG857h433vxWDfvBo6jbGBLCvdsLRa/2IMwaTdy4milFXYYqMqLFFV+zroFwVcdkcXPyb6
	JODgVJpMgFMLL1yFGtXFIhsedu7MiKjriJEgRplTdTi/j3JUTAfsyYC+ZnBS1tX3lOKRw0CTBhA
	rK+JnaAYd7okU4keoziJBOLTiTdlAVmXGGSsY9ofIU2go60e/oNnQfs7XQvmgK1i0bh3Xx0zqlP
	M6PPP2Qmcs65hCI6QNxVooQtqV7e7dK+xL0n77KSWiB4BWj5IgtTjKAilXd75NnMfVuo8mCjGnF
	o8tcYdSNpv3XrNDxbUYHV1bP9giQ/mQqWUe3Aby33ehy05mspO2Z+rJ3ltuUVKxdheX9uuMGDc7
	rkfwj8teb7l7nKnZWsCMVjIf7thU8MYCybrhmWsepcE0ZGdFax1+p8VnViInE8qaWMpG40ty5Ku
	dB3k6aaFwOIDVNmx0u6rFvQdDcjeKR8Rkm4l+H4hVUpgkbiWbylCP8Z/PDrcYL2SxoMwL5d9AtG
	QCCNr8/cduKGc0Vj7TQDkjLXn9xujlebIMGqe8g/1MlTInH52h+DwMwh8jNzWrUtd8Y=
X-Received: by 2002:a05:690c:7348:b0:8b3:2b8:856 with SMTP id 00721157ae682-8b520524419mr18181877b3.68.1795188814096;
        Fri, 20 Nov 2026 07:33:34 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b52033f617sm14005017b3.39.2026.11.20.07.33.33
        for <linux-input@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 07:33:33 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7cc81984fceso416767137.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 07:33:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErE1r7e5V53N3bj0VKiNLZR8yQvKLKWmRkT98B7Z2y43oH3Cn277WP7eAJSgLj83ogvxQyu3SFYiz7UU0w==@vger.kernel.org
X-Received: by 2002:a05:6102:3f16:b0:7c0:1d48:b2a2 with SMTP id
 ada2fe7eead31-7d73968c860mr1362556137.31.1795188813290; Fri, 20 Nov 2026
 07:33:33 -0800 (PST)
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
 <CAMuHMdWPvKop0KAg_nff29ZeAELKprfmDtp8hDU2KPvJH5VVMQ@mail.gmail.com> <CAPVz0n3zsUixggHgKNzWsxtxDZ20GecHGa7qQf2RmzkoJ792KA@mail.gmail.com>
In-Reply-To: <CAPVz0n3zsUixggHgKNzWsxtxDZ20GecHGa7qQf2RmzkoJ792KA@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Nov 2026 16:33:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUOtO6XNw1MKW5CBi9MSK+5TxVJhf_4nOt=Zr=qordTJQ@mail.gmail.com>
X-Gm-Features: Aa3M54ph5eK70EiMju3R-mcxt-wZED0VO-z7mXKruy6-8v4cTNmqw-8EZNTAXM8
Message-ID: <CAMuHMdUOtO6XNw1MKW5CBi9MSK+5TxVJhf_4nOt=Zr=qordTJQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Improve MFD_ASUS_TRANSFORMER_EC dependencies
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, 
	Ion Agorria <ion@agorria.com>, Lee Jones <lee@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, mfd@lists.linux.dev, 
	linux-input@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Svyatoslav,

On Fri, 20 Nov 2026 at 16:15, Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> =D0=BF=D1=82, 20 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 10=
:45 Geert Uytterhoeven <geert@linux-m68k.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > On Thu, 19 Nov 2026 at 15:51, Svyatoslav Ryhel <clamor95@gmail.com> wro=
te:
> > > =D1=87=D1=82, 19 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 15:52 Geert Uytterhoeven <geert+renesas@glider.be> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > > > This patch series improves dependencies for the MFD_ASUS_TRANSFORME=
R_EC
> > > > MFD driver and its various subdrivers:
> > > >   - The first patch adds a missing dependency for the MFD driver,
> > > >   - The other patches enable compile-testing for the input, serio, =
and
> > > >     battery subdrivers.
> > > >
> > > > Note that compile-testing cannot be enabled for the LED and charger
> > > > subdrivers, as they have a hard dependency on the MFD driver.
> > > >
> > > > Thanks for your comments!
> > > >
> > > > Geert Uytterhoeven (4):
> > > >   mfd: MFD_ASUS_TRANSFORMER_EC should depend on ARCH_TEGRA
> > >
> > > Though this EC is designed for Tegra based devices, it does not have
> > > any Tegra specific parts. It can be used by any other SoC.
> >
> > Sure, the dependency can be extended once the hardware appears in
> > devices with other SoCs.  The question to ask is: does it make sense to
> > ask about this driver when configuring a kernel for e.g PA-RISC or S390=
?
>
> Restricting this device to Tegra, even though it is not part of the
> Tegra SoC or Tegra-specific, seems plain wrong. If you want to

The help text explicitly mentions Tegra-based tablets.

> restrict it by architecture, restrict it to arm/arm64 instead. Your
> logic is strange.

Sorry for my bad wording, PA-RISC or S390 were just examples.
Does it make sense to ask this question when configuring a kernel for
an Apple ARM machine? Linus Torvalds does't like irrelevant questions
popping up, so let's wait until he starts complaining?

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
