From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2 2/5] input: keyboard: imx_sc: Add i.MX system
 controller power key support
Date: Mon, 2 Sep 2019 23:38:54 -0300
Message-ID: <CAOMZO5CHmvrbVG_h8hOb7hMjXasV_QwtNoXpEw9kqY=4Jj5HAg@mail.gmail.com>
References: <1567519424-32271-1-git-send-email-Anson.Huang@nxp.com> <1567519424-32271-2-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567519424-32271-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Sascha Hauer <kernel@pengutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Fugang Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Leonard Crestez <leonard.crestez@nxp.com>, mripard@kernel.org, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Jagan Teki <jagan@amarulasolutions.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Dinh Nguyen <dinguyen@kernel.org>, marcin.juszkiewicz@linaro.org, Stefan Agner <stefan@agn>
List-Id: linux-input@vger.kernel.org

Hi Anson,

On Mon, Sep 2, 2019 at 11:05 PM Anson Huang <Anson.Huang@nxp.com> wrote:

> +       ret = input_register_device(input);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to register input device\n");
> +               return ret;
> +       }
> +
> +       pdata->input = input;
> +       platform_set_drvdata(pdev, pdata);
> +
> +       ret = imx_scu_irq_group_enable(SC_IRQ_GROUP_WAKE, SC_IRQ_BUTTON, true);
> +       if (ret) {
> +               dev_warn(&pdev->dev, "enable scu group irq failed\n");
> +               return ret;

Better do a 'goto input_unregister' here instead and call
input_unregister_device().
