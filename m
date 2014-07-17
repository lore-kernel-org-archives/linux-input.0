From: Chen Gang <gang.chen.5i5j-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 17:29:31 +0800
Message-ID: <53C7977B.9090903@gmail.com>
References: <201407130545.23004.marex@denx.de> <53C53CE1.4090803@gmail.com> <53C7269E.4010702@gmail.com> <6823014.2plXDE9VA9@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <6823014.2plXDE9VA9@wuerfel>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>, Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>, teg-B22kvLQNl6c@public.gmane.org, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lennox Wu <lennox.wu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, Liqin Chen <liqin.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, msalter-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devel-gWbeCf7V1WCQmaza687I9mD2FQJk+8+b@public.gmane.org, linux-watchdog-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, knaack.h-Mmb7MZpHnFY@public.gmane.org, Martin Schwidefsky <schwidefsky-tA70FqPdS9bQT0dZR+AlfA@public.gmane.org>, Mischa.Jonker-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
List-Id: linux-input@vger.kernel.org



On 07/17/2014 05:20 PM, Arnd Bergmann wrote:
> On Thursday 17 July 2014 09:27:58 Chen Gang wrote:
>>                                          gfp_t gfp_mask, unsigned int order);
>>  extern void devm_free_pages(struct device *dev, unsigned long addr);
>>  
>> +#ifdef CONFIG_HAS_IOMEM
>>  void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
>> +#elif defined(CONFIG_COMPILE_TEST)
>> +static inline void __iomem *devm_ioremap_resource(struct device *dev,
>> +                                               struct resource *res)
>> +{
>> +       pr_warn("no hardware io memory, only for COMPILE_TEST\n");
>> +       return (__force void __iomem *)ERR_PTR(-ENXIO);
>> +}
>> +#endif /* CONFIG_HAS_IOMEM || CONFIG_COMPILE_TEST */
>>  
>>  /* allows to add/remove a custom action to devres stack */
> 
> To be honest, I think it's a bad idea to introduce wrappers functions
> that are only available when CONFIG_COMPILE_TEST is set.
> 
> COMPILE_TEST is a great tool in general, but it has its limits.
> In particular, the case for !CONFIG_IOMEM is completely obscure
> and we won't find any bugs by allowing more drivers to be built
> in those configurations, but attempting to do it would cause
> endless churn by changing each instance of 'depends on HAS_IOMEM'
> to 'depends on HAS_IOMEM || COMPILE_TEST'.
>

Architecture members and driver members really have different tastes,
they are different roles. It really need additional discussion.

For me, I only want to change devm_io*map*, not touch so much.

Welcome any other members' idea or suggestions.

> Note that s390 no has gained support for IOMEM, tile has it most
> of the time (when PCI is enabled, so you get it in half the
> test builds already), score should set HAS_IOMEM and doesn't
> even have public compilers, and uml doesn't even compile in
> latest mainline. Nothing else ever sets NO_IOMEM.
> 

In latest gcc and binutils, can compile score cross compiler
successfully for building kernel (but I am not quite sure whether the
compiling result are really OK, but I guess so).

And next (maybe after finish allmodconfig for microblaze), I shall try
to let uml pass allmodconfig for linux-next tree.

Thanks.
-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
