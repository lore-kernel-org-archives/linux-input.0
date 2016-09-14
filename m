From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: support the regulator
Date: Wed, 14 Sep 2016 09:36:03 +0200
Message-ID: <20160914073603.GH25951@mail.corp.redhat.com>
References: <1473027116-13892-1-git-send-email-wxt@rock-chips.com>
 <1473027116-13892-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759039AbcINHgQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 14 Sep 2016 03:36:16 -0400
Content-Disposition: inline
In-Reply-To: <1473027116-13892-2-git-send-email-wxt@rock-chips.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-rockchip@lists.infradead.org, dbasehore@chromium.org, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Brian Norris <briannorris@chromium.org>, linux-input@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Dmitry Torokhov <dtor@chromium.org>, Benson Leung <bleung@chromium.org>, Guohua Zhong <ghzhong@yifangdigital.com>, "Zhonghui\"" <zhonghui.fu@linux.intel.com>, linux-kernel@vger.kernel.org

On Sep 05 2016 or thereabouts, Caesar Wang wrote:
> From: Brian Norris <briannorris@chromium.org>
> 
> In order to allow supporting the HID based devices that need power on/off
> the regulator. We try to get a power-supply property from the
> device tree.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: linux-input@vger.kernel.org
> 
> ---
> 
>  drivers/hid/i2c-hid/i2c-hid.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index b3ec4f2..07cc7aa 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -38,6 +38,7 @@
>  #include <linux/acpi.h>
>  #include <linux/of.h>
>  #include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include <linux/i2c/i2c-hid.h>
>  
> @@ -152,6 +153,7 @@ struct i2c_hid {
>  
>  	bool			irq_wake_enabled;
>  	struct mutex		reset_lock;
> +	struct regulator	*supply;
>  };
>  
>  static int __i2c_hid_command(struct i2c_client *client,
> @@ -968,6 +970,21 @@ static int i2c_hid_probe(struct i2c_client *client,
>  	if (!ihid)
>  		return -ENOMEM;
>  
> +	ihid->supply = devm_regulator_get(&client->dev, "power");
> +	if (IS_ERR(ihid->supply)) {

I am not familiar with regulators, but what if (like 99% of the
available i2c-hid devices) there is no regulator attached to the device?

Will the pointer be null? Will there be a dummy regulator?

It seems at first sight that you are adding a requirement on the devices
which is not part of the spec, and which will break every existing
systems but yours. Again, I might be wrong, so please provide more
information.

Cheers,
Benjamin

> +		ret = PTR_ERR(ihid->supply);
> +		dev_err(&client->dev, "Failed to get power regulator: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ret = regulator_enable(ihid->supply);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Failed to enable power regulator: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
>  	if (client->dev.of_node) {
>  		ret = i2c_hid_of_probe(client, &ihid->pdata);
>  		if (ret)
> @@ -1100,6 +1117,8 @@ static int i2c_hid_remove(struct i2c_client *client)
>  	if (ihid->desc)
>  		gpiod_put(ihid->desc);
>  
> +	regulator_disable(ihid->supply);
> +
>  	kfree(ihid);
>  
>  	acpi_dev_remove_driver_gpios(ACPI_COMPANION(&client->dev));
> @@ -1152,6 +1171,11 @@ static int i2c_hid_suspend(struct device *dev)
>  		else
>  			hid_warn(hid, "Failed to enable irq wake: %d\n",
>  				wake_status);
> +	} else {
> +		ret = regulator_disable(ihid->supply);
> +		if (ret < 0)
> +			hid_warn(hid, "Failed to disable power supply: %d\n",
> +				 ret);
>  	}
>  
>  	return 0;
> @@ -1165,7 +1189,12 @@ static int i2c_hid_resume(struct device *dev)
>  	struct hid_device *hid = ihid->hid;
>  	int wake_status;
>  
> -	if (device_may_wakeup(&client->dev) && ihid->irq_wake_enabled) {
> +	if (!device_may_wakeup(&client->dev)) {
> +		ret = regulator_enable(ihid->supply);
> +		if (ret < 0)
> +			hid_warn(hid, "Failed to enable power supply: %d\n",
> +				 ret);
> +	} else if (ihid->irq_wake_enabled) {
>  		wake_status = disable_irq_wake(ihid->irq);
>  		if (!wake_status)
>  			ihid->irq_wake_enabled = false;
> -- 
> 1.9.1
> 
