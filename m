From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/3] mfd: dm355evm_msp: move header file out of I2C realm
Date: Mon, 14 Aug 2017 07:43:36 +0100
Message-ID: <20170814064336.secnn77amfjgbltw@dell>
References: <20170521220212.1404-1-wsa@the-dreams.de>
 <20170521220212.1404-2-wsa@the-dreams.de>
 <20170523071727.tw6vblpnevihqgqk@dell>
 <20170813133418.e7lftrmry3gu3dcc@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170813133418.e7lftrmry3gu3dcc@ninjato>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Sun, 13 Aug 2017, Wolfram Sang wrote:

> On Tue, May 23, 2017 at 08:17:27AM +0100, Lee Jones wrote:
> > On Mon, 22 May 2017, Wolfram Sang wrote:
> > 
> > > include/linux/i2c is not for client devices. Move the header file to a
> > > more appropriate location.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > ---
> > >  drivers/input/misc/dm355evm_keys.c        | 2 +-
> > 
> > >  drivers/mfd/dm355evm_msp.c                | 2 +-
> > 
> > For my own reference:
> >   Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> 
> Does that mean it will be in 4.14? Or is something else needed?

Can this patch be applied on its own, or does it have dependencies?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
