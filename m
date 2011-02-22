From: Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] input: evdev: Add a read() callback
Date: Tue, 22 Feb 2011 13:13:07 +0000
Message-ID: <4D63B663.6070308@cam.ac.uk>
References: <1298297930-3937-1-git-send-email-bgat@billgatliff.com> <20110222002315.GA18299@sirena.org.uk> <AANLkTik8d1KZd_qSr2tKrBHq2X-9agA1BG7guK1SqzAd@mail.gmail.com> <20110222043302.GD18299@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:44955 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697Ab1BVNMk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Feb 2011 08:12:40 -0500
In-Reply-To: <20110222043302.GD18299@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Bill Gatliff <bgat@billgatliff.com>, linux-input@vger.kernel.org, linux-embedded@vger.kernel.org

On 02/22/11 04:33, Mark Brown wrote:
> On Mon, Feb 21, 2011 at 10:07:12PM -0600, Bill Gatliff wrote:
> 
>> A good case in point comes up when someone moves an Android
>> implementation from one platform to another.  No two accelerometer
>> drivers seem to agree on how to specify the desired event generation
>> rate, so the migration effort is increased.  And the work is divided
>> between both kernel and userspace: the former in its mandate to
>> provide a rate-request interface, and the latter to utilize that
>> interface.  I really don't see the point in this.
> 
> But surely the most obvious solution here is to standardise a rate
> control interface?  Anything else means we need a completely different
> implementation for hardware which does have the ability to schedule its
> own conversions.
I agree that standardizing would be a good idea.  Note that far from all
accelerometers act as 'polled' devices.  Most I've encountered have their
own sampling clocks and in many cases these can be set pretty low, saving
power and sometimes applying filters to give lower noise on the output.

For these I don't think the approach given in this thread makes sense.
It's more promising for those devices that are using an in driver
polling thread that actually initializes the sampling (more common
in slow devices like magnetometers).  Still, whilst I initially liked
the idea, the whole point about it interoperating badly with apps that
are event driven is clearly a big issue...
> 
>> As I mention in my commit log/essay, devices like USB keyboards and
>> other event-driven hardware have no use for my read callback idea, and
>> can safely ignore it.  And I don't see a day on the horizon where
>> anyone will plug an accelerometer into X and expect X to deal with it
>> as properly as it does today for keyboards and mice.  I don't think
>> the "do the right thing" applications you are referring to will be
>> affected by the read callback at all, since the callback doesn't apply
>> to ordinary, "do the right thing"-type situations.
> 
> The problem you're trying to solve is also an issue for really common
> and standard things like touchscreens and polled switches/keys (the
> latter of which you mentioned in your mail) which are used by standard
> applications.
> 
>> But if the accelerometer measurement has to be synchronized with some
>> other event, things get a little trickier.  At the moment my concerns
>> for this are theoretical, but I can see some situations coming soon
>> where the theory could be usefully put to practice.
> 
> Have you looked at the IIO subsystem for things like this?  There has
> been talk of putting accelerometers in there and it certainly fits in
> with the sync requirements you're mentioning.
Hmm. We still need to do more work on this to get it to the level I'd like.
To give background info:

A common reason for wanting this is Inertial Measurement Units (combination
of typically accelerometers, gyros and magnetometers) made up of a number
of discrete parts.  Some of these will run on their own internal clocks, so
not much we can do about them, but others as for the devices you are considering
here will sample based on a trigger pin, command over bus, or the bus read
itself.

IIO handles this via 'triggers'.  These are provided either by hardware
(data ready signals from chips, or gpio pins), timers or userspace triggering.
Any trigger can have as many separate poll functions attached as you like,
allowing the 'trigger event' to cause data to be captured from lots of different
sensors.  There are two queues, one for hammering capture pins as fast as possible
and one for doing slower bus based reads.  Aim is to get all the captures as close
as possible together subject to constraints of the actual board.

Things we don't handle well:
* delays.  Some devices have deterministic capture delays. Ideally we would take
these into account though it isn't entirely clear what the desired behaviour actually
is.
* Triggering based on the data ready signal of a part that isn't attached to the
same trigger.  This is fiddly and right now you can end up with the trigger not being
cleared and hence only firing once.
* Triggering form more esoteric events. E.g. Grab values from one device when another
passes some threshold.  However these will only be added if anyone actually has a use
case and even then will require support in the particular parts driver.

Still, it's a work in progress...
> 
>>> If the application were to use a rate control in conjunction with blocking
>>> (which is the expected programming model) then a rate control will do
>>> exactly what's expected.
> 
>> No argument with that.  My main complaint is that everyone is doing
>> rate control APIs differently.  I'm proposing a way to standardize
>> them by eliminating them altogether.  A side-effect of my idea is that
>> applications get complete control over event generation.  Many of them
>> won't care about that, but some will.
> 
> The problem with your proposal as it stands is that if they do use the
> new interface they interact badly with existing applications.  This
> isn't really a decision the driver should be taking, it needs to be
> userspace policy if it's going to be a decision at all.
> 
>> I recognize your concern.  But I don't think that the applications
>> which could be confused by the behavior I'm proposing would be the
>> same applications that would take advantage of it.  Or, perhaps, such
>> applications might welcome eliminating the code needed to support the
>> different rate-limiting interfaces of a half-dozen or more devices
>> that they claim compatibility with.
> 
> Again, you appear to be assuming that there are many rate limiting
> interfaces.  Surely the solution to an excess of rate limit interfaces
> is to standardise the rate limiting interfaces rather than invent a new
> interface, especially one that interoperates poorly with blocking apps?
> 
>>> This is all stuff that can be put into a library (parts of it are
>>> already) so there's no real cost to drivers from implementing anything.
> 
>> ... except the redundancy of everyone doing it slightly differently.
>> Why not settle on a common approach, so the library you mention isn't
>> necessary at all?
> 
> Note that I'm talking about in-kernel code here, not a linked library in
> userspace.  One way or another *something* is going to have to provide
> the scheduling support.

