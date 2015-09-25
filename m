From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH v3 1/5] Input: goodix - reset device at init
Date: Fri, 25 Sep 2015 16:44:11 +0200
Message-ID: <1443192251.17020.29.camel@hadess.net>
References: <1435595304-4840-1-git-send-email-irina.tirdea@intel.com>
	 <1435595304-4840-2-git-send-email-irina.tirdea@intel.com>
	 <1435679809.2612.13.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F0AC0D3@irsmsx105.ger.corp.intel.com>
	 <1441818159.27328.30.camel@hadess.net>
	 <1F3AC3675D538145B1661F571FE1805F2F0C9F85@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:40740 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178AbbIYOoS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Sep 2015 10:44:18 -0400
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F0C9F85@irsmsx105.ger.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Purdila, Octavian" <octavian.purdila@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Thu, 2015-09-10 at 14:04 +0000, Tirdea, Irina wrote:
>=20
> > -----Original Message-----
> > From: Bastien Nocera [mailto:hadess@hadess.net]
> > Sent: 09 September, 2015 20:03
> > To: Tirdea, Irina; linux-input@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; Rob Herring; Pawel Moll; Ian
> > Campbell; Kumar Gala; Purdila, Octavian; Dmitry Torokhov; Mark
> > Rutland; devicetree@vger.kernel.org
> > Subject: Re: [PATCH v3 1/5] Input: goodix - reset device at init
> >=20
> > On Thu, 2015-07-30 at 11:27 +0000, Tirdea, Irina wrote:
> > > I can send some additional patches that will simplify testing the
> > > configuration update to the Goodix device. I think this feature
> > > is
> > > the easiest
> > > to test so we can determine if writing to the interrupt pin
> > > actually
> > > works.
> > > However, even if it is a BIOS problem and the code will work, the
> > > warning
> > > will still be printed in dmesg.
> >=20
> >=20
> > Somehow missed this mail before replying to the current patchset.
> > I'd
> > be fine with that, though it's still not clear to me whether the
> > BIOS/hardware is at fault, or the code that's being added to the
> > driver
> > ;)
> >=20
>=20
> The reset procedure is described in the Goodix GT911 datasheet [1]
> and is
> used for power-on reset and power management. The power-on sequence
> is described in chapter 6.1. I2C Timing, in the Power-on Timing
> diagram.
> The sequence for putting the device to sleep is described in chapter
> 7.1. Operating Modes, c) Sleep mode. These sequences use the
> interrupt
> pin as output.
>=20
> The warning you mentioned comes from the following code in the goodix
> driver, which sets the interrupt to be used as output:
>=20
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error =3D gpiod_direction_=
output(ts->gpiod_int, ts->client-
> >addr =3D=3D 0x14);
>=20
> The gpiod_direction_output() call ends up in
> drivers/pinctrl/intel/pinctrl-baytrail.c:
> /*
> =C2=A0* Before making any direction modifications, do a check if gpio
> =C2=A0* is set for direct IRQ.=C2=A0=C2=A0On baytrail, setting GPIO t=
o output does
> =C2=A0* not make sense, so let's at least warn the caller before they
> shoot
> =C2=A0* themselves in the foot.
> =C2=A0*/
> WARN(readl(conf_reg) & BYT_DIRECT_IRQ_EN,
> 	"Potential Error: Setting GPIO with direct_irq_en to output");
>=20
> So the problem comes from using the gpio interrupt pin as output,
> which=20
> should not work on Baytrail if BYT_DIRECT_IRQ_EN is set by BIOS.
> The above warning is introduced and discussed in [2] and [3]. As I
> mentioned,
> this could be a real HW issue or the BIOS sets BYT_DIRECT_IRQ_EN when
> it should not. I have also tested these patches on a Baytrail
> plarform
> (that uses the same pinctrl driver), but I did not see any issues
> since
> BYT_DIRECT_IRQ_EN is not set in my case for the interrupt gpio pin.

Do we have a way to work-around this in the GPIO driver?

> To determine if using the interrupt pin as output works, you can test
> updating
> the goodix configuration [4].

Right, the problem being that it's a later patch in the branch, and
that the driver will fail to probe if there's an error from the GPIO
call.

Would you have a patch for me to test that would bypass this error, or
at least fallback gracefully to not resetting, not probing GPIOs if
they're badly setup?

Cheers
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
