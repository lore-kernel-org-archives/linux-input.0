From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: O_ASYNC not working on /dev/input/event* ?
Date: Wed, 3 Feb 2010 01:03:25 -0800
Message-ID: <20100203090325.GD22110@core.coreip.homeip.net>
References: <20100203085600.GA20743@atrey.karlin.mff.cuni.cz>
 <20100203090045.GC22110@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f182.google.com ([209.85.216.182]:51154 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754623Ab0BCJDa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Feb 2010 04:03:30 -0500
Received: by pxi12 with SMTP id 12so1199998pxi.33
        for <linux-input@vger.kernel.org>; Wed, 03 Feb 2010 01:03:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100203090045.GC22110@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-input@vger.kernel.org

On Wed, Feb 03, 2010 at 01:00:46AM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 03, 2010 at 09:56:00AM +0100, Pavel Machek wrote:
> > HI!
> > 
> > I'm trying to use O_ASYNC on /dev/input/event* (getting SIGIO when key
> > is pressed), but so far no luck. Is it possible that O_ASYNC is not
> > implemented there?
> 
> You should be getting SIGIO when driver sends EV_SYN/SYN_REPORT...

BTW, see here:

http://patchwork.kernel.org/patch/70736/

-- 
Dmitry
