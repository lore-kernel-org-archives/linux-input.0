From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 - disable KBD port on Late-2016 Razer Blade
 Stealth
Date: Tue, 16 Jul 2019 22:28:09 +0200
Message-ID: <20190716202809.GB584@penguin>
References: <20190407213735.10658-1-lyude@redhat.com>
 <20190407221034.GA162359@dtor-ws>
 <0ac9aef48f4cf974f4f7046aad1267ab5c8fe525.camel@redhat.com>
 <28dc38a55c45467dad6f11e9ea459172@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <28dc38a55c45467dad6f11e9ea459172@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Lyude Paul' <lyude@redhat.com>, "stable@vger.kernel.org" <stable@vger.kernel.org>, Chen-Yu Tsai <wens@csie.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Mon, Apr 08, 2019 at 09:55:00AM +0000, David Laight wrote:
> From: Lyude Paul
> > Sent: 07 April 2019 23:55
> > On Sun, 2019-04-07 at 15:10 -0700, Dmitry Torokhov wrote:
> > > Hi Lyude,
> > >
> > > On Sun, Apr 07, 2019 at 05:37:34PM -0400, Lyude Paul wrote:
> > > > The late 2016 model of the Razer Blade Stealth has a built-in USB
> > > > keyboard, but for some reason the BIOS exposes an i8042 controller with
> > > > a connected KBD port. While this fake AT Keyboard device doesn't appear
> > > > to report any events, attempting to change the state of the caps lock
> > > > LED on it from on to off causes the entire system to hang.
> > > >
> > > > So, introduce a quirk table for disabling keyboard probing by default,
> > > > i8042_dmi_nokbd_table, and add this specific model of Razer laptop to
> > > > that table.
> > >
> > > What does dmesg show about i8042 for this device? Especially line "PNP:
> > > PS/2 Controller  ..."?
> > >
> > 
> > Apr 07 18:42:46 malachite kernel: i8042: PNP: No PS/2 controller found.
> > Apr 07 18:42:46 malachite kernel: i8042: Probing ports directly.
> > Apr 07 18:42:46 malachite kernel: serio: i8042 KBD port at 0x60,0x64 irq 1
> > Apr 07 18:42:46 malachite kernel: serio: i8042 AUX port at 0x60,0x64 irq 12
> > Apr 07 18:42:46 malachite kernel: mousedev: PS/2 mouse device common for all mice
> 
> That is the 'default' probe of the ps/2 serial ports.
> Looks like the BIOS is correct in not exposing the ps/2 controller.
> Usually they just fail to expose the mouse when it needs a ps/2 splitter :-(
> 
> I do wonder what they've connected it to though.
> It is extremely unlikely they've found an x86 chipset that doesn't
> have the ps/2 serial ports at the standard io addresses.

I wonder if it is time to start trusting BIOS if it was released maybe
in Win7+ timeframe?

Thanks.

-- 
Dmitry
