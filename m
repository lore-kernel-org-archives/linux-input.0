Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2DF35E94E
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 23:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787613827; cv=none; b=ErmWksv8TPFYau5mr98QYSZIcggzaj2izTBBt+Lw2L1bx5ntN/+SgU6BDHvK73uBfgZxgrMy9B7eLXOMY9aoF/WpVDfohHe5V5fj1jhDXGydy5Ke2zWsFO2VPZgM0K8ZczgvzTuze+H343YkohTluqP4MeMrWXAxa7VGLpHICZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787613827; c=relaxed/simple;
	bh=O2KaOWkFXRg+1LMZ3Z+JN5rK7MIaOBDMwDjs5/2WHnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dHuuNB+eYgCjQ9kyMRYj0E/7J5hi4Cq4kgB0rccJJ/NUt967yl1B2QbHg8So6rpqwaOD3xQbnzA6f1OQo37L+7NelpvXPJSb4DI8WR4obUavPUZd9LcAldAgpDX/0drVBYQCzEJIJK8y33+GyXIX1uVytzlUmbEw002VW7cNcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=KF0Wt7XP; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="KF0Wt7XP"
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id E24EABDE04
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 02:23:43 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 285DCBDDDE
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 02:23:43 +0300 (EEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 6C43E1FFDAB
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 02:23:42 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1787613822;
	bh=87AnO6nSxcWbiZl2F889c0eg/LcEVCbXfZZlPYFQPN4=;
	h=Received:From:Subject:To;
	b=KF0Wt7XPIWTc9S3LVh9+bWqUqIykZI2J1A4CyhoW0+Tvq3T7PcHMRrC15tcIkEib4
	 CMRtJDOHFjjE339aRaQYbtmE+tqmsQdq/hVPqvl8MDhSxmmCphUMmWSU0DMrmTFDZD
	 l2OH8QkPeWzI9agilQ3JsUV7xtetqzoppV4TAiPGaANOJQLrwPw09mpVAM4W0Cx3Wr
	 hjx67sQ1pP3FNPaxhwwwz87YIGswQkbrLst4sc7stI7hoUSuNlNcU7QrvtVNhhtWHj
	 dtbxJg3mCIJ34lCj8tYI2Hf6j4rEiCl683FxRniYxEbCtfTQ8xUKM/FiE7lhAvARAf
	 Wv6ho/09jpB4Q==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.210.171) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pf1-f171.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-848593533cbso1356455b3a.3
        for <linux-input@vger.kernel.org>;
 Mon, 24 Aug 2026 16:23:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrWxqtlYNBdUUVrgShPkExLh86spMSA2jMP0TN83DrVGXrLjKTSZy3qm3Ajzv4GgDRmdJW8iWe6GNQk2g==@vger.kernel.org
X-Gm-Message-State: AFuF++njo4HSeq37xjgYvOJS14dq+Pema3MVtt3YlogzMJEG/lQFenmh
	u+RXG2W3Ec1glwJ08DeCmhhl48m1D3Ccmj/g5rDdui7rd5auchywxekJo6xESgzxolK46whnhsp
	E38thnF/DpjrOo29hKl6LWwtg19VX02k=
X-Received: by 2002:a05:6a00:2383:b0:835:6388:655d with SMTP id
 d2e1a72fcca58-8520ba30a62mr34780601b3a.14.1787613820817; Mon, 24 Aug 2026
 16:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: 
 <CAGwozwECcyX6vxJmiBhfO2DfOE6VbkURCArY6gvaqgXJEkA8BQ@mail.gmail.com>
 <20260824224737.97147-1-hello@matias.me>
In-Reply-To: <20260824224737.97147-1-hello@matias.me>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 25 Aug 2026 01:23:29 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwFdyATn5ZE+ACKqcLvsBTkRsiJ2xF4D+AoEtgpoBVOk9w@mail.gmail.com>
X-Gm-Features: AcwNN1UlzL8gED1iCflZ3GEQKM9rU4yJW2EFx-QYXjru8428U9RiqeatgwPv2wY
Message-ID: 
 <CAGwozwFdyATn5ZE+ACKqcLvsBTkRsiJ2xF4D+AoEtgpoBVOk9w@mail.gmail.com>
Subject: Re: [PATCH] HID: ayaneo: Add AYANEO 3 detachable controller driver
To: =?UTF-8?Q?Mati=CC=81as_Marti=CC=81nez?= <hello@matias.me>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Denis Benato <denis.benato@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <178761382270.4166159.6056550387911895915@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 25 Aug 2026 at 00:47, Mati=CC=81as Marti=CC=81nez <hello@matias.me>=
 wrote:
>
> > If you need userspace coordination anyway, including the multiple
> > timing hacks I had to implement, the question of having to route this
> > through the kernel arises.
>
> Fair question. What tipped it for me:
>
> - The RGB wants to be a LED class device to be usable by the existing
>   stacks (InputPlumber and friends consume /sys/class/leds, and with
>   hw_pattern in v2 the breathing mode fits an accepted ABI). There is
>   no hidraw equivalent short of every stack reimplementing the
>   checksummed vendor protocol.
>
> - The protocol and timing part (reply matching, retries, the eject
>   handshake polling) now lives in one place. What remains in userspace
>   is policy: when to cut controller power and what UX to wrap around
>   it. That split also lets the module/eject controls be exposed as
>   narrowly-scoped sysfs attributes instead of handing out the whole
>   vendor interface through hidraw permissions.
>
> - It complements ayaneo-ec, which already exposes attach state and
>   controller power on the kernel side, so both halves of the flow sit
>   at the same layer.
>
> Working on this also flushed out a teardown bug that v2 fixes: a
> brightness write racing a driver unbind could queue LED work that ran
> after the transport was gone and the driver data freed. Reproducible
> memory corruption under a write loop, and the window is reachable in
> normal use, since the controller power-cycles on resume and on module
> eject while userspace may be poking the LED.
>
> > Overwriting joystick sensitivity is a bit problematic. Can you see if
> > dropping those four bytes still allows RGB to go through? This might
> > be preferable.
>
> Confirmed on hardware: with bytes 22/23/37/38 left zero the firmware
> still acks the config command, and RGB (solid and breathing) and eject
> all work. v2 no longer writes them.
>
> > Consider implementing the pulsing mode it offers, there should be an
> > accepted ABI for it somewhere...
>
> Done in v2 through the hw_pattern trigger ABI (pattern_set /
> pattern_clear, same two-step shape as the sc27xx breathing pattern):
> "0 <t> <brightness> <t>" selects the firmware's fixed-period breathing
> at the current colour. Tested on the device, with an ABI document
> added.
>
> (v2 crossed your second mail in flight, so two things are still open
> there:)
>
> > Almost forgot. Magic value.
> [...]
> > Magic value. You need to justify those.
>
> Right. Both are empirical firmware timings inherited from the
> Handheld Daemon implementation (its reset sequence sleeps 0.5s
> between the reset and the config restore, and it polls at a similar
> cadence during eject); both are validated on hardware. Queued for v3
> as named constants (AYA3_RESET_SETTLE_MS, AYA3_EJECT_POLL_MS/POLLS)
> with a comment stating exactly that. I'll hold v3 briefly in case
> more comes out of the v2 review.

They are eyeballed timings that worked during my testing. Because I
operate in userspace I have the freedom to choose whatever timings I
want and change them whenever I want. Carrying them to the kernel
freezes them for the vendor device and there is a higher level of
scrutiny required before they are merged. Fiddling with timings is not
something that's favored in kernel development. You also only carry
part of the policy. Userspace still has to coordinate between the
calls to the EC so that is left to userspace. I am pretty sure I have
a lot of timing quirks there as well. So now you have a split policy
and fixing your userspace implementation requires that other
distributions backport your fixes, otherwise your software will not
work.

The full implementation would require a bridge similar to how hid-asus
talks to asus-wmi with a common header. It would also probably require
more timing quirks. The payout for asus is bigger though, because you
kind of need a working keyboard and brightness button and that should
not require userspace software. Asus devices also do not need timing
quirks. For a niche device with unstable firmware, not so much. Expect
upstreaming such a bridge to take around 4-6 months at minimum.

Those are my 2 cents.

FYI direct EC/ACPI/TDP access is a security boundary, so a kernel
driver is required for those specific subcomponents, but when it is
trivial for something like Chrome to talk directly to USB devices,
that argument does not hold much water for the controller itself.
There are already TDP driver patches for all current handhelds in the
market, so as far as I am concerned, I will slowly start upstreaming
my backlog and keep sending and reviewing dmi matches for the existing
drivers.

I did not disagree on the RGB part, that's a decent addition barring
timing quirks being needed and it should be relatively easy to
upstream. Some other downstream users find RGB control via a
standardized interface userful. I would advise some caution, because
e.g., I noticed hid-oxp got upstreamed using a global drvdata table
even though it is a HID driver and there are actually multiple
OneXPlayer models that carry both hid devices and now they will
potentially have their kernel memory corrupted. I think the cover
letter of the series said so as well [0]. I am not sure
oxp_hybrid_mcu_list is authoritative enough.

Give it a few days before sending a V3, others should leave feedback
as well. You sent V2 a bit too fast.

Best,
Antheas

[0] https://lore.kernel.org/all/20260407041354.2283201-1-derekjohn.clark@gm=
ail.com/

> Thanks for the review!
>
> Mat=C3=ADas
>

