From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: Support i2c-hid multitouch compatible Wacom
 touchscreens
Date: Thu, 27 Apr 2017 17:09:28 +0200
Message-ID: <20170427150928.GA28152@mail.corp.redhat.com>
References: <20170427135757.29947-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21029 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932150AbdD0PJe (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Apr 2017 11:09:34 -0400
Content-Disposition: inline
In-Reply-To: <20170427135757.29947-1-jarkko.nikula@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, Jason Gerecke <killertofu@gmail.com>, Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Apr 27 2017 or thereabouts, Jarkko Nikula wrote:
> Vendor specific handling in hid_scan_report() overrides the hid->group
> to HID_GROUP_WACOM for all devices with vendor ID equal to
> USB_VENDOR_ID_WACOM.
> 
> However there is an i2c-hid multitouch compatible Wacom touschreen which
> is parsed as generic HID_GROUP_MULTITOUCH_WIN_8 device but
> hid-multitouch doesn't probe because of this overriding.
> 
> Support this touschreen by overring the group only when the bus is
> different than I2C.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> I'm not an HID expert and I don't know is there any existing Wacom
> tablets using the I2C bus. There are USB and Bluetooth tablets so that's

I'd say there are other I2C Wacom tablets. Jason and Ping can confirm.

> the reason I'm checking id->bus != BUS_I2C when overring the group.
> I've done only basic testing that device is registered as an
> hid-multitouch device and "hexdump /dev/input/eventX" produces a bunch
> of hexadecimals when touschscreen is touched.

What's the issue of having wacom.ko loaded for this particular
touchscreen? wacom.ko should handle it properly.

Cheers,
Benjamin

> ---
>  drivers/hid/hid-core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index d162f0dc76e3..cfb0b7262de7 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -816,7 +816,8 @@ static int hid_scan_report(struct hid_device *hid)
>  	 */
>  	switch (hid->vendor) {
>  	case USB_VENDOR_ID_WACOM:
> -		hid->group = HID_GROUP_WACOM;
> +		if (hid->bus != BUS_I2C)
> +			hid->group = HID_GROUP_WACOM;
>  		break;
>  	case USB_VENDOR_ID_SYNAPTICS:
>  		if (hid->group == HID_GROUP_GENERIC)
> -- 
> 2.11.0
> 
