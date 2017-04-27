From: Darren Hart <dvhart@infradead.org>
Subject: Re: Silead DMI driver
Date: Thu, 27 Apr 2017 14:13:22 -0700
Message-ID: <20170427211322.GA29261@fury>
References: <20170424132356.044ae04f@endymion>
 <1493034496.24567.163.camel@linux.intel.com>
 <20170425121939.7dbdfeed@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170425121939.7dbdfeed@endymion>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Hans de Goede <hdegoede@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Apr 25, 2017 at 12:19:39PM +0200, Jean Delvare wrote:
> On Mon, 24 Apr 2017 14:48:16 +0300, Andy Shevchenko wrote:
> > On Mon, 2017-04-24 at 13:23 +0200, Jean Delvare wrote:
> > > I'm looking at drivers/platform/x86/silead_dmi.c which is being added
> > > to kernel v4.11 and I do not like what I see.
> > 
> > I don't like it either by some other reasons.
> > 
> > > I have to say I don't understand the whole complexity of the design.
> > > As I understand it, the properties which are being added are only
> > > consumed by the "silead" touchscreen driver. I see no necessity to add
> > > the missing properties before that driver is even loaded. Can't you
> > > just look for the ACPI companion device at the time the silead driver
> > > tries to bind to the i2c device, and add the missing properties before
> > > performing the actual probe? This would be so much simpler. What am I
> > > missing?
> > 
> > As far as I understand it would be as simple as adding a quirk in actual
> > driver (touchscreen), but there is strong objection of adding quirks to
> > the drivers/input/* from Dmitry as I noticed during discussion [1] about
> > GPIO ACPI library fixes I'm working on.
> > 
> > [1] https://lkml.org/lkml/2017/4/4/593
> 
> Thanks for the pointer Andy. OK, I can understand the argument of
> Dmitry that platform-specific quirks do not belong to the device
> drivers, even though in practice I'm not sure the cost of having a
> separate platform driver for the purpose is always worth it - depends
> on how "popular" the device is, I suppose.
> 
> But still, this can't justify non-modular platform code that will run
> on every X86 system out there. Any piece of platform-specific quirks,
> we should be able to build as a module, otherwise it simply doesn't
> scale. PCI quirks and such are enough pain already without inventing
> more flavors of bloat :-(
> 

Jean makes a good point. I would insist on this if the Kconfig default was y or
if distros were likely to enable this by default. However, this is for the still
very rare x86 tablet and is likely to only be enabled for those systems which
require it.

To emphasize its role, perhaps this driver should have a depends on TOUCHSCREEN_SILEAD?

While the default for Kconfig is n if not explicitly set to m or y, perhaps
"default n" should be added to TOUCHSCREEN_SILEAD and SILEAD_DMI to make it more
explicit. I don't know if there is an official preference on "default n"
statements or not.

-- 
Darren Hart
VMware Open Source Technology Center
