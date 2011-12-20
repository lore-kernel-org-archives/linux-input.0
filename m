From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [PATCH] Input: Add a driver to support for Wacom I2C Stylus Device
Date: Tue, 20 Dec 2011 14:05:04 +0800
Message-ID: <4EF02590.5020409@cn.fujitsu.com>
References: <1324360008-32641-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:64685 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751076Ab1LTGGP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 01:06:15 -0500
In-Reply-To: <1324360008-32641-1-git-send-email-tobita.tatsunosuke@wacom.co.jp>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tatsunosuke Tobita <junkpainting@gmail.com>
Cc: linux-input@vger.kernel.org, Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>

On 12/20/2011 01:46 PM, Tatsunosuke Tobita wrote:

> From: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> 
> This driver supports for Wacom Stylus Device with I2C interface.
> 
> Signed-off-by: Tatsunosuke Tobita <tobita.tatsunosuke@wacom.co.jp>
> ---
>  drivers/input/touchscreen/wacom_i2c.c |  250 +++++++++++++++++++++++++++++++++
>  drivers/input/touchscreen/wacom_i2c.h |   55 +++++++
>  2 files changed, 305 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/input/touchscreen/wacom_i2c.c
>  create mode 100644 drivers/input/touchscreen/wacom_i2c.h
> 
> diff --git a/drivers/input/touchscreen/wacom_i2c.c b/drivers/input/touchscreen/wacom_i2c.c
> new file mode 100644
> index 0000000..157bcc5
> --- /dev/null
> +++ b/drivers/input/touchscreen/wacom_i2c.c

> +
> +static struct i2c_driver wacom_i2c_driver = {
> +	.driver = {
> +		.name = "wacom_i2c",
> +		.owner = THIS_MODULE,
> +		.pm = &wacom_i2c_pm,
> +	},
> +
> +	.probe = wacom_i2c_probe,
> +	.remove = __devexit_p(wacom_i2c_remove),
> +	.id_table = wacom_i2c_id,
> +};
> +
> +static int __init wacom_i2c_init(void)
> +{
> +	return i2c_add_driver(&wacom_i2c_driver);
> +}
> +
> +static void __exit wacom_i2c_exit(void)
> +{
> +	i2c_del_driver(&wacom_i2c_driver);
> +}
> +
> +module_init(wacom_i2c_init);
> +module_exit(wacom_i2c_exit);


You can use module_i2c_driver(wacom_i2c_driver) instead of module_init{exit},
it has been queued to driver-core-next already.


Thanks
-Wanlong Gao

