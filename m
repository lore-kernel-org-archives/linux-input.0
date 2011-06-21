From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v4 3/3] Input: gpio_keys.c: Enable use with non-local
	GPIO chips.
Date: Tue, 21 Jun 2011 12:46:32 +0100
Message-ID: <20110621114631.GC25032@sirena.org.uk>
References: <1308042491-20203-1-git-send-email-david@protonic.nl> <1308042491-20203-4-git-send-email-david@protonic.nl> <20110616192732.GJ3795@ponder.secretlab.ca> <20110618101706.GB2401@core.coreip.homeip.net> <BANLkTiky39X3g3g9oy7fAdFhPn4hHOij9w@mail.gmail.com> <20110618145154.GA18190@core.coreip.homeip.net> <20110618151645.GG8195@ponder.secretlab.ca> <20110620094815.341d1cff@archvile> <20110620084511.GB23113@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:59944 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237Ab1FULqf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2011 07:46:35 -0400
Content-Disposition: inline
In-Reply-To: <20110620084511.GB23113@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Jander <david.jander@protonic.nl>, Grant Likely <grant.likely@secretlab.ca>, David Jander <david@protonic.nl>, linux-input@vger.kernel.org

On Mon, Jun 20, 2011 at 01:45:12AM -0700, Dmitry Torokhov wrote:

> This is a laudable goal, but then device-tree needs to be able to
> express device dependencies better. Until then board-specific code is
> needed to register devices in proper order.

Like Grant says this really isn't terribly sustainable - it's not just
the device registration you need to sort out, it's also the registration
of the drivers so things actually get bound and handing of any delays in
the process of getting things to appear.  It's not trivial to get this
right in the general case and it's not reasonable to expect individual
boards to open code things, we really do need core code to figure things
out in some fashion (ideally data rather than retry driven).

> > Sounds interesting. So the probe function could return some sort of -ENOTYET
> > or -EAGAIN and have it called again later?

> How about we do not register device until all resources are ready? This
> is pretty simple concept - do not create an object until it is usable. Then
> nobody needs to bother with -EAGAIN or -ENOTYET or any other similar
> garbage.

As soon as you let the user build drivers modular this goes out of the
window.  All the faff with initcall ordering that we do at the minute is
essentially trying to implement this mechanism.
