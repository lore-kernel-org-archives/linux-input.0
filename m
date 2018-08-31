From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] HID: i2c-hid: enforce I2C_HID_QUIRK_RESEND_REPORT_DESCR
Date: Fri, 31 Aug 2018 12:04:22 +0200
Message-ID: <4687e76a-d9a8-4a20-194b-526bb345cf73@redhat.com>
References: <20180831095417.8541-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831095417.8541-1-benjamin.tissoires@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 31-08-18 11:54, Benjamin Tissoires wrote:
> The spec states that the HID devices should allow
> the host to query the HID descriptor at any time.
> 
> Some devices require the HID descriptor to be set
> on resume, or they will fail.
> 
> Instead of having a growing list of blacklisted devices
> make the call part of the general resume process
> so we can remove this list.
> 
> Tested on a Dell XPS 9360 and a Surface 3.
> 
> link: https://bugzilla.redhat.com/show_bug.cgi?id=1622695
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I agree we should just do this everywhere:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>   drivers/hid/i2c-hid/i2c-hid.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
> index 57126f6837bb..17ec57c62a0b 100644
> --- a/drivers/hid/i2c-hid/i2c-hid.c
> +++ b/drivers/hid/i2c-hid/i2c-hid.c
> @@ -47,7 +47,7 @@
>   /* quirks to control the device */
>   #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
>   #define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
> -#define I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2)
> +/* reserved: I2C_HID_QUIRK_RESEND_REPORT_DESCR	BIT(2) */
>   
>   /* flags */
>   #define I2C_HID_STARTED		0
> @@ -170,12 +170,6 @@ static const struct i2c_hid_quirks {
>   		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
>   	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
>   		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
> -	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_3118,
> -		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> -	{ USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS10FB_TOUCH,
> -		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
> -	{ I2C_VENDOR_ID_RAYD, I2C_PRODUCT_ID_RAYD_4B33,
> -		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
>   	{ 0, 0 }
>   };
>   
> @@ -1245,11 +1239,9 @@ static int i2c_hid_resume(struct device *dev)
>   	 * after resume, after this it will be back normal.
>   	 * otherwise it issues too many incomplete reports.
>   	 */
> -	if (ihid->quirks & I2C_HID_QUIRK_RESEND_REPORT_DESCR) {
> -		ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = i2c_hid_command(client, &hid_report_descr_cmd, NULL, 0);
> +	if (ret)
> +		return ret;
>   
>   	if (hid->driver && hid->driver->reset_resume) {
>   		ret = hid->driver->reset_resume(hid);
> 
