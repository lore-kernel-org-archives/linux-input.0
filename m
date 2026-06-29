Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09C93C09F7
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782767655; cv=none; b=KR5E0IprTz0B96jYgzrT45w551bRoMi/Hk0UyQ6ePwOcR5bcrxQGCVhcEtr8JcPAzN2k9ZbOyAnUbExuqizFJU43IelykXAu3+8vREirivpL3Zz2j6KL3cU1rYcQGOSWbeUiB8CsZWhvXaarhC+JAQWJQ52IUiObg+UaKyMKGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782767655; c=relaxed/simple;
	bh=+gOM9aQ05Z4YiQIkfQyxGx42f2311iu0bqhzyGg3ItY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DeXrhKC1WX+sS0RgEte5P4YP+sJp7orVK2S6ikXtgCqpypSX91lkgmSRU+jKWa2UvzaqM3M6P4Ltf3zT8i4sZuWK+TEcMF4PE629iTZTshqpTWYp6EG/RwnTUhKl3V7nxXdqK8+9KyNSduq33BD2MxKmS66hlRWy/6LtF88nZK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=mU5RphQp; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="mU5RphQp"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 0C762BCF03
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 00:14:11 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 0451CBCCCF
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 00:14:10 +0300 (EEST)
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6D90A1FF460
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 00:14:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1782767649;
	bh=+gOM9aQ05Z4YiQIkfQyxGx42f2311iu0bqhzyGg3ItY=;
	h=Received:From:Subject:To;
	b=mU5RphQpir9oay+NFr6G2t4STzj20OHHnyIJCfsHB7OgFEz36F7b0QcrWOh/Lj1Yv
	 n83cOrtot9GdpEzaAZkofGrY5e62xY85aMcslYkTLslKZYRrqzBAL5sH5/GsKQJrP3
	 3lNUrHzLL6WmRaOrkMmjIsGdLju0E9nj+EqHkvv9VC8U5d1iAzNbROzF+xnXPcxVW9
	 oO1OShMYLpzFCxvxsk+psB1ZZ832xlekPVz+wmNUpLymTGcIxaIXwXjmSHuxsMLjeQ
	 eYYrheKFq39EmQN2/WvB1RPboLrdizC5G0y8xnQc5IFH5vtkypsL7zszZbJXuW1Szq
	 WAcrRAkj41a2A==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.216.53) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pj1-f53.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-37fb17e1435so1216471a91.1
        for <linux-input@vger.kernel.org>;
 Mon, 29 Jun 2026 14:14:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RqSjhFl3NyOf3YhDU5Bp0uX1w/SFN18h0PDLkRou6tIs8EJ5n1gImg3620prxGxqMxD1GxaKLZ+PE8aaw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVoVbwXS/myt6Q6Rm5gvS8a2qUtbJVDMli7eOFgiDCvZftgJjI
	AnXMYbv97IriV3VSHayqHLWp/pbV6fWsk1zP66+4+ndDGlz7GrPgf+0o55nmbgzPJKTrbZ02bOj
	kYy34FYPM539nfnVVkaBxP6dtQ/Vm7g4=
X-Received: by 2002:a17:90b:4c52:b0:37f:fda5:8d9a with SMTP id
 98e67ed59e1d1-380527d5d6emr616891a91.25.1782767647971; Mon, 29 Jun 2026
 14:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619001103.1189200-1-denis.benato@linux.dev>
 <rr8s664r-5s34-1815-57ss-32p461sopp45@xreary.bet>
 <ab282e6e-bc0a-4705-b25a-780d3ab33f5b@linux.dev>
 <CAGwozwFgw5aj1k_h60whKhTkzSf+vc=eEGvFz9sa-0rGoWOoww@mail.gmail.com>
 <abca959e-8757-426c-b641-f18cebfbeed5@gmail.com>
In-Reply-To: <abca959e-8757-426c-b641-f18cebfbeed5@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 29 Jun 2026 23:13:55 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwHCCre6EbCANiQA+zers7AWXDF8zQMsOuDn3G4hsiFkHw@mail.gmail.com>
X-Gm-Features: AVVi8Ce8ljwK-vnzDpKaiS1IzpLgo40aGtgWM7lhu-rQpdWxToNJPp7YqeeiMKI
Message-ID: 
 <CAGwozwHCCre6EbCANiQA+zers7AWXDF8zQMsOuDn3G4hsiFkHw@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] HID: asus: security fixes and more hardware
 support
To: Denis Benato <benato.denis96@gmail.com>
Cc: Denis Benato <denis.benato@linux.dev>, Jiri Kosina <jikos@kernel.org>,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	Benjamin Tissoires <bentiss@kernel.org>, "Luke D . Jones" <luke@ljones.dev>,
 Mateusz Schyboll <dragonn@op.pl>,
	Connor Belli <connorbelli2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178276764968.3727534.13742556389508411112@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 29 Jun 2026 at 23:11, Denis Benato <benato.denis96@gmail.com> wrote:
>
>
> On 6/29/26 22:21, Antheas Kapenekakis wrote:
> > On Mon, 29 Jun 2026 at 22:12, Denis Benato <denis.benato@linux.dev> wrote:
> >>
> >> On 6/29/26 11:21, Jiri Kosina wrote:
> >>> On Fri, 19 Jun 2026, Denis Benato wrote:
> >>>
> >>>> Hi all,
> >>>>
> >>>> I have added support for controlling the (way too bright) XG mobile
> >>>> LEDs in hid-asus and added the i2c version of already supported
> >>>> hardware that was probed only when it's a USB: these are two separate
> >>>> features changes and are the only two that are not fixes for
> >>>> pre-existing issue (see below).
> >>>>
> >>>> Auto-review bot has spotted a bunch of pre-existing problems alongside
> >>>> problems in my own code therefore at this point I am going to fix the
> >>>> more problems I can and including those fixes and improvements in this
> >>>> patchset.
> >>>>
> >>>> For v4 I decided to follow Antheas' suggestion of reusing the existing
> >>>> workqueue and by making it more generic I solved a good bunch of issues.
> >>>>
> >>>> The v5 iteration is simply me fixing a bunch of bugs in new code spotted
> >>>> by the bot. Thanks for providing such a useful tool!
> >>>>
> >>>> On a side node this patchset has a few more warnings: specifically
> >>>> "WARNING: Prefer kzalloc_obj over kzalloc with sizeof" but it's a false
> >>>> positive as that would introduce sleeping calls in atomic contexts.
> >>> Denis,
> >>>
> >>> thanks. Could you please flag which patches you'd prefer to go in still
> >>> for 7.1 and which ones are not critical and could wait for 7.2? The whole
> >>> lot is quite big.
> >> Hi Jiri!
> >>
> >> Patch 1 contains multiple fixes, mainly use of sleeping calls in atomic contexts:
> >> I'd say slap it in 7.1 fixes.
> >>
> >> Patch 2 is a minor improvement removing an OOM message to align the driver
> >> to newer code where that would have been a flagged warning: probably a fix for
> >> 7.1 but there's no rush for this one.
> >>
> >> Patch 3 is a logic fix, condition is very rare (not sure if even possible) but belongs
> >> to 7.1 almost certainly.
> > I would like to take my time on reviewing patch 4 in the next cycle.
> > The patch 5 does the backlight for the station? That looked _fine_ to
> > me but a second pair of eyes would be good because it is big.
> Mmhh I think you may have a mistake here? Patch 4 has your reviewed-by
> and it's for the xgm led.
>
> Patch 5 adds backlight for TUFs 2025 and 2026 models: asus is using
> the (almost) same firmware as recent ROGs just i2c instead of usb,
> so patch 5 add i2c to the list.

I want to review for the next cycle:
HID: asus: refactor the two workqueues and init sequence

Antheas

> > Antheas
> >
> >> Patch 4 new feature support: goes to 7.2.
> >>
> >> Patch 5 unsure. It adds support to the backlight, but to properly do it I'll need
> >> to wait for lamparray to be merged since autonomous mode must be disabled
> >> to take effect. I'd say 7.2 just because of the missing lamparray. Merging in 7.1
> >> has no downsides, yet IDK if putting in 7.1 violates some rule (probably yes?).
> >>
> >> Please give a (very) quick read to the following link:
> >> https://github.com/OpenGamingCollective/asusctl/issues/119#issuecomment-4723566635
> >>
> >> This is something I am full of tickets for, probably we have reached the thousand
> >> between discord, github and gitlab: very prominent issue and I'm eagerly waiting
> >> for lamparray support to appear upstream.
> >>
> >> Thanks,
> >> Denis
> >>> Thanks,
> >>>
>

