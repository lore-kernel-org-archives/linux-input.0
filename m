From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-sensor-hub: Adding USB_DEVICE_ID_STM_HID_SENSOR
 device id
Date: Thu, 4 Sep 2014 08:50:14 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1409040849520.12309@pobox.suse.cz>
References: <1409785254-20245-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:49899 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068AbaIDGuS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Sep 2014 02:50:18 -0400
In-Reply-To: <1409785254-20245-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: elad@fedoraproject.org, linux-input@vger.kernel.org

On Wed, 3 Sep 2014, Srinivas Pandruvada wrote:

> Adding USB_DEVICE_ID_STM_HID_SENSOR again in the quirk table. During 3.16 merge
> cycle somehow quirk for device id USB_DEVICE_ID_STM_HID_SENSOR is missing.
> I see commit dde3b45cd74e ("HID: hid-sensor-hub: new device id and quirk
> for STM Sensor hub") added new id USB_DEVICE_ID_STM_HID_SENSOR_1,
> but didn't really delete the old device id.
> Anyway we need to add this back, otherwise it breaks ST sensor hubs.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/hid/hid-sensor-hub.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 2ac2576..e6d8e18 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -709,6 +709,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
>  			USB_DEVICE_ID_MS_TYPE_COVER_2),
>  			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_STM_0,
> +			USB_DEVICE_ID_STM_HID_SENSOR),
> +			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_STM_0,
>  			USB_DEVICE_ID_STM_HID_SENSOR_1),
>  			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_TEXAS_INSTRUMENTS,

Queued for 3.17.

-- 
Jiri Kosina
SUSE Labs
