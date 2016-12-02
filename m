From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: support regulator power on/off
Date: Fri, 2 Dec 2016 15:00:13 -0800
Message-ID: <20161202230013.GA18268@dtor-ws>
References: <1480717140-14558-1-git-send-email-briannorris@chromium.org>
 <1480717140-14558-2-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33693 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbcLBXAR (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 2 Dec 2016 18:00:17 -0500
Content-Disposition: inline
In-Reply-To: <1480717140-14558-2-git-send-email-briannorris@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Caesar Wang <wxt@rock-chips.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>

On Fri, Dec 02, 2016 at 02:19:00PM -0800, Brian Norris wrote:
> On some boards, we need to enable a regulator before using the HID, and
> it's also nice to save power in suspend by disabling it. Support an
> optional "vdd-supply" and a companion initialization delay.
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: linux-input@vger.kernel.org
> ---
> v2:
>  * support compatible property for wacom, with specific "vdd-supply"
>  * name
>  * support the 100ms delay needed for this digitizer
>  * target regulator support only at specific device
> 
> v3:
>  * drop Wacom specifics and allow this to be used generically
>  * add "init-delay-ms" property support
> 
> v4:
>  * use devm_regulator_get() (with a 'dummy' regulator for most cases)
>    instead of _optional() version, to make code less conditional (Dmitry)
>  * fix but where 'init_delay_ms' wasn't getting assigned properly
>  * disable regulator in probe() failure path
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 44 +++++++++++++++++++++++++++++++++++++++++--
>  include/linux/i2c/i2c-hid.h   |  6 ++++++
>  2 files changed, 48 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index b3ec4f2de875..5c6e037613d7 100644
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
> @@ -937,6 +938,10 @@ static int i2c_hid_of_probe(struct i2c_client *client,
>  	}
>  	pdata->hid_descriptor_address = val;
>  
> +	ret = of_property_read_u32(dev->of_node, "init-delay-ms", &val);
> +	if (!ret)
> +		pdata->init_delay_ms = val;
> +
>  	return 0;
>  }
>  
> @@ -983,6 +988,15 @@ static int i2c_hid_probe(struct i2c_client *client,
>  		ihid->pdata = *platform_data;
>  	}
>  
> +	ihid->pdata.supply = devm_regulator_get(&client->dev, "vdd");

Oh, haveni't noticed that the rest of the driver does not use devm.
Well, I'll leave it up to hid-i2c folks to decide if they are OK with
mixing up the managed and non-managed resources, it seems safe to me in
this case.

Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
