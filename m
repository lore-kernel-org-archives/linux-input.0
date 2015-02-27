From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/2] Cleanup and fix touch_down implementation
Date: Fri, 27 Feb 2015 21:18:47 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502272118290.19920@pobox.suse.cz>
References: <1424471119-4628-1-git-send-email-pingc@wacom.com> <alpine.LNX.2.00.1502270838120.19920@pobox.suse.cz> <CAF8JNhLmYCM3LmAeDoM+Hg9Wts5xmYpWAFzZGzBD3qOUWostFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51244 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbbB0USs (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2015 15:18:48 -0500
In-Reply-To: <CAF8JNhLmYCM3LmAeDoM+Hg9Wts5xmYpWAFzZGzBD3qOUWostFg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Fri, 27 Feb 2015, Ping Cheng wrote:

> >> before sending pen events. This idea has been implemented for
> >> Tablet PCs. But other tablets that support both pen and touch are
> >> not fully considered.
> >>
> >> Ping Cheng (2):
> >>   HID: wacom: do not send pen events before touch is up/forced out
> >>   HID: wacom: rely on actual touch down count to decide touch_down
> >
> > Ping, looking at the code, I think this both should go into 4.0 still
> > (i.e. not postponed for the next merge window), as it's purely fixes.
> >
> > Could you please confirm that for me?
> 
> Sure, they can go to 4.0.

The question rather is "do they absolutely have to?" :)

Thanks,

-- 
Jiri Kosina
SUSE Labs
