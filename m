Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325C746F4A0;
	Mon, 14 Sep 2026 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789392736; cv=none; b=s1/UkK51eq0wH9XdQzdF63o/NSivnDpayosKoG20rGkuYjQXPcygdWALUt5aBwaJmYKrw9vrq0bsvyG5urm7IFERcbXJmg6Q/Uz4ktQrMK0HoHA5j8Ng1E/e9AnkzjTMiDl8BMajZYKZmfCW04R2fsmVleNydtdnabN86+TlF9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789392736; c=relaxed/simple;
	bh=S/7DoU9w/adzeImuAELyp83bLhS+5tqqdA6JhGXIO/4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=si4p72LaErq5N1fvBz9HQcAq2fWdwkFl+jAvedPxx8NFjHTsQyDk5KIiHJwL6xKlJL1BMm6p8RC6enMqPnz594o6oJ/Sy2vAc08wrg4yNxLzpS3tluLQbxcqMD8Zb1uR6dui7IeAyZhdqdMP63063lKJnHVaaONzIbk5VfQtS/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=iItvpyeL; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="iItvpyeL"
Received: from [10.235.78.2] (dynamic-176-002-023-136.176.2.pool.telefonica.de [176.2.23.136])
	(Authenticated sender: a.erhardt@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id ED9BB2FC0063;
	Mon, 14 Sep 2026 15:32:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1789392725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BroUSLltzgQ4tFVvgwVa49cEuOWIstWsPc6LnBEpsKI=;
	b=iItvpyeLfzTYVBbES53XX4NhsoNHvDwSebXHJ4u04HcAU0L9p0+gaRD9tmvSbfMtppdYlT
	WOOGgCiIJLv9xShUtlS86qK8igLWUJnCBudV4FL9ZCd6EpsuS0tabsCPbddy7+3hcjlNXC
	LWRDSD5rQmCfOUdtOboyLbOi4UuISwk=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=a.erhardt@tuxedocomputers.com smtp.mailfrom=aer@tuxedocomputers.com
Message-ID: <9ea37d10-7b9b-4f4c-b294-e5f392a8d358@tuxedocomputers.com>
Date: Mon, 14 Sep 2026 15:32:03 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] HID: generic: add LampArray support via
 hid-lamparray helper
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: wse@tuxedocomputers.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Armin Wolf <W_Armin@gmx.de>,
 Cristian Mazzotta <cmmazzo@icloud.com>
References: <20260903073602.3815258-1-aer@tuxedocomputers.com>
Content-Language: en-US
From: Aaron Erhardt <aer@tuxedocomputers.com>
In-Reply-To: <20260903073602.3815258-1-aer@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 03.09.26 um 09:35 schrieb Aaron Erhardt:
> Add a new hid-lamparray helper module and integrate it with the
> hid-generic driver.
> 
> While more complex lamparray handling should be done in userspace via
> hidraw, providing a small module to add basic lamparray support makes it
> possible for userspace software to interact with lamparrays by simply
> using well-known APIs of the LED subsystem. One use-case would be to
> enable desktop environments to support keyboard backlight control out of
> the box for HID lamparray devices without having to implement the whole
> HID protocol themselves.
> 
> This patch is based on previous discussions:
> https://lore.kernel.org/all/1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxedocomputers.com/
> 
> The helper provides basic support for devices exposing a
> Lighting/LampArray application collection (usage page 0x59) and
> registers a single-zone RGB LED representation via the LED
> subsystem.
> 
> hid-generic now checks for LampArray support after hid_parse() and
> optionally registers a lamparray instance. Failures in the helper
> do not abort device probe to keep the driver logic otherwise unchanged.

Another question that came to my mind while doing some tests on what will soon
be posted as v6 is the following: Should we really set everything to zero as a
default? Up to v4, the LEDs were set to full brightness by default which would
be quite annoying in dark environments or when the LEDs of the device are
really bright. Turning everything off like the current implementation on the
other side makes things look like they don't work until a userspace program
takes over control. So I was wondering whether it would be better to just leave
everything in autonomous mode until userspace starts writing to the LED. I'm
not sure yet what the best solution is, so I would like to have some feedback
on that design if possible.

> 
> LampArray resources are released on driver remove.
> 
> This commit was successfully tested on the Microsoft MacroPad reference
> implementation (https://github.com/microsoft/RP2040MacropadHidSample
> 1d6c3ad) and in combination with the tuxedo_nb04_wmi driver, albeit
> only fully functional with a recent fix posted to the LKML
> (https://lore.kernel.org/all/20260826081149.235487-2-aer@tuxedocomputers.com).
> 
> v5:
> - Proper hardware detection (no quirks necessary anymore)
> - Add documentation for new sysfs knob
> - Pass limits of the device to sysfs (intesities & brightness)
> - More flexible Kconfig (use tristate)
> - Improved locking
> - Several memory leak and (de-)initialization fixes
> - Don't read current color values from hardware (the HID spec does not
>   offer this option)
> - Remove redundant report dump functionality
> v4:
> - Restrict CONFIG_HID_LAMPARRAY to built-in configurations only to fix
>   additional randconfig build errors
> v3:
> - Squash V1 and V2 into one patch
> v2:
> - Fix Kconfig to avoid build errors when LEDS_CLASS_MULTICOLOR is
>   disabled
> 
> Aaron Erhardt (2):
>   HID: lamparray: add new LampArray helper module
>   HID: generic: add LampArray support via hid-lamparray helper
> 
>  .../ABI/testing/sysfs-driver-hid-lamparray    |  16 +
>  drivers/hid/Kconfig                           |  18 +
>  drivers/hid/Makefile                          |   2 +
>  drivers/hid/hid-generic.c                     |  38 +
>  drivers/hid/hid-lamparray.c                   | 812 ++++++++++++++++++
>  include/linux/hid-lamparray.h                 |  88 ++
>  6 files changed, 974 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lamparray
>  create mode 100644 drivers/hid/hid-lamparray.c
>  create mode 100644 include/linux/hid-lamparray.h
> 

