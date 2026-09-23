Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E08441684B;
	Wed, 23 Sep 2026 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150056; cv=none; b=aoOUQBRrUgwCRHin9R973yLRJUchuvRvA7xTZCP3LWktfCNve0hfaTPPnquiiHocC0ytf6rE1HLLGMo8CsOfSKM9h6UmVJTmez18VFg7jMqQc3KFltIMmwQ71Il33SoaKqR4Bdc5ell3TnlM6Te8LNuMhCFa5tHehm1rZxOj/f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150056; c=relaxed/simple;
	bh=g5NVr6Ppi6fxR1f48o6Y4diHY1Fv0IIfwPKdZ4ZEi0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFUIG+PUV0mbudLdklz2zM/+r8n6+92hfh0AwTzWJvpIsFGubWNqLdudg4mai96dAdlaum/VGMfUUUT+YUmiz09InwWLOvUViMycIxjVjSdQGNTMWdL7RC11O2EBZuI9hoTQUpeLwfBA9hdilXVFFUkqPbREQAwE27HiuAWFFIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEXPWWWN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEXPWWWN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A23F11F000FF;
	Wed, 23 Sep 2026 07:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790150055;
	bh=XI62g0/7hWWvvNwvVWmKBzN879ivTNVDgUYx4tZ0jmE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QEXPWWWNPWLQ5sAoNcwxcEAAIPW3/OH7SYCsgUARq6eQdAA49giv/5DoFOhZMJsu9
	 agwJEWeLhDc0qE26mH1Ev35Bg852UrPJniPW2y0EwMznt7aS7dUSscr+KvjNED6V7/
	 I1m0hB+W9et8VEh298tRNmfmJMCWE+Lr9FuSRbyTqFwbLzMW/9OAf/pcm3OgEPaXdR
	 Dy5IdUYQb6O8YMyhKqP1/kpmF0n+1YnmfZVyQDv0oOHiV/RjTdCXghOVa1CzE70N1w
	 RKvVATyx2Ap/h/v977NymSeuC6LXX7+kP+h+P981dU/6IBDa4+ir/uQXj8rl2t94qq
	 U2U1vBFaXnk9A==
Date: Wed, 23 Sep 2026 09:54:09 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Oleksandr Natalenko <oleksandr@natalenko.name>
Cc: Erik =?utf-8?Q?H=C3=A5kansson?= <erikhakan@gmail.com>, 
	Jiri Kosina <jikos@kernel.org>, Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Rafael Passos <rafael@rcpassos.me>, 
	=?utf-8?B?R3LDqWdvaXJl?= Stein <greyxor@protonmail.com>, Alexey Zagorodnikov <xglooom@gmail.com>, 
	Roman Stingler <roman.stingler@gmail.com>, Lovekesh Solanki <lovekeshsolanki00@gmail.com>, 
	=?utf-8?B?S2F0ZcWZaW5hIE1lZHbEm2RvdsOh?= <k8ie@mcld.eu>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] HID: logitech-hidpp: fix Bolt hi-res wheel handling
Message-ID: <arOEsd3o2zgXlyHW@beelink>
References: <20260922-feature-bolt-fix-v1-0-63b0fa8da0d3@gmail.com>
 <8P3_vvAUQ0qq3g6Cks8PBg@natalenko.name>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8P3_vvAUQ0qq3g6Cks8PBg@natalenko.name>

On Sep 23 2026, Oleksandr Natalenko wrote:
> Hello.
> 
> On úterý 22. září 2026 19:40:26, středoevropský letní čas Erik Håkansson wrote:
> > This series aims to fix high-resolution wheel handling for Logitech devices
> > connected through Bolt receivers as well as respect user settings for
> > scroll behaviour.
> > 
> > Patch 1 is Rafael Passos’s original implementation:
> > 
> > https://lore.kernel.org/linux-input/20260904034843.1340846-1-rafael@rcpassos.me/
> > 
> > His patch routes Bolt wheel movement through the HID++ child, where the
> > device’s HiRes Wheel multiplier can be applied. Patch 2 builds on
> > Rafael’s work by 1. supporting both high-resolution and low-resolution
> > scroll events, and 2. preserving user-selected high-resolution and
> > inversion settings.
> > 
> > The follow-up patch was developed with reference to the patches and
> > reported behavior in Magnetar-OS’s `logitech-bolt-hidpp-dkms` repository:
> > 
> > https://github.com/Magnetar-OS/logitech-bolt-hidpp-dkms/tree/main/patches
> > 
> > So my assumption right now is that the reason for the divergent results
> > people have had with the two different fix approaches (i.e. either passing
> > interface 0 and 1 as DJ interfaces, or Rafael's approach), where it works
> > for some, and only sometimes, etc. is that with user settings coming from
> > Solaar, we may end up in weird states.
> > For example, in the original patch, high-resolution events would go through
> > the generic HID which would treat each tick as a full wheel event, thus 
> > scaling the scroll way too far. That was solved with Rafael's patch but
> > that would instead fail to handle low-resolution events if high resolution
> > was turned off in Solaar while use_hidpp remained enabled, so a low-resolution
> > delta would be treated as high-resolution, which would result instead in a 
> > too slow scroll. Possibly, when Oleksandr switched devices, Solaar reapplied
> > some saved user settings, which conflicted with the driver logic.
> > 
> > With this patch, user settings from Solaar (or elsewhere) for high-resolution
> > mode and scroll inversion will be respected, 
> > and scrolling should work both in high-resolution and low-resolution mode.
> > However, if user-space turns off the use_hidpp setting while high_resolution
> > remains on, this will route high-resolution scroll events to generic HID.
> > Thus, when high_resolution is on for a Bolt device, the driver will
> > force use_hidpp to be on during initialisation or reinitialisation, because
> > otherwise the scaling issue will return.
> > Solaar may still, after driver initialisation, reapply a saved use_hidpp
> > setting of off while high_resolution remains on, or the user may change it
> > to off, which will cause the issue even with this patch.
> > 
> > In theory, it should be possible to look at incoming setWheelMode responses
> > or notifications and, just like on initialisation, enforce use_hidpp as long
> > as high_resolution is set on a Bolt device. However, I don't know how Solaar
> > will behave then. There's a risk it will trigger a back-and-forth if Solaar
> > reapplies its saved setting after the kernel corrects it. Also, even if that
> > doesn't happen, we should respect user choice even for use_hidpp. Perhaps
> > the Solaar team can be informed about the problem so they can add a warning
> > text.
> > 
> > Note that I don't have a Bolt mouse to test this with, and my theory is 
> > mostly inferred, so I would appreciate very much if people with various
> > Bolt mice could test it out. Also great if you try different settings in 
> > Solaar, but note that use_hidpp must be on if high_resolution is on, so 
> > either set it to on in Solaar, or to ignore.
> > 
> > Link: https://lore.kernel.org/linux-input/20260712003051.338194-2-erikhakan@gmail.com/
> > Link: https://lore.kernel.org/linux-input/20260901-bolt-scroll-fix-v1-1-58bca7ae487f@protonmail.com/
> > Link: https://lore.kernel.org/linux-input/LYMlyJcyQt29e1KlLnEoLw@natalenko.name/
> > Link: https://lore.kernel.org/linux-input/20260920094508.39682-1-roman.stingler@gmail.com/
> > Signed-off-by: Erik Håkansson <erikhakan@gmail.com>
> > ---
> > Erik Håkansson (1):
> >       HID: logitech-hidpp: fix Bolt wheel mode handling
> > 
> > Rafael Passos (1):
> >       HID: logitech-hidpp: fix hi-res scroll for Bolt-connected MX Master
> > 
> >  drivers/hid/hid-logitech-hidpp.c | 147 ++++++++++++++++++++++++++++++++-------
> >  1 file changed, 123 insertions(+), 24 deletions(-)
> > ---
> > base-commit: 022eb347ff3a48281e7e69c3addcb11bf24afa53
> > change-id: 20260921-feature-bolt-fix-5f1f642496df
> > 
> > Best regards,
> 
> Not sure if I'm testing this right, but with v7.3-rc4 and these two patches scrolling works OK as long as I keep "Scroll Wheel Resolution" in Solaar off. Unlike with unpatched kernel, scrolling doesn't go crazy if I switch between devices. But if I switch "Scroll Wheel Resolution" on, scrolling jumps crazy again.

Hopefully we've got all of the involved people here.

Honestly, this whole situation has been running for too long: Bolt can't
be handled as a DJ receiver, and all the quirks I'm seeing here are
making things even worse, with the "as long as I keep [some user
settings] off".

Bolt in kernel was adding in 7.3, so I'm going to revert it now, and
we'll have to have a fully working plan for an eventual inclusion in a
future kernel version.

Cheers,
Benjamin
