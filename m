From: Mika Westerberg <mika.westerberg@iki.fi>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to specify
	exact irq flags
Date: Sat, 28 Nov 2009 15:27:42 +0200
Message-ID: <20091128132742.GC27249@gw.healthdatacare.com>
References: <87y6lxchwf.fsf@tac.ki.iif.hu> <20091123172451.GD17813@core.coreip.homeip.net> <87tywlcbyr.fsf@tac.ki.iif.hu> <20091124063711.GL17675@esdhcp04058.research.nokia.com> <87my2cp4h6.fsf@tac.ki.iif.hu> <20091124170249.GQ17675@esdhcp04058.research.nokia.com> <87k4xfojhb.fsf@tac.ki.iif.hu> <20091126063506.GM23244@core.coreip.homeip.net> <20091127105408.GV17675@esdhcp04058.research.nokia.com> <87tywe4zf3.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33320 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751283AbZK1N1k (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Nov 2009 08:27:40 -0500
Received: by bwz27 with SMTP id 27so1629735bwz.21
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2009 05:27:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87tywe4zf3.fsf@tac.ki.iif.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sat, Nov 28, 2009 at 01:16:48PM +0100, Ferenc Wagner wrote:
> Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
> 
> > On Thu, Nov 26, 2009 at 07:35:07AM +0100, ext Dmitry Torokhov wrote:
> >> On Tue, Nov 24, 2009 at 07:39:28PM +0100, Ferenc Wagner wrote:
> >>> Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
> >>> 
> >>>> So I'll try to implement this gpio-keys muting so that it allows
> >>>> also multiple buttons to share single IRQ line.
> >>> 
> >>> Thanks.  But you'd better wait for Dmitry's response, because I'm by no
> >>> means authoritative in this business.
> >> 
> >> I would not refuse a reasonable patch as long as there is a use case for
> >> it. The only think is that I would prefer to keep compatibility with the
> >> current format of the platform data, otherwise we will screw up embedded
> >> guys that are currently using the driver. But if compatibility results
> >> in too ugly code then I reserve the right to invoke "out of tree drivers
> >> - don't care" card ;)
> >
> > How about if we just add one field to struct gpio_keys_button?
> > 	...
> > 	bool can_disable;
> >
> > Then gpio_keys uses this field when it decides what irqflags it
> > is going to pass to request_irq() (we don't allow platform data
> > to pass exact flags). So in case of can_disable is set, we don't
> > pass IRQF_SHARED to request_irq().
> >
> > When support for sharing single IRQ between multiple buttons arrives
> > this field is still valid and we just need to take care of disable IRQ
> > line only when all buttons that share it, are disabled.
> >
> > This won't break existing users of gpio_keys and allows future
> > extension to support case of multiple buttons sharing single
> > IRQ line, right?
> 
> Please don't shoot me, but I've got a different idea: what if we leave
> this whole business to the generic kernel interrupt handling routines?
> It would be as easy as requesting the IRQ on device open (I guess the
> input layer can relay the open event down here) and freeing it on close.
> The IRQ could stat shared all the time, and the kernel would
> automatically disable it when all handlers are unregistered.  All this
> means no need to extend the platform data, no need for a separate sysfs
> interface, and still the application would have complete control of its
> wakeup sources by opening/closing them as needed.  What do you think?

Yeah, that would be nice. But it won't work for us :(

This is because the actual input device might be open for several
applications. Then we have single process which controls state of
the device. Now if, for example the device is locked by user, this
process just disables those buttons which are not allowed to wake
up the device and blanks the screen.

So the input device is still open but we just prevent GPIO lines
from generating any interrupts while the device is locked. There
are other use-cases also where different buttons are
disabled/enabled.

Thanks,
MW
