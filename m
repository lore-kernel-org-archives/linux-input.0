From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv6] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Mon, 24 Feb 2014 14:16:24 +0100
Message-ID: <201402241416.24270.jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <52CEA4AA.8050503@free-electrons.com> <201401100955.45885.jbe@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <201401100955.45885.jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Alexandre,

> While I don't have much experience with the TS part of the code but I
> can investigate if you don't have any idea.

can you please test the following patch?
After releasing the touchscreen the internal state machine was left in =
a
wrong state.

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/=
adc/mxs-lradc.c
index e2dd783..558a76c 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -698,6 +698,7 @@ static void mxs_lradc_finish_touch_event(struct mxs=
_lradc *lradc, bool valid)
        }

        /* if it is released, wait for the next touch via IRQ */
+       lradc->cur_plate =3D LRADC_TOUCH;
        mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_=
CTRL1);
        mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC=
_CTRL1);
 }

Regards,
Juergen

--=20
Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Juergen Beisert =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |
Linux Solutions for Science and Industry =C2=A0 =C2=A0 =C2=A0| Phone: +=
49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany =C2=A0 =C2=A0| Fax: =C2=A0 +=
49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| http://www.pengutronix.de/ =C2=A0|
