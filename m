From: "Henrik Rydberg" <rydberg@euromail.se>
Subject: Re: [PATCH] input: evdev: Add a read() callback
Date: Tue, 22 Feb 2011 10:14:33 +0100
Message-ID: <20110222091433.GA2183@polaris.bitmath.org>
References: <1298297930-3937-1-git-send-email-bgat@billgatliff.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:39502 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752282Ab1BVJNS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 04:13:18 -0500
Content-Disposition: inline
In-Reply-To: <1298297930-3937-1-git-send-email-bgat@billgatliff.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

Hi Bill,

Some additional comments inline.

On Mon, Feb 21, 2011 at 08:18:50AM -0600, Bill Gatliff wrote:
> Some devices, like accelerometers, can manufacture as many input
> events as userspace can consume.  The traditional method for limiting
> the number of input events sent to userspace by such devices is to use
> a kernel thread looping around an idle timer, to "throttle" the
> creation and queuing of input events to a manageable rate.  Such
> drivers often also provide a sysfs attribute (or similar means) that
> allows userspace to indicate a desired event rate.
>
> Some operating systems and/or applications e.g. Android, might prefer
> to control input event creation rates themselves.  They frequently
> attempt to do so by implementing a userspace polling thread that loops
> around an idle timer; this idle timer throttles the rate of calls to
> the input devices' read() method, which (at least in theory) limits
> the rate of input events arriving at the application to a desired
> level.

In addition, we do have open/close and EV_ABS fuzz ioctl as two
existing, user-controllable throttling techniques. Additional filter
possibilities might do the trick?

> The enclosed patch address all of the above problems by implementing
> an advisory callback from the evdev read() and poll() methods to the
> associated input device driver.  The driver may then choose to
> populate the input event buffer at that time, rather than on a
> schedule implemented by a polling loop, sysfs trigger, or other means.

As already stated, this does not play very well with the event model.

> Use of this callback by a driver naturally synchronizes the generation
> of input events to requests from userspace, because the driver now
> "knows" when userspace is attempting to retrieve an input event and
> can therefore produce one just-in-time.  It also allows the driver to
> easily match the rate of input event generation, by simply sampling the
> hardware only during this callback.

The same effect could be achieved if the driver could simply ask the
input core if the read buffers are being emptied or not.

> If an input device driver chooses to use only the read() callback as
> its signal to produce an input event, then the driver need not
> implement a polling kernel thread or other means of pacing its event
> generation rate.

There is a generic polled input device for that.

> The driver also has no need to provide a sysfs
> attribute to allow userspace to request a polling rate or to trigger a
> measurement: userspace must only read() or poll() the interface at the
> desired rate.  This can greatly simplify input device driver
> implementation, while conveniently leaving the incoming event rate and
> synchronization issues completely up to the application. (See POSIX.1b
> interval timers and scheduler options for APIs allowing precise timing
> within user applications).

Right, rate adaption should be transparent and automatic.

> Finally, input device drivers might choose to implement a holdoff
> timer that gets reset in the read() callback; expiration of this timer
> would mean that userspace is no longer actively reading from the
> device, even though the interface itself might still be open.  In such
> cases the driver might wish to invoke a power-management method to
> idle the hardware until the next  callback occurs.

Or userspace could actually close the device to accomplish the desired
effect with existing infrastructure.

> Polled devices like accelerometers and compasses (and perhaps some
> types of pushbuttons or switch inputs) will get the most benefit from
> utilizing the read() callback.  Other devices, like USB keyboards and
> mice, will have no use for it and may safely ignore it.

Thanks,
Henrik
