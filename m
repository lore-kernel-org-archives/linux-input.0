From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: i2c-hid: Do not bind to CHPN0001 touchscreen
Date: Mon, 24 Jul 2017 10:19:28 +0200
Message-ID: <20170724081928.GB18097@mail.corp.redhat.com>
References: <20170722185537.12696-1-hdegoede@redhat.com>
 <20170722185537.12696-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752990AbdGXITf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 24 Jul 2017 04:19:35 -0400
Content-Disposition: inline
In-Reply-To: <20170722185537.12696-2-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org

On Jul 22 2017 or thereabouts, Hans de Goede wrote:
> The CHPN0001 ACPI device has a _CID of PNP0C50 but is not HID compatible,
> it uses its own protocol which is handled by the chipone_icn8318 driver.
> 
> If the i2c_hid_driver's probe functon gets called it will fail with a
> "hid_descr_cmd failed" error.
> 
> Worse, after the probe failure the i2c / ACPI core code will put the ACPI
> device in D3 state and when the chipone_icn8318 driver then loads the
> device is put back in D0 state, executing its PS0 ACPI method, which
> resets the controller, causing the controller to loose its firmware
> which was loaded by the BIOS. The chipone_icn8318 driver has a workaround
> for this, but that requires it to be the only (or the first) driver to
> probe the device.
> 
> This commit adds a match callback and returns -ENODEV for i2c_client-s
> with a CHPN0001 ACPI device id, so that the probe function never gets
> called, fixing the controller losing its firmware.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Use the new i2c_driver match callback to only filter out the CHPN0001
>  ACPI device, rather then use acpi_dev_present in probe and not
>  registering the driver at all when the system has a CHPN0001 device

I like the v2 much more than the v1.

Reviewed-By: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 046f692fd0a2..79bed9afc388 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -891,6 +891,26 @@ static void i2c_hid_acpi_fix_up_power(struct device *dev)
>  		acpi_device_fix_up_power(adev);
>  }
>  
> +static const struct acpi_device_id i2c_hid_acpi_blacklist[] = {
> +	/*
> +	 * The CHPN0001 ACPI device has a _CID of PNP0C50 but is not HID
> +	 * compatible, just probing it puts the device in an unusable state due
> +	 * to it also have ACPI power management issues.
> +	 */
> +	{"CHPN0001", 0 },
> +	{ },
> +};
> +
> +static int i2c_hid_match(struct i2c_client *client)
> +{
> +	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
> +
> +	if (adev && acpi_match_device_ids(adev, i2c_hid_acpi_blacklist) == 0)
> +		return -ENODEV;
> +
> +	return 0;
> +}
> +
>  static const struct acpi_device_id i2c_hid_acpi_match[] = {
>  	{"ACPI0C50", 0 },
>  	{"PNP0C50", 0 },
> @@ -905,6 +925,7 @@ static inline int i2c_hid_acpi_pdata(struct i2c_client *client,
>  }
>  
>  static inline void i2c_hid_acpi_fix_up_power(struct device *dev) {}
> +static int i2c_hid_match(struct i2c_client *client) { return 0; }
>  #endif
>  
>  #ifdef CONFIG_OF
> @@ -1255,6 +1276,7 @@ static struct i2c_driver i2c_hid_driver = {
>  		.of_match_table = of_match_ptr(i2c_hid_of_match),
>  	},
>  
> +	.match		= i2c_hid_match,
>  	.probe		= i2c_hid_probe,
>  	.remove		= i2c_hid_remove,
>  	.shutdown	= i2c_hid_shutdown,
> -- 
> 2.13.0
> 
