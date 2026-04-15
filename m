Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3C3AF661;
	Wed, 15 Apr 2026 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776241400; cv=none; b=qwt4+Qgt7S5P1AOsuR6mTA4anUMXqTexmh2hdmS2c8oB3rJok5eEdmCJEMxE0pbm9aj0c36t/tGS4fkwjmFGhSYNNvJPrs5bZVBggMzzgzUPgB3jyhKjj4vgsfYqyCXr8BmhN3Qe+GhWxaQvA8xr69cylV0QhLxWAZqXY/GPbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776241400; c=relaxed/simple;
	bh=A4nUBX2GSi8UiPiqK6yXaxRW0DyfFtlAi/F6l2Q+T1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXwsujFEzql2T71NE1cDxH4Ah05uaYRYVoiywNast3KSyzIHSpkqOgb4DjHtjhJE3wjPvypPU7fWg1KxVS3bdOpjTUzihJEq/RKgqo457asd0pz7BT5OoYfDiqlJ/unkhxlsH39Sqiff6SQOkQhOLLDF59yRPmy3wY9zkEsmkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=my2DbNSp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="my2DbNSp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A627BC19424;
	Wed, 15 Apr 2026 08:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776241400;
	bh=A4nUBX2GSi8UiPiqK6yXaxRW0DyfFtlAi/F6l2Q+T1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=my2DbNSpYQur5O3kGa1j7cdcBQkqfJWQdB3Kzi8Qwsl9p2ZbKW0R05hyWWzeygLG2
	 EWi7s0MCAbGT8BWT2OEUq9THjlY2if5KP8/zuPdcEG7nnlpawxnMi4U+cphwVPzdh0
	 Ufrdi9R8PM5yPhUxssWkR4PB45c2pVny3FJKX9E9inHSfZpWkyKExo/Q6UePAfgFj4
	 z7E0lbiKyCf8PXskY3/SvvQWaJdmMdIcBEvv98gj01Bb+v9t3tn7bPejheMYwEWhac
	 mWWs8ybLJndHwMEvbQ780IClPp6yYBu0Nq1Yw3GsEDNCbZj/AHCYHXcSqCAAaIbhvv
	 1jwuM4nRsYSIw==
Date: Wed, 15 Apr 2026 10:23:15 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Jiri Kosina <jikos@kernel.org>, denis.benato@linux.dev, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, honjow <honjow311@gmail.com>, 
	Anj D <aduvnjak@hotmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH] HID: core: add short report quirk and use it for GPD Win
 (2f24:0137)
Message-ID: <ad9IhFBm85HmoxB2@beelink>
References: <20260407173212.86942-1-honjow311@gmail.com>
 <adZ2PTzQ05iObcGt@beelink>
 <652713b8-aa98-4ca7-8cd4-8f7ad6cff77f@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <652713b8-aa98-4ca7-8cd4-8f7ad6cff77f@leemhuis.info>

On Apr 14 2026, Thorsten Leemhuis wrote:
> On 4/8/26 17:41, Benjamin Tissoires wrote:
> > Definitely not a big fan of that new quirk. The issue is that current
> > hid-core fix is too restrictive because it doesn't have enough
> > information, like the actual allocated buffer size.
> > 
> > On Apr 08 2026, Zhouwang Huang wrote:
> >> Commit 9e2a17d2e808 ("HID: gpd: fix report descriptor on GPD Win
> >> handheld (2f24:0137)") used report_fixup to shrink Report Count from
> >> 63 to 11 so that short reports from firmware <= 1.09 would not be
> >> rejected by hid_report_raw_event().
> >>
> >> However, firmware 1.10 fixed the report length and now sends the full
> >> 63 bytes.  Because report_fixup already shrank the descriptor,
> >> usbhid allocates a 12-byte URB buffer — far too small for the 64-byte
> >> transfer — causing continuous -EOVERFLOW on every interrupt-in URB.
> >> The HID report descriptor and bcdDevice are identical across firmware
> >> versions, so report_fixup cannot conditionally apply.
> > 
> > OK, so if a firmware already fixed the bug, I'll drop 9e2a17d2e808 from
> > for-next and not include it in the final 7.0 PR I'll need to send.
> 
> Well, that meanwhile dropped commit 9e2a17d2e808 ("HID: gpd: fix report
> descriptor on GPD Win handheld (2f24:0137)") was supposed to fix a
> regression honjow (now CCed) reported on 2026-03-23:
> https://bugzilla.kernel.org/show_bug.cgi?id=221271
> https://lore.kernel.org/all/20260324013847.68024-1-honjow311@gmail.com/
> 
> So it is still unfixed as of now, I assume?

correct. But the HW is faulty and a new firmware version works, so it's
not like there is no options. But...

> 
> Side note: was honjow even notified about dropping the commit?

Not sure we replied to the original thread. That's an omission from us,
but OTH, the "fix" was only in linux-next, never in a realease kernel,
so it was just a delay introduced.

> 
> > We can tell people to upgrade to the latest firmware
> 
> Well, that should not be required by users when it comes to regressions
> -- unless maybe no other way to fix a severe issue can be found. Is that
> the case here?

Sigh. The fix that was introduced in the previous release cycle was a
"security" one. Which explained it had a fast path in being merged into
the kernel and into stable. I hate those but there was something
fundamentally wrong in the hid core code. We already got numerous
reports that the fix is not breaking other devices but is way too
verbose, so a proper fix is on its way, as soon as I managed to properly
test it on my machine.

> 
> > while I work on a proper fix.
> 
> How far is a proper fix away? And will that be GPD Win specific, or fix

Should be out today or tomorrow, depending if my machine still randomly
freeze because of the latest 7.0-rc bugs

GPD specific -> no, it's basically restoring the old behaviour where we
authorize shorter reports, but only if the provided buffer is big
enough. This is is the case when we are dealing with an actual call from
a transport layer like USB or I2C, but not from uhid.

> issues with other issues, too. Because Anj D (now CCed) recently
> reported a flooded dmesg caused by 0a3fe972a7cb ("HID: core: Mitigate
> potential OOB by removing bogus memset()") with a APC UPS (USB VID/PID
> 051D:0002):
> https://lore.kernel.org/all/MW5PR84MB135613E7947113897DD9FDA4C7272@MW5PR84MB1356.NAMPRD84.PROD.OUTLOOK.COM/
> 
> That's with 6.19.12, as the commit was recently backported to 6.18.y and
> 6.19.y.

Yes, again, please redirect your wrath to the persons who decided that
this kind of bugs (that we admitedly have to fix) are security in some
cases :) 

But yeah, security bugs are an annoyance for anybody, and we are far
from seeing the end of it.

Cheers,
Benjamin
