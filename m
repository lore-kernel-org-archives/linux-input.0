From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/4] input: keyboard/mouse/touchscreen/misc: Use
 dev_get_drvdata()
Date: Wed, 3 Jul 2019 07:17:46 +0100
Message-ID: <20190703061746.GI4652@dell>
References: <20190701032342.25971-1-huangfq.daxian@gmail.com>
 <20190701075255.GD172968@dtor-ws>
 <CABXRUiSO2Fos1V3hR5t3AviZ9Hit_y+E-Tp3PNOQj6-FKUBJBw@mail.gmail.com>
 <CAHp75VeUo2Au66tETo3zneBpeaVU+Y+-h5zghpo+hPuB=a6-eA@mail.gmail.com>
 <CABXRUiQ77feNzEdQ7GqNxLS9YAMybVG3eAWWSDPFdGvERaxCyg@mail.gmail.com>
 <20190702143225.12b0fe07@karo-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190702143225.12b0fe07@karo-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Fuqian Huang <huangfq.daxian@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Kate Stewart <kstewart@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Richard Fontana <rfontana@redhat.com>, Laxman Dewangan <ldewangan@nvidia.com>, Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Anson Huang <anson.huang@nxp.com>, Jonathan Hunter <jonathanh@nvidia.com>, Luca Weiss <luca@z3ntu.xyz>, NXP Linux Team <linux-imx@nxp.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Brian Masney <masneyb@onstation.org>, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input <linux-input@vger.kernel.org>, Vladimir
List-Id: linux-input@vger.kernel.org

On Tue, 02 Jul 2019, Lothar Waßmann wrote:

> Hi,
> 
> On Tue, 2 Jul 2019 19:47:16 +0800 Fuqian Huang wrote:
> > Andy Shevchenko <andy.shevchenko@gmail.com> 於 2019年7月2日週二 下午5:51寫道：
> > >
> > > On Tue, Jul 2, 2019 at 11:20 AM Fuqian Huang <huangfq.daxian@gmail.com> wrote:  
> > > >
> > > > I am not an expert on this. I just write a coccinelle script to search
> > > > this kind of misuse and fix it in a naive way.
> > > > Could you tell me about how to use the proper bus accessors? Then I
> > > > will fix it up and resend a v2 patch set.  
> > >
> > > First, don't top post.
> > > And answering to this, simple drop the patch.
> > > Proper bus accessors is exactly what it's used in the current code.  
> > 
> > But why not use dev_get_drvdata directly.
> > It simplifies getting the 'driver_data' from 'struct device' directly.
> > And the platform_device here is not required.
> > Replace it can remove the unnecessary step back and forth. (dev -> pdev -> dev).
> > 
> Did you check whether the compiler generates different (better) code
> with and without your patch? My guess is it won't.

I can see Fuqian's point.  If bus APIs are preferred, maybe it would
be nicer if the function was adapted to accept a platform_device
instead?

Caveat: I haven't taken the time to look into the call-site details.
	This comment is based on just the patch alone.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
