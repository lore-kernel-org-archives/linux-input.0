From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: i2c-hid: add platform data for quirks
Date: Wed, 9 Oct 2013 12:26:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1310091225230.13289@pobox.suse.cz>
References: <1380790121-1355-1-git-send-email-bbasu@nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43613 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753646Ab3JIK0w (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 9 Oct 2013 06:26:52 -0400
In-Reply-To: <1380790121-1355-1-git-send-email-bbasu@nvidia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bibek Basu <bbasu@nvidia.com>
Cc: benjamin.tissoires@gmail.com, linux-tegra@vger.kernel.org, kadduri@nvidia.com, linux-input@vger.kernel.org

On Thu, 3 Oct 2013, Bibek Basu wrote:

> Some HID device does not responds to INPUT/FEATURE
> report query during initialization. As a result HID driver
> throws error even when its not mandatory according to the
> HID specification. Add platform data to provide
> quirk information to the driver so that init query is not
> done on such devices.
> 
> Signed-off-by: Bibek Basu <bbasu@nvidia.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid.c | 1 +
>  include/linux/i2c/i2c-hid.h   | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index fd7ce37..a7aec2c 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -1017,6 +1017,7 @@ static int i2c_hid_probe(struct i2c_client *client,
>  	hid->version = le16_to_cpu(ihid->hdesc.bcdVersion);
>  	hid->vendor = le16_to_cpu(ihid->hdesc.wVendorID);
>  	hid->product = le16_to_cpu(ihid->hdesc.wProductID);
> +	hid->quirks = platform_data->quirks;
>  
>  	snprintf(hid->name, sizeof(hid->name), "%s %04hX:%04hX",
>  		 client->name, hid->vendor, hid->product);
> diff --git a/include/linux/i2c/i2c-hid.h b/include/linux/i2c/i2c-hid.h
> index 7aa901d..12e682d 100644
> --- a/include/linux/i2c/i2c-hid.h
> +++ b/include/linux/i2c/i2c-hid.h
> @@ -17,7 +17,7 @@
>  /**
>   * struct i2chid_platform_data - used by hid over i2c implementation.
>   * @hid_descriptor_address: i2c register where the HID descriptor is stored.
> - *
> + * @quirks: quirks, if any for i2c-hid devices
>   * Note that it is the responsibility of the platform driver (or the acpi 5.0
>   * driver, or the flattened device tree) to setup the irq related to the gpio in
>   * the struct i2c_board_info.
> @@ -31,6 +31,7 @@
>   */
>  struct i2c_hid_platform_data {
>  	u16 hid_descriptor_address;
> +	u32 quirks;
>  };

Umm, and where does the quirks field of platform data actually get set? I 
don't seem to see any followup patchset doing that?

Thanks,

-- 
Jiri Kosina
SUSE Labs
