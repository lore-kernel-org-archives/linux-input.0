From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH 1/2] atmel_tsadcc: Device driver for AT91SAM9RL Touchscreen
Date: Thu, 5 Jun 2008 15:49:51 +0200
Message-ID: <20080605154951.2d32d106@hskinnemo-gx745.norway.atmel.com>
References: <1209149798-20418-1-git-send-email-justin.waters@timesys.com>
	<1209149798-20418-2-git-send-email-justin.waters@timesys.com>
	<20080425211041.GC28497@flint.arm.linux.org.uk>
	<1209159453.6990.48.camel@justin-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1209159453.6990.48.camel@justin-linux>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: Justin Waters <justin.waters@timesys.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "linux@maxim.org.za" <linux@maxim.org.za>
List-Id: linux-input@vger.kernel.org

Justin Waters <justin.waters@timesys.com> wrote:
> On Fri, 2008-04-25 at 17:10 -0400, Russell King - ARM Linux wrote:
> > > +config TOUCHSCREEN_ATMEL_TSADCC
> > > +     tristate "Atmel Touchscreen Interface"  
> > 
> > No dependencies.  So does this mean this'll build and link on an
> > x86 platform?
> >   
> I was actually thinking that this IP will end up on an AVR32 platform as
> well, so I intentionally tried to avoid making the driver too ARM
> specific.  However, I definitely see the point of specifying
> ARCH_AT91SAM9RL and worrying about adding additional support for new
> platforms later, so I'll add that in.

Thanks for thinking about AVR32 as well :-)

I think adding a dependency on AT91 is the right thing to do for now. We
can always patch in "|| AVR32" later if/when this IP finds its way into
an AVR32 chip.

Though it looks like the only thing this driver uses that isn't
available on x86 is the clk API, so perhaps it would be best to depend
on HAVE_CLK assuming this patch gets merged:

http://lkml.org/lkml/2008/5/29/367

This would give the driver much better compile-testing coverage by
people who do allyesconfig builds and such on different platforms.

Haavard

-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
