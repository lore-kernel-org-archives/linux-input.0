From: Fuqian Huang <huangfq.daxian@gmail.com>
Subject: Re: [PATCH 2/4] input: keyboard/mouse/touchscreen/misc: Use dev_get_drvdata()
Date: Tue, 2 Jul 2019 19:47:16 +0800
Message-ID: <CABXRUiQ77feNzEdQ7GqNxLS9YAMybVG3eAWWSDPFdGvERaxCyg@mail.gmail.com>
References: <20190701032342.25971-1-huangfq.daxian@gmail.com>
 <20190701075255.GD172968@dtor-ws> <CABXRUiSO2Fos1V3hR5t3AviZ9Hit_y+E-Tp3PNOQj6-FKUBJBw@mail.gmail.com>
 <CAHp75VeUo2Au66tETo3zneBpeaVU+Y+-h5zghpo+hPuB=a6-eA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeUo2Au66tETo3zneBpeaVU+Y+-h5zghpo+hPuB=a6-eA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Vladimir Zapolskiy <vz@mleia.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>, Laxman Dewangan <ldewangan@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Olof Johansson <olof@lixom.net>, H Hartley Sweeten <hsweeten@visionengravers.com>, Arnd Bergmann <arnd@arndb.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Kate Stewart <kstewart@linuxfoundation.org>, Florian Fainelli <f.fainelli@gmail.com>
List-Id: linux-input@vger.kernel.org

Andy Shevchenko <andy.shevchenko@gmail.com> =E6=96=BC 2019=E5=B9=B47=E6=9C=
=882=E6=97=A5=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:51=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Tue, Jul 2, 2019 at 11:20 AM Fuqian Huang <huangfq.daxian@gmail.com> w=
rote:
> >
> > I am not an expert on this. I just write a coccinelle script to search
> > this kind of misuse and fix it in a naive way.
> > Could you tell me about how to use the proper bus accessors? Then I
> > will fix it up and resend a v2 patch set.
>
> First, don't top post.
> And answering to this, simple drop the patch.
> Proper bus accessors is exactly what it's used in the current code.

But why not use dev_get_drvdata directly.
It simplifies getting the 'driver_data' from 'struct device' directly.
And the platform_device here is not required.
Replace it can remove the unnecessary step back and forth. (dev -> pdev -> =
dev).

Just like the commit
ed835136ee67 ("mfd: Use dev_get_drvdata() directly")
1948d498dcf6("thermal: intel: int340x: processor_thermal_device:
simplify to get driver data")
and many other similar commits in the Linux git log.
