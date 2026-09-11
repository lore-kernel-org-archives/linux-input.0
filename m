Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E973CCA12;
	Fri, 11 Sep 2026 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120892; cv=none; b=tESZn0TOVEbRInq8ssOKR0n50iLNgtDdAGOaSE50kRPWOjjCXlt6UgM21KsBzlyvAQ6h0ZGK9yaiRrgu9q0r2moZMAa4RCzn7Qyq4YVYm+0ye7cYASZhFu/X2SHJImFLOzbMJ6+Q9tfPYHJKUuyOr5ZAGnFTMG4qrfL8GhqknE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120892; c=relaxed/simple;
	bh=m2LNCeQtoeoWBWMM+KuDtibR6+RG/g54Jo8tuQwXdN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uCVHBWsB2adLBAqRgdvPB8MmUEXjY+VW7LSRtuorSetI74ZRwhcC+Jrd3GyxQAWd8G+GOriaS2ADPGd3TPp5/wFnLaH58eZRVvNHcqoyR9LrUf3+uDdGQd3N0OACEBhr7CTyLVvETPS7dipay3vY0gazwP0RXgs4KUf+xFvRdss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=PFtasN55; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="PFtasN55"
Received: from [10.10.11.33] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 0F6AD2FC009E;
	Fri, 11 Sep 2026 12:01:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1789120875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q5PiXe+YtJ4kDxSUvGiXx1wqn57hKaXdq6JVWXcKGHI=;
	b=PFtasN55byX5mLZ4wcPiNYBuraAyMO/362oneN8/aYVompv/sdDAijmFCtU31OVEC15CrA
	T3IKHtGpb35VAKS9SoOu8F/JmAnsRXDo/mQJe6Kex2ncCnSvYEhJ0+Mrv88pAsxkiOICG8
	ZJEatcj8Dz1OeVWWrBRTEY8TjLe9o1I=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
Message-ID: <50192f8e-992b-43e2-b333-54d551af03eb@tuxedocomputers.com>
Date: Fri, 11 Sep 2026 12:01:14 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] HID: generic: add LampArray support via
 hid-lamparray helper
To: Armin Wolf <W_Armin@gmx.de>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: wse@tuxedocomputers.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903073602.3815258-1-aer@tuxedocomputers.com>
 <456191a9-f914-4bb3-8cb8-90ed25a13b94@gmx.de>
 <a62d1907-73cb-4cfd-98b1-7cdce3b37541@tuxedocomputers.com>
 <19f2b88a-834a-485b-b546-94e0a604014e@gmx.de>
Content-Language: en-US
From: Aaron Erhardt <aer@tuxedocomputers.com>
In-Reply-To: <19f2b88a-834a-485b-b546-94e0a604014e@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 10.09.26 um 00:36 schrieb Armin Wolf:
> 
> Am 07.09.26 um 18:30 schrieb Aaron Erhardt:
>> Am 04.09.26 um 22:49 schrieb Armin Wolf:
>>> Am 03.09.26 um 09:35 schrieb Aaron Erhardt:
>>>
>>>> Add a new hid-lamparray helper module and integrate it with the
>>>> hid-generic driver.
>>>>
>>>> While more complex lamparray handling should be done in userspace via
>>>> hidraw, providing a small module to add basic lamparray support makes it
>>>> possible for userspace software to interact with lamparrays by simply
>>>> using well-known APIs of the LED subsystem. One use-case would be to
>>>> enable desktop environments to support keyboard backlight control out of
>>>> the box for HID lamparray devices without having to implement the whole
>>>> HID protocol themselves.
>>>>
>>>> This patch is based on previous discussions:
>>>> https://lore.kernel.org/all/1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com/
>>>>
>>>> The helper provides basic support for devices exposing a
>>>> Lighting/LampArray application collection (usage page 0x59) and
>>>> registers a single-zone RGB LED representation via the LED
>>>> subsystem.
>>>>
>>>> hid-generic now checks for LampArray support after hid_parse() and
>>>> optionally registers a lamparray instance. Failures in the helper
>>>> do not abort device probe to keep the driver logic otherwise unchanged.
>>>>
>>>> LampArray resources are released on driver remove.
>>>>
>>>> This commit was successfully tested on the Microsoft MacroPad reference
>>>> implementation (https://github.com/microsoft/RP2040MacropadHidSample
>>>> 1d6c3ad) and in combination with the tuxedo_nb04_wmi driver, albeit
>>>> only fully functional with a recent fix posted to the LKML
>>>> (https://lore.kernel.org/all/20260826081149.235487-2-aer@tuxedocomputers.com).
>>> Nice work, it works on my ASUS Prime B650-Plus. However the behavior of the brightness
>>> attribute is a bit strange:
>>>
>>> - manually setting "brightness" does not change anything (max. is 1)
>>> - setting RGB to "0 0 0" causes "brightness" to become 0
>>> - setting RGB to a non-zero value causes "brightness" to become 1
>>>
>>> Any idea why this happens? I can check if the same problems also exists under Windows,
>>> if requested.
>>>
>>> Thanks,
>>> Armin Wolf
>>>
>> It is completely normal for LampArray devices to only offer two brightness
>> values (1 and 0) for turning the whole LED on and off. Since a lot of
>> userspace software seems to never use brightness (it is more convenient to
>> adjust the RGB channels directly), this was not even properly implemented in
>> the MacropadHidSample until recently:
>> https://github.com/microsoft/RP2040MacropadHidSample/commit/cfc29120a3910c5772976da29ecd57392dfd44d6
>>
>> Thus, I think it is likely, that the implementation is broken and simply
>> ignores brightness. The driver just forwards this to the device.
>>
>> However, the RGB values (aka. multi_intensity) should not interfere with the
>> brightness. Yet, I wasn't able to reproduce this on the Macropad. Capping the
>> brightness to 1 is normal on the other hand, at least if that's the
>> maxIntensity reported by your device.
>>
>> So the only really odd thing for me would be the RGB values influencing the
>> brightness. Please provide more detailed feedback if you can since I can't
>> reproduce this on the hardware available to me.
> 
> I did some further tests, and it turned out that the RGB values indeed do not
> influence the brightness value. It seems that i confused myself during testing xd.
> 
> So it seems that Asus copied the buggy Macropad code. Would it be possible to
> send RGB = (0, 0, 0) when the user has selected brightness 0 to work around this
> firmware bug?

Yes, I think that would be a reasonably small quirk that could be useful for a
wide range of devices. I will add this in the next iteration.

> 
> Thanks,
> Armin Wolf
> 
>> If you want to investigate the LampArray capabilities of your device, you're
>> probably better off with userspace tooling like my lampctl fork:
>> https://github.com/tuxedo-aer/lampctl
>>
>> You can adjust the hardcoded brightness here to see whether your device honors
>> the brightness value or not:
>> https://github.com/tuxedo-aer/lampctl/blob/main/crates/lamparray/src/hid.rs#L36
>>
>>>> v5:
>>>> - Proper hardware detection (no quirks necessary anymore)
>>>> - Add documentation for new sysfs knob
>>>> - Pass limits of the device to sysfs (intesities & brightness)
>>>> - More flexible Kconfig (use tristate)
>>>> - Improved locking
>>>> - Several memory leak and (de-)initialization fixes
>>>> - Don't read current color values from hardware (the HID spec does not
>>>>     offer this option)
>>>> - Remove redundant report dump functionality
>>>> v4:
>>>> - Restrict CONFIG_HID_LAMPARRAY to built-in configurations only to fix
>>>>     additional randconfig build errors
>>>> v3:
>>>> - Squash V1 and V2 into one patch
>>>> v2:
>>>> - Fix Kconfig to avoid build errors when LEDS_CLASS_MULTICOLOR is
>>>>     disabled
>>>>
>>>> Aaron Erhardt (2):
>>>>     HID: lamparray: add new LampArray helper module
>>>>     HID: generic: add LampArray support via hid-lamparray helper
>>>>
>>>>    .../ABI/testing/sysfs-driver-hid-lamparray    |  16 +
>>>>    drivers/hid/Kconfig                           |  18 +
>>>>    drivers/hid/Makefile                          |   2 +
>>>>    drivers/hid/hid-generic.c                     |  38 +
>>>>    drivers/hid/hid-lamparray.c                   | 812 ++++++++++++++++++
>>>>    include/linux/hid-lamparray.h                 |  88 ++
>>>>    6 files changed, 974 insertions(+)
>>>>    create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lamparray
>>>>    create mode 100644 drivers/hid/hid-lamparray.c
>>>>    create mode 100644 include/linux/hid-lamparray.h
>>>>
> 

