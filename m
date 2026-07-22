Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA5B470E8D
	for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 19:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784746986; cv=none; b=sYZtTTe/xnb9XkcbaOCqXx4kvae8UgqbYWgRsMWtBIn+QAVP+puuS1lRvl6fi5T4/+vN6hVyNb87RoNBlKesx2vQyedofsSeBxnRuOCV5GZyX30NSBBYbLS8Z+vUWvoLOn3wKQyQhxiqguohv0AakufWD/hH0A3VivwyRp7vGtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784746986; c=relaxed/simple;
	bh=q+/pH4VpueN9qbULsKajh1beArHNGgXpSu6ae5p1T2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B4u/uIOqUPzR6Z874Iceku/foNF9ScVdjZG26wvcsxjTbDW30y9Gkn0Cn96Msc/u9FT/oAZ+j2VA75MD2eVqJ1k1/iUfokKwcTksLryILluvsHAo8Qv1oWS5KoM/4bzi7y3MkjigsGCCNomBZ6mIwqaUjSd0fVn+0pQmFUy9E/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZlkjDB2i; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZlkjDB2i"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-9063b380982so100749166d6.0
        for <linux-input@vger.kernel.org>; Wed, 22 Jul 2026 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784746961; x=1785351761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kkZF/WZBw7y0mWXJtKzXBAtws7VQLj2ICg8f1E9ne6E=;
        b=ZlkjDB2ifRTxwwZM5YbL7ASzCIFmb+HK8JT02ZrbMFUai7ZYcynBy1/3WrrKUqM74Y
         vcPT20vTb7VZ4wDMEBcoANP82lev4VDf86n01zsf+oMX16NfiISae5RMKFRH6dCDE+6E
         EoaaVpumfn8+NLyR9cJ5I6yU89g8cQCoKvadCJIDP+tOEcRKDreoBE9ZbYDnSLB1DzD8
         Kej+/tN5jBO+zvXEXvKAqtoIBj7810cWxfx1+v1LhL7TLEEkT1gr+3pKmWJSYnScLz9Y
         lKe4ovilAW5teDNma1umlG2wHzfhIElH8jCTzYZyry9OgUs/LrQ9LAm0Fyy9Zu3hNknc
         casQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746961; x=1785351761;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kkZF/WZBw7y0mWXJtKzXBAtws7VQLj2ICg8f1E9ne6E=;
        b=dyFPOFyPj5ik0DunWl+DVftsZYEfvodwZUiuFJhG1OblIxBSFgbSsaLPJT1pzWT2/j
         398FuA6ISCo44lTlhx0+s19IhHdJrLbA3Fm8iNl9bS202xlvOMy6K+VrRqfVX7bbfCTA
         8PyGVL81GVnJNtk+xyWtsLFSJElQvuRMcCXQQG7Xi+f0TyDyb4QZEGuDhVg0M2t+Dff3
         0WT1nElex7PjWwnTVUkkMWYyX20i8f6r3XpP/W6FZokK2lGKF0t0Jq8kTSKbZNXaeHCM
         6N90QW/0koer4BVws9+07lOSC9kSjB755NbRcRLeM6pPRbTYlyrKxW+8nRg4Dm58Fu4o
         rFPA==
X-Forwarded-Encrypted: i=1; AHgh+Rq+1GH/+VI1zfQYJenzaXD5yR/1Hc5eEeN6sI4OOPpXWYLscy8CZhExys+MTdwVegCQ27JYZ6hpynOtPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwx4wYI4Wm3G/cTTKlrR6dhMJEsbDsRw8q+iU6GYz3LTUFW4XX
	JqS8N5S6auDrUO4rAl2veaC6Ca08+vCvjwTgDDULRBeLyXKkx6rx/46I
X-Gm-Gg: AR+sD11fTPlNCLrZA7pGXN2C5VcSYDomkI21V9APlOwmv/YEJ0B0BKtoG/5GlU3xuDX
	wXmmYy0W2PuOjVD9FHIzpD7Y/HuLrviw5bT8wcdnxCImuas/HJpDmqRZEQ6b21fYeV3U/fl82r8
	tcKK1TKqHXENNHCDxeQVhgE26e75ikWIfOWCtcPY6R2EZbYkuAmgPwl5cCyouXaz/04r76qOVhH
	JLcOemAsed225rS3yz8cUgPAd/B18g/xTSe7aYKl410BJXipC5y8MDenHKzTS0de5HQImDihWiS
	GQI2vxE5CgAuQpGvegRcp+Dww0D1mHc5JPHKKEBne5pMDjc8wUs/Mm3ir1a0bWLL113SzSVugWb
	EMSHzR14dFcUqrGlTqDWp3T8UrPoL7zcwLkhPgGkWTyFErT66omr+Ui1UMb6PWgPoxCBhC/7i4P
	bw5f2N6fqja8GOZ2Amx4lFm7blaeygwUUA2d66bHJvqhvqk953wAOVcH6OEA==
X-Received: by 2002:a05:6214:398a:b0:8ef:4749:b1cb with SMTP id 6a1803df08f44-907ca24feb5mr2113136d6.6.1784746960946;
        Wed, 22 Jul 2026 12:02:40 -0700 (PDT)
Received: from ?IPV6:2600:383:440:b4b4:8f4a:ba6:c937:25ed? ([2600:383:440:b4b4:8f4a:ba6:c937:25ed])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba8d5434sm27588656d6.13.2026.07.22.12.02.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2026 12:02:40 -0700 (PDT)
Message-ID: <b928fd4b-7139-4a18-8e00-ef2ce2f1a6fb@gmail.com>
Date: Wed, 22 Jul 2026 15:02:38 -0400
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/2] platform/x86/lenovo: Add Yoga Book 9 keyboard
 dock detection driver
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, hdegoede@redhat.com, W_Armin@gmx.de,
 jikos@kernel.org, linux-input@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>
References: <20260722142712.814597-1-carvsdriver@gmail.com>
 <20260722142712.814597-3-carvsdriver@gmail.com>
 <15943a77-07e3-9449-7e2f-2d72f345dfa2@linux.intel.com>
Content-Language: en-US
From: Dave Carey <carvsdriver@gmail.com>
In-Reply-To: <15943a77-07e3-9449-7e2f-2d72f345dfa2@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ugh ... let me check, was trying to do a few different things today at 
the same time.  Appreciate the patience.


-DC


On 7/22/26 10:42 AM, Ilpo Järvinen wrote:
> On Wed, 22 Jul 2026, Dave Carey wrote:
>
>> The Lenovo Yoga Book 9 14IAH10 ships with a detachable Bluetooth keyboard
>> that magnetically attaches to the bottom (secondary) screen in one of two
>> positions.  The Embedded Controller tracks the attachment state in a 2-bit
>> field called BKBD and signals changes via WMI event GUID
>> 806BD2A2-177B-481D-BFB5-3BA0BB4A2285 (notify ID 0xEB on the WM10 ACPI
>> device, _UID "GMZN").
>>
>> The device contains embedded BMOF data (WQDD, 20705 bytes) documenting
>> both WMI interfaces used by this driver:
>>
>>    LENOVO_BTKBD_EVENT (event GUID): WmiDataId(1) uint32 Status.
>>    The ACPI _WED(0xEB) method returns EC.BKBD directly as an integer,
>>    so the notify callback receives BKBD without a separate query.
>>
>>    LENOVO_FEATURE_STATUS_DATA (block GUID, WQAF method): returns an
>>    8-byte buffer {uint32 IDs=0x00060000, uint32 Status=BKBD}.
>>    Used for the initial state read on probe and after resume.
>>
>> BKBD encoding:
>>    0 = keyboard detached
>>    1 = keyboard docked on top half of bottom screen
>>    2 = keyboard docked on bottom half of bottom screen
>>    3 = reserved (not observed in practice)
>>
>> This driver registers two WMI drivers sharing a module-level
>> BLOCKING_NOTIFIER_HEAD:
>>
>>    - The event driver (LENOVO_BTKBD_EVENT) uses .notify_new() to receive
>>      a pre-parsed wmi_buffer and fires the notifier chain with the BKBD
>>      value extracted from the buffer.
>>
>>    - The block driver (LENOVO_FEATURE_STATUS_DATA) owns the input_dev in
>>      its per-device private struct.  At probe time it registers a
>>      notifier_block on the chain and reads the initial BKBD state via
>>      wmidev_query_block().  The WMI buffer is parsed as
>>      struct lenovo_feature_status { __le32 id; __le32 status; }, and the
>>      ID field is verified before the status is used.
>>
>>    - SW_TABLET_MODE=1 is reported when the keyboard is detached;
>>      SW_TABLET_MODE=0 when docked in either position (keyboard present).
>>
>>    - The raw BKBD value is exposed via read-only sysfs attribute
>>      "keyboard_position".
>>
>>    - BKBD state is re-read via wmidev_query_block() on resume from
>>      suspend or hibernation.
>>
>> Tested on: Lenovo Yoga Book 9 14IAH10 (model 83KJ), kernel 7.0.
>>
>> Acked-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>> Signed-off-by: Dave Carey <carvsdriver@gmail.com>
>> ---
>> v13:
>> - Resend of v12: patch was corrupted in transit.  git-send-email chose
>>    quoted-printable encoding (triggered by non-ASCII in the changelog)
>>    which encoded '=' as '=3D', corrupting the RST table separators in
>>    the ABI doc and breaking git-am.  No content changes from v12.
>>
>> v12:
>> - Add #include <linux/sysfs.h> (for sysfs_emit; Ilpo Järvinen)
>> - Add #include <linux/types.h> (for __le32 and __packed; Ilpo Järvinen)
>>
>> v11 (addressing Armin Wolf's v10 review):
>> - ABI doc: correct Date to "June 2027" and KernelVersion to "7.3"
>>
>> v10 (addressing Armin Wolf's v9 review):
>> - Update ABI doc: Date: June 2026, KernelVersion: 6.16
>> - Add #include <linux/compiler_attributes.h> and <linux/types.h>
>> - yb9_kbdock_query(): change return to pointer-out u32 *bkbd
>> - struct yb9_kbdock_data: add spinlock_t lock
>> - yb9_kbdock_report(): hold lock across input_report_switch + input_sync
>> - yb9_kbdock_sync(): return int, propagate query error to callers
>> - yb9_kbdock_resume(), yb9_kbdock_block_probe(): propagate sync error
>> - struct wmi_buffer out: remove zero-initializer
>> - yb9_kbdock_notify_new(): drop manual length check; use
>>    .min_event_size = sizeof(__le32) in struct wmi_driver instead
>>
>>   .../testing/sysfs-driver-lenovo-yb9-kbdock    |  19 ++
>>   MAINTAINERS                                   |   7 +
>>   drivers/platform/x86/lenovo/Kconfig           |  14 +
>>   drivers/platform/x86/lenovo/Makefile          |   1 +
>>   drivers/platform/x86/lenovo/yb9-kbdock.c      | 312 ++++++++++++++++++
>>   5 files changed, 353 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
>>   create mode 100644 drivers/platform/x86/lenovo/yb9-kbdock.c
>>
>> diff --git a/Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock b/Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
>> new file mode 100644
>> index 0000000..ebe713a
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
>> @@ -0,0 +1,19 @@
>> +What:		/sys/bus/wmi/drivers/lenovo-yb9-kbdock/<guid>/keyboard_position
>> +Date:		June 2027
>> +KernelVersion:	7.3
>> +Contact:	Dave Carey <carvsdriver@gmail.com>
>> +Description:
>> +		Read-only attribute reporting the current keyboard dock position
>> +		as reported by the Embedded Controller on the Lenovo Yoga Book 9
>> +		14IAH10.
>> +
>> +		Possible values:
>> +
>> +		==  =============================================================
>> +		0   keyboard is not docked to any screen (detached)
>> +		1   keyboard docked on the top half of the bottom screen
>> +		2   keyboard docked on the bottom half of the bottom screen
>> +		==  =============================================================
>> +
>> +		SW_TABLET_MODE input events are also emitted: 0 when the keyboard
>> +		is docked (either position), 1 when detached.
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d1cc0e1..00e8275 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -14479,6 +14479,13 @@ L:	platform-driver-x86@vger.kernel.org
>>   S:	Maintained
>>   F:	drivers/platform/x86/lenovo/wmi-hotkey-utilities.c
>>   
>> +LENOVO YOGA BOOK 9 KEYBOARD DOCK DRIVER
>> +M:	Dave Carey <carvsdriver@gmail.com>
>> +L:	platform-driver-x86@vger.kernel.org
>> +S:	Maintained
>> +F:	Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
>> +F:	drivers/platform/x86/lenovo/yb9-kbdock.c
>> +
>>   LETSKETCH HID TABLET DRIVER
>>   M:	Hans de Goede <hansg@kernel.org>
>>   L:	linux-input@vger.kernel.org
>> diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/lenovo/Kconfig
>> index 9c48487..938b361 100644
>> --- a/drivers/platform/x86/lenovo/Kconfig
>> +++ b/drivers/platform/x86/lenovo/Kconfig
>> @@ -43,6 +43,20 @@ config LENOVO_WMI_CAMERA
>>   	  To compile this driver as a module, choose M here: the module
>>   	  will be called lenovo-wmi-camera.
>>   
>> +config LENOVO_YB9_KBDOCK
>> +	tristate "Lenovo Yoga Book 9 keyboard dock detection"
>> +	depends on ACPI_WMI
>> +	depends on DMI
>> +	depends on INPUT
>> +	help
>> +	  Say Y here to enable keyboard dock detection on the Lenovo Yoga Book 9
>> +	  14IAH10.  The detachable Bluetooth keyboard magnetically attaches to
>> +	  either screen; this driver reports SW_TABLET_MODE input events based
>> +	  on the attachment state and exposes the raw position in sysfs.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called lenovo-yb9-kbdock.
>> +
>>   config LENOVO_YMC
>>   	tristate "Lenovo Yoga Tablet Mode Control"
>>   	depends on ACPI_WMI
>> diff --git a/drivers/platform/x86/lenovo/Makefile b/drivers/platform/x86/lenovo/Makefile
>> index 7b2128e..2842d7d 100644
>> --- a/drivers/platform/x86/lenovo/Makefile
>> +++ b/drivers/platform/x86/lenovo/Makefile
>> @@ -8,6 +8,7 @@ obj-$(CONFIG_THINKPAD_LMI)	+= think-lmi.o
>>   obj-$(CONFIG_THINKPAD_ACPI)	+= thinkpad_acpi.o
>>   
>>   lenovo-target-$(CONFIG_LENOVO_WMI_HOTKEY_UTILITIES)	+= wmi-hotkey-utilities.o
>> +lenovo-target-$(CONFIG_LENOVO_YB9_KBDOCK)	+= yb9-kbdock.o
>>   lenovo-target-$(CONFIG_LENOVO_YMC)	+= ymc.o
>>   lenovo-target-$(CONFIG_YOGABOOK)	+= yogabook.o
>>   lenovo-target-$(CONFIG_YT2_1380)	+= yoga-tab2-pro-1380-fastcharger.o
>> diff --git a/drivers/platform/x86/lenovo/yb9-kbdock.c b/drivers/platform/x86/lenovo/yb9-kbdock.c
>> new file mode 100644
>> index 0000000..69c68a0
>> --- /dev/null
>> +++ b/drivers/platform/x86/lenovo/yb9-kbdock.c
>> @@ -0,0 +1,312 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Lenovo Yoga Book 9 keyboard-dock detection
>> + *
>> + * The Yoga Book 9 ships with a detachable Bluetooth keyboard that magnetically
>> + * attaches to the bottom screen in one of two positions.  The EC tracks
>> + * attachment state in a 2-bit field called BKBD and signals changes via WMI
>> + * event 0xEB on the WM10 ACPI device (_UID "GMZN").
>> + *
>> + * BKBD values:
>> + *   0 = keyboard detached
>> + *   1 = keyboard docked on the top half of the bottom screen
>> + *   2 = keyboard docked on the bottom half of the bottom screen
>> + *   3 = reserved / not observed
>> + *
>> + * Two WMI interfaces are used (documented in embedded BMOF, WQDD, 20705 bytes):
>> + *
>> + *   LENOVO_BTKBD_EVENT (event GUID, 806BD2A2-...)
>> + *     WmiDataId(1) uint32 Status — _WED(0xEB) returns EC.BKBD directly.
>> + *     The notify callback receives BKBD as an integer; no separate query needed.
>> + *
>> + *   LENOVO_FEATURE_STATUS_DATA (block GUID, E7F300FA-...)
>> + *     WmiDataId(1) uint32 IDs   = 0x00060000 (feature selector)
>> + *     WmiDataId(2) uint32 Status = BKBD value
>> + *     Used on probe and resume to read initial state.
>> + *
>> + * The event driver (LENOVO_BTKBD_EVENT) fires a notifier chain on each WMI
>> + * event.  The block driver (LENOVO_FEATURE_STATUS_DATA) owns the input_dev
>> + * and registers a notifier_block to receive those events, eliminating the
>> + * need for shared global state or a mutex.
>> + *
>> + * SW_TABLET_MODE=1 is reported when the keyboard is detached;
>> + * SW_TABLET_MODE=0 when docked in either position (keyboard present).
>> + * The raw BKBD value is exposed via the sysfs attribute "keyboard_position".
>> + *
>> + * Copyright (C) 2026 Dave Carey <carvsdriver@gmail.com>
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/dev_printk.h>
>> +#include <linux/dmi.h>
>> +#include <linux/input.h>
>> +#include <linux/module.h>
>> +#include <linux/notifier.h>
>> +#include <linux/pm.h>
>> +#include <linux/slab.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/types.h>
>> +#include <linux/wmi.h>
> Hi,
>
> Are you sure you sent the latest version, AFAICT, v12 had this:
>
> +#include <linux/acpi.h>
> +#include <linux/cleanup.h>
> +#include <linux/compiler_attributes.h>
> +#include <linux/dev_printk.h>
> ...
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/wmi.h>
>
> ?
>
