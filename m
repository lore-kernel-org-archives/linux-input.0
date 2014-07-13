From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] drivers: Let several drivers depends on HAS_IOMEM for
 'devm_ioremap_resource'
Date: Sun, 13 Jul 2014 13:17:53 -0700
Message-ID: <20140713201753.GA29955@kroah.com>
References: <201407130545.23004.marex@denx.de>
 <CAF0htA60juBVkPo2HQKMDGcEr-wRzRVL_6JgHAa+7WVE_E8M0Q@mail.gmail.com>
 <53C25551.1050909@nod.at> <53C288F0.3070001@metafoo.de>
 <53C28C4A.70907@nod.at> <53C29015.5070607@metafoo.de>
 <53C291C8.6050303@nod.at> <53C296C2.30304@metafoo.de>
 <20140713192202.GA19090@kroah.com> <53C2DF12.6040507@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <53C2DF12.6040507@nod.at>
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
Cc: Marek Vasut <marex@denx.de>, Liqin Chen <liqin.linux@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Chen Gang <gang.chen.5i5j@gmail.com>, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, dmitry.torokhov@gmail.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, teg@jklm.no, Martin Schwidefsky <schwidefsky@de.ibm.com>, thierry.reding@gmail.com, jic23@kernel.org, msalter@redhat.com, knaack.h@gmx.de, devel@driverdev.osuosl.org, linux-input@vger.kernel.org, Mischa.Jonker@synopsys.com, Lennox Wu <lennox.wu@gmail.com>, linux-watchdog@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Jul 13, 2014 at 09:33:38PM +0200, Richard Weinberger wrote:
> Am 13.07.2014 21:22, schrieb Greg Kroah-Hartman:
> > On Sun, Jul 13, 2014 at 04:25:06PM +0200, Lars-Peter Clausen wrote:
> >> On 07/13/2014 04:03 PM, Richard Weinberger wrote:
> >>> Am 13.07.2014 15:56, schrieb Lars-Peter Clausen:
> >>>> On 07/13/2014 03:40 PM, Richard Weinberger wrote:
> >>>>> Am 13.07.2014 15:26, schrieb Lars-Peter Clausen:
> >>>>>> On 07/13/2014 11:45 AM, Richard Weinberger wrote:
> >>>>>>> Am 13.07.2014 11:27, schrieb Lennox Wu:
> >>>>>>>> As I said before, some configurations don't make sense.
> >>>>>>>
> >>>>>>> If such a configuration can be achieved using allmod/yesconfig it has to be fixed.
> >>>>>>> Chen's fixes seem reasonable as not all architectures support iomem.
> >>>>>>
> >>>>>> Maybe we should stub out ioremap() and friends when COMPILE_TEST is enabled to avoid these linker errors. That's in my opinion better than turning most of the 'depends on
> >>>>>> COMPILE_TEST' into 'depends on COMPILE_TEST && HAS_IOMEM'. The issue comes up quite a lot and it is often overlooked when adding a driver that can be build when COMPILE_TEST is
> >>>>>> enabled.
> >>>>>
> >>>>> And what should this stub do?
> >>>>> Except calling BUG()...
> >>>>
> >>>> return NULL;
> >>>>
> >>>> It's for compile testing, it's not meant to work at runtime.
> >>>
> >>> Hm, I really don't like the idea of having a non-working kernel.
> >>> IMHO either it should build _and_ run and nothing else.
> >>> Greg, what do you think?
> >>
> >> The kernel will still be working fine and you can run it on a system. The
> >> drivers which use ioremap() or similar are probably not instantiated on a
> >> system that does not provide HAS_IOMEM. But even if it was the driver should
> >> handle ioremap() returning NULL gracefully and abort the driver probe. That
> >> said you'll probably not run a kernel that was built with COMPILE_TEST on
> >> your real hardware since it contains so many drivers that are completely
> >> useless on your hardware. The idea of COMPILE_TEST is to have as much
> >> compile test exposure as possible to the code that is enabled by
> >> COMPILE_TEST. Stubbing out ioremap() and friends when HAS_IOMEM is not set
> >> and COMPILE_TEST is set makes it easier to get there.
> > 
> > I run my kernels with COMPILE_TEST enabled as I need to build test
> > things that I don't happen to use.
> > 
> > I like the 'return NULL' option for this, it hits us all the time, might
> > as well fix it properly like this so that we don't have to deal with
> > Kconfig changes everywhere.
> > 
> > Also put a big "This platform does not support IOMEM" error printk in
> > there, so that people have a chance to figure out what is going on if
> > they happen to run such a driver on a platform that can't support it.
> 
> Maybe we could add COMPILE_TEST to the version string too?
> Just to detect such kernels fast in user bug reports...

What kind of bug report are you going to get?
