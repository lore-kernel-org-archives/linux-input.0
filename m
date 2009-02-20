From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] input: keyboard: introduce lm8323 driver
Date: Fri, 20 Feb 2009 14:54:12 -0800
Message-ID: <20090220145412.742feb9c.akpm@linux-foundation.org>
References: <1235046677-29959-1-git-send-email-me@felipebalbi.com>
	<20090220141505.d1d53e4b.akpm@linux-foundation.org>
	<20090220222911.GV32564@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40045 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752773AbZBTWzJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Feb 2009 17:55:09 -0500
In-Reply-To: <20090220222911.GV32564@gandalf>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: me@felipebalbi.com
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, felipe.balbi@nokia.com

On Sat, 21 Feb 2009 00:29:12 +0200
Felipe Balbi <me@felipebalbi.com> wrote:

> On Fri, Feb 20, 2009 at 02:15:05PM -0800, Andrew Morton wrote:
> > On Thu, 19 Feb 2009 14:31:17 +0200
> > Felipe Balbi <me@felipebalbi.com> wrote:
> > 
> > > +struct lm8323_platform_data {
> > > +	int debounce_time; /* Time to watch for key bouncing, in ms. */
> > > +	int active_time; /* Idle time until sleep, in ms. */
> > > +
> > > +	int size_x;
> > > +	int size_y;
> > > +	int repeat : 1;
> > 
> > lm8323_platform_data.repeat appears to be never-written-to?
> 
> Nobody is using that yet, still it's used in the driver:
> 	if (pdata->repeat)
> 		__set_bit(EV_REP, idev->evbit);

Yes, but that's presently dead code.

> Also, those spaces around : should vanish. Want me to resend the whole
> patch or just a patch on top of it ?

I already fixed that.
