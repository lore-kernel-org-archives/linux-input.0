From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: add have_special_driver hid module parameter
Date: Sun, 1 Apr 2012 21:46:28 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204012137150.16928@pobox.suse.cz>
References: <1329773340-14066-1-git-send-email-spbnick@gmail.com> <alpine.LNX.2.00.1203301544270.25526@pobox.suse.cz> <4F78AD8B.9020104@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59354 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab2DATqc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 1 Apr 2012 15:46:32 -0400
In-Reply-To: <4F78AD8B.9020104@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Sun, 1 Apr 2012, Nikolai Kondrashov wrote:

> > > Add "have_special_driver" hid module parameter - a list of additional HID
> > > devices which have specialized driver on HID bus. Needed to support
> > > out-of-tree
> > > HID drivers.
> > 
> > I'd very much prefer just using sysfs (bind/unbind) way of doing things if
> > possible for this purpose. What do you think?
> 
> I've tried this and it is not suitable. At least not in the current shape.

Hi Nikolai,

thanks for looking into this.

> In short, two reasons:
> 
> 1. The HID report descriptor is parsed only once, on first device probe and
>    the resulting data is kept within device structure. It is not parsed
>    again after unbind/bind, thus report_fixup of my driver is not called and
>    the reports are getting interpreted according to the old one, rendering
>    the device (partially) unusable.

Hmm, you are absolutely right. This is the thing we should fix first, 
instead of introducing more-or-less hackish workarounds.

I will be travelling for the whole day tomorrow, so I will look into this 
onboard the airplane and will try to come up with a fix.

> 2. The udev rules and scripts needed to make it work in a plug'n'play manner
>    suitable for users are considerably more hacky than this solution.

As this is solely for the purpose of out-of-tree drivers, I believe it's 
better to keep the hackery in userspace though.

> I'd like to ask you to accept this patch for now.  Would it still be 
> possible to get this patch into 3.4? I promise to look for a better 
> solution. First step would probably be to fix rebinding.

Let's see whether we can come up with proper rebinding fix quickly enough. 
I don't want to end up introducing module parameter that we don't need, as 
we'll have to be maintaining it for compatibility reasons forever.

> It seems that you don't have much time recently to review/accept my patches.
> Would you direct me to someone else who could do this and thus reduce your
> load?

It's just a matter of prioritizing the incoming queue. I believe I process 
your new drivers and support for new devices by in-tree drivers in a 
timely manner.

But this is a core infrastructure change, influencing how we aproach 
out-of-tree drivers, so we'd better be sure to get it right before 
merging (even more so as your solution introduces a userspace interface 
(module parameter) that we'll have to keep forever).

Thanks,

-- 
Jiri Kosina
SUSE Labs
