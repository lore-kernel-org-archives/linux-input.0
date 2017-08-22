From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] serio: PS2 gpio bit banging driver for the serio bus
Date: Tue, 22 Aug 2017 15:35:50 +0200
Message-ID: <CACRpkdZ39AOYdN_KNLJXTkimW1WaHpYvrw89J_kJo_FJThWwuw@mail.gmail.com>
References: <20170731222452.22887-1-danilokrummrich@dk-develop.de>
 <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
 <20170807182207.348762301bf3d7f8509b1bf7@dk-develop.de> <8e5e73575b3a70e0e60931698687471d@dk-develop.de>
 <CACRpkda=bYacXmv8SoQu3wPoZW9v+j8myZnme=QpofD=Y-gYTg@mail.gmail.com> <20170817090908.GP20805@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170817090908.GP20805@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Danilo Krummrich <danilokrummrich@dk-develop.de>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Aug 17, 2017 at 11:09 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Fri, Aug 11, 2017 at 11:16:20AM +0200, Linus Walleij wrote:
>> writel() should be guaranteeing that the values hit the hardware, wmb() is
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

Thanks Russell. I tend to forget things over time even though I have
some memory of this being spelled out to me in the past :(

Yours,
Linus Walleij
