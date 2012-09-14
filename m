From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 5/5] MFD: ti_tscadc: add suspend/resume functionality
Date: Fri, 14 Sep 2012 04:59:21 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E953CC3@DBDE01.ent.ti.com>
References: <1347532819-505-1-git-send-email-rachna@ti.com>
 <1347532819-505-6-git-send-email-rachna@ti.com> <5051D92F.1090309@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5051D92F.1090309-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dtor-JGs/UdohzUI@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Thu, Sep 13, 2012 at 18:31:35, Lars-Peter Clausen wrote:
> On 09/13/2012 12:40 PM, Patil, Rachna wrote:
> > This patch adds support for suspend/resume of TSC/ADC MFDevice.
> > 
> > Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
> > ---
> > Changes in v2:
> > 	Added this patch newly in this patch series.
> > 
> > Changes in v3:
> > 	No changes.
> > 
> >  drivers/iio/adc/ti_adc.c           |   32 ++++++++++++++++++++++++++++++++
> >  drivers/input/touchscreen/ti_tsc.c |   33 +++++++++++++++++++++++++++++++++
> >  drivers/mfd/ti_tscadc.c            |   33 ++++++++++++++++++++++++++++++++-
> >  include/linux/mfd/ti_tscadc.h      |    3 +++
> >  4 files changed, 100 insertions(+), 1 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ti_adc.c b/drivers/iio/adc/ti_adc.c index 
> > 56f8af2..69f19f0 100644
> > --- a/drivers/iio/adc/ti_adc.c
> > +++ b/drivers/iio/adc/ti_adc.c
> > @@ -207,6 +207,36 @@ static int __devexit tiadc_remove(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> [...]
> >  static struct platform_driver tiadc_driver = {
> >  	.driver = {
> >  		.name   = "tiadc",
> > @@ -214,6 +244,8 @@ static struct platform_driver tiadc_driver = {
> >  	},
> >  	.probe	= tiadc_probe,
> >  	.remove	= __devexit_p(tiadc_remove),
> > +	.suspend = adc_suspend,
> > +	.resume = adc_resume,
> >  };
> >  
> 
> 
> Using the suspend/resume callbacks is deprecated, please use dev_pm_ops.
> Same comment applies to the other two drivers.

Ok. I will make changes in all the 3 driver to use dev_pm_ops instead of suspend/resume callbacks.

Regards,
Rachna

> 
> 
> 
