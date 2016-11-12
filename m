From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers: tca8418: Change the interrupt type
Date: Fri, 11 Nov 2016 17:24:17 -0800
Message-ID: <20161112012417.GB37875@dtor-ws>
References: <20161107144024.15291-1-maxime.ripard@free-electrons.com>
 <20161109000400.GA8719@dtor-ws>
 <20161109080235.v23y42bojnwcw6rk@lukather>
 <20161110040208.GA9498@dtor-ws>
 <20161110091302.cjn4srrpxtg2mknv@lukather>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36394 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934430AbcKLBYU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 11 Nov 2016 20:24:20 -0500
Content-Disposition: inline
In-Reply-To: <20161110091302.cjn4srrpxtg2mknv@lukather>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Nov 10, 2016 at 10:13:02AM +0100, Maxime Ripard wrote:
> On Wed, Nov 09, 2016 at 08:02:08PM -0800, Dmitry Torokhov wrote:
> > On Wed, Nov 09, 2016 at 09:02:35AM +0100, Maxime Ripard wrote:
> > > Hello Dmitry,
> > > 
> > > On Tue, Nov 08, 2016 at 04:04:00PM -0800, Dmitry Torokhov wrote:
> > > > On Mon, Nov 07, 2016 at 03:40:24PM +0100, Maxime Ripard wrote:
> > > > > The TCA8418 interrupt has a level trigger, not a edge one.
> > > > > 
> > > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > 
> > > > Hmm, maybe we could rely on OF data for trigger type?
> > > 
> > > We might, even though the i2c core doesn't change the trigger type
> > > when it retrieves the interrupt from the DT.
> > 
> > i2c core itself does not, and should not, but irq code does:
> > 
> > of_irq_get() -> irq_create_of_mapping() -> irq_create_fwspec_mapping()
> > -> irqd_set_trigger_type().
> 
> Ah, indeed, I overlooked that. I wonder why platform_get_irq does it
> then.
> 
> > 
> > > 
> > > However, I'm a bit worried about the other probing mechanims (ACPI,
> > > board files) that should be supported as well, and removing the
> > > trigger type from the flags might break those. There's no board files
> > > using it though in the tree, but I don't know about ACPI systems.
> > 
> > The driver is not enabled for ACPI systems, at least not in mainline.
> 
> Ok. Good.
> 
> > By the way, this is what TCA8418 binding dochas to say:
> > 
> > "- interrupts: IRQ line number, should trigger on falling edge"
> > 
> > so it seems there was at least one system that needed falling edge and
> > not level interrupt.
> 
> I don't know, looking at the datasheet, it really looks like it's
> level triggered to me, and we were actually seeing issues when set in
> edge.
> 
> http://www.ti.com/lit/ds/symlink/tca8418.pdf
> Especially page 20 and 33.
> 
> My understanding is that in input, the chip will trigger on edges, but
> the line coming from that device to the SoC will be level triggered.

The issue is that it is not necessarily connected directly to the
SoC/AP. It could be on a daughterboard with any number of converters,
possibly inverting polarity, or doing level->edge, etc. So the only sane
solution is to leave it to device tree to describe the setup to the
driver.

Thanks.

-- 
Dmitry
