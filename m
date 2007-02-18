From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [PATCH] input: extend EV_LED
Date: Sun, 18 Feb 2007 08:45:00 +0100 (CET)
Message-ID: <freemail.20070118084500.15225@fm07.freemail.hu>
References: <1171580944.5839.38.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <1171580944.5839.38.camel@localhost.localdomain>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


On Fri, 16 Feb 2007, Henrique de Moraes Holschuh wrote:
> On Thu, 15 Feb 2007, Richard Purdie wrote:
> > This has been discussed in several places several times.
The problem
> > with hardware accelerated flashing is that you're are
often limited to
> > certain constraints (this case being no exception) and
indicating what
> > these are to userspace in a generic fashion is difficult.
>=20
> The hability to blinking at one rate is *very* common on
laptops.  Blinking
> at a few discrete rates is also common enough.  They
should be supported in
> a generic way.
> [...]
> Here's a suggestion for a simple, non-overengineered
interface: a "blink"
> attribute (on/off) for leds which can hardware-blink.=20
Only one blink
> frequency is common enough that this attribute by itself
is very useful
> (e.g. it is all a ThinkPad and most WiFi/network card leds
need).
>=20
> For hardware-blink leds with various frequencies, there is
the typical way
> to provide such things: give us a RO
blink_available_frequencies attribute
> which says which discrete frequencies are allowed (space
separated), and a
> RW blink_frequency attribute to set the frequency.  If
instead of
> blink_available_frequencies, the driver provides RO
blink_frequency_min and
> _max attributes, then it means it can blink on that range
of freqs.
>=20
> That is simple enough to implement and use, and generic
enough.  You just
> need to set in stone if you want the freq in Hz, or a
submultiple.  You can
> even implement an optional "blink" software emulation that
drivers can hook
> into for systems where the driver *knows* that led access
is fast, but there
> is no hardware blinking emulation.
>=20

A blinking led is basically a PWM (Pulse Width Modulation)
signal. A PWM signal has three different attribute. The
first one is the amplitude, this attribute is already
provided by the led subsystem as "brightness". There are two
more attributes, which are the frequency [Hz] and the duty
cycle [%], or the on-time [ms] and off-time [ms].

The frequency [Hz] and duty cycle [%] parameters has the
problem, that if we are limited to integers, it is not
possible to express slower blinks than 1Hz. We could also
use [mHz] (milli-Hertz), but it is not very common unit.

The on-time [ms] and off-time [ms] seems to be easier to
handle (and this is also easier to simulate from software if
ever needed). An RO attribute could be introduced:
'pwm_available', which can contain parameter pairs separated
by space, and the new parameter pair is in new line. An RW
attribute 'pwm' could accept a parameter pair separated by
space.

A range could be also given in 'pwm_available', like this:
'500-1000 500-1000'. This has the limitation that if there
is a hardware which can blink a LED in differet freqencies,
but only with fixed 50% duty cycle, the on-time off-time
pair cannot express this range easily.

My real-world example would be my Clevo D4J (D410J)
notebook's mail led. It has three known state: off, PWM at
1Hz (50%), PWM at 0.5Hz (50%). In case the on-time [ms]
off-time [ms] parameter pairs are used:

$ cat pwm_available
500 500
1000 1000

What is your opinion?
Is there more real-world hardware accelerated blinking LED
parameter examples?

        NMarci

=0A=0A_____________________________________________________________________=
_____
Kedvez=F5 tand=EDjak, k=FCl=F6nleges kedvezm=E9nyek =E9s magas szint=FB szo=
lg=E1ltat=E1sok.=20
Ez az Educomm online nyelviskola =E9s az egyed=FCl=E1ll=F3 EDUCATOR. Kattin=
ts ide!
http://ad.adverticum.net/b/cl,1,6022,131839,203066/click.prm
