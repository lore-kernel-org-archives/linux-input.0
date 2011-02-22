From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] input: evdev: Add a read() callback
Date: Tue, 22 Feb 2011 00:23:16 +0000
Message-ID: <20110222002315.GA18299@sirena.org.uk>
References: <1298297930-3937-1-git-send-email-bgat@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:56718 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751757Ab1BVAXR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Feb 2011 19:23:17 -0500
Content-Disposition: inline
In-Reply-To: <1298297930-3937-1-git-send-email-bgat@billgatliff.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org, linux-embedded@vger.kernel.org

On Mon, Feb 21, 2011 at 08:18:50AM -0600, Bill Gatliff wrote:

> But implementing a rate-specifying sysfs attribute isn't enough,
> however.  Under the Linux kernel's current input device buffering
> scheme, drivers and applications can create and consume input events
> every 100ms, for example, but there is always the possibility that an
> input event will sit in the queue for 99ms waiting for an application
> to retrieve it.  For devices and applications where this potential
> delay causes problems, drivers must implement an external means for
> applications to trigger the timely production of an input event.

I don't see how any of the above shows an issue with rate limiting in
the application image.  As was discussed in some detail the last time
you posted this the issue that's causing the applications to experience
delayed notifications of events is that rather than blocking waiting for
an event to be delivered to them they're sleeping unconditionally.  If
the application were to use a rate control in conjunction with blocking
(which is the expected programming model) then a rate control will do
exactly what's expected.

> The enclosed patch address all of the above problems by implementing
> an advisory callback from the evdev read() and poll() methods to the
> associated input device driver.  The driver may then choose to
> populate the input event buffer at that time, rather than on a
> schedule implemented by a polling loop, sysfs trigger, or other means.

> Use of this callback by a driver naturally synchronizes the generation
> of input events to requests from userspace, because the driver now
> "knows" when userspace is attempting to retrieve an input event and
> can therefore produce one just-in-time.  It also allows the driver to
> easily match the rate of input event generation, by simply sampling the
> hardware only during this callback.

This doesn't address the issue raised in the previous discussion with
the poor interaction with applications that do behave sensibly and block
for events from the device - either we can't use the ability to trigger
readings from the hardware or we end up doing extra readings because
every read triggers an additional sample.

> If an input device driver chooses to use only the read() callback as
> its signal to produce an input event, then the driver need not
> implement a polling kernel thread or other means of pacing its event
> generation rate.  The driver also has no need to provide a sysfs
> attribute to allow userspace to request a polling rate or to trigger a
> measurement: userspace must only read() or poll() the interface at the
> desired rate.  This can greatly simplify input device driver
> implementation, while conveniently leaving the incoming event rate and

This is all stuff that can be put into a library (parts of it are
already) so there's no real cost to drivers from implementing anything.

> Finally, input device drivers might choose to implement a holdoff
> timer that gets reset in the read() callback; expiration of this timer
> would mean that userspace is no longer actively reading from the
> device, even though the interface itself might still be open.  In such
> cases the driver might wish to invoke a power-management method to
> idle the hardware until the next  callback occurs.

This will again interact poorly with event driven applications - if
notifications to userspace don't happen (eg, because there has been no
change) then there will be no cause for the application to read.

I can see a use for a read on demand callback in the implementation of
polling (eg, if rate is set to zero or for the core polling library to
use) but the userspace API thats being proposed here seems like it's
going to cause problems for applications that try to do the right thing.
