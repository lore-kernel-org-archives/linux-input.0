From: Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v2 8/8] ARM: LPC32xx: Device tree support
Date: Wed, 18 Apr 2012 14:30:20 +0200
Message-ID: <4F8EB3DC.3060203@antcom.de>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de> <1334682507-15055-9-git-send-email-stigge@antcom.de> <20120418060230.GC17506@avionic-0098.adnet.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20120418060230.GC17506-RM9K5IK7kjIyiCvfTdI0JKcOhU4Rzj621B7CTYaBSLdn68oJJulU0Q@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: arm-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, axel.lin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, kevin.wells-3arQi8VN3Tc@public.gmane.org, srinivas.bakki-3arQi8VN3Tc@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Thierry,

thanks for your suggestions.

On 04/18/2012 08:02 AM, Thierry Reding wrote:
>> arch/arm/mach-lpc32xx/irq.c                           |   78
>> +++++--
> 
> Could this perhaps be split into another patch. Basically this is
> a conversion to IRQ domain *and* device tree support. But maybe it
> isn't worth the effort.

I was thinking the same. :-) Specifically, using
irq_domain_add_legacy() already builds upon available DT nodes. DT for
irq in turn seems to require irqdomain. So  would only split those two
on explicit request of reviewers when we have a reasonable solution to
this dilemma. Otherwise, I'd keep it in one patch.

>> arch/arm/mach-lpc32xx/phy3250.c                       |  146
>> +++++--------
> 
> While at it, this should probably be renamed board-dt.c or
> something similar since it is no longer phy3250 specific.

As Arnd wrote, there are board specific bits left (open questions
about how to DT'ize spi's controller_data, and DT-conversion of AMBA
CLCD). However, I will move board-independent stuff over to common.c.
(Keeping lpc32xx_auxdata_lookup[] in phy3250.c due to remaining
platform_data, though.)

>> -	platform_add_devices(phy3250_devs, ARRAY_SIZE(phy3250_devs)); -
>> for (i = 0; i < ARRAY_SIZE(amba_devs); i++) { -		struct
>> amba_device *d = amba_devs[i]; -		amba_device_register(d,
>> &iomem_resource); -	} +	tmp =
>> __raw_readl(LPC32XX_CLKPWR_DMA_CLK_CTRL); +	__raw_writel((tmp |
>> LPC32XX_CLKPWR_DMACLKCTRL_CLK_EN), +
>> LPC32XX_CLKPWR_DMA_CLK_CTRL); /* Test clock needed for UDA1380
>> initial init */ __raw_writel(LPC32XX_CLKPWR_TESTCLK2_SEL_MOSC | 
>> LPC32XX_CLKPWR_TESTCLK_TESTCLK2_EN, 
>> LPC32XX_CLKPWR_TEST_CLK_SEL);
> 
> A lot of these seem to be gratuitous here. Can control of these
> clocks not be exposed via the clock framework? That would allow the
> controllers to only activate them when actually needed. This could
> also be done in follow up patches, though.

Correct, clock framework is on my list of following patches.

> 
> [...]
>> +	/* Register GPIOs used on this board */ +	if
>> (gpio_request(SPI0_CS_GPIO, "spi0 cs")) +		printk(KERN_ERR "Error
>> requesting gpio %u", +			SPI0_CS_GPIO); +	else if
>> (gpio_direction_output(SPI0_CS_GPIO, 1)) +		printk(KERN_ERR
>> "Error setting gpio %u to output", +			SPI0_CS_GPIO);
> 
> This should be initialized based on data from the device tree.

Correct. This will be done in the later patch regarding spi controller
DT conversion. Still discussing this with Grant. For now, I'm
considering the above hunk as just moving around the resp. lines
without change. Please let me keep it until the SPI issue is solved.

Thanks,

Roland
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
