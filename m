From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 0/3] mfd: mc13xxx: Fixes and enhancements for NXP's
 mc34708
Date: Tue, 1 Oct 2019 07:41:30 +0100
Message-ID: <20191001064130.GA11769@dell>
References: <20190909214440.30674-1-lukma@denx.de>
 <20190930095159.64e1001a@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190930095159.64e1001a@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-input@vger.kernel.org

On Mon, 30 Sep 2019, Lukasz Majewski wrote:

> Dear Lee,
> 
> > This patch set provides several enhancements to mc13xxx MFD family
> > of devices by introducing mc34708 as a separate device.
> > 
> > This IC has dedicated pen detection feature, which allows better
> > touchscreen experience.
> > 
> > This is the fifth version of this code (v5).
> > Discussion regarding previous versions can be found here:
> > https://lkml.org/lkml/2018/4/12/351
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1661934.html
> > https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1664296.html
> > https://lkml.org/lkml/2019/7/17/705
> 
> Gentle ping on this patch series. It is now 3 weeks without any reply...

Please take note and follow the kernel release cycle.

These patches were sent after the release of -rc7 i.e. very late
in the release cycle and a point where most kernel maintainers stop
reviewing/applying patches and start to prepare for the impending
merge-window.

Also, there is no such thing as a gentle ping.  If you genuinely think
your patches have unlikely("slipped though the gaps"), then post a
[RESEND] complete with a note alluding your reasons doing such.

> > Sascha Hauer (3):
> >   mfd: mc13xxx: Add mc34708 adc support
> >   input: touchscreen mc13xxx: Make platform data optional
> >   input: touchscreen mc13xxx: Add mc34708 support
> > 
> >  drivers/input/touchscreen/mc13783_ts.c | 63 ++++++++++++++---
> >  drivers/mfd/mc13xxx-core.c             | 98
> > +++++++++++++++++++++++++- include/linux/mfd/mc34708.h            |
> > 37 ++++++++++ 3 files changed, 185 insertions(+), 13 deletions(-)
> >  create mode 100644 include/linux/mfd/mc34708.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
