From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mfd: twl4030: add twl4030-pwrbutton as our child
Date: Fri, 27 Feb 2009 14:12:12 -0800
Message-ID: <20090227141212.a2bc4a01.akpm@linux-foundation.org>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com>
	<1235762883-20870-2-git-send-email-me@felipebalbi.com>
	<20090227123649.d2d6408c.akpm@linux-foundation.org>
	<200902271358.46863.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57646 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755281AbZB0WMa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 17:12:30 -0500
In-Reply-To: <200902271358.46863.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, sameo@openedhand.com

On Fri, 27 Feb 2009 13:58:46 -0800
David Brownell <david-b@pacbell.net> wrote:

> On Friday 27 February 2009, Andrew Morton wrote:
> > > --- a/drivers/mfd/twl4030-core.c
> > > +++ b/drivers/mfd/twl4030-core.c
> > > @@ -101,6 +101,12 @@
> > > __#define twl_has_usb()________________false
> > > __#endif
> > > __
> > > +#if defined(CONFIG_INPUT_TWL4030_PWRBUTTON) \
> > > +__________|| defined(CONFIG_INPUT_TWL4030_PWBUTTON_MODULE)
> > 
> > OK, this is "wrong". __The core shouldn't need to know about specific
> > clients.
> 
> This is a pretty standard idiom:

That doesn't make it right.

>  only create the device
> nodes a system actually uses.

That happens automatically if the nodes are made when the client
registers itself with the core.

> > 
> > What has gone wrong here?
> 
> Not much I can see.  It's registering a platform_device,
> but only if it could be used on this system.

Again, that all gets fixed if this is done the right way around.  Run
your probe function.  If the hardware is there, register with the core
and all the nodes appear.  If the hardware is not present: bale.

The design of the whole subsystem appears to be upside down :(
