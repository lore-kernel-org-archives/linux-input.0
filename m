From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
 GPIO chips.
Date: Sat, 18 Jun 2011 07:51:54 -0700
Message-ID: <20110618145154.GA18190@core.coreip.homeip.net>
References: <1308042491-20203-1-git-send-email-david@protonic.nl>
 <1308042491-20203-4-git-send-email-david@protonic.nl>
 <20110616192732.GJ3795@ponder.secretlab.ca>
 <20110618101706.GB2401@core.coreip.homeip.net>
 <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f51.google.com ([209.85.210.51]:53510 "EHLO
	mail-pz0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753416Ab1FROwD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 18 Jun 2011 10:52:03 -0400
Received: by pzk26 with SMTP id 26so2638219pzk.10
        for <linux-input@vger.kernel.org>; Sat, 18 Jun 2011 07:52:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Sat, Jun 18, 2011 at 07:18:28AM -0600, Grant Likely wrote:
> On Sat, Jun 18, 2011 at 4:17 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Thu, Jun 16, 2011 at 01:27:32PM -0600, Grant Likely wrote:
> >> On Tue, Jun 14, 2011 at 11:08:11AM +0200, David Jander wrote:
> >> > Use a threaded interrupt handler in order to permit the handler to use
> >> > a GPIO driver that causes things like I2C transactions being done inside
> >> > the handler context.
> >> > Also, gpio_keys_init needs to be declared as a late_initcall, to make sure
> >> > all needed GPIO drivers have been loaded if the drivers are built into the
> >> > kernel.
> >>
> >> ...which is a horrid hack, but until device dependencies can be
> >> described, it isn't one that can be solved easily.
> >>
> >
> > I really do not want to apply this... Currently the order of
> > initialization does not matter since nothing actually happens until
> > corresponding device appears on the bus. Does the OF code creates
> > devices before all resources are ready?
> 
> It's not an OF problem.  The problem is that all the platform_devices
> typically get registered all at once at machine_init time (on arm),
> and if the gpio expander isn't a platform_device, (like an i2c gpio
> expander which would end up being a child of a platform_device), then
> it won't be ready.

Ah, I see. But that can be handled in board code that should ensure that
it registers devices in correct order.

>  The real problem is that we have no mechanism for
> holding off or deferring a driver probe if it depends on an
> asynchronous resource.

The mechanism we do have - we should not be creating the device for the
driver to bind to unless all resources that are needed by that device
are ready.

Just shuffling the initcall order is not maintanable. Next there will be
GPIO expander that is for some reason registered as late_initcall and
we'll be back to square one. I am going to take the threaded IRQ bit but
will drop the initcall bit from the patch.

Thanks.

-- 
Dmitry
