From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 12:28:28 +0200
Message-ID: <8453588.VVyODXRso0@wuerfel>
References: <201407130545.23004.marex@denx.de> <6823014.2plXDE9VA9@wuerfel>
 <53C796E1.8080708@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53C796E1.8080708@nod.at>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Richard Weinberger <richard@nod.at>
Cc: linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no, Thierry Reding <thierry.reding@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, linux-watchdog@vger.kernel.org, Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Geert Uytterhoeven <geert@linux-m68k.org>, msalter@redhat.com, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org, Chen Gang <gang.chen.5i5j@gmail.com>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday 17 July 2014 11:26:57 Richard Weinberger wrote:
> Am 17.07.2014 11:20, schrieb Arnd Bergmann:
> > On Thursday 17 July 2014 09:27:58 Chen Gang wrote:
> >>                                          gfp_t gfp_mask, unsigned int order);
> >>  extern void devm_free_pages(struct device *dev, unsigned long addr);
> >>  
> >> +#ifdef CONFIG_HAS_IOMEM
> >>  void __iomem *devm_ioremap_resource(struct device *dev, struct resource *res);
> >> +#elif defined(CONFIG_COMPILE_TEST)
> >> +static inline void __iomem *devm_ioremap_resource(struct device *dev,
> >> +                                               struct resource *res)
> >> +{
> >> +       pr_warn("no hardware io memory, only for COMPILE_TEST\n");
> >> +       return (__force void __iomem *)ERR_PTR(-ENXIO);
> >> +}
> >> +#endif /* CONFIG_HAS_IOMEM || CONFIG_COMPILE_TEST */
> >>  
> >>  /* allows to add/remove a custom action to devres stack */
> > 
> > To be honest, I think it's a bad idea to introduce wrappers functions
> > that are only available when CONFIG_COMPILE_TEST is set.
> > 
> > COMPILE_TEST is a great tool in general, but it has its limits.
> > In particular, the case for !CONFIG_IOMEM is completely obscure
> > and we won't find any bugs by allowing more drivers to be built
> > in those configurations, but attempting to do it would cause
> > endless churn by changing each instance of 'depends on HAS_IOMEM'
> > to 'depends on HAS_IOMEM || COMPILE_TEST'.
> > 
> > Note that s390 no has gained support for IOMEM, tile has it most
> > of the time (when PCI is enabled, so you get it in half the
> > test builds already), score should set HAS_IOMEM and doesn't
> > even have public compilers, and uml doesn't even compile in
> > latest mainline. Nothing else ever sets NO_IOMEM.
> 
> Huh? UML (v3.16-rc5-143-gb6603fe) builds fine here. What build issue are you facing?

This is what I got upon trying earlier. I have not attempted to look into
why this is happening. Note this is on linux-next from yesterday,
not mainline as I incorrectly stated above.

In file included from ../arch/um/include/asm/fixmap.h:58:0,
                 from ../arch/um/include/asm/pgtable.h:11,
                 from ../include/linux/mm.h:51,
                 from ../kernel/uid16.c:6:
../include/asm-generic/fixmap.h: In function 'fix_to_virt':
../include/asm-generic/fixmap.h:31:2: error: size of unnamed array is negative
  BUILD_BUG_ON(idx >= __end_of_fixed_addresses);


	Arnd
