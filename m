From: Niko Rosvall <niko@fograven.net>
Subject: Re: Reading keys
Date: Mon, 10 May 2010 22:54:23 +0300
Message-ID: <1273521263.2199.17.camel@localhost>
References: <1273507273.2199.13.camel@localhost>
	 <1273510547.10849.10.camel@lovely>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:53334 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755128Ab0EJTy6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 15:54:58 -0400
In-Reply-To: <1273510547.10849.10.camel@lovely>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Linux input <linux-input@vger.kernel.org>

On Mon, 2010-05-10 at 18:55 +0200, Christoph Fritz wrote:
> On Mon, 2010-05-10 at 19:01 +0300, Niko Rosvall wrote:
> > Hi All,
> > 
> > I'm new to Linux kernel and actually subscribed to this list today.
> > So, i'm not even sure is this the right place to ask this, but:
> > 
> > I want to make a kernel module which detects a keypress and then
> > disables it. E.g someone presses F1 and my module would just "eat" it.
> 
> Interesting usecase, is it for a kiosk? And why don't you disable the
> keys in X or your application?
> 
> > Any examples and/or hints where to start? Some nice, small peace of code
> > would be very very nice.
> 
> You could hack input_event() in drivers/input/input.c
> 
> Thanks,
>  Christoph

No, not for a kiosk or anything. Basically I'm just having fun here and
trying to do a module which would disable caps lock key completely.

Of course I can do that using xmodmap, but where's the fun then? ;)

I did modify input.c (didn't test it yet thought), but what I really
want is just a simple module so I can load and unload it when I want.

Cheers,
Niko

