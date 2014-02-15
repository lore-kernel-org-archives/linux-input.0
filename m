From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH] HID: hid-sensor-hub: quirk for STM Sensor hub
Date: Sat, 15 Feb 2014 11:00:55 +0000
Message-ID: <52FF48E7.9070400@kernel.org>
References: <1391411656-32684-1-git-send-email-archana.patni@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43905 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752800AbaBOLAU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 15 Feb 2014 06:00:20 -0500
In-Reply-To: <1391411656-32684-1-git-send-email-archana.patni@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Archana Patni <archana.patni@linux.intel.com>, jkosina@suse.cz
Cc: linux-input@vger.kernel.org, srinivas.pandruvada@linux.intel.com

On 03/02/14 07:14, Archana Patni wrote:
> Added STM sensor hub vendor id in HID_SENSOR_HUB_ENUM_QUIRK to
> fix report descriptors. These devices uses old FW which uses
> logical 0 as minimum. In these, HID reports are not using proper
> collection classes. So we need to fix report descriptors,for
> such devices. This will not have any impact, if the FW uses
> logical 1 as minimum.
>
> We look for usage id for "power and report state", and modify
> logical minimum value to 1.
>
> This is a follow-up patch to commit id 875e36f8.
>
> Signed-off-by: Archana Patni <archana.patni@linux.intel.com>
> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Hi Jiri,

I'm fine with any of these going in through the hid tree without without
my Ack given they are just marking which drivers need the quirk and
which do not.

Jonathan
> ---
>   drivers/hid/hid-ids.h        |    3 +++
>   drivers/hid/hid-sensor-hub.c |    3 +++
>   2 files changed, 6 insertions(+)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index 5a5248f..1fc5bee 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -451,6 +451,9 @@
>   #define USB_VENDOR_ID_INTEL_1		0x8087
>   #define USB_DEVICE_ID_INTEL_HID_SENSOR	0x09fa
>
> +#define USB_VENDOR_ID_STM_0             0x0483
> +#define USB_DEVICE_ID_STM_HID_SENSOR    0x91d1
> +
>   #define USB_VENDOR_ID_ION		0x15e4
>   #define USB_DEVICE_ID_ICADE		0x0132
>
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 46f4480..9c22e14 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -665,6 +665,9 @@ static const struct hid_device_id sensor_hub_devices[] = {
>   	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_INTEL_1,
>   			USB_DEVICE_ID_INTEL_HID_SENSOR),
>   			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
> +	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, USB_VENDOR_ID_STM_0,
> +			USB_DEVICE_ID_STM_HID_SENSOR),
> +			.driver_data = HID_SENSOR_HUB_ENUM_QUIRK},
>   	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_SENSOR_HUB, HID_ANY_ID,
>   		     HID_ANY_ID) },
>   	{ }
>

