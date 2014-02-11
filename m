From: Jingoo Han <jg1.han@samsung.com>
Subject: Re: [PATCH 6/7] Input: pwm-beepe: remove HAVE_PWM dependencies
Date: Tue, 11 Feb 2014 21:18:54 +0900
Message-ID: <000901cf2723$6e68bc10$4b3a3430$%han@samsung.com>
References: <003901cf25fc$73002790$590076b0$%han@samsung.com>
 <003f01cf25fd$b3e274b0$1ba75e10$%han@samsung.com> <52FA12D1.4020408@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <52FA12D1.4020408@metafoo.de>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'Lars-Peter Clausen' <lars@metafoo.de>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>
List-Id: linux-input@vger.kernel.org

On Tuesday, February 11, 2014 9:09 PM, Lars-Peter Clausen wrote:
> On 02/10/2014 02:16 AM, Jingoo Han wrote:
> > The HAVE_PWM symbol is only for legacy platforms that provide
> > the PWM API without using the generic framework. However, legacy
> > PWM drivers were already moved to the generic PWM framework.
> > Thus, HAVE_PWM should be removed, because HAVE_PWM is not
> > required anymore.
> >
> > Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> 
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Hi Lars-Peter Clausen,

I really appreciate your Acked-by. However, the same patch was
already submitted by Sascha Hauer.[1] So, please ignore this patch.
Thank you.

[1] https://lkml.org/lkml/2014/1/16/262

Best regards,
Jingoo Han

> 
> > ---
> >   drivers/input/misc/Kconfig |    2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> > index ae74df7..762e6d2 100644
> > --- a/drivers/input/misc/Kconfig
> > +++ b/drivers/input/misc/Kconfig
> > @@ -470,7 +470,7 @@ config INPUT_PCF8574
> >
> >   config INPUT_PWM_BEEPER
> >   	tristate "PWM beeper support"
> > -	depends on PWM && HAVE_PWM
> > +	depends on PWM
> >   	help
> >   	  Say Y here to get support for PWM based beeper devices.
> >
> >
