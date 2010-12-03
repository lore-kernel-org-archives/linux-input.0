From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Synchronizing evdev readers and drivers?
Date: Fri, 3 Dec 2010 18:52:50 +0000
Message-ID: <20101203185250.GA730@opensource.wolfsonmicro.com>
References: <AANLkTik8X-Xe9fvYUtRObRBP1PyedOu+zwb1SKKf+kgy@mail.gmail.com>
 <20101202212223.GA9864@core.coreip.homeip.net>
 <AANLkTi=vc0b5Zcy=TuVq3=6yZ8eHCEwLQ0hkkk-x-AyZ@mail.gmail.com>
 <20101203124240.GH3182@sirena.org.uk>
 <AANLkTimFoyFksd1orc9Bf8y5y7xQf14i_hhDoRyR3vnE@mail.gmail.com>
 <20101203135346.GI3182@sirena.org.uk>
 <AANLkTimKyU9dhxE5pkwTZ_0m7C1z+KjB-FMqLkA_UsNf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:43620 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752230Ab0LCSwk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Dec 2010 13:52:40 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimKyU9dhxE5pkwTZ_0m7C1z+KjB-FMqLkA_UsNf@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bill Gatliff <bgat@billgatliff.com>
Cc: linux-input@vger.kernel.org

On Fri, Dec 03, 2010 at 11:36:50AM -0600, Bill Gatliff wrote:

I guess my main thing here is that I don't see why we'd want to present
applications with an interface which means we can't make use of hardware
scheduling facilities where they exist.  The other thing is that this
feels like a workaround for applications that are already doing
application layer scheduling rather than anything else and that feels
more like a workaround for a lack of control provided by the kernel than
anything else.

> The poll() and blocking read() system calls allow an application to
> tell an input device that it is prepared to receive an event, and for
> an input device driver to tell userspace when an event has occurred.
> As implemented in evdev, however, neither system call provides a
> natural, consistent way for userspace to tell an input device driver
> how often it wants data--- or even if it wants any (at the moment) at
> all.

This is what I'm saying the sysfs interface polldev provides (or a
similar interface done via ioctl() or whatever) should do.

> I think that you and I talking about two different scenarios.  You
> seem to be focused on the one where userspace is informed when an
> input event occurs, but has no ability to request or schedule those

No, not at all.  What I'm saying is that userspace should be able to
express to the kernel that it wants events delivering at a given rate
and the kernel should then attempt to deliver events at that rate.

> events.  That model makes perfect sense for USB mice and keyboards
> where the hardware itself is inherently event-driven.  For those kinds
> of devices, users don't know or care when a key will be pressed---
> they just need to respond when one is.  So they simply block in a
> poll() or read() until a keypress shows up.  Problem solved.

This is also true for things like touchscreens which work by
continuously delivering samples (ideally only while there is a touch) at
intervals which currently can't be configured in the application layer -
they're also polling, and they may not even be doing so in hardware.

> I'm looking at input devices like accelerometers and compasses, which
> must be explicitly sampled and can send events at upwards of 4K/sec if
> you ask them to.  The vast majority of user applications don't need

Right, and what I'm saying is that userspace should just say what rate
it wants and then get that.

> data anywhere near that fast, but the range of desirable rates can't
> be met by a simple "just sample it at 100 Hz" kernel thread because of
> other modes want the data at 200 Hz with minimal latency.  The current

Resolving the rate needs of multiple simultaneous users sounds like a
tractable bit of programming which we'd only ever need to do once in the
input layer, surely?

> architecture requires me to implement that range using a dedicated
> kernel thread, plus a sysfs attribute/ioctl to dial the rate up or
> down from userspace.

No need for the kernel thread - timers should do the trick - but other
than that I see no problem with this at all, other than the fact that we
probably want to implement a standard API for setting the rate which can
be used across devices.  Worst case a fully software implementation is
pretty much equivalent to what you want to do but is very simple to use
in the application layer.  Best case the hardware is able to clock out
the samples by itself and we get to skip the bit where software
initiates the transfer which saves us work and is especially nice at
higher data rates.

For a devices like touchscreens driving the reads from the application
would typically be a 50-100% overhead on the I/O costs and involves
blocking the application while the conversion happens, neither of which
seems desirable.

> I don't want to do an ad-hoc method for communicating a polling rate
> request to the hardware for each hardware driver that I have to deal
> with.  One way to avoid this is to add a standard sysfs attribute or

I wasn't suggesting that at all.  Like you say, define a standard one
and/or use the interface we already have in polldev which looks general
enough for a lot of cases though it's pretty much root only.

> The other option, which is the one I'm proposing and which seems more
> natural for end users, is to add an optional read callback in the
> input_dev structure that, if implemented by the driver, will call the
> driver back whenever someone is asking for the state of the input
> device.  Drivers can then choose to initiate a sampling operation only
> when a user is asking for the data.  Users just call poll() or read()
> at the rate they want the sampling to occur, and never get blocked for
> longer than it takes to acquire a sample.

This seems painful for applications, it means they need to deal with
their own data scheduling and means we have to take the hit of
explicitly polling the device even when it is capable of pushing the
data at us.  If we triggered the callback on poll() they'd also have
issues blocking on other file descriptors simultaneously.

> Finally, with the read callback approach there isn't any behavioral
> change in the evdev interface at all for existing drivers (and
> existing drivers will continue to work as they do now).  When drivers
> start implementing the read callback, users will just notice that
> their drivers are simpler and their data is more recent--- if they
> care to investigate either of those.

Assuming the applications are behaving as you describe and not blocking
waiting for data - I'd expect that if they block waiting for data they'd
also end up seeing data delievered much faster.

I don't see any meaningful difference in the timeliness of data
delivery with the two approaches - no matter who's clocking the poll the
application will get the data at pretty much the same time after the
sample, the difference would be for applications that current schedule
their own reads.  For drivers that don't or can't have the hardware push
samples out I'd expect librification would mean that there'd be little
impact on driver code, obviously if the hardware was helping the
complexity would depend on how helpful the hardware is.

> What I'm proposing is something that is very similar to input-polldev,
> except that users don't even have to specify the polling rate: they
> just call read() or poll() at the rate they want the input device
> hardware to scan/sample itself.  Some current users of input-polldev
> might be better served by a read callback, in fact.

Perhaps I'm missing something here but my experience has always been
that having to worry about time periods adds rather than removes
complexity in applications; the raw POSIX APIs aren't especially
convenient here.  Obviously higher level libraries will often provide
timer facilities which make these useful (I've written such things
myself) but it's still going to be more work for the system than if the
hardware can push data out for us.

> The read callback approach is completely wrong for USB-ish keyboards
> and mice, so those drivers won't implement a read callback.  But for
> accelerometers, pushbuttons and such, a read callback seems like a
> very useful tool.  I hope to have first-hand evidence of that later
> today, preferably in a way that will be useful to the broader
> community as well.  :)

Pushbuttons seem like they'd want to be event driven, surely?
