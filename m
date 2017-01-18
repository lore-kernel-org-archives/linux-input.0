From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 23/33] Input: xilinx_ps2 - Use 'dev' instead of
 dereferencing it and other changes
Date: Wed, 18 Jan 2017 11:17:12 -0800
Message-ID: <20170118191712.GA33920@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-24-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1484761614-12225-24-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Jan 18, 2017 at 09:46:44AM -0800, Guenter Roeck wrote:
> Use local variable 'dev' instead of dereferencing it several times.
> 
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Use local variable 'struct device *dev' consistently
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thank you.

> ---
>  drivers/input/serio/xilinx_ps2.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
> index 5223cbf94262..14c40892ed82 100644
> --- a/drivers/input/serio/xilinx_ps2.c
> +++ b/drivers/input/serio/xilinx_ps2.c
> @@ -243,18 +243,17 @@ static int xps2_of_probe(struct platform_device *ofdev)
>  	unsigned int irq;
>  	int error;
>  
> -	dev_info(dev, "Device Tree Probing \'%s\'\n",
> -			ofdev->dev.of_node->name);
> +	dev_info(dev, "Device Tree Probing \'%s\'\n", dev->of_node->name);
>  
>  	/* Get iospace for the device */
> -	error = of_address_to_resource(ofdev->dev.of_node, 0, &r_mem);
> +	error = of_address_to_resource(dev->of_node, 0, &r_mem);
>  	if (error) {
>  		dev_err(dev, "invalid address\n");
>  		return error;
>  	}
>  
>  	/* Get IRQ for the device */
> -	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
> +	irq = irq_of_parse_and_map(dev->of_node, 0);
>  	if (!irq) {
>  		dev_err(dev, "no IRQ found\n");
>  		return -ENODEV;
> -- 
> 2.7.4
> 

-- 
Dmitry
