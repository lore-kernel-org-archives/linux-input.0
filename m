From: Lennox Wu <lennox.wu@gmail.com>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Fri, 18 Jul 2014 23:37:21 +0800
Message-ID: <CAF0htA6Vvp+d4=wPuqJJhT+FxEUoT9mbJ3_NQuEJTP-hniS-KQ@mail.gmail.com>
References: <201407130545.23004.marex@denx.de> <6823014.2plXDE9VA9@wuerfel>
 <53C7A819.40403@metafoo.de> <6485666.LVFO2YCEQx@wuerfel>
 <53C8114D.30601@nod.at> <53C86C10.2000608@gmail.com>
 <53C8CE59.3060103@nod.at> <53C8FA78.1020501@gmail.com>
 <53C8FC1E.9090003@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53C8FC1E.9090003@nod.at>
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
Cc: linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Tom Gundersen <teg@jklm.no>, Thierry Reding <thierry.reding@gmail.com>, linux-watchdog@vger.kernel.org, Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Geert Uytterhoeven <geert@linux-m68k.org>, msalter@redhat.com, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org, Chen Gang <gang.chen.5i5j@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org
List-Id: linux-input@vger.kernel.org

Score can provide dummy functions if HAS_IOMEM  and NO_IOMEM will be
removed, even if we indeed have no IOMEM.

Best,
Lennox

2014-07-18 18:51 GMT+08:00 Richard Weinberger <richard@nod.at>:
> Am 18.07.2014 12:44, schrieb Chen Gang:
>> On 07/18/2014 03:35 PM, Richard Weinberger wrote:
>>> Am 18.07.2014 02:36, schrieb Chen Gang:
>>>>
>>>> On 07/18/2014 02:09 AM, Richard Weinberger wrote:
>>>>> Am 17.07.2014 12:48, schrieb Arnd Bergmann:
>>>>>> AFAICT, NO_IOMEM only has a real purpose on UML these days. Could we take
>>>>>> a shortcut here and make COMPILE_TEST depend on !UML? Getting random stuff
>>>>>> to build on UML seems pointless to me and we special-case it in a number of
>>>>>> places already.
>>>>>
>>>>> If UML is the only arch without io memory the dependency on !UML seems
>>>>> reasonable to me. :-)
>>>>>
>>>>
>>>> For me, if only uml left, I suggest to implement dummy functions within
>>>> uml instead of let CONFIG_UML appear in generic include directory. And
>>>> then remove all HAS_IOMEM and NO_IOMEM from kernel.
>>>
>>> Erm, this is something completely different.
>>> I thought we're focusing on COMPILE_TEST?
>>>
>>
>> COMPILE_TEST is none-architecture specific, but UML is. So in generic
>> include folder, if we're focusing on choosing whether COMPILE_TEST or
>> UML, for me, I will choose COMPILE_TEST.
>>
>> If we're not only focusing on COMPILE_TEST, for me, if something only
>> depend on one architecture, I'd like to put them under "arch/*/" folder.
>>
>> Especially, after that, we can remove all HAS_IOMEM and NO_IOMEM, nobody
>> has to think of them again. :-)
>
> And then we end up with a solution that on UML a lot of completely useless
> drivers are build which fail in various interesting manners because you'll
> add stubs for all kinds of io memory related functions to arch/um/?
> We had this kind of discussion already. You'll need more than ioremap...
>
> I like Arnd's idea *much* more to make COMPILE_TEST depend on !UML.
>
> Thanks,
> //richard
