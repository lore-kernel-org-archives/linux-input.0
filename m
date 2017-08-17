From: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Subject: Re: [PATCH] serio: PS2 gpio bit banging driver for the serio bus
Date: Thu, 17 Aug 2017 12:51:33 +0200
Message-ID: <d9966e58f98ed5820154d9a979ca19f2@dk-develop.de>
References: <20170731222452.22887-1-danilokrummrich@dk-develop.de>
 <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
 <20170807182207.348762301bf3d7f8509b1bf7@dk-develop.de>
 <8e5e73575b3a70e0e60931698687471d@dk-develop.de>
 <CACRpkda=bYacXmv8SoQu3wPoZW9v+j8myZnme=QpofD=Y-gYTg@mail.gmail.com>
 <20170817090908.GP20805@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170817090908.GP20805-l+eeeJia6m9URfEZ8mYm6t73F7V6hmMc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On 2017-08-17 11:09, Russell King - ARM Linux wrote:
> On Fri, Aug 11, 2017 at 11:16:20AM +0200, Linus Walleij wrote:
>> writel() should be guaranteeing that the values hit the hardware, 
>> wmb() is
>> spelled out "write memory barrier" I don't see what you're after here.
> 
> Incorrect.  writel() has a barrier which ensures that data written to
> memory (eg, dma coherent memory) is visible to the hardware prior to
> the write hitting the hardware.
> 
> There is no barrier to ensure that the write hits the hardware in a
> timely manner - the write can be buffered by the buses, which will
> delay it before it hits its destination.
> 
> PCI particularly buffers MMIO writes, and the requirement there has
> always been that if you need the write to hit the hardware in a timely
> fashion, you must perform a read-back to force the bus to deliver the
> write (since a read is not allowed to overlap a write.)
> 
> The solution is never to use barrier() - barrier() is a _compiler_
> barrier and does nothing for posted writes on hardware buses.

Thanks for clarification. I thought I just need a wmb() to make sure 
writel()
can not be reordered with another store operation. I wasn't aware that 
writel()
is defined to guarantee this on every arch.

That having the correct execution order is not enough on some buses 
because
of buffering is really something to be aware of, thanks again for 
pointing
this out.

So for the scenario I was concerned about I would expect the irqchip 
driver
guarantees the write actually hits the the hardware (if necessary read 
it
back) before the function (disable_irq_nosync()) returns, is that 
correct?
Though, having the need should be very unlikely.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
