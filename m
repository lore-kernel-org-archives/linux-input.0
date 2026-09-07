Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA0E50EC0C;
	Mon,  7 Sep 2026 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797637; cv=none; b=R8D/nzGLiwDZqJQDVFiOUenHXgI7P8IP9cUT7VymgGwiwiOTEk7b6zvaSCzMDNaImEqwO+raNaGi5bCk/jhUFVX7+XFSZMlBoUgltbIsT63aj3pVfTu6Lnsb9LK2wqCz2ZyvYOL7w0D15SGpTdVY9VXyQTeNGtf7ZB92oKkvdd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797637; c=relaxed/simple;
	bh=aJMAI/QMwdHwrEZCjT6LiVt+/+c9axQ2JjExHSFYpKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAVu+nt9gzbHPRoHW35ZOUwWGWt/B65BAK/PfaacI33UvmAcL50QwWVow0ExkjQ3sTN0mRqUQyRcDxEJM4uPyeIGbC5G6IhLDN4EGuf4X47293x9axEjh0Jm1IQWoUk3Ctv3Vi9V4XoXN18aBj3k4q9ofNXNoXOpLuP2OSYDY9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=QVuiL2Qu; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="QVuiL2Qu"
Received: from [192.168.178.102] (p4fc02130.dip0.t-ipconnect.de [79.192.33.48])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 37FDC2FC0076;
	Mon,  7 Sep 2026 18:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1788797624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G+ACGOz9/miXyjMxlzYISTduBSftLdbEDr9qUsN18wM=;
	b=QVuiL2QuHLHg5aR3ykzRCM+CnNnS8ILvnwfUYrTLLZg/phdA8WLUvuFApxfGRNADX/RW3O
	9q+XPoRUkOz+Oc8RDUWli51ycBuavHkC+0QunwZmbPosUOPR2rcO8AZ/+dptOOiDj12geX
	lnUsPeoYkIkmIHbJY4ocaWEI3Fqd/4A=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
Message-ID: <f962298f-4547-44ea-a78e-2d64d73ad538@tuxedocomputers.com>
Date: Mon, 7 Sep 2026 18:13:43 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] HID: lamparray: add new LampArray helper module
To: Armin Wolf <W_Armin@gmx.de>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: wse@tuxedocomputers.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903073602.3815258-1-aer@tuxedocomputers.com>
 <20260903073602.3815258-2-aer@tuxedocomputers.com>
 <dfcf2cb6-ab64-41a1-8fc5-748f4f47c58f@gmx.de>
Content-Language: en-US
From: Aaron Erhardt <aer@tuxedocomputers.com>
In-Reply-To: <dfcf2cb6-ab64-41a1-8fc5-748f4f47c58f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 04.09.26 um 23:30 schrieb Armin Wolf:
> Am 03.09.26 um 09:35 schrieb Aaron Erhardt:
> 
>> Add a new hid-lamparray helper module that provides basic support for
>> devices exposing a Lighting/LampArray application collection (usage
>> page 0x59) and registers a single-zone RGB LED representation via the
>> LED subsystem.
>>
>> The module can be used as a library in HID drivers to add support for
>> the HID LampArray protocol. While the API is quite basic as of now
>> it could be extended in the future.
>>
>> Co-developed-by: Tim Guttzeit <tgu@tuxedocomputers.com>
>> Signed-off-by: Tim Guttzeit <tgu@tuxedocomputers.com>
>> Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
>> ---
>>   .../ABI/testing/sysfs-driver-hid-lamparray    |  16 +
>>   drivers/hid/Kconfig                           |  17 +
>>   drivers/hid/Makefile                          |   2 +
>>   drivers/hid/hid-lamparray.c                   | 812 ++++++++++++++++++
>>   include/linux/hid-lamparray.h                 |  88 ++
>>   5 files changed, 935 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lamparray
>>   create mode 100644 drivers/hid/hid-lamparray.c
>>   create mode 100644 include/linux/hid-lamparray.h
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lamparray b/Documentation/ABI/testing/sysfs-driver-hid-lamparray
>> new file mode 100644
>> index 000000000000..795be6c4c368
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-hid-lamparray
>> @@ -0,0 +1,16 @@
>> +What:        /sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/use_leds_uapi
>> +Date:        August 2026
>> +KernelVersion:    7.3
>> +Contact:    aer@tuxedocomputers.com
>> +Description:
>> +        If a driver uses the hid-lamparray module and a device supporting
>> +        LampArray is found, one multicolor LED class device is registered under
>> +        /sys/class/leds/rgb:<function> to expose the single-zone RGB control.
>> +        Every device gets an incremental unique id.
>> +
>> +        Additionally, the use_leds_uapi sysfs attribute to control the LED class
>> +        device is attached directly to the HID device at
>> +        /sys/bus/hid/devices/<bus>:<vid>:<pid>.<n>/use_leds_uapi. Writing 0 to
>> +        use_leds_uapi unregisters the LED class device. The last state is kept
>> +        cached. Writing 1 registers it again and restores the cached state to
>> +        hardware.
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index aa7fa11a0197..4afd80a67b39 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -92,6 +92,23 @@ config HID_GENERIC
>>         If unsure, say Y.
>>   +config HID_LAMPARRAY
>> +    tristate "HID LampArray helper"
>> +    depends on HID
>> +    depends on LEDS_CLASS_MULTICOLOR
>> +    default n
>> +    help
>> +      Helper for HID devices exposing a Lighting/LampArray collection.
>> +      Treats LampArray devices as a single-zone device and exposes a sysfs
>> +      interface for changing color and intensity values. Also exposes a
>> +      sysfs flag to be disabled e.g. by a userspace driver.
>> +
>> +      This can be used as library in existing drivers. The generic HID
>> +      driver is extended by default to handle lamp array devices if this
>> +      option is enabled.
>> +
>> +      If unsure, say N.
>> +
>>   config HID_HAPTIC
>>       bool "Haptic touchpad support"
>>       default n
>> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
>> index 48a863b245ee..f95630fa8bd8 100644
>> --- a/drivers/hid/Makefile
>> +++ b/drivers/hid/Makefile
>> @@ -13,6 +13,8 @@ obj-$(CONFIG_UHID)        += uhid.o
>>     obj-$(CONFIG_HID_GENERIC)    += hid-generic.o
>>   +obj-$(CONFIG_HID_LAMPARRAY)    += hid-lamparray.o
>> +
>>   hid-$(CONFIG_HIDRAW)        += hidraw.o
>>     hid-logitech-y        := hid-lg.o
>> diff --git a/drivers/hid/hid-lamparray.c b/drivers/hid/hid-lamparray.c
>> new file mode 100644
>> index 000000000000..9a438aa2d305
>> --- /dev/null
>> +++ b/drivers/hid/hid-lamparray.c
>> @@ -0,0 +1,812 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * hid-lamparray.c - HID LampArray helper module (single-zone RGB)
>> + *
>> + * Helper module for HID drivers supporting devices that expose a Lighting and
>> + * Illumination (LampArray) application collection (usage page 0x59).
>> + *
>> + * The module provides a minimal integration with the LED subsystem and treats
>> + * the device as a single zone: all lamps share one RGB value and a global
>> + * brightness level. It does not implement multi-zone layouts or hardware
>> + * effects.
>> + *
>> + * If enabled and a device supporting LampArray is found, one multicolor LED
>> + * class device is registered under /sys/class/leds/<HID-ID>:rgb:LampArray to
>> + * expose the single-zone RGB control.
>> + *
>> + * The use_leds_uapi sysfs attribute is attached directly to the HID device
>> + * under /sys/bus/hid/devices/<HID-ID>/use_leds_uapi. Writing 0 to use_leds_uapi
>> + * unregisters the LED class device. The last state is kept cached. Writing 1
>> + * registers it again and restores the cached state to hardware. State is cached
>> + * as last known RGB + brightness.
>> + *
>> + * The module does not bind to devices on its own. Instead, a HID driver may
>> + * query support via lamparray_is_supported_device() after hid_parse() and
>> + * create an instance using lamparray_register().
>> + *
>> + * Copyright (C) 2026 Tim Guttzeit <tgu@tuxedocomputers.com>
>> + * Copyright (C) 2026 Aaron Erhardt <aer@tuxedocomputers.com>
>> + */
>> +
>> +#include <dt-bindings/leds/common.h>
>> +#include <linux/limits.h>
>> +#include <linux/minmax.h>
>> +#include <linux/hid.h>
>> +#include <linux/leds.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/hid-lamparray.h>
>> +#include <linux/module.h>
>> +#include <linux/mutex.h>
>> +#include <linux/container_of.h>
>> +#include <linux/led-class-multicolor.h>
>> +#include <linux/xarray.h>
>> +
>> +/* Constants */
>> +
>> +/* HID usages (LampArray, etc.) */
>> +#define HID_LIGHTING_ILLUMINATION_USAGE_PAGE    0x0059
>> +
>> +/* HID usage types */
>> +#define HID_APPLICATION_COLLECTION_USAGE_TYPE    0x0001
>> +#define HID_LAMPARRAY_ATTRIBUTES_REPORT    0x0002
>> +#define HID_LAMP_ATTRIBUTES_RESPONSE_REPORT    0x0022
>> +#define HID_LAMP_RANGE_UPDATE_REPORT        0x0060
>> +#define HID_LAMPARRAY_CONTROL_REPORT        0x0070
>> +
>> +/* HID attributes */
>> +#define HID_LAIP_LAMP_COUNT            0x0003
>> +#define HID_LAIP_LAMPARRAY_KIND            0x0007
>> +#define HID_LAIP_RED_LEVEL_COUNT        0x0028
>> +#define HID_LAIP_GREEN_LEVEL_COUNT        0x0029
>> +#define HID_LAIP_BLUE_LEVEL_COUNT        0x002a
>> +#define HID_LAIP_INTENSITY_LEVEL_COUNT        0x002b
>> +#define HID_LAIP_RED_UPDATE_CHANNEL        0x0051
>> +#define HID_LAIP_GREEN_UPDATE_CHANNEL        0x0052
>> +#define HID_LAIP_BLUE_UPDATE_CHANNEL        0x0053
>> +#define HID_LAIP_INTENSITY_UPDATE_CHANNEL    0x0054
>> +#define HID_LAIP_LAMP_ID_START            0x0061
>> +#define HID_LAIP_LAMP_ID_END            0x0062
>> +#define HID_LAIP_AUTONOMOUS_MODE        0x0071
>> +
>> +/* LampArrayKind values */
>> +#define HID_LAMPARRAY_KIND_KEYBOARD        0x0001
>> +
>> +/* Helper struct for fields and their indices */
>> +struct hid_field_value {
>> +    struct hid_field *field;
>> +    int index;
>> +};
>> +
>> +/* Helper struct for color fields */
>> +struct lamparray_color_fields {
>> +    struct hid_field_value red;
>> +    struct hid_field_value green;
>> +    struct hid_field_value blue;
>> +    struct hid_field_value intensity;
>> +};
>> +
>> +/* Device state */
>> +struct lamparray_device {
>> +    struct hid_device *hdev;
>> +
>> +    struct lamparray_color_fields color_levels;
>> +    struct lamparray_color_fields color_update;
>> +
>> +    struct hid_field_value autonomous_field;
>> +    struct hid_field_value range_start;
>> +    struct hid_field_value range_end;
>> +    struct hid_field_value lamp_count;
>> +    struct hid_field_value lamparray_kind;
>> +
>> +    u16 lamp_count_value;
>> +    u32 lamparray_kind_value;
>> +
>> +    struct led_classdev_mc mc_cdev;
>> +    struct mc_subled subleds[3];
>> +
>> +    struct mutex dev_lock; /* Protects cached state and HID access */
>> +    struct mutex sysfs_lock; /* Protects sysfs LED (de-)initialization */
>> +
>> +    u8 max_r;
>> +    u8 max_g;
>> +    u8 max_b;
>> +    u8 max_brightness;
>> +
>> +    u8 last_r;
>> +    u8 last_g;
>> +    u8 last_b;
>> +    u8 last_brightness;
>> +
>> +    bool use_leds_uapi;
>> +    bool led_registered;
>> +};
>> +
>> +/*
>> + * Opaque handle exposed to callers via the header.
>> + * Keep the actual state in lamparray_device, but return a stable pointer.
>> + */
>> +struct lamparray {
>> +    struct lamparray_device ldev;
>> +};
>> +
>> +/*
>> + * Mapping for hid_device pointers to their lamparray data.
>> + * Since there is not guarantee of how the driver using this library
>> + * will use its drvdata, the only safe way to retrieve the lamparray
>> + * data from a HID device pointer is using this mapping.
>> + */
>> +static DEFINE_XARRAY(lamparray_by_hdev);
>> +
>> +/* HID helper functions */
>> +
>> +static int get_field_value(struct hid_field_value *field_value)
>> +{
>> +    return field_value->field->value[field_value->index];
>> +}
>> +
>> +static u8 get_field_value_as_u8(struct hid_field_value *field_value)
>> +{
>> +    return clamp_val(get_field_value(field_value), 0, U8_MAX);
>> +}
>> +
>> +static void set_field_value(struct hid_field_value *field_value, int value)
>> +{
>> +    field_value->field->value[field_value->index] = value;
>> +}
>> +
>> +static bool lamparray_color_fields_is_complete(struct lamparray_color_fields *color_fields)
>> +{
>> +    return color_fields->red.field && color_fields->green.field &&
>> +           color_fields->blue.field && color_fields->intensity.field;
>> +}
>> +
>> +static int lamparray_read_attributes_report(struct lamparray_device *ldev)
>> +{
>> +    struct hid_device *hdev = ldev->hdev;
>> +    struct hid_report *report;
>> +
>> +    if (!ldev->lamp_count.field) {
>> +        hid_dbg(hdev, "No LampCount field found\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    if (!ldev->lamparray_kind.field) {
>> +        hid_dbg(hdev, "No LampArrayKind field found\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    report = ldev->lamp_count.field->report;
>> +
>> +    if (!report) {
>> +        hid_dbg(hdev, "LampCount field has no report\n");
>> +        return -ENODEV;
>> +    }
>> +
>> +    mutex_lock(&ldev->dev_lock);
>> +
>> +    /* Update values */
>> +    hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
>> +    hid_hw_wait(hdev);
>> +
>> +    ldev->lamp_count_value = get_field_value(&ldev->lamp_count);
>> +
>> +    if (ldev->lamp_count_value == 0) {
>> +        mutex_unlock(&ldev->dev_lock);
>> +        hid_dbg(hdev, "LampCount is %d (invalid)\n", ldev->lamp_count_value);
>> +        return -EINVAL;
>> +    }
>> +
>> +    ldev->lamparray_kind_value = get_field_value(&ldev->lamparray_kind);
>> +
>> +    mutex_unlock(&ldev->dev_lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int lamparray_parse_update_report(struct lamparray_device *ldev)
>> +{
>> +    struct hid_device *hdev = ldev->hdev;
>> +    struct hid_report_enum *re;
>> +    struct hid_report *report;
>> +    struct hid_field *field;
>> +    int i, j;
>> +    int ret = 0;
>> +
>> +    mutex_lock(&ldev->dev_lock);
>> +
>> +    re = &hdev->report_enum[HID_FEATURE_REPORT];
>> +
>> +    list_for_each_entry(report, &re->report_list, list) {
>> +        for (i = 0; i < report->maxfield; i++) {
>> +            field = report->field[i];
>> +            if (!field)
>> +                continue;
>> +
>> +            if (!field->usage || !field->maxusage)
>> +                continue;
>> +
>> +            for (j = 0; j < field->maxusage; j++) {
>> +                u32 usage = field->usage[j].hid;
>> +                u32 collection_idx = field->usage[j].collection_index;
>> +                u32 collection_usage = hdev->collection[collection_idx].usage;
>> +
>> +                u16 page = (usage & HID_USAGE_PAGE) >> 16;
>> +                u16 id = usage & HID_USAGE;
>> +                u16 collection_usage_id = collection_usage & U16_MAX;
>> +
>> +                if (page != HID_LIGHTING_ILLUMINATION_USAGE_PAGE)
>> +                    continue;
>> +
>> +                if (collection_usage_id == HID_LAMPARRAY_ATTRIBUTES_REPORT) {
>> +                    switch (id) {
>> +                    case HID_LAIP_LAMP_COUNT:
>> +                        ldev->lamp_count.field = field;
>> +                        ldev->lamp_count.index = j;
>> +                        break;
>> +                    case HID_LAIP_LAMPARRAY_KIND:
>> +                        ldev->lamparray_kind.field = field;
>> +                        ldev->lamparray_kind.index = j;
>> +                        break;
>> +                    }
>> +                } else if (collection_usage_id ==
>> +                       HID_LAMP_ATTRIBUTES_RESPONSE_REPORT) {
>> +                    switch (id) {
>> +                    case HID_LAIP_RED_LEVEL_COUNT:
>> +                        ldev->color_levels.red.field = field;
>> +                        ldev->color_levels.red.index = j;
>> +                        break;
>> +                    case HID_LAIP_GREEN_LEVEL_COUNT:
>> +                        ldev->color_levels.green.field = field;
>> +                        ldev->color_levels.green.index = j;
>> +                        break;
>> +                    case HID_LAIP_BLUE_LEVEL_COUNT:
>> +                        ldev->color_levels.blue.field = field;
>> +                        ldev->color_levels.blue.index = j;
>> +                        break;
>> +                    case HID_LAIP_INTENSITY_LEVEL_COUNT:
>> +                        ldev->color_levels.intensity.field = field;
>> +                        ldev->color_levels.intensity.index = j;
>> +                        break;
>> +                    }
>> +                } else if (collection_usage_id == HID_LAMP_RANGE_UPDATE_REPORT) {
>> +                    switch (id) {
>> +                    case HID_LAIP_RED_UPDATE_CHANNEL:
>> +                        ldev->color_update.red.field = field;
>> +                        ldev->color_update.red.index = j;
>> +                        break;
>> +                    case HID_LAIP_GREEN_UPDATE_CHANNEL:
>> +                        ldev->color_update.green.field = field;
>> +                        ldev->color_update.green.index = j;
>> +                        break;
>> +                    case HID_LAIP_BLUE_UPDATE_CHANNEL:
>> +                        ldev->color_update.blue.field = field;
>> +                        ldev->color_update.blue.index = j;
>> +                        break;
>> +                    case HID_LAIP_INTENSITY_UPDATE_CHANNEL:
>> +                        ldev->color_update.intensity.field = field;
>> +                        ldev->color_update.intensity.index = j;
>> +                        break;
>> +                    case HID_LAIP_LAMP_ID_START:
>> +                        ldev->range_start.field = field;
>> +                        ldev->range_start.index = j;
>> +                        break;
>> +                    case HID_LAIP_LAMP_ID_END:
>> +                        ldev->range_end.field = field;
>> +                        ldev->range_end.index = j;
>> +                        break;
>> +                    default:
>> +                        break;
>> +                    }
>> +                } else if (collection_usage_id == HID_LAMPARRAY_CONTROL_REPORT &&
>> +                       id == HID_LAIP_AUTONOMOUS_MODE) {
>> +                    ldev->autonomous_field.field = field;
>> +                    ldev->autonomous_field.index = j;
>> +                }
>> +            }
>> +        }
>> +    }
>> +
>> +    if (!ldev->autonomous_field.field ||
>> +        !lamparray_color_fields_is_complete(&ldev->color_update))
>> +        ret = -ENODEV;
>> +
>> +    mutex_unlock(&ldev->dev_lock);
>> +
>> +    return ret;
>> +}
>> +
>> +static int lamparray_hw_set_autonomous(struct lamparray_device *ldev,
>> +                       bool enable)
>> +{
>> +    struct hid_device *hdev = ldev->hdev;
>> +    struct hid_field *field = ldev->autonomous_field.field;
>> +
>> +    if (!field)
>> +        return -ENODEV;
>> +
>> +    mutex_lock(&ldev->dev_lock);
>> +
>> +    set_field_value(&ldev->autonomous_field, !!enable);
>> +
>> +    hid_hw_request(hdev, field->report, HID_REQ_SET_REPORT);
>> +    hid_hw_wait(hdev);
>> +
>> +    mutex_unlock(&ldev->dev_lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static int lamparray_hw_set_state(struct lamparray_device *ldev, u8 r, u8 g,
>> +                  u8 b, u8 intensity)
>> +{
>> +    struct hid_device *hdev = ldev->hdev;
>> +    struct hid_report *report;
>> +
>> +    if (!lamparray_color_fields_is_complete(&ldev->color_update))
>> +        return -ENODEV;
>> +
>> +    if (ldev->range_start.field && ldev->range_end.field) {
>> +        set_field_value(&ldev->range_start, 0);
>> +        set_field_value(&ldev->range_end, ldev->lamp_count_value - 1);
>> +    }
>> +
>> +    set_field_value(&ldev->color_update.red, r);
>> +    set_field_value(&ldev->color_update.green, g);
>> +    set_field_value(&ldev->color_update.blue, b);
>> +    set_field_value(&ldev->color_update.intensity, intensity);
>> +
>> +    report = ldev->color_update.red.field->report;
>> +    hid_hw_request(hdev, report, HID_REQ_SET_REPORT);
>> +    hid_hw_wait(hdev);
>> +
>> +    return 0;
>> +}
>> +
>> +/*
>> + * Simple helper to read the color information of the first lamp.
>> + * This does not read the state of the whole lamp array since this driver only
>> + * exposes one LED anyway, so one color is sufficient here for now.
>> + */
>> +static int lamparray_get_lamp_attributes(struct lamparray_device *ldev)
>> +{
>> +    struct hid_device *hdev = ldev->hdev;
>> +    struct hid_report *report;
>> +
>> +    if (!lamparray_color_fields_is_complete(&ldev->color_levels))
>> +        return -ENODEV;
>> +
>> +    /*
>> +     * Get value of any lamp.
>> +     */
>> +    report = ldev->color_levels.red.field->report;
>> +
>> +    mutex_lock(&ldev->dev_lock);
>> +
>> +    hid_hw_request(hdev, report, HID_REQ_GET_REPORT);
>> +    hid_hw_wait(hdev);
>> +
>> +    ldev->max_r = get_field_value_as_u8(&ldev->color_levels.red);
>> +    ldev->max_g = get_field_value_as_u8(&ldev->color_levels.green);
>> +    ldev->max_b = get_field_value_as_u8(&ldev->color_levels.blue);
>> +    ldev->max_brightness = get_field_value_as_u8(&ldev->color_levels.intensity);
>> +
>> +    mutex_unlock(&ldev->dev_lock);
>> +
>> +    return 0;
>> +}
>> +
>> +/* Helper functions */
>> +
>> +static int lamparray_restore_state(struct lamparray_device *ldev)
>> +{
>> +    u8 r, g, b;
>> +    int ret;
>> +    enum led_brightness brightness;
>> +
>> +    mutex_lock(&ldev->dev_lock);
>> +
>> +    if (!ldev->use_leds_uapi) {
>> +        mutex_unlock(&ldev->dev_lock);
>> +        return 0;
>> +    }
>> +
>> +    r = ldev->last_r;
>> +    g = ldev->last_g;
>> +    b = ldev->last_b;
>> +    brightness = ldev->last_brightness;
>> +
>> +    ldev->mc_cdev.subled_info[0].intensity = r;
>> +    ldev->mc_cdev.subled_info[1].intensity = g;
>> +    ldev->mc_cdev.subled_info[2].intensity = b;
>> +    ldev->mc_cdev.led_cdev.brightness = brightness;
>> +
>> +    led_mc_calc_color_components(&ldev->mc_cdev, brightness);
> 
> Hi,
> 
> since you are not using the brightness of the subleds, this call to
> led_mc_calc_color_components() is unnecessary.
> 

Thanks for pointing this out. I will remove it in the next iteration.

I was aware that this is not necessary for the LampArray functionality, but
assumed it would be useful for updating the values in the LED subsystem. I
somehow thought there would be a file with scaled values which would need 
to be updates sperately since the LampArray device will do the scaling by
itself. After checking, this was quite obviously wrong.
>> +
>> +    ret = lamparray_hw_set_state(ldev, r, g, b, brightness);
>> +
>> +    mutex_unlock(&ldev->dev_lock);
>> +    return ret;
>> +}
>> +
>> +/* LEDs API */
>> +
>> +static int lamparray_led_brightness_set(struct led_classdev *cdev,
>> +                    enum led_brightness brightness)
>> +{
>> +    struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
>> +    struct lamparray_device *ldev =
>> +        container_of_const(mc, struct lamparray_device, mc_cdev);
>> +    u8 r, g, b;
>> +    int ret;
>> +
>> +    /*
>> +     * Brightness is handled by the LampArray device if supported,
>> +     * so we can pass the raw intensity values.
>> +     */
>> +    r = mc->subled_info[0].intensity;
>> +    g = mc->subled_info[1].intensity;
>> +    b = mc->subled_info[2].intensity;
>> +
>> +    mc->led_cdev.brightness = brightness;
>> +    led_mc_calc_color_components(&ldev->mc_cdev, brightness);
> 
> Same here, the assignment of mc->led_cdev.brightness is also already preformed
> by the LED core itself.
> 
> Thanks,
> Armin Wolf
> 
>> +    mutex_lock(&ldev->dev_lock);
>> +    ret = lamparray_hw_set_state(ldev, r, g, b, brightness);
>> +    if (ret) {
>> +        mutex_unlock(&ldev->dev_lock);
>> +        hid_err(ldev->hdev, "Failed to send LampArray update: %d\n",
>> +            ret);
>> +        return ret;
>> +    }
>> +
>> +    ldev->last_r = r;
>> +    ldev->last_g = g;
>> +    ldev->last_b = b;
>> +    ldev->last_brightness = brightness;
>> +    mutex_unlock(&ldev->dev_lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static enum led_brightness
>> +lamparray_led_brightness_get(struct led_classdev *cdev)
>> +{
>> +    struct led_classdev_mc *mc = lcdev_to_mccdev(cdev);
>> +    struct lamparray_device *ldev =
>> +        container_of_const(mc, struct lamparray_device, mc_cdev);
>> +
>> +    return ldev->last_brightness;
>> +}
>> +
>> +static int lamparray_register_led(struct lamparray_device *ldev)
>> +{
>> +    struct device *dev = &ldev->hdev->dev;
>> +    struct led_classdev *cdev = &ldev->mc_cdev.led_cdev;
>> +    int ret;
>> +
>> +    mutex_lock(&ldev->sysfs_lock);
>> +
>> +    if (ldev->led_registered) {
>> +        mutex_unlock(&ldev->sysfs_lock);
>> +        return 0;
>> +    }
>> +
>> +    if (!cdev->name) {
>> +        /* Fallback value */
>> +        const char *function = LED_FUNCTION_STATUS;
>> +
>> +        /* Some heuristics for choosing a better LED function. */
>> +        if (ldev->lamparray_kind_value == HID_LAMPARRAY_KIND_KEYBOARD)
>> +            function = LED_FUNCTION_KBD_BACKLIGHT;
>> +
>> +        cdev->name = kasprintf(GFP_KERNEL, "rgb:%s", function);
>> +        if (!cdev->name) {
>> +            mutex_unlock(&ldev->sysfs_lock);
>> +            return -ENOMEM;
>> +        }
>> +    }
>> +
>> +    mutex_lock(&ldev->dev_lock);
>> +    /* Setup */
>> +    cdev->max_brightness = ldev->max_brightness;
>> +    cdev->brightness_set_blocking = lamparray_led_brightness_set;
>> +    cdev->brightness_get = lamparray_led_brightness_get;
>> +    cdev->flags |= LED_RETAIN_AT_SHUTDOWN;
>> +
>> +    ldev->subleds[0].color_index = LED_COLOR_ID_RED;
>> +    ldev->subleds[0].max_intensity = ldev->max_r;
>> +    ldev->subleds[1].color_index = LED_COLOR_ID_GREEN;
>> +    ldev->subleds[1].max_intensity = ldev->max_g;
>> +    ldev->subleds[2].color_index = LED_COLOR_ID_BLUE;
>> +    ldev->subleds[2].max_intensity = ldev->max_b;
>> +
>> +    /* Set values */
>> +    ldev->subleds[0].intensity = ldev->last_r;
>> +    ldev->subleds[1].intensity = ldev->last_g;
>> +    ldev->subleds[2].intensity = ldev->last_b;
>> +    cdev->brightness = ldev->last_brightness;
>> +
>> +    ldev->mc_cdev.subled_info = ldev->subleds;
>> +    ldev->mc_cdev.num_colors = ARRAY_SIZE(ldev->subleds);
>> +
>> +    /* Ensure subled_info[].brightness matches intensity + brightness */
>> +    led_mc_calc_color_components(&ldev->mc_cdev, ldev->last_brightness);
>> +    mutex_unlock(&ldev->dev_lock);
>> +
>> +    ret = led_classdev_multicolor_register(dev, &ldev->mc_cdev);
>> +    if (ret) {
>> +        mutex_unlock(&ldev->sysfs_lock);
>> +        return ret;
>> +    }
>> +
>> +    ldev->led_registered = true;
>> +    mutex_unlock(&ldev->sysfs_lock);
>> +
>> +    return 0;
>> +}
>> +
>> +static void lamparray_unregister_led(struct lamparray_device *ldev)
>> +{
>> +    bool was_registered;
>> +    struct led_classdev *cdev = &ldev->mc_cdev.led_cdev;
>> +
>> +    mutex_lock(&ldev->sysfs_lock);
>> +    was_registered = ldev->led_registered;
>> +    ldev->led_registered = false;
>> +
>> +    if (was_registered)
>> +        led_classdev_multicolor_unregister(&ldev->mc_cdev);
>> +
>> +    kfree(cdev->name);
>> +    cdev->name = NULL;
>> +
>> +    mutex_unlock(&ldev->sysfs_lock);
>> +}
>> +
>> +/* Sysfs */
>> +
>> +static struct lamparray_device *
>> +lamparray_ldev_from_sysfs_dev(struct device *dev)
>> +{
>> +    struct hid_device *hdev = to_hid_device(dev);
>> +
>> +    return xa_load(&lamparray_by_hdev, (unsigned long)hdev);
>> +}
>> +
>> +static ssize_t use_leds_uapi_show(struct device *dev,
>> +                  struct device_attribute *attr, char *buf)
>> +{
>> +    struct lamparray_device *ldev = lamparray_ldev_from_sysfs_dev(dev);
>> +
>> +    if (!ldev)
>> +        return -ENODEV;
>> +
>> +    return sysfs_emit(buf, "%d\n", ldev->use_leds_uapi);
>> +}
>> +
>> +static ssize_t use_leds_uapi_store(struct device *dev,
>> +                   struct device_attribute *attr,
>> +                   const char *buf, size_t count)
>> +{
>> +    struct lamparray_device *ldev = lamparray_ldev_from_sysfs_dev(dev);
>> +    int val;
>> +    int old_val;
>> +    int ret;
>> +
>> +    if (!ldev)
>> +        return -ENODEV;
>> +
>> +    ret = kstrtoint(buf, 0, &val);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (val != 0 && val != 1)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&ldev->dev_lock);
>> +    old_val = ldev->use_leds_uapi;
>> +
>> +    if (val == old_val) {
>> +        mutex_unlock(&ldev->dev_lock);
>> +        return count;
>> +    }
>> +
>> +    ldev->use_leds_uapi = val;
>> +    mutex_unlock(&ldev->dev_lock);
>> +
>> +    if (val == 1) {
>> +        ret = lamparray_register_led(ldev);
>> +        if (ret) {
>> +            mutex_lock(&ldev->dev_lock);
>> +            ldev->use_leds_uapi = old_val;
>> +            mutex_unlock(&ldev->dev_lock);
>> +            return ret;
>> +        }
>> +        ret = lamparray_restore_state(ldev);
>> +        if (ret) {
>> +            hid_err(ldev->hdev, "Could not restore state: %d\n", ret);
>> +            return ret;
>> +        }
>> +
>> +    } else {
>> +        lamparray_unregister_led(ldev);
>> +    }
>> +
>> +    return count;
>> +}
>> +static DEVICE_ATTR_RW(use_leds_uapi);
>> +
>> +static int lamparray_register_sysfs(struct lamparray_device *ldev)
>> +{
>> +    struct device *dev = &ldev->hdev->dev;
>> +    int ret;
>> +
>> +    ret = sysfs_create_file(&dev->kobj, &dev_attr_use_leds_uapi.attr);
>> +    if (ret)
>> +        hid_err(ldev->hdev,
>> +            "Failed to create lamparray sysfs group: %d\n", ret);
>> +
>> +    return ret;
>> +}
>> +
>> +static void lamparray_remove_sysfs(struct lamparray_device *ldev)
>> +{
>> +    sysfs_remove_file(&ldev->hdev->dev.kobj, &dev_attr_use_leds_uapi.attr);
>> +}
>> +
>> +/* Public API */
>> +
>> +bool lamparray_is_supported_device(struct hid_device *hdev)
>> +{
>> +    unsigned int i;
>> +
>> +    hid_dbg(hdev, "lamparray: walking %u collections\n",
>> +        hdev->maxcollection);
>> +
>> +    for (i = 0; i < hdev->maxcollection; i++) {
>> +        struct hid_collection *col = &hdev->collection[i];
>> +        u16 page = (col->usage & HID_USAGE_PAGE) >> 16;
>> +        u16 code = col->usage & HID_USAGE;
>> +
>> +        hid_dbg(hdev,
>> +            "lamparray:  collection[%u]: type=%u level=%u usage=0x%08x page=0x%04x code=0x%04x\n",
>> +            i, col->type, col->level, col->usage, page, code);
>> +
>> +        if (col->type == HID_COLLECTION_APPLICATION &&
>> +            page == HID_LIGHTING_ILLUMINATION_USAGE_PAGE &&
>> +            code == HID_APPLICATION_COLLECTION_USAGE_TYPE) {
>> +            return true;
>> +        }
>> +    }
>> +    return false;
>> +}
>> +EXPORT_SYMBOL_GPL(lamparray_is_supported_device);
>> +
>> +struct lamparray *
>> +lamparray_register(struct hid_device *hdev,
>> +           const struct lamparray_init_state *led_init_state)
>> +{
>> +    int ret;
>> +    struct lamparray *la;
>> +    struct lamparray_device *ldev;
>> +
>> +    if (!hdev)
>> +        return ERR_PTR(-ENODEV);
>> +
>> +    la = kzalloc_obj(*la, GFP_KERNEL);
>> +    if (!la)
>> +        return ERR_PTR(-ENOMEM);
>> +
>> +    ldev = &la->ldev;
>> +
>> +    mutex_init(&ldev->dev_lock);
>> +    mutex_init(&ldev->sysfs_lock);
>> +    ldev->hdev = hdev;
>> +    ldev->use_leds_uapi = true;
>> +    ldev->led_registered = false;
>> +
>> +    /* Make sure the driver lock gets released for probing. */
>> +    hid_device_io_start(hdev);
>> +
>> +    ret = lamparray_parse_update_report(ldev);
>> +    if (ret) {
>> +        hid_err(hdev, "No LampArray update report found: %d\n", ret);
>> +        goto err_free;
>> +    }
>> +
>> +    ret = lamparray_read_attributes_report(ldev);
>> +    if (ret) {
>> +        hid_err(hdev,
>> +            "Could not determine LampCount: %d\n",
>> +            ret);
>> +        goto err_free;
>> +    }
>> +
>> +    ret = lamparray_get_lamp_attributes(ldev);
>> +    if (ret) {
>> +        hid_err(hdev,
>> +            "Faulty device. Could not query lamp attributes.\n");
>> +        goto err_free;
>> +    }
>> +
>> +    /* Use black (all zeros) as default. */
>> +    if (led_init_state) {
>> +        ldev->last_r = min(led_init_state->r, ldev->max_r);
>> +        ldev->last_g = min(led_init_state->g, ldev->max_g);
>> +        ldev->last_b = min(led_init_state->b, ldev->max_b);
>> +        ldev->last_brightness = min(led_init_state->brightness,
>> +                        ldev->max_brightness);
>> +    }
>> +
>> +    ret = lamparray_register_led(ldev);
>> +    if (ret) {
>> +        hid_warn(hdev, "Failed to register LED UAPI: %d\n", ret);
>> +        ldev->use_leds_uapi = false;
>> +    }
>> +
>> +    ret = xa_err(xa_store(&lamparray_by_hdev, (unsigned long)hdev, ldev,
>> +                  GFP_KERNEL));
>> +    if (ret)
>> +        goto err_unregister_led;
>> +
>> +    ret = lamparray_register_sysfs(ldev);
>> +    if (ret)
>> +        goto err_xa_erase;
>> +
>> +    ret = lamparray_hw_set_autonomous(ldev, false);
>> +    if (ret) {
>> +        hid_err(hdev, "Could not disable autonomous mode: %d", ret);
>> +        goto err_remove_sysfs;
>> +    }
>> +
>> +    hid_info(hdev, "LampArray device registered\n");
>> +
>> +    ret = lamparray_restore_state(ldev);
>> +    if (ret) {
>> +        hid_err(hdev, "Failed to set default state: %d", ret);
>> +        goto err_remove_sysfs;
>> +    }
>> +
>> +    hid_device_io_stop(hdev);
>> +    return la;
>> +
>> +err_remove_sysfs:
>> +    lamparray_remove_sysfs(ldev);
>> +err_xa_erase:
>> +    xa_erase(&lamparray_by_hdev, (unsigned long)hdev);
>> +err_unregister_led:
>> +    lamparray_unregister_led(ldev);
>> +err_free:
>> +    hid_device_io_stop(hdev);
>> +    mutex_destroy(&ldev->dev_lock);
>> +    mutex_destroy(&ldev->sysfs_lock);
>> +    kfree(la);
>> +    return ERR_PTR(ret);
>> +}
>> +EXPORT_SYMBOL_GPL(lamparray_register);
>> +
>> +void lamparray_unregister(struct lamparray *la)
>> +{
>> +    struct lamparray_device *ldev;
>> +
>> +    if (!la)
>> +        return;
>> +
>> +    ldev = &la->ldev;
>> +
>> +    lamparray_hw_set_autonomous(ldev, true);
>> +
>> +    lamparray_remove_sysfs(ldev);
>> +    xa_erase(&lamparray_by_hdev, (unsigned long)ldev->hdev);
>> +    lamparray_unregister_led(ldev);
>> +
>> +    mutex_destroy(&ldev->dev_lock);
>> +    mutex_destroy(&ldev->sysfs_lock);
>> +    kfree(la);
>> +}
>> +EXPORT_SYMBOL_GPL(lamparray_unregister);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Tim Guttzeit <tgu@tuxedocomputers.com>");
>> +MODULE_AUTHOR("Aaron Erhardt <aer@tuxedocomputers.com>");
>> +MODULE_DESCRIPTION("HID LampArray helper module (single-zone RGB)");
>> diff --git a/include/linux/hid-lamparray.h b/include/linux/hid-lamparray.h
>> new file mode 100644
>> index 000000000000..a77869728d12
>> --- /dev/null
>> +++ b/include/linux/hid-lamparray.h
>> @@ -0,0 +1,88 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +
>> +#ifndef _HID_LAMPARRAY_H
>> +#define _HID_LAMPARRAY_H
>> +
>> +#include <linux/hid.h>
>> +#include <linux/err.h>
>> +#include <linux/types.h>
>> +
>> +struct lamparray;
>> +
>> +/*
>> + * Optional initial LED state for lamparray_register().
>> + * Used to define the initial state of a LampArray's LEDs.
>> + */
>> +struct lamparray_init_state {
>> +    u8 r;
>> +    u8 g;
>> +    u8 b;
>> +    u8 brightness;
>> +};
>> +
>> +#if IS_ENABLED(CONFIG_HID_LAMPARRAY)
>> +
>> +/**
>> + * lamparray_is_supported_device() - check whether a HID device supports LampArray
>> + * @hdev: HID device to inspect
>> + *
>> + * Check whether the given HID device exposes a Lighting/LampArray application
>> + * collection as defined by the HID Lighting specification.
>> + *
>> + * This helper can be used by HID drivers to determine whether LampArray
>> + * functionality should be enabled for a device.
>> + *
>> + * Return: %true if LampArray support is detected, %false otherwise.
>> + */
>> +bool lamparray_is_supported_device(struct hid_device *hdev);
>> +
>> +/**
>> + * lamparray_register() - initialize LampArray support for a HID device
>> + * @hdev: HID device
>> + * @led_init_state: Optional LED state at init specification
>> + *
>> + * Allocate and initialize internal LampArray state for the given HID device.
>> + * The function parses required HID reports and fields and registers the
>> + * associated miscdevice and sysfs attributes.
>> + *
>> + * Registers a multicolor LED class device to expose the LampArray functionality
>> + * via the LED subsystem. If specified, the desired initial LED state is
>> + * applied. If led_init_state is NULL, a default state is applied (all LEDs off).
>> + *
>> + * Return: pointer to a LampArray handle on success, or ERR_PTR() on failure.
>> + */
>> +struct lamparray *lamparray_register(struct hid_device *hdev,
>> +                     const struct lamparray_init_state *led_init_state);
>> +
>> +/**
>> + * lamparray_unregister() - tear down LampArray support
>> + * @la: LampArray handle returned by lamparray_register()
>> + *
>> + * Remove all resources associated with a LampArray instance.
>> + *
>> + * This unregisters the LED class device (if present), removes the miscdevice
>> + * and sysfs interfaces and frees all internal state associated with @la.
>> + */
>> +void lamparray_unregister(struct lamparray *la);
>> +
>> +#else /* !CONFIG_HID_LAMPARRAY */
>> +
>> +static inline bool lamparray_is_supported_device(struct hid_device *hdev)
>> +{
>> +    return false;
>> +}
>> +
>> +static inline struct lamparray *
>> +lamparray_register(struct hid_device *hdev,
>> +           const struct lamparray_init_state *led_init_state)
>> +{
>> +    return ERR_PTR(-EOPNOTSUPP);
>> +}
>> +
>> +static inline void lamparray_unregister(struct lamparray *la)
>> +{
>> +}
>> +
>> +#endif /* CONFIG_HID_LAMPARRAY */
>> +
>> +#endif /* _HID_LAMPARRAY_H */
> 

