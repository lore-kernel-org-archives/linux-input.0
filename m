From: "Henrik Rydberg" <rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org>
Subject: Re: USB interrupt times
Date: Tue, 14 Aug 2012 20:30:54 +0200
Message-ID: <20120814183054.GA2890@polaris.bitmath.org>
References: <20120814103936.GA7105@flint.arm.linux.org.uk>
 <alpine.LNX.2.00.1208141250020.12490@pobox.suse.cz>
 <20120814121804.GC7105@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120814121804.GC7105-f404yB8NqCZvn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King <rmk-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Russell,

> On Tue, Aug 14, 2012 at 12:54:00PM +0200, Jiri Kosina wrote:
> > Actually, Henrik (added to CC) has been doing some latency improvements 
> > both for input core in general, and for HID devices as well lately. I 
> > still have his patchset in my to-review queue, as I have just came back 
> > from offline vacation, but the patch below definitely can't hurt and 
> > should significantly lower the time spent in handling the irq for hid 
> > device in common situation (i.e. noone listening for debugfs events).
> > 
> > Could you please measure how much it helps on your system?
> 
> Ok, it looks like it's changed the maximum USB interrupt execution
> time from around 364us to 255us.

With the on-review input patches on top of that, the latency should
drop further. I have measured a total of 2.5 times lower latency in
other areas, so I would expect something like 150 us in 3.7 for your
case.

> If I also do a similar trick with the debug code in hid_input_report()
> then I get down to 212us - iow, something like the patch below.

Linus' master already has a patch for that code path, actually.

> Given that debugfs is fairly ubiquitous in the kernel, and that this is
> fairly invasive in terms of interrupt execution impact, wouldn't having
> this debug code enabled by a separate Kconfig symbol be reasonable too?

I would like that, too.

Thanks,
Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
