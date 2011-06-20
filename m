From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local GPIO chips.
Date: Mon, 20 Jun 2011 12:49:09 -0600
Message-ID: <BANLkTimXMg7Di=6sWnGS-+8o5UmtQ-O08A@mail.gmail.com>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-4-git-send-email-david@protonic.nl> <20110616192732.GJ3795@ponder.secretlab.ca>
 <20110618101706.GB2401@core.coreip.homeip.net> <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
 <20110618145154.GA18190@core.coreip.homeip.net> <20110618151645.GG8195@ponder.secretlab.ca>
 <20110620094815.341d1cff@archvile> <20110620084511.GB23113@core.coreip.homeip.net>
 <20110620113301.556e8cd9@archvile>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:58858 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab1FTSta (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jun 2011 14:49:30 -0400
Received: by gxk21 with SMTP id 21so426122gxk.19
        for <linux-input@vger.kernel.org>; Mon, 20 Jun 2011 11:49:29 -0700 (PDT)
In-Reply-To: <20110620113301.556e8cd9@archvile>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Jander <david.jander@protonic.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Mon, Jun 20, 2011 at 3:33 AM, David Jander <david.jander@protonic.nl> wrote:
> On Mon, 20 Jun 2011 01:45:12 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
>> On Mon, Jun 20, 2011 at 09:48:15AM +0200, David Jander wrote:
>> > On Sat, 18 Jun 2011 09:16:45 -0600
>> > Grant Likely <grant.likely@secretlab.ca> wrote:
>> > > Unfortunately, handling it in board code doesn't really work either.
>> > > It just shuffles the complexity to the board code to implement some
>> > > kind of deferred mechanism for registering devices, and it has to take
>> > > into account that it may be a long time before the device actually
>> > > appears, such as when the driver is configured as a module.
>> >
>> > Besides... we don't want anymore board-code, do we? I mean, if a board can
>> > use a generic board configuration and specify all it needs in the
>> > device-tree, why should something as trivial as connecting a gpio_keys
>> > device to a I2C GPIO expander force us to do special board setup all of a
>> > sudden? IMHO specifying I2C-gpios to be used for gpio_keys should "just
>> > work", even if declared in a device-tree.

No, of course we don't.  It's a big problem.  The "just work" test
oversimplifies what is going on here.  Yes, you need gpio-keys
working, and yes changing the initcall solves the problem for you, and
it may very well be expedient to apply the change for the short term,
but no it doesn't solve the underlying problem.  While it makes it
"just work" for you, there is the potential that it will make it "just
not work" for somebody else.

>>
>> This is a laudable goal, but then device-tree needs to be able to
>> express device dependencies better. Until then board-specific code is
>> needed to register devices in proper order.
>
> Hmmm, I am not an expert in OF/DT stuff, but I think that while it would
> theoretically be possible to add extra properties to the tree, that are
> handled by the of_platform code, I am not sure if that is an option, since
> that would be pretty much linux-specific, and could never work on another OS.
> Grant?

We /could/, but I don't think that it is a good idea.  Dependencies
between devices are already expressed by the device tree in the
domain-specific properties.  A gpio property expresses which gpio
controller it depends on.  Similarly an interrupt-parent property
expresses which interrupt controller it depends on.  Similarly with
phy-device for PHYs, and other bindings for i2s links, clock
connections, etc.  What is not defined, is any kind of global
"depends-on" node that states dependencies on other nodes.  I don't
think that having a depends-on property that duplicates already
present information is a good idea; particularly when having
inaccurate data in the property is very likely to go unnoticed because
it may not break anything.

My opinion is that making decisions about dependencies, and telling
the core kernel about those dependencies, really should be in the
domain of the driver.  The driver has all the information about what a
device needs to operate correctly, and it is the only place that will
be able to describe constraints on other devices to the runtime PM
infrastructure.  Plus, most dependencies aren't necessarily on
devices, but rather on the interfaces that a device driver advertises.
 For instance, a single device may present multiple interfaces (say,
gpio controller with irq function), but depending on the
configuration, the driver may not register one or the other.  It's not
the actual device that a driver like gpio-keys depends on, but rather
whether or not the driver registers the gpio interface when it
initialized the device.

Again, this is a core infrastructure deficiency.  The problem is just
as much present when not using the DT, but it does present
differently.

>> How about we do not register device until all resources are ready? This
>> is pretty simple concept - do not create an object until it is usable. Then
>> nobody needs to bother with -EAGAIN or -ENOTYET or any other similar
>> garbage.
>
> I agree, but DT doesn't permit that (yet).

I don't.  The systems we're working with are sufficiently complex now
that I don't think that solution works in the long term.  Take a look
at the work the ALSA folks needed to do to get the audio complex wired
up.  Three or more devices get registered, a DAI driver, a codec
driver, and a sound device driver, all of which can get registered in
any order.  The sound driver waits for the other devices to show up,
and then does the work to attach them all together.  I think this is a
very credible approach, and I intend to dig into generalizing it.

-EAGAIN might not be the right mechanism, but I do think it is
entirely appropriate for drivers to be able to defer initialization
when waiting for asynchronous events.

> What do you think, Grant? Would it be possible/acceptable to add some special
> property to devices that could make them be added in a second round by
> of_platform code (until there are _real_ dependencies)?

As discussed above, I don't think this is a good idea.

> Or could the of_platform code be smart and just notice that gpio_keys needs
> "gpios" (or other resources for that matter) that are depending on another
> node in the tree, and make sure it gets probed before adding this one?

I'm not going to say no; but I'd like to see a prototype what it would
look like before I say yes.  If it can be done relatively cleanly,
then I'll be okay with it.  I suspect that it will end up being crazy
complex to use global code for tracking dependencies in this manor.

g.
