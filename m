Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.62.234.254
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794147999;
	b=Ock3QZKAuNTniVZH6dLndCeHxC5bKuf04W21Lwq/vlhJSp3sX2pTrPhH5Is6FWEOmnyU
	 PmgJe45TpcLR6jD2+m9iCsmXBAD6dL728lbS1KCWeqrx0+x3/3e/h/UWUN9Bzm74NfuFq
	 eg8Nv3Av9miuQe3ehZhQbAUfhxN0WC5S8h7BXsCc2xEw0khb+IX9vXt/WBKCytji7vZxU
	 rQTjG3fxGf9gJZm/Od4L1sWJY0rQZbkZ1/jJJgRzStRb63wVfpKt4WoE7YUeMNZ001EtJ
	 FkP7dRxTYjDEMdq4cUlYGElcZyzhoOLSk4bhQqov7wqe1Cy3N2GX7FXCks8m1M5ng6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794147999;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Received-SPF:
	 Received:X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-PPP-Message-ID:X-PPP-Vhost:X-Virus-Scanned:
	 X-Virus-Status;
	bh=fPRAwt6gCc/aeEGAwUvTMhd29rocLRC7MawVr2saLj8=;
	b=1sE1y+svuEL1lVIIk4LCmxKh4RDuwz3Fd6S1t2WcvbPuBZ0dYi3Hs9+f9wHQZm+EqsvX
	 zJl8CIVWp0rSVO2F/J+FISafIUpOz89AoPYR72kG2I5SqJkmIUfFKPRVslVUsdZulDNuV
	 lF6LlxbN8KX+/YXa7gb2caOsgvrwDMrfj+81cjPXmi5AiX+8fFf7qZimDd/JekzRnVGME
	 CY82yCulqmDpTSp1DlvuQmEQTgQOPHn4SvKjQZ54CH7oVpBbz7Ds/14IMJfAePXMeOm/W
	 dCyEw58qohrXu4E53rCHSm+ZZQYffE8lZbwmcRynqW3t8hgWZENIb/7S2Qno0nQHpWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=antheas.dev;
	spf=pass smtp.mailfrom=antheas.dev;
	dkim=pass header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b="eNl/2rCN";
	arc=none smtp.remote-ip=46.62.234.254
Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D461D606A31C
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 14:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D461D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b=eNl/2rCN
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id 58E7A3EBF2
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 14:26:31 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id A4B1B3EB42
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 14:26:30 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 9B7091FF1B7
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 16:26:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1794147990;
	bh=fPRAwt6gCc/aeEGAwUvTMhd29rocLRC7MawVr2saLj8=;
	h=Received:From:Subject:To;
	b=eNl/2rCNp+kalS2Kn4dnSQCC7B3s1HpIu9MiVho65ORYPuOueYbsSUxCpemE/f+5Z
	 kKgUmFGUhWARIufAgPi/5mGiah0tzhVO5ZZ3IYW3+Bjy2I+qA+vW2uL2vhFG7PFC84
	 eGlRUZKiDw1lZw1cI0ZisXu3kIOXhvgXBbqmpcsUsLLnfcqVu9Od+oFUDYhzXDsz2D
	 n1/5LFKrDaq0oWJ9tbL2nj36BWHB5Hu/Kk4oSsUyfMR/nuCsKnCnywawStEwDWes1X
	 KfU6orNT4mxmGXnWdQQ4BMf+ZaX6uHRUPKoWjSjn5rpkM5rh3nOG521kKQo/YBil4S
	 TQUkcvUPINGwA==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.177) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f177.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2ed06b725fdso856075ad.0
        for <linux-input@vger.kernel.org>;
 Sun, 08 Nov 2026 06:26:29 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErGc4QKeskv5fX5QwsfZSU5QL/4gqSwmts8YmQ9QBTP85joffEViZLLv7CpA5HoBNxavZgGbwlNTVeQIdA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+9L+kpLdDRRcayBNRHGqC9YsvlCW3k28h/ZK0R7xGJRzBvDpYH
	Os4Tg/ATcG54HLFKPiY2rFsnWYBIHLd9TAruXxS9SsQizGwba7N3WEVNdp1IpVH/T2kl2QtgXPB
	EihIm8t0XJJiGvVU0kCjmRMqN7Jy+VaY=
X-Received: by 2002:a17:903:2290:b0:2ea:1079:e518 with SMTP id
 d9443c01a7336-2ed83036768mr10542495ad.0.1794147988317; Sun, 08 Nov 2026
 06:26:28 -0800 (PST)
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
In-Reply-To: <20261108135505.67330-1-hijae99@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 8 Nov 2026 15:26:17 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHoTDCw63MoP2S6Qd1dk9Ym-=_E1e3oXOXkoWNfJxmUVQ@mail.gmail.com>
X-Gm-Features: AclHuK8Ya8THLxcfdbiN4O0gUBtp_pOnojK24EKP4Xp8y6ZVUjHgAMUFgotFdxA
Message-ID: 
 <CAGwozwHoTDCw63MoP2S6Qd1dk9Ym-=_E1e3oXOXkoWNfJxmUVQ@mail.gmail.com>
Subject: Re: [PATCH] HID: ayaneo-flip-kb: Add driver for keyboard backlight
To: Hijae Song <hijae99@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <179414799001.1249102.4081009291327202754@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 8 Nov 2026 at 14:55, Hijae Song <hijae99@gmail.com> wrote:
>
> Hi Antheas,
>
> Thanks for the feedback.
>
> > If this is an actual keyboard product on the market and Ayaneo is
> > sourcing the part for their device, look-up similar devices and kernel
> > drivers.
>
> I checked. hid-sigmamicro only fixes the 0x0059 report descriptor, and
> I found no SiGma Micro backlight driver on lore.
>
> > The name of the driver cannot be -flip-kb. You need to make sure it is
> > generic enough to match most Ayaneo devices.
>
> 1c4f:007c also appears on the AYANEO Slide in hhd-dev/hwinfo, with the
> same vendor interface (report ID 0x41, 7-byte feature report). I only
> have a Flip KB, so I can only test the byte layout there.
>
> Matias's hid-ayaneo already claims 1c4f:0002 behind a DMI check for
> AYANEO 3. Would you prefer that I add 007c backlight support to
> hid-ayaneo once it is merged, or keep a separate driver named after
> the chip? I lean towards hid-ayaneo, since the Slide may work the same
> way, but I would like your view first.

Mmmm so Ayaneo does not have a vid and may trample the pid of another
device. That is not good. There is no guarantee this led profile is
used by a different vendor.

There are two options:
 - Adding the keyboard to the hid-ayaneo driver
     - This would happen after it merges
     - There is 0 common logic between the rgb device and the keyboard device
     - Driver registers a different led sysfs ABI and has convoluted
dmi handling
     - The driver would devolve
 - Adding a scoped driver for the keyboard
     - You can start now
     - Can tightly scope to keyboard device
     - name can be hid-ayaneo-kbd unless other vendor is found

I would tend towards the latter. hid-ayaneo has plenty of work to
merge. The controller firmware is quite unstable. Even my
implementation in userspace is buggy. But that's fine... Windows is
buggy too.

I have two comments for your current version:
  - remove all flip kbd references, name AYANEO_KBD
  - use brightness values of 0 and 1, no scaling. DEs know how to
handle these values by toggling.
     - another option is 0-3, which looks nicer, but let's not get too
deep into this
  - use devm to register the led structure, drop remove entry point.
Use devm prior to starting the device so that register code stays with
initialization
  - check if led subsystem is appropriate. I am not sure of the
correct place. If not, current location is fine
  - initialize host values to ff ff ff so on first write we get a nice
white color
  - if there is only one effect, brightness 0 is off. Do not add an
effect handler

With 2-3 revisions this should be good to go. While at it, try to find
a Slide user

Best,
Antheas

> I will also fix the two sashiko comments in v2.
>
> Thanks,
> Hijae
>

