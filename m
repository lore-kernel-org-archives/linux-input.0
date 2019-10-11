From: Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
Subject: Re: [PATCH v4 1/4] HID: logitech: Add MX Mice over Bluetooth
Date: Fri, 11 Oct 2019 09:49:34 +0100
Message-ID: <403b3e7f6d276e47c447e6ea56a3370b03c3298c.camel@archlinux.org>
References: <uBbIS3nFJ1jdYNLHcqjW5wxQAwmZv0kmYEoeoPrxNhfzi6cHwmCOY-ewdqe7S1hNEj-p4Hd9D0_Y3PymUTdh_6WFXuMmIYUkV2xaKCPMYz0=@protonmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <uBbIS3nFJ1jdYNLHcqjW5wxQAwmZv0kmYEoeoPrxNhfzi6cHwmCOY-ewdqe7S1hNEj-p4Hd9D0_Y3PymUTdh_6WFXuMmIYUkV2xaKCPMYz0=@protonmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mazin Rezk <mnrzk@protonmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Cc: "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>, "jikos@kernel.org" <jikos@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2019-10-11 at 00:57 +0000, Mazin Rezk wrote:
> On Saturday, October 5, 2019 9:04 PM, Mazin Rezk <
> mnrzk@protonmail.com> wrote:
> 
> > This patch adds support for several MX mice over Bluetooth. The
> > device IDs
> > have been copied from the libratbag device database and their
> > features
> > have been based on their DJ device counterparts.
> 
> No changes have been made to this patch in v4. However, it should be
> noted
> that the only device that has been thoroughly tested in this patch is
> the
> MX Master (b01e). Further testing for the other devices may be
> required.
> 
> Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-
> logitech-hidpp.c
> index 0179f7ed77e5..85fd0c17cc2f 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -3773,6 +3773,24 @@ static const struct hid_device_id
> hidpp_devices[] = {
>  	{ /* MX5500 keyboard over Bluetooth */
>  	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb30b),
>  	  .driver_data = HIDPP_QUIRK_HIDPP_CONSUMER_VENDOR_KEYS },
> +	{ /* MX Anywhere 2 mouse over Bluetooth */
> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb013),
> +	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb018),
> +	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ /* MX Anywhere 2S mouse over Bluetooth */
> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01a),
> +	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ /* MX Master mouse over Bluetooth */
> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb012),
> +	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb017),
> +	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb01e),
> +	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
> +	{ /* MX Master 2S mouse over Bluetooth */
> +	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH, 0xb019),
> +	  .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_X2121 },
>  	{}
>  };
> 
> --
> 2.23.0
> 

The series now looks great, thanks!

Benjamin, I can confirm that up to now all BLE devices don't have short
reports. I am not sure if you still want to only enable tested devices
but from an architectural standpoint everything here should be fine.

Mazin, you can have my

Reviewed-by: Filipe Laíns <lains@archlinux.org>

for the series.

Thank you,
Filipe Laíns
