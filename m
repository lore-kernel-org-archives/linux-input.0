From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] HID: asus: Add product-id for the T100TAF keyboard dock
Date: Thu, 23 Nov 2017 15:41:02 +0100
Message-ID: <89bd0355-40b5-f0db-f8eb-186e29c95f59@redhat.com>
References: <20171122120500.11206-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20171122120500.11206-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi,

On 22-11-17 13:05, Hans de Goede wrote:
> The T100TAF keyboard dock has the same special keys and custom
> protocol multitouch touchpad as the T100TA, but uses a different
> product id, add support for this.
> 
> Cc: stable@vger.kernel.org
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=197849
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Self nack, this patch is no good, the touchpad has a different
resolution then the one in the T100TA (I forgot to check this)
so a slightly more comprehensive patch is needed.

Regards,

Hans



> ---
>   drivers/hid/hid-asus.c | 5 ++++-
>   drivers/hid/hid-core.c | 3 ++-
>   drivers/hid/hid-ids.h  | 3 ++-
>   3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 1bb7b63b3150..4cdac9857037 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -751,7 +751,10 @@ static const struct hid_device_id asus_devices[] = {
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
>   		USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3), QUIRK_G752_KEYBOARD },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> -		USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD),
> +		USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD),
> +	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
> +		USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD),
>   	  QUIRK_T100_KEYBOARD | QUIRK_NO_CONSUMER_USAGES },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_CHICONY, USB_DEVICE_ID_ASUS_AK1D) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index f3fcb836a1f9..d6780e1d2526 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1983,7 +1983,8 @@ static const struct hid_device_id hid_have_special_driver[] = {
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD3) },
> -	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_JESS, USB_DEVICE_ID_ASUS_MD_5112) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_TURBOX, USB_DEVICE_ID_ASUS_MD_5110) },
>   	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ASUSTEK, USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD) },
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5da3d6256d25..dc1db8558850 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -178,7 +178,8 @@
>   #define USB_VENDOR_ID_ASUSTEK		0x0b05
>   #define USB_DEVICE_ID_ASUSTEK_LCM	0x1726
>   #define USB_DEVICE_ID_ASUSTEK_LCM2	0x175b
> -#define USB_DEVICE_ID_ASUSTEK_T100_KEYBOARD	0x17e0
> +#define USB_DEVICE_ID_ASUSTEK_T100TA_KEYBOARD	0x17e0
> +#define USB_DEVICE_ID_ASUSTEK_T100TAF_KEYBOARD	0x1807
>   #define USB_DEVICE_ID_ASUSTEK_T100CHI_KEYBOARD	0x8502
>   #define USB_DEVICE_ID_ASUSTEK_T304_KEYBOARD	0x184a
>   #define USB_DEVICE_ID_ASUSTEK_I2C_KEYBOARD	0x8585
> 
