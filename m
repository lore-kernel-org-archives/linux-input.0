From: Danilo Krummrich <danilokrummrich@dk-develop.de>
Subject: Re: [PATCH] serio: PS2 gpio bit banging driver for the serio bus
Date: Fri, 11 Aug 2017 13:05:20 +0200
Message-ID: <180873724a3d2ee187178f12c09dfb9f@dk-develop.de>
References: <20170731222452.22887-1-danilokrummrich@dk-develop.de>
 <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
 <20170807182207.348762301bf3d7f8509b1bf7@dk-develop.de>
 <8e5e73575b3a70e0e60931698687471d@dk-develop.de>
 <CACRpkda=bYacXmv8SoQu3wPoZW9v+j8myZnme=QpofD=Y-gYTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hs01.dk-develop.de ([213.136.71.231]:51049 "EHLO
        hs01.dk-develop.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751618AbdHKLFV (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Aug 2017 07:05:21 -0400
In-Reply-To: <CACRpkda=bYacXmv8SoQu3wPoZW9v+j8myZnme=QpofD=Y-gYTg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Linux Input <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org

On 2017-08-11 11:16, Linus Walleij wrote:
> On Thu, Aug 10, 2017 at 4:38 PM, Danilo Krummrich
> <danilokrummrich@dk-develop.de> wrote:
>> On 2017-08-07 18:22, Danilo Krummrich wrote:
>>>> 
>>>> > +static int ps2_gpio_write(struct serio *serio, unsigned char val)
>>>> > +{
>>>> > +       struct ps2_gpio_data *drvdata = serio->port_data;
>>>> > +
>>>> > +       drvdata->mode = PS2_MODE_TX;
>>>> > +       drvdata->tx_byte = val;
>>>> > +       /* Make sure ISR running on other CPU notice changes. */
>>>> > +       barrier();
>>>> 
>>>> This seems overengineered, is this really needed?
>>>> 
>>>> If we have races like this, the error is likely elsewhere, and 
>>>> should be
>>>> fixed in the GPIO driver MMIO access or so.
>>>> 
>>> Yes, seems it can be removed. I didn't saw any explicit barriers in 
>>> the
>>> GPIO
>>> driver (I'm testing on bcm2835), but it seems MMIO operations on SMP 
>>> archs
>>> does contain barriers. Not sure if all do. If some do not this 
>>> barrier
>>> might
>>> be needed to ensure ISR on other CPU notice the correct mode and byte 
>>> to
>>> send.
>>> 
>> I couldn't find any guarantee that the mode and tx_byte change is 
>> implicitly
>> covered by a barrier in this case. E.g. the bcm2835 driver does not 
>> make
>> sure stores are completed before the particular interrupt is enabled, 
>> except by
>> the fact that writel on ARM contains a wmb(). But this is nothing to 
>> rely on.
>> (Please tell me if I miss something.)
> 
> writel() should be guaranteeing that the values hit the hardware, wmb() 
> is
> spelled out "write memory barrier" I don't see what you're after here.
> 
Sorry for confusing wording. What I actually meant is if writel() is 
guaranteed
to make sure there's no reordering happening with other store 
operations. Of
course, in case of ARM it is sufficient as it contains a wmb. But I 
wasn't aware
that all writel() implementations guarantee this (if needed).
Thanks for clarification.

> If you think writel() doesn't do its job on some platform, then fix 
> writel()
> on that platform.
> 
> We can't randomly sprinkle things like this all over the kernel it 
> makes
> no sense.
> 
>> Therefore I would like to keep this barrier and replace it with 
>> smp_wmb() if
>> you are fine with that.
> 
> I do not think this is proper.
> 
As you explained writel() should guarantee no reordering with other 
store operations
(like drvdata->mode = PS2_MODE_TX in my case) is happening, I totally 
agree and will
fix this.

> Yours,
> Linus Walleij

Thanks,
Danilo
