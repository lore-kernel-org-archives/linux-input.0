From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/4] input: keyboard/mouse/touchscreen/misc: Use
 dev_get_drvdata()
Date: Tue, 2 Jul 2019 12:51:25 +0300
Message-ID: <CAHp75VeUo2Au66tETo3zneBpeaVU+Y+-h5zghpo+hPuB=a6-eA@mail.gmail.com>
References: <20190701032342.25971-1-huangfq.daxian@gmail.com>
 <20190701075255.GD172968@dtor-ws>
 <CABXRUiSO2Fos1V3hR5t3AviZ9Hit_y+E-Tp3PNOQj6-FKUBJBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CABXRUiSO2Fos1V3hR5t3AviZ9Hit_y+E-Tp3PNOQj6-FKUBJBw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fuqian Huang <huangfq.daxian@gmail.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Tony Lindgren <tony@atomide.com>, Richard Fontana <rfontana@redhat.com>, Laxman Dewangan <ldewangan@nvidia.com>, Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Anson Huang <anson.huang@nxp.com>, Lee Jones <lee.jones@linaro.org>, Jonathan Hunter <jonathanh@nvidia.com>, Luca Weiss <luca@z3ntu.xyz>, NXP Linux Team <linux-imx@nxp.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Brian Masney <masneyb@onstation.org>, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, linux-input <linux-input@vger.kernel.org>, Vladimir Zapolskiy <vz@mleia.com>, Alexios Zavras <alexios.zavras@intel.com>, linux-tegra@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Allison
List-Id: linux-input@vger.kernel.org

On Tue, Jul 2, 2019 at 11:20 AM Fuqian Huang <huangfq.daxian@gmail.com> wrote:
>
> I am not an expert on this. I just write a coccinelle script to search
> this kind of misuse and fix it in a naive way.
> Could you tell me about how to use the proper bus accessors? Then I
> will fix it up and resend a v2 patch set.

First, don't top post.
And answering to this, simple drop the patch.
Proper bus accessors is exactly what it's used in the current code.


-- 
With Best Regards,
Andy Shevchenko
