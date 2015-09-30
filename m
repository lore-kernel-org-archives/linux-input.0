From: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Subject: Re: [PATCH v3 1/5] Input: goodix - reset device at init
Date: Wed, 30 Sep 2015 13:15:39 +0200
Message-ID: <1443611739.5056.8.camel@hadess.net>
References: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
	 <1435595304-4840-2-git-send-email-irina.tirdea@intel.com>
	 <1435679809.2612.13.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F0AC0D3@irsmsx105.ger.corp.intel.com>
	 <1441818159.27328.30.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F0C9F85@irsmsx105.ger.corp.intel.com>
	 <1443192251.17020.29.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F0E98FC@irsmsx105.ger.corp.intel.com>
	 <1443492265.17930.9.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F0EBB24@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0EBB24-pww93C2UFcwu0RiL9chJVbfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Tirdea, Irina" <irina.tirdea-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Carlos Garnacho <carlosg-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org>, Cosimo Cecchi <cosimoc-rDKQcyrBJuzYtjvyW6yDsg@public.gmane.org>, christian-7XSPgEYZchhBDLzU/O5InQ@public.gmane.org
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "Purdila, Octavian" <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Tue, 2015-09-29 at 17:47 +0000, Tirdea, Irina wrote:
>=20
> > -----Original Message-----
> > From: Bastien Nocera [mailto:hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org]
> > Sent: 29 September, 2015 5:04
> > To: Tirdea, Irina; linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Rob Herring; Pawel Moll; Ian
> > Campbell; Kumar Gala; Purdila, Octavian; Dmitry Torokhov; Mark
> > Rutland; devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> > Subject: Re: [PATCH v3 1/5] Input: goodix - reset device at init
> >=20
> > On Fri, 2015-09-25 at 21:04 +0000, Tirdea, Irina wrote:
> > >=20
> <snip>
> > >=20
> > > The warning from your dmesg output will not cause probe to fail.
> > > If you look at the code for byt_gpio_direction_output, it will
> > > just
> > > print
> > > a warning and continue [1]:
> > > 	WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
> > > 		"Potential Error: Setting GPIO with direct_irq_en to
> > > output");
> > > I thought probe finishes successfully, but due to the warning in
> > > dmesg you
> > > are not sure whether the IRQ GPIO pin can be used as output.
> > > If probe fails, it must be for another reason than the
> > > direct_irq_en
> > > warning.
> > >=20
> > > > Would you have a patch for me to test that would bypass this
> > > > error,
> > > > or
> > > > at least fallback gracefully to not resetting, not probing
> > > > GPIOs if
> > > > they're badly setup?
> > >=20
> > > If the driver fails to initialize the GPIOs, it will at least
> > > print
> > > some
> > > "Failed to get GPIO" warnings in dmesg. Do you have such messages
> > > in
> > > dmesg or any additional information on why probe fails?
> > >=20
> > > The current code will ignore GPIOs if they are not defined in
> > > ACPI
> > > (see the check for -ENOENT), but does not ignore other error
> > > codes.
> > > If you want to bypass all GPIO errors, you can use the code
> > > below.
> >=20
> > The failure isn't there, it's when running=C2=A0goodix_i2c_test():
> > Sep 25 16:39:20 winbook kernel: Goodix-TS i2c-GDIX1001:00: i2c test
> > failed attempt 1: -121
> > Sep 25 16:39:20 winbook kernel: Goodix-TS i2c-GDIX1001:00: i2c test
> > failed attempt 2: -121
> > Sep 25 16:39:20 winbook kernel: Goodix-TS i2c-GDIX1001:00: I2C
> > communication failure: -121
> > Sep 25 16:39:20 winbook kernel: Goodix-TS: probe of i2c-GDIX1001:00=
=20
> > failed with error -121
> >=20
>=20
> Are you using v6 of the patches? There was an issue with reset that
> Aleksei reported
> and was fixed in v6 (although he had a different i2c error and a
> different scenario).

Pretty certain. Your current patchset is at:
https://github.com/hadess/gt9xx/tree/irina-tirdea

And the patches are yours, with the prefix and Documentation removed.

> > The GPIO setup seems to work (bar the warnings), and the reset as
> > well,
> > but then the device fails to communicate. Likely a fallout from the
> > reset actually failing.
> >=20
> > Swapping around the RST and INT pins leads to the same problem.
> > Either
> > this device's GPIO PINs aren't actually functional, and the
> > firmware
> > contains garbage, or something else is wrong.
> >=20
>=20
> I agree. Either the interrupt pin cannot be used as output in your
> configuration
> or there are some specifics in the ACPI tables that prevent using
> these pins.=20
>=20
> > I'm not sure how we can detect, and blacklist, those devices. At
> > least
> > my original device, the Onda v975w, and the WinBook TW100 would
> > have
> > those problems.
> >=20
>=20
> I can use DMI quirks to exclude these devices from using the features
> that
> depend on the gpio pins. I already have the DMI information for
> WinBook TW100
> and WinBook TW700. Could you tell me the DMI_SYS_VENDOR and
> DMI_PRODUCT_NAME for Onda v975w so I can add it as well?

I don't have access to the Onda v975w anymore, but let me CC: a few
people that could also help with testing.

Carlos, Cosimo, Christian, there's a patchset for you to test on the
Onda v975w at:
https://github.com/hadess/gt9xx/commits/irina-tirdea

Doing an "rmmod goodix ; insmod ./goodix_backport.ko" should be enough
to test whether the patch set works. If it doesn't work correctly,
you'll need to reboot the machine, swap the irq_idx and rst_idx values
at:
https://github.com/hadess/gt9xx/commit/c27de79f494c2b2e7a198ff4d27976ae=
93669dbd#diff-dddc2849e36327439530f3e2faacec4fR321

and try again.

If all that fails, could you please send the output of "dmidecode" to
Irina?

Cheers
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
