From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RFT V2 3/3] iio: mxs-lradc: implement suspend/resume
 support
Date: Mon, 25 Apr 2016 14:14:12 -0700
Message-ID: <20160425211412.GF26059@dtor-ws>
References: <1461269478-449-1-git-send-email-stefan.wahren@i2se.com>
 <1461269478-449-4-git-send-email-stefan.wahren@i2se.com>
 <20160421210810.GC25466@dtor-ws>
 <571A27FC.4030301@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <571A27FC.4030301-eS4NqCHxEME@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Fri, Apr 22, 2016 at 03:32:44PM +0200, Stefan Wahren wrote:
> Hi Dmitry,
> 
> Am 21.04.2016 um 23:08 schrieb Dmitry Torokhov:
> > On Thu, Apr 21, 2016 at 08:11:18PM +0000, Stefan Wahren wrote:
> >> This patch implements suspend/resume support for mxs-lradc.
> >> It's possible to use the touchscreen as wakeup source.
> >>
> >> Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> >> ---
> >>  drivers/iio/adc/mxs-lradc.c |   61 +++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 61 insertions(+)
> >>
> >> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> >> index cfc558f..6bd387f 100644
> >> --- a/drivers/iio/adc/mxs-lradc.c
> >> +++ b/drivers/iio/adc/mxs-lradc.c
> >> @@ -29,6 +29,7 @@
> >>  #include <linux/of.h>
> >>  #include <linux/of_device.h>
> >>  #include <linux/platform_device.h>
> >> +#include <linux/pm.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/stmp_device.h>
> >>  #include <linux/sysfs.h>
> >> @@ -1745,10 +1746,70 @@ static int mxs_lradc_remove(struct platform_device *pdev)
> >>  	return 0;
> >>  }
> >>  
> >> +static int __maybe_unused mxs_lradc_suspend(struct device *dev)
> >> +{
> >> +	struct iio_dev *iio = dev_get_drvdata(dev);
> >> +	struct mxs_lradc *lradc = iio_priv(iio);
> >> +	struct input_dev *input = lradc->ts_input;
> >> +	int ret = 0;
> >> +
> >> +	if (input) {
> >> +		mutex_lock(&input->mutex);
> >> +
> >> +		/* Enable touchscreen wakeup irq */
> >> +		if (input->users && device_may_wakeup(dev))
> >> +			ret = enable_irq_wake(lradc->irq[0]);
> >> +		else
> >> +			mxs_lradc_disable_ts(lradc);
> >> +
> >> +		mutex_unlock(&input->mutex);
> >> +	}
> >> +
> >> +	if (ret)
> >> +		return ret;
> > I'd rather we had it right after we do:
> >
> > 			ret = enable_irq_wake(lradc->irq[0]);
> 
> but we must unlock the mutex first before return. An option would be to
> place the return inside the input branch.

Ah, right, ignore me then.

-- 
Dmitry
