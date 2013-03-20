From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH v6 0/6] Add ChromeOS Embedded Controller support
Date: Wed, 20 Mar 2013 02:12:11 +0100
Message-ID: <20130320011211.GA5905@zurbaran>
References: <1361830121-32284-1-git-send-email-sjg@chromium.org>
 <20130320005652.GC26903@zurbaran>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:34655 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756846Ab3CTBMx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Mar 2013 21:12:53 -0400
Content-Disposition: inline
In-Reply-To: <20130320005652.GC26903@zurbaran>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Glass <sjg@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rob Landley <rob@landley.net>, Felipe Balbi <balbi@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Wolfram Sang <w.sang@pengutronix.de>, Luigi Semenzato <semenzato@chromium.org>, Rob Herring <rob.herring@calxeda.com>, Che-Liang Chiou <clchiou@chromium.org>, Jonathan Kliegman <kliegs@chromium.org>, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>, devicetree-discuss@lists.ozlabs.org, Alban Bedel <alban.bedel@avionic-design.de>, Roland Stigge <stigge@antcom.de>, Vincent Palatin <vpalatin@chromium.org>, Javier Martinez Canillas <javier@dowhile0.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-doc@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Tony Lindgren <tony@atomide.com>, Bill Pemberton <wfp5p@virginia.edu>

On Wed, Mar 20, 2013 at 01:56:52AM +0100, Samuel Ortiz wrote:
> Hi Simon,
>=20
> On Mon, Feb 25, 2013 at 02:08:35PM -0800, Simon Glass wrote:
> > The ChromeOS Embedded Controller (EC) is an Open Source EC implemen=
tation
> > used on ARM and Intel Chromebooks. Current implementations use a Co=
rtex-M3
> > connected on a bus (such as I2C, SPI, LPC) to the AP. A separate in=
terrupt
> > line is used to indicate when the EC needs service.
> All 6 patches applied to my mfd-next tree, thanks a lot.
Actually, this one fails to build when CONFIG_OF is not set:

drivers/mfd/cros_ec_i2c.c:130:2: error: implicit declaration of functio=
n
=E2=80=98of_device_is_available=E2=80=99 [-Werror=3Dimplicit-function-d=
eclaration]

If the check in cros_ec_probe_i2c() is really needed then you'll need t=
o inline
of_device_is_available() into a NOP in include/linux/of.h.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
