From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: rotary encoder
Date: Wed, 30 Jun 2010 12:54:34 -0700
Message-ID: <20100630195433.GB12366@core.coreip.homeip.net>
References: <20100617112135.GC17833@buzzloop.caiaq.de>
 <B111F158EBCF48779A16E4EF5FAA2F84@tech>
 <20100617113725.GD17833@buzzloop.caiaq.de>
 <1E284238E08046EFA4038129CEA2527F@tech>
 <20100617120005.GF17833@buzzloop.caiaq.de>
 <20100628182225.GB7427@core.coreip.homeip.net>
 <20100628183229.GI2698@buzzloop.caiaq.de>
 <6F142F21F5134B03BDACDD706E7BCA3C@tech>
 <20100630084001.GE4154@core.coreip.homeip.net>
 <30BA0A72AA534DE289E9DA5963938449@tech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48488 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484Ab0F3Tym (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 15:54:42 -0400
Received: by pwj8 with SMTP id 8so416379pwj.19
        for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 12:54:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <30BA0A72AA534DE289E9DA5963938449@tech>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Vasil'ev <tech@digiton.ru>
Cc: linux-input@vger.kernel.org

On Wed, Jun 30, 2010 at 01:33:25PM +0400, Dmitriy Vasil'ev wrote:
> >the separate gpio/irq for press button is
> >better handled as a separate input device by gpio_keys driver.
> >
> >Thanks.
> >
> >-- 
> >Dmitry
> 
> Small note:
> 
> if you use two separate drivers for rotary encoder and it's button,
> you must work with two device nodes in user space.

Yes.

> If user space driver working with one device node, this more usable.

Not really. Having to deal with multiple input devices is something
that you have to handle. Hotplug, USB (taht sometimes splits its
interfaces into several logical devices), etc - devices are coming
and going and you simply have to handle this.

Thanks.

-- 
Dmitry
