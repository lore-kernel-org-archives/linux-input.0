From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] input: keyboard/mouse/touchscreen/misc: Use
 dev_get_drvdata()
Date: Mon, 1 Jul 2019 00:52:55 -0700
Message-ID: <20190701075255.GD172968@dtor-ws>
References: <20190701032342.25971-1-huangfq.daxian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190701032342.25971-1-huangfq.daxian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Olof Johansson <olof@lixom.net>, H Hartley Sweeten <hsweeten@visionengravers.com>, Arnd Bergmann <arnd@arndb.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Florian Fainelli <f.fainelli@gmail.com>, Anson Huang <anson.huang@nxp.com>
List-Id: linux-input@vger.kernel.org

Hi Fuqian,

On Mon, Jul 01, 2019 at 11:23:12AM +0800, Fuqian Huang wrote:
> Using dev_get_drvdata directly.
> 

I prefer using proper bus accessors.

Thanks.

-- 
Dmitry
