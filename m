From: Paul Parsons <lost.distance@yahoo.com>
Subject: Re: [PATCH v5 1/2] pxa/hx4700: Add Synaptics NavPoint (PXA27x SSP/SPI) driver
Date: Wed, 4 Jan 2012 16:21:33 +0000 (GMT)
Message-ID: <1325694093.98137.YahooMailClassic@web29006.mail.ird.yahoo.com>
References: <4F014E2C.4000402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nm14.bullet.mail.ird.yahoo.com ([77.238.189.67]:37303 "HELO
	nm14.bullet.mail.ird.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756211Ab2ADQVf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Jan 2012 11:21:35 -0500
In-Reply-To: <4F014E2C.4000402@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Shubhrajyoti <shubhrajyoti@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, philipp.zabel@gmail.com, eric.y.miao@gmail.com, mad_soft@inbox.ru, koen@dominion.thruhere.net, dmitry.torokhov@gmail.com

Hi Shubhrajyoti,

--- On Mon, 2/1/12, Shubhrajyoti <shubhrajyoti@ti.com> wrote:

> > +    int  =20
>       =20
> pressed;    /* 1 =3D pressed, 0 =3D released */
> Could this be bool ?

OK.

> > +config MOUSE_NAVPOINT_PXA27x
> > +=A0=A0=A0 tristate "Synaptics NavPoint
> (PXA27x SSP/SPI)"
> > +=A0=A0=A0 depends on PXA27x &&
> PXA_SSP
> > +=A0=A0=A0 help
> > +=A0=A0=A0 =A0 This option enables support
> for the Synaptics NavPoint connected to
> > +=A0=A0=A0 =A0 a PXA27x SSP port in SPI
> slave mode. The driver implements a simple
> > +=A0=A0=A0 =A0 navigation pad. The four
> raised dots are mapped to UP/DOWN/LEFT/RIGHT
> > +=A0=A0=A0 =A0 buttons and the centre of
> the touchpad is mapped to the ENTER button.
> Maybe some help on module building as tristate.

OK.

> > +=A0=A0=A0 ret =3D request_irq(ssp->irq,
> navpoint_int, 0, pdev->name, &pdev->dev);
> Could this be a threadded irq?

The reading of the SSDR could not, because that is needed to clear the
interrupt.
The initial processing of navpoint_packet() could, but would require a =
new FIFO between the hard irq and threaded irq handlers to buffer the 1=
6-bit data from the SSDR. Since most of the data is ultimately discarde=
d I can avoid the FIFO by keeping this initial processing in the hard i=
rq handler.
The final processing of navpoint_packet(), the calls to input_report_ke=
y() and input_sync(), could and should. I presume this was your main co=
ncern.

> navpoint_resume(&pdev->dev);
> Could this be pushed to open instead?

It could. In practice the navpoint device would only be opened by the X=
 server, and thus would remain open for the duration of the system anyw=
ay.
But I'm happy to add a new open function.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
