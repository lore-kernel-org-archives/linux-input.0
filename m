From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: rotary encoder
Date: Wed, 30 Jun 2010 01:40:01 -0700
Message-ID: <20100630084001.GE4154@core.coreip.homeip.net>
References: <20100617101021.GB17833@buzzloop.caiaq.de>
 <B221BAA24375436992F7587DF15BB812@tech>
 <20100617112135.GC17833@buzzloop.caiaq.de>
 <B111F158EBCF48779A16E4EF5FAA2F84@tech>
 <20100617113725.GD17833@buzzloop.caiaq.de>
 <1E284238E08046EFA4038129CEA2527F@tech>
 <20100617120005.GF17833@buzzloop.caiaq.de>
 <20100628182225.GB7427@core.coreip.homeip.net>
 <20100628183229.GI2698@buzzloop.caiaq.de>
 <6F142F21F5134B03BDACDD706E7BCA3C@tech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:39715 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907Ab0F3IkH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 04:40:07 -0400
Received: by pvc7 with SMTP id 7so257528pvc.19
        for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 01:40:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <6F142F21F5134B03BDACDD706E7BCA3C@tech>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Vasil'ev <tech@digiton.ru>
Cc: Daniel Mack <daniel@caiaq.de>, linux-input@vger.kernel.org

On Tue, Jun 29, 2010 at 07:06:24PM +0400, Dmitriy Vasil'ev wrote:
> I am sorry, I am not a kernel programmer, I just share my code.
> I think, kernel maintainers must heck any code before applying it to kernel.
> 
> I have found of the problem:
> my editor uses \r\n as end of line symbol.
> original code uses \n as end of line
> 
> diff utlility could be more flexible....
> 

The diff utility does not know on which OS the resulting file will be
used so, by default, it reports everything that was changed. And it was
a good thing it showd all these differences as we do not really need DOS
format in kernel code.

> 1. I do not know how many people use encoder without button.
> Probably, need correct this code to disable using the button and
> free a irq, if button do not uses.
> 
> 2. I do not know what code inside the kernel use the rotary encoder.
> If this code there is, probably it need correct these code.

Just grep for it.

> 
> My patch, check it please before applying to kernel:
> 

I will assume that it was Outlook that butchered all indentation, but
no, it does not apply... It also does not seem to follow our kernel
style (and please do not consider us too picky, but we do request
everyone follow the coding style so that review process is easier and
we can concentrate on more important details).

Anyway, I think that mapping rotary actions on EV_KEY does make sense
and would be nice to have; the separate gpio/irq for press button is
better handled as a separate input device by gpio_keys driver.

Thanks.

-- 
Dmitry
