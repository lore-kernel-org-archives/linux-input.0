From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: Re: [PATCH v2 1/2] Input: gpio-keys - allow platform to specify
	exact irq flags
Date: Fri, 27 Nov 2009 12:54:08 +0200
Message-ID: <20091127105408.GV17675@esdhcp04058.research.nokia.com>
References: <cover.1258976669.git.ext-mika.1.westerberg@nokia.com> <8237c9a4afd1fa883120b5793fcd91a970d2ffb7.1258976669.git.ext-mika.1.westerberg@nokia.com> <87y6lxchwf.fsf@tac.ki.iif.hu> <20091123172451.GD17813@core.coreip.homeip.net> <87tywlcbyr.fsf@tac.ki.iif.hu> <20091124063711.GL17675@esdhcp04058.research.nokia.com> <87my2cp4h6.fsf@tac.ki.iif.hu> <20091124170249.GQ17675@esdhcp04058.research.nokia.com> <87k4xfojhb.fsf@tac.ki.iif.hu> <20091126063506.GM23244@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:57642 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750871AbZK0K6v (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Nov 2009 05:58:51 -0500
Content-Disposition: inline
In-Reply-To: <20091126063506.GM23244@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Ferenc Wagner <wferi@niif.hu>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Thu, Nov 26, 2009 at 07:35:07AM +0100, ext Dmitry Torokhov wrote:
> On Tue, Nov 24, 2009 at 07:39:28PM +0100, Ferenc Wagner wrote:
> > Mika Westerberg <ext-mika.1.westerberg@nokia.com> writes:
> > 
> > >
> > > So I'll try to implement this gpio-keys muting so that it allows
> > > also multiple buttons to share single IRQ line.
> > 
> > Thanks.  But you'd better wait for Dmitry's response, because I'm by no
> > means authoritative in this business.
> 
> I would not refuse a reasonable patch as long as there is a use case for
> it. The only think is that I would prefer to keep compatibility with the
> current format of the platform data, otherwise we will screw up embedded
> guys that are currently using the driver. But if compatibility results
> in too ugly code then I reserve the right to invoke "out of tree drivers
> - don't care" card ;)

How about if we just add one field to struct gpio_keys_button?
	...
	bool can_disable;

Then gpio_keys uses this field when it decides what irqflags it
is going to pass to request_irq() (we don't allow platform data
to pass exact flags). So in case of can_disable is set, we don't
pass IRQF_SHARED to request_irq().

When support for sharing single IRQ between multiple buttons arrives
this field is still valid and we just need to take care of disable IRQ
line only when all buttons that share it, are disabled.

This won't break existing users of gpio_keys and allows future
extension to support case of multiple buttons sharing single
IRQ line, right?

Thanks,
MW
