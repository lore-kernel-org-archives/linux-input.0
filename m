From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V2 2/5] input: keyboard: imx_sc: Add i.MX system
 controller power key support
Date: Mon, 2 Sep 2019 23:12:14 -0700
Message-ID: <CAKdAkRRX4Cs1m7iwTuM0dpNr+xjp3qAZ1fo1pqreE7rR8KFgQQ@mail.gmail.com>
References: <1567519424-32271-1-git-send-email-Anson.Huang@nxp.com>
 <1567519424-32271-2-git-send-email-Anson.Huang@nxp.com> <CAOMZO5CHmvrbVG_h8hOb7hMjXasV_QwtNoXpEw9kqY=4Jj5HAg@mail.gmail.com>
 <DB3PR0402MB391636D31F486639FB8B3BA6F5B90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB3PR0402MB391636D31F486639FB8B3BA6F5B90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <anson.huang@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Andy Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, "mripard@kernel.org" <mripard@kernel.org>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Jagan Teki <jagan@amarulasolutions.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dinh Nguyen <dinguyen@kernel.org>, marcin
List-Id: linux-input@vger.kernel.org

On Mon, Sep 2, 2019 at 8:11 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Fabio
>
> > On Mon, Sep 2, 2019 at 11:05 PM Anson Huang <Anson.Huang@nxp.com>
> > wrote:
> >
> > > +       ret = input_register_device(input);
> > > +       if (ret < 0) {
> > > +               dev_err(&pdev->dev, "failed to register input device\n");
> > > +               return ret;
> > > +       }
> > > +
> > > +       pdata->input = input;
> > > +       platform_set_drvdata(pdev, pdata);
> > > +
> > > +       ret = imx_scu_irq_group_enable(SC_IRQ_GROUP_WAKE,
> > SC_IRQ_BUTTON, true);
> > > +       if (ret) {
> > > +               dev_warn(&pdev->dev, "enable scu group irq failed\n");
> > > +               return ret;
> >
> > Better do a 'goto input_unregister' here instead and call
> > input_unregister_device().
>
> Agreed, will fix in V3 later.

Not needed actually as input device is managed by devm.

Thanks.

-- 
Dmitry
