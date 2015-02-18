From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 1/6] mfd: fsl imx25 Touchscreen ADC driver
Date: Wed, 18 Feb 2015 08:01:56 +0000
Message-ID: <20150218080156.GA5781@x1>
References: <1422108103-15052-1-git-send-email-mpa@pengutronix.de>
 <1422108103-15052-2-git-send-email-mpa@pengutronix.de>
 <20150216133829.GG14545@x1>
 <CAOMZO5AwbNeEhVgUuLUi-_QT0DesPBBCTvvebuA91y-P2_CNzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:51478 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbbBRICD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 03:02:03 -0500
Received: by mail-wg0-f54.google.com with SMTP id y19so40499499wgg.13
        for <linux-input@vger.kernel.org>; Wed, 18 Feb 2015 00:02:01 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAOMZO5AwbNeEhVgUuLUi-_QT0DesPBBCTvvebuA91y-P2_CNzg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Markus Pargmann <mpa@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Denis Carikli <denis@eukrea.com>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Sascha Hauer <kernel@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On Tue, 17 Feb 2015, Fabio Estevam wrote:

> On Mon, Feb 16, 2015 at 11:38 AM, Lee Jones <lee.jones@linaro.org> wr=
ote:
>=20
> >> +static int mx25_tsadc_setup_irq(struct platform_device *pdev,
> >> +                             struct mx25_tsadc *tsadc)
> >> +{
> >> +     struct device *dev =3D &pdev->dev;
> >> +     struct device_node *np =3D dev->of_node;
> >> +     int irq;
> >> +
> >> +     irq =3D platform_get_irq(pdev, 0);
> >> +     if (irq < 0) {
> >
> > What if 0 is returned?
>=20
> Then  imx25.dtsi would be passing irq=3D0 for the ADC, which would be
> totally wrong.

Exactly, so it should be <=3D.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
