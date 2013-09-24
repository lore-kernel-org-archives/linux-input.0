From: =?utf-8?q?J=C3=BCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 1/9] Staging/iio/adc/touchscreen/MXS: add proper clock handling
Date: Tue, 24 Sep 2013 09:39:48 +0200
Message-ID: <201309240939.48094.jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <1379946998-23041-2-git-send-email-jbe@pengutronix.de> <21056.24202.312851.105281@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <21056.24202.312851.105281-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Lothar =?utf-8?q?Wa=C3=9Fmann?= <LW-AvR2QvxeiV7DiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Lothar,

On Monday 23 September 2013 17:30:18 Lothar Wa=C3=9Fmann wrote:
> > [...]
> > @@ -928,6 +931,9 @@ static int mxs_lradc_probe(struct platform_devi=
ce
> > *pdev) if (IS_ERR(lradc->base))
> >  		return PTR_ERR(lradc->base);
> >
> > +	lradc->clk =3D devm_clk_get(&pdev->dev, NULL);
> > +	clk_prepare_enable(lradc->clk);
> > +
>
> Wouldn't it make sense to enable the clock only when the device is
> opened to save power while not actually in use?

Sure. But I haven't analyzed yet if the IIO part of the driver also use=
s the=20
delay units and - more important - when it use them.

@Marek: can you tell us, where the clock should be enabled in your part=
 of the=20
driver (if required)?

BTW: do we also need to get and enable the 24 MHz clock (used by the AD=
C=20
itself)? I'm not sure if this clock is the "CLK_ANA24M" shown in=20
their "Logical Diagram of Clock Domains". The datasheets also mention=20
the "clk_xtal24m" clock for "analog 24 MHz clock domains". But does "Fi=
xed=20
clock domains" mean they are not switchable and thus always enabled?

Regards,
Juergen

--=20
Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Juergen Beisert =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
Linux Solutions for Science and Industry =C2=A0 =C2=A0 =C2=A0| http://w=
ww.pengutronix.de/  |
