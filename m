From: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 5/6] Staging/iio/adc/touchscreen/MXS: add interrupt driven touch detection
Date: Mon, 16 Sep 2013 17:10:36 +0200
Message-ID: <201309161710.36726.marex@denx.de>
References: <1378887511-24530-1-git-send-email-jbe@pengutronix.de> <201309161623.48247.marex@denx.de> <201309161634.54603.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41506 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757219Ab3IPPKi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Sep 2013 11:10:38 -0400
In-Reply-To: <201309161634.54603.jbe@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, devel@driverdev.osuosl.org, fabio.estevam@freescale.com, jic23@cam.ac.uk, Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Otavio Salvador <otavio.salvador@gmail.com>

Dear J=FCrgen Beisert,

> Hi Marek,
>=20
> On Monday 16 September 2013 16:23:48 Marek Vasut wrote:
> > > On Sunday 15 September 2013 12:56:25 Jonathan Cameron wrote:
> > > > On 09/11/13 09:18, Juergen Beisert wrote:
> > > > > For battery driven systems it is a very bad idea to collect t=
he
> > > > > touchscreen data within a kernel busy loop.
> > > > >=20
> > > > > This change uses the features of the hardware to delay and
> > > > > accumulate samples in hardware to avoid a high interrupt and =
CPU
> > > > > load.
> > > > >=20
> > > > > Note: this is only tested on an i.MX23 SoC yet.
> > > > >=20
> > > > > Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
> > > > > CC: linux-arm-kernel@lists.infradead.org
> > > > > CC: devel@driverdev.osuosl.org
> > > > > CC: Marek Vasut <marex@denx.de>
> > > > > CC: Fabio Estevam <fabio.estevam@freescale.com>
> > > > > CC: Jonathan Cameron <jic23@cam.ac.uk>
> > > >=20
> > > > While this driver is placed in IIO within staging at the moment=
,
> > > > these changes are definitely input related.  Hence I have cc'd
> > > > Dmitry and the input list.
> > > >=20
> > > > I am personaly a little uncomfortable that we have such a compl=
ex bit
> > > > of input code sat within an IIO driver but such is life.
> > >=20
> > > Maybe an MFD for this ADC unit would be a better way to go? Curre=
ntly I
> > > have a different problem with this driver, because the ADC unit
> > > monitors the battery as well. And the charging driver from the po=
wer
> > > subsystem needs these values to charge the battery in a correct
> > > manner.
> >=20
> > Are you planning to post the power block patches too ?
>=20
> When they will work: yes. Currently it crashes all the time. The PMIC=
 is a
> beast...

=46ull ACK

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
