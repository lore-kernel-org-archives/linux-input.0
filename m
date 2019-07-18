From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] Input: applespi: Fix build error without CONFIG_PCI
Date: Thu, 18 Jul 2019 14:34:09 +0200
Message-ID: <CAK8P3a2Bi4xChuQH+buFtw+ODeDHPiPX=KqOuRNb9L2Koy8yYA@mail.gmail.com>
References: <20190718020654.39860-1-yuehaibing@huawei.com> <CAK8P3a2H0o+_3Y_J3r=D5_hGCArTYeHPfPPjY3dJ+ArmqYrOfQ@mail.gmail.com>
 <20190718115827.GB2872@innovation.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190718115827.GB2872@innovation.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: "Life is hard, and then you die" <ronald@innovation.ch>
Cc: YueHaibing <yuehaibing@huawei.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hartley Sweeten <hsweeten@visionengravers.com>, Rob Herring <robh@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Jul 18, 2019 at 1:58 PM Life is hard, and then you die
<ronald@innovation.ch> wrote:
> On Thu, Jul 18, 2019 at 09:15:59AM +0200, Arnd Bergmann wrote:
> > On Thu, Jul 18, 2019 at 4:07 AM YueHaibing <yuehaibing@huawei.com> wrote:
> > Your patch correctly solves the spi_pxa2xx issue, but I'd prefer to instead
> > drop the three 'imply' statements altogether, they seem to do more harm
> > than good.
> >
> > (the circular dependency I saw might only happen when applying the
> > arm32 KASAN patches, but I expect to see them merged for linux-5.4)
>
> Isn't there more generally a problem here that this is selecting
> MFD_INTEL_LPSS_PCI even though that depends on X86? I.e. are both ARM
> and X86 selected at the same time? (sorry if I'm being naïve, but I
> assumed only one arch can be selected at a time)

You can't have ARM and X86 defined at the same time, but Kconfig does
not know that, it just sees X86 as an undefined symbol, and ARM as
as always-enabled symbol when building for ARM.

In theory, 'imply' should deal with that and have no effect when there
are missing dependencies, but it appears that this only works for
deciding whether to turn on MFD_INTEL_LPSS_PCI, not for figuring
out loops in the dependency chain.

       Arnd
