From: Alexander Holler <holler@ahsoftware.de>
Subject: Re: [PATCH 3/3] HID: sensor-hub: don't limit the driver only to USB
 bus
Date: Mon, 18 Feb 2013 12:03:04 +0100
Message-ID: <51220A68.9030608@ahsoftware.de>
References: <1360578679-7029-1-git-send-email-mika.westerberg@linux.intel.com> <1360578679-7029-3-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from h1446028.stratoserver.net ([85.214.92.142]:35400 "EHLO
	mail.ahsoftware.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab3BRLDV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Feb 2013 06:03:21 -0500
In-Reply-To: <1360578679-7029-3-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, srinivas.pandruvada@intel.com

Am 11.02.2013 11:31, schrieb Mika Westerberg:
> We now have two transport mediums: USB and I2C, where sensor hubs can
> exists. So instead of constraining the driver to only these two we let it
> to match any HID bus as long as the group is HID_GROUP_SENSOR_HUB.
>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>   drivers/hid/hid-sensor-hub.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 2643bce9..c01f10d 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -603,7 +603,8 @@ static void sensor_hub_remove(struct hid_device *hdev)
>   }
>
>   static const struct hid_device_id sensor_hub_devices[] = {
> -	{ HID_DEVICE(BUS_USB, HID_GROUP_SENSOR_HUB, HID_ANY_ID, HID_ANY_ID) },
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
> +		     HID_ANY_ID) },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(hid, sensor_hub_devices);
>

Hmm, what happens with Bluetooth sensor-hubs? Is the driver now able to 
handle them too?

Regards,

Alexander
