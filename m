From: David Jander <david.jander@protonic.nl>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Mon, 20 Jun 2011 09:48:15 +0200
Message-ID: <20110620094815.341d1cff@archvile>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
	<1308042491-20203-4-git-send-email-david@protonic.nl>
	<20110616192732.GJ3795@ponder.secretlab.ca>
	<20110618101706.GB2401@core.coreip.homeip.net>
	<BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
	<20110618145154.GA18190@core.coreip.homeip.net>
	<20110618151645.GG8195@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:13922 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab1FTHsM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2011 03:48:12 -0400
In-Reply-To: <20110618151645.GG8195@ponder.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Sat, 18 Jun 2011 09:16:45 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Sat, Jun 18, 2011 at 07:51:54AM -0700, Dmitry Torokhov wrote:
> > On Sat, Jun 18, 2011 at 07:18:28AM -0600, Grant Likely wrote:
> > > On Sat, Jun 18, 2011 at 4:17 AM, Dmitry Torokhov
> > > <dmitry.torokhov@gmail.com> wrote:
> > > > On Thu, Jun 16, 2011 at 01:27:32PM -0600, Grant Likely wrote:
> > > >> On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
> > > >> > Use a threaded interrupt handler in order to permit the handler to
> > > >> > use a GPIO driver that causes things like I2C transactions being
> > > >> > done inside the handler context.
> > > >> > Also, gpio_keys_init needs to be declared as a late_initcall, to
> > > >> > make sure all needed GPIO drivers have been loaded if the drivers
> > > >> > are built into the kernel.
> > > >>
> > > >> ...which is a horrid hack, but until device dependencies can be
> > > >> described, it isn't one that can be solved easily.
> > > >>
> > > >
> > > > I really do not want to apply this... Currently the order of
> > > > initialization does not matter since nothing actually happens until
> > > > corresponding device appears on the bus. Does the OF code creates
> > > > devices before all resources are ready?
> > > 
> > > It's not an OF problem.  The problem is that all the platform_devices
> > > typically get registered all at once at machine_init time (on arm),
> > > and if the gpio expander isn't a platform_device, (like an i2c gpio
> > > expander which would end up being a child of a platform_device), then
> > > it won't be ready.
> > 
> > Ah, I see. But that can be handled in board code that should ensure that
> > it registers devices in correct order.
> 
> Unfortunately, handling it in board code doesn't really work either.
> It just shuffles the complexity to the board code to implement some
> kind of deferred mechanism for registering devices, and it has to take
> into account that it may be a long time before the device actually
> appears, such as when the driver is configured as a module.

Besides... we don't want anymore board-code, do we? I mean, if a board can use
a generic board configuration and specify all it needs in the device-tree, why
should something as trivial as connecting a gpio_keys device to a I2C GPIO
expander force us to do special board setup all of a sudden?
IMHO specifying I2C-gpios to be used for gpio_keys should "just work", even if
declared in a device-tree.

> I completely agree that shuffling initcall order isn't maintainable
> though.

I also agree, and if there is a better solution to make this work without
additional board-support code, please tell me.
I just think that this patch makes the already cool gpio_keys driver quite a
bit more awesome. IMO, being able to just hook it all up in the device-tree is
just fantastic, and we should make it possible.

> A related concern is that changing the device registration order, or
> the initcall order, does absolutely nothing to tell runtime PM about
> the dependencies between devices.  For instance, how does runtime PM
> know when it is safe to PM a gpio controller, when it has no reference
> to devices depending on it, like gpio-keys?  (although gpio-keys isn't
> a great example because it doesn't really have any runtime PM states).
> 
> I think part of the solution is to give drivers the option of
> returning a 'defer' code at probe time if it cannot obtain all it's
> resources, and have the driver core re-probe it when more devices
> become available, but I haven't had time to prototype it yet.

Sounds interesting. So the probe function could return some sort of -ENOTYET
or -EAGAIN and have it called again later?

But, does that mean that we really need to miss this use-case until something
like this gets approved and merged? Can't we just declare this late_initcall
for now and fix it later? Please!

> > >  The real problem is that we have no mechanism for
> > > holding off or deferring a driver probe if it depends on an
> > > asynchronous resource.
> > 
> > The mechanism we do have - we should not be creating the device for the
> > driver to bind to unless all resources that are needed by that device
> > are ready.

How would we do that in a device-tree?

> > Just shuffling the initcall order is not maintanable. Next there will be
> > GPIO expander that is for some reason registered as late_initcall and
> > we'll be back to square one. I am going to take the threaded IRQ bit but
> > will drop the initcall bit from the patch.

That would destroy the whole purpose of this patch. Do you mean to say, what I
want to do has no acceptable implementation? That would be a pity, since IMHO
it is a very cool feature, and quite trivial to implement this way.
Our boards do not need any board setup code. Actually just adding one
line of code in arch/powerpc/platforms/512x/mpc5121_generic.c or
arch/powerpc/platforms/52xx/mpc5200_simple.c is enough to support any of our
boards that need this driver... the rest is done in the device-tree. Don't you
think this is worth that little bit of (temporary) ugliness?

Best regards,

-- 
David Jander
Protonic Holland.
