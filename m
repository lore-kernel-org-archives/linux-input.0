From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 8/9] MIPS: SGI-IP27: fix readb/writeb addressing
Date: Sun, 11 Aug 2019 09:29:07 +0200
Message-ID: <20190811072907.GA1416@kroah.com>
References: <20190809103235.16338-1-tbogendoerfer@suse.de>
 <20190809103235.16338-9-tbogendoerfer@suse.de>
 <CAHp75Vd_083R9sRsspVuJ3ZMTxpVR79PF5Lg-bpnMxRfN+b7wA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75Vd_083R9sRsspVuJ3ZMTxpVR79PF5Lg-bpnMxRfN+b7wA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Thomas Bogendoerfer <tbogendoerfer@suse.de>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@mips.com>, James Hogan <jhogan@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, "David S. Miller" <davem@davemloft.net>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jiri Slaby <jslaby@suse.com>, Evgeniy Polyakov <zbr@ioremap.net>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, netdev <netdev@vger.kernel.org>, "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" <linux-rtc@vger.kernel.org>, "open list:SERIAL DRIVERS" <linux-serial@v>
List-Id: linux-input@vger.kernel.org

On Sat, Aug 10, 2019 at 04:22:23PM +0300, Andy Shevchenko wrote:
> On Fri, Aug 9, 2019 at 1:34 PM Thomas Bogendoerfer
> <tbogendoerfer@suse.de> wrote:
> >
> > Our chosen byte swapping, which is what firmware already uses, is to
> > do readl/writel by normal lw/sw intructions (data invariance). This
> > also means we need to mangle addresses for u8 and u16 accesses. The
> > mangling for 16bit has been done aready, but 8bit one was missing.
> > Correcting this causes different addresses for accesses to the
> > SuperIO and local bus of the IOC3 chip. This is fixed by changing
> > byte order in ioc3 and m48rtc_rtc structs.
> 
> >  /* serial port register map */
> >  struct ioc3_serialregs {
> > -       uint32_t        sscr;
> > -       uint32_t        stpir;
> > -       uint32_t        stcir;
> > -       uint32_t        srpir;
> > -       uint32_t        srcir;
> > -       uint32_t        srtr;
> > -       uint32_t        shadow;
> > +       u32     sscr;
> > +       u32     stpir;
> > +       u32     stcir;
> > +       u32     srpir;
> > +       u32     srcir;
> > +       u32     srtr;
> > +       u32     shadow;
> >  };
> 
> Isn't it a churn? AFAIU kernel documentation the uint32_t is okay to
> use, just be consistent inside one module / driver.
> Am I mistaken?

No, but really it uint* shouldn't be used anywhere in the kernel source
as it does not make sense.

thanks,

greg k-h
