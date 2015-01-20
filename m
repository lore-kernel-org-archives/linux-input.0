From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: About Goodix-TS on Bay Trail, and ACPI and interrupts
Date: Tue, 20 Jan 2015 11:31:52 -0500
Message-ID: <20150120163152.GB23441@mail.corp.redhat.com>
References: <20150117010306.7e32b72524e4c0cf8296bbac@ao2.it>
 <20150119153758.GA18115@mail.corp.redhat.com>
 <20150120100548.GG1850@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150120100548.GG1850@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Mika Westerberg <mika.westerberg@intel.com>
Cc: Antonio Ospite <ao2@ao2.it>, linux-input@vger.kernel.org, linux-acpi@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Mathias Nyman <mathias.nyman@linux.intel.com>
List-Id: linux-input@vger.kernel.org

On Jan 20 2015 or thereabouts, Mika Westerberg wrote:
> On Mon, Jan 19, 2015 at 10:37:58AM -0500, Benjamin Tissoires wrote:
> > Hi Antonio,
> > 
> > [adding Mika in CC, he implemented most of the ACPI and GPIO for
> > i2c-hid]
> > 
> > On Jan 17 2015 or thereabouts, Antonio Ospite wrote:
> > > Hi,
> > > 
> > > I am trying to make the Goodix driver (drivers/input/touchscreen/goodix.c)
> > > working with a Teclast X98 Air 3G, a tablet based on Intel Bay Trail,
> > > but I am new to ACPI and I could use some help.
> > > 
> > > I am working with a 3.19-rc4 kernel compiled for x86_64.
> > > 
> > > This is the DSDT section in the UEFI firmware:
> > > 
> > >             Device (TCS0)
> > >             {
> > >                 Name (_ADR, Zero)  // _ADR: Address
> > >                 Name (_HID, "GODX0911")  // _HID: Hardware ID
> > >                 Name (_CID, "PNP0C50" /* HID Protocol Device (I2C bus) */)  // _CID: Compatible ID
> > 
> > urgh, this is bad. It declares itself as i2c-hid, but it is not :(
> > Anyway, according to your logs, i2c-hid probe() just fails, so it's not
> > a big problem.
> 
> 
> Actually, I think this device should use i2c-hid. All the ACPI plumbing
> is there including _DSM.
> 
> What makes you think it should use the goodix driver?

The fact that the 3.19-rc4 log says:
[    2.424370] i2c_hid i2c-GODX0911:01: unexpected HID descriptor bcdVersion (0x0000)

Which is rather troublesome and shows that we might have received a 0
answer when requesting the HID descriptor. Then Antonio tried to poke
the device with the goodix driver and got a better answer from the
version point of view.

Cheers,
Benjamin
