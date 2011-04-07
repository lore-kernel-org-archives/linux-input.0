From: Anisse Astier <anisse@astier.eu>
Subject: Re: [RFC] Reporting "orientation changed" event
Date: Thu, 7 Apr 2011 19:19:57 +0200
Message-ID: <20110407191957.7ebbee62@destiny.ordissimo>
References: <20110407181800.27b441b1@destiny.ordissimo>
	<4D9DEDF3.1090502@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <4D9DEDF3.1090502@cam.ac.uk>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>, Matthew Garrett <mjg@redhat.com>, Andy Ross <andy.ross@windriver.com>, Corentin Chary <corentin.chary@gmail.com>
List-Id: linux-input@vger.kernel.org

On Thu, 07 Apr 2011 18:01:39 +0100, Jonathan Cameron <jic23@cam.ac.uk> =
wrote :

> On 04/07/11 17:18, Anisse Astier wrote:
> >=20
> > Pegatron Lucid tablet sends an ACPI hotkey event(0xEA) when the
> > accelerometer detects coarse orientation change. My initial thought=
 was
> > to just translate this event into KEY_DIRECTION, which seems to be =
the
> > norm from what we can see in hp-wmi driver. (See patch below for an
> > implementation.)
> >=20
> > But this isn't just a key per se like on the HP touchsmart tablet, =
this
> > is an event that is triggered when the device is rotated.
> >=20
> > This could be defined as a new Misc (EV_MSC) event:
> > MSC_ORIENTATION_CHANGED ?
> >=20
> > Or we could use the upcoming IIO subsystem which is supposed to be =
for
> > sensors, but then we'd have a mismatch between the device based on =
ACPI
> > with firmware in the middle (driver submitted by Andy Ross) and the
> > purpose of IIO ("SPI or I2C device").
> Don't take that too literally. It's examples of types of bus IIO sens=
ors use.
> Having said this, if your main use is user input then it should proba=
bly be
> handled through input rather than IIO anyway.
>=20

Indeed, main use is user input. There's also the BIOS translation layer
to ACPI, so I=C2=A0guess it's a bit distant from IIO's purpose.


Anisse
