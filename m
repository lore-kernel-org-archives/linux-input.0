From: Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH] input: extend EV_LED
Date: Thu, 15 Feb 2007 23:09:03 +0000
Message-ID: <1171580944.5839.38.camel@localhost.localdomain>
References: <freemail.20070115234756.58787@fm13.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <freemail.20070115234756.58787@fm13.freemail.hu>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Pavel Machek <pavel@ucw.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2007-02-15 at 23:47 +0100, N=E9meth M=E1rton wrote:
> Pavel Machek <pavel@ucw.cz> wrote:
> > > >I do not know the LED subsystem in detail, but I do not=20
> > > >know any possibility to access the i8042 from different=20
> > > >subsystem than the input subsystem.
> > > >
> > > >What do you think and recommend?
> > >=20
> > > I think you need to use leds framework for what you are=20
> > > trying to do.
> >=20
> > I'm actually not sure if led framework can do that. It was
> > designed for leds on gpios, and handles blinking itself.

The led framework is generic. If you can write a function to turn it
on/off you can drive it with the LED framework.

> > But he could export two leds :-).
>
> what do you mean about two leds? The first one would be
> off/0.5Hz and the other off/1Hz?
>=20
> I read in linux/Documentation/led-class.txt the following:
>=20
> | Some leds can be programmed to flash in hardware. As this
> isn't a generic
> | LED device property, this should be exported as a device
> specific sysfs
> | attribute rather than part of the class if this
> functionality is required.
>=20
> Does it mean that neither the input subsystem nor the led
> subsystem is designed for hardware acelerated blinking leds?
> Is there any usual way what attribute a hw accelerated
> blinking LED_MAIL should export?

This has been discussed in several places several times. The problem
with hardware accelerated flashing is that you're are often limited to
certain constraints (this case being no exception) and indicating what
these are to userspace in a generic fashion is difficult.

One way I've come up with is adds capability to the class to have LED
specific triggers and you can then expose these hardware capabilities as
an extra trigger specific to the LED.

Another proposal more specific to this use case was to have some
information behind the scenes which the software timer based trigger
could use to turn on the "hardware acceleration" if present and capable
of the requested mode. This might just need a function pointer in the
core so could be quite neat.

Nether patch exists yet.

Cheers,

Richard
