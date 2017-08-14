From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] i2c: core: Allow the driver to override the default
 i2c_bus match behavior
Date: Mon, 14 Aug 2017 22:13:23 +0200
Message-ID: <de6bf483-9ef4-522b-507d-272f736bcabc@redhat.com>
References: <20170722185537.12696-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46214 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751030AbdHNUNc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 14 Aug 2017 16:13:32 -0400
In-Reply-To: <20170722185537.12696-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Wolfram Sang <wsa@the-dreams.de>
Cc: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

Hi,

On 22-07-17 20:55, Hans de Goede wrote:
> Some ACPI devices report multiple ids for a single i2c_client, while not
> really implementing the hw-interface asociated with some of these ids.
> 
> For some of these devices calling probe and having probe fail with
> -ENODEV is a problem in itself as this causes the device to be
> powered-up and down again (causes its PS0 and PS3 ACPI methods to be
> executed) which puts some devices in an unusable state.
> 
> This commit adds a match callback to i2c_driver, allowing drivers to
> override the default i2c_bus match behavior and tell the core they
> are not the right driver for the device, avoiding i2c_bus_type.probe
> getting called, avoiding the undesirable power up / down cycle.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

What is the status of this series ? I thought there was agreement
on merging this through the i2c (wsa/linux.git) tree ?

Regards,

Hans


> ---
>   drivers/i2c/i2c-core-base.c | 12 +++++++++---
>   include/linux/i2c.h         |  6 ++++++
>   2 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index c89dac7fd2e7..2c6702f2347b 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -98,8 +98,16 @@ EXPORT_SYMBOL_GPL(i2c_match_id);
>   static int i2c_device_match(struct device *dev, struct device_driver *drv)
>   {
>   	struct i2c_client	*client = i2c_verify_client(dev);
> -	struct i2c_driver	*driver;
> +	struct i2c_driver	*driver = to_i2c_driver(drv);
> +	int ret;
>   
> +	if (driver->match && client) {
> +		ret = driver->match(client);
> +		if (ret < 0)
> +			return 0;
> +		if (ret > 0)
> +			return 1;
> +	}
>   
>   	/* Attempt an OF style match */
>   	if (i2c_of_match_device(drv->of_match_table, client))
> @@ -109,8 +117,6 @@ static int i2c_device_match(struct device *dev, struct device_driver *drv)
>   	if (acpi_driver_match_device(dev, drv))
>   		return 1;
>   
> -	driver = to_i2c_driver(drv);
> -
>   	/* Finally an I2C match */
>   	if (i2c_match_id(driver->id_table, client))
>   		return 1;
> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
> index 00ca5b86a753..670577c82bc3 100644
> --- a/include/linux/i2c.h
> +++ b/include/linux/i2c.h
> @@ -139,6 +139,9 @@ enum i2c_alert_protocol {
>    * struct i2c_driver - represent an I2C device driver
>    * @class: What kind of i2c device we instantiate (for detect)
>    * @attach_adapter: Callback for bus addition (deprecated)
> + * @match: Allows the driver to override the default i2c_bus match behavior
> + *         return < 0 to fail the match, > 0 to force a match, 0 to fallback
> + *         to default id matching
>    * @probe: Callback for device binding - soon to be deprecated
>    * @probe_new: New callback for device binding
>    * @remove: Callback for device unbinding
> @@ -180,6 +183,9 @@ struct i2c_driver {
>   	 */
>   	int (*attach_adapter)(struct i2c_adapter *) __deprecated;
>   
> +	/* Set this to override standard i2c_bus match behavior */
> +	int (*match)(struct i2c_client *);
> +
>   	/* Standard driver model interfaces */
>   	int (*probe)(struct i2c_client *, const struct i2c_device_id *);
>   	int (*remove)(struct i2c_client *);
> 
