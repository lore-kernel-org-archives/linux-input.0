From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/2] iio: exynos-adc: add experimental touchscreen support
Date: Mon, 21 Jul 2014 12:23:58 +0200
Message-ID: <5158672.dMAnnUQc7Z@wuerfel>
References: <1405663186-26464-1-git-send-email-cw00.choi@samsung.com> <53CBC969.4090704@kernel.org> <20140720202842.GB18347@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20140720202842.GB18347@core.coreip.homeip.net>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-arm-kernel@lists.infradead.org, Chanwoo Choi <cw00.choi@samsung.com>, ch.naveen@samsung.com, mark.rutland@arm.com, devicetree@vger.kernel.org, kgene.kim@samsung.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, linux-iio@vger.kernel.org, t.figa@samsung.com, rdunlap@infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, kyungmin.park@samsung.com, robh+dt@kernel.org, galak@codeaurora.org, heiko.stuebner@bq.com, Ben Dooks <ben-linux@fluff.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sunday 20 July 2014 13:28:42 Dmitry Torokhov wrote:
> On Sun, Jul 20, 2014 at 02:51:37PM +0100, Jonathan Cameron wrote:
> > >>+
> > >>+    do {
> > >>+        ret =exynos_read_s3c64xx_ts(dev, NULL, &x, &y, IIO_CHAN_INFO_RAW);
> > >= exynos
> > >>+        if (ret == -ETIMEDOUT)
> > >>+            break;
> > >>+
> > >>+        pressed = x & y & ADC_DATX_PRESSED;
> > >>+        if (!pressed)
> > >>+            break;
> > >>+
> > >>+        input_report_abs(info->input, ABS_X, x & ADC_DATX_MASK);
> > >>+        input_report_abs(info->input, ABS_Y, y & ADC_DATX_MASK);
> > >>+        input_report_key(info->input, BTN_TOUCH, 1);
> > >>+        input_sync(info->input);
> > >>+
> > >>+        msleep(1);
> > >>+    } while (1);
> 
> It would be nice to actually close the device even if someone is
> touching screen. Please implement open/close methods and have them set a
> flag that you would check here.

Ok. I think it's even better to move the request_irq() into the open function,
which will avoid the flag and defer the error handling into the actual opening,
as well as syncing the running irq with the close function.

> > >>+    /* data from s3c2410_ts driver */
> > >>+    info->input->name = "S3C24xx TouchScreen";
> > >>+    info->input->id.bustype = BUS_HOST;
> > >>+    info->input->id.vendor = 0xDEAD;
> > >>+    info->input->id.product = 0xBEEF;
> 
> You do not need to fill these entries with fake data.

Ok, I wondered about this, but didn't want to change too much from
the old driver (I changed the version number).

> > >>+    info->input->id.version = 0x0200;

Do I need this?

> > >>@@ -576,6 +728,11 @@ static int exynos_adc_probe(struct platform_device *pdev)
> > >>  err_of_populate:
> > >>      device_for_each_child(&indio_dev->dev, NULL,
> > >>                  exynos_adc_remove_devices);
> > >>+    if (has_ts) {
> > >>+        input_unregister_device(info->input);
> > >>+        free_irq(info->tsirq, info);
> 
> Are we sure that device is quiesced here and interrupt won't arrive
> between input_unregister_device() and free_irq()? I guess if you
> properly implement open/close it won't matter.
 
Should be fixed now.

> > >>+err_iio:
> > >>      iio_device_unregister(indio_dev);
> > >>  err_irq:
> > >>      free_irq(info->irq, info);
> > >>@@ -595,9 +752,12 @@ static int exynos_adc_remove(struct platform_device *pdev)
> > >>      struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > >>      struct exynos_adc *info = iio_priv(indio_dev);
> > >>
> > >>+    input_free_device(info->input);
> 
> Should be unregister, not free.

Ok.

Thanks a lot for the review! I'll send out the new version after some build testing.

	Arnd
