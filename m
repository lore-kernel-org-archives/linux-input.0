From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 00/10] drivers, provide a way to add sysfs groups easily
Date: Wed, 31 Jul 2019 15:22:27 +0200
Message-ID: <20190731132227.GC12603@kroah.com>
References: <20190731124349.4474-1-gregkh@linuxfoundation.org>
 <20190731131045.GB147138@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190731131045.GB147138@dtor-ws>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: x86@kernel.org, linux-input@vger.kernel.org, linux-fbdev@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, platform-driver-x86@vger.kernel.org, Tony Prisk <linux@prisktech.co.nz>, Andy Shevchenko <andy.shevchenko@gmail.com>, Florian Fainelli <f.fainelli@gmail.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Darren Hart <dvhart@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Richard Gong <richard.gong@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Wed, Jul 31, 2019 at 06:10:45AM -0700, Dmitry Torokhov wrote:
> On Wed, Jul 31, 2019 at 02:43:39PM +0200, Greg Kroah-Hartman wrote:
> > This patch originally started out just as a way for platform drivers to
> > easily add a sysfs group in a race-free way, but thanks to Dmitry's
> > patch, this series now is for all drivers in the kernel (hey, a unified
> > driver model works!!!)
> > 
> > I've only converted a few platform drivers here in this series to show
> > how it works, but other busses can be converted after the first patch
> > goes into the tree.
> > 
> > Here's the original 00 message, for people to get an idea of what is
> > going on here:
> > 
> > If a platform driver wants to add a sysfs group, it has to do so in a
> > racy way, adding it after the driver is bound.  To resolve this issue,
> > have the platform driver core do this for the driver, making the
> > individual drivers logic smaller and simpler, and solving the race at
> > the same time.
> > 
> > All of these patches depend on the first patch.  I'll take the first one
> > through my driver-core tree, and any subsystem maintainer can either ack
> > their individul patch and I will be glad to also merge it, or they can
> > wait until after 5.4-rc1 when the core patch hits Linus's tree and then
> > take it, it's up to them.
> 
> Maybe make an immutable branch off 5.2 with just patch 1/10 so that
> subsystems (and the driver core tree itself) could pull it in at their
> leisure into their "*-next" branches and did not have to wait till 5.4
> or risk merge clashes?

Good idea, I will do that when I apply it after a few days to give
people a chance to review it.

thanks,

greg k-h
