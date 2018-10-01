From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: xilinx_ps2: Convert to using %pOFn instead of
 device_node.name
Date: Mon, 1 Oct 2018 16:29:52 -0700
Message-ID: <20181001232952.GB194397@dtor-ws>
References: <20181001214351.13230-1-robh@kernel.org>
 <20181001214351.13230-2-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181001214351.13230-2-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

On Mon, Oct 01, 2018 at 04:43:49PM -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thank you.

> ---
>  drivers/input/serio/xilinx_ps2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
> index 07de1b49293c..6615c02a08fd 100644
> --- a/drivers/input/serio/xilinx_ps2.c
> +++ b/drivers/input/serio/xilinx_ps2.c
> @@ -245,7 +245,7 @@ static int xps2_of_probe(struct platform_device *ofdev)
>  	unsigned int irq;
>  	int error;
>  
> -	dev_info(dev, "Device Tree Probing \'%s\'\n", dev->of_node->name);
> +	dev_info(dev, "Device Tree Probing \'%pOFn\'\n", dev->of_node);
>  
>  	/* Get iospace for the device */
>  	error = of_address_to_resource(dev->of_node, 0, &r_mem);
> -- 
> 2.17.1
> 

-- 
Dmitry
