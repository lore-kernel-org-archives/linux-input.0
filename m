Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232152;
	b=R8T54sdABQdjV+C5xJdmxAJgWyUOe8G80Tcy3kim3mE2efrpSnphWySaPmEGGiTNLTM5
	 iFnjDRUU1yH6e9WN9QZp5EjHJKvJp5aHFawa85fQAJJ7GSdz602VwsZb1a7uxyVGhaUY+
	 rmnrs2y8K1eFKV67RuUphQilhezOl6VZwEopEVDMqXU6oCWuY/Sasqh/++RQ84PMPeQKk
	 AI2Pf5Qh1LYcYZISne88r0QiE6Xq6y84I3PbnGRZeRcuhksEHL3nc7xgfwm3UWB+ZEXwS
	 jaP0e9OUswir3Ryik3vZ8jRZg5H5XRuxbZ4GUqeGSSqEof9l4R6HtpO3WREgFIdofVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232152;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=8PFZkQCD6ILn1s8X2AxhNNZGgEneoc7HoQXfmR+1pTg=;
	b=oZ10KMTkpRs+TdDFoooudwRsEmnevCe50jJogBjyjF6qALaDCzfxLq+B3QqPU5deg7Gn
	 Q7mWX5upjKmjUBPnWkViZDFuYQ96dc0ntX3hJK7H9/QvPWlNeT4VJV2CsBxkxpNu8q8gw
	 +RSvTjVxhSNkR5Rqj0z+Las2U8nE7KCUbjiucoH4Fu0RmTKPvwYgyzVb3cQswZprzN+IX
	 +ktrq4bzLaz+l5xCLjZ++ew/wQX5mG68uedkMQmPL0/NYC7s91U04Hepq/xymLErJZS1H
	 iBP+uWwfkxFQ4Bx5g2LLugxvfrtJGlE/8uwU/7zEstBKvXiLvFxN9XxLJ644oAYcReg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrvuAWsn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF61D606A31C;
	Mon,  9 Nov 2026 13:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YrvuAWsn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6041F008A1;
	Mon,  9 Nov 2026 13:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232151;
	bh=8PFZkQCD6ILn1s8X2AxhNNZGgEneoc7HoQXfmR+1pTg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YrvuAWsneTIpjPHVpdFdeFQ/vyNnkHZbq2gfydvtaRDQdYQE/9TRnu35Iu02xiTZC
	 5rcxFWeHs2xSn/AyZocNZXfDdlpBYe7YSzVNwVnQ1oJKK9yos8XekgXDK4ClVldt7O
	 Iw6O0BEJOs1WRBDy7Z8c0ek7hTrKA2eKC8BKFWgMUvjJrDPf1OsN9MbohC/miY3ZUi
	 GhJPpP9CppeUNFay6CcFwwhQdF7RhqPbJzJP+m5RDXJbOOcYNJUdDwcooCYoC+J0Dz
	 lqVDmT6VwL9HFAG4oqM0UiTQIm4Ugo2uW2ei6IL652kF11UVpPsrd5x0Jp/n/VG4nj
	 OFXaILSt2gpfQ==
Message-ID: <f6f843ea-1ab2-45fc-b844-7fbb646c686e@kernel.org>
Date: Mon, 9 Nov 2026 14:49:08 +0100
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] HID: lg-g15: G15 v2 LCD and game-mode support
To: Torstein Eide <torsteine+linux@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Maoyi Xie <maoyixie.tju@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261109094426.1432465-1-torsteine+linux@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20261109094426.1432465-1-torsteine+linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

+To: Benjamin Valentin <benpicco@googlemail.com>

Who also just submitted a G15 LCD HID framebuffer driver:

https://lore.kernel.org/linux-input/20261108173920.424072-1-benpicco@googlemail.com/

On 9-Nov-26 10:44, Torstein Eide wrote:
> This series adds support for more of the Logitech G15 v2 hardware to
> hid-lg-g15, plus a fix for the remove path.
> 
> Patch 1 exposes the GamePanel LCD contrast as a g15::lcd_contrast LED.
> 
> Patch 2 adds an optional fbdev framebuffer (HID_LOGITECH_G15_FB) for
> the 160x43 monochrome LCD, updated through deferred I/O, so userspace
> can draw on the LCD or bind fbcon to it without libg15/g15daemon.

Ok, so both of you are trying to turn this into a /dev/fb# device, which
I can understand but I'm not sure this is the best idea.

The /dev/fb# API is sorta deprecated in favor of the /dev/dri/card#
kernel-mode-setting (KMS) interface. Note this is not an invitation to
turn this into a KMS driver instead. Please do NOT tell your LLM agent
to turn this into a KMS driver.

Regardless of /dev/fb# vs KMS the problem is that userspace code
like GNOME/KDE will try to treat this as an actual display / an extra
monitor and that userspace code will now need some special code to not
treat it as such and may break without special handling added to it.

And we *never* break userspace so using a userspace API which is
intended for normal (extra) monitor / LCD panel  display output
is not really appropriate IMHO.

Which brings us to the question, why handle this in the kernel at
all. I realize that libg15/g15daemon are no longer maintained and
are obsolete. This is part of why I wrote the drivers/hid/hid-lg-g15.c
driver to move handling of the key-presses into the kernel.

But while handling key-presses is typically always done in the kernel
so far these kind of small status displays (again not a full blown
monitor / display output) has typically been done in userspace.

There are several projects for this, e.g. lcdproc, which is still
actively developed on github:

https://github.com/lcdproc/lcdproc

This works more or less out of the box with the G15 display, it does
still rely on the libg15render library. But that can easily be fixed
as shown by these kernel patches which in essence integrate a copy of
the relevant libg15render bits.

So maybe instead of writing a kernel driver you can write a PR for
lcdproc to remove the dependency on the unmaintained libg15render,
instead folding the render bits directly into the lcdproc code.

Note that on Fedora (you can try by booting a F45 livecd) after
installing lcdprod "sudo dnf install lcdproc" just replugging
the G15 keyboard will trigger a udev script which automatically
creates a lcdproc conf file to use the keyboard if no lcdproc.conf
exists yet. So this pretty much works plug and play without any
kernel changes...

> Patch 3 binds the G15 v2's second interface (046D:C226), which is
> currently handled by hid-generic, and exposes the Super-key-lock
> ("Game Mode") state as a read-only g15::game_mode LED. Normal key
> input on that interface is left to hid-input.

Patches 1 and 3 do sound potentially interesting although I wonder
how these interact with e.g. the existing lcdproc support which
uses this interface directly in hidraw mode.

Note again we never break userspace. So existing lcdproc setups
must keep working with these changes.

> Patch 4 fixes a use-after-free on remove: the LED work can be
> rescheduled by a key press between cancel_work_sync() and
> hid_hw_stop(). The bug predates this series, but the patch is
> written against the remove path as changed by patches 1-3, so
> it does not apply to the current tree on its own.

I'll reply to this patch seperately.

Regards,

Hans


> 
> The LCD wire format and contrast commands follow libg15, hence the
> Based-on-work-by tags for its authors.
> 
> All patches were tested on a Logitech G15 v2.
> 
> Torstein Eide (4):
>   HID: lg-g15: add LCD contrast LED
>   HID: lg-g15: add LCD pixel-content framebuffer
>   HID: lg-g15: report Super-key-lock state on G15 v2's keyboard
>     interface
>   HID: lg-g15: cancel LED work only after stopping the hardware
> 
>  drivers/hid/Kconfig      |  13 +
>  drivers/hid/hid-ids.h    |   1 +
>  drivers/hid/hid-lg-g15.c | 599 ++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 606 insertions(+), 7 deletions(-)
> 

