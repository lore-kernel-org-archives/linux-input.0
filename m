From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: Add quirk for sleep before reset
Date: Thu, 5 Jan 2017 12:23:19 +0100
Message-ID: <20170105112319.GA17928@mail.corp.redhat.com>
References: <1483589429-2886-1-git-send-email-redmcg@redmandi.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35382 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759518AbdAELXY (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Jan 2017 06:23:24 -0500
Content-Disposition: inline
In-Reply-To: <1483589429-2886-1-git-send-email-redmcg@redmandi.dyndns.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brendan McGrath <redmcg@redmandi.dyndns.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Victor Vlasenko <victor.vlasenko@sysgears.com>, Frederik Wenigwieser <frederik.wenigwieser@gmail.com>

On Jan 05 2017 or thereabouts, Brendan McGrath wrote:
> Support for the Asus Touchpad was recently added. It turns out this
> device can fail initialisation (and become unusable) when the RESET
> command is sent too soon after the POWER ON command.
> 
> Unfortunately the i2c-hid specification does not specify the need for
> a delay between these two commands. But it was discovered the Windows
> driver has a 1ms delay.
> 
> As a result, this patch adds a new QUIRK to the i2c-hid module that
> allows a device to specify a specific sleep inbetween the POWER ON and
> RESET commands.
> 
> See https://github.com/vlasenko/hid-asus-dkms/issues/24 for further
> details.
> 
> Signed-off-by: Brendan McGrath <redmcg@redmandi.dyndns.org>
> ---
> I considered three approaches for this patch:
> a) add a hardcoded sleep that would affect all devices;
> b) add a quirk with a hardcoded sleep value; or
> c) add a quirk with a configurable sleep value
> 
> Each was a trade off between flexibility and the amount of code/complexity required.

I am not a big fan of having to configure the sleep value in each quirk.
I think I'd actually prefer the solution a: no quirk and a small wait
(you wait less than 5ms, I would think this as acceptable). I wouldn't
be surprised if other devices would require such timing issues, so I
wouldn't mind waiting a tiny bit for those to be working without any
quirks.

If anyone prefer not having those timeouts, we can add some quirks, but
I would then prefer solution b.

Cheers,
Benjamin

> 
> In the end I chose c) as this allowed for the most flexibility; but would
> be happy to resubmit the patch using one of the other options (or any other
> alternative).
> 
>  drivers/hid/i2c-hid/i2c-hid.c | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 8d53efe..fb1ebfa 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -45,6 +45,7 @@
>  
>  /* quirks to control the device */
>  #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
> +#define I2C_HID_QUIRK_SLEEP_BEFORE_RESET	BIT(1)
>  
>  /* flags */
>  #define I2C_HID_STARTED		0
> @@ -156,17 +157,26 @@ struct i2c_hid {
>  
>  	bool			irq_wake_enabled;
>  	struct mutex		reset_lock;
> +
> +	__u32			reset_usleep_low;
> +	__u32			reset_usleep_high;
>  };
>  
>  static const struct i2c_hid_quirks {
>  	__u16 idVendor;
>  	__u16 idProduct;
>  	__u32 quirks;
> +	__u32 reset_usleep_low;
> +	__u32 reset_usleep_high;
>  } i2c_hid_quirks[] = {
>  	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8752,
>  		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
>  	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8755,
>  		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
> +	{ USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_TOUCHPAD,
> +		I2C_HID_QUIRK_SLEEP_BEFORE_RESET,
> +		 .reset_usleep_low = 750,
> +		 .reset_usleep_high = 5000 },
>  	{ 0, 0 }
>  };
>  
> @@ -177,16 +187,16 @@ static const struct i2c_hid_quirks {
>   *
>   * Returns: a u32 quirks value.
>   */
> -static u32 i2c_hid_lookup_quirk(const u16 idVendor, const u16 idProduct)
> +static const struct i2c_hid_quirks* i2c_hid_lookup_quirk(const u16 idVendor, const u16 idProduct)
>  {
> -	u32 quirks = 0;
> +	const struct i2c_hid_quirks *quirks = NULL;
>  	int n;
>  
>  	for (n = 0; i2c_hid_quirks[n].idVendor; n++)
>  		if (i2c_hid_quirks[n].idVendor == idVendor &&
>  		    (i2c_hid_quirks[n].idProduct == (__u16)HID_ANY_ID ||
>  		     i2c_hid_quirks[n].idProduct == idProduct))
> -			quirks = i2c_hid_quirks[n].quirks;
> +			quirks = &i2c_hid_quirks[n];
>  
>  	return quirks;
>  }
> @@ -425,6 +435,9 @@ static int i2c_hid_hwreset(struct i2c_client *client)
>  	if (ret)
>  		goto out_unlock;
>  
> +	if (ihid->quirks & I2C_HID_QUIRK_SLEEP_BEFORE_RESET)
> +		usleep_range(ihid->reset_usleep_low, ihid->reset_usleep_high);
> +
>  	i2c_hid_dbg(ihid, "resetting...\n");
>  
>  	ret = i2c_hid_command(client, &hid_reset_cmd, NULL, 0);
> @@ -1005,6 +1018,7 @@ static int i2c_hid_probe(struct i2c_client *client,
>  	struct i2c_hid *ihid;
>  	struct hid_device *hid;
>  	__u16 hidRegister;
> +	const struct i2c_hid_quirks *quirks;
>  	struct i2c_hid_platform_data *platform_data = client->dev.platform_data;
>  
>  	dbg_hid("HID probe called for i2c 0x%02x\n", client->addr);
> @@ -1091,7 +1105,15 @@ static int i2c_hid_probe(struct i2c_client *client,
>  		 client->name, hid->vendor, hid->product);
>  	strlcpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
>  
> -	ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
> +	quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
> +
> +	if (quirks)
> +		ihid->quirks = quirks->quirks;
> +
> +	if (ihid->quirks & I2C_HID_QUIRK_SLEEP_BEFORE_RESET) {
> +		ihid->reset_usleep_low = quirks->reset_usleep_low;
> +		ihid->reset_usleep_high = quirks->reset_usleep_high;
> +	}
>  
>  	ret = hid_add_device(hid);
>  	if (ret) {
> -- 
> 2.7.4
> 
