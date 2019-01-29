From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] input: goodix - support Goodix gt5688
Date: Tue, 29 Jan 2019 11:30:53 +0100
Message-ID: <12e21befacf68861ddf34020838ff7a6e6e078ad.camel@hadess.net>
References: <20190128170310.GA305@bogon.m.sigxcpu.org>
         <7e289e6b3410a3fdea99d7d6becfe5180a69f0c5.camel@hadess.net>
         <20190129091651.GA8497@bogon.m.sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190129091651.GA8497@bogon.m.sigxcpu.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Tue, 2019-01-29 at 10:16 +0100, Guido Günther wrote:
> Hi,
> On Mon, Jan 28, 2019 at 07:24:33PM +0100, Bastien Nocera wrote:
> > On Mon, 2019-01-28 at 18:03 +0100, Guido Günther wrote:
> > > From what I've seen in vendor trees it's fine to treat this as
> > > gt1x¹.
> > > 
> > > [1]: 
> > > https://github.com/TadiT7/android_kernel_mtk-4.4/tree/master/drivers/input/touchscreen/mediatek/GT5688
> > 
> > Can you please point to the exact line of code that makes you say
> > that?
> > I'm not saying it's not compatible, but it's not the same driver
> > that
> > the current goodix.c was based on, or even goodix.c.
> > 
> > Can you please elaborate?
> 
> I basically looked at the registers uses for the config update:
> 
> https://github.com/TadiT7/android_kernel_mtk-4.4/blob/master/drivers/input/touchscreen/mediatek/GT5688/include/gt1x_tpd_common.h#L152
> https://github.com/TadiT7/android_kernel_mtk-4.4/blob/master/drivers/input/touchscreen/mediatek/GT5688/gt1x_generic.c#L430

I'm not sure that's good enough to say that the touchscreen models are
compatible.

> That and the fact that the driver is doing it's job well made me
> believe
> that's good for base support.

If you've tested it, that's better. Can you please add a reference to
the device that you've tested this on in the commit message?

>  Things like hotknot, gesture wakeup and
> proximity sensor will need additional work.
> 
> > Finding that data in the specs would also be fine:
> > https://github.com/hadess/gt9xx/tree/master/specifications
> 
> https://github.com/hadess/gt9xx/pull/3

Merged that, thanks

Cheers
