From: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 1/5] mfd: mt6397: create irq mappings in mfd core
 driver
Date: Tue, 8 Aug 2017 17:09:55 +0800
Message-ID: <1502183395.28466.5.camel@mhfsdcap03>
References: <1502071065-6745-1-git-send-email-chen.zhong@mediatek.com>
         <1502071065-6745-2-git-send-email-chen.zhong@mediatek.com>
         <20170807213244.7hrd3isq5jj44dgd@piout.net>
         <20170808025328.GB12328@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170808025328.GB12328@dtor-ws>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, 2017-08-07 at 19:53 -0700, Dmitry Torokhov wrote:
> On Mon, Aug 07, 2017 at 11:32:44PM +0200, Alexandre Belloni wrote:
> > On 07/08/2017 at 09:57:41 +0800, Chen Zhong wrote:
> > > The core driver should create and manage irq mappings instead of
> > > leaf drivers. This patch change to pass irq domain to
> > > devm_mfd_add_devices() and it will create mapping for irq resources
> > > automatically. And remove irq mapping in rtc driver since this has
> > > been done in core driver.
> > > 
> > > Signed-off-by: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > For the RTC part:
> > Acked-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> > 
> > > ---
> > >  drivers/mfd/mt6397-core.c |    4 ++--
> > >  drivers/rtc/rtc-mt6397.c  |    2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > > index 04a601f..6546d7f 100644
> > > --- a/drivers/mfd/mt6397-core.c
> > > +++ b/drivers/mfd/mt6397-core.c
> > > @@ -289,7 +289,7 @@ static int mt6397_probe(struct platform_device *pdev)
> > >  
> > >  		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6323_devs,
> > >  					   ARRAY_SIZE(mt6323_devs), NULL,
> > > -					   0, NULL);
> > > +					   0, pmic->irq_domain);
> > >  		break;
> > >  
> > >  	case MT6397_CID_CODE:
> > > @@ -304,7 +304,7 @@ static int mt6397_probe(struct platform_device *pdev)
> > >  
> > >  		ret = devm_mfd_add_devices(&pdev->dev, -1, mt6397_devs,
> > >  					   ARRAY_SIZE(mt6397_devs), NULL,
> > > -					   0, NULL);
> > > +					   0, pmic->irq_domain);
> > >  		break;
> > >  
> > >  	default:
> > > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > > index 1a61fa5..22c52f7 100644
> > > --- a/drivers/rtc/rtc-mt6397.c
> > > +++ b/drivers/rtc/rtc-mt6397.c
> > > @@ -323,7 +323,7 @@ static int mtk_rtc_probe(struct platform_device *pdev)
> > >  	rtc->addr_base = res->start;
> > >  
> > >  	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> > > -	rtc->irq = irq_create_mapping(mt6397_chip->irq_domain, res->start);
> > > +	rtc->irq = res->start;
> 
> Why not
> 
> 	rtc->irq = platform_get_irq(pdev, 0);
> 	if (rtc->irq < 0)
> 		return rtc->irq;
> ?
> 
> This way you propagate error properly.
> 
> Thanks.
> 

Hi Dmitry,

	I'll modify it to get irq number via this way.

Thank you.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
