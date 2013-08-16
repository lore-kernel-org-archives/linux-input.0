From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 4/4] iio: ti_am335x_adc: Add continuous sampling and
 trigger support
Date: Fri, 16 Aug 2013 12:17:14 +0200
Message-ID: <20130816101714.GE26895@linutronix.de>
References: <1376424303-22740-1-git-send-email-zubair.lutfullah@gmail.com>
 <1376424303-22740-5-git-send-email-zubair.lutfullah@gmail.com>
 <520CBEC6.8010400@kernel.org>
 <20130816100702.GD26895@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20130816100702.GD26895-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Zubair Lutfullah <zubair.lutfullah-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, Russ.Dill-l0cyMroinI0@public.gmane.org
List-Id: linux-input@vger.kernel.org

* Sebastian Andrzej Siewior | 2013-08-16 12:07:02 [+0200]:

>* Jonathan Cameron | 2013-08-15 12:43:02 [+0100]:
>
>It did apply with no trouble here.

and with

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 93129ec..fdd9810 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -156,6 +156,7 @@ config TI_ADC081C
 config TI_AM335X_ADC
 	tristate "TI's ADC driver"
 	depends on MFD_TI_AM335X_TSCADC
+	select IIO_TRIGGERED_BUFFER
 	help
 	  Say yes here to build support for Texas Instruments ADC
 	  driver which is also a MFD client.


it links :)

Sebastian
