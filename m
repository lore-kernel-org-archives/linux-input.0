From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: cros_ec_keyb - Fix usage of cros_ec_cmd_xfer()
Date: Mon, 25 Jul 2016 11:28:21 -0700
Message-ID: <20160725182821.GD27415@dtor-ws>
References: <1469470451-111822-1-git-send-email-briannorris@chromium.org>
 <1469470451-111822-3-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1469470451-111822-3-git-send-email-briannorris@chromium.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Lee Jones <lee.jones@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Olof Johansson <olof@lixom.net>, Brian Norris <computersforpeace@gmail.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Enric Balletbo <enric.balletbo@collabora.co.uk>, Shawn Nematbakhsh <shawnn@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-input@vger.kernel.org

On Mon, Jul 25, 2016 at 11:14:11AM -0700, Brian Norris wrote:
> cros_ec_cmd_xfer returns success status if the command transport
> completes successfully, but the execution result is incorrectly ignored.
> In many cases, the execution result is assumed to be successful, leading
> to ignored errors and operating on uninitialized data.
> 
> We've recently introduced the cros_ec_cmd_xfer_status() helper to avoid these
> problems. Let's use it.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Instead of me pulling in pwm/mfd branch maybe Thierry can push through
his branch?

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> ---
>  drivers/input/keyboard/cros_ec_keyb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index b01966dc7eb3..6e48616a3a88 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -160,7 +160,7 @@ static int cros_ec_keyb_get_state(struct cros_ec_keyb *ckdev, uint8_t *kb_state)
>  	msg->insize = ckdev->cols;
>  	msg->outsize = 0;
>  
> -	ret = cros_ec_cmd_xfer(ckdev->ec, msg);
> +	ret = cros_ec_cmd_xfer_status(ckdev->ec, msg);
>  	if (ret < 0) {
>  		dev_err(ckdev->dev, "Error transferring EC message %d\n", ret);
>  		goto exit;
> -- 
> 2.8.0.rc3.226.g39d4020
> 

-- 
Dmitry
