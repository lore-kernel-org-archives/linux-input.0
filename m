From: Andy Ross <andy.ross@windriver.com>
Subject: [PATCH 0/2] Pegatron Lucid tablet accelerometer
Date: Mon, 17 Jan 2011 09:56:49 -0800
Message-ID: <1295287011-12849-1-git-send-email-andy.ross@windriver.com>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, linux-input@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Resend with fixes per comments: Driver for the ACPI interface to the
accelerometer on the Pegatron Lucid tablets (sold as WeTab and ExoPC).

Corentin Chary wrote:
> > +       int z =  acpi_s16("\\_SB.ATKD.XLRZ");
> 
> Using the absolute path (\\_SB.ATKD) may not work on new hardware, you
> should find the path of the device using the HID (AKT0100, or
> something like that). But we may not core in this case since it's pega
> specific.

I could pass the ACPI prefix (or a handle) through the platform driver
if you like, but it's a little more complexity and as you mention that
seems like overkill for a driver whose core is only three lines of
code.  Left unchanged.

Corentin Chary wrote:
> > +static int __devinit platform_probe(struct platform_device *pd)
> 
> You should check if the device exists here, before trying to do
> anything, (using the path or the HID, depending of what you'll do
> about my previous comment)

Detection is done in asus-laptop: this code won't be reached unless
the platform device is created, which is after the three needed
methods have already been detected with acpi_check_handle().

Dmitry Torokhov wrote:
> This is not a critical component; default should be 'n' (or just omit
> default statement).

Fixed.

Dmitry Torokhov wrote:
> Please keep Kconfig and Makefile sorted alphabetically.

Fixed in Makefile.  Kconfig is hopelessly out of order, but I did what
I could.

Dmitry Torokhov wrote:
> What's up with people loving to put filename into comments? It just
> makes renaming files more4 difficult.

No love here; I was trying to adhere to what looked like existing
convention.  Removed.

Dmitry Torokhov wrote:
> No need to initialize to 0, in fact, it is quite often dangerous as it
> masks compiler warnings.

True enough.  Fixed.

> > +	ipdev->input->dev.release = dev_noop_release;
> 
> WTH is this???

It's an attempt to avoid this from drivers/base/core.c:

      WARN(1, KERN_ERR "Device '%s' does not have a release() "
           "function, it is broken and must be fixed.\n",
           dev_name(dev));

...but it was in the wrong place.  The input device doesn't hit that
path, the platform device does.  Moved to where it belongs.

Andy
