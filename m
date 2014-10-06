From: Dmitry Torokhov <dtor@mail.ru>
Subject: Re: 3.17-rc5: kernel oops when exiting X under heavy load
Date: Mon, 6 Oct 2014 14:31:15 -0700
Message-ID: <20141006213115.GB39707@dtor-ws>
References: <20141003231109.GA4530@amd>
 <20141006181202.GA22781@dtor-ws>
 <20141006204526.GA28905@amd>
 <20141006210358.GA39707@dtor-ws>
 <20141006211430.GA31880@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:48351 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbaJFVbT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Oct 2014 17:31:19 -0400
Content-Disposition: inline
In-Reply-To: <20141006211430.GA31880@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>

On Mon, Oct 06, 2014 at 11:14:30PM +0200, Pavel Machek wrote:
> On Mon 2014-10-06 14:03:58, Dmitry Torokhov wrote:
> > On Mon, Oct 06, 2014 at 10:45:26PM +0200, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > > From the backtrace, it looks evdev related...?
> > > > 
> > > > Hmm, looks like it...
> > > 
> > > I don't think I can repeat that. I was doing crazy stuff at that
> > > moment. (Typo fixes suggested below).
> > > 
> > > Thanks,
> > > 								Pavel
> > > 
> > > Input: evdev - fix EVIOCG{type} ioctl
> > > 
> > > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > 
> > > The 'max' size passed into the function is measured in number of bits
> > > (KEY_MAX, LED_MAX, etc) so we nedd to convert it accoidingly before tyring
> > > 
> > > ###                           need               accordingly(?)     trying
> > 
> > Thanks, I'll fix them up.
> 
> No problem. BTW, I guess this should go to 3.17-stable at least, and
> probably older stable releases, too...?

Yep. I'll wait for a bit though to give a chance more people to look it
over before committing to my tree.

BTW, can I put you down as reviewed-by?

-- 
Dmitry
