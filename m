From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 0/3] mfd: mc13xxx: Fixes and enhancements for NXP's
 mc34708
Date: Mon, 30 Sep 2019 10:21:34 +0200
Message-ID: <20190930082134.GB2036553@kroah.com>
References: <20190909214440.30674-1-lukma@denx.de>
 <20190930095159.64e1001a@jawa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190930095159.64e1001a@jawa>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Majewski <lukma@denx.de>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, Sep 30, 2019 at 09:51:59AM +0200, Lukasz Majewski wrote:
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

It's the middle of the merge window, 2 weeks where we can't add any new
code to any of our trees.  Please give people a chance...

greg k-h
