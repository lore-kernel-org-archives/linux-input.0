From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/3] HID: wacom: Add support for I2C connected devices
Date: Tue, 24 Feb 2015 11:31:31 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502241131180.19920@pobox.suse.cz>
References: <1424699565-138045-1-git-send-email-mika.westerberg@linux.intel.com> <1424699565-138045-2-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56283 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752166AbbBXKbe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Feb 2015 05:31:34 -0500
In-Reply-To: <1424699565-138045-2-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mark Rutland <mark.rutland@arm.com>, sb@m-labs.hk, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 23 Feb 2015, Mika Westerberg wrote:

> Lenovo Thinkpad 10 has wacom digitizer connected as a I2C-HID device. Add
> generic support for this.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Applied, thanks.

> ---
>  drivers/hid/wacom_wac.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> index 1a6507999a65..c8e73bf62468 100644
> --- a/drivers/hid/wacom_wac.c
> +++ b/drivers/hid/wacom_wac.c
> @@ -2969,6 +2969,10 @@ static const struct wacom_features wacom_features_HID_ANY_ID =
>  	HID_DEVICE(BUS_BLUETOOTH, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
>  	.driver_data = (kernel_ulong_t)&wacom_features_##prod
>  
> +#define I2C_DEVICE_WACOM(prod)						\
> +	HID_DEVICE(BUS_I2C, HID_GROUP_WACOM, USB_VENDOR_ID_WACOM, prod),\
> +	.driver_data = (kernel_ulong_t)&wacom_features_##prod
> +
>  #define USB_DEVICE_LENOVO(prod)					\
>  	HID_USB_DEVICE(USB_VENDOR_ID_LENOVO, prod),			\
>  	.driver_data = (kernel_ulong_t)&wacom_features_##prod
> @@ -3113,6 +3117,7 @@ const struct hid_device_id wacom_ids[] = {
>  	{ USB_DEVICE_LENOVO(0x6004) },
>  
>  	{ USB_DEVICE_WACOM(HID_ANY_ID) },
> +	{ I2C_DEVICE_WACOM(HID_ANY_ID) },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(hid, wacom_ids);
> -- 
> 2.1.4
> 

-- 
Jiri Kosina
SUSE Labs
