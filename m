From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: wm831x-ts - Fix races with IRQ management
Date: Fri, 25 Mar 2011 00:30:32 -0700
Message-ID: <20110325073032.GB2590@core.coreip.homeip.net>
References: <1300142701-22260-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1300142701-22260-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20110318112043.GA27129@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:62894 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409Ab1CYHai (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 03:30:38 -0400
Received: by pzk9 with SMTP id 9so109141pzk.19
        for <linux-input@vger.kernel.org>; Fri, 25 Mar 2011 00:30:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110318112043.GA27129@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com

On Fri, Mar 18, 2011 at 11:20:44AM +0000, Mark Brown wrote:
> On Mon, Mar 14, 2011 at 10:45:01PM +0000, Mark Brown wrote:
> 
> > This revision reworks the close() implementation, hopefully more
> > robustly, which should address the main thrust of your comments
> > previously.  As I said in my previous e-mail the restrictions on
> > enable_irq() seem reasonable to me, the thing that's nasty here is that
> > we need to enable and disable the IRQs at all.
> 
> It'd be good to get something for this into 2.6.39.  At the very least
> this version of the patch avoids issues while the device is open and
> keeps any issues in close() which is an improvement.  If this approach
> isn't going to be OK please let me know so I can look into alternatives.

Mark,

Sorry for the delay.

I am just not comfortable with a touchcsreen requiring essentially 2
threads to operate (2 IRQ threads, 2 works).  I was thinking about
converting to a thread with a state machine and 2 non-threaded IRQs
disabling themselves and waking the thread up. Do you think something
like that would work?

Thanks.

-- 
Dmitry
