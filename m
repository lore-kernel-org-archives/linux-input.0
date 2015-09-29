From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v3 1/5] Input: goodix - reset device at init
Date: Tue, 29 Sep 2015 04:04:25 +0200
Message-ID: <1443492265.17930.9.camel@hadess.net>
References: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
	 <1435595304-4840-2-git-send-email-irina.tirdea@intel.com>
	 <1435679809.2612.13.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F0AC0D3@irsmsx105.ger.corp.intel.com>
	 <1441818159.27328.30.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F0C9F85@irsmsx105.ger.corp.intel.com>
	 <1443192251.17020.29.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F0E98FC@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0E98FC-pww93C2UFcwu0RiL9chJVbfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2015-09-25 at 21:04 +0000, Tirdea, Irina wrote:
>=20
> > -----Original Message-----
> > From: Bastien Nocera [mailto:hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org]
> > Sent: 25 September, 2015 17:44
> > To: Tirdea, Irina; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Rob Herring; Pawel Moll; Ian
> > Campbell; Kumar Gala; Purdila, Octavian; Dmitry Torokhov; Mark
> > Rutland; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [PATCH v3 1/5] Input: goodix - reset device at init
> >=20
> > On Thu, 2015-09-10 at 14:04 +0000, Tirdea, Irina wrote:
> > >=20
> > > > -----Original Message-----
> > > > From: Bastien Nocera [mailto:hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org]
> > > > Sent: 09 September, 2015 20:03
> > > > To: Tirdea, Irina; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Rob Herring; Pawel Moll; Ian
> > > > Campbell; Kumar Gala; Purdila, Octavian; Dmitry Torokhov; Mark
> > > > Rutland; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > > > Subject: Re: [PATCH v3 1/5] Input: goodix - reset device at
> > > > init
> > > >=20
> > > > On Thu, 2015-07-30 at 11:27 +0000, Tirdea, Irina wrote:
> > > > > I can send some additional patches that will simplify testing
> > > > > the
> > > > > configuration update to the Goodix device. I think this
> > > > > feature
> > > > > is
> > > > > the easiest
> > > > > to test so we can determine if writing to the interrupt pin
> > > > > actually
> > > > > works.
> > > > > However, even if it is a BIOS problem and the code will work,
> > > > > the
> > > > > warning
> > > > > will still be printed in dmesg.
> > > >=20
> > > >=20
> > > > Somehow missed this mail before replying to the current
> > > > patchset.
> > > > I'd
> > > > be fine with that, though it's still not clear to me whether
> > > > the
> > > > BIOS/hardware is at fault, or the code that's being added to
> > > > the
> > > > driver
> > > > ;)
> > > >=20
> > >=20
> > > The reset procedure is described in the Goodix GT911 datasheet
> > > [1]
> > > and is
> > > used for power-on reset and power management. The power-on
> > > sequence
> > > is described in chapter 6.1. I2C Timing, in the Power-on Timing
> > > diagram.
> > > The sequence for putting the device to sleep is described in
> > > chapter
> > > 7.1. Operating Modes, c) Sleep mode. These sequences use the
> > > interrupt
> > > pin as output.
> > >=20
> > > The warning you mentioned comes from the following code in the
> > > goodix
> > > driver, which sets the interrupt to be used as output:
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error =3D gpiod_direct=
ion_output(ts->gpiod_int, ts->client-
> > > > addr =3D=3D 0x14);
> > >=20
> > > The gpiod_direction_output() call ends up in
> > > drivers/pinctrl/intel/pinctrl-baytrail.c:
> > > /*
> > > =C2=A0* Before making any direction modifications, do a check if =
gpio
> > > =C2=A0* is set for direct IRQ.=C2=A0=C2=A0On baytrail, setting GP=
IO to output
> > > does
> > > =C2=A0* not make sense, so let's at least warn the caller before =
they
> > > shoot
> > > =C2=A0* themselves in the foot.
> > > =C2=A0*/
> > > WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
> > > 	"Potential Error: Setting GPIO with direct_irq_en to output");
> > >=20
> > > So the problem comes from using the gpio interrupt pin as output,
> > > which
> > > should not work on Baytrail if BYT_DIRECT_IRQ_EN is set by BIOS.
> > > The above warning is introduced and discussed in [2] and [3]. As
> > > I
> > > mentioned,
> > > this could be a real HW issue or the BIOS sets BYT_DIRECT_IRQ_EN
> > > when
> > > it should not. I have also tested these patches on a Baytrail
> > > plarform
> > > (that uses the same pinctrl driver), but I did not see any issues
> > > since
> > > BYT_DIRECT_IRQ_EN is not set in my case for the interrupt gpio
> > > pin.
> >=20
> > Do we have a way to work-around this in the GPIO driver?
> >=20
> > > To determine if using the interrupt pin as output works, you can
> > > test
> > > updating
> > > the goodix configuration [4].
> >=20
> > Right, the problem being that it's a later patch in the branch, and
> > that the driver will fail to probe if there's an error from the
> > GPIO
> > call.
> >=20
>=20
> The warning from your dmesg output will not cause probe to fail.
> If you look at the code for byt_gpio_direction_output, it will just
> print
> a warning and continue [1]:
> 	WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
> 		"Potential Error: Setting GPIO with direct_irq_en to
> output");
> I thought probe finishes successfully, but due to the warning in
> dmesg you
> are not sure whether the IRQ GPIO pin can be used as output.
> If probe fails, it must be for another reason than the direct_irq_en
> warning.
>=20
> > Would you have a patch for me to test that would bypass this error,
> > or
> > at least fallback gracefully to not resetting, not probing GPIOs if
> > they're badly setup?
>=20
> If the driver fails to initialize the GPIOs, it will at least print
> some
> "Failed to get GPIO" warnings in dmesg. Do you have such messages in
> dmesg or any additional information on why probe fails?
>=20
> The current code will ignore GPIOs if they are not defined in ACPI
> (see the check for -ENOENT), but does not ignore other error codes.
> If you want to bypass all GPIO errors, you can use the code below.

The failure isn't there, it's when running=C2=A0goodix_i2c_test():
Sep 25 16:39:20 winbook kernel: Goodix-TS i2c-GDIX1001:00: i2c test fai=
led attempt 1: -121
Sep 25 16:39:20 winbook kernel: Goodix-TS i2c-GDIX1001:00: i2c test fai=
led attempt 2: -121
Sep 25 16:39:20 winbook kernel: Goodix-TS i2c-GDIX1001:00: I2C communic=
ation failure: -121
Sep 25 16:39:20 winbook kernel: Goodix-TS: probe of i2c-GDIX1001:00 fai=
led with error -121

The GPIO setup seems to work (bar the warnings), and the reset as well,
but then the device fails to communicate. Likely a fallout from the
reset actually failing.

Swapping around the RST and INT pins leads to the same problem. Either
this device's GPIO PINs aren't actually functional, and the firmware
contains garbage, or something else is wrong.

I'm not sure how we can detect, and blacklist, those devices. At least
my original device, the Onda v975w, and the WinBook TW100 would have
those problems.

Cheers
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
