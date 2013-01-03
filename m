From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2 1/3] Input: imx_keypad - Add device tree support
Date: Thu, 3 Jan 2013 15:11:00 +0800
Message-ID: <20130103071058.GA2566@S2101-09.ap.freescale.net>
References: <1357010475-7331-1-git-send-email-Ying.Liu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1357010475-7331-1-git-send-email-Ying.Liu@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Liu Ying <Ying.Liu@freescale.com>
Cc: broonie@opensource.wolfsonmicro.com, linux@arm.linux.org.uk, linux-doc@vger.kernel.org, liu.y.victor@gmail.com, s.hauer@pengutronix.de, dmitry.torokhov@gmail.com, rob.herring@calxeda.com, grant.likely@secretlab.ca, rob@landley.net, linux-input@vger.kernel.org, cjb@laptop.org, linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 01, 2013 at 11:21:13AM +0800, Liu Ying wrote:
> +#ifdef CONFIG_OF
> +static inline int imx_keypad_check_dt(struct platform_device *pdev)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +#else
> +static inline int imx_keypad_check_dt(struct platform_device *pdev)
> +{
> +	return -ENODEV;
> +}
> +#endif
> +
>  static int imx_keypad_probe(struct platform_device *pdev)
>  {
>  	const struct matrix_keymap_data *keymap_data = pdev->dev.platform_data;
>  	struct imx_keypad *keypad;
>  	struct input_dev *input_dev;
>  	struct resource *res;
> -	int irq, error, i;
> +	int irq, error, i, row, col, row_shift;
>  
> -	if (keymap_data == NULL) {
> +	if (keymap_data == NULL && imx_keypad_check_dt(pdev)) {

Shouldn't the following just equally work?
	
	if (keymap_data == NULL && pdev->dev.of_node == NULL) {

Shawn

>  		dev_err(&pdev->dev, "no keymap defined\n");
>  		return -EINVAL;
>  	}
