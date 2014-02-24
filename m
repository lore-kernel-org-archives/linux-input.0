From: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH] staging/iio/adc/MXS/LRADC: fix touchscreen statemachine
Date: Mon, 24 Feb 2014 15:39:53 +0100
Message-ID: <201402241539.53707.jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de> <201402241416.24270.jbe@pengutronix.de> <20140224133316.GI26722@mwanda>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140224133316.GI26722@mwanda>
Content-Disposition: inline
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, marex-ynQEQJNshbs@public.gmane.org, fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Releasing the touchscreen lets the internal statemachine left in a wron=
g state.
Due to this the release coordinate will be reported again by accident w=
hen the next
touchscreen event happens. This change sets up the correct state when w=
aiting
for the next touchscreen event.
   =20
Signed-off-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/=
adc/mxs-lradc.c
index 7fc66a6..514844e 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -757,6 +757,7 @@ static void mxs_lradc_finish_touch_event(struct mxs=
_lradc *lradc, bool valid)
 	}
=20
 	/* if it is released, wait for the next touch via IRQ */
+	lradc->cur_plate =3D LRADC_TOUCH;
 	mxs_lradc_reg_clear(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ, LRADC_CTRL1)=
;
 	mxs_lradc_reg_set(lradc, LRADC_CTRL1_TOUCH_DETECT_IRQ_EN, LRADC_CTRL1=
);
 }

--=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| http://www.pengut=
ronix.de/  |
