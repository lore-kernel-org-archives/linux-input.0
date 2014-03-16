From: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 05/15] ARM: at91: sam9m10g45ek: Add touchscreen support
 through at91_adc
Date: Sun, 16 Mar 2014 21:00:24 +0100
Message-ID: <20140316200024.GL3106@piout.net>
References: <1394040940-18246-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1394040940-18246-6-git-send-email-alexandre.belloni@free-electrons.com>
 <5325EB01.5060700@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5325EB01.5060700-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On 16/03/2014 at 18:18:41 +0000, Jonathan Cameron wrote :
> On 05/03/14 17:35, Alexandre Belloni wrote:
> >at91_adc now supports reading a touchscreen for ADCs without a TSMR register.
> >Enable touchscreen support through at91_adc. This allows to use both a
> >touchscreen and the remaining ADC channel at the same time.
> >
> >Also, lower the clock for the ADC as it allows to have more stable reads and
> >this is the speed used by atmel_tsadcc.
> Are there any side effects on the adc read if that functionality was previously
> being used?  I doubt it matters, but probably wants to be mentioned here if there
> is.

Hum, it lowers the throughput rate but I really doubt anyone is trying
to achieve 440000 samples per second under linux ;) At that frequency,
we are still able to achieve 12958 samples per second so I guess this is
fine as from my experience, the CPU can't really keep up when reading
500 samples per seconds. I will include that in the commit log.

> >Signed-off-by: Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
> >---
> >  arch/arm/mach-at91/at91sam9g45.c        | 2 +-
> >  arch/arm/mach-at91/board-sam9m10g45ek.c | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> >diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
> >index 2f455ce35268..3c519a7a938f 100644
> >--- a/arch/arm/mach-at91/at91sam9g45.c
> >+++ b/arch/arm/mach-at91/at91sam9g45.c
> >@@ -181,7 +181,7 @@ static struct clk vdec_clk = {
> >  static struct clk adc_op_clk = {
> >  	.name		= "adc_op_clk",
> >  	.type		= CLK_TYPE_PERIPHERAL,
> >-	.rate_hz	= 13200000,
> >+	.rate_hz	= 300000,
> >  };
> >
> >  /* AES/TDES/SHA clock - Only for sam9m11/sam9g56 */
> >diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
> >index ef39078c8ce2..4d775b796ce4 100644
> >--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
> >+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
> >@@ -315,6 +315,7 @@ static struct at91_adc_data ek_adc_data = {
> >  	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7),
> >  	.use_external_triggers = true,
> >  	.vref = 3300,
> >+	.touchscreen_type = ATMEL_ADC_TOUCHSCREEN_4WIRE,
> >  };
> >
> >  /*
> >
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
