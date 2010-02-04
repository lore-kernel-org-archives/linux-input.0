From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: O_ASYNC not working on /dev/input/event* ?
Date: Wed, 3 Feb 2010 23:09:25 -0800
Message-ID: <20100204070925.GA7832@core.coreip.homeip.net>
References: <20100203085600.GA20743@atrey.karlin.mff.cuni.cz>
 <20100203090045.GC22110@core.coreip.homeip.net>
 <20100204070253.GB3928@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f189.google.com ([209.85.222.189]:45684 "EHLO
	mail-pz0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab0BDHJa (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 4 Feb 2010 02:09:30 -0500
Received: by pzk27 with SMTP id 27so2464835pzk.33
        for <linux-input@vger.kernel.org>; Wed, 03 Feb 2010 23:09:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100204070253.GB3928@atrey.karlin.mff.cuni.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-input@vger.kernel.org

On Thu, Feb 04, 2010 at 08:02:53AM +0100, Pavel Machek wrote:
> > On Wed, Feb 03, 2010 at 09:56:00AM +0100, Pavel Machek wrote:
> > > HI!
> > > 
> > > I'm trying to use O_ASYNC on /dev/input/event* (getting SIGIO when key
> > > is pressed), but so far no luck. Is it possible that O_ASYNC is not
> > > implemented there?
> > 
> > You should be getting SIGIO when driver sends EV_SYN/SYN_REPORT...
> 
> Thanks, it works now. Signal setup needs to be before fcntl(). 
> 

Cool. Thanks for letting me know.

-- 
Dmitry
