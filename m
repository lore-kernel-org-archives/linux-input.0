From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [PATCH] input: extend EV_LED
Date: Wed, 14 Feb 2007 20:06:35 +0100 (CET)
Message-ID: <freemail.20070114200635.96983@fm13.freemail.hu>
References: <d120d5000702121031o1ea5ff20lf4e0946c8c1e2980@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932466AbXBNTPc@vger.kernel.org>
In-Reply-To: <d120d5000702121031o1ea5ff20lf4e0946c8c1e2980@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



Dmitry Torokhov <dmitry.torokhov@gmail.com> =EDrta:

> On 2/11/07, N=E9meth M=E1rton <nm127@freemail.hu> wrote:
> >
> > Extend EV_LED handling code so that it can handle not
> > only two states (on/off) but also others. For example
> > a LED can blink using hardware acceleration. The code
> > changed so that it is similar to the code at EV_SND.
> >
>=20
> Hi,
>=20
> I am not sure we would need this, could you explain what
are you
> trying to use input leds for?
>=20
> Generally speaking leds within input subsystem are
supposed to be very
> simple on/off objects, mostly for reporting state of input
devices
> (keyboards), I am not even sure that LED_MAIL and
LED_CHARGING make
> much sense here. For more compex objects(blinking/different
> colors/different brightness) we have a separate LED subsystem
> (drivers/leds).

The background is that I own a Clevo notebook model D4J,
product D410J which has a mail led near to the other LEDs.
The mail LED in question has three known state: off, blink
slow (0.5Hz), and blink fast (1Hz).

The mail LED can be programmed through the ports 0x60 and
0x64. These ports belog to the i8042 controller, which is
operated by the input subsystem. To be able to access the
i8042 controller correctly, I need the spinlock i8042_lock
held, which is defined as static in
linux/drivers/input/serio/i8042.c .

What I miss currently from the input subsystem is that the
EV_LED can only handle on/off state.

I do not know the LED subsystem in detail, but I do not know
any possibility to access the i8042 from different subsystem
than the input subsystem.

What do you think and recommend?

        NMarci

P.S.: my project home page is located at
http://clevo-mailled.sourceforge.net/





______________________________________________________________________
K=F6nyvszerda a Gabo, Akkord, Talentum, Cicer=F3 Kiad=F3kkal!=20
T=F6bb mint 700 f=E9le k=F6nyv 30% kedvezm=E9nnyel!=20
http://www.bookline.hu/control/news?newsid=3D397&affiliate=3Dfrekszkar3=
435
