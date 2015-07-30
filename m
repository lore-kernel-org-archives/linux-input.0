From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 07/27] Input: Export I2C module alias information in
 missing drivers
Date: Thu, 30 Jul 2015 10:39:53 -0700
Message-ID: <20150730173953.GE13165@dtor-ws>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com>
 <1438273132-20926-8-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1438273132-20926-8-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Jul 30, 2015 at 06:18:32PM +0200, Javier Martinez Canillas wrote:
> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
> regardless if the driver was matched using the I2C id_table or the
> of_match_table. So the driver needs to export the I2C table and this
> be built into the module or udev won't have the necessary information
> to auto load the correct module when the device is added.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thank you.

> 
> ---
> 
>  drivers/input/misc/gp2ap002a00f.c  | 1 +
>  drivers/input/touchscreen/goodix.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/input/misc/gp2ap002a00f.c b/drivers/input/misc/gp2ap002a00f.c
> index ba301af91b95..3bfdfcc20485 100644
> --- a/drivers/input/misc/gp2ap002a00f.c
> +++ b/drivers/input/misc/gp2ap002a00f.c
> @@ -267,6 +267,7 @@ static const struct i2c_device_id gp2a_i2c_id[] = {
>  	{ GP2A_I2C_NAME, 0 },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(i2c, gp2a_i2c_id);
>  
>  static struct i2c_driver gp2a_i2c_driver = {
>  	.driver = {
> diff --git a/drivers/input/touchscreen/goodix.c b/drivers/input/touchscreen/goodix.c
> index 19c792ee4dfa..4d113c9e4b77 100644
> --- a/drivers/input/touchscreen/goodix.c
> +++ b/drivers/input/touchscreen/goodix.c
> @@ -420,6 +420,7 @@ static const struct i2c_device_id goodix_ts_id[] = {
>  	{ "GDIX1001:00", 0 },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id goodix_acpi_match[] = {
> -- 
> 2.4.3
> 

-- 
Dmitry
