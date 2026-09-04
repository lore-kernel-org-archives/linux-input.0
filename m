Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE0B51D500;
	Fri,  4 Sep 2026 21:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557426; cv=none; b=R1Jl3zun8xNWtL7vJtQ2si9isNIa9MKEzrT4JAZ+Xm7fLNq6K0BW2aB6YYHrT0fBepDyHurUPHwl/PCUNv4ym3u0fbQY7D8UBQ5d3fSwzORnSQmOlzmn4gp2gX0vwo1ZLLXDSbZz9pD7RZc+oNzZer2aerJJnANusHolNAmkRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557426; c=relaxed/simple;
	bh=OFez2jWiEHrmrZ/msjTfiKLe3ZhDGnYttnN1wNf1tzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IiQT1uMbvxgLpcrnnnQMud53H1bVm482WSQcIKwiRMHBj3a1EL8wcr0vZyWTJDNfOmcgDuLUQoEKgVkW2HYy/GfJfTox+6JikSfLlChyqIcumIzR65/yVVuZT0iRPff1oXPJhyxOYsB+lUGl/kQi0io02rRFGL1jry7fm6xvDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=ZJSW48el; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="ZJSW48el"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788557415; x=1789162215; i=w_armin@gmx.de;
	bh=7TRpN0U2qtev+NF8ubOMnb281peZSLtgCc1WwA55/m0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ZJSW48ele9fVPv7DpUSIfdfay6FF1LT/QUoxlKjRAI24qtzDS8GcAsTg1y3OM+SS
	 KDgeYK0g9VvA+cT89nqVVaqkapaAg01tHA+OUqq0tSJgEFmEwtP34rEF8X/hBvbol
	 5rwM3qcfVzkcKsKfIbG7fOh1PzskrjIump9ALDF0XItXWm65BWchXR7oDxt6Z3ZVP
	 pu+X90QdsENm5jNCiO6xF0+1AS0QtjfSdiKkQwzeu10LB6fQIMyXVAZjT260dm2wV
	 N91W+sjSMk7RyZZGnAZ1UH5aJgGYB2x7nqeoBTdb2uehUAEw097Mo1fUrFUNrT3CC
	 7QVEzB6cIljlWMX3xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M26r3-1x07aA13jV-0092jL; Fri, 04
 Sep 2026 23:30:15 +0200
Message-ID: <dfcf2cb6-ab64-41a1-8fc5-748f4f47c58f@gmx.de>
Date: Fri, 4 Sep 2026 23:30:14 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] HID: lamparray: add new LampArray helper module
To: Aaron Erhardt <aer@tuxedocomputers.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: wse@tuxedocomputers.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903073602.3815258-1-aer@tuxedocomputers.com>
 <20260903073602.3815258-2-aer@tuxedocomputers.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260903073602.3815258-2-aer@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/XkfyhqLOsx5QIyZUfVEV8aOG7L/5T3FSu4uRHAN50bkxwU+EBu
 MBwmJ98XWQF0uk8502hnkjk7roAAKH3/eXKBhbGgtbtZ2LqArz87NdmzCF6hl8Wcg+nMtHH
 lbggIla0WpiKUNTJy+9thGsG5RBr8hag8V2q4DtmjUzYyly4HYIhepIkZGrDXqY2X0vt1n4
 n+N9ad3E6ZLq1VD1LBMeQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:t0vj7kfPPSA=;LCyrIi++pdp19qY1uK5h/k+bG+q
 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
 WjjyjFLLGiS0/PgApZ/e+0yICHG3PGNua7w==

Am 03.09.26 um 09:35 schrieb Aaron Erhardt:

> Add a new hid-lamparray helper module that provides basic support for
> devices exposing a Lighting/LampArray application collection (usage
> page 0x59) and registers a single-zone RGB LED representation via the
> LED subsystem.
>
> The module can be used as a library in HID drivers to add support for
> the HID LampArray protocol. While the API is quite basic as of now
> it could be extended in the future.
>
> Co-developed-by: Tim Guttzeit <tgu@tuxedocomputers.com>
> Signed-off-by: Tim Guttzeit <tgu@tuxedocomputers.com>
> Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
> ---
>   .../ABI/testing/sysfs-driver-hid-lamparray    |  16 +
>   drivers/hid/Kconfig                           |  17 +
>   drivers/hid/Makefile                          |   2 +
>   drivers/hid/hid-lamparray.c                   | 812 ++++++++++++++++++
>   include/linux/hid-lamparray.h                 |  88 ++
>   5 files changed, 935 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lamparra=
y
>   create mode 100644 drivers/hid/hid-lamparray.c
>   create mode 100644 include/linux/hid-lamparray.h
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lamparray b/Docu=
mentation/ABI/testing/sysfs-driver-hid-lamparray
> new file mode 100644
> index 000000000000..795be6c4c368
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lamparray
> @@ -0,0 +1,16 @@
> +What:		/sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/use_leds_uapi
> +Date:		August 2026
> +KernelVersion:	7.3
> +Contact:	aer@tuxedocomputers.com
> +Description:
> +        If a driver uses the hid-lamparray module and a device supporti=
ng
> +        LampArray is found, one multicolor LED class device is register=
ed under
> +        /sys/class/leds/rgb:<function> to expose the single-zone RGB co=
ntrol.
> +        Every device gets an incremental unique id.
> +
> +        Additionally, the use_leds_uapi sysfs attribute to control the =
LED class
> +        device is attached directly to the HID device at
> +        /sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/use_leds_uapi. Writi=
ng 0 to
> +        use_leds_uapi unregisters the LED class device. The last state =
is kept
> +        cached. Writing 1 registers it again and restores the cached st=
ate to
> +        hardware.
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index aa7fa11a0197..4afd80a67b39 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -92,6 +92,23 @@ config HID_GENERIC
>  =20
>   	If unsure, say Y.
>  =20
> +config HID_LAMPARRAY
> +	tristate "HID LampArray helper"
> +	depends on HID
> +	depends on LEDS_CLASS_MULTICOLOR
> +	default n
> +	help
> +	  Helper for HID devices exposing a Lighting/LampArray collection.
> +	  Treats LampArray devices as a single-zone device and exposes a sysfs
> +	  interface for changing color and intensity values. Also exposes a
> +	  sysfs flag to be disabled e.g. by a userspace driver.
> +
> +	  This can be used as library in existing drivers. The generic HID
> +	  driver is extended by default to handle lamp array devices if this
> +	  option is enabled.
> +
> +	  If unsure, say N.
> +
>   config HID_HAPTIC
>   	bool "Haptic touchpad support"
>   	default n
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 48a863b245ee..f95630fa8bd8 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -13,6 +13,8 @@ obj-$(CONFIG_UHID)		+=3D uhid.o
>  =20
>   obj-$(CONFIG_HID_GENERIC)	+=3D hid-generic.o
>  =20
> +obj-$(CONFIG_HID_LAMPARRAY)	+=3D hid-lamparray.o
> +
>   hid-$(CONFIG_HIDRAW)		+=3D hidraw.o
>  =20
>   hid-logitech-y		:=3D hid-lg.o
> diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
> new file mode 100644
> index 000000000000..9a438aa2d305
> --- /dev/null
> +++ b/drivers/hid/hid-lamparray.c
> @@ -0,0 +1,812 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * hid-lamparray.c - HID LampArray helper module (single-zone RGB)
> + *
> + * Helper module for HID drivers supporting devices that expose a Light=
ing and
> + * Illumination (LampArray) application collection (usage page 0x59).
> + *
> + * The module provides a minimal integration with the LED subsystem and=
 treats
> + * the device as a single zone: all lamps share one RGB value and a glo=
bal
> + * brightness level. It does not implement multi-zone layouts or hardwa=
re
> + * effects.
> + *
> + * If enabled and a device supporting LampArray is found, one multicolo=
r LED
> + * class device is registered under /sys/class/leds/<HID-ID>:rgb:LampAr=
ray to
> + * expose the single-zone RGB control.
> + *
> + * The use_leds_uapi sysfs attribute is attached directly to the HID de=
vice
> + * under /sys/bus/hid/devices/<HID-ID>/use_leds_uapi. Writing 0 to use_=
leds_uapi
> + * unregisters the LED class device. The last state is kept cached. Wri=
ting 1
> + * registers it again and restores the cached state to hardware. State =
is cached
> + * as last known RGB + brightness.
> + *
> + * The module does not bind to devices on its own. Instead, a HID drive=
r may
> + * query support via lamparray_is_supported_device() after hid_parse() =
and
> + * create an instance using lamparray_register().
> + *
> + * Copyright (C) 2026 Tim Guttzeit <tgu@tuxedocomputers.com>
> + * Copyright (C) 2026 Aaron Erhardt <aer@tuxedocomputers.com>
> + */
> +
> +#include <dt-bindings/leds/common.h>
> +#include <linux/limits.h>
> +#include <linux/minmax.h>
> +#include <linux/hid.h>
> +#include <linux/leds.h>
> +#include <linux/sysfs.h>
> +#include <linux/hid-lamparray.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/container_of.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/xarray.h>
> +
> +/* Constants */
> +
> +/* HID usages (LampArray, etc.) */
> +#define HID_LIGHTING_ILLUMINATION_USAGE_PAGE	0x0059
> +
> +/* HID usage types */
> +#define HID_APPLICATION_COLLECTION_USAGE_TYPE	0x0001
> +#define HID_LAMPARRAY_ATTRIBUTES_REPORT	0x0002
> +#define HID_LAMP_ATTRIBUTES_RESPONSE_REPORT	0x0022
> +#define HID_LAMP_RANGE_UPDATE_REPORT		0x0060
> +#define HID_LAMPARRAY_CONTROL_REPORT		0x0070
> +
> +/* HID attributes */
> +#define HID_LAIP_LAMP_COUNT			0x0003
> +#define HID_LAIP_LAMPARRAY_KIND			0x0007
> +#define HID_LAIP_RED_LEVEL_COUNT		0x0028
> +#define HID_LAIP_GREEN_LEVEL_COUNT		0x0029
> +#define HID_LAIP_BLUE_LEVEL_COUNT		0x002a
> +#define HID_LAIP_INTENSITY_LEVEL_COUNT		0x002b
> +#define HID_LAIP_RED_UPDATE_CHANNEL		0x0051
> +#define HID_LAIP_GREEN_UPDATE_CHANNEL		0x0052
> +#define HID_LAIP_BLUE_UPDATE_CHANNEL		0x0053
> +#define HID_LAIP_INTENSITY_UPDATE_CHANNEL	0x0054
> +#define HID_LAIP_LAMP_ID_START			0x0061
> +#define HID_LAIP_LAMP_ID_END			0x0062
> +#define HID_LAIP_AUTONOMOUS_MODE		0x0071
> +
> +/* LampArrayKind values */
> +#define HID_LAMPARRAY_KIND_KEYBOARD		0x0001
> +
> +/* Helper struct for fields and their indices */
> +struct hid_field_value {
> +	struct hid_field *field;
> +	int index;
> +};
> +
> +/* Helper struct for color fields */
> +struct lamparray_color_fields {
> +	struct hid_field_value red;
> +	struct hid_field_value green;
> +	struct hid_field_value blue;
> +	struct hid_field_value intensity;
> +};
> +
> +/* Device state */
> +struct lamparray_device {
> +	struct hid_device *hdev;
> +
> +	struct lamparray_color_fields color_levels;
> +	struct lamparray_color_fields color_update;
> +
> +	struct hid_field_value autonomous_field;
> +	struct hid_field_value range_start;
> +	struct hid_field_value range_end;
> +	struct hid_field_value lamp_count;
> +	struct hid_field_value lamparray_kind;
> +
> +	u16 lamp_count_value;
> +	u32 lamparray_kind_value;
> +
> +	struct led_classdev_mc mc_cdev;
> +	struct mc_subled subleds[3];
> +
> +	struct mutex dev_lock; /* Protects cached state and HID access */
> +	struct mutex sysfs_lock; /* Protects sysfs LED (de-)initialization */
> +
> +	u8 max_r;
> +	u8 max_g;
> +	u8 max_b;
> +	u8 max_brightness;
> +
> +	u8 last_r;
> +	u8 last_g;
> +	u8 last_b;
> +	u8 last_brightness;
> +
> +	bool use_leds_uapi;
> +	bool led_registered;
> +};
> +
> +/*
> + * Opaque handle exposed to callers via the header.
> + * Keep the actual state in lamparray_device, but return a stable point=
er.
> + */
> +struct lamparray {
> +	struct lamparray_device ldev;
> +};
> +
> +/*
> + * Mapping for hid_device pointers to their lamparray data.
> + * Since there is not guarantee of how the driver using this library
> + * will use its drvdata, the only safe way to retrieve the lamparray
> + * data from a HID device pointer is using this mapping.
> + */
> +static DEFINE_XARRAY(lamparray_by_hdev);
> +
> +/* HID helper functions */
> +
> +static int get_field_value(struct hid_field_value *field_value)
> +{
> +	return field_value->field->value[field_value->index];
> +}
> +
> +static u8 get_field_value_as_u8(struct hid_field_value *field_value)
> +{
> +	return clamp_val(get_field_value(field_value), 0, U8_MAX);
> +}
> +
> +static void set_field_value(struct hid_field_value *field_value, int va=
lue)
> +{
> +	field_value->field->value[field_value->index] =3D value;
> +}
> +
> +static bool lamparray_color_fields_is_complete(struct lamparray_color_f=
ields *color_fields)
> +{
> +	return color_fields->red.field && color_fields->green.field &&
> +	       color_fields->blue.field && color_fields->intensity.field;
> +}
> +
> +static int lamparray_read_attributes_report(struct lamparray_device *ld=
ev)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_report *report;
> +
> +	if (!ldev->lamp_count.field) {
> +		hid_dbg(hdev, "No LampCount field found\n");
> +		return -ENODEV;
> +	}
> +
> +	if (!ldev->lamparray_kind.field) {
> +		hid_dbg(hdev, "No LampArrayKind field found\n");
> +		return -ENODEV;
> +	}
> +
> +	report =3D ldev->lamp_count.field->report;
> +
> +	if (!report) {
> +		hid_dbg(hdev, "LampCount field has no report\n");
> +		return -ENODEV;
> +	}
> +
> +	mutex_lock(&ldev->dev_lock);
> +
> +	/* Update values */
> +	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
> +	hid_hw_wait(hdev);
> +
> +	ldev->lamp_count_value =3D get_field_value(&ldev->lamp_count);
> +
> +	if (ldev->lamp_count_value =3D=3D 0) {
> +		mutex_unlock(&ldev->dev_lock);
> +		hid_dbg(hdev, "LampCount is %d (invalid)\n", ldev->lamp_count_value);
> +		return -EINVAL;
> +	}
> +
> +	ldev->lamparray_kind_value =3D get_field_value(&ldev->lamparray_kind);
> +
> +	mutex_unlock(&ldev->dev_lock);
> +
> +	return 0;
> +}
> +
> +static int lamparray_parse_update_report(struct lamparray_device *ldev)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_report_enum *re;
> +	struct hid_report *report;
> +	struct hid_field *field;
> +	int i, j;
> +	int ret =3D 0;
> +
> +	mutex_lock(&ldev->dev_lock);
> +
> +	re =3D &hdev->report_enum[HID_FEATURE_REPORT];
> +
> +	list_for_each_entry(report, &re->report_list, list) {
> +		for (i =3D 0; i < report->maxfield; i++) {
> +			field =3D report->field[i];
> +			if (!field)
> +				continue;
> +
> +			if (!field->usage || !field->maxusage)
> +				continue;
> +
> +			for (j =3D 0; j < field->maxusage; j++) {
> +				u32 usage =3D field->usage[j].hid;
> +				u32 collection_idx =3D field->usage[j].collection_index;
> +				u32 collection_usage =3D hdev->collection[collection_idx].usage;
> +
> +				u16 page =3D (usage & HID_USAGE_PAGE) >> 16;
> +				u16 id =3D usage & HID_USAGE;
> +				u16 collection_usage_id =3D collection_usage & U16_MAX;
> +
> +				if (page !=3D HID_LIGHTING_ILLUMINATION_USAGE_PAGE)
> +					continue;
> +
> +				if (collection_usage_id =3D=3D HID_LAMPARRAY_ATTRIBUTES_REPORT) {
> +					switch (id) {
> +					case HID_LAIP_LAMP_COUNT:
> +						ldev->lamp_count.field =3D field;
> +						ldev->lamp_count.index =3D j;
> +						break;
> +					case HID_LAIP_LAMPARRAY_KIND:
> +						ldev->lamparray_kind.field =3D field;
> +						ldev->lamparray_kind.index =3D j;
> +						break;
> +					}
> +				} else if (collection_usage_id =3D=3D
> +					   HID_LAMP_ATTRIBUTES_RESPONSE_REPORT) {
> +					switch (id) {
> +					case HID_LAIP_RED_LEVEL_COUNT:
> +						ldev->color_levels.red.field =3D field;
> +						ldev->color_levels.red.index =3D j;
> +						break;
> +					case HID_LAIP_GREEN_LEVEL_COUNT:
> +						ldev->color_levels.green.field =3D field;
> +						ldev->color_levels.green.index =3D j;
> +						break;
> +					case HID_LAIP_BLUE_LEVEL_COUNT:
> +						ldev->color_levels.blue.field =3D field;
> +						ldev->color_levels.blue.index =3D j;
> +						break;
> +					case HID_LAIP_INTENSITY_LEVEL_COUNT:
> +						ldev->color_levels.intensity.field =3D field;
> +						ldev->color_levels.intensity.index =3D j;
> +						break;
> +					}
> +				} else if (collection_usage_id =3D=3D HID_LAMP_RANGE_UPDATE_REPORT)=
 {
> +					switch (id) {
> +					case HID_LAIP_RED_UPDATE_CHANNEL:
> +						ldev->color_update.red.field =3D field;
> +						ldev->color_update.red.index =3D j;
> +						break;
> +					case HID_LAIP_GREEN_UPDATE_CHANNEL:
> +						ldev->color_update.green.field =3D field;
> +						ldev->color_update.green.index =3D j;
> +						break;
> +					case HID_LAIP_BLUE_UPDATE_CHANNEL:
> +						ldev->color_update.blue.field =3D field;
> +						ldev->color_update.blue.index =3D j;
> +						break;
> +					case HID_LAIP_INTENSITY_UPDATE_CHANNEL:
> +						ldev->color_update.intensity.field =3D field;
> +						ldev->color_update.intensity.index =3D j;
> +						break;
> +					case HID_LAIP_LAMP_ID_START:
> +						ldev->range_start.field =3D field;
> +						ldev->range_start.index =3D j;
> +						break;
> +					case HID_LAIP_LAMP_ID_END:
> +						ldev->range_end.field =3D field;
> +						ldev->range_end.index =3D j;
> +						break;
> +					default:
> +						break;
> +					}
> +				} else if (collection_usage_id =3D=3D HID_LAMPARRAY_CONTROL_REPORT =
&&
> +					   id =3D=3D HID_LAIP_AUTONOMOUS_MODE) {
> +					ldev->autonomous_field.field =3D field;
> +					ldev->autonomous_field.index =3D j;
> +				}
> +			}
> +		}
> +	}
> +
> +	if (!ldev->autonomous_field.field ||
> +	    !lamparray_color_fields_is_complete(&ldev->color_update))
> +		ret =3D -ENODEV;
> +
> +	mutex_unlock(&ldev->dev_lock);
> +
> +	return ret;
> +}
> +
> +static int lamparray_hw_set_autonomous(struct lamparray_device *ldev,
> +				       bool enable)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_field *field =3D ldev->autonomous_field.field;
> +
> +	if (!field)
> +		return -ENODEV;
> +
> +	mutex_lock(&ldev->dev_lock);
> +
> +	set_field_value(&ldev->autonomous_field, !!enable);
> +
> +	hid_hw_request(hdev, field->report, HID_REQ_SET_REPORT);
> +	hid_hw_wait(hdev);
> +
> +	mutex_unlock(&ldev->dev_lock);
> +
> +	return 0;
> +}
> +
> +static int lamparray_hw_set_state(struct lamparray_device *ldev, u8 r, =
u8 g,
> +				  u8 b, u8 intensity)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_report *report;
> +
> +	if (!lamparray_color_fields_is_complete(&ldev->color_update))
> +		return -ENODEV;
> +
> +	if (ldev->range_start.field && ldev->range_end.field) {
> +		set_field_value(&ldev->range_start, 0);
> +		set_field_value(&ldev->range_end, ldev->lamp_count_value - 1);
> +	}
> +
> +	set_field_value(&ldev->color_update.red, r);
> +	set_field_value(&ldev->color_update.green, g);
> +	set_field_value(&ldev->color_update.blue, b);
> +	set_field_value(&ldev->color_update.intensity, intensity);
> +
> +	report =3D ldev->color_update.red.field->report;
> +	hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
> +	hid_hw_wait(hdev);
> +
> +	return 0;
> +}
> +
> +/*
> + * Simple helper to read the color information of the first lamp.
> + * This does not read the state of the whole lamp array since this driv=
er only
> + * exposes one LED anyway, so one color is sufficient here for now.
> + */
> +static int lamparray_get_lamp_attributes(struct lamparray_device *ldev)
> +{
> +	struct hid_device *hdev =3D ldev->hdev;
> +	struct hid_report *report;
> +
> +	if (!lamparray_color_fields_is_complete(&ldev->color_levels))
> +		return -ENODEV;
> +
> +	/*
> +	 * Get value of any lamp.
> +	 */
> +	report =3D ldev->color_levels.red.field->report;
> +
> +	mutex_lock(&ldev->dev_lock);
> +
> +	hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
> +	hid_hw_wait(hdev);
> +
> +	ldev->max_r =3D get_field_value_as_u8(&ldev->color_levels.red);
> +	ldev->max_g =3D get_field_value_as_u8(&ldev->color_levels.green);
> +	ldev->max_b =3D get_field_value_as_u8(&ldev->color_levels.blue);
> +	ldev->max_brightness =3D get_field_value_as_u8(&ldev->color_levels.int=
ensity);
> +
> +	mutex_unlock(&ldev->dev_lock);
> +
> +	return 0;
> +}
> +
> +/* Helper functions */
> +
> +static int lamparray_restore_state(struct lamparray_device *ldev)
> +{
> +	u8 r, g, b;
> +	int ret;
> +	enum led_brightness brightness;
> +
> +	mutex_lock(&ldev->dev_lock);
> +
> +	if (!ldev->use_leds_uapi) {
> +		mutex_unlock(&ldev->dev_lock);
> +		return 0;
> +	}
> +
> +	r =3D ldev->last_r;
> +	g =3D ldev->last_g;
> +	b =3D ldev->last_b;
> +	brightness =3D ldev->last_brightness;
> +
> +	ldev->mc_cdev.subled_info[0].intensity =3D r;
> +	ldev->mc_cdev.subled_info[1].intensity =3D g;
> +	ldev->mc_cdev.subled_info[2].intensity =3D b;
> +	ldev->mc_cdev.led_cdev.brightness =3D brightness;
> +
> +	led_mc_calc_color_components(&ldev->mc_cdev, brightness);

Hi,

since you are not using the brightness of the subleds, this call to
led_mc_calc_color_components() is unnecessary.

> +
> +	ret =3D lamparray_hw_set_state(ldev, r, g, b, brightness);
> +
> +	mutex_unlock(&ldev->dev_lock);
> +	return ret;
> +}
> +
> +/* LEDs API */
> +
> +static int lamparray_led_brightness_set(struct led_classdev *cdev,
> +					enum led_brightness brightness)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct lamparray_device *ldev =3D
> +		container_of_const(mc, struct lamparray_device, mc_cdev);
> +	u8 r, g, b;
> +	int ret;
> +
> +	/*
> +	 * Brightness is handled by the LampArray device if supported,
> +	 * so we can pass the raw intensity values.
> +	 */
> +	r =3D mc->subled_info[0].intensity;
> +	g =3D mc->subled_info[1].intensity;
> +	b =3D mc->subled_info[2].intensity;
> +
> +	mc->led_cdev.brightness =3D brightness;
> +	led_mc_calc_color_components(&ldev->mc_cdev, brightness);

Same here, the assignment of mc->led_cdev.brightness is also already prefo=
rmed
by the LED core itself.

Thanks,
Armin Wolf

> +	mutex_lock(&ldev->dev_lock);
> +	ret =3D lamparray_hw_set_state(ldev, r, g, b, brightness);
> +	if (ret) {
> +		mutex_unlock(&ldev->dev_lock);
> +		hid_err(ldev->hdev, "Failed to send LampArray update: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	ldev->last_r =3D r;
> +	ldev->last_g =3D g;
> +	ldev->last_b =3D b;
> +	ldev->last_brightness =3D brightness;
> +	mutex_unlock(&ldev->dev_lock);
> +
> +	return 0;
> +}
> +
> +static enum led_brightness
> +lamparray_led_brightness_get(struct led_classdev *cdev)
> +{
> +	struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +	struct lamparray_device *ldev =3D
> +	    container_of_const(mc, struct lamparray_device, mc_cdev);
> +
> +	return ldev->last_brightness;
> +}
> +
> +static int lamparray_register_led(struct lamparray_device *ldev)
> +{
> +	struct device *dev =3D &ldev->hdev->dev;
> +	struct led_classdev *cdev =3D &ldev->mc_cdev.led_cdev;
> +	int ret;
> +
> +	mutex_lock(&ldev->sysfs_lock);
> +
> +	if (ldev->led_registered) {
> +		mutex_unlock(&ldev->sysfs_lock);
> +		return 0;
> +	}
> +
> +	if (!cdev->name) {
> +		/* Fallback value */
> +		const char *function =3D LED_FUNCTION_STATUS;
> +
> +		/* Some heuristics for choosing a better LED function. */
> +		if (ldev->lamparray_kind_value =3D=3D HID_LAMPARRAY_KIND_KEYBOARD)
> +			function =3D LED_FUNCTION_KBD_BACKLIGHT;
> +
> +		cdev->name =3D kasprintf(GFP_KERNEL, "rgb:%s", function);
> +		if (!cdev->name) {
> +			mutex_unlock(&ldev->sysfs_lock);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	mutex_lock(&ldev->dev_lock);
> +	/* Setup */
> +	cdev->max_brightness =3D ldev->max_brightness;
> +	cdev->brightness_set_blocking =3D lamparray_led_brightness_set;
> +	cdev->brightness_get =3D lamparray_led_brightness_get;
> +	cdev->flags |=3D LED_RETAIN_AT_SHUTDOWN;
> +
> +	ldev->subleds[0].color_index =3D LED_COLOR_ID_RED;
> +	ldev->subleds[0].max_intensity =3D ldev->max_r;
> +	ldev->subleds[1].color_index =3D LED_COLOR_ID_GREEN;
> +	ldev->subleds[1].max_intensity =3D ldev->max_g;
> +	ldev->subleds[2].color_index =3D LED_COLOR_ID_BLUE;
> +	ldev->subleds[2].max_intensity =3D ldev->max_b;
> +
> +	/* Set values */
> +	ldev->subleds[0].intensity =3D ldev->last_r;
> +	ldev->subleds[1].intensity =3D ldev->last_g;
> +	ldev->subleds[2].intensity =3D ldev->last_b;
> +	cdev->brightness =3D ldev->last_brightness;
> +
> +	ldev->mc_cdev.subled_info =3D ldev->subleds;
> +	ldev->mc_cdev.num_colors =3D ARRAY_SIZE(ldev->subleds);
> +
> +	/* Ensure subled_info[].brightness matches intensity + brightness */
> +	led_mc_calc_color_components(&ldev->mc_cdev, ldev->last_brightness);
> +	mutex_unlock(&ldev->dev_lock);
> +
> +	ret =3D led_classdev_multicolor_register(dev, &ldev->mc_cdev);
> +	if (ret) {
> +		mutex_unlock(&ldev->sysfs_lock);
> +		return ret;
> +	}
> +
> +	ldev->led_registered =3D true;
> +	mutex_unlock(&ldev->sysfs_lock);
> +
> +	return 0;
> +}
> +
> +static void lamparray_unregister_led(struct lamparray_device *ldev)
> +{
> +	bool was_registered;
> +	struct led_classdev *cdev =3D &ldev->mc_cdev.led_cdev;
> +
> +	mutex_lock(&ldev->sysfs_lock);
> +	was_registered =3D ldev->led_registered;
> +	ldev->led_registered =3D false;
> +
> +	if (was_registered)
> +		led_classdev_multicolor_unregister(&ldev->mc_cdev);
> +
> +	kfree(cdev->name);
> +	cdev->name =3D NULL;
> +
> +	mutex_unlock(&ldev->sysfs_lock);
> +}
> +
> +/* Sysfs */
> +
> +static struct lamparray_device *
> +lamparray_ldev_from_sysfs_dev(struct device *dev)
> +{
> +	struct hid_device *hdev =3D to_hid_device(dev);
> +
> +	return xa_load(&lamparray_by_hdev, (unsigned long)hdev);
> +}
> +
> +static ssize_t use_leds_uapi_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct lamparray_device *ldev =3D lamparray_ldev_from_sysfs_dev(dev);
> +
> +	if (!ldev)
> +		return -ENODEV;
> +
> +	return sysfs_emit(buf, "%d\n", ldev->use_leds_uapi);
> +}
> +
> +static ssize_t use_leds_uapi_store(struct device *dev,
> +				   struct device_attribute *attr,
> +				   const char *buf, size_t count)
> +{
> +	struct lamparray_device *ldev =3D lamparray_ldev_from_sysfs_dev(dev);
> +	int val;
> +	int old_val;
> +	int ret;
> +
> +	if (!ldev)
> +		return -ENODEV;
> +
> +	ret =3D kstrtoint(buf, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val !=3D 0 && val !=3D 1)
> +		return -EINVAL;
> +
> +	mutex_lock(&ldev->dev_lock);
> +	old_val =3D ldev->use_leds_uapi;
> +
> +	if (val =3D=3D old_val) {
> +		mutex_unlock(&ldev->dev_lock);
> +		return count;
> +	}
> +
> +	ldev->use_leds_uapi =3D val;
> +	mutex_unlock(&ldev->dev_lock);
> +
> +	if (val =3D=3D 1) {
> +		ret =3D lamparray_register_led(ldev);
> +		if (ret) {
> +			mutex_lock(&ldev->dev_lock);
> +			ldev->use_leds_uapi =3D old_val;
> +			mutex_unlock(&ldev->dev_lock);
> +			return ret;
> +		}
> +		ret =3D lamparray_restore_state(ldev);
> +		if (ret) {
> +			hid_err(ldev->hdev, "Could not restore state: %d\n", ret);
> +			return ret;
> +		}
> +
> +	} else {
> +		lamparray_unregister_led(ldev);
> +	}
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(use_leds_uapi);
> +
> +static int lamparray_register_sysfs(struct lamparray_device *ldev)
> +{
> +	struct device *dev =3D &ldev->hdev->dev;
> +	int ret;
> +
> +	ret =3D sysfs_create_file(&dev->kobj, &dev_attr_use_leds_uapi.attr);
> +	if (ret)
> +		hid_err(ldev->hdev,
> +			"Failed to create lamparray sysfs group: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static void lamparray_remove_sysfs(struct lamparray_device *ldev)
> +{
> +	sysfs_remove_file(&ldev->hdev->dev.kobj, &dev_attr_use_leds_uapi.attr)=
;
> +}
> +
> +/* Public API */
> +
> +bool lamparray_is_supported_device(struct hid_device *hdev)
> +{
> +	unsigned int i;
> +
> +	hid_dbg(hdev, "lamparray: walking %u collections\n",
> +		hdev->maxcollection);
> +
> +	for (i =3D 0; i < hdev->maxcollection; i++) {
> +		struct hid_collection *col =3D &hdev->collection[i];
> +		u16 page =3D (col->usage & HID_USAGE_PAGE) >> 16;
> +		u16 code =3D col->usage & HID_USAGE;
> +
> +		hid_dbg(hdev,
> +			"lamparray:  collection[%u]: type=3D%u level=3D%u usage=3D0x%08x pag=
e=3D0x%04x code=3D0x%04x\n",
> +			i, col->type, col->level, col->usage, page, code);
> +
> +		if (col->type =3D=3D HID_COLLECTION_APPLICATION &&
> +		    page =3D=3D HID_LIGHTING_ILLUMINATION_USAGE_PAGE &&
> +		    code =3D=3D HID_APPLICATION_COLLECTION_USAGE_TYPE) {
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(lamparray_is_supported_device);
> +
> +struct lamparray *
> +lamparray_register(struct hid_device *hdev,
> +		   const struct lamparray_init_state *led_init_state)
> +{
> +	int ret;
> +	struct lamparray *la;
> +	struct lamparray_device *ldev;
> +
> +	if (!hdev)
> +		return ERR_PTR(-ENODEV);
> +
> +	la =3D kzalloc_obj(*la, GFP_KERNEL);
> +	if (!la)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ldev =3D &la->ldev;
> +
> +	mutex_init(&ldev->dev_lock);
> +	mutex_init(&ldev->sysfs_lock);
> +	ldev->hdev =3D hdev;
> +	ldev->use_leds_uapi =3D true;
> +	ldev->led_registered =3D false;
> +
> +	/* Make sure the driver lock gets released for probing. */
> +	hid_device_io_start(hdev);
> +
> +	ret =3D lamparray_parse_update_report(ldev);
> +	if (ret) {
> +		hid_err(hdev, "No LampArray update report found: %d\n", ret);
> +		goto err_free;
> +	}
> +
> +	ret =3D lamparray_read_attributes_report(ldev);
> +	if (ret) {
> +		hid_err(hdev,
> +			"Could not determine LampCount: %d\n",
> +			ret);
> +		goto err_free;
> +	}
> +
> +	ret =3D lamparray_get_lamp_attributes(ldev);
> +	if (ret) {
> +		hid_err(hdev,
> +			"Faulty device. Could not query lamp attributes.\n");
> +		goto err_free;
> +	}
> +
> +	/* Use black (all zeros) as default. */
> +	if (led_init_state) {
> +		ldev->last_r =3D min(led_init_state->r, ldev->max_r);
> +		ldev->last_g =3D min(led_init_state->g, ldev->max_g);
> +		ldev->last_b =3D min(led_init_state->b, ldev->max_b);
> +		ldev->last_brightness =3D min(led_init_state->brightness,
> +					    ldev->max_brightness);
> +	}
> +
> +	ret =3D lamparray_register_led(ldev);
> +	if (ret) {
> +		hid_warn(hdev, "Failed to register LED UAPI: %d\n", ret);
> +		ldev->use_leds_uapi =3D false;
> +	}
> +
> +	ret =3D xa_err(xa_store(&lamparray_by_hdev, (unsigned long)hdev, ldev,
> +			      GFP_KERNEL));
> +	if (ret)
> +		goto err_unregister_led;
> +
> +	ret =3D lamparray_register_sysfs(ldev);
> +	if (ret)
> +		goto err_xa_erase;
> +
> +	ret =3D lamparray_hw_set_autonomous(ldev, false);
> +	if (ret) {
> +		hid_err(hdev, "Could not disable autonomous mode: %d", ret);
> +		goto err_remove_sysfs;
> +	}
> +
> +	hid_info(hdev, "LampArray device registered\n");
> +
> +	ret =3D lamparray_restore_state(ldev);
> +	if (ret) {
> +		hid_err(hdev, "Failed to set default state: %d", ret);
> +		goto err_remove_sysfs;
> +	}
> +
> +	hid_device_io_stop(hdev);
> +	return la;
> +
> +err_remove_sysfs:
> +	lamparray_remove_sysfs(ldev);
> +err_xa_erase:
> +	xa_erase(&lamparray_by_hdev, (unsigned long)hdev);
> +err_unregister_led:
> +	lamparray_unregister_led(ldev);
> +err_free:
> +	hid_device_io_stop(hdev);
> +	mutex_destroy(&ldev->dev_lock);
> +	mutex_destroy(&ldev->sysfs_lock);
> +	kfree(la);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(lamparray_register);
> +
> +void lamparray_unregister(struct lamparray *la)
> +{
> +	struct lamparray_device *ldev;
> +
> +	if (!la)
> +		return;
> +
> +	ldev =3D &la->ldev;
> +
> +	lamparray_hw_set_autonomous(ldev, true);
> +
> +	lamparray_remove_sysfs(ldev);
> +	xa_erase(&lamparray_by_hdev, (unsigned long)ldev->hdev);
> +	lamparray_unregister_led(ldev);
> +
> +	mutex_destroy(&ldev->dev_lock);
> +	mutex_destroy(&ldev->sysfs_lock);
> +	kfree(la);
> +}
> +EXPORT_SYMBOL_GPL(lamparray_unregister);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Tim Guttzeit <tgu@tuxedocomputers.com>");
> +MODULE_AUTHOR("Aaron Erhardt <aer@tuxedocomputers.com>");
> +MODULE_DESCRIPTION("HID LampArray helper module (single-zone RGB)");
> diff --git a/include/linux/hid-lamparray.h b/include/linux/hid-lamparray=
.h
> new file mode 100644
> index 000000000000..a77869728d12
> --- /dev/null
> +++ b/include/linux/hid-lamparray.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#ifndef _HID_LAMPARRAY_H
> +#define _HID_LAMPARRAY_H
> +
> +#include <linux/hid.h>
> +#include <linux/err.h>
> +#include <linux/types.h>
> +
> +struct lamparray;
> +
> +/*
> + * Optional initial LED state for lamparray_register().
> + * Used to define the initial state of a LampArray's LEDs.
> + */
> +struct lamparray_init_state {
> +	u8 r;
> +	u8 g;
> +	u8 b;
> +	u8 brightness;
> +};
> +
> +#if IS_ENABLED(CONFIG_HID_LAMPARRAY)
> +
> +/**
> + * lamparray_is_supported_device() - check whether a HID device support=
s LampArray
> + * @hdev: HID device to inspect
> + *
> + * Check whether the given HID device exposes a Lighting/LampArray appl=
ication
> + * collection as defined by the HID Lighting specification.
> + *
> + * This helper can be used by HID drivers to determine whether LampArra=
y
> + * functionality should be enabled for a device.
> + *
> + * Return: %true if LampArray support is detected, %false otherwise.
> + */
> +bool lamparray_is_supported_device(struct hid_device *hdev);
> +
> +/**
> + * lamparray_register() - initialize LampArray support for a HID device
> + * @hdev: HID device
> + * @led_init_state: Optional LED state at init specification
> + *
> + * Allocate and initialize internal LampArray state for the given HID d=
evice.
> + * The function parses required HID reports and fields and registers th=
e
> + * associated miscdevice and sysfs attributes.
> + *
> + * Registers a multicolor LED class device to expose the LampArray func=
tionality
> + * via the LED subsystem. If specified, the desired initial LED state i=
s
> + * applied. If led_init_state is NULL, a default state is applied (all =
LEDs off).
> + *
> + * Return: pointer to a LampArray handle on success, or ERR_PTR() on fa=
ilure.
> + */
> +struct lamparray *lamparray_register(struct hid_device *hdev,
> +				     const struct lamparray_init_state *led_init_state);
> +
> +/**
> + * lamparray_unregister() - tear down LampArray support
> + * @la: LampArray handle returned by lamparray_register()
> + *
> + * Remove all resources associated with a LampArray instance.
> + *
> + * This unregisters the LED class device (if present), removes the misc=
device
> + * and sysfs interfaces and frees all internal state associated with @l=
a.
> + */
> +void lamparray_unregister(struct lamparray *la);
> +
> +#else /* !CONFIG_HID_LAMPARRAY */
> +
> +static inline bool lamparray_is_supported_device(struct hid_device *hde=
v)
> +{
> +	return false;
> +}
> +
> +static inline struct lamparray *
> +lamparray_register(struct hid_device *hdev,
> +		   const struct lamparray_init_state *led_init_state)
> +{
> +	return ERR_PTR(-EOPNOTSUPP);
> +}
> +
> +static inline void lamparray_unregister(struct lamparray *la)
> +{
> +}
> +
> +#endif /* CONFIG_HID_LAMPARRAY */
> +
> +#endif /* _HID_LAMPARRAY_H */
