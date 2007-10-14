From: Pavel Pisa <ppisa4lists@pikron.com>
Subject: Re: [PATCH] Generic, platform independent matrix keyboard support
Date: Sun, 14 Oct 2007 22:57:03 +0200
Message-ID: <200710142257.03872.ppisa4lists@pikron.com>
References: <200709021228.58354.ppisa4lists@pikron.com> <200710091905.39882.david-b@pacbell.net> <d120d5000710100610n50d7c62cuf365ad0d2ded5916@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <d120d5000710100610n50d7c62cuf365ad0d2ded5916@mail.gmail.com>
Content-Disposition: inline
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, David Brownell <david-b@pacbell.net>, linux-input <linux-input@atrey.karlin.mff.cuni.cz>, Sascha Hauer <s.hauer@pengutronix.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: linux-input@vger.kernel.org

On Wednesday 10 October 2007 15:10, Dmitry Torokhov wrote:
> On 10/9/07, David Brownell <david-b@pacbell.net> wrote:
> > On Tuesday 09 October 2007, Pavel Pisa wrote:
> > > On the other hand I cannot imagine electronic designed wanting
> > > so many wires. Reduction of the wires counts is why matrix keyboards
> > > are used. The 32 bits limitation then means that maximal supported
> > > keyboard can be 32x32 key => 1024 keys, that is quite imposing.
> >
> > Yes:  http://weblog.sinteur.com/?p=20412  :)
>
> Thank you David ;)

OK, I am defeated for now.

I do not have time at this moment to rewrite code with unlimited
return lines number support. I even think, that finding decent interface
could be problematic. I have some ideas, but each has its own ugliness
in it. I am putting your other suggestion on my instantly growing
unfinished tasks queue. I hope, that I find some time before
2.6.25 merge window to sort that out. I believe, that the
code could be usesfull for other as well. 
I need to work on other more urgent things and actual
code version seems to be sufficient for me at this moment.

The IRQ cannot cause problem in my case, because I have edge
triggered sources, UP system and keyboard code generally work
and is designed to work such way, that only one of timer
and IRQ event is armed at one time instant so there should not
be a problem. But I am aware of and fully agree that this has
to be cleaned up before mainline inclusion. It could be solved
by spinlock_irq quickly too. I have that in my mind first but
then it looked as possible to implement it without this
requirement.

As for 32 lines limit, I think, that it is nonsense, but I agree,
that there could be simple-minded people for which could come to mind
to weave 100 x 100 matrix keyboard in single net. I have never seen
single PCI card for so many direct IOs, but I have seen assembly of many
boxes full of mechanical relays connected to multiport PLC to do
centralized control of big industrial systems spread on large area.
I would never do that. Even in keyboard case it would be much better
to use more building blocks with local MCU or FPGA and interconnect
them by I2C, USB, CAN or SPI. But because there exists people to whom such
weaving comes to mind, I try to think if I could find way to support
their strange preferences without big code usability and performance
degradation.

I would be much more happy, if such pressure for generality would
be pushed into directions where such universality makes more sense.
GPIO is an example. It would be great if there would be support to test
if pin can become input, output, has pull-up and or OC support
and if these options could be controlled portable way. These things
are common on most of todays chips (even on 8-bit MCUs) and
pull-ups are required to prevent extraordinary power consumption
caused by floating input pins. The restricted GPIO API is bigger
obstacle to build really portable matrix keyboard support
than 32 return lines limit from my point of view.
The other area is runtime registration and mapping of GPIO
ports, but I agree, that it is problematic to design well.

Best wishes

              Pavel Pisa

PS: I do not expect, that MS is so stupid to build single
    matrix but who knows. There could be even signal crossover
    noise problems caused by scanning soccer field size keyboards.

    
