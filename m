From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: MOUSE_PS2_VMMOUSE and input/mice
Date: Sat, 16 Jan 2016 11:38:08 -0800
Message-ID: <20160116193808.GG9203@dtor-ws>
References: <20160115123928.d06e1fed.cand@gmx.com>
 <5698D343.3000606@vmware.com>
 <20160115132312.654ad5aa.cand@gmx.com>
 <56991418.1070701@vmware.com>
 <20160115175040.GA5664@dtor-ws>
 <20160116105735.5c659e05.cand@gmx.com>
 <20160116183008.GB9203@dtor-ws>
 <20160116211011.6aeff246.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34982 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752660AbcAPTiM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 16 Jan 2016 14:38:12 -0500
Received: by mail-pf0-f174.google.com with SMTP id 65so135227018pff.2
        for <linux-input@vger.kernel.org>; Sat, 16 Jan 2016 11:38:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160116211011.6aeff246.cand@gmx.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lauri Kasanen <cand@gmx.com>
Cc: Thomas Hellstrom <thellstrom@vmware.com>, linux-input@vger.kernel.org

On Sat, Jan 16, 2016 at 09:10:11PM +0200, Lauri Kasanen wrote:
> On Sat, 16 Jan 2016 10:30:08 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > > > Although we will make vmmouse work with /dev/input/mice, could you
> > > > please tell TinyCore that 90s are calling and they want their mouse
> > > > technology back? And tell them to switch to switch to evdev X driver.
> > > 
> > > TinyCore sends their regards, and tells they will consider evdev when
> > > Xorg + evdev + paraphelia can total less than 650kb.
> > 
> > I do not think you are doing your users any favors by limiting them to
> > PS/2 emulation. For desktops, unless they only use basic mice mousedev
> > emulation does not work well for neither touchpads, nor tablets, nor
> > touchscreens.  And for appliances you do not need mouse at all. Maybe if
> > you targeting kiosks with limited UI it will work for a bit. I wonder
> > how long Xorg will be keeping lights on for mouse_drv.
> > 
> > I am tempted to deprecate mousedev and maybe joydev as well. They were
> > supposed to fill the gap between then current applications and kernel,
> > but that was 10+ years ago.
> 
> Hi,
> 
> It's a choice we leave up to the users. The majority uses normal
> desktops with normal mice, touch screens and tablets tend to be a
> rarity in our userbase. So we can serve the majority without the bloat
> of Xorg, but those who need it can install it.

So people who do not need Xorg do not need the mouse either, right? I am
still confused who your target user base is.

> 
> That's why I was asking for a runtime way - the default should work,
> but so should VMWare's nicer mouse integration when Xorg is installed.
> That concern was resolved with the statement the older support is not
> being considered for removal. The original issue will be solved by
> disabling VMMOUSE in our kernel.

I guess you can disable this (bit then you need to carry Xorg vmmouse
driver), but then you'll still have to pay the piper once Xorg drops
root support and X vmmouse driver will not be able to access the
hypervisor port.

Thanks.

-- 
Dmitry
