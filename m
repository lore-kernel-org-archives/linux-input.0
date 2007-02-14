From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: extend EV_LED
Date: Wed, 14 Feb 2007 14:49:46 -0500
Message-ID: <d120d5000702141149g772840e7h87e4362b3f380bc0@mail.gmail.com>
References: <d120d5000702121031o1ea5ff20lf4e0946c8c1e2980@mail.gmail.com>
	 <freemail.20070114200635.96983@fm13.freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <freemail.20070114200635.96983@fm13.freemail.hu>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On 2/14/07, N=E9meth M=E1rton <nm127@freemail.hu> wrote:
>
>
> Dmitry Torokhov <dmitry.torokhov@gmail.com> =EDrta:
>
> > On 2/11/07, N=E9meth M=E1rton <nm127@freemail.hu> wrote:
> > >
> > > Extend EV_LED handling code so that it can handle not
> > > only two states (on/off) but also others. For example
> > > a LED can blink using hardware acceleration. The code
> > > changed so that it is similar to the code at EV_SND.
> > >
> >
> > Hi,
> >
> > I am not sure we would need this, could you explain what
> are you
> > trying to use input leds for?
> >
> > Generally speaking leds within input subsystem are
> supposed to be very
> > simple on/off objects, mostly for reporting state of input
> devices
> > (keyboards), I am not even sure that LED_MAIL and
> LED_CHARGING make
> > much sense here. For more compex objects(blinking/different
> > colors/different brightness) we have a separate LED subsystem
> > (drivers/leds).
>
> The background is that I own a Clevo notebook model D4J,
> product D410J which has a mail led near to the other LEDs.
> The mail LED in question has three known state: off, blink
> slow (0.5Hz), and blink fast (1Hz).
>
> The mail LED can be programmed through the ports 0x60 and
> 0x64. These ports belog to the i8042 controller, which is
> operated by the input subsystem. To be able to access the
> i8042 controller correctly, I need the spinlock i8042_lock
> held, which is defined as static in
> linux/drivers/input/serio/i8042.c .
>
> What I miss currently from the input subsystem is that the
> EV_LED can only handle on/off state.
>
> I do not know the LED subsystem in detail, but I do not know
> any possibility to access the i8042 from different subsystem
> than the input subsystem.
>
> What do you think and recommend?
>

I think you need to use leds framework for what you are trying to do.
I could export i8042_command() so you could access keyboard controller
from your driver.

--=20
Dmitry
