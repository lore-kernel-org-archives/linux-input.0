From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Input: applespi: Fix build error without CONFIG_PCI
Date: Thu, 18 Jul 2019 13:56:55 +0200
Message-ID: <CAK8P3a09paRwS2ZEfvhxOdPAgjBz+9ZJ3Mv_kMaO5kSMV_Kadg@mail.gmail.com>
References: <20190718020654.39860-1-yuehaibing@huawei.com> <20190718114036.GA2872@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190718114036.GA2872@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: YueHaibing <yuehaibing@huawei.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Rob Herring <robh@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 18, 2019 at 1:40 PM Life is hard, and then you die
<ronald@innovation.ch> wrote:
> On Thu, Jul 18, 2019 at 10:06:54AM +0800, YueHaibing wrote:

> > @@ -74,7 +74,7 @@ config ATARI_KBD_CORE
> >  config KEYBOARD_APPLESPI
> >       tristate "Apple SPI keyboard and trackpad"
> >       depends on ACPI && EFI
> > -     depends on SPI
> > +     depends on SPI && PCI
> >       depends on X86 || COMPILE_TEST
> >       imply SPI_PXA2XX
> >       imply SPI_PXA2XX_PCI
> > --
> > 2.7.4
>
> I think this is more properly fixed by Dmitry's suggestion of making
> SPI_PXA2XX_PCI depend on PCI, since it's that module, not applespi,
> that actually needs PCI - see
> https://www.spinics.net/lists/linux-input/msg62351.html

I'll put that into my randconfig setup to see if it's sufficient. I'm
a little bit
suspicious as the circular dependency was not avoided by the 'depends
on X86' for MFD_INTEL_LPSS_PCI.

        Arnd
