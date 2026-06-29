Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE2B2DAFAF
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 20:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782765009; cv=none; b=RzCweSsQr5kRwz63xWR5HW9mcg7BmYjR8rN5FPT9wQc8SwQ/GdtuQ91nuuzdfCN4Uykb683r6CH0qgQiYDUHke4/rLNHHaRJMRhIVKcRAdqkpcncpEjDpoWlihBPkDzrNXOXJk3dxUvKVUQKxrhvDtwl6VYjsaMSR315BPU7ZEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782765009; c=relaxed/simple;
	bh=n24crFzAk2FSbUqxjkkN5R5xQukJazQfiv3LkGbGKoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tCDysWTbHVCMi6kwD2lV+aiXyAQee2v/6yXlnr0zK6sX0gAr5HCGPcE6m44BWRKx9XloUtJr5Usa/KD7+Ie6E3CZCWQtq+1HD4/ickx94oYIgR1Tom3QdOVpEk9ulrpp5i0rKK6mJtY23tvJ19mAN1SxRoNuwoutG0d2zciMrvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=Zg1mKinX; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="Zg1mKinX"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 51E1ABBF65
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 23:21:22 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 5941CBBF7A
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 23:21:21 +0300 (EEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id CF7661FF286
	for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 23:21:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1782764481;
	bh=n24crFzAk2FSbUqxjkkN5R5xQukJazQfiv3LkGbGKoc=;
	h=Received:From:Subject:To;
	b=Zg1mKinXyjcqUAJAEuJ+h+7BNTn7Zkgz/nfYiWwhfLYHqp7Qllgf4RlS8MxrwUCiv
	 f4no8k/s/fxglpMtbCgrL5Q5QSFFiXLHJ10VrXa00QeXN7HC9VQvYxg0ND/YKULyir
	 6Wj/R3w36Fk3xk9oFTt6AEFtbp2+eVbYeAFVLBc6E2vj0ZVgRfnKroG120p4xAvloP
	 13PnUn5w9XhldW8KKlXymslJ6s21BCzzdCbEg/3JKrH2WP5bmzcc0cliZ9O2CywWeQ
	 WvLgqoyJLi3rHGlGFzWIcr8z+LhOJTWk14wEVdHXnKwiikffsgvDT/C3QcEsyfsX4C
	 HNXlzj9fd9qCQ==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.170) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f170.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2c9ed0c7fc7so10311015ad.1
        for <linux-input@vger.kernel.org>;
 Mon, 29 Jun 2026 13:21:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ8d+tuPSR/oguHm1K1kf8w0BVNEHRrGztGAIG+s7LV3FzbfeI5cvrJ8IWzIUmCvat++kRPAjWI68K2rxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZg8AL7X7sqBJcjE3LUi9+3sLE1KLEdripyzqGz1mZjGvj17J
	RO9PYHUIJCF1B/wVX0o2sEietRigH95CLqtrGBRoXcci7lb/nM6Han/iqCW0hyn0lZhmCB2Rarr
	GNwVb9GaHpablbDR9g/6Jm13FSonx1qc=
X-Received: by 2002:a05:6a21:112:b0:3b3:cea:874d with SMTP id
 adf61e73a8af0-3bfc50b66damr777759637.18.1782764479354; Mon, 29 Jun 2026
 13:21:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619001103.1189200-1-denis.benato@linux.dev>
 <rr8s664r-5s34-1815-57ss-32p461sopp45@xreary.bet>
 <ab282e6e-bc0a-4705-b25a-780d3ab33f5b@linux.dev>
In-Reply-To: <ab282e6e-bc0a-4705-b25a-780d3ab33f5b@linux.dev>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 29 Jun 2026 22:21:07 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFgw5aj1k_h60whKhTkzSf+vc=eEGvFz9sa-0rGoWOoww@mail.gmail.com>
X-Gm-Features: AVVi8Ccl85gHIgGNWIEO3ZeaLZkUYgBfJUMi4dX0VGuOrBrl9o3tumRkOb7OGpA
Message-ID: 
 <CAGwozwFgw5aj1k_h60whKhTkzSf+vc=eEGvFz9sa-0rGoWOoww@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] HID: asus: security fixes and more hardware
 support
To: Denis Benato <denis.benato@linux.dev>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>, Mateusz Schyboll <dragonn@op.pl>,
 Denis Benato <benato.denis96@gmail.com>,
	Connor Belli <connorbelli2003@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <178276448106.3524854.4731433021550925237@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Mon, 29 Jun 2026 at 22:12, Denis Benato <denis.benato@linux.dev> wrote:
>
>
> On 6/29/26 11:21, Jiri Kosina wrote:
> > On Fri, 19 Jun 2026, Denis Benato wrote:
> >
> >> Hi all,
> >>
> >> I have added support for controlling the (way too bright) XG mobile
> >> LEDs in hid-asus and added the i2c version of already supported
> >> hardware that was probed only when it's a USB: these are two separate
> >> features changes and are the only two that are not fixes for
> >> pre-existing issue (see below).
> >>
> >> Auto-review bot has spotted a bunch of pre-existing problems alongside
> >> problems in my own code therefore at this point I am going to fix the
> >> more problems I can and including those fixes and improvements in this
> >> patchset.
> >>
> >> For v4 I decided to follow Antheas' suggestion of reusing the existing
> >> workqueue and by making it more generic I solved a good bunch of issues.
> >>
> >> The v5 iteration is simply me fixing a bunch of bugs in new code spotted
> >> by the bot. Thanks for providing such a useful tool!
> >>
> >> On a side node this patchset has a few more warnings: specifically
> >> "WARNING: Prefer kzalloc_obj over kzalloc with sizeof" but it's a false
> >> positive as that would introduce sleeping calls in atomic contexts.
> > Denis,
> >
> > thanks. Could you please flag which patches you'd prefer to go in still
> > for 7.1 and which ones are not critical and could wait for 7.2? The whole
> > lot is quite big.
> Hi Jiri!
>
> Patch 1 contains multiple fixes, mainly use of sleeping calls in atomic contexts:
> I'd say slap it in 7.1 fixes.
>
> Patch 2 is a minor improvement removing an OOM message to align the driver
> to newer code where that would have been a flagged warning: probably a fix for
> 7.1 but there's no rush for this one.
>
> Patch 3 is a logic fix, condition is very rare (not sure if even possible) but belongs
> to 7.1 almost certainly.

I would like to take my time on reviewing patch 4 in the next cycle.
The patch 5 does the backlight for the station? That looked _fine_ to
me but a second pair of eyes would be good because it is big.

Antheas

> Patch 4 new feature support: goes to 7.2.
>
> Patch 5 unsure. It adds support to the backlight, but to properly do it I'll need
> to wait for lamparray to be merged since autonomous mode must be disabled
> to take effect. I'd say 7.2 just because of the missing lamparray. Merging in 7.1
> has no downsides, yet IDK if putting in 7.1 violates some rule (probably yes?).
>
> Please give a (very) quick read to the following link:
> https://github.com/OpenGamingCollective/asusctl/issues/119#issuecomment-4723566635
>
> This is something I am full of tickets for, probably we have reached the thousand
> between discord, github and gitlab: very prominent issue and I'm eagerly waiting
> for lamparray support to appear upstream.
>
> Thanks,
> Denis
> > Thanks,
> >
>

