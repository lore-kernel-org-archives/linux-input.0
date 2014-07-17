From: Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 20:09:17 +0200
Message-ID: <53C8114D.30601@nod.at>
References: <201407130545.23004.marex@denx.de> <6823014.2plXDE9VA9@wuerfel>
 <53C7A819.40403@metafoo.de> <6485666.LVFO2YCEQx@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <6485666.LVFO2YCEQx@wuerfel>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Arnd Bergmann <arnd@arndb.de>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no, Thierry Reding <thierry.reding@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, linux-watchdog@vger.kernel.org, Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, msalter@redhat.com, Guenter Roeck <linux@roeck-us.net>, devel@driverdev.osuosl.org, Chen Gang <gang.chen.5i5j@gmail.com>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org
List-Id: linux-input@vger.kernel.org

Am 17.07.2014 12:48, schrieb Arnd Bergmann:
> AFAICT, NO_IOMEM only has a real purpose on UML these days. Could we take
> a shortcut here and make COMPILE_TEST depend on !UML? Getting random stuff
> to build on UML seems pointless to me and we special-case it in a number of
> places already.

If UML is the only arch without io memory the dependency on !UML seems
reasonable to me. :-)

Thanks,
//richard
