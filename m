From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: Re: [PATCH] Input: atmel_mxt_ts: Add of node type to the i2c table
Date: Tue, 09 Sep 2014 12:21:09 +0200
Message-ID: <540ED495.20609@collabora.co.uk>
References: <1410249158-18192-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1410249158-18192-1-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick.dyer@itdev.co.uk>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
List-Id: linux-input@vger.kernel.org

[adding Lee Jones to cc list since I'm referring on a series he posted]

Hello Sjoerd,

On 09/09/2014 09:52 AM, Sjoerd Simons wrote:
> For i2c devices in OF the modalias exposed to userspace is i2c:<node
> type>, for the Maxtouch driver this is i2c:maxtouch.
> 
> Add maxtouch to the i2c id table such that userspace can correctly
> load the module for the device and drop the OF table as it's not
> needed for i2c devices.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index db178ed..57ff26d 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -2267,16 +2267,11 @@ static int mxt_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(mxt_pm_ops, mxt_suspend, mxt_resume);
>  
> -static const struct of_device_id mxt_of_match[] = {
> -	{ .compatible = "atmel,maxtouch", },
> -	{},
> -};
> -MODULE_DEVICE_TABLE(of, mxt_of_match);
> -
>  static const struct i2c_device_id mxt_id[] = {
>  	{ "qt602240_ts", 0 },
>  	{ "atmel_mxt_ts", 0 },
>  	{ "atmel_mxt_tp", 0 },
> +	{ "maxtouch", 0 },
>  	{ "mXT224", 0 },
>  	{ }
>  };
> @@ -2286,7 +2281,6 @@ static struct i2c_driver mxt_driver = {
>  	.driver = {
>  		.name	= "atmel_mxt_ts",
>  		.owner	= THIS_MODULE,
> -		.of_match_table = of_match_ptr(mxt_of_match),
>  		.pm	= &mxt_pm_ops,
>  	},
>  	.probe		= mxt_probe,
> 

I see that Lee is working to allow the I2C subsystem to not need an I2C ID
table to match [0]. I'll let Lee to comment what the future plans are and if
his series are going to solve your issue since I'm not that familiar with the
I2C core.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/6/20/199
