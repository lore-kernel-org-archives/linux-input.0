Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.62.234.254
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148126;
	b=WUGCWH9kk6+8hK9fE71yL07/fVxg+Siz0p+isYqd0IggOfPAd5DKHLH/VLt0amtiOtMD
	 pBgtBKjAYGwg0u2SGFqb7hCNdvaoSyC6j/19oKO0FZeKQjoqsuVi6XSkYft0W18vdIB4A
	 Yb2smoxeE9qLc85DwdJCDzZPrgkGMycg+7pYmEMDd/QS/kOmSrDQdOgNOJ3vNknDiwJ89
	 feqkAdeS55HMKFKdvj9rjbADguWE6xTcavabc+1licIOrQJTmKeoM1pX4zo4MaiZs8YLH
	 dKntV/wHeeOvQAtyLWs/Kwct6wiO3Rrzl56pdhOlUrEhJBAlR3fYI/gzhAh3S3Bh8WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148126;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Received-SPF:
	 Received:X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-PPP-Message-ID:X-PPP-Vhost:X-Virus-Scanned:
	 X-Virus-Status;
	bh=+Y9xIcW79wCsOIJSrbxLrdNmDEfycOIMuPxVKpVjvIM=;
	b=TyKTi1wE9KvYxJPOlov/zmKZYwCZNRds84EBbWmUlY0/YLq1DGpINJB3IA8Q0X9aNvZl
	 2o9ySoAVuXuVkLjOhAQmgyDEzmP6mIyEl9tnD4n7QFT2Pz78+2O4S/ZAZuU+xqJ7iLUkv
	 RdY+hNPbCFhHnxyWgkdWik584hriR30Pv6DHT0fUGYbw1DSXiZRfK6sbTWGxzB3iwjeVv
	 EhbkNf4OZi6YAuTDbML7nGDN/yhXaPfLuLa3ugIeDYYZ66dGMNhTLdnMKBFYH6+klwm9q
	 yWlYV3lYX0tDceQCjQ1RzbD4QdepSy4NqHDnv9OBK9mG/AaRVNis9B2iNUEhNQ1ze0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=antheas.dev;
	spf=pass smtp.mailfrom=antheas.dev;
	dkim=pass header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b=E+ptHQh5;
	arc=none smtp.remote-ip=46.62.234.254
Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E084A606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 14:28:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E084A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b=E+ptHQh5
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id 2047A3ECD1
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 14:28:44 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id 5426E3EAB8
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 14:28:43 +0000 (UTC)
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 8B7121FEB0F
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 16:28:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1794148122;
	bh=+Y9xIcW79wCsOIJSrbxLrdNmDEfycOIMuPxVKpVjvIM=;
	h=Received:From:Subject:To;
	b=E+ptHQh5ruep8fOg+nL5e9tg/DrYqYLSXSoHLAaeIoZ7H93Su4riS3wt161dv3f91
	 JOq2L1gjQJt2R0epl3ZT5GvF7YSWDDSxxwju0jQyw6Cu1iyyMUNuWOa7HLPkrXYXPQ
	 nNKFRTrGovcyULuYLG1bZjlzRFae+nB0iTBAamkbmWBQKgFtntIO6DaFrFKwK+mWNn
	 oA9+v/EvcBL85g2pNyO15+ahOIJOMLbHmfuAt4Q/zn9Df2n9V88KXx5NSvl6cjsRIA
	 D+qrYjhBSihhFyaX6Jtt5y8MyawIwsXCqDhV6OuyCoRxHStIbiGjxQtcxU9bChawQw
	 NvCbvyeDgTCsw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.173) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f173.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-8b6399ebb41so86436b3a.0
        for <linux-input@vger.kernel.org>;
 Sun, 08 Nov 2026 06:28:42 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGNOfHbbjOAyPUwNpb9515qCtFAr2QOzpIKDVgwN3IscfNrS/a34mXKq1dcmP/RN88ll5P6qtQ3w+j3jQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/41FkfY/CoV4+y6YFDBZvrAJgD3KuFaEg/HeJbQauB3MNgezCU
	7fK6YyZD8OK+fM4deks/JaFevOmpBRYqFhLE7YidDqS8u0Mip82upsASSVnZMVAxJFErBfJFy0x
	IJCLrZauraScmoyXp1vcealYJ3mz7osc=
X-Received: by 2002:a05:6a00:a245:b0:8b5:8fcd:a5d6 with SMTP id
 d2e1a72fcca58-8b670a21de9mr1358355b3a.41.1794148121377; Sun, 08 Nov 2026
 06:28:41 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: 
 <CAGwozwEKXJGBY5oZtdrrzfK-aOyYu5GaiOqkejSqbCPdeq0UJg@mail.gmail.com>
 <20261108135505.67330-1-hijae99@gmail.com>
 <CAGwozwHoTDCw63MoP2S6Qd1dk9Ym-=_E1e3oXOXkoWNfJxmUVQ@mail.gmail.com>
In-Reply-To: 
 <CAGwozwHoTDCw63MoP2S6Qd1dk9Ym-=_E1e3oXOXkoWNfJxmUVQ@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 8 Nov 2026 15:28:30 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwFv9x_d5WprytNTdgAFqepeqxgT6TTKeXLD8-G1Z9T3yg@mail.gmail.com>
X-Gm-Features: AclHuK-p_g_GdUHU1_lGxOnirMhox94ZRUMyLbTRe8D51RzYv4iMKddJMh8MKvo
Message-ID: 
 <CAGwozwFv9x_d5WprytNTdgAFqepeqxgT6TTKeXLD8-G1Z9T3yg@mail.gmail.com>
Subject: Re: [PATCH] HID: ayaneo-flip-kb: Add driver for keyboard backlight
To: Hijae Song <hijae99@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <179414812278.1256220.8033988307333111509@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 8 Nov 2026 at 15:26, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Sun, 8 Nov 2026 at 14:55, Hijae Song <hijae99@gmail.com> wrote:
> >
> > Hi Antheas,
> >
> > Thanks for the feedback.
> >
> > > If this is an actual keyboard product on the market and Ayaneo is
> > > sourcing the part for their device, look-up similar devices and kernel
> > > drivers.
> >
> > I checked. hid-sigmamicro only fixes the 0x0059 report descriptor, and
> > I found no SiGma Micro backlight driver on lore.
> >
> > > The name of the driver cannot be -flip-kb. You need to make sure it is
> > > generic enough to match most Ayaneo devices.
> >
> > 1c4f:007c also appears on the AYANEO Slide in hhd-dev/hwinfo, with the
> > same vendor interface (report ID 0x41, 7-byte feature report). I only
> > have a Flip KB, so I can only test the byte layout there.
> >
> > Matias's hid-ayaneo already claims 1c4f:0002 behind a DMI check for
> > AYANEO 3. Would you prefer that I add 007c backlight support to
> > hid-ayaneo once it is merged, or keep a separate driver named after
> > the chip? I lean towards hid-ayaneo, since the Slide may work the same
> > way, but I would like your view first.
>
> Mmmm so Ayaneo does not have a vid and may trample the pid of another
> device. That is not good. There is no guarantee this led profile is
> used by a different vendor.
>
> There are two options:
>  - Adding the keyboard to the hid-ayaneo driver
>      - This would happen after it merges
>      - There is 0 common logic between the rgb device and the keyboard device
>      - Driver registers a different led sysfs ABI and has convoluted
> dmi handling
>      - The driver would devolve
>  - Adding a scoped driver for the keyboard
>      - You can start now
>      - Can tightly scope to keyboard device
>      - name can be hid-ayaneo-kbd unless other vendor is found
>
> I would tend towards the latter. hid-ayaneo has plenty of work to
> merge. The controller firmware is quite unstable. Even my
> implementation in userspace is buggy. But that's fine... Windows is
> buggy too.
>
> I have two comments for your current version:
>   - remove all flip kbd references, name AYANEO_KBD
>   - use brightness values of 0 and 1, no scaling. DEs know how to
> handle these values by toggling.
>      - another option is 0-3, which looks nicer, but let's not get too
> deep into this
>   - use devm to register the led structure, drop remove entry point.
> Use devm prior to starting the device so that register code stays with
> initialization
>   - check if led subsystem is appropriate. I am not sure of the
> correct place. If not, current location is fine
>   - initialize host values to ff ff ff so on first write we get a nice
> white color
>   - if there is only one effect, brightness 0 is off. Do not add an
> effect handler

Ah yes, if the device supports Fn+Space, for this driver to merge you
need to send the correct hw notify and have at least KDE report the
cycling correctly. You will also need to read the values currently in
the device instead of hardcoding them. If it is a feature report, a
get_report should return current values

I am not sure what your current comment means about sending 0 breaking
the toggle.

Best,
Antheas

> With 2-3 revisions this should be good to go. While at it, try to find
> a Slide user
>
> Best,
> Antheas
>
> > I will also fix the two sashiko comments in v2.
> >
> > Thanks,
> > Hijae
> >

