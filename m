From: Anson Huang <anson.huang@nxp.com>
Subject: RE: [PATCH] input: imx6ul_tsc: use devm_platform_ioremap_resource()
 to simplify code
Date: Sun, 28 Apr 2019 06:30:11 +0000
Message-ID: <DB3PR0402MB3916D9B009F5187D52A8A7D3F5380@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1554095712-15413-1-git-send-email-Anson.Huang@nxp.com>
 <d3b8cf17-36bb-d79d-7d60-76ae2416075d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <d3b8cf17-36bb-d79d-7d60-76ae2416075d@codeaurora.org>
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
To: Mukesh Ojha <mojha@codeaurora.org>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-input@vger.kernel.org

Ping...

> -----Original Message-----
> From: Mukesh Ojha [mailto:mojha@codeaurora.org]
> Sent: Monday, April 1, 2019 4:02 PM
> To: Anson Huang <anson.huang@nxp.com>; dmitry.torokhov@gmail.com;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; linux-input@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Cc: dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] input: imx6ul_tsc: use
> devm_platform_ioremap_resource() to simplify code
> 
> 
> On 4/1/2019 10:49 AM, Anson Huang wrote:
> > Use the new helper devm_platform_ioremap_resource() which wraps the
> > platform_get_resource() and devm_ioremap_resource() together, to
> > simplify the code.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> 
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
> 
> Cheers,
> -Mukesh
> 
> > ---
> >   drivers/input/touchscreen/imx6ul_tsc.c | 8 ++------
> >   1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/input/touchscreen/imx6ul_tsc.c
> > b/drivers/input/touchscreen/imx6ul_tsc.c
> > index c10fc59..e04eecd 100644
> > --- a/drivers/input/touchscreen/imx6ul_tsc.c
> > +++ b/drivers/input/touchscreen/imx6ul_tsc.c
> > @@ -364,8 +364,6 @@ static int imx6ul_tsc_probe(struct platform_device
> *pdev)
> >   	struct device_node *np = pdev->dev.of_node;
> >   	struct imx6ul_tsc *tsc;
> >   	struct input_dev *input_dev;
> > -	struct resource *tsc_mem;
> > -	struct resource *adc_mem;
> >   	int err;
> >   	int tsc_irq;
> >   	int adc_irq;
> > @@ -403,16 +401,14 @@ static int imx6ul_tsc_probe(struct
> platform_device *pdev)
> >   		return err;
> >   	}
> >
> > -	tsc_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > -	tsc->tsc_regs = devm_ioremap_resource(&pdev->dev, tsc_mem);
> > +	tsc->tsc_regs = devm_platform_ioremap_resource(pdev, 0);
> >   	if (IS_ERR(tsc->tsc_regs)) {
> >   		err = PTR_ERR(tsc->tsc_regs);
> >   		dev_err(&pdev->dev, "failed to remap tsc memory: %d\n",
> err);
> >   		return err;
> >   	}
> >
> > -	adc_mem = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > -	tsc->adc_regs = devm_ioremap_resource(&pdev->dev, adc_mem);
> > +	tsc->adc_regs = devm_platform_ioremap_resource(pdev, 1);
> >   	if (IS_ERR(tsc->adc_regs)) {
> >   		err = PTR_ERR(tsc->adc_regs);
> >   		dev_err(&pdev->dev, "failed to remap adc memory: %d\n",
> err);
