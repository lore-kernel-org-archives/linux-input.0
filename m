From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 23:05:12 +0200
Message-ID: <5190668.jExaFa8pKn@wuerfel>
References: <201407130545.23004.marex@denx.de> <53C7B365.4080000@gmail.com>
 <53C834EA.5030605@tilera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53C834EA.5030605@tilera.com>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Chris Metcalf <cmetcalf@tilera.com>
Cc: linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, teg@jklm.no, Thierry Reding <thierry.reding@gmail.com>, Lennox Wu <lennox.wu@gmail.com>, linux-watchdog@vger.kernel.org, Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Richard Weinberger <richard@nod.at>, Geert Uytterhoeven <geert@linux-m68k.org>, msalter@redhat.com, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, devel@driverdev.osuosl.org, Chen Gang <gang.chen.5i5j@gmail.com>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, knaack.h@gmx.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Mischa.Jonker@synopsys.com, jic23@kernel.org
List-Id: linux-input@vger.kernel.org

On Thursday 17 July 2014 16:41:14 Chris Metcalf wrote:
> On 7/17/2014 7:28 AM, Chen Gang wrote:
> > On 07/17/2014 06:48 PM, Arnd Bergmann wrote:
> >> AFAICT, NO_IOMEM only has a real purpose on UML these days. Could we take
> >> a shortcut here and make COMPILE_TEST depend on !UML? Getting random stuff
> >> to build on UML seems pointless to me and we special-case it in a number of
> >> places already.
> >>
> > According to current source code, tile still has chance to choose
> > NO_IOMEM, for me, welcome the tile's maintainer's ideas or suggestions.
> 
> I'm not really sure.  It's true that on tile, if you don't enable PCI
> support there's no other I/O memory (or I/O port) space you can use.
> We pretty much always enable PCI support in our kernel, though.  I'm
> kind of surprised that other architectures don't also have the model
> that IOMEM requires PCI, but perhaps most architectures just don't
> encode that in the Kconfig file?

Only s390 as far as I know. Most architectures have integrated
peripherals that use MMIO without PCI.

> My observation is just that if I remove the "NO_IOMEM if !PCI" from
> arch/tile/Kconfig, my build fails with ioremap() undefined.  No doubt I
> could work around that, but my assumption was that NO_IOMEM was exactly the
> right thing to express the fact that without PCI there is no I/O memory 

Your assumption is correct.

For tile by itself it would certainly be best to leave this
dependency, it makes no sense to enable IOMEM without PCI.

That doesn't solve the problem of COMPILE_TEST enabling drivers
that require IOMEM though. An easy hack for that would be to
make COMPILE_TEST depend on HAS_IOMEM, but it gets into hacky territory
there, and it's not clear if this is any better than the original patch
to provide fallbacks for ioremap and friends. Definitely simpler
though.

	Arnd
