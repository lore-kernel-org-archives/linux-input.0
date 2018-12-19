From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: i2c-hid: Ignore input report if there's no data
 present on Elan touchpanels
Date: Wed, 19 Dec 2018 14:09:00 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1812191406240.17216@cbobk.fhfr.pm>
References: <20181214090930.13386-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214090930.13386-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, 14 Dec 2018, Kai-Heng Feng wrote:

> While using Elan touchpads, the message floods:
> [  136.138487] i2c_hid i2c-DELL08D6:00: i2c_hid_get_input: incomplete report (14/65535)
> 
> Though the message flood is annoying, the device it self works without
> any issue. I suspect that the device in question takes too much time to
> pull the IRQ back to high after I2C host has done reading its data.
> 
> Since the host receives all useful data, let's ignore the input report
> when there's no data.

Interesting, never seen such a bug before.

> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 8555ce7e737b..1776afa6d69c 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -50,6 +50,7 @@
>  #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
>  #define I2C_HID_QUIRK_NO_RUNTIME_PM		BIT(2)
>  #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP		BIT(3)
> +#define I2C_HID_QUIRK_BOGUS_IRQ			BIT(4)
>  
>  /* flags */
>  #define I2C_HID_STARTED		0
> @@ -179,6 +180,8 @@ static const struct i2c_hid_quirks {
>  		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
>  	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
>  		I2C_HID_QUIRK_NO_RUNTIME_PM },
> +	{ USB_VENDOR_ID_ELAN, HID_ANY_ID,
> +		 I2C_HID_QUIRK_BOGUS_IRQ },
>  	{ 0, 0 }
>  };
>  
> @@ -503,6 +506,12 @@ static void i2c_hid_get_input(struct i2c_hid *ihid)
>  		return;
>  	}
>  
> +	if (ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ && ret_size == 0xffff) {
> +		dev_dbg(&ihid->client->dev,
> +			"%s: IRQ triggered but there's no data\n", __func__);
> +		return;
> +	}

Would it perhaps make sense to make this some sort of printk_once(), so 
that it's immediately apparent from dmesg that the system/device is 
suffering from this particular problem? Might potentially be helpful piece 
of information.

Thanks,

-- 
Jiri Kosina
SUSE Labs
