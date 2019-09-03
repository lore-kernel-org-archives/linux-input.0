From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH V2 2/5] input: keyboard: imx_sc: Add i.MX system
 controller power key support
Date: Tue, 3 Sep 2019 03:11:35 +0000
Message-ID: <DB3PR0402MB391636D31F486639FB8B3BA6F5B90@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1567519424-32271-1-git-send-email-Anson.Huang@nxp.com>
 <1567519424-32271-2-git-send-email-Anson.Huang@nxp.com>
 <CAOMZO5CHmvrbVG_h8hOb7hMjXasV_QwtNoXpEw9kqY=4Jj5HAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5CHmvrbVG_h8hOb7hMjXasV_QwtNoXpEw9kqY=4Jj5HAg@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>, Jacky Bai <ping.bai@nxp.com>, Catalin Marinas <catalin.marinas@arm.com>, Peng Fan <peng.fan@nxp.com>, Stefan Agner <stefan@agner.ch>, Bjorn Andersson <bjorn.andersson@linaro.org>, Leonard Crestez <leonard.crestez@nxp.com>, "will@kernel.org" <will@kernel.org>, "yuehaibing@huawei.com" <yuehaibing@huawei.com>, "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>, Jagan Teki <jagan@amarulasolutions.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "ronald@innovation.ch" <ronald@innovation.ch>, dl-linux-imx <linux-imx@nxp.com>, "open list:OPEN
 FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Sascha Hauer <s.hauer@pengutronix.de>, "mripard@kernel.org" <mripard@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>, Rob
List-Id: linux-input@vger.kernel.org

Hi, Fabio

> On Mon, Sep 2, 2019 at 11:05 PM Anson Huang <Anson.Huang@nxp.com>
> wrote:
> 
> > +       ret = input_register_device(input);
> > +       if (ret < 0) {
> > +               dev_err(&pdev->dev, "failed to register input device\n");
> > +               return ret;
> > +       }
> > +
> > +       pdata->input = input;
> > +       platform_set_drvdata(pdev, pdata);
> > +
> > +       ret = imx_scu_irq_group_enable(SC_IRQ_GROUP_WAKE,
> SC_IRQ_BUTTON, true);
> > +       if (ret) {
> > +               dev_warn(&pdev->dev, "enable scu group irq failed\n");
> > +               return ret;
> 
> Better do a 'goto input_unregister' here instead and call
> input_unregister_device().

Agreed, will fix in V3 later.

Thanks,
Anson.
