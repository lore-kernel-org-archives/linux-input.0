From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Fri, 18 Jul 2014 09:35:53 +0200
Message-ID: <53C8CE59.3060103@nod.at>
References: <201407130545.23004.marex@denx.de> <6823014.2plXDE9VA9@wuerfel>
 <53C7A819.40403@metafoo.de> <6485666.LVFO2YCEQx@wuerfel>
 <53C8114D.30601@nod.at> <53C86C10.2000608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53C86C10.2000608@gmail.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Chen Gang <gang.chen.5i5j@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, devel@driverdev.osuosl.org, msalter@redhat.com, linux-watchdog@vger.kernel.org, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, jic23@kernel.org, teg@jklm.no, Thierry Reding <thierry.reding@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Lennox Wu <lennox.wu@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-input@vger.kernel.org, Mischa.Jonker@synopsys.com, Guenter Roeck <linux@roeck-us.net>, knaack.h@gmx.de
List-Id: linux-input@vger.kernel.org

Am 18.07.2014 02:36, schrieb Chen Gang:
> 
> On 07/18/2014 02:09 AM, Richard Weinberger wrote:
>> Am 17.07.2014 12:48, schrieb Arnd Bergmann:
>>> AFAICT, NO_IOMEM only has a real purpose on UML these days. Could we take
>>> a shortcut here and make COMPILE_TEST depend on !UML? Getting random stuff
>>> to build on UML seems pointless to me and we special-case it in a number of
>>> places already.
>>
>> If UML is the only arch without io memory the dependency on !UML seems
>> reasonable to me. :-)
>>
> 
> For me, if only uml left, I suggest to implement dummy functions within
> uml instead of let CONFIG_UML appear in generic include directory. And
> then remove all HAS_IOMEM and NO_IOMEM from kernel.

Erm, this is something completely different.
I thought we're focusing on COMPILE_TEST?

Thanks,
//richard
