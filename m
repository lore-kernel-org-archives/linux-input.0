From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] Input: elan_i2c - enable ELAN0100 acpi panels
Date: Mon, 24 Aug 2015 10:50:41 -0700
Message-ID: <20150824175041.GB22442@dtor-ws>
References: <1440229072-621-1-git-send-email-michele.curti@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33626 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751959AbbHXRuo (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Aug 2015 13:50:44 -0400
Content-Disposition: inline
In-Reply-To: <1440229072-621-1-git-send-email-michele.curti@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michele Curti <michele.curti@gmail.com>
Cc: jikos@kernel.org, dusonlin@emc.com.tw, bleung@chromium.org, k.kozlowski@samsung.com, charliemooney@chromium.org, benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Aug 22, 2015 at 09:37:52AM +0200, Michele Curti wrote:
> Enable ELAN0100 touchpad driver, found on a Asus X205TA laptop, to
> gai 2,3 fingers tap and 2 fingers scroll.
> 
> Signed-off-by: Michele Curti <michele.curti@gmail.com>

Applied, thank you (Duson, I put you as 'reviewed-by').

> ---
>  drivers/hid/hid-core.c              | 1 +
>  drivers/input/mouse/elan_i2c_core.c | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 22afab9..70a11ac 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -2294,6 +2294,7 @@ static const struct hid_device_id hid_ignore_list[] = {
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
>  	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0400) },
> +	{ HID_I2C_DEVICE(USB_VENDOR_ID_ELAN, 0x0401) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
>  	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index 67388f4..bbdaedc 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -98,6 +98,9 @@ static int elan_get_fwinfo(u8 ic_type, u16 *vaildpage_count,
>  			   u16 *signature_address)
>  {
>  	switch(ic_type) {
> +	case 0x08:
> +		*vaildpage_count = 512;
> +		break;
>  	case 0x09:
>  		*vaildpage_count = 768;
>  		break;
> @@ -1165,6 +1168,7 @@ MODULE_DEVICE_TABLE(i2c, elan_id);
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id elan_acpi_id[] = {
>  	{ "ELAN0000", 0 },
> +	{ "ELAN0100", 0 },
>  	{ "ELAN0600", 0 },
>  	{ }
>  };
> -- 
> 2.5.0
> 

-- 
Dmitry
