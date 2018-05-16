From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/3] input: touchscreen: edt-ft5x06: make wakeup source
 behavior configurable
Date: Wed, 16 May 2018 10:03:33 -0700
Message-ID: <20180516170333.GA21971@dtor-ws>
References: <20180516122829.23694-1-daniel@zonque.org>
 <20180516122829.23694-2-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180516122829.23694-2-daniel@zonque.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <daniel@zonque.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, robh+dt@kernel.org, kernel@pengutronix.de, linux-input@vger.kernel.org, fabio.estevam@nxp.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org

Hi Daniel,

On Wed, May 16, 2018 at 02:28:27PM +0200, Daniel Mack wrote:
> Allow configuring the device as wakeup source through device properties, as
> not all platforms want to wake up on touch screen activity.
> 
> Note that by default, the device will now no longer be a wakeup source.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt | 3 +++
>  drivers/input/touchscreen/edt-ft5x06.c                             | 3 ++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> index 025cf8c9324a..83f792d4d88c 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.txt
> @@ -52,6 +52,8 @@ Optional properties:
>   - touchscreen-inverted-y  : See touchscreen.txt
>   - touchscreen-swapped-x-y : See touchscreen.txt
>  
> + - wakeup-source: touchscreen acts as wakeup source
> +
>  Example:
>  	polytouch: edt-ft5x06@38 {
>  		compatible = "edt,edt-ft5406", "edt,edt-ft5x06";
> @@ -62,4 +64,5 @@ Example:
>  		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
>  		reset-gpios = <&gpio2 6 GPIO_ACTIVE_LOW>;
>  		wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
> +		wakeup-source;
>  	};
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
> index 5bf63f76ddda..955f085627fa 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -1007,7 +1007,8 @@ static int edt_ft5x06_ts_probe(struct i2c_client *client,
>  		goto err_remove_attrs;
>  
>  	edt_ft5x06_ts_prepare_debugfs(tsdata, dev_driver_string(&client->dev));
> -	device_init_wakeup(&client->dev, 1);
> +	device_init_wakeup(&client->dev,
> +			    device_property_read_bool(dev, "wakeup-source"));

I think we should actually drop device_init_wakeup() call. I2C core
already handles "wakeup-source" property (for OF). The static board
files can instantiate clients with I2C_CLIENT_WAKE, so that's handled
too, and I think ACPI has its own notion of annotating wakeup sources.

>  
>  	dev_dbg(&client->dev,
>  		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
> -- 
> 2.14.3
> 

Thanks.

-- 
Dmitry
