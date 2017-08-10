From: Danilo Krummrich <danilokrummrich-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Subject: Re: [PATCH] serio: PS2 gpio bit banging driver for the serio bus
Date: Thu, 10 Aug 2017 16:38:10 +0200
Message-ID: <8e5e73575b3a70e0e60931698687471d@dk-develop.de>
References: <20170731222452.22887-1-danilokrummrich@dk-develop.de>
 <CACRpkdYz_+soss4Rb9zMiP4eZZtXqjW_Xy7hH=wm1x2m_R9R3A@mail.gmail.com>
 <20170807182207.348762301bf3d7f8509b1bf7@dk-develop.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170807182207.348762301bf3d7f8509b1bf7-q2z19idT6fYRctDU1SCqIg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Input <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

On 2017-08-07 18:22, Danilo Krummrich wrote:
>> > +static int ps2_gpio_write(struct serio *serio, unsigned char val)
>> > +{
>> > +       struct ps2_gpio_data *drvdata = serio->port_data;
>> > +
>> > +       drvdata->mode = PS2_MODE_TX;
>> > +       drvdata->tx_byte = val;
>> > +       /* Make sure ISR running on other CPU notice changes. */
>> > +       barrier();
>> 
>> This seems overengineered, is this really needed?
>> 
>> If we have races like this, the error is likely elsewhere, and should 
>> be
>> fixed in the GPIO driver MMIO access or so.
>> 
> Yes, seems it can be removed. I didn't saw any explicit barriers in the 
> GPIO
> driver (I'm testing on bcm2835), but it seems MMIO operations on SMP 
> archs
> does contain barriers. Not sure if all do. If some do not this barrier 
> might
> be needed to ensure ISR on other CPU notice the correct mode and byte 
> to send.
> 
I couldn't find any guarantee that the mode and tx_byte change is 
implicitly
covered by a barrier in this case. E.g. the bcm2835 driver does not make 
sure
stores are completed before the particular interrupt is enabled, except 
by the
fact that writel on ARM contains a wmb(). But this is nothing to rely 
on. (Please
tell me if I miss something.)
Therefore I would like to keep this barrier and replace it with 
smp_wmb() if you
are fine with that.

Regards,
Danilo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
