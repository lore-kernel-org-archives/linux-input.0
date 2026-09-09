Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF5332907;
	Wed,  9 Sep 2026 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993473; cv=none; b=YuzkyX+EDRpn+4A+3FCZTqbBSohJt5MvXdDZSIsRSSed1OkEZdqvgh+JbQc0j59uJhmMEBQD7380wn+DOmGNLeX1cFTd2Wptky2HJ6LrmppVHAiAMmsjVapPvs1qm6EIcmykdKpSnsMqVC4sf6XjZZ3IweEVFTb5X4q5QrvYhCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993473; c=relaxed/simple;
	bh=gqa5g2AA0FFynYgsSVNR5XnE0RSXh7ruXXBo3mjP+Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3mg1KyP1yQIXoLMyKET0vmP82EZ2nGv6P/GBm247BA4Q9DEC862fVSc9IZhnyWkTkmfP6E7uDFGlJxRIn0me4i08lRdZXsf77FRVDL8qNZA9jTaNQcCcDzmE7kIO3e2grxPwLq2B6VmCowiLCiMqeehaZtc9S34FiIrewcjQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=lIFezfwa; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="lIFezfwa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788993417; x=1789598217; i=w_armin@gmx.de;
	bh=bM+qzANRkL5ynEP974owwROOD96q5D9omjRGzZBNdlY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=lIFezfwaOS9V3D7JQy13g03mJMzEfT4AnBCCrgMsSA6G7SowfdG/QoZxSAUb3MWn
	 DTeiFM2j5D0A2B3ueRedJjrbZgvWzqrjiYsX21aZYD8N8v7vStfw6TUrUJwHg4iWM
	 8o2hW1wimSIW8eB1tRHWw4LWarfr+iiXp1s90MhPGyYjLaLCYyjgAAVvM3og06JcZ
	 f3BxNK+Z0upUUMxryCUXscy5x8VrJI9eIQZQK/+8ftANKSdny5q+Y/rPKEdTGEjGb
	 jmeJyk4e2pkZpJjzBev1MkCOm9pfZ0t+PDDcVjzRUfJPXT2RqyHHjyuGgRefJdicn
	 sNzlcbYoOkLQVc7m8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1x1h6M3890-00E5Ll; Thu, 10
 Sep 2026 00:36:56 +0200
Message-ID: <19f2b88a-834a-485b-b546-94e0a604014e@gmx.de>
Date: Thu, 10 Sep 2026 00:36:56 +0200
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
 <456191a9-f914-4bb3-8cb8-90ed25a13b94@gmx.de>
 <a62d1907-73cb-4cfd-98b1-7cdce3b37541@tuxedocomputers.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <a62d1907-73cb-4cfd-98b1-7cdce3b37541@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RxXLpzk/rKSF39vhruNbfzrqRUr5/qkUTK0DO4IoW9BzCF52DUY
 Tt3qFJsGkjd3MIGcfkX3/ejExyORfcPUqQKv1VyzTE//rC4lAhWOiTUQI3GdVqZAswXat5G
 Fc0yzHBoVBZY+PDArZqASpOygBYsgcWct5qK42BfMwOvunXk0WUvTwzZXgYjJ2yXqosiMnD
 P5wCptXxqf+vlLGXkppTg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gmEixv4Aax4=;N2xOnB9mPmUW6Rmbo6dKjmfHBuL
 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
 /wThtI93Yc4ac4vmT2hb9Dk8pvVLSunMzSw==


Am 07.09.26 um 18:30 schrieb Aaron Erhardt:
> Am 04.09.26 um 22:49 schrieb Armin Wolf:
>> Am 03.09.26 um 09:35 schrieb Aaron Erhardt:
>>
>>> Add a new hid-lamparray helper module and integrate it with the
>>> hid-generic driver.
>>>
>>> While more complex lamparray handling should be done in userspace via
>>> hidraw, providing a small module to add basic lamparray support makes =
it
>>> possible for userspace software to interact with lamparrays by simply
>>> using well-known APIs of the LED subsystem. One use-case would be to
>>> enable desktop environments to support keyboard backlight control out =
of
>>> the box for HID lamparray devices without having to implement the whol=
e
>>> HID protocol themselves.
>>>
>>> This patch is based on previous discussions:
>>> https://lore.kernel.org/all/1fb08a74-62c7-4d0c-ba5d-648e23082dcb@tuxed=
ocomputers.com/
>>>
>>> The helper provides basic support for devices exposing a
>>> Lighting/LampArray application collection (usage page 0x59) and
>>> registers a single-zone RGB LED representation via the LED
>>> subsystem.
>>>
>>> hid-generic now checks for LampArray support after hid_parse() and
>>> optionally registers a lamparray instance. Failures in the helper
>>> do not abort device probe to keep the driver logic otherwise unchanged=
.
>>>
>>> LampArray resources are released on driver remove.
>>>
>>> This commit was successfully tested on the Microsoft MacroPad referenc=
e
>>> implementation (https://github.com/microsoft/RP2040MacropadHidSample
>>> 1d6c3ad) and in combination with the tuxedo_nb04_wmi driver, albeit
>>> only fully functional with a recent fix posted to the LKML
>>> (https://lore.kernel.org/all/20260826081149.235487-2-aer@tuxedocompute=
rs.com).
>> Nice work, it works on my ASUS Prime B650-Plus. However the behavior of=
 the brightness
>> attribute is a bit strange:
>>
>> - manually setting "brightness" does not change anything (max. is 1)
>> - setting RGB to "0 0 0" causes "brightness" to become 0
>> - setting RGB to a non-zero value causes "brightness" to become 1
>>
>> Any idea why this happens? I can check if the same problems also exists=
 under Windows,
>> if requested.
>>
>> Thanks,
>> Armin Wolf
>>
> It is completely normal for LampArray devices to only offer two brightne=
ss
> values (1 and 0) for turning the whole LED on and off. Since a lot of
> userspace software seems to never use brightness (it is more convenient =
to
> adjust the RGB channels directly), this was not even properly implemente=
d in
> the MacropadHidSample until recently:
> https://github.com/microsoft/RP2040MacropadHidSample/commit/cfc29120a391=
0c5772976da29ecd57392dfd44d6
>
> Thus, I think it is likely, that the implementation is broken and simply
> ignores brightness. The driver just forwards this to the device.
>
> However, the RGB values (aka. multi_intensity) should not interfere with=
 the
> brightness. Yet, I wasn't able to reproduce this on the Macropad. Cappin=
g the
> brightness to 1 is normal on the other hand, at least if that's the
> maxIntensity reported by your device.
>
> So the only really odd thing for me would be the RGB values influencing =
the
> brightness. Please provide more detailed feedback if you can since I can=
't
> reproduce this on the hardware available to me.

I did some further tests, and it turned out that the RGB values indeed do =
not
influence the brightness value. It seems that i confused myself during tes=
ting xd.

So it seems that Asus copied the buggy Macropad code. Would it be possible=
 to
send RGB =3D (0, 0, 0) when the user has selected brightness 0 to work aro=
und this
firmware bug?

Thanks,
Armin Wolf

> If you want to investigate the LampArray capabilities of your device, yo=
u're
> probably better off with userspace tooling like my lampctl fork:
> https://github.com/tuxedo-aer/lampctl
>
> You can adjust the hardcoded brightness here to see whether your device =
honors
> the brightness value or not:
> https://github.com/tuxedo-aer/lampctl/blob/main/crates/lamparray/src/hid=
.rs#L36
>
>>> v5:
>>> - Proper hardware detection (no quirks necessary anymore)
>>> - Add documentation for new sysfs knob
>>> - Pass limits of the device to sysfs (intesities & brightness)
>>> - More flexible Kconfig (use tristate)
>>> - Improved locking
>>> - Several memory leak and (de-)initialization fixes
>>> - Don't read current color values from hardware (the HID spec does not
>>>  =C2=A0=C2=A0 offer this option)
>>> - Remove redundant report dump functionality
>>> v4:
>>> - Restrict CONFIG_HID_LAMPARRAY to built-in configurations only to fix
>>>  =C2=A0=C2=A0 additional randconfig build errors
>>> v3:
>>> - Squash V1 and V2 into one patch
>>> v2:
>>> - Fix Kconfig to avoid build errors when LEDS_CLASS_MULTICOLOR is
>>>  =C2=A0=C2=A0 disabled
>>>
>>> Aaron Erhardt (2):
>>>  =C2=A0=C2=A0 HID: lamparray: add new LampArray helper module
>>>  =C2=A0=C2=A0 HID: generic: add LampArray support via hid-lamparray he=
lper
>>>
>>>  =C2=A0 .../ABI/testing/sysfs-driver-hid-lamparray=C2=A0=C2=A0=C2=A0 |=
=C2=A0 16 +
>>>  =C2=A0 drivers/hid/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 +
>>>  =C2=A0 drivers/hid/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
>>>  =C2=A0 drivers/hid/hid-generic.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 38 +
>>>  =C2=A0 drivers/hid/hid-lamparray.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 812 ++++++++++++++++++
>>>  =C2=A0 include/linux/hid-lamparray.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 88=
 ++
>>>  =C2=A0 6 files changed, 974 insertions(+)
>>>  =C2=A0 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-=
lamparray
>>>  =C2=A0 create mode 100644 drivers/hid/hid-lamparray.c
>>>  =C2=A0 create mode 100644 include/linux/hid-lamparray.h
>>>
