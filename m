From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH] input: evdev: Add a read() callback
Date: Mon, 21 Feb 2011 22:07:12 -0600
Message-ID: <AANLkTik8d1KZd_qSr2tKrBHq2X-9agA1BG7guK1SqzAd@mail.gmail.com>
References: <1298297930-3937-1-git-send-email-bgat@billgatliff.com>
	<20110222002315.GA18299@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-embedded-owner@vger.kernel.org>
In-Reply-To: <20110222002315.GA18299@sirena.org.uk>
Sender: linux-embedded-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, linux-embedded@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Mark:


Thanks for the great feedback!

In a nutshell, I agree with your summary stating that my proposal "is
going to cause problems for applications that try to do the right
thing".  Were my suggestion to be adopted immediately and across the
board, things would turn hairy indeed!

I'm actually focused on a very narrow use case, however:
accelerometers, compasses, polled switches, and similar hardware.  I'm
wanting to propose a common method for dealing with these, as an
alternative to the raft of incompatible approaches that are currently
taking hold.  And in addition to avoiding the inconsistency of these
implementations across devices, I also want to eliminate as much
redundancy in the implementations as possible.

A good case in point comes up when someone moves an Android
implementation from one platform to another.  No two accelerometer
drivers seem to agree on how to specify the desired event generation
rate, so the migration effort is increased.  And the work is divided
between both kernel and userspace: the former in its mandate to
provide a rate-request interface, and the latter to utilize that
interface.  I really don't see the point in this.

Granted, on all of MY platforms I can go ahead and implement this
read-callback idea, and so far it has proven interesting and helpful.
I'm just thinking that my success could appeal to a wider audience.
Instead of all of us creating and repeating the same work over and
over again, let's agree on SOMETHING.  Mine is of course a
somewhat-different way of solving the problem, but not without merit.

As I mention in my commit log/essay, devices like USB keyboards and
other event-driven hardware have no use for my read callback idea, and
can safely ignore it.  And I don't see a day on the horizon where
anyone will plug an accelerometer into X and expect X to deal with it
as properly as it does today for keyboards and mice.  I don't think
the "do the right thing" applications you are referring to will be
affected by the read callback at all, since the callback doesn't apply
to ordinary, "do the right thing"-type situations.

More responses inline below:


On Mon, Feb 21, 2011 at 6:23 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> I don't see how any of the above shows an issue with rate limiting in
> the application image. =A0As was discussed in some detail the last ti=
me
> you posted this the issue that's causing the applications to experien=
ce
> delayed notifications of events is that rather than blocking waiting =
for
> an event to be delivered to them they're sleeping unconditionally.

That is definitely one source of problems.

But if the accelerometer measurement has to be synchronized with some
other event, things get a little trickier.  At the moment my concerns
for this are theoretical, but I can see some situations coming soon
where the theory could be usefully put to practice.


> If the application were to use a rate control in conjunction with blo=
cking
> (which is the expected programming model) then a rate control will do
> exactly what's expected.

No argument with that.  My main complaint is that everyone is doing
rate control APIs differently.  I'm proposing a way to standardize
them by eliminating them altogether.  A side-effect of my idea is that
applications get complete control over event generation.  Many of them
won't care about that, but some will.

> This doesn't address the issue raised in the previous discussion with
> the poor interaction with applications that do behave sensibly and bl=
ock
> for events from the device - either we can't use the ability to trigg=
er
> readings from the hardware or we end up doing extra readings because
> every read triggers an additional sample.

I recognize your concern.  But I don't think that the applications
which could be confused by the behavior I'm proposing would be the
same applications that would take advantage of it.  Or, perhaps, such
applications might welcome eliminating the code needed to support the
different rate-limiting interfaces of a half-dozen or more devices
that they claim compatibility with.

Besides, it isn't like my proposal would be forced upon any of the
existing mainline drivers.  Most of them, like keyboards and mice,
couldn't use it anyway.

> This is all stuff that can be put into a library (parts of it are
> already) so there's no real cost to drivers from implementing anythin=
g.

=2E.. except the redundancy of everyone doing it slightly differently.
Why not settle on a common approach, so the library you mention isn't
necessary at all?

> This will again interact poorly with event driven applications - if
> notifications to userspace don't happen (eg, because there has been n=
o
> change) then there will be no cause for the application to read.

Agreed.  But those situations don't describe users of accelerometers
and compasses.  At least not in the code/situations I have
encountered.

> I can see a use for a read on demand callback in the implementation o=
f
> polling (eg, if rate is set to zero or for the core polling library t=
o
> use) but the userspace API thats being proposed here seems like it's
> going to cause problems for applications that try to do the right thi=
ng.

Such applications probably aren't a factor here.


b.g.
--=20
Bill Gatliff
bgat@billgatliff.com
