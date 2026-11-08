Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=78.46.171.57
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148253;
	b=qlusV+QzQoxV5pzhmJQhpeerxPnN6qv2ywXBr/XoVIgYgxN/Br1f5FcPdZeHWTotayj3
	 LHV5yWnkNhZIZ+x5sJG7fbZvO1dtXSZj+Z7KSpF8ceK+xjhEK7AK4TBSW0h5RAVtzWI2d
	 lhLaVT2c+DvIaI9p3i1jGnrDy+OyohbD2jPP/iTlNdikMjrwq4LQoKX8gwzb6BE7sjrIh
	 Yeq/IRveSIbOV8sETQZKGG95WiRFyS8CjvMdbGyeevlwlRDKOFW6IeYEaNK/kpMgdj5Lm
	 vIUnknWGu/iOm6kSxdNNi4GArjtjU8Oo1QrSJVcIUx4wa7kf1umvxsOWm6woclfPuBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148253;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Received-SPF:
	 Received:X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:X-PPP-Message-ID:X-PPP-Vhost:X-Virus-Scanned:
	 X-Virus-Status;
	bh=CY/McYpu+0ebDojIJRHMZeui4dASH1SC50Q2/rCUGZo=;
	b=bo62KRN4/6ykvI9YoInvQKK6UWnLHD40Ozkp88BqHUH4rHTSMFF745n92sNIGrqnk4bR
	 LHIIicqyuoOex0rmvpfp0HLMtvyNspgsnUde0XHA4h61OsL2Z2L1Kw3N2DfkYwGt/2KL7
	 gDPKQ8QgUdwveHXX6y88/qPwsi5vLo8xfapztVdGMKVtv6vvWeZ8DfUQmZlfwWcX4Of/u
	 72abwVwwCMGLfGPEPRThCNDO52Al87qodHM1rN2EfRcAb+6SXlSoJY8X8ObbkPAJrL+3F
	 6dVvsZ6St9sq6oWgAzcFdTpPPwrXtwMVAKurOX0hHrQsuqweIr3wfzq0iCNpLL08PYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=antheas.dev;
	spf=pass smtp.mailfrom=antheas.dev;
	dkim=pass header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b="Vpsbr/ey";
	arc=none smtp.remote-ip=78.46.171.57
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36957606A320
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 14:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36957606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.a=rsa-sha256 header.s=default header.b=Vpsbr/ey
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 3750EC253A
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 16:30:51 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 669E7C23F4
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 16:30:50 +0200 (EET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id A8C9A1FF289
	for <linux-input@vger.kernel.org>; Sun,  8 Nov 2026 16:30:49 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1794148250;
	bh=CY/McYpu+0ebDojIJRHMZeui4dASH1SC50Q2/rCUGZo=;
	h=Received:From:Subject:To;
	b=Vpsbr/eyQQH7R7tb57iuAbYx1TDcjTcAUw6honlEPUnyXJUG2/KvRMjdrSjAcjKMk
	 gFIKg1ousrfhpzOyitK+WCM3/3YJQH7wlCPKcswYjt4mBqf/ecSvtKEqJGBZdZtJms
	 1Z/j9itu0QXwh/EMk74IQOtNx8/H9foddmqnbe7SyI33C5C1DkWms5fo+ZlGtvSjwK
	 H4nVznhPwoULBPG8NOh4Ep5UIuFl277Rj5Ybli50SdpNyHakoq2EnwBVOJPfHid+TG
	 FlOSg5zzzSlLVqTkblUn5jv4JnmWGBy/0HsmYYXDxc+0BSmn3CgVrQNmfEphVPsoaM
	 8cNsDgquE8yjg==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.175) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f175.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2e942864693so431705ad.1
        for <linux-input@vger.kernel.org>;
 Sun, 08 Nov 2026 06:30:49 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AL+hErH6OX/TOhUSUQltpUwzQiGzCbHy5skJJVKSrTsPXe7gFrESIrBO2aOfi3t8ZEafbgJku2+W2q1HifiFvg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9yEWqkwH2fq5mSVLPDYZNhBcwrJFBCE9KjLPeoY19dXr9p0+kM
	MBfhJLis2sexXrFxa3qM/UrgOyheRdaDLTNRen8QF3ITx5i7R8GP2RHChqZ6L7JBWBJnWfvf4e0
	T+hqawGYJRox5RlQPxsjjZrWzcWOkxbQ=
X-Received: by 2002:a17:903:110e:b0:2ed:3be3:c63d with SMTP id
 d9443c01a7336-2ed837afe76mr13741695ad.23.1794148248256; Sun, 08 Nov 2026
 06:30:48 -0800 (PST)
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
 <CAGwozwFv9x_d5WprytNTdgAFqepeqxgT6TTKeXLD8-G1Z9T3yg@mail.gmail.com>
In-Reply-To: 
 <CAGwozwFv9x_d5WprytNTdgAFqepeqxgT6TTKeXLD8-G1Z9T3yg@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Sun, 8 Nov 2026 15:30:34 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE2vN9Za2eYNwaKHN-NjE6zRfC43-dSr2ug5-2OS2z_kw@mail.gmail.com>
X-Gm-Features: AclHuK_HzHti2lUaHGe0yFtShcc0XhjDDjFmALYvAZ1Wrf5mnv5HvKejfealJrA
Message-ID: 
 <CAGwozwE2vN9Za2eYNwaKHN-NjE6zRfC43-dSr2ug5-2OS2z_kw@mail.gmail.com>
Subject: Re: [PATCH] HID: ayaneo-flip-kb: Add driver for keyboard backlight
To: Hijae Song <hijae99@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <179414825005.1264551.10417894096191140096@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Sun, 8 Nov 2026 at 15:28, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Sun, 8 Nov 2026 at 15:26, Antheas Kapenekakis <lkml@antheas.dev> wrote:
> >
> > On Sun, 8 Nov 2026 at 14:55, Hijae Song <hijae99@gmail.com> wrote:
> > >
> > > Hi Antheas,
> > >
> > > Thanks for the feedback.
> > >
> > > > If this is an actual keyboard product on the market and Ayaneo is
> > > > sourcing the part for their device, look-up similar devices and kernel
> > > > drivers.
> > >
> > > I checked. hid-sigmamicro only fixes the 0x0059 report descriptor, and
> > > I found no SiGma Micro backlight driver on lore.
> > >
> > > > The name of the driver cannot be -flip-kb. You need to make sure it is
> > > > generic enough to match most Ayaneo devices.
> > >
> > > 1c4f:007c also appears on the AYANEO Slide in hhd-dev/hwinfo, with the
> > > same vendor interface (report ID 0x41, 7-byte feature report). I only
> > > have a Flip KB, so I can only test the byte layout there.
> > >
> > > Matias's hid-ayaneo already claims 1c4f:0002 behind a DMI check for
> > > AYANEO 3. Would you prefer that I add 007c backlight support to
> > > hid-ayaneo once it is merged, or keep a separate driver named after
> > > the chip? I lean towards hid-ayaneo, since the Slide may work the same
> > > way, but I would like your view first.
> >
> > Mmmm so Ayaneo does not have a vid and may trample the pid of another
> > device. That is not good. There is no guarantee this led profile is
> > used by a different vendor.
> >
> > There are two options:
> >  - Adding the keyboard to the hid-ayaneo driver
> >      - This would happen after it merges
> >      - There is 0 common logic between the rgb device and the keyboard device
> >      - Driver registers a different led sysfs ABI and has convoluted
> > dmi handling
> >      - The driver would devolve
> >  - Adding a scoped driver for the keyboard
> >      - You can start now
> >      - Can tightly scope to keyboard device
> >      - name can be hid-ayaneo-kbd unless other vendor is found
> >
> > I would tend towards the latter. hid-ayaneo has plenty of work to
> > merge. The controller firmware is quite unstable. Even my
> > implementation in userspace is buggy. But that's fine... Windows is
> > buggy too.
> >
> > I have two comments for your current version:
> >   - remove all flip kbd references, name AYANEO_KBD
> >   - use brightness values of 0 and 1, no scaling. DEs know how to
> > handle these values by toggling.
> >      - another option is 0-3, which looks nicer, but let's not get too
> > deep into this
> >   - use devm to register the led structure, drop remove entry point.
> > Use devm prior to starting the device so that register code stays with
> > initialization
> >   - check if led subsystem is appropriate. I am not sure of the
> > correct place. If not, current location is fine
> >   - initialize host values to ff ff ff so on first write we get a nice
> > white color
> >   - if there is only one effect, brightness 0 is off. Do not add an
> > effect handler
>
> Ah yes, if the device supports Fn+Space, for this driver to merge you
> need to send the correct hw notify and have at least KDE report the
> cycling correctly. You will also need to read the values currently in
> the device instead of hardcoding them. If it is a feature report, a
> get_report should return current values
>
> I am not sure what your current comment means about sending 0 breaking
> the toggle.

Ok got it. Make intensity take values of 0 and 1, and use those for
the mode byte. Do not scale intensities. Always send what is
programmed currently. Implement the readback correctly and see if the
device notifies you when brightness changes. If it does, use hw notify
(as other drivers do) to notify userspace and have them read the new
value.

Antheas

> Best,
> Antheas
>
> > With 2-3 revisions this should be good to go. While at it, try to find
> > a Slide user
> >
> > Best,
> > Antheas
> >
> > > I will also fix the two sashiko comments in v2.
> > >
> > > Thanks,
> > > Hijae
> > >

