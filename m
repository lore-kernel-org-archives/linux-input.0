From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 7/8] Input: olpc_apsp: enable the SP clock
Date: Wed, 10 Oct 2018 10:09:01 -0700
Message-ID: <20181010170901.GC47260@dtor-ws>
References: <20181010142504.233467-1-lkundrak@v3.sk>
 <20181010142504.233467-8-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181010142504.233467-8-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Cc: Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <sboyd@kernel.org>, James Cameron <quozl@laptop.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Oct 10, 2018 at 04:25:03PM +0200, Lubomir Rintel wrote:
> Without the clock, the keyboard controller won't operate.
> Tested on an OLPC XO 1.75.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/input/serio/olpc_apsp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/input/serio/olpc_apsp.c b/drivers/input/serio/olpc_apsp.c
> index 8b19a47dfa46..fe9e19014e70 100644
> --- a/drivers/input/serio/olpc_apsp.c
> +++ b/drivers/input/serio/olpc_apsp.c
> @@ -23,6 +23,7 @@
>  #include <linux/of.h>
>  #include <linux/slab.h>
>  #include <linux/delay.h>
> +#include <linux/clk.h>
>  
>  /*
>   * The OLPC XO-1.75 and XO-4 laptops do not have a hardware PS/2 controller.
> @@ -74,6 +75,7 @@ struct olpc_apsp {
>  	struct serio *kbio;
>  	struct serio *padio;
>  	void __iomem *base;
> +	struct clk *clk;
>  	int open_count;
>  	int irq;
>  };
> @@ -146,8 +148,13 @@ static int olpc_apsp_open(struct serio *port)
>  	struct olpc_apsp *priv = port->port_data;
>  	unsigned int tmp;
>  	unsigned long l;
> +	int error;
>  
>  	if (priv->open_count++ == 0) {
> +		error = clk_prepare_enable(priv->clk);
> +		if (error)
> +			return error;
> +
>  		l = readl(priv->base + COMMAND_FIFO_STATUS);
>  		if (!(l & CMD_STS_MASK)) {
>  			dev_err(priv->dev, "SP cannot accept commands.\n");

I think you need to disable clock here.

> @@ -171,6 +178,8 @@ static void olpc_apsp_close(struct serio *port)
>  		/* Disable interrupt 0 */
>  		tmp = readl(priv->base + PJ_INTERRUPT_MASK);
>  		writel(tmp | INT_0, priv->base + PJ_INTERRUPT_MASK);
> +
> +		clk_disable_unprepare(priv->clk);
>  	}
>  }
>  
> @@ -198,6 +207,10 @@ static int olpc_apsp_probe(struct platform_device *pdev)
>  	if (priv->irq < 0)
>  		return priv->irq;
>  
> +	priv->clk = devm_clk_get(&pdev->dev, "sp");
> +	if (IS_ERR(priv->clk))
> +		return PTR_ERR(priv->clk);
> +
>  	/* KEYBOARD */
>  	kb_serio = kzalloc(sizeof(struct serio), GFP_KERNEL);
>  	if (!kb_serio)
> -- 
> 2.19.0
> 

-- 
Dmitry
