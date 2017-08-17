From: Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: Re: [PATCH] serio: PS2 gpio bit banging driver for the serio bus
Date: Thu, 17 Aug 2017 16:14:23 +0200
Message-ID: <52be16427347cefff9238902146df110@dk-develop.de>
References: <20170731222452.22887-1-danilokrummrich@dk-develop.de>
 <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
 <20170807182207.348762301bf3d7f8509b1bf7@dk-develop.de>
 <8e5e73575b3a70e0e60931698687471d@dk-develop.de>
 <CACRpkda=bYacXmv8SoQu3wPoZW9v+j8myZnme=QpofD=Y-gYTg@mail.gmail.com>
 <20170817090908.GP20805@n2100.armlinux.org.uk>
 <d9966e58f98ed5820154d9a979ca19f2@dk-develop.de>
 <20170817130103.GR20805@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817130103.GR20805@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2017-08-17 15:01, Russell King - ARM Linux wrote:
> On Thu, Aug 17, 2017 at 12:51:33PM +0200, Danilo Krummrich wrote:
>> That having the correct execution order is not enough on some buses 
>> because
>> of buffering is really something to be aware of, thanks again for 
>> pointing
>> this out.
> 
> PCI guarantees the order of writes to a device, but there are 
> situations
> on SoCs where you can't rely on that - for instance, if the writes go
> over different buses to different devices (eg, write to a peripheral
> vs write to an interrupt controller.)
> 
> Even then, with interrupts delivered by message (eg, MSI) there's
> issues.
> 
>> So for the scenario I was concerned about I would expect the irqchip 
>> driver
>> guarantees the write actually hits the the hardware (if necessary read 
>> it
>> back) before the function (disable_irq_nosync()) returns, is that 
>> correct?
>> Though, having the need should be very unlikely.
> 
> Well, disable_irq_nosync() doesn't guarantee that the interrupt handler
> isn't running - a CPU may have just received the interrupt and is just
> entering the interrupt handler when disable_irq_nosync() returns.  The
> hint is the "nosync" - there's no synchronisation.  If you need to
> guarantee that the interrupt handler is not running, disable_irq() does
> that.  By implication, however, disable_irq() can not be called from
> within the same interrupt handler for the interrupt that is being
> disabled.
> 
Thanks again, I'm aware of that. As in my case the code could be called 
from
atomic context disable_irq() is not an option.

My main point is if it can be assumed that after disable_irq_nosync() 
returns
it is guaranteed, by convention, that the hardware was hit. But I really 
would
think so.
