From: Robin Gong <yibin.gong@nxp.com>
Subject: RE: [PATCH] input: keyboard: snvs_pwrkey: Send press and release
 event for i.MX6 S,DL and Q
Date: Tue, 27 Aug 2019 06:17:52 +0000
Message-ID: <VE1PR04MB6638754916357F551502102589A00@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <20190823123002.10448-1-robin@protonic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190823123002.10448-1-robin@protonic.nl>
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
To: Robin van der Gracht <robin@protonic.nl>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Adam Ford <aford173@gmail.com>, Fabio Estevam <festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-input@vger.kernel.org

On Fri, Aug 23, 2019 at 02:30:02PM +0200, Robin van der Gracht wrote:> 
> The older generation i.MX6 processors send a powerdown request interrupt
> if the powerkey is released before a hard shutdown (5 second press). This
> should allow software to bring down the SoC safely.
> 
> For this driver to work as a regular powerkey with the older SoCs, we need to
> send a keypress AND release when we get the powerdown request interrupt.
Please clarify here more clearly that because there is NO press interrupt triggered
but only release interrupt on elder i.mx6 processors and that HW issue fixed from
i.mx6sx.
> 
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> ---
>  arch/arm/boot/dts/imx6qdl.dtsi       |  2 +-
>  arch/arm/boot/dts/imx6sll.dtsi       |  2 +-
>  arch/arm/boot/dts/imx6sx.dtsi        |  2 +-
>  arch/arm/boot/dts/imx6ul.dtsi        |  2 +-
>  arch/arm/boot/dts/imx7s.dtsi         |  2 +-
As Shawn talked, please keep the original "fsl,sec-v4.0-pwrkey", just add
'imx6qdl-snvs-pwrkey' for elder i.mx6 processor i.mx6q/dl/sl, thus no need
to touch other newer processor's dts.

> 
>  static void imx_imx_snvs_check_for_events(struct timer_list *t) @@ -67,13
> +85,23 @@ static irqreturn_t imx_snvs_pwrkey_interrupt(int irq, void
> *dev_id)  {
>  	struct platform_device *pdev = dev_id;
>  	struct pwrkey_drv_data *pdata = platform_get_drvdata(pdev);
> +	struct input_dev *input = pdata->input;
>  	u32 lp_status;
> 
> -	pm_wakeup_event(pdata->input->dev.parent, 0);
> +	pm_wakeup_event(input->dev.parent, 0);
> 
>  	regmap_read(pdata->snvs, SNVS_LPSR_REG, &lp_status);
> -	if (lp_status & SNVS_LPSR_SPO)
> -		mod_timer(&pdata->check_timer, jiffies +
> msecs_to_jiffies(DEBOUNCE_TIME));
> +	if (lp_status & SNVS_LPSR_SPO) {
> +		if (pdata->hwtype == IMX6QDL_SNVS) {
> +			input_report_key(input, pdata->keycode, 1);
> +			input_report_key(input, pdata->keycode, 0);
> +			input_sync(input);
> +			pm_relax(input->dev.parent);
Could you move the above input event report steps into imx_imx_snvs_check_for_events()
as before? That make code better to understand and less operation in ISR.
> +		} else {
> +			mod_timer(&pdata->check_timer,
> +				jiffies + msecs_to_jiffies(DEBOUNCE_TIME));
> +		}
> +	}
> 
>  	/* clear SPO status */
>  	regmap_write(pdata->snvs, SNVS_LPSR_REG, SNVS_LPSR_SPO); @@
> -88,11 +116,24 @@ static void imx_snvs_pwrkey_act(void *pdata)
>  	del_timer_sync(&pd->check_timer);
>  }
> 
> +static const struct of_device_id imx_snvs_pwrkey_ids[] = {
> +	{
> +		.compatible = "fsl,imx6sx-sec-v4.0-pwrkey",
> +		.data = &imx_snvs_devtype[IMX6SX_SNVS],
> +	}, {
> +		.compatible = "fsl,imx6qdl-sec-v4.0-pwrkey",
> +		.data = &imx_snvs_devtype[IMX6QDL_SNVS],
No ' IMX6QDL_SNVS ' defined in your patch or am I missing?
> +	},
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_snvs_pwrkey_ids);
> --
> 2.20.1
