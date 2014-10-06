From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 3.17-rc5: kernel oops when exiting X under heavy load
Date: Tue, 7 Oct 2014 00:47:17 +0200
Message-ID: <20141006224717.GA11873@amd>
References: <20141003231109.GA4530@amd>
 <20141006181202.GA22781@dtor-ws>
 <20141006204526.GA28905@amd>
 <20141006210358.GA39707@dtor-ws>
 <20141006211430.GA31880@amd>
 <20141006213115.GB39707@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:36513 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaJFWrU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Oct 2014 18:47:20 -0400
Content-Disposition: inline
In-Reply-To: <20141006213115.GB39707@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>

On Mon 2014-10-06 14:31:15, Dmitry Torokhov wrote:
> On Mon, Oct 06, 2014 at 11:14:30PM +0200, Pavel Machek wrote:
> > On Mon 2014-10-06 14:03:58, Dmitry Torokhov wrote:
> > > On Mon, Oct 06, 2014 at 10:45:26PM +0200, Pavel Machek wrote:
> > > > Hi!
> > > > 
> > > > > > From the backtrace, it looks evdev related...?
> > > > > 
> > > > > Hmm, looks like it...
> > > > 
> > > > I don't think I can repeat that. I was doing crazy stuff at that
> > > > moment. (Typo fixes suggested below).
> > > > 
> > > > Thanks,
> > > > 								Pavel
> > > > 
> > > > Input: evdev - fix EVIOCG{type} ioctl
> > > > 
> > > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > > 
> > > > The 'max' size passed into the function is measured in number of bits
> > > > (KEY_MAX, LED_MAX, etc) so we nedd to convert it accoidingly before tyring
> > > > 
> > > > ###                           need               accordingly(?)     trying
> > > 
> > > Thanks, I'll fix them up.
> > 
> > No problem. BTW, I guess this should go to 3.17-stable at least, and
> > probably older stable releases, too...?
> 
> Yep. I'll wait for a bit though to give a chance more people to look it
> over before committing to my tree.
> 
> BTW, can I put you down as reviewed-by?

I'm not an input expert, but yes, it looks ok to me.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
