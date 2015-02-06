From: Antonio Ospite <ao2@ao2.it>
Subject: Re: About Goodix-TS on Bay Trail, and ACPI and interrupts
Date: Fri, 6 Feb 2015 17:00:13 +0100
Message-ID: <20150206170013.90a20c05fae6393ea92312df@ao2.it>
References: <20150117010306.7e32b72524e4c0cf8296bbac@ao2.it>
	<20150119153758.GA18115@mail.corp.redhat.com>
	<20150120100548.GG1850@lahna.fi.intel.com>
	<20150120175645.f0f95b83da0355b8fdc7dd0d@ao2.it>
	<20150121101654.GM1850@lahna.fi.intel.com>
	<20150127154559.5baae4c2d2540f6f4362e3c6@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:40712 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752AbbBFQAW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2015 11:00:22 -0500
In-Reply-To: <20150127154559.5baae4c2d2540f6f4362e3c6@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Mathias Nyman <mathias.nyman@linux.intel.com>

On Tue, 27 Jan 2015 15:45:59 +0100
Antonio Ospite <ao2@ao2.it> wrote:

> On Wed, 21 Jan 2015 12:16:54 +0200
> Mika Westerberg <mika.westerberg@intel.com> wrote:
> 
> > On Tue, Jan 20, 2015 at 05:56:45PM +0100, Antonio Ospite wrote:
[...]
> > > [    9.056300] gpiochip_get_desc: hwnum: 68 chip->ngpio: 44
> > > [    9.056303] acpi_find_gpio: desc_error: -22
> > > [    9.056306] acpi_find_gpio: ares->type: 17
> > > [    9.056308] acpi_find_gpio: ares->type: 7
> > > [    9.056314] i2c_hid i2c-GODX0911:01: lookup for GPIO irq failed
> > > [    9.056319] i2c_hid i2c-GODX0911:01: Failed to get GPIO interrupt
> > > [    9.073895] i2c_hid: probe of i2c-GODX0911:01 failed with error -22
> > > 
> > > As I was trying to say in the original mail, the DSDT declares a gpio
> > > pin number (68) grater than the number of gpios for GPO2 (which on Bay
> > > Trail is 44, isn't it?).
> > 
> > That's right.
> > 
> > > Is the DSDT just wrong? Or could there be anything missing in the
> > > pinctrl-baytrail driver?
> > 
> > I think the DSDT is wrong here.
> > 
> > I found out from my mail archives that similar Goodix panel was used on
> > some internal reference design boards (it also used Goodix driver, btw).
> > Those also had the 0x44 GPIO there but that was wrong and it looked like
> > the correct GPIO number is 3 (in GPO2).
> 

And indeed it was the DSDT which had wrong both the interrupt pin _and_
the reset pin (GPO1.TCD3)...

Now I am sure that the android kernel doesn't use the platform data from
ACPI but provides it to drivers with some machine specific code, which I
don't have access to.

I was able to make the touchscreen work by using these resources:
	Reset line (GPO1.TCD3) is: pin 9 on GPO1
	Interrupt line is:         pin 3 on GPO2

The reset sequence is performed when calling the _PS0 method, and with
the correct values the goodix driver can even retrieve the stored
configuration, no need to use the hardcoded default one.

Last doubt, now that I am fixing the DSDT I am going to add an
Interrupt resource, but what is the correct way to specify its value?
Pin 3 of GPO2 is mapped to IRQ 220 by the mainline kernel, so I added
this:

  Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
  {
    0x000000DC,
  }

And it works, but doesn't this rely on the way linux maps interrupt
numbers? Is this going to be OS agnostic? My doubt arises from the
fact that on the Android kernel the same pin is mapped to IRQ
389.

JFTR since I had no access to the kernel source (the device
manufacturer does not reply...), I had to derive the correct gpios from
the running Android kernel.

The interrupt one was easy, to verify that it was pin 3 of GPO2 I looked
in /proc/interrupts, done some subtractions and figured it out.

The reset line was trickier for me, first I thought that I could rmmod
the android goodix driver and look at some status changes, but the
driver was not rmmod-safe, the kernel hung... then I thought that the
touchscreen may be turned off when the screen is turned off and that did
it; in the end I managed to spot it by comparing /sys/kernel/debug/gpio
with the screen on and off; inteltool from coreboot would have worked
just as well.

Thanks,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
