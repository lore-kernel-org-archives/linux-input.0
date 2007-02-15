From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [PATCH] input: extend EV_LED
Date: Thu, 15 Feb 2007 23:47:56 +0100 (CET)
Message-ID: <freemail.20070115234756.58787@fm13.freemail.hu>
References: <20070215174009.GA6535@ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <owner-linux-input@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20070215174009.GA6535@ucw.cz>
Sender: owner-linux-input@atrey.karlin.mff.cuni.cz
List-Help: <mailto:majordomo@atrey.karlin.mff.cuni.cz?body=help>
List-Owner: <mailto:owner-linux-input@atrey.karlin.mff.cuni.cz>
List-Post: <mailto:linux-input@atrey.karlin.mff.cuni.cz>
List-Unsubscribe: <mailto:linux-input-request@atrey.karlin.mff.cuni.cz?body=unsubscribe>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org



Pavel Machek <pavel@ucw.cz> wrote:

> Hi!
>=20
> > >I do not know the LED subsystem in detail, but I do not=20
> > >know
> > >any possibility to access the i8042 from different=20
> > >subsystem
> > >than the input subsystem.
> > >
> > >What do you think and recommend?
> >=20
> > I think you need to use leds framework for what you are=20
> > trying to do.
>=20
> I'm actually not sure if led framework can do that. It was
designed
> for leds on gpios, and handles blinking itself.
>=20
> But he could export two leds :-).

Hi,

what do you mean about two leds? The first one would be
off/0.5Hz and the other off/1Hz?

I read in linux/Documentation/led-class.txt the following:

| Some leds can be programmed to flash in hardware. As this
isn't a generic
| LED device property, this should be exported as a device
specific sysfs
| attribute rather than part of the class if this
functionality is required.

Does it mean that neither the input subsystem nor the led
subsystem is designed for hardware acelerated blinking leds?
Is there any usual way what attribute a hw accelerated
blinking LED_MAIL should export?

        NMarci=0A=0A_______________________________________________________=
_______________________
10.000 Ft aj=E1nd=E9k fot=F3kidolgoz=E1s minden Panasonic digit=E1lis f=E9n=
yk=E9pez=F5g=E9phez!
FotoMarket Online Fot=F3=E1ruh=E1z=20
http://ad.adverticum.net/b/cl,1,6022,99786,162268/click.prm
