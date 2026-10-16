Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8446A61A;
	Fri, 16 Oct 2026 10:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145761; cv=none; b=aVke3ddHjJRNejQ6gugeBhjzfSdmnocLCpYOoTT3hrFqSBp7k3QxYBtIgqJYu6BwA6S4Sw1K7MQ2Rt9CcXgXNokqvRQphC8NEgSKvyJ0GdOUXfpUJ3831d3qr5xr1yl25mkRDjv5Fd3GC1E1AXgWS79KyMFUpli0ImUMbrMSZvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145761; c=relaxed/simple;
	bh=Ehcl0B7SfiHOi5RV/Sw2WoQYyYyKVSbATt4XSXVGjyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmfhOqUWmeUUlPJsU3aY86gzbDAc1aqsswzErV8YcRaPak89ksmOAQJ8pzAoXgIQ6g0ms9XPgy9NF9I5rKrOBUeDjmLn/kQIV4uvA1Q9IDPTDV0w1aVcHmh4Y81I9oP5aAX7nw9Gie6u/7qQoUr4I/6FviZwmYUkskxrihPKvsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HC7SX4pR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HC7SX4pR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79351F000C4;
	Fri, 16 Oct 2026 10:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792145760;
	bh=GP/kjuGx2fzgLmoe1V4NY3PcIUr3S0ZrKGtRNI+gTfM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HC7SX4pRK+hlrEuoHQyN5RYj8vBVz1YgeykYe0VsNkZD8FjZkc8UFPk/Ivapv2lDw
	 bzeEDah3ABtpGm2yQLLllmv5F5Z6bRbGtT7jg6ePSRwWRuxA0yD3aSh5gr9xAsAXMY
	 JeFI+EGjTfx65osDcMoHvxDdj9GNWaOMD/aiQkipfSbzm/FxtbeXMrMagGLyKLsLwj
	 YjhV7cNe57AOW59HD7Xt0+DoMDZXfw33YlPAxAIuogfmI9G60NyfUgbuxl0sv6Svmj
	 hipCYIO1keDL2+7Lc6GOdfmE2HKXOM/K+ZguARFPb0JsIfQiGUeoPBuF6TMjfefYD4
	 jgcReGB8xShuA==
Date: Fri, 16 Oct 2026 12:15:54 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Michael Zaidman <michael.zaidman@gmail.com>, 
	Rishi Gupta <gupt21@gmail.com>, Heiner Kallweit <hkallweit1@gmail.com>, 
	David Barksdale <dbarksdale@uplogix.com>, Andrej Shadura <andrew@shadura.me>, 
	Johannes Roith <johannes@gnu-linux.rocks>, linux-input@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] HID: hidraw: Encapsulate struct hidraw and make
 hidraw.h private
Message-ID: <atH4tx8B_alkLgu9@beelink>
References: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014051326.3784498-1-dmitry.torokhov@gmail.com>

Hi Dmitry,

On Oct 13 2026, Dmitry Torokhov wrote:
> This series cleans up internal HID core and hidraw header boundaries.
> 
> First, internal HID core declarations and unused symbol exports are
> moved out of include/linux/hid.h into a private drivers/hid/hid-core.h
> header. Next, a hidraw_instance() accessor is introduced in
> include/linux/hidraw.h so HID drivers that only need the hidraw minor
> number for naming or debug logging no longer dereference struct hidraw
> directly. After converting the drivers and dropping unused
> linux/hidraw.h includes, hidraw.h is moved to drivers/hid/hidraw.h and
> struct hidraw along with its internal buffer and list structures are
> made private to drivers/hid/hidraw.c.

Series looks good to me. However I have a couple of hiccups:
- the series doesn't apply cleanly on v7.3 (conflict in
	include/linux/hid.h, which seems 7.2 based), and also not on v7.2
	(conflict in 2/5 this time around)
- Jinmo kind of hijacked the series, and now b4 thinks 1/6 is Jinmo's patch.

Would you mind respinning it on top of 7.3-rc7 or hid.git/for-next?

Cheers,
Benjamin

> 
> Dmitry Torokhov (5):
>   HID: core: Move internal declarations and drop unused exports
>   HID: hidraw: Introduce hidraw_instance() helper
>   HID: Use hidraw_instance() in drivers
>   HID: Drop unused linux/hidraw.h includes
>   HID: hidraw: Make hidraw.h private to HID subsystem
> 
>  drivers/hid/Kconfig                     |  3 ++
>  drivers/hid/hid-core.c                  |  7 ++--
>  drivers/hid/hid-core.h                  | 20 +++++++++++
>  drivers/hid/hid-cp2112.c                | 15 ++++----
>  drivers/hid/hid-ft260.c                 |  2 +-
>  drivers/hid/hid-input.c                 |  4 +--
>  drivers/hid/hid-led.c                   | 10 ++++--
>  drivers/hid/hid-mcp2200.c               |  1 -
>  drivers/hid/hid-mcp2221.c               |  1 -
>  drivers/hid/hid-quirks.c                |  1 +
>  drivers/hid/hid-u2fzero.c               | 10 ++++--
>  drivers/hid/hid-winwing.c               |  1 -
>  drivers/hid/hidraw.c                    | 48 ++++++++++++++++++++++---
>  {include/linux => drivers/hid}/hidraw.h | 32 +++--------------
>  drivers/hid/usbhid/hid-core.c           |  1 -
>  include/linux/hid.h                     |  8 -----
>  net/bluetooth/hidp/core.c               |  1 -
>  17 files changed, 100 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/hid/hid-core.h
>  rename {include/linux => drivers/hid}/hidraw.h (58%)
> 
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 
