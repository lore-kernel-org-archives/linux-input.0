From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: Re: [PATCH 2/4] input: keyboard/mouse/touchscreen/misc: Use dev_get_drvdata()
Date: Tue, 2 Jul 2019 16:18:32 +0800
Message-ID: <CABXRUiSO2Fos1V3hR5t3AviZ9Hit_y+E-Tp3PNOQj6-FKUBJBw@mail.gmail.com>
References: <20190701032342.25971-1-huangfq.daxian@gmail.com> <20190701075255.GD172968@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190701075255.GD172968@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Olof Johansson <olof@lixom.net>, H Hartley Sweeten <hsweeten@visionengravers.com>, Arnd Bergmann <arnd@arndb.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Florian Fainelli <f.fainelli@gmail.com>, Anson Huang <anson.huang@nxp.com>
List-Id: linux-input@vger.kernel.org

I am not an expert on this. I just write a coccinelle script to search
this kind of misuse and fix it in a naive way.
Could you tell me about how to use the proper bus accessors? Then I
will fix it up and resend a v2 patch set.

Thanks.

Dmitry Torokhov <dmitry.torokhov@gmail.com> =E6=96=BC 2019=E5=B9=B47=E6=9C=
=881=E6=97=A5=E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:52=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Hi Fuqian,
>
> On Mon, Jul 01, 2019 at 11:23:12AM +0800, Fuqian Huang wrote:
> > Using dev_get_drvdata directly.
> >
>
> I prefer using proper bus accessors.
>
> Thanks.
>
> --
> Dmitry
