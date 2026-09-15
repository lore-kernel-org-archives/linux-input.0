Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C30F3D75B5
	for <linux-input@vger.kernel.org>; Tue, 15 Sep 2026 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789446610; cv=none; b=ctbCnbP/mq6PpycRw96revAQGJ3x2M4cGKyz/LDDgyVM+9rJW3hz0M2qXXeRgRJ0ha7VZeFP3L/bhqwkwmXdE4ViShViKRNFwXtMlB5SEG3FIgjtET+3/1jHt7pXTW263V+1REDIpHxYWHRKf2Vp7p0QtXCDGGu945bcVVX3Zu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789446610; c=relaxed/simple;
	bh=M0S5yaTWV2jxon3GXnqFx3016pw+W1iE559NuEKUOQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZVmEI5GTKsWbv/7Ymp0vHOTPzEBM5yrL3W5PF6cIyyG/qvWcX6GY2lNcn1azNGCIxYW2cYCPwhwZFinQFg4lg6ljbFP+aD7qPRQHgQWanttrvytBgIgPRWcebxG4e64L742NeZg9KnZg1ANfq9xUG55uaIOtxvQoTuLQxZ0RW70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V34f3ikb; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V34f3ikb"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso2409575a91.3
        for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 21:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789446607; x=1790051407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BDvQuJ/rOoLrMqyktLy0LXLmDbVDlpOcUTTqLm4pVrE=;
        b=V34f3ikbsQ/qwEI8jee4vw2bfxE65NUVS+FAC4DX9KBUgRBjiUpQvyzcYhDzkQqgGj
         MfXSu9PYHgqbElkcnOC9dLddQnpL7TF3LqR9YPyB4NjANbTuaQgFG4/wRBbhbRNJJXNr
         8MqHDpxOTg0kGB3Y9pvyXAvOoHVXEB9rZp7wnOL+IItIUMIeN3+LcLJr7JNGtoxBBepT
         tatOWJl9aKqeK5QI1KUObwdc+Ktqoa1gbC6Cxa8nWxxiblrYiCIHSjFXBR7lv/RfYdDe
         ZhT3X0U7D6cG4M5D5zNGeMDvFm8aI02w+fEwbBRhv0lfUic5hXk2UTOLvwJUqWJxytD4
         B1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789446607; x=1790051407;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BDvQuJ/rOoLrMqyktLy0LXLmDbVDlpOcUTTqLm4pVrE=;
        b=CKN0H6oUuonXZLSguOANyS+GoQYY97lM38HuI4BAc3lldgg1A3AoStsV8vbmZ7fwrU
         foxzYT7xrfdVYPoy1bgEfDcqChNXEdQkMYjHBBMSdxgaTerxNJH+njRBpUVHRktXjjlb
         KXA9bo/WEwqiR0n8qjw6Au9GKVC5dO6MNOS9b5Vm7LQKFcrYfKaDxyvKojfT+N9UPEGb
         uIBs+qdzvL497E+LyrE7hhAWo3iDPva/i+X7flWewKlCk+BIniaVFPfTGBQtSQVyv+NK
         SaOy4gL/wT9sYKOl/29Ms5RfiGI+56kMFKHLSY6sj0QEzqrkR8rmjz2hZeNbYFmXJr5l
         YD7g==
X-Forwarded-Encrypted: i=1; AKwUvBzqgJhd4wxreESRO93lv+RarhitJs8egNCtOI3lai4NsYAP8kEem3ivmonw/nP6sXFfinuWLF8964vbRA==@vger.kernel.org
X-Gm-Message-State: AFuF++n23zQShsx9WmgjLDUMe2McJecYUWuSz+YWwceRXwMiZF7spJJj
	vyUfBQI7dNtLhf/4TzBiUVB02EM6Tp6lNoJluVJ3/iisW8z6qrZQy8b1
X-Gm-Gg: AYBFou2D22OEBlY5Mbn6bZxEQJPRUk91LdWdbaE11+REzYXa4B28AZoLlCU37jKlq6s
	NnwaRC4OGI1yRhpwsSLEkNx9Rjbi4J7wINUb+aoYGg50YuYiOs+xYITueBq09sFUAAkXuXohruq
	yELcl8Jxspeo7k3sTDl70LoWd+JiDdEylR35Guddlwve0LT+VmpAjDiStkiOaSupUOoEoWBQvea
	rralEZBR2kAgya8O9mqhjzikSJaElW/JMBUuxUcB93G2YANxZBnOcQnYnf7GMwqzTJMmOZRtqbJ
	lPdP6AsE+moaoYAUoRZkbPLdpwl0np+0+/BbaqUevcJ8N0qtCaDfH7YQBQh26lYkCSs2FXEdwjZ
	CXAx/x0ylWQt58wAWSHTViPFo/GHjbF0JgrWPMsWQwJH0MNNqbgikD8ggV3BJXzYuAD4zw+PWw9
	btvmu+qJ+9VMv+zMWcBoxiInIFF2Y+D0Cmm0IfjRnK5d+4gxoauYCqteyRUgHd0eKcCqTfSkx1M
	eus1/m3U3TmnjGdsXDKEEEZkphOU/+fNPD72nVtbeVYOOyx
X-Received: by 2002:a17:90b:390f:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39dec079f10mr10567966a91.14.1789446607196;
        Mon, 14 Sep 2026 21:30:07 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1438d89556asm3021593c88.13.2026.09.14.21.30.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2026 21:30:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a968a02f-c513-42f0-993f-ede4f785025c@roeck-us.net>
Date: Mon, 14 Sep 2026 21:30:04 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] hwmon: (aquacomputer_d5next) Add AMPINEL support
To: Vas Zayarskiy <contact@vasily.cc>, Aleksa Savic
 <savicaleksa83@gmail.com>, Jack Doan <me@jackdoan.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-hwmon@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
References: <20260914233728.22725-1-contact@vasily.cc>
 <20260914233728.22725-5-contact@vasily.cc>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260914233728.22725-5-contact@vasily.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/14/26 16:37, Vas Zayarskiy wrote:
> Add read-only total power, total current, input voltage, hotspot
> temperature and six channel currents for the Aquacomputer AMPINEL.
> 
> Decode its 544-byte input report through the existing serial-number,
> temperature and update path, with power, current and voltage handled in
> the device-specific switch. Store all readings in hwmon units.
> 
> Match only the USB telemetry interface, leaving the separate keyboard
> interface to hid-generic. Validate the telemetry collection and report
> size before opening the device. Channel labels follow report order;
> configuration and alarms are not supported.
> 
> Assisted-by: LLM sparse
> Signed-off-by: Vas Zayarskiy <contact@vasily.cc>
> ---
>   Documentation/hwmon/aquacomputer_d5next.rst |  11 ++
>   drivers/hwmon/Kconfig                       |   4 +-
>   drivers/hwmon/aquacomputer_d5next.c         | 107 +++++++++++++++++++-
>   3 files changed, 116 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 49163f387..faf1c51c1 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -13,6 +13,7 @@ Supported devices:
>   * Aquacomputer Quadro fan controller
>   * Aquacomputer High Flow Next sensor
>   * Aquacomputer Leakshield leak prevention system
> +* Aquacomputer AMPINEL power monitor
>   * Aquacomputer Aquastream XT watercooling pump
>   * Aquacomputer Aquastream Ultimate watercooling pump
>   * Aquacomputer Poweradjust 3 fan controller
> @@ -69,6 +70,16 @@ The Aquastream XT pump exposes temperature readings for the coolant, external se
>   and fan IC. It also exposes pump and fan speeds (in RPM), voltages, as well as pump
>   current.
>   
> +The AMPINEL exposes total power, total current, input voltage, hotspot
> +temperature and six channel currents. Channel numbers follow report order;
> +their mapping to physical connector pins has not been verified. The readings
> +are received approximately twice per second. Only sensor reads are supported;
> +the driver does not configure protection settings or report alarms.
> +
> +For AMPINEL, ``power1_input`` is total power, ``in0_input`` is input voltage,
> +``temp1_input`` is hotspot temperature, ``curr1_input`` is total current, and
> +``curr[2-7]_input`` are the six channel currents.
> +
>   The Aquastream Ultimate pump exposes coolant temp and an external temp sensor, along
>   with speed, power, voltage and current of both the pump and optionally connected fan.
>   It also exposes pressure and flow speed readings.
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 3d8b2c958..06cb246ff 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -257,14 +257,14 @@ config SENSORS_AHT10
>   	  will be called aht10.
>   
>   config SENSORS_AQUACOMPUTER_D5NEXT
> -	tristate "Aquacomputer D5 Next, Octo, Quadro, Farbwerk, Farbwerk 360, High Flow Next"
> +	tristate "Aquacomputer D5 Next and other USB devices"
>   	depends on USB_HID
>   	select CRC16
>   	help
>   	  If you say yes here you get support for sensors and fans of
>   	  the Aquacomputer D5 Next watercooling pump, Octo and Quadro fan
>   	  controllers, Farbwerk and Farbwerk 360 RGB controllers, High Flow
> -	  Next sensor, where available.
> +	  Next sensor and AMPINEL power monitor, where available.
>   
>   	  This driver can also be built as a module. If so, the module
>   	  will be called aquacomputer_d5next.
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index b58f5b5c9..e661c4dfa 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -2,7 +2,7 @@
>   /*
>    * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
>    * Quadro, High Flow Next, Aquaero, Aquastream Ultimate, Leakshield,
> - * High Flow USB/MPS Flow family)
> + * High Flow USB/MPS Flow family, AMPINEL)
>    *
>    * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>    * sensor values, except for devices that communicate through the
> @@ -23,6 +23,7 @@
>   #include <linux/module.h>
>   #include <linux/seq_file.h>
>   #include <linux/unaligned.h>
> +#include <linux/usb.h>
>   
>   #define USB_VENDOR_ID_AQUACOMPUTER	0x0c70
>   #define USB_PRODUCT_ID_AQUAERO		0xf001
> @@ -33,6 +34,7 @@
>   #define USB_PRODUCT_ID_OCTO		0xf011
>   #define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
>   #define USB_PRODUCT_ID_LEAKSHIELD	0xf014
> +#define USB_PRODUCT_ID_AMPINEL		0xf015
>   #define USB_PRODUCT_ID_AQUASTREAMXT	0xf0b6
>   #define USB_PRODUCT_ID_AQUASTREAMULT	0xf00b
>   #define USB_PRODUCT_ID_POWERADJUST3	0xf0bd
> @@ -41,7 +43,7 @@
>   enum kinds {
>   	d5next, farbwerk, farbwerk360, octo, quadro,
>   	highflownext, aquaero, poweradjust3, aquastreamult,
> -	aquastreamxt, leakshield, highflow
> +	aquastreamxt, leakshield, highflow, ampinel
>   };
>   
>   static const char *const aqc_device_names[] = {
> @@ -56,7 +58,8 @@ static const char *const aqc_device_names[] = {
>   	[aquaero] = "aquaero",
>   	[aquastreamult] = "aquastreamultimate",
>   	[poweradjust3] = "poweradjust3",
> -	[highflow] = "highflow" /* Covers MPS Flow devices */
> +	[highflow] = "highflow", /* Covers MPS Flow devices */
> +	[ampinel] = "ampinel"

Add "," at the end to avoid having to change it whenever a new device is added.

>   };
>   
>   #define DRIVER_NAME			"aquacomputer_d5next"
> @@ -111,6 +114,16 @@ static u8 aquaero_secondary_ctrl_report[] = {
>   #define AQC_FAN_POWER_OFFSET		0x06
>   #define AQC_FAN_SPEED_OFFSET		0x08
>   
> +/* AMPINEL offsets include the report ID byte. */
> +#define AMPINEL_DATA_INTERFACE		1
> +#define AMPINEL_STATUS_REPORT_SIZE	544
> +#define AMPINEL_NUM_CHANNELS		6
> +#define AMPINEL_CHANNEL_CURRENT_START	0x6f
> +#define AMPINEL_POWER			0xc7
> +#define AMPINEL_CURRENT			0xc9
> +#define AMPINEL_VOLTAGE			0xcf
> +#define AMPINEL_HOTSPOT			0xe1
> +
>   /* Specs of the Aquaero fan controllers */
>   #define AQUAERO_SERIAL_START			0x07
>   #define AQUAERO_FIRMWARE_VERSION		0x0B
> @@ -516,6 +529,24 @@ static const char *const label_highflow_speeds[] = {
>   	"Flow speed [dL/h]"
>   };
>   
> +static const char *const label_ampinel_temp[] = {
> +	"Hotspot"
> +};
> +
> +static const char *const label_ampinel_power[] = {
> +	"Total power"
> +};
> +
> +static const char *const label_ampinel_voltage[] = {
> +	"VCC In"
> +};
> +
> +static const char *const label_ampinel_current[] = {
> +	"Total current",
> +	"Channel 1", "Channel 2", "Channel 3",
> +	"Channel 4", "Channel 5", "Channel 6"
> +};
> +
>   struct aqc_fan_structure_offsets {
>   	u8 voltage;
>   	u8 curr;
> @@ -869,6 +900,10 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>   		break;
>   	case hwmon_power:
>   		switch (priv->kind) {
> +		case ampinel:
> +			if (channel == 0)
> +				return 0444;
> +			break;
>   		case aquastreamult:
>   			/* Special case to support pump and fan power */
>   			if (channel < 2)
> @@ -889,6 +924,10 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>   		break;
>   	case hwmon_curr:
>   		switch (priv->kind) {
> +		case ampinel:
> +			if (channel < AMPINEL_NUM_CHANNELS + 1)
> +				return 0444;
> +			break;
>   		case aquastreamult:
>   			/* Special case to support pump and fan current */
>   			if (channel < 2)
> @@ -907,6 +946,10 @@ static umode_t aqc_is_visible(const void *data, enum hwmon_sensor_types type, u3
>   		break;
>   	case hwmon_in:
>   		switch (priv->kind) {
> +		case ampinel:
> +			if (channel == 0)
> +				return 0444;
> +			break;
>   		case d5next:
>   			/* Special case to support +5V and +12V voltage sensors */
>   			if (channel < priv->num_fans + 2)
> @@ -1336,12 +1379,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>   		return 0;
>   
>   	priv = hid_get_drvdata(hdev);
> +	if (priv->kind == ampinel &&
> +	    (report->type != HID_INPUT_REPORT || size != AMPINEL_STATUS_REPORT_SIZE ||
> +	     data[0] != STATUS_REPORT_ID))
> +		return 0;
>   

This is again a bug fix affecting other controllers as well (report size and
input type check).

>   	/* Info provided with every report */
>   	priv->serial_number[0] = get_unaligned_be16(data + priv->serial_number_start_offset);
>   	priv->serial_number[1] = get_unaligned_be16(data + priv->serial_number_start_offset +
>   						    SERIAL_PART_OFFSET);
> -	priv->firmware_version = get_unaligned_be16(data + priv->firmware_version_offset);
> +	if (priv->firmware_version_offset)
> +		priv->firmware_version = get_unaligned_be16(data + priv->firmware_version_offset);

Unrelated to adding support for ampinel.

>   
>   	/* Physical temperature sensor readings */
>   	for (i = 0; i < priv->num_temp_sensors; i++) {
> @@ -1394,6 +1442,17 @@ static int aqc_raw_event(struct hid_device *hdev, struct hid_report *report, u8
>   
>   	/* Special-case sensor readings */
>   	switch (priv->kind) {
> +	case ampinel:
> +		priv->power_input[0] =
> +			min_t(u64, get_unaligned_be16(data + AMPINEL_POWER) * 100000ULL,
> +			      LONG_MAX);
> +		priv->current_input[0] = get_unaligned_be16(data + AMPINEL_CURRENT) * 10;
> +		for (i = 0; i < AMPINEL_NUM_CHANNELS; i++)
> +			priv->current_input[i + 1] =
> +				get_unaligned_be16(data + AMPINEL_CHANNEL_CURRENT_START +
> +						   i * AQC_SENSOR_SIZE);
> +		priv->voltage_input[0] = get_unaligned_be16(data + AMPINEL_VOLTAGE);
> +		break;
>   	case aquaero:
>   		/* Read calculated virtual temp sensors */
>   		i = priv->num_temp_sensors + priv->num_virtual_temp_sensors;
> @@ -1519,8 +1578,26 @@ static void aqc_debugfs_init(struct aqc_data *priv)
>   		debugfs_create_file("power_cycles", 0444, priv->debugfs, priv, &power_cycles_fops);
>   }
>   
> +static bool aqc_match(struct hid_device *hdev, bool ignore_special_driver)
> +{
> +	struct usb_interface *intf;
> +
> +	if (ignore_special_driver || hdev->quirks & HID_QUIRK_IGNORE_SPECIAL_DRIVER)
> +		return false;
> +
> +	if (hdev->product != USB_PRODUCT_ID_AMPINEL)
> +		return true;
> +
> +	if (!hid_is_usb(hdev))
> +		return false;
> +
> +	intf = to_usb_interface(hdev->dev.parent);
> +	return intf->cur_altsetting->desc.bInterfaceNumber == AMPINEL_DATA_INTERFACE;
> +}
> +
>   static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   {
> +	struct hid_report *report;
>   	struct aqc_data *priv;
>   	int ret;
>   
> @@ -1537,6 +1614,14 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   	if (ret)
>   		return ret;
>   
> +	if (hdev->product == USB_PRODUCT_ID_AMPINEL) {
> +		report = hdev->report_enum[HID_INPUT_REPORT].report_id_hash[STATUS_REPORT_ID];
> +		if (hdev->maxcollection != 1 ||
> +		    hdev->collection[0].usage != (HID_UP_MSVENDOR | 1) ||
> +		    !report || report->size != (AMPINEL_STATUS_REPORT_SIZE - 1) * 8)
> +			return -ENODEV;
> +	}

USB_PRODUCT_ID_AQUAERO has the same or a similar problem and handles it
in the switch statement below. I do not see a reason to handle this one
differently (including the need for the match function which doesn't seem
to be needed for USB_PRODUCT_ID_AQUAERO).

If the match function _is_ needed, the reason needs to be explained, even
more so since this may impact USB_PRODUCT_ID_AQUAERO.

> +
>   	ret = hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>   	if (ret)
>   		return ret;
> @@ -1546,6 +1631,15 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   		goto fail_and_stop;
>   
>   	switch (hdev->product) {
> +	case USB_PRODUCT_ID_AMPINEL:
> +		priv->kind = ampinel;
> +		priv->num_temp_sensors = 1;
> +		priv->temp_sensor_start_offset = AMPINEL_HOTSPOT;

FWIW, the raw even can happen prior to this, which will result
in bad data. This also affetcs other devices supported by this
driver (and those with fans can crash when it happens).

> +		priv->temp_label = label_ampinel_temp;
> +		priv->power_label = label_ampinel_power;
> +		priv->voltage_label = label_ampinel_voltage;
> +		priv->current_label = label_ampinel_current;
> +		break;
>   	case USB_PRODUCT_ID_AQUAERO:
>   		/*
>   		 * Aquaero presents itself as three HID devices under the same product ID:
> @@ -1795,6 +1889,9 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>   	}
>   
>   	switch (priv->kind) {
> +	case ampinel:
> +		priv->serial_number_start_offset = AQC_SERIAL_START;
> +		break;
>   	case aquaero:
>   		priv->serial_number_start_offset = AQUAERO_SERIAL_START;
>   		priv->firmware_version_offset = AQUAERO_FIRMWARE_VERSION;
> @@ -1890,6 +1987,7 @@ static const struct hid_device_id aqc_table[] = {
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_QUADRO) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_HIGHFLOWNEXT) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_LEAKSHIELD) },
> +	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AMPINEL) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMXT) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_AQUASTREAMULT) },
>   	{ HID_USB_DEVICE(USB_VENDOR_ID_AQUACOMPUTER, USB_PRODUCT_ID_POWERADJUST3) },
> @@ -1902,6 +2000,7 @@ MODULE_DEVICE_TABLE(hid, aqc_table);
>   static struct hid_driver aqc_driver = {
>   	.name = DRIVER_NAME,
>   	.id_table = aqc_table,
> +	.match = aqc_match,
>   	.probe = aqc_probe,
>   	.remove = aqc_remove,
>   	.raw_event = aqc_raw_event,

