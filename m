From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 12:58:55 +0200
Message-ID: <53C7AC6F.1070001@nod.at>
References: <201407130545.23004.marex@denx.de> <6823014.2plXDE9VA9@wuerfel> <53C796E1.8080708@nod.at> <8453588.VVyODXRso0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pwm-owner@vger.kernel.org>
In-Reply-To: <8453588.VVyODXRso0@wuerfel>
Sender: linux-pwm-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chen Gang <gang.chen.5i5j@gmail.com>, Guenter Roeck <linux@roeck-us.net>, Lars-Peter Clausen <lars@metafoo.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no, Thierry Reding <thierry.reding@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, msalter@redhat.com, linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org, linux-watchdog@vger.kernel.org, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

Am 17.07.2014 12:28, schrieb Arnd Bergmann:
> On Thursday 17 July 2014 11:26:57 Richard Weinberger wrote:
>> Am 17.07.2014 11:20, schrieb Arnd Bergmann:
>>> On Thursday 17 July 2014 09:27:58 Chen Gang wrote:
>>>>                                          gfp_t gfp_mask, unsigned =
int order);
>>>>  extern void devm_free_pages(struct device *dev, unsigned long add=
r);
>>>> =20
>>>> +#ifdef CONFIG_HAS_IOMEM
>>>>  void __iomem *devm_ioremap_resource(struct device *dev, struct re=
source *res);
>>>> +#elif defined(CONFIG_COMPILE_TEST)
>>>> +static inline void __iomem *devm_ioremap_resource(struct device *=
dev,
>>>> +                                               struct resource *r=
es)
>>>> +{
>>>> +       pr_warn("no hardware io memory, only for COMPILE_TEST\n");
>>>> +       return (__force void __iomem *)ERR_PTR(-ENXIO);
>>>> +}
>>>> +#endif /* CONFIG_HAS_IOMEM || CONFIG_COMPILE_TEST */
>>>> =20
>>>>  /* allows to add/remove a custom action to devres stack */
>>>
>>> To be honest, I think it's a bad idea to introduce wrappers functio=
ns
>>> that are only available when CONFIG_COMPILE_TEST is set.
>>>
>>> COMPILE_TEST is a great tool in general, but it has its limits.
>>> In particular, the case for !CONFIG_IOMEM is completely obscure
>>> and we won't find any bugs by allowing more drivers to be built
>>> in those configurations, but attempting to do it would cause
>>> endless churn by changing each instance of 'depends on HAS_IOMEM'
>>> to 'depends on HAS_IOMEM || COMPILE_TEST'.
>>>
>>> Note that s390 no has gained support for IOMEM, tile has it most
>>> of the time (when PCI is enabled, so you get it in half the
>>> test builds already), score should set HAS_IOMEM and doesn't
>>> even have public compilers, and uml doesn't even compile in
>>> latest mainline. Nothing else ever sets NO_IOMEM.
>>
>> Huh? UML (v3.16-rc5-143-gb6603fe) builds fine here. What build issue=
 are you facing?
>=20
> This is what I got upon trying earlier. I have not attempted to look =
into
> why this is happening. Note this is on linux-next from yesterday,
> not mainline as I incorrectly stated above.
>=20
> In file included from ../arch/um/include/asm/fixmap.h:58:0,
>                  from ../arch/um/include/asm/pgtable.h:11,
>                  from ../include/linux/mm.h:51,
>                  from ../kernel/uid16.c:6:
> ../include/asm-generic/fixmap.h: In function 'fix_to_virt':
> ../include/asm-generic/fixmap.h:31:2: error: size of unnamed array is=
 negative
>   BUILD_BUG_ON(idx >=3D __end_of_fixed_addresses);

So, this is next-20140716?
I don't see the fixmap issue you're reporting, also not on the most rec=
ent next.

All I see is the known ext4 issue with CONFIG_SMP=3Dn:

fs/ext4/super.c: In function =91ext4_commit_super=92:
fs/ext4/super.c:4547:41: error: =91struct percpu_counter=92 has no memb=
er named =91counters=92
  if (EXT4_SB(sb)->s_freeclusters_counter.counters)
                                         ^
fs/ext4/super.c:4551:39: error: =91struct percpu_counter=92 has no memb=
er named =91counters=92
  if (EXT4_SB(sb)->s_freeinodes_counter.counters)

Thanks,
//richard
