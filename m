From: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH v2 5/5] mfd: mt6397: Add PMIC keys support to MT6397
 driver
Date: Fri, 11 Aug 2017 15:18:28 +0800
Message-ID: <1502435908.28466.21.camel@mhfsdcap03>
References: <1502071065-6745-1-git-send-email-chen.zhong@mediatek.com>
         <1502071065-6745-6-git-send-email-chen.zhong@mediatek.com>
         <20170808111556.dmx2s6bcwnsccrkn@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170808111556.dmx2s6bcwnsccrkn@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Jaechul Lee <jcsing.lee-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rtc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Tue, 2017-08-08 at 12:15 +0100, Lee Jones wrote:
> On Mon, 07 Aug 2017, Chen Zhong wrote:
> 
> > This patch adds compatible strings and interrupts for pmic keys
> > which serves as child device of MFD.
> > 
> > Signed-off-by: Chen Zhong <chen.zhong-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/mfd/mt6397-core.c |   36 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 35 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > index 6546d7f..3c6a765 100644
> > --- a/drivers/mfd/mt6397-core.c
> > +++ b/drivers/mfd/mt6397-core.c
> > @@ -43,6 +43,30 @@
> >  	},
> >  };
> >  
> > +static const struct resource mt6323_keys_resources[] = {
> > +	{
> > +		.start = MT6323_IRQ_STATUS_PWRKEY,
> > +		.end   = MT6323_IRQ_STATUS_PWRKEY,
> > +		.flags = IORESOURCE_IRQ,
> > +	}, {
> > +		.start = MT6323_IRQ_STATUS_FCHRKEY,
> > +		.end   = MT6323_IRQ_STATUS_FCHRKEY,
> > +		.flags = IORESOURCE_IRQ,
> > +	},
> > +};
> > +
> > +static const struct resource mt6397_keys_resources[] = {
> > +	{
> > +		.start = MT6397_IRQ_PWRKEY,
> > +		.end   = MT6397_IRQ_PWRKEY,
> > +		.flags = IORESOURCE_IRQ,
> > +	}, {
> > +		.start = MT6397_IRQ_HOMEKEY,
> > +		.end   = MT6397_IRQ_HOMEKEY,
> > +		.flags = IORESOURCE_IRQ,
> > +	},
> > +};
> 
> We have better ways to define these now.
> 
> Please grep for "DEFINE_RES_"

I'll define these with "DEFINE_RES_IRQ" here, Thank you for your
suggestion.

> 
> >  static const struct mfd_cell mt6323_devs[] = {
> >  	{
> >  		.name = "mt6323-regulator",
> > @@ -50,6 +74,11 @@
> >  	}, {
> >  		.name = "mt6323-led",
> >  		.of_compatible = "mediatek,mt6323-led"
> > +	}, {
> > +		.name = "mtk-pmic-keys",
> > +		.num_resources = ARRAY_SIZE(mt6323_keys_resources),
> > +		.resources = mt6323_keys_resources,
> > +		.of_compatible = "mediatek,mt6323-keys"
> >  	},
> >  };
> >  
> > @@ -71,7 +100,12 @@
> >  	}, {
> >  		.name = "mt6397-pinctrl",
> >  		.of_compatible = "mediatek,mt6397-pinctrl",
> > -	},
> > +	}, {
> > +		.name = "mtk-pmic-keys",
> > +		.num_resources = ARRAY_SIZE(mt6397_keys_resources),
> > +		.resources = mt6397_keys_resources,
> > +		.of_compatible = "mediatek,mt6397-keys"
> > +	}
> >  };
> >  
> >  static void mt6397_irq_lock(struct irq_data *data)
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
