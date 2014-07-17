From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Thu, 17 Jul 2014 13:24:46 +0200
Message-ID: <5581945.I7Fc5qufcE@wuerfel>
References: <201407130545.23004.marex@denx.de> <8453588.VVyODXRso0@wuerfel>
 <53C7AC6F.1070001@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <53C7AC6F.1070001@nod.at>
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

On Thursday 17 July 2014 12:58:55 Richard Weinberger wrote:
> > This is what I got upon trying earlier. I have not attempted to look into
> > why this is happening. Note this is on linux-next from yesterday,
> > not mainline as I incorrectly stated above.
> > 
> > In file included from ../arch/um/include/asm/fixmap.h:58:0,
> >                  from ../arch/um/include/asm/pgtable.h:11,
> >                  from ../include/linux/mm.h:51,
> >                  from ../kernel/uid16.c:6:
> > ../include/asm-generic/fixmap.h: In function 'fix_to_virt':
> > ../include/asm-generic/fixmap.h:31:2: error: size of unnamed array is negative
> >   BUILD_BUG_ON(idx >= __end_of_fixed_addresses);
> 
> So, this is next-20140716?
> I don't see the fixmap issue you're reporting, also not on the most recent next.

Sorry, nevermind. I had a workaround for a gcc-4.9 bug applied that
turned off optimization for uid16.c, which fixed the build for ARM for
me but happened to break x86 including uml.

Without that patch, I don't see this problem.

	Arnd
