From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RESEND PATCH 1/2] i2c: cros-ec-tunnel: Fix usage of
 cros_ec_cmd_xfer()
Date: Wed, 10 Aug 2016 14:15:50 -0700
Message-ID: <20160810211550.GA21385@roeck-us.net>
References: <1470861439-129201-1-git-send-email-briannorris@chromium.org>
 <1470861439-129201-2-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1470861439-129201-2-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, "# 9798ac6d32c1 mfd : cros_ec : Add cros_ec_cmd_xfer_status helper" <stable@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Wed, Aug 10, 2016 at 01:37:18PM -0700, Brian Norris wrote:
> cros_ec_cmd_xfer returns success status if the command transport
> completes successfully, but the execution result is incorrectly ignored.
> In many cases, the execution result is assumed to be successful, leading
> to ignored errors and operating on uninitialized data.
> 
> We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid these
> problems. Let's use it.
> 
> [Regarding the 'Fixes' tag; there is significant refactoring since the driver's
> introduction, but the underlying logical error exists throughout I believe]
> 
> Fixes: 9d230c9e4f4e ("i2c: ChromeOS EC tunnel driver")
> Cc: <stable@vger.kernel.org> # 9798ac6d32c1 mfd: cros_ec: Add cros_ec_cmd_xfer_status() helper
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/i2c/busses/i2c-cros-ec-tunnel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> index a0d95ff682ae..2d5ff86398d0 100644
> --- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> +++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
> @@ -215,7 +215,7 @@ static int ec_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg i2c_msgs[],
>  	msg->outsize = request_len;
>  	msg->insize = response_len;
>  
> -	result = cros_ec_cmd_xfer(bus->ec, msg);
> +	result = cros_ec_cmd_xfer_status(bus->ec, msg);
>  	if (result < 0) {
>  		dev_err(dev, "Error transferring EC i2c message %d\n", result);
>  		goto exit;
> -- 
> 2.8.0.rc3.226.g39d4020
> 
