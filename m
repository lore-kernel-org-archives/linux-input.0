Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7C3C1D47;
	Fri,  4 Sep 2026 20:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788555000; cv=none; b=dFeJ0k12kg/y2ZcfBzhedYiacGV7pxTPTXg0FijpnjvdHBEQYq+DAAqnVzHlup8ATOLqm7sxSsn0rsLUCJdMo2c94rWCBvhy0wD59DHWH2LGrzUQo6x2xcTnnuxO690gqrkV91rJyMJ5M68wnBcHYEaHB5vbH13bQ/Q3riulFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788555000; c=relaxed/simple;
	bh=NvdPmuMjW+aPyM6/pQ7QQJHHjMNV/X5jhSE9Jt0akJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sW2Lyk+DoltqkTOCvhaxg3OwnExLt8TXiS7mk0ihwgaQtYPJmfxlxJuAOuVe/e1XmLcZpr+Onm9WpO1Dq2gNX8LzgptAdCaup3nqboRInlMSvkm0TaLnamBBuuKqy+7SmJaFrcwr9Eju+AwQJxr5lwfjoeJch+rrnq/X2rcfgXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=BxX3je37; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="BxX3je37"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788554994; x=1789159794; i=w_armin@gmx.de;
	bh=Bd2BC++rnCWcC3UBEfCJ8lX/14zJcz9gRz0FseriHAU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=BxX3je37KW19aORZtmJa9yjrgVfVsPdxgDTZvlYgmqzbmBOAQ2ydfXqLMR8Pgmxl
	 2t0NqPpIckxz43VFwARSzYTGtrv9O8SMEWRd7aSOOwon66mD56a67wrqf6yTKQTp4
	 F3qLthEnGOgnaZsZyO1dAmX3Ti2fp3onYLzs6QuHdAfTGTYAsDowaqzXkmO/c/rG5
	 82jKJxkkodZjAhkHUOAXZtgbrUA9ShZh0kNAoeGJzf/PP1tKWdj+H6NR4NioRCALS
	 c9KLsSkb3lDasSQcADZasVKb1l9uV3BH9uoMPbeRiclHRaISlUfgCXJLdaMH5sq9S
	 Enf9HKv89BTIy4a9bw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDhhN-1xBd010ahj-00D3UY; Fri, 04
 Sep 2026 22:49:54 +0200
Message-ID: <456191a9-f914-4bb3-8cb8-90ed25a13b94@gmx.de>
Date: Fri, 4 Sep 2026 22:49:53 +0200
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] HID: generic: add LampArray support via
 hid-lamparray helper
To: Aaron Erhardt <aer@tuxedocomputers.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: wse@tuxedocomputers.com, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260903073602.3815258-1-aer@tuxedocomputers.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260903073602.3815258-1-aer@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:jdPaUslzmbHcbL7rHzpt91iBEfjW4Ceva1Aum9DWlXPOjn5+BDF
 ZQBbeQMBYw2bcyCbSoJoyURPoMSI9m298kc9hY9KPP7C8HhByNdgsqxcmtvh/VeXvTjYs+a
 BB/8CLp3v+dCyQSTtqLqQ6+1v3sz1yD5I9YNFkGisnqrtRTyDLWQWk4Qq6Ul1uzuPpl9dSS
 YMrG0tSZJcQkMPMm7NROA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OnzLBqPiKMI=;XNBEAy9sT6ZdFvB4xTcEZkpinIm
 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
 CnXr9ZOB+bpsI

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
>
> LampArray resources are released on driver remove.
>
> This commit was successfully tested on the Microsoft MacroPad reference
> implementation (https://github.com/microsoft/RP2040MacropadHidSample
> 1d6c3ad) and in combination with the tuxedo_nb04_wmi driver, albeit
> only fully functional with a recent fix posted to the LKML
> (https://lore.kernel.org/all/20260826081149.235487-2-aer@tuxedocomputers.com).

Nice work, it works on my ASUS Prime B650-Plus. However the behavior of the brightness
attribute is a bit strange:

- manually setting "brightness" does not change anything (max. is 1)
- setting RGB to "0 0 0" causes "brightness" to become 0
- setting RGB to a non-zero value causes "brightness" to become 1

Any idea why this happens? I can check if the same problems also exists under Windows,
if requested.

Thanks,
Armin Wolf

> v5:
> - Proper hardware detection (no quirks necessary anymore)
> - Add documentation for new sysfs knob
> - Pass limits of the device to sysfs (intesities & brightness)
> - More flexible Kconfig (use tristate)
> - Improved locking
> - Several memory leak and (de-)initialization fixes
> - Don't read current color values from hardware (the HID spec does not
>    offer this option)
> - Remove redundant report dump functionality
> v4:
> - Restrict CONFIG_HID_LAMPARRAY to built-in configurations only to fix
>    additional randconfig build errors
> v3:
> - Squash V1 and V2 into one patch
> v2:
> - Fix Kconfig to avoid build errors when LEDS_CLASS_MULTICOLOR is
>    disabled
>
> Aaron Erhardt (2):
>    HID: lamparray: add new LampArray helper module
>    HID: generic: add LampArray support via hid-lamparray helper
>
>   .../ABI/testing/sysfs-driver-hid-lamparray    |  16 +
>   drivers/hid/Kconfig                           |  18 +
>   drivers/hid/Makefile                          |   2 +
>   drivers/hid/hid-generic.c                     |  38 +
>   drivers/hid/hid-lamparray.c                   | 812 ++++++++++++++++++
>   include/linux/hid-lamparray.h                 |  88 ++
>   6 files changed, 974 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-lamparray
>   create mode 100644 drivers/hid/hid-lamparray.c
>   create mode 100644 include/linux/hid-lamparray.h
>
