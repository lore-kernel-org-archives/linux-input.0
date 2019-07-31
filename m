From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 00/10] drivers, provide a way to add sysfs groups
 easily
Date: Wed, 31 Jul 2019 06:10:45 -0700
Message-ID: <20190731131045.GB147138@dtor-ws>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190731124349.4474-1-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, Richard Gong <richard.gong@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Borislav Petkov <bp@alien8.de>, Darren Hart <dvhart@infradead.org>, Florian Fainelli <f.fainelli@gmail.com>, Ingo Molnar <mingo@redhat.com>, Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Tony Prisk <linux@prisktech.co.nz>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, x86@kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 31, 2019 at 02:43:39PM +0200, Greg Kroah-Hartman wrote:
> This patch originally started out just as a way for platform drivers to
> easily add a sysfs group in a race-free way, but thanks to Dmitry's
> patch, this series now is for all drivers in the kernel (hey, a unified
> driver model works!!!)
> 
> I've only converted a few platform drivers here in this series to show
> how it works, but other busses can be converted after the first patch
> goes into the tree.
> 
> Here's the original 00 message, for people to get an idea of what is
> going on here:
> 
> If a platform driver wants to add a sysfs group, it has to do so in a
> racy way, adding it after the driver is bound.  To resolve this issue,
> have the platform driver core do this for the driver, making the
> individual drivers logic smaller and simpler, and solving the race at
> the same time.
> 
> All of these patches depend on the first patch.  I'll take the first one
> through my driver-core tree, and any subsystem maintainer can either ack
> their individul patch and I will be glad to also merge it, or they can
> wait until after 5.4-rc1 when the core patch hits Linus's tree and then
> take it, it's up to them.

Maybe make an immutable branch off 5.2 with just patch 1/10 so that
subsystems (and the driver core tree itself) could pull it in at their
leisure into their "*-next" branches and did not have to wait till 5.4
or risk merge clashes?

Thanks.

-- 
Dmitry
