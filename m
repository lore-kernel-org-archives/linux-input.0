Received: from endrift.com (endrift.com [173.255.198.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49BC257824
	for <linux-input@vger.kernel.org>; Fri,  3 Apr 2026 01:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.198.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775179431; cv=none; b=b/Tb1vIa8/2QReZSFHQSPCTGmJG93LB8WsTxftYUEORQl7gqxNVp3zGUJuqmRHyOB7LLtLt+xEWnZ9Nd0OlbgQYEZjg4G9dVx4du7q2GlPStOf2VPHgEjJTvkZu2KSKdeScIh8e42jkWoDNp/otdBFaytTCknqmA2igFMHUeViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775179431; c=relaxed/simple;
	bh=BCE1xjtTxMgt86PbEAr9nFUoXQjEPAw1qYXsMSFpPuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6qsXR5rBYu1KlfE/ACdbmZZtRnLUbvFJlnGJhAdrBQ8x7zovVkba4LMt0KA63Hqied63zLA+nOs8hn4ToSKVt6sYWw5NmvQHmdbrxJXNCilw1XfDfu2kafGnQhts0K5droDIL/7Use4pdWmoijdMygpxT9sxafeXaQwDDcbOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com; spf=pass smtp.mailfrom=endrift.com; dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b=OqPIM8cV; arc=none smtp.client-ip=173.255.198.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endrift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endrift.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endrift.com header.i=@endrift.com header.b="OqPIM8cV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=endrift.com; s=2020;
	t=1775179064; bh=BCE1xjtTxMgt86PbEAr9nFUoXQjEPAw1qYXsMSFpPuI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OqPIM8cVHNdm3nCajJp5kvvBOd/MUrjtjQrOCpDrL8zrJqKx0cHgvc1CrSWUB8+Xh
	 0FZqzJZwRfwyRkj6Q910Au0RWh9aFFdmBLGj89EYq2YCwS44ZN12vR1teWLWVty3gW
	 5aLZ1979ppfcShqO/OKMxmSdTklilbl1wES1W/Kkxkye94OoRxhSIua4WCtOt1bnTF
	 XIZ8h96c0BOBWxlA6jwr4eDnDGlA2jq8jCVPICDw/qfeUh3zzOFF8nPmyqIEMy9htn
	 n351T74s+d0UsqZXh0JHwd3D2Vs0m4bkKTLyiPyWYIH34GeHLXANB9A+thoz5rMh2l
	 cpbINobDN/Lrg==
Received: from [192.168.0.22] (71-212-73-87.tukw.qwest.net [71.212.73.87])
	by endrift.com (Postfix) with ESMTPSA id ECFB6A039;
	Thu, 02 Apr 2026 18:17:43 -0700 (PDT)
Message-ID: <ee55d9f8-506d-4b95-a63b-01844e4e1bdf@endrift.com>
Date: Thu, 2 Apr 2026 18:17:42 -0700
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] HID: nintendo: Add preliminary Switch 2 controller
 driver
To: Silvan Jegen <s.jegen@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
References: <20260318030850.289712-1-vi@endrift.com>
 <20260318030850.289712-2-vi@endrift.com>
 <3GWQPE79MJ7Y0.2LOOIA8A83N7R@homearch.localdomain>
Content-Language: en-US
From: Vicki Pfau <vi@endrift.com>
Autocrypt: addr=vi@endrift.com; keydata=
 xsBNBFtJAmYBCADmRIN9O/aBbYc93lUMvG2hPip++otLit+65EwNHB1y9BmbVr0Q8Tz7rbAM
 K2mB0EiA4Z3DesoLIOzlJq0E4fgDsAi8ok/i7aTx35d0Qeab95GEdkCMcL98xNJE0agq+KYk
 pnvFlhdyC23K32KdOijsUqqbd86GgxRZmuf/Yf932KxKAj+n0aFBw5y6i0ep7WQBF6ytpqah
 Uzy04D//smiTr6rrXg+C09MX0XZ2Fvcv3gmimnoV6C/ZCO1Zecqyhrs0YFfdIhFEBp2ItYim
 MoeU4g6y726gyRO/+wwzZkryJMU8hHootzW1gUylZeELSwx8uIJSHFiLE7AK+M5soPtDABEB
 AAHNG1ZpY2tpIFBmYXUgPHZpQGVuZHJpZnQuY29tPsLAjgQTAQoAOBYhBNj+0QMp9OPSosB4
 6X72E7X7Nb0rBQJbSQJmAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEH72E7X7Nb0r
 WIcH/0GnIOkmAyy2UlgS/VKi193ZRWYJjBfUncIBf57gLt1KYY0PvUoR9MVvkLqcx8vaCxWh
 bVSqzxT6WU1ECp/URdQV2W4IGB6W4B8rT3VGw0QzbVVQRmt6vReEMFVL+vBfgHKTRBItiy7x
 Bd+JZDusiyrrGok9TqqkBYlZPWE29ajiOAe05N1UhuRq7y8w/bOkzFD36ohMtfqV4hByWV+q
 d0LujqgZm1AkM1FqpJ4j8h1Gox5rpmWfaHJmBQ8HcKqQfwACQCvDNHS2vlTXJYfxlh+mVerL
 YKZgWnyvqx4pLKqJOXQKssIaDjnDfTu6bQgXvhaKb1+piBUYuoe9/+3E15TOwE0EW0kCZgEI
 AL/KzT+NR1/LbJ7Kuv3gAHFp+S7cfyyPSamN6i6/X135vNSawG7g81iWUweAW6YahFA2haqw
 t+8/Bm9Dzc8rF6RHCElK1GoHiF4SIYQxjqPo2wwqvTad9FblWTfaYRKfVDvNz2Rz4i681JrR
 8gizvzJPX+gocH7FMzPwb1DAwL2kKA5wilgAGSv8nZqeG55hNt2t/XiT6Yd97DJv86D24UUP
 BetLTq2jUWtX+omt+JhF3QzMjnyGQYKHNXUB/ipBxNSkwnDrWg/f1EjDtNzuOHManJDC9Bqi
 qhi1abiTNlmmewI5iLEnnxzfSKS5HO9nCC1szl229DHwIMH7jA+G+z0AEQEAAcLAdgQYAQoA
 IBYhBNj+0QMp9OPSosB46X72E7X7Nb0rBQJbSQJmAhsMAAoJEH72E7X7Nb0roioIAM0oDKEU
 QH7Og4+AXm35uklIiCX6cFQPgDVlQn7M/QFLnEhhCfPTt8PkIIN4dLgs4lIJxExpgQWgOLUX
 h+ZLLupzZXoysAXfdwNLf/RqRed/zTZbUjssy4D7yeNIJThzU32kDy0Hx3pMNM/Hd9yaXmHL
 LDkfwcyQuqA9+eeOogkDC8inLNLfYQ8JtVQZuWppNcbOZkBxfMVAmPHg6C9fe2biQFojoLPe
 4nQheprKfBp5QsY2cIjP8kaWPpfJEJ5i2aNgtrfebEzjYoWWLkK78Lo8qABdxkVhH6rhAlw2
 rVf41cHNCfHF7ddvOb9IItWacXxYn7ql+dI/Se3+ISWDboQ=
In-Reply-To: <3GWQPE79MJ7Y0.2LOOIA8A83N7R@homearch.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Replies inline

On 4/2/26 12:09 PM, Silvan Jegen wrote:
> Hi
>=20
> Thanks for the patch!
>=20
> Just some comments and questions inline below.
>=20
> Vicki Pfau <vi@endrift.com> wrote:
>> This adds a new driver for the Switch 2 controllers. The Switch 2 uses=
 an
>> unusual split-interface design such that input and rumble occur on the=
 main
>> HID interface, but all other communication occurs over a "configuratio=
n"
>> interface. This is the case on both USB and Bluetooth, so this new dri=
ver
>> uses a split-driver design with the HID interface being the "main" dri=
ver
>> and the configuration interface is a secondary driver that looks up to=
 the
>> HID interface, sharing resources on a common struct.
>>
>> Due to using a non-standard pairing interface as well as Bluetooth
>> communications being extremely limited in the kernel, a custom interfa=
ce
>> between userspace and the kernel will need to be design, along with br=
ingup
>> in BlueZ. That is beyond the scope of this initial patch, which only
>> contains the generic HID and USB configuration interface drivers.
>>
>> This initial work supports general input for the Joy-Con 2, Pro Contro=
ller
>> 2, and GameCube NSO controllers. IMU, rumble and battery support is no=
t yet
>> present.
>>
>> Signed-off-by: Vicki Pfau <vi@endrift.com>
>> ---
>>  MAINTAINERS                                   |    1 +
>>  drivers/hid/Kconfig                           |   11 +-
>>  drivers/hid/hid-ids.h                         |    4 +
>>  drivers/hid/hid-nintendo.c                    | 1194 ++++++++++++++++=
-
>>  drivers/hid/hid-nintendo.h                    |   72 +
>>  drivers/input/joystick/Kconfig                |   11 +
>>  drivers/input/joystick/Makefile               |    1 +
>>  drivers/input/joystick/nintendo-switch2-usb.c |  353 +++++
>>  8 files changed, 1637 insertions(+), 10 deletions(-)
>>  create mode 100644 drivers/hid/hid-nintendo.h
>>  create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 7b277d5bf3d12..4d1a28df5fd24 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18743,6 +18743,7 @@ F:	drivers/scsi/nsp32*
>> =20
>>  NINTENDO HID DRIVER
>>  M:	Daniel J. Ogorchock <djogorchock@gmail.com>
>> +M:	Vicki Pfau <vi@endrift.com>
>>  L:	linux-input@vger.kernel.org
>>  S:	Maintained
>>  F:	drivers/hid/hid-nintendo*
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index c1d9f7c6a5f23..1a293a6c02c26 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -826,10 +826,13 @@ config HID_NINTENDO
>>  	depends on LEDS_CLASS
>>  	select POWER_SUPPLY
>>  	help
>> -	Adds support for the Nintendo Switch Joy-Cons, NSO, Pro Controller.
>> -	All controllers support bluetooth, and the Pro Controller also suppo=
rts
>> -	its USB mode. This also includes support for the Nintendo Switch Onl=
ine
>> -	Controllers which include the NES, Genesis, SNES, and N64 controller=
s.
>> +	Adds support for the Nintendo Switch Joy-Cons, NSO, Pro Controller, =
as
>> +	well as Nintendo Switch 2 Joy-Cons, Pro Controller, and NSO GameCube=

>> +	controllers. All Switch controllers support bluetooth, and the Pro
>> +	Controller also supports its USB mode. This also includes support fo=
r
>> +	the Nintendo Switch Online Controllers which include the NES, Genesi=
s,
>> +	SNES, and N64 controllers. Switch 2 controllers currently only suppo=
rt
>> +	USB mode.
>> =20
>>  	To compile this driver as a module, choose M here: the
>>  	module will be called hid-nintendo.
>> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
>> index 4ab7640b119ac..a794dad7980f3 100644
>> --- a/drivers/hid/hid-ids.h
>> +++ b/drivers/hid/hid-ids.h
>> @@ -1073,6 +1073,10 @@
>>  #define USB_DEVICE_ID_NINTENDO_SNESCON	0x2017
>>  #define USB_DEVICE_ID_NINTENDO_GENCON	0x201e
>>  #define USB_DEVICE_ID_NINTENDO_N64CON	0x2019
>> +#define USB_DEVICE_ID_NINTENDO_NS2_JOYCONR	0x2066
>> +#define USB_DEVICE_ID_NINTENDO_NS2_JOYCONL	0x2067
>> +#define USB_DEVICE_ID_NINTENDO_NS2_PROCON	0x2069
>> +#define USB_DEVICE_ID_NINTENDO_NS2_GCCON	0x2073
>> =20
>>  #define USB_VENDOR_ID_NOVATEK		0x0603
>>  #define USB_DEVICE_ID_NOVATEK_PCT	0x0600
>> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
>> index 29008c2cc5304..4ab8d4e7558a1 100644
>> --- a/drivers/hid/hid-nintendo.c
>> +++ b/drivers/hid/hid-nintendo.c
>> @@ -1,11 +1,13 @@
>>  // SPDX-License-Identifier: GPL-2.0+
>>  /*
>> - * HID driver for Nintendo Switch Joy-Cons and Pro Controllers
>> + * HID driver for Nintendo Switch Joy-Cons and Pro Controllers, as we=
ll as
>> + * Nintendo Switch 2 Joy-Cons, Pro Controller, and GameCube Controlle=
r
>>   *
>>   * Copyright (c) 2019-2021 Daniel J. Ogorchock <djogorchock@gmail.com=
>
>>   * Portions Copyright (c) 2020 Nadia Holmquist Pedersen <nadia@nhp.sh=
>
>>   * Copyright (c) 2022 Emily Strickland <linux@emily.st>
>>   * Copyright (c) 2023 Ryan McClelland <rymcclel@gmail.com>
>> + * Copyright (c) 2026 Valve Software
>>   *
>>   * The following resources/projects were referenced for this driver:
>>   *   https://github.com/dekuNukem/Nintendo_Switch_Reverse_Engineering=

>> @@ -13,6 +15,8 @@
>>   *   https://github.com/FrotBot/SwitchProConLinuxUSB
>>   *   https://github.com/MTCKC/ProconXInput
>>   *   https://github.com/Davidobot/BetterJoyForCemu
>> + *   https://gist.github.com/shinyquagsire23/66f006b46c56216acbaac6c1=
e2279b64
>> + *   https://github.com/ndeadly/switch2_controller_research
>>   *   hid-wiimote kernel hid driver
>>   *   hid-logitech-hidpp driver
>>   *   hid-sony driver
>> @@ -29,6 +33,7 @@
>>   */
>> =20
>>  #include "hid-ids.h"
>> +#include "hid-nintendo.h"
>>  #include <linux/unaligned.h>
>>  #include <linux/delay.h>
>>  #include <linux/device.h>
>> @@ -41,6 +46,8 @@
>>  #include <linux/module.h>
>>  #include <linux/power_supply.h>
>>  #include <linux/spinlock.h>
>> +#include <linux/usb.h>
>> +#include "usbhid/usbhid.h"
>> =20
>>  /*
>>   * Reference the url below for the following HID report defines:
>> @@ -2614,7 +2621,7 @@ static int joycon_ctlr_handle_event(struct joyco=
n_ctlr *ctlr, u8 *data,
>>  	return ret;
>>  }
>> =20
>> -static int nintendo_hid_event(struct hid_device *hdev,
>> +static int joycon_event(struct hid_device *hdev,
>>  			      struct hid_report *report, u8 *raw_data, int size)
>>  {
>>  	struct joycon_ctlr *ctlr =3D hid_get_drvdata(hdev);
>> @@ -2625,7 +2632,7 @@ static int nintendo_hid_event(struct hid_device =
*hdev,
>>  	return joycon_ctlr_handle_event(ctlr, raw_data, size);
>>  }
>> =20
>> -static int nintendo_hid_probe(struct hid_device *hdev,
>> +static int joycon_probe(struct hid_device *hdev,
>>  			    const struct hid_device_id *id)
>>  {
>>  	int ret;
>> @@ -2729,7 +2736,7 @@ static int nintendo_hid_probe(struct hid_device =
*hdev,
>>  	return ret;
>>  }
>> =20
>> -static void nintendo_hid_remove(struct hid_device *hdev)
>> +static void joycon_remove(struct hid_device *hdev)
>>  {
>>  	struct joycon_ctlr *ctlr =3D hid_get_drvdata(hdev);
>>  	unsigned long flags;
>> @@ -2748,7 +2755,9 @@ static void nintendo_hid_remove(struct hid_devic=
e *hdev)
>>  	hid_hw_stop(hdev);
>>  }
>> =20
>> -static int nintendo_hid_resume(struct hid_device *hdev)
>> +#ifdef CONFIG_PM
>> +
>> +static int joycon_resume(struct hid_device *hdev)
>>  {
>>  	struct joycon_ctlr *ctlr =3D hid_get_drvdata(hdev);
>>  	int ret;
>> @@ -2771,7 +2780,7 @@ static int nintendo_hid_resume(struct hid_device=
 *hdev)
>>  	return ret;
>>  }
>> =20
>> -static int nintendo_hid_suspend(struct hid_device *hdev, pm_message_t=
 message)
>> +static int joycon_suspend(struct hid_device *hdev, pm_message_t messa=
ge)
>>  {
>>  	struct joycon_ctlr *ctlr =3D hid_get_drvdata(hdev);
>> =20
>> @@ -2790,7 +2799,1120 @@ static int nintendo_hid_suspend(struct hid_de=
vice *hdev, pm_message_t message)
>>  	return 0;
>>  }
>> =20
>> +#endif
>> +
>> +/*
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> + * Switch 2 support
>> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> + */
>> +#define NS2_BTNR_B	BIT(0)
>> +#define NS2_BTNR_A	BIT(1)
>> +#define NS2_BTNR_Y	BIT(2)
>> +#define NS2_BTNR_X	BIT(3)
>> +#define NS2_BTNR_R	BIT(4)
>> +#define NS2_BTNR_ZR	BIT(5)
>> +#define NS2_BTNR_PLUS	BIT(6)
>> +#define NS2_BTNR_RS	BIT(7)
>> +
>> +#define NS2_BTNL_DOWN	BIT(0)
>> +#define NS2_BTNL_RIGHT	BIT(1)
>> +#define NS2_BTNL_LEFT	BIT(2)
>> +#define NS2_BTNL_UP	BIT(3)
>> +#define NS2_BTNL_L	BIT(4)
>> +#define NS2_BTNL_ZL	BIT(5)
>> +#define NS2_BTNL_MINUS	BIT(6)
>> +#define NS2_BTNL_LS	BIT(7)
>> +
>> +#define NS2_BTN3_C	BIT(4)
>> +#define NS2_BTN3_SR	BIT(6)
>> +#define NS2_BTN3_SL	BIT(7)
>> +
>> +#define NS2_BTN_JCR_HOME	BIT(0)
>> +#define NS2_BTN_JCR_GR		BIT(2)
>> +#define NS2_BTN_JCR_C		NS2_BTN3_C
>> +#define NS2_BTN_JCR_SR		NS2_BTN3_SR
>> +#define NS2_BTN_JCR_SL		NS2_BTN3_SL
>> +
>> +#define NS2_BTN_JCL_CAPTURE	BIT(0)
>> +#define NS2_BTN_JCL_GL		BIT(2)
>> +#define NS2_BTN_JCL_SR		NS2_BTN3_SR
>> +#define NS2_BTN_JCL_SL		NS2_BTN3_SL
>> +
>> +#define NS2_BTN_PRO_HOME	BIT(0)
>> +#define NS2_BTN_PRO_CAPTURE	BIT(1)
>> +#define NS2_BTN_PRO_GR		BIT(2)
>> +#define NS2_BTN_PRO_GL		BIT(3)
>> +#define NS2_BTN_PRO_C		NS2_BTN3_C
>> +
>> +#define NS2_BTN_GC_HOME		BIT(0)
>> +#define NS2_BTN_GC_CAPTURE	BIT(1)
>> +#define NS2_BTN_GC_C		NS2_BTN3_C
>> +
>> +#define NS2_TRIGGER_RANGE	4095
>> +#define NS2_AXIS_MIN		-32768
>> +#define NS2_AXIS_MAX		32767
>> +
>> +#define NS2_MAX_PLAYER_ID	8
>> +
>> +#define NS2_MAX_INIT_RETRIES	4
>> +
>> +#define NS2_FLASH_ADDR_SERIAL			0x13002
>> +#define NS2_FLASH_ADDR_FACTORY_PRIMARY_CALIB	0x130a8
>> +#define NS2_FLASH_ADDR_FACTORY_SECONDARY_CALIB	0x130e8
>> +#define NS2_FLASH_ADDR_FACTORY_TRIGGER_CALIB	0x13140
>> +#define NS2_FLASH_ADDR_USER_PRIMARY_CALIB	0x1fc040
>> +#define NS2_FLASH_ADDR_USER_SECONDARY_CALIB	0x1fc080
>> +
>> +#define NS2_FLASH_SIZE_SERIAL 0x10
>> +#define NS2_FLASH_SIZE_FACTORY_AXIS_CALIB 9
>> +#define NS2_FLASH_SIZE_FACTORY_TRIGGER_CALIB 2
>> +#define NS2_FLASH_SIZE_USER_AXIS_CALIB 11
>> +
>> +#define NS2_USER_CALIB_MAGIC 0xa1b2
>> +
>> +#define NS2_FEATURE_BUTTONS	BIT(0)
>> +#define NS2_FEATURE_ANALOG	BIT(1)
>> +#define NS2_FEATURE_IMU		BIT(2)
>> +#define NS2_FEATURE_MOUSE	BIT(4)
>> +#define NS2_FEATURE_RUMBLE	BIT(5)
>> +#define NS2_FEATURE_MAGNETO	BIT(7)
>> +
>> +enum switch2_subcmd_flash {
>> +	NS2_SUBCMD_FLASH_READ_BLOCK =3D 0x01,
>> +	NS2_SUBCMD_FLASH_WRITE_BLOCK =3D 0x02,
>> +	NS2_SUBCMD_FLASH_ERASE_BLOCK =3D 0x03,
>> +	NS2_SUBCMD_FLASH_READ =3D 0x04,
>> +	NS2_SUBCMD_FLASH_WRITE =3D 0x05,
>> +};
>> +
>> +enum switch2_subcmd_init {
>> +	NS2_SUBCMD_INIT_SELECT_REPORT =3D 0xa,
>> +	NS2_SUBCMD_INIT_USB =3D 0xd,
>> +};
>> +
>> +enum switch2_subcmd_feature_select {
>> +	NS2_SUBCMD_FEATSEL_GET_INFO =3D 0x1,
>> +	NS2_SUBCMD_FEATSEL_SET_MASK =3D 0x2,
>> +	NS2_SUBCMD_FEATSEL_CLEAR_MASK =3D 0x3,
>> +	NS2_SUBCMD_FEATSEL_ENABLE =3D 0x4,
>> +	NS2_SUBCMD_FEATSEL_DISABLE =3D 0x5,
>> +};
>> +
>> +enum switch2_subcmd_grip {
>> +	NS2_SUBCMD_GRIP_GET_INFO =3D 0x1,
>> +	NS2_SUBCMD_GRIP_ENABLE_BUTTONS =3D 0x2,
>> +	NS2_SUBCMD_GRIP_GET_INFO_EXT =3D 0x3,
>> +};
>> +
>> +enum switch2_subcmd_led {
>> +	NS2_SUBCMD_LED_P1 =3D 0x1,
>> +	NS2_SUBCMD_LED_P2 =3D 0x2,
>> +	NS2_SUBCMD_LED_P3 =3D 0x3,
>> +	NS2_SUBCMD_LED_P4 =3D 0x4,
>> +	NS2_SUBCMD_LED_ALL_ON =3D 0x5,
>> +	NS2_SUBCMD_LED_ALL_OFF =3D 0x6,
>> +	NS2_SUBCMD_LED_PATTERN =3D 0x7,
>> +	NS2_SUBCMD_LED_BLINK =3D 0x8,
>> +};
>> +
>> +enum switch2_subcmd_fw_info {
>> +	NS2_SUBCMD_FW_INFO_GET =3D 0x1,
>> +};
>> +
>> +enum switch2_ctlr_type {
>> +	NS2_CTLR_TYPE_JCL =3D 0x00,
>> +	NS2_CTLR_TYPE_JCR =3D 0x01,
>> +	NS2_CTLR_TYPE_PRO =3D 0x02,
>> +	NS2_CTLR_TYPE_GC =3D 0x03,
>> +};
>> +
>> +enum switch2_report_id {
>> +	NS2_REPORT_UNIFIED =3D 0x05,
>> +	NS2_REPORT_JCL =3D 0x07,
>> +	NS2_REPORT_JCR =3D 0x08,
>> +	NS2_REPORT_PRO =3D 0x09,
>> +	NS2_REPORT_GC =3D 0x0a,
>> +};
>> +
>> +enum switch2_init_step {
>> +	NS2_INIT_READ_SERIAL,
>> +	NS2_INIT_GET_FIRMWARE_INFO,
>> +	NS2_INIT_READ_FACTORY_PRIMARY_CALIB,
>> +	NS2_INIT_READ_FACTORY_SECONDARY_CALIB,
>> +	NS2_INIT_READ_FACTORY_TRIGGER_CALIB,
>> +	NS2_INIT_READ_USER_PRIMARY_CALIB,
>> +	NS2_INIT_READ_USER_SECONDARY_CALIB,
>> +	NS2_INIT_SET_FEATURE_MASK,
>> +	NS2_INIT_ENABLE_FEATURES,
>> +	NS2_INIT_GRIP_BUTTONS,
>> +	NS2_INIT_REPORT_FORMAT,
>> +	NS2_INIT_SET_PLAYER_LEDS,
>> +	NS2_INIT_INPUT,
>> +	NS2_INIT_FINISH,
>> +	NS2_INIT_DONE,
>> +};
>> +
>> +struct switch2_version_info {
>> +	uint8_t major;
>> +	uint8_t minor;
>> +	uint8_t patch;
>> +	uint8_t ctlr_type;
>> +	__le32 unk;
>> +	int8_t dsp_major;
>> +	int8_t dsp_minor;
>> +	int8_t dsp_patch;
>> +	int8_t dsp_type;
>> +};
>> +
>> +struct switch2_axis_calibration {
>> +	uint16_t neutral;
>> +	uint16_t negative;
>> +	uint16_t positive;
>> +};
>> +
>> +struct switch2_stick_calibration {
>> +	struct switch2_axis_calibration x;
>> +	struct switch2_axis_calibration y;
>> +};
>> +
>> +struct switch2_controller {
>> +	struct hid_device *hdev;
>> +	struct switch2_cfg_intf *cfg;
>> +
>> +	char name[64];
>> +	char phys[64];
>> +	struct list_head entry;
>> +	struct mutex lock;
>> +
>> +	enum switch2_ctlr_type ctlr_type;
>> +	enum switch2_init_step init_step;
>> +	struct input_dev __rcu *input;
>> +	char serial[NS2_FLASH_SIZE_SERIAL + 1];
>> +	struct switch2_version_info version;
>> +
>> +	struct switch2_stick_calibration stick_calib[2];
>> +	uint8_t lt_zero;
>> +	uint8_t rt_zero;
>> +
>> +	uint32_t player_id;
>> +	struct led_classdev leds[4];
>> +};
>> +
>> +static DEFINE_MUTEX(switch2_controllers_lock);
>> +static LIST_HEAD(switch2_controllers);
>> +
>> +struct switch2_ctlr_button_mapping {
>> +	uint32_t code;
>> +	int byte;
>> +	uint32_t bit;
>> +};
>> +
>> +static const struct switch2_ctlr_button_mapping ns2_left_joycon_butto=
n_mappings[] =3D {
>> +	{ BTN_DPAD_LEFT,	0, NS2_BTNL_LEFT,	},
>> +	{ BTN_DPAD_UP,		0, NS2_BTNL_UP,		},
>> +	{ BTN_DPAD_DOWN,	0, NS2_BTNL_DOWN,	},
>> +	{ BTN_DPAD_RIGHT,	0, NS2_BTNL_RIGHT,	},
>> +	{ BTN_TL,		0, NS2_BTNL_L,		},
>> +	{ BTN_TL2,		0, NS2_BTNL_ZL,		},
>> +	{ BTN_SELECT,		0, NS2_BTNL_MINUS,	},
>> +	{ BTN_THUMBL,		0, NS2_BTNL_LS,		},
>> +	{ KEY_RECORD,		1, NS2_BTN_JCL_CAPTURE,	},
>> +	{ BTN_GRIPR,		1, NS2_BTN_JCL_SL,	},
>> +	{ BTN_GRIPR2,		1, NS2_BTN_JCL_SR,	},
>> +	{ BTN_GRIPL,		1, NS2_BTN_JCL_GL,	},
>> +	{ /* sentinel */ },
>> +};
>> +
>> +static const struct switch2_ctlr_button_mapping ns2_right_joycon_butt=
on_mappings[] =3D {
>> +	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
>> +	{ BTN_EAST,	0, NS2_BTNR_B,		},
>> +	{ BTN_NORTH,	0, NS2_BTNR_X,		},
>> +	{ BTN_WEST,	0, NS2_BTNR_Y,		},
>> +	{ BTN_TR,	0, NS2_BTNR_R,		},
>> +	{ BTN_TR2,	0, NS2_BTNR_ZR,		},
>> +	{ BTN_START,	0, NS2_BTNR_PLUS,	},
>> +	{ BTN_THUMBR,	0, NS2_BTNR_RS,		},
>> +	{ BTN_C,	1, NS2_BTN_JCR_C,	},
>> +	{ BTN_MODE,	1, NS2_BTN_JCR_HOME,	},
>> +	{ BTN_GRIPL2,	1, NS2_BTN_JCR_SL,	},
>> +	{ BTN_GRIPL,	1, NS2_BTN_JCR_SR,	},
>> +	{ BTN_GRIPR,	1, NS2_BTN_JCR_GR,	},
>> +	{ /* sentinel */ },
>> +};
>> +
>> +static const struct switch2_ctlr_button_mapping ns2_procon_mappings[]=
 =3D {
>> +	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
>> +	{ BTN_EAST,	0, NS2_BTNR_B,		},
>> +	{ BTN_NORTH,	0, NS2_BTNR_X,		},
>> +	{ BTN_WEST,	0, NS2_BTNR_Y,		},
>> +	{ BTN_TL,	1, NS2_BTNL_L,		},
>> +	{ BTN_TR,	0, NS2_BTNR_R,		},
>> +	{ BTN_TL2,	1, NS2_BTNL_ZL,		},
>> +	{ BTN_TR2,	0, NS2_BTNR_ZR,		},
>> +	{ BTN_SELECT,	1, NS2_BTNL_MINUS,	},
>> +	{ BTN_START,	0, NS2_BTNR_PLUS,	},
>> +	{ BTN_THUMBL,	1, NS2_BTNL_LS,		},
>> +	{ BTN_THUMBR,	0, NS2_BTNR_RS,		},
>> +	{ BTN_MODE,	2, NS2_BTN_PRO_HOME	},
>> +	{ KEY_RECORD,	2, NS2_BTN_PRO_CAPTURE	},
>> +	{ BTN_GRIPR,	2, NS2_BTN_PRO_GR	},
>> +	{ BTN_GRIPL,	2, NS2_BTN_PRO_GL	},
>> +	{ BTN_C,	2, NS2_BTN_PRO_C	},
>> +	{ /* sentinel */ },
>> +};
>> +
>> +static const struct switch2_ctlr_button_mapping ns2_gccon_mappings[] =
=3D {
>> +	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
>> +	{ BTN_EAST,	0, NS2_BTNR_B,		},
>> +	{ BTN_NORTH,	0, NS2_BTNR_X,		},
>> +	{ BTN_WEST,	0, NS2_BTNR_Y,		},
>> +	{ BTN_TL2,	1, NS2_BTNL_L,		},
>> +	{ BTN_TR2,	0, NS2_BTNR_R,		},
>> +	{ BTN_TL,	1, NS2_BTNL_ZL,		},
>> +	{ BTN_TR,	0, NS2_BTNR_ZR,		},
>> +	{ BTN_SELECT,	1, NS2_BTNL_MINUS,	},
>> +	{ BTN_START,	0, NS2_BTNR_PLUS,	},
>> +	{ BTN_MODE,	2, NS2_BTN_GC_HOME	},
>> +	{ KEY_RECORD,	2, NS2_BTN_GC_CAPTURE	},
>> +	{ BTN_C,	2, NS2_BTN_GC_C		},
>> +	{ /* sentinel */ },
>> +};
>> +
>> +static const uint8_t switch2_init_cmd_data[] =3D {
>> +	/*
>> +	 * The last 6 bytes of this packet are the MAC address of
>> +	 * the console, but we don't need that for USB
>> +	 */
>> +	0x01, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
>> +};
>> +
>> +static const uint8_t switch2_one_data[] =3D { 0x01, 0x00, 0x00, 0x00 =
};
>> +
>> +static const uint8_t switch2_feature_mask[] =3D {
>> +	NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG | NS2_FEATURE_IMU,
>> +	0x00, 0x00, 0x00
>> +};
>> +
>> +static void switch2_init_step_done(struct switch2_controller *ns2, en=
um switch2_init_step step)
>> +{
>> +	if (ns2->init_step !=3D step)
>> +		return;
>> +
>> +	ns2->init_step++;
>> +}
>> +
>> +static inline bool switch2_ctlr_is_joycon(enum switch2_ctlr_type type=
)
>> +{
>> +	return type =3D=3D NS2_CTLR_TYPE_JCL || type =3D=3D NS2_CTLR_TYPE_JC=
R;
>> +}
>> +
>> +static int switch2_set_leds(struct switch2_controller *ns2)
>> +{
>> +	int i;
>> +	uint8_t message[8] =3D { 0 };
>> +
>> +	for (i =3D 0; i < JC_NUM_LEDS; i++)
>> +		message[0] |=3D (!!ns2->leds[i].brightness) << i;
>> +
>> +	if (!ns2->cfg)
>> +		return -ENOTCONN;
>> +	return ns2->cfg->send_command(NS2_CMD_LED, NS2_SUBCMD_LED_PATTERN,
>> +		&message, sizeof(message),
>> +		ns2->cfg);
>> +}
>> +
>> +static int switch2_player_led_brightness_set(struct led_classdev *led=
,
>> +					    enum led_brightness brightness)
>> +{
>> +	struct device *dev =3D led->dev->parent;
>> +	struct hid_device *hdev =3D to_hid_device(dev);
>> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
>> +
>> +	if (!ns2)
>> +		return -ENODEV;
>> +
>> +	guard(mutex)(&ns2->lock);
>> +	return switch2_set_leds(ns2);
>> +}
>> +
>> +static void switch2_leds_create(struct switch2_controller *ns2)
>> +{
>> +	struct hid_device *hdev =3D ns2->hdev;
>> +	struct led_classdev *led;
>> +	int i;
>> +	int player_led_pattern;
>> +
>> +	player_led_pattern =3D ns2->player_id % JC_NUM_LED_PATTERNS;
>> +	hid_dbg(hdev, "assigned player %d led pattern", player_led_pattern +=
 1);
>> +
>> +	for (i =3D 0; i < JC_NUM_LEDS; i++) {
>> +		led =3D &ns2->leds[i];
>> +		led->brightness =3D joycon_player_led_patterns[player_led_pattern][=
i];
>> +		led->max_brightness =3D 1;
>> +		led->brightness_set_blocking =3D switch2_player_led_brightness_set;=

>> +		led->flags =3D LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE;
>> +	}
>> +}
>> +
>> +static void switch2_config_buttons(struct input_dev *idev,
>> +	const struct switch2_ctlr_button_mapping button_mappings[])
>> +{
>> +	const struct switch2_ctlr_button_mapping *button;
>> +
>> +	for (button =3D button_mappings; button->code; button++)
>> +		input_set_capability(idev, EV_KEY, button->code);
>> +}
>> +
>> +static int switch2_init_input(struct switch2_controller *ns2)
>> +{
>> +	struct input_dev *input;
>> +	struct hid_device *hdev =3D ns2->hdev;
>> +	int i;
>> +	int ret;
>> +
>> +	switch2_init_step_done(ns2, NS2_INIT_FINISH);
>> +
>> +	rcu_read_lock();
>> +	input =3D rcu_dereference(ns2->input);
>> +	rcu_read_unlock();
>> +
>> +	if (input)
>> +		return 0;
>> +
>> +	input =3D devm_input_allocate_device(&hdev->dev);
>> +	if (!input)
>> +		return -ENOMEM;
>> +
>> +	input_set_drvdata(input, ns2);
>> +	input->dev.parent =3D &hdev->dev;
>> +	input->id.bustype =3D hdev->bus;
>> +	input->id.vendor =3D hdev->vendor;
>> +	input->id.product =3D hdev->product;
>> +	input->id.version =3D hdev->version;
>> +	input->uniq =3D ns2->serial;
>> +	input->name =3D ns2->name;
>> +	input->phys =3D hdev->phys;
>> +
>> +	switch (ns2->ctlr_type) {
>> +	case NS2_CTLR_TYPE_JCL:
>> +		input_set_abs_params(input, ABS_X, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
>> +		input_set_abs_params(input, ABS_Y, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
>> +		switch2_config_buttons(input, ns2_left_joycon_button_mappings);
>> +		break;
>> +	case NS2_CTLR_TYPE_JCR:
>> +		input_set_abs_params(input, ABS_X, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
>> +		input_set_abs_params(input, ABS_Y, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
>> +		switch2_config_buttons(input, ns2_right_joycon_button_mappings);
>> +		break;
>> +	case NS2_CTLR_TYPE_GC:
>> +		input_set_abs_params(input, ABS_X, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
>> +		input_set_abs_params(input, ABS_Y, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
>> +		input_set_abs_params(input, ABS_RX, NS2_AXIS_MIN, NS2_AXIS_MAX, 32,=
 128);
>> +		input_set_abs_params(input, ABS_RY, NS2_AXIS_MIN, NS2_AXIS_MAX, 32,=
 128);
>> +		input_set_abs_params(input, ABS_Z, 0, NS2_TRIGGER_RANGE, 32, 128);
>> +		input_set_abs_params(input, ABS_RZ, 0, NS2_TRIGGER_RANGE, 32, 128);=

>> +		input_set_abs_params(input, ABS_HAT0X, -1, 1, 0, 0);
>> +		input_set_abs_params(input, ABS_HAT0Y, -1, 1, 0, 0);
>> +		switch2_config_buttons(input, ns2_gccon_mappings);
>> +		break;
>> +	case NS2_CTLR_TYPE_PRO:
>> +		input_set_abs_params(input, ABS_X, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
>> +		input_set_abs_params(input, ABS_Y, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
>> +		input_set_abs_params(input, ABS_RX, NS2_AXIS_MIN, NS2_AXIS_MAX, 32,=
 128);
>> +		input_set_abs_params(input, ABS_RY, NS2_AXIS_MIN, NS2_AXIS_MAX, 32,=
 128);
>> +		input_set_abs_params(input, ABS_HAT0X, -1, 1, 0, 0);
>> +		input_set_abs_params(input, ABS_HAT0Y, -1, 1, 0, 0);
>> +		switch2_config_buttons(input, ns2_procon_mappings);
>> +		break;
>> +	default:
>> +		input_free_device(input);
>> +		return -EINVAL;
>> +	}
>> +
>> +	hid_info(ns2->hdev, "Firmware version %u.%u.%u (type %i)\n", ns2->ve=
rsion.major,
>> +		ns2->version.minor, ns2->version.patch, ns2->version.ctlr_type);
>> +	if (ns2->version.dsp_type >=3D 0)
>> +		hid_info(ns2->hdev, "DSP version %u.%u.%u\n", ns2->version.dsp_majo=
r,
>> +			ns2->version.dsp_minor, ns2->version.dsp_patch);
>> +
>> +	ret =3D input_register_device(input);
>> +	if (ret < 0) {
>> +		hid_err(ns2->hdev, "Failed to register input; ret=3D%d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	for (i =3D 0; i < JC_NUM_LEDS; i++) {
>> +		struct led_classdev *led =3D &ns2->leds[i];
>> +		char *name =3D devm_kasprintf(&input->dev, GFP_KERNEL, "%s:%s:%s",
>> +				      dev_name(&input->dev),
>> +				      "green",
>> +				      joycon_player_led_names[i]);
>> +
>> +		if (!name)
>> +			return -ENOMEM;
>> +
>> +		led->name =3D name;
>> +		ret =3D devm_led_classdev_register(&input->dev, led);
>> +		if (ret < 0) {
>> +			dev_err(&input->dev, "Failed to register player %d LED; ret=3D%d\n=
",
>> +				i + 1, ret);
>> +			input_unregister_device(input);
>> +			return ret;
>> +		}
>> +	}
>> +
>> +	rcu_assign_pointer(ns2->input, input);
>> +	synchronize_rcu();
>> +	return 0;
>> +}
>> +
>> +static struct switch2_controller *switch2_get_controller(const char *=
phys)
>> +{
>> +	struct switch2_controller *ns2;
>> +
>> +	guard(mutex)(&switch2_controllers_lock);
>> +	list_for_each_entry(ns2, &switch2_controllers, entry) {
>> +		if (strncmp(ns2->phys, phys, sizeof(ns2->phys)) =3D=3D 0)
>> +			return ns2;
>> +	}
>> +	ns2 =3D kzalloc(sizeof(*ns2), GFP_KERNEL);
>> +	if (!ns2)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	mutex_init(&ns2->lock);
>> +	INIT_LIST_HEAD(&ns2->entry);
>> +	list_add(&ns2->entry, &switch2_controllers);
>> +	strscpy(ns2->phys, phys, sizeof(ns2->phys));
>> +	return ns2;
>> +}
>> +
>> +static void switch2_controller_put(struct switch2_controller *ns2)
>> +{
>> +	struct input_dev *input;
>> +	bool do_free;
>> +
>> +	guard(mutex)(&switch2_controllers_lock);
>> +	mutex_lock(&ns2->lock);
>> +
>> +	rcu_read_lock();
>> +	input =3D rcu_dereference(ns2->input);
>> +	rcu_read_unlock();
>> +
>> +	rcu_assign_pointer(ns2->input, NULL);
>> +	synchronize_rcu();
>> +
>> +	ns2->init_step =3D 0;
>> +	do_free =3D !ns2->hdev && !ns2->cfg;
>> +	mutex_unlock(&ns2->lock);
>> +
>> +	if (input)
>> +		input_unregister_device(input);
>> +
>> +	if (do_free) {
>> +		list_del_init(&ns2->entry);
>> +		mutex_destroy(&ns2->lock);
>> +		kfree(ns2);
>> +	}
>> +}
>> +
>> +static bool switch2_parse_stick_calibration(struct switch2_stick_cali=
bration *calib,
>> +	const uint8_t *data)
>> +{
>> +	static const uint8_t UNCALIBRATED[9] =3D {
>> +		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
>> +	};
>> +	if (memcmp(UNCALIBRATED, data, sizeof(UNCALIBRATED)) =3D=3D 0)
>> +		return false;
>> +
>> +	calib->x.neutral =3D data[0];
>> +	calib->x.neutral |=3D (data[1] & 0x0F) << 8;
>> +
>> +	calib->y.neutral =3D data[1] >> 4;
>> +	calib->y.neutral |=3D data[2] << 4;
>> +
>> +	calib->x.positive =3D data[3];
>> +	calib->x.positive |=3D (data[4] & 0x0F) << 8;
>> +
>> +	calib->y.positive =3D data[4] >> 4;
>> +	calib->y.positive |=3D data[5] << 4;
>> +
>> +	calib->x.negative =3D data[6];
>> +	calib->x.negative |=3D (data[7] & 0x0F) << 8;
>> +
>> +	calib->y.negative =3D data[7] >> 4;
>> +	calib->y.negative |=3D data[8] << 4;
>> +
>> +	return true;
>> +}
>> +
>> +static void switch2_handle_flash_read(struct switch2_controller *ns2,=
 uint8_t size,
>> +	uint32_t address, const uint8_t *data)
>> +{
>> +	bool ok;
>> +
>> +	switch (address) {
>> +	case NS2_FLASH_ADDR_SERIAL:
>> +		if (size !=3D NS2_FLASH_SIZE_SERIAL)
>> +			return;
>> +		memcpy(ns2->serial, data, size);
>> +		switch2_init_step_done(ns2, NS2_INIT_READ_SERIAL);
>> +		break;
>> +	case NS2_FLASH_ADDR_FACTORY_PRIMARY_CALIB:
>> +		if (size !=3D NS2_FLASH_SIZE_FACTORY_AXIS_CALIB)
>> +			return;
>> +		switch2_init_step_done(ns2, NS2_INIT_READ_FACTORY_PRIMARY_CALIB);
>> +		ok =3D switch2_parse_stick_calibration(&ns2->stick_calib[0], data);=

>> +		if (ok) {
>> +			hid_dbg(ns2->hdev, "Got factory primary stick calibration:\n");
>> +			hid_dbg(ns2->hdev, "Left max: %i, neutral: %i, right max: %i\n",
>> +				ns2->stick_calib[0].x.negative,
>> +				ns2->stick_calib[0].x.neutral,
>> +				ns2->stick_calib[0].x.positive);
>> +			hid_dbg(ns2->hdev, "Down max: %i, neutral: %i, up max: %i\n",
>> +				ns2->stick_calib[0].y.negative,
>> +				ns2->stick_calib[0].y.neutral,
>> +				ns2->stick_calib[0].y.positive);
>> +		} else {
>> +			hid_dbg(ns2->hdev, "Factory primary stick calibration not present\=
n");
>> +		}
>> +		break;
>> +	case NS2_FLASH_ADDR_FACTORY_SECONDARY_CALIB:
>> +		if (size !=3D NS2_FLASH_SIZE_FACTORY_AXIS_CALIB)
>> +			return;
>> +		switch2_init_step_done(ns2, NS2_INIT_READ_FACTORY_SECONDARY_CALIB);=

>> +		ok =3D switch2_parse_stick_calibration(&ns2->stick_calib[1], data);=

>> +		if (ok) {
>> +			hid_dbg(ns2->hdev, "Got factory secondary stick calibration:\n");
>> +			hid_dbg(ns2->hdev, "Left max: %i, neutral: %i, right max: %i\n",
>> +				ns2->stick_calib[1].x.negative,
>> +				ns2->stick_calib[1].x.neutral,
>> +				ns2->stick_calib[1].x.positive);
>> +			hid_dbg(ns2->hdev, "Down max: %i, neutral: %i, up max: %i\n",
>> +				ns2->stick_calib[1].y.negative,
>> +				ns2->stick_calib[1].y.neutral,
>> +				ns2->stick_calib[1].y.positive);
>> +		} else {
>> +			hid_dbg(ns2->hdev, "Factory secondary stick calibration not presen=
t\n");
>> +		}
>> +		break;
>> +	case NS2_FLASH_ADDR_FACTORY_TRIGGER_CALIB:
>> +		if (size !=3D NS2_FLASH_SIZE_FACTORY_TRIGGER_CALIB)
>> +			return;
>> +		switch2_init_step_done(ns2, NS2_INIT_READ_FACTORY_TRIGGER_CALIB);
>> +		if (data[0] !=3D 0xFF && data[1] !=3D 0xFF) {
>> +			ns2->lt_zero =3D data[0];
>> +			ns2->rt_zero =3D data[1];
>> +
>> +			hid_dbg(ns2->hdev, "Got factory trigger calibration:\n");
>> +			hid_dbg(ns2->hdev, "Left zero point: %i\n", ns2->lt_zero);
>> +			hid_dbg(ns2->hdev, "Right zero point: %i\n", ns2->rt_zero);
>> +		} else {
>> +			hid_dbg(ns2->hdev, "Factory trigger calibration not present\n");
>> +		}
>> +		break;
>> +	case NS2_FLASH_ADDR_USER_PRIMARY_CALIB:
>> +		if (size !=3D NS2_FLASH_SIZE_USER_AXIS_CALIB)
>> +			return;
>> +		switch2_init_step_done(ns2, NS2_INIT_READ_USER_PRIMARY_CALIB);
>> +		if (__le16_to_cpu(*(__le16 *)data) !=3D NS2_USER_CALIB_MAGIC) {
>> +			hid_dbg(ns2->hdev, "No user primary stick calibration present\n");=

>> +			break;
>> +		}
>> +
>> +		ok =3D switch2_parse_stick_calibration(&ns2->stick_calib[0], &data[=
2]);
>> +		if (ok) {
>> +			hid_dbg(ns2->hdev, "Got user primary stick calibration:\n");
>> +			hid_dbg(ns2->hdev, "Left max: %i, neutral: %i, right max: %i\n",
>> +				ns2->stick_calib[0].x.negative,
>> +				ns2->stick_calib[0].x.neutral,
>> +				ns2->stick_calib[0].x.positive);
>> +			hid_dbg(ns2->hdev, "Down max: %i, neutral: %i, up max: %i\n",
>> +				ns2->stick_calib[0].y.negative,
>> +				ns2->stick_calib[0].y.neutral,
>> +				ns2->stick_calib[0].y.positive);
>> +		} else {
>> +			hid_dbg(ns2->hdev, "No user primary stick calibration present\n");=

>> +		}
>> +		break;
>> +	case NS2_FLASH_ADDR_USER_SECONDARY_CALIB:
>> +		if (size !=3D NS2_FLASH_SIZE_USER_AXIS_CALIB)
>> +			return;
>> +		switch2_init_step_done(ns2, NS2_INIT_READ_USER_SECONDARY_CALIB);
>> +		if (__le16_to_cpu(*(__le16 *)data) !=3D NS2_USER_CALIB_MAGIC) {
>> +			hid_dbg(ns2->hdev, "No user secondary stick calibration present\n"=
);
>> +			break;
>> +		}
>> +
>> +		ok =3D switch2_parse_stick_calibration(&ns2->stick_calib[1], &data[=
2]);
>> +		if (ok) {
>> +			hid_dbg(ns2->hdev, "Got user secondary stick calibration:\n");
>> +			hid_dbg(ns2->hdev, "Left max: %i, neutral: %i, right max: %i\n",
>> +				ns2->stick_calib[1].x.negative,
>> +				ns2->stick_calib[1].x.neutral,
>> +				ns2->stick_calib[1].x.positive);
>> +			hid_dbg(ns2->hdev, "Down max: %i, neutral: %i, up max: %i\n",
>> +				ns2->stick_calib[1].y.negative,
>> +				ns2->stick_calib[1].y.neutral,
>> +				ns2->stick_calib[1].y.positive);
>> +		} else {
>> +			hid_dbg(ns2->hdev, "No user secondary stick calibration present\n"=
);
>> +		}
>> +		break;
>> +	}
>> +}
>> +
>> +static void switch2_report_buttons(struct input_dev *input, const uin=
t8_t *bytes,
>> +	const struct switch2_ctlr_button_mapping button_mappings[])
>> +{
>> +	const struct switch2_ctlr_button_mapping *button;
>> +
>> +	for (button =3D button_mappings; button->code; button++)
>> +		input_report_key(input, button->code, bytes[button->byte] & button-=
>bit);
>> +}
>> +
>> +static void switch2_report_axis(struct input_dev *input, struct switc=
h2_axis_calibration *calib,
>> +	int axis, bool invert, int value)
>> +{
>> +	if (calib && calib->neutral && calib->negative && calib->positive) {=

>> +		value -=3D calib->neutral;
>> +		value *=3D NS2_AXIS_MAX + 1;
>> +		if (value < 0)
>> +			value /=3D calib->negative;
>> +		else
>> +			value /=3D calib->positive;
>> +	} else {
>> +		value =3D (value - 2048) * 16;
>> +	}
>> +
>> +	if (invert)
>> +		value =3D -value;
>> +	input_report_abs(input, axis,
>> +		clamp(value, NS2_AXIS_MIN, NS2_AXIS_MAX));
>> +}
>> +
>> +static void switch2_report_stick(struct input_dev *input, struct swit=
ch2_stick_calibration *calib,
>> +	int x, bool invert_x, int y, bool invert_y, const uint8_t *data)
>> +{
>> +	switch2_report_axis(input, &calib->x, x, invert_x, data[0] | ((data[=
1] & 0x0F) << 8));
>> +	switch2_report_axis(input, &calib->y, y, invert_y, (data[1] >> 4) | =
(data[2] << 4));
>> +}
>> +
>> +static void switch2_report_trigger(struct input_dev *input, uint8_t z=
ero, int abs, uint8_t data)
>> +{
>> +	int value =3D (NS2_TRIGGER_RANGE + 1) * (data - zero) / (232 - zero)=
;
>> +
>> +	input_report_abs(input, abs, clamp(value, 0, NS2_TRIGGER_RANGE));
>> +}
>> +
>> +static int switch2_event(struct hid_device *hdev, struct hid_report *=
report, uint8_t *raw_data,
>> +	int size)
>> +{
>> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
>> +	struct input_dev *input;
>> +
>> +	if (report->type !=3D HID_INPUT_REPORT)
>> +		return 0;
>> +
>> +	if (size < 15)
>> +		return -EINVAL;
>> +
>> +	guard(rcu)();
>> +	input =3D rcu_dereference(ns2->input);
>> +
>> +	if (!input)
>> +		return 0;
>> +
>> +	switch (report->id) {
>> +	case NS2_REPORT_UNIFIED:
>> +		/*
>> +		 * TODO
>> +		 * This won't be sent unless the report type gets changed via comma=
nd
>> +		 * 03-0A, but we should support it at some point regardless.
>> +		 */
>> +		break;
>> +	case NS2_REPORT_JCL:
>> +		switch2_report_stick(input, &ns2->stick_calib[0], ABS_X, false,
>> +			ABS_Y, true, &raw_data[6]);
>> +		switch2_report_buttons(input, &raw_data[3], ns2_left_joycon_button_=
mappings);
>> +		break;
>> +	case NS2_REPORT_JCR:
>> +		switch2_report_stick(input, &ns2->stick_calib[0], ABS_X, false,
>> +			ABS_Y, true, &raw_data[6]);
>> +		switch2_report_buttons(input, &raw_data[3], ns2_right_joycon_button=
_mappings);
>> +		break;
>> +	case NS2_REPORT_GC:
>> +		input_report_abs(input, ABS_HAT0X,
>> +			!!(raw_data[4] & NS2_BTNL_RIGHT) -
>> +			!!(raw_data[4] & NS2_BTNL_LEFT));
>> +		input_report_abs(input, ABS_HAT0Y,
>> +			!!(raw_data[4] & NS2_BTNL_DOWN) -
>> +			!!(raw_data[4] & NS2_BTNL_UP));
>> +		switch2_report_buttons(input, &raw_data[3], ns2_gccon_mappings);
>> +		switch2_report_stick(input, &ns2->stick_calib[0], ABS_X, false,
>> +			ABS_Y, true, &raw_data[6]);
>> +		switch2_report_stick(input, &ns2->stick_calib[1], ABS_RX, false,
>> +			ABS_RY, true, &raw_data[9]);
>> +		switch2_report_trigger(input, ns2->lt_zero, ABS_Z, raw_data[13]);
>> +		switch2_report_trigger(input, ns2->rt_zero, ABS_RZ, raw_data[14]);
>> +		break;
>> +	case NS2_REPORT_PRO:
>> +		input_report_abs(input, ABS_HAT0X,
>> +			!!(raw_data[4] & NS2_BTNL_RIGHT) -
>> +			!!(raw_data[4] & NS2_BTNL_LEFT));
>> +		input_report_abs(input, ABS_HAT0Y,
>> +			!!(raw_data[4] & NS2_BTNL_DOWN) -
>> +			!!(raw_data[4] & NS2_BTNL_UP));
>> +		switch2_report_buttons(input, &raw_data[3], ns2_procon_mappings);
>> +		switch2_report_stick(input, &ns2->stick_calib[0], ABS_X, false,
>> +			ABS_Y, true, &raw_data[6]);
>> +		switch2_report_stick(input, &ns2->stick_calib[1], ABS_RX, false,
>> +			ABS_RY, true, &raw_data[9]);
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	input_sync(input);
>> +	return 0;
>> +}
>> +
>> +static int switch2_features_enable(struct switch2_controller *ns2, in=
t features)
>> +{
>> +	__le32 feature_bits =3D __cpu_to_le32(features);
>> +
>> +	if (!ns2->cfg)
>> +		return -ENOTCONN;
>> +	return ns2->cfg->send_command(NS2_CMD_FEATSEL, NS2_SUBCMD_FEATSEL_EN=
ABLE,
>> +		&feature_bits, sizeof(feature_bits),
>> +		ns2->cfg);
>> +}
>> +
>> +static int switch2_read_flash(struct switch2_controller *ns2, uint32_=
t address,
>> +	uint8_t size)
>> +{
>> +	uint8_t message[8] =3D { size, 0x7e };
>> +
>> +	if (!ns2->cfg)
>> +		return -ENOTCONN;
>> +	*(__le32 *)&message[4] =3D __cpu_to_le32(address);
>> +	return ns2->cfg->send_command(NS2_CMD_FLASH, NS2_SUBCMD_FLASH_READ, =
message,
>> +		sizeof(message), ns2->cfg);
>> +}
>> +
>> +static int switch2_set_player_id(struct switch2_controller *ns2, uint=
32_t player_id)
>> +{
>> +	int i;
>> +	int player_led_pattern =3D player_id % JC_NUM_LED_PATTERNS;
>> +
>> +	for (i =3D 0; i < JC_NUM_LEDS; i++)
>> +		ns2->leds[i].brightness =3D joycon_player_led_patterns[player_led_p=
attern][i];
>> +
>> +	return switch2_set_leds(ns2);
>> +}
>> +
>> +static int switch2_set_report_format(struct switch2_controller *ns2, =
enum switch2_report_id fmt)
>> +{
>> +	__le32 format_id =3D __cpu_to_le32(fmt);
>> +
>> +	if (!ns2->cfg)
>> +		return -ENOTCONN;
>> +	return ns2->cfg->send_command(NS2_CMD_INIT, NS2_SUBCMD_INIT_SELECT_R=
EPORT,
>> +		&format_id, sizeof(format_id),
>> +		ns2->cfg);
>> +}
>> +
>> +static int switch2_init_controller(struct switch2_controller *ns2)
>=20
> This is now a recursive call while in v1 it wasn't. I think I preferred=

> the non-recursive version as there was one place where init_step
> state was changed while now I am not sure where it happens (and whether=

> there is a code path where we end up in an infinite recursion)
>=20
> What is the advantage of the recursive version compared to the
> non-recursive one?
>=20

The old version incremented the step regardless of whether or not it coul=
d confirm it had happened. Since the confirmation is now handled with an =
external step, calling into switch2_init_step_done, the loop condition wo=
uld become somewhat complicated. I replaced it with explicit tail calls s=
ince that make the control flow simplier, and it is always matched with a=
 call to switch2_init_step_done to ensure that the state is always advanc=
ed. As such, the number recursive calls is explicitly limited, and the fa=
ct that they're tail calls should mean that it doesn't increase the stack=
 depth (unless there's something I don't know about how the kernel is com=
piled, which is possible in the wake of things like retpoline protections=
). I suppose I could replace it with a loop, but the condition would be t=
he same so the only real difference would be a `while (ns2->init_step < N=
S2_INIT_DONE)` instead of the tail calls; the tail calls themselves would=
 just become break statements. There would be no functional difference.

>> +{
>> +	if (ns2->init_step =3D=3D NS2_INIT_DONE)
>> +		return 0;
>> +
>> +	if (!ns2->cfg)
>> +		return -ENOTCONN;
>> +
>> +	switch (ns2->init_step) {
>> +	case NS2_INIT_READ_SERIAL:
>> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_SERIAL,
>> +			NS2_FLASH_SIZE_SERIAL);
>> +	case NS2_INIT_GET_FIRMWARE_INFO:
>> +		return ns2->cfg->send_command(NS2_CMD_FW_INFO, NS2_SUBCMD_FW_INFO_G=
ET,
>> +			NULL, 0, ns2->cfg);
>> +	case NS2_INIT_READ_FACTORY_PRIMARY_CALIB:
>> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_FACTORY_PRIMARY_CALIB=
,
>> +			NS2_FLASH_SIZE_FACTORY_AXIS_CALIB);
>> +	case NS2_INIT_READ_FACTORY_SECONDARY_CALIB:
>> +		if (switch2_ctlr_is_joycon(ns2->ctlr_type)) {
>> +			switch2_init_step_done(ns2, NS2_INIT_READ_FACTORY_SECONDARY_CALIB)=
;
>> +			return switch2_init_controller(ns2);
>> +		}
>> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_FACTORY_SECONDARY_CAL=
IB,
>> +			NS2_FLASH_SIZE_FACTORY_AXIS_CALIB);
>> +	case NS2_INIT_READ_FACTORY_TRIGGER_CALIB:
>> +		if (ns2->ctlr_type !=3D NS2_CTLR_TYPE_GC) {
>> +			switch2_init_step_done(ns2, NS2_INIT_READ_FACTORY_TRIGGER_CALIB);
>> +			return switch2_init_controller(ns2);
>> +		}
>> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_FACTORY_TRIGGER_CALIB=
,
>> +			NS2_FLASH_SIZE_FACTORY_TRIGGER_CALIB);
>> +	case NS2_INIT_READ_USER_PRIMARY_CALIB:
>> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_USER_PRIMARY_CALIB,
>> +			NS2_FLASH_SIZE_USER_AXIS_CALIB);
>> +	case NS2_INIT_READ_USER_SECONDARY_CALIB:
>> +		if (switch2_ctlr_is_joycon(ns2->ctlr_type)) {
>> +			switch2_init_step_done(ns2, NS2_INIT_READ_USER_SECONDARY_CALIB);
>> +			return switch2_init_controller(ns2);
>> +		}
>> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_USER_SECONDARY_CALIB,=

>> +			NS2_FLASH_SIZE_USER_AXIS_CALIB);
>> +	case NS2_INIT_SET_FEATURE_MASK:
>> +		return ns2->cfg->send_command(NS2_CMD_FEATSEL, NS2_SUBCMD_FEATSEL_S=
ET_MASK,
>> +			switch2_feature_mask, sizeof(switch2_feature_mask), ns2->cfg);
>> +	case NS2_INIT_ENABLE_FEATURES:
>> +		return switch2_features_enable(ns2, NS2_FEATURE_BUTTONS | NS2_FEATU=
RE_ANALOG);
>> +	case NS2_INIT_GRIP_BUTTONS:
>> +		if (!switch2_ctlr_is_joycon(ns2->ctlr_type)) {
>> +			switch2_init_step_done(ns2, NS2_INIT_GRIP_BUTTONS);
>> +			return switch2_init_controller(ns2);
>> +		}
>> +		return ns2->cfg->send_command(NS2_CMD_GRIP, NS2_SUBCMD_GRIP_ENABLE_=
BUTTONS,
>> +			switch2_one_data, sizeof(switch2_one_data),
>> +			ns2->cfg);
>> +	case NS2_INIT_REPORT_FORMAT:
>> +		switch (ns2->ctlr_type) {
>> +		case NS2_CTLR_TYPE_JCL:
>> +			return switch2_set_report_format(ns2, NS2_REPORT_JCL);
>> +		case NS2_CTLR_TYPE_JCR:
>> +			return switch2_set_report_format(ns2, NS2_REPORT_JCR);
>> +		case NS2_CTLR_TYPE_PRO:
>> +			return switch2_set_report_format(ns2, NS2_REPORT_PRO);
>> +		case NS2_CTLR_TYPE_GC:
>> +			return switch2_set_report_format(ns2, NS2_REPORT_GC);
>> +		default:
>> +			switch2_init_step_done(ns2, NS2_INIT_REPORT_FORMAT);
>> +			return switch2_init_controller(ns2);
>> +		}
>> +	case NS2_INIT_SET_PLAYER_LEDS:
>> +		return switch2_set_player_id(ns2, ns2->player_id);
>> +	case NS2_INIT_INPUT:
>> +		return ns2->cfg->send_command(NS2_CMD_INIT, NS2_SUBCMD_INIT_USB,
>> +			switch2_init_cmd_data, sizeof(switch2_init_cmd_data), ns2->cfg);
>> +	case NS2_INIT_FINISH:
>> +		if (ns2->hdev)
>=20
> If this is not set we skip the switch2_init_input call but don't error
> out. Is this intentional (are we expecting ns2->hdev to be populated at=

> a later time and this step retried, perhaps)?

This is intentional, yes. There are a handful of places this can get call=
ed, including the function that sets ns2->hdev in the first place (switch=
2_probe). It's to ensure the steps start as soon as possible (when the cf=
g pointer gets set) but it can't finish until the hdev gets set, which ca=
n be either before or after, depending on the ordering the interfaces get=
 enumerated.

>=20
>> +			return switch2_init_input(ns2);
>> +		break;
>> +	default:
>> +		WARN_ON_ONCE(1);
>> +		break;
>> +	}
>> +	return 0;
>> +}
>> +
>> +int switch2_receive_command(struct switch2_controller *ns2,
>> +	const uint8_t *message, size_t length)
>> +{
>> +	const struct switch2_cmd_header *header;
>> +	int ret =3D 0;
>> +
>> +	if (length < 8)
>> +		return -EINVAL;
>> +
>> +	print_hex_dump_debug("got cmd: ", DUMP_PREFIX_OFFSET, 16, 1, message=
, length, false);
>> +
>> +	guard(mutex)(&ns2->lock);
>> +
>> +	header =3D (const struct switch2_cmd_header *)message;
>> +	if (!(header->flags & NS2_FLAG_OK)) {
>> +		ret =3D -EIO;
>> +		goto exit;
>> +	}
>> +	message =3D &message[8];
>> +	switch (header->command) {
>> +	case NS2_CMD_FLASH:
>> +		if (header->subcommand =3D=3D NS2_SUBCMD_FLASH_READ) {
>> +			uint8_t read_size;
>> +			uint32_t read_address;
>> +
>> +			if (length < 16) {
>> +				ret =3D -EINVAL;
>> +				goto exit;
>> +			}
>> +			read_size =3D message[0];
>> +			read_address =3D __le32_to_cpu(*(__le32 *)&message[4]);
>> +			if (length < read_size + 16) {
>> +				ret =3D -EINVAL;
>> +				goto exit;
>> +			}
>> +			switch2_handle_flash_read(ns2, read_size, read_address, &message[8=
]);
>> +		}
>> +		break;
>> +	case NS2_CMD_INIT:
>> +		if (header->subcommand =3D=3D NS2_SUBCMD_INIT_USB)
>> +			switch2_init_step_done(ns2, NS2_INIT_INPUT);
>> +		else if (header->subcommand =3D=3D NS2_SUBCMD_INIT_SELECT_REPORT)
>> +			switch2_init_step_done(ns2, NS2_INIT_REPORT_FORMAT);
>> +		break;
>> +	case NS2_CMD_GRIP:
>> +		if (header->subcommand =3D=3D NS2_SUBCMD_GRIP_ENABLE_BUTTONS)
>> +			switch2_init_step_done(ns2, NS2_INIT_GRIP_BUTTONS);
>> +		break;
>> +	case NS2_CMD_LED:
>> +		if (header->subcommand =3D=3D NS2_SUBCMD_LED_PATTERN)
>> +			switch2_init_step_done(ns2, NS2_INIT_SET_PLAYER_LEDS);
>> +		break;
>> +	case NS2_CMD_FEATSEL:
>> +		if (header->subcommand =3D=3D NS2_SUBCMD_FEATSEL_SET_MASK)
>> +			switch2_init_step_done(ns2, NS2_INIT_SET_FEATURE_MASK);
>> +		else if (header->subcommand =3D=3D NS2_SUBCMD_FEATSEL_ENABLE)
>> +			switch2_init_step_done(ns2, NS2_INIT_ENABLE_FEATURES);
>> +		break;
>> +	case NS2_CMD_FW_INFO:
>> +		if (header->subcommand =3D=3D NS2_SUBCMD_FW_INFO_GET) {
>> +			if (length < sizeof(ns2->version)) {
>> +				ret =3D -EINVAL;
>> +				goto exit;
>> +			}
>> +			memcpy(&ns2->version, message, sizeof(ns2->version));
>> +			ns2->ctlr_type =3D ns2->version.ctlr_type;
>> +			switch2_init_step_done(ns2, NS2_INIT_GET_FIRMWARE_INFO);
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +exit:
>> +	if (ns2->init_step < NS2_INIT_DONE)
>> +		switch2_init_controller(ns2);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(switch2_receive_command);
>> +
>> +int switch2_controller_attach_cfg(const char *phys, struct switch2_cf=
g_intf *cfg)
>> +{
>> +	struct switch2_controller *ns2 =3D switch2_get_controller(phys);
>> +
>> +	if (IS_ERR(ns2))
>> +		return PTR_ERR(ns2);
>> +
>> +	cfg->parent =3D ns2;
>> +
>> +	guard(mutex)(&ns2->lock);
>> +	WARN_ON(ns2->cfg);
>> +	ns2->cfg =3D cfg;
>> +
>> +	if (ns2->hdev)
>> +		return switch2_init_controller(ns2);
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(switch2_controller_attach_cfg);
>> +
>> +void switch2_controller_detach_cfg(struct switch2_controller *ns2)
>> +{
>> +	mutex_lock(&ns2->lock);
>> +	WARN_ON(ns2 !=3D ns2->cfg->parent);
>> +	ns2->cfg =3D NULL;
>> +	mutex_unlock(&ns2->lock);
>> +	switch2_controller_put(ns2);
>> +}
>> +EXPORT_SYMBOL_GPL(switch2_controller_detach_cfg);
>> +
>> +static int switch2_probe(struct hid_device *hdev, const struct hid_de=
vice_id *id)
>> +{
>> +	struct switch2_controller *ns2;
>> +	struct usb_device *udev;
>> +	char phys[64];
>> +	int ret;
>> +
>> +	if (!hid_is_usb(hdev))
>> +		return -ENODEV;
>> +
>> +	udev =3D hid_to_usb_dev(hdev);
>> +	if (usb_make_path(udev, phys, sizeof(phys)) < 0)
>> +		return -EINVAL;
>> +
>> +	ret =3D hid_parse(hdev);
>> +	if (ret) {
>> +		hid_err(hdev, "parse failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
>> +	if (ret) {
>> +		hid_err(hdev, "hw_start failed %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret =3D hid_hw_open(hdev);
>> +	if (ret) {
>> +		hid_err(hdev, "hw_open failed %d\n", ret);
>> +		goto err_stop;
>> +	}
>=20
> For the Switch 1 controllers we are calling hid_device_io_start after
> hid_hw_open. Is this not necessary in this case?

Since we don't do any HID I/O during probe it's not needed; the startup c=
onfiguration is on the cfg interface instead.

>=20
>> +
>> +	ns2 =3D switch2_get_controller(phys);
>> +	if (!ns2) {
>=20
> switch2_get_controller returns an err pointer in case of ENOMEM, not
> NULL so I think this check has to be changed.

Fixed locally, thanks. I'll send that out with v4 (this was actually v3 b=
ut I thought it was v2, oops).

>=20
>> +		ret =3D -ENOMEM;
>> +		goto err_close;
>> +	}
>> +
>> +	guard(mutex)(&ns2->lock);
>> +	WARN_ON(ns2->hdev);
>> +	ns2->hdev =3D hdev;
>> +	switch (hdev->product | (hdev->vendor << 16)) {
>> +	default:
>> +		strscpy(ns2->name, hdev->name, sizeof(ns2->name));
>> +		break;
>> +	/* Some controllers have slightly wrong names so we override them */=

>> +	case USB_DEVICE_ID_NINTENDO_NS2_JOYCONR | (USB_VENDOR_ID_NINTENDO <<=
 16):
>> +		/* Missing the "2" in the name */
>> +		strscpy(ns2->name, "Nintendo Joy-Con 2 (R)", sizeof(ns2->name));
>> +		break;
>> +	case USB_DEVICE_ID_NINTENDO_NS2_GCCON | (USB_VENDOR_ID_NINTENDO << 1=
6):
>> +		/* Has "Nintendo" in the name twice */
>> +		strscpy(ns2->name, "Nintendo GameCube Controller", sizeof(ns2->name=
));
>> +		break;
>> +	}
>> +
>> +	ns2->player_id =3D U32_MAX;
>> +	ret =3D ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
>> +	if (ret < 0)
>> +		hid_warn(hdev, "Failed to allocate player ID, skipping; ret=3D%d\n"=
, ret);
>> +	else
>> +		ns2->player_id =3D ret;
>> +
>> +	switch2_leds_create(ns2);
>> +
>> +	hid_set_drvdata(hdev, ns2);
>> +
>> +	if (ns2->cfg)
>> +		return switch2_init_controller(ns2);
>> +
>> +	return 0;
>> +
>> +err_close:
>> +	hid_hw_close(hdev);
>> +err_stop:
>> +	hid_hw_stop(hdev);
>> +
>> +	return ret;
>> +}
>> +
>> +static void switch2_remove(struct hid_device *hdev)
>> +{
>> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
>> +
>> +	hid_hw_close(hdev);
>> +	mutex_lock(&ns2->lock);
>> +	WARN_ON(ns2->hdev !=3D hdev);
>> +	ns2->hdev =3D NULL;
>> +	mutex_unlock(&ns2->lock);
>> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);
>> +	switch2_controller_put(ns2);
>> +	hid_hw_stop(hdev);
>> +}
>> +
>>  static const struct hid_device_id nintendo_hid_devices[] =3D {
>> +	/* Switch devices */
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
>>  			 USB_DEVICE_ID_NINTENDO_PROCON) },
>>  	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
>> @@ -2813,10 +3935,69 @@ static const struct hid_device_id nintendo_hid=
_devices[] =3D {
>>  			 USB_DEVICE_ID_NINTENDO_GENCON) },
>>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_NINTENDO,
>>  			 USB_DEVICE_ID_NINTENDO_N64CON) },
>> +	/* Switch 2 devices */
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
>> +			 USB_DEVICE_ID_NINTENDO_NS2_JOYCONL) },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
>> +			 USB_DEVICE_ID_NINTENDO_NS2_JOYCONR) },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
>> +			 USB_DEVICE_ID_NINTENDO_NS2_PROCON) },
>> +	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
>> +			 USB_DEVICE_ID_NINTENDO_NS2_GCCON) },
>>  	{ }
>>  };
>>  MODULE_DEVICE_TABLE(hid, nintendo_hid_devices);
>> =20
>> +static bool nintendo_is_switch2(struct hid_device *hdev)
>> +{
>> +	return hdev->vendor =3D=3D USB_VENDOR_ID_NINTENDO &&
>> +		hdev->product >=3D USB_DEVICE_ID_NINTENDO_NS2_JOYCONR;
>> +}
>> +
>> +static void nintendo_hid_remove(struct hid_device *hdev)
>> +{
>> +	if (nintendo_is_switch2(hdev))
>> +		switch2_remove(hdev);
>> +	else
>> +		joycon_remove(hdev);
>> +}
>> +
>> +static int nintendo_hid_event(struct hid_device *hdev,
>> +			      struct hid_report *report, u8 *raw_data, int size)
>> +{
>> +	if (nintendo_is_switch2(hdev))
>> +		return switch2_event(hdev, report, raw_data, size);
>> +	else
>> +		return joycon_event(hdev, report, raw_data, size);
>> +}
>> +
>> +static int nintendo_hid_probe(struct hid_device *hdev,
>> +			    const struct hid_device_id *id)
>> +{
>> +	if (nintendo_is_switch2(hdev))
>> +		return switch2_probe(hdev, id);
>> +	else
>> +		return joycon_probe(hdev, id);
>> +}
>> +
>> +#ifdef CONFIG_PM
>> +static int nintendo_hid_resume(struct hid_device *hdev)
>> +{
>> +	if (nintendo_is_switch2(hdev))
>> +		return 0;
>> +	else
>> +		return joycon_resume(hdev);
>> +}
>> +
>> +static int nintendo_hid_suspend(struct hid_device *hdev, pm_message_t=
 message)
>> +{
>> +	if (nintendo_is_switch2(hdev))
>> +		return 0;
>> +	else
>> +		return joycon_suspend(hdev, message);
>> +}
>> +#endif
>> +
>>  static struct hid_driver nintendo_hid_driver =3D {
>>  	.name		=3D "nintendo",
>>  	.id_table	=3D nintendo_hid_devices,
>> @@ -2844,4 +4025,5 @@ MODULE_LICENSE("GPL");
>>  MODULE_AUTHOR("Ryan McClelland <rymcclel@gmail.com>");
>>  MODULE_AUTHOR("Emily Strickland <linux@emily.st>");
>>  MODULE_AUTHOR("Daniel J. Ogorchock <djogorchock@gmail.com>");
>> +MODULE_AUTHOR("Vicki Pfau <vi@endrift.com>");
>>  MODULE_DESCRIPTION("Driver for Nintendo Switch Controllers");
>> diff --git a/drivers/hid/hid-nintendo.h b/drivers/hid/hid-nintendo.h
>> new file mode 100644
>> index 0000000000000..7aff22f302661
>> --- /dev/null
>> +++ b/drivers/hid/hid-nintendo.h
>> @@ -0,0 +1,72 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * HID driver for Nintendo Switch 2 controllers
>> + *
>> + * Copyright (c) 2025 Valve Software
>> + *
>> + * This driver is based on the following work:
>> + *   https://gist.github.com/shinyquagsire23/66f006b46c56216acbaac6c1=
e2279b64
>> + *   https://github.com/ndeadly/switch2_controller_research
>> + */
>> +
>> +#ifndef __HID_NINTENDO_H
>> +#define __HID_NINTENDO_H
>> +
>> +#include <linux/bits.h>
>> +
>> +#define NS2_FLAG_OK	BIT(0)
>> +#define NS2_FLAG_NACK	BIT(2)
>> +
>> +enum switch2_cmd {
>> +	NS2_CMD_NFC =3D 0x01,
>> +	NS2_CMD_FLASH =3D 0x02,
>> +	NS2_CMD_INIT =3D 0x03,
>> +	NS2_CMD_GRIP =3D 0x08,
>> +	NS2_CMD_LED =3D 0x09,
>> +	NS2_CMD_VIBRATE =3D 0x0a,
>> +	NS2_CMD_BATTERY =3D 0x0b,
>> +	NS2_CMD_FEATSEL =3D 0x0c,
>> +	NS2_CMD_FW_UPD =3D 0x0d,
>> +	NS2_CMD_FW_INFO =3D 0x10,
>> +	NS2_CMD_BT_PAIR =3D 0x15,
>> +};
>> +
>> +enum switch2_direction {
>> +	NS2_DIR_IN =3D 0x00,
>> +	NS2_DIR_OUT =3D 0x90,
>> +};
>> +
>> +enum switch2_transport {
>> +	NS2_TRANS_USB =3D 0x00,
>> +	NS2_TRANS_BT =3D 0x01,
>> +};
>> +
>> +struct switch2_cmd_header {
>> +	uint8_t command;
>> +	uint8_t flags;
>> +	uint8_t transport;
>> +	uint8_t subcommand;
>> +	uint8_t unk1;
>> +	uint8_t length;
>> +	uint16_t unk2;
>> +};
>> +static_assert(sizeof(struct switch2_cmd_header) =3D=3D 8);
>> +
>> +struct device;
>> +struct switch2_controller;
>> +struct switch2_cfg_intf {
>> +	struct switch2_controller *parent;
>> +	struct device *dev;
>> +
>> +	int (*send_command)(enum switch2_cmd command, uint8_t subcommand,
>> +		const void *message, size_t length,
>> +		struct switch2_cfg_intf *intf);
>> +};
>> +
>> +int switch2_controller_attach_cfg(const char *phys, struct switch2_cf=
g_intf *cfg);
>> +void switch2_controller_detach_cfg(struct switch2_controller *control=
ler);
>> +
>> +int switch2_receive_command(struct switch2_controller *controller,
>> +	const uint8_t *message, size_t length);
>> +
>> +#endif
>> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/K=
config
>> index 7755e5b454d2c..868262c6ccd9a 100644
>> --- a/drivers/input/joystick/Kconfig
>> +++ b/drivers/input/joystick/Kconfig
>> @@ -422,4 +422,15 @@ config JOYSTICK_SEESAW
>>  	  To compile this driver as a module, choose M here: the module will=
 be
>>  	  called adafruit-seesaw.
>> =20
>> +config JOYSTICK_NINTENDO_SWITCH2_USB
>> +	tristate "Wired Nintendo Switch 2 controller support"
>> +	depends on HID_NINTENDO
>> +	depends on USB
>> +	help
>> +	  Say Y here if you want to enable support for wired Nintendo Switch=
 2
>> +	  controllers.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called nintendo-switch2-usb.
>> +
>>  endif
>> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/=
Makefile
>> index 9976f596a9208..8f92900ae8856 100644
>> --- a/drivers/input/joystick/Makefile
>> +++ b/drivers/input/joystick/Makefile
>> @@ -34,6 +34,7 @@ obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+=3D sidewinder.o
>>  obj-$(CONFIG_JOYSTICK_SPACEBALL)	+=3D spaceball.o
>>  obj-$(CONFIG_JOYSTICK_SPACEORB)		+=3D spaceorb.o
>>  obj-$(CONFIG_JOYSTICK_STINGER)		+=3D stinger.o
>> +obj-$(CONFIG_JOYSTICK_NINTENDO_SWITCH2_USB)	+=3D nintendo-switch2-usb=
=2Eo
>>  obj-$(CONFIG_JOYSTICK_TMDC)		+=3D tmdc.o
>>  obj-$(CONFIG_JOYSTICK_TURBOGRAFX)	+=3D turbografx.o
>>  obj-$(CONFIG_JOYSTICK_TWIDJOY)		+=3D twidjoy.o
>> diff --git a/drivers/input/joystick/nintendo-switch2-usb.c b/drivers/i=
nput/joystick/nintendo-switch2-usb.c
>> new file mode 100644
>> index 0000000000000..ebd89d852e21a
>> --- /dev/null
>> +++ b/drivers/input/joystick/nintendo-switch2-usb.c
>> @@ -0,0 +1,353 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * USB driver for Nintendo Switch 2 controllers configuration interfa=
ce
>> + *
>> + * Copyright (c) 2025 Valve Software
>> + *
>> + * This driver is based on the following work:
>> + *   https://gist.github.com/shinyquagsire23/66f006b46c56216acbaac6c1=
e2279b64
>> + *   https://github.com/ndeadly/switch2_controller_research
>> + */
>> +
>> +#include "../../hid/hid-ids.h"
>> +#include "../../hid/hid-nintendo.h"
>> +#include <linux/module.h>
>> +#include <linux/usb/input.h>
>> +
>> +#define NS2_BULK_SIZE 64
>> +#define NS2_IN_URBS 2
>> +#define NS2_OUT_URBS 4
>> +
>> +static struct usb_driver switch2_usb;
>> +
>> +struct switch2_urb {
>> +	struct urb *urb;
>> +	uint8_t *data;
>> +	bool active;
>> +};
>> +
>> +struct switch2_usb {
>> +	struct switch2_cfg_intf cfg;
>> +	struct usb_device *udev;
>> +
>> +	struct switch2_urb bulk_in[NS2_IN_URBS];
>> +	struct usb_anchor bulk_in_anchor;
>> +	spinlock_t bulk_in_lock;
>> +
>> +	struct switch2_urb bulk_out[NS2_OUT_URBS];
>> +	struct usb_anchor bulk_out_anchor;
>> +	spinlock_t bulk_out_lock;
>> +
>> +	int message_in;
>> +	struct work_struct message_in_work;
>> +};
>> +
>> +static void switch2_bulk_in(struct urb *urb)
>> +{
>> +	struct switch2_usb *ns2_usb =3D urb->context;
>> +	int i;
>> +	bool schedule =3D false;
>> +	unsigned long flags;
>> +
>> +	switch (urb->status) {
>> +	case 0:
>> +		schedule =3D true;
>> +		break;
>> +	case -ECONNRESET:
>> +	case -ENOENT:
>> +	case -ESHUTDOWN:
>> +		dev_dbg(&ns2_usb->udev->dev, "shutting down input urb: %d\n", urb->=
status);
>> +		return;
>> +	default:
>> +		dev_dbg(&ns2_usb->udev->dev, "unknown input urb status: %d\n", urb-=
>status);
>> +		break;
>> +	}
>> +
>> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
>> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
>> +		int err;
>> +		struct switch2_urb *ns2_urb;
>> +
>> +		if (ns2_usb->bulk_in[i].urb =3D=3D urb) {
>> +			ns2_usb->message_in =3D i;
>> +			continue;
>> +		}
>> +
>> +		if (ns2_usb->bulk_in[i].active)
>> +			continue;
>> +
>> +		ns2_urb =3D &ns2_usb->bulk_in[i];
>> +		usb_anchor_urb(ns2_urb->urb, &ns2_usb->bulk_in_anchor);
>> +		err =3D usb_submit_urb(ns2_urb->urb, GFP_ATOMIC);
>> +		if (err) {
>> +			usb_unanchor_urb(ns2_urb->urb);
>> +			dev_dbg(&ns2_usb->udev->dev, "failed to queue input urb: %d\n", er=
r);
>> +		} else {
>> +			ns2_urb->active =3D true;
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
>> +
>> +	if (schedule)
>> +		schedule_work(&ns2_usb->message_in_work);
>> +}
>> +
>> +static void switch2_bulk_out(struct urb *urb)
>> +{
>> +	struct switch2_usb *ns2_usb =3D urb->context;
>> +	int i;
>> +
>> +	guard(spinlock_irqsave)(&ns2_usb->bulk_out_lock);
>> +
>> +	switch (urb->status) {
>> +	case 0:
>> +		break;
>> +	case -ECONNRESET:
>> +	case -ENOENT:
>> +	case -ESHUTDOWN:
>> +		dev_dbg(&ns2_usb->udev->dev, "shutting down output urb: %d\n", urb-=
>status);
>> +		return;
>> +	default:
>> +		dev_dbg(&ns2_usb->udev->dev, "unknown output urb status: %d\n", urb=
->status);
>> +		return;
>> +	}
>> +
>> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
>> +		if (ns2_usb->bulk_out[i].urb !=3D urb)
>> +			continue;
>> +
>> +		ns2_usb->bulk_out[i].active =3D false;
>> +		break;
>> +	}
>> +}
>> +
>> +static int switch2_usb_send_cmd(enum switch2_cmd command, uint8_t sub=
command,
>> +	const void *message, size_t size, struct switch2_cfg_intf *cfg)
>> +{
>> +	struct switch2_usb *ns2_usb =3D (struct switch2_usb *)cfg;
>> +	struct switch2_urb *urb =3D NULL;
>> +	int i;
>> +	int ret;
>> +	unsigned long flags;
>> +
>> +	struct switch2_cmd_header header =3D {
>> +		command, NS2_DIR_OUT | NS2_FLAG_OK, NS2_TRANS_USB, subcommand, 0, s=
ize
>> +	};
>> +
>> +	if (WARN_ON(size > 56))
>> +		return -EINVAL;
>> +
>> +	spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
>> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
>> +		if (ns2_usb->bulk_out[i].active)
>> +			continue;
>> +
>> +		urb =3D &ns2_usb->bulk_out[i];
>> +		urb->active =3D true;
>> +		break;
>> +	}
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
>> +
>> +	if (!urb) {
>> +		dev_warn(&ns2_usb->udev->dev, "output queue full, dropping message\=
n");
>> +		return -ENOBUFS;
>> +	}
>> +
>> +	memcpy(urb->data, &header, sizeof(header));
>> +	if (message && size)
>> +		memcpy(&urb->data[8], message, size);
>> +	urb->urb->transfer_buffer_length =3D size + sizeof(header);
>> +
>> +	print_hex_dump_debug("sending cmd: ", DUMP_PREFIX_OFFSET, 16, 1, urb=
->data,
>> +		size + sizeof(header), false);
>> +
>> +	usb_anchor_urb(urb->urb, &ns2_usb->bulk_out_anchor);
>> +	ret =3D usb_submit_urb(urb->urb, GFP_ATOMIC);
>> +	if (ret) {
>> +		if (ret !=3D -ENODEV)
>> +			dev_warn(&ns2_usb->udev->dev, "failed to submit output urb: %i", r=
et);
>> +		urb->active =3D false;
>> +		usb_unanchor_urb(urb->urb);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void switch2_usb_message_in_work(struct work_struct *work)
>> +{
>> +	struct switch2_usb *ns2_usb =3D container_of(work, struct switch2_us=
b, message_in_work);
>> +	struct switch2_urb *urb;
>> +	int err;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
>> +	urb =3D &ns2_usb->bulk_in[ns2_usb->message_in];
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
>> +
>> +	err =3D switch2_receive_command(ns2_usb->cfg.parent, urb->urb->trans=
fer_buffer,
>> +		urb->urb->actual_length);
>> +	if (err)
>> +		dev_dbg(&ns2_usb->udev->dev, "receive command failed: %d\n", err);
>> +
>> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
>> +	urb->active =3D false;
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
>> +}
>> +
>> +static int switch2_usb_probe(struct usb_interface *intf, const struct=
 usb_device_id *id)
>> +{
>> +	struct switch2_usb *ns2_usb;
>> +	struct usb_device *udev;
>> +	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
>> +	char phys[64];
>> +	int ret;
>> +	int i;
>> +
>> +	udev =3D interface_to_usbdev(intf);
>> +	if (usb_make_path(udev, phys, sizeof(phys)) < 0)
>> +		return -EINVAL;
>> +
>> +	ret =3D usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &b=
ulk_out, NULL, NULL);
>> +	if (ret) {
>> +		dev_err(&intf->dev, "failed to find bulk EPs\n");
>> +		return ret;
>> +	}
>> +
>> +	ns2_usb =3D devm_kzalloc(&intf->dev, sizeof(*ns2_usb), GFP_KERNEL);
>> +	if (!ns2_usb)
>> +		return -ENOMEM;
>> +
>> +	ns2_usb->udev =3D udev;
>> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
>> +		ns2_usb->bulk_in[i].urb =3D usb_alloc_urb(0, GFP_KERNEL);
>> +		if (!ns2_usb->bulk_in[i].urb) {
>> +			ret =3D -ENOMEM;
>> +			goto err_free_in;
>> +		}
>> +
>> +		ns2_usb->bulk_in[i].data =3D usb_alloc_coherent(udev, NS2_BULK_SIZE=
, GFP_KERNEL,
>> +			&ns2_usb->bulk_in[i].urb->transfer_dma);
>> +		if (!ns2_usb->bulk_in[i].data) {
>> +			ret =3D -ENOMEM;
>> +			goto err_free_in;
>> +		}
>> +
>> +		usb_fill_bulk_urb(ns2_usb->bulk_in[i].urb, udev,
>> +			usb_rcvbulkpipe(udev, bulk_in->bEndpointAddress),
>> +			ns2_usb->bulk_in[i].data, NS2_BULK_SIZE, switch2_bulk_in, ns2_usb)=
;
>> +		ns2_usb->bulk_in[i].urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MA=
P;
>> +	}
>> +
>> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
>> +		ns2_usb->bulk_out[i].urb =3D usb_alloc_urb(0, GFP_KERNEL);
>> +		if (!ns2_usb->bulk_out[i].urb) {
>> +			ret =3D -ENOMEM;
>> +			goto err_free_out;
>> +		}
>> +
>> +		ns2_usb->bulk_out[i].data =3D usb_alloc_coherent(udev, NS2_BULK_SIZ=
E, GFP_KERNEL,
>> +			&ns2_usb->bulk_out[i].urb->transfer_dma);
>> +		if (!ns2_usb->bulk_out[i].data) {
>> +			ret =3D -ENOMEM;
>> +			goto err_free_out;
>> +		}
>> +
>> +		usb_fill_bulk_urb(ns2_usb->bulk_out[i].urb, udev,
>> +			usb_sndbulkpipe(udev, bulk_out->bEndpointAddress),
>> +			ns2_usb->bulk_out[i].data, NS2_BULK_SIZE, switch2_bulk_out, ns2_us=
b);
>> +		ns2_usb->bulk_out[i].urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_M=
AP;
>> +	}
>> +
>> +	ns2_usb->bulk_in[0].active =3D true;
>> +	ret =3D usb_submit_urb(ns2_usb->bulk_in[0].urb, GFP_ATOMIC);
>> +	if (ret < 0)
>> +		goto err_free_out;
>> +
>> +	init_usb_anchor(&ns2_usb->bulk_out_anchor);
>> +	spin_lock_init(&ns2_usb->bulk_out_lock);
>> +	init_usb_anchor(&ns2_usb->bulk_in_anchor);
>> +	spin_lock_init(&ns2_usb->bulk_in_lock);
>> +	INIT_WORK(&ns2_usb->message_in_work, switch2_usb_message_in_work);
>> +
>> +	usb_set_intfdata(intf, ns2_usb);
>> +
>> +	ns2_usb->cfg.dev =3D &ns2_usb->udev->dev;
>> +	ns2_usb->cfg.send_command =3D switch2_usb_send_cmd;
>> +
>> +	ret =3D switch2_controller_attach_cfg(phys, &ns2_usb->cfg);
>> +	if (ret < 0)
>> +		goto err_kill_urb;
>> +
>> +	return 0;
>> +
>> +err_kill_urb:
>> +	usb_kill_urb(ns2_usb->bulk_in[0].urb);
>> +err_free_out:
>> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
>> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_out[i=
].data,
>> +			ns2_usb->bulk_out[i].urb->transfer_dma);
>> +		usb_free_urb(ns2_usb->bulk_out[i].urb);
>> +	}
>> +err_free_in:
>> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
>> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_in[i]=
=2Edata,
>> +			ns2_usb->bulk_in[i].urb->transfer_dma);
>> +		usb_free_urb(ns2_usb->bulk_in[i].urb);
>> +	}
>> +	devm_kfree(&intf->dev, ns2_usb);
>> +
>> +	return ret;
>> +}
>> +
>> +static void switch2_usb_disconnect(struct usb_interface *intf)
>> +{
>> +	struct switch2_usb *ns2_usb =3D usb_get_intfdata(intf);
>> +	unsigned long flags;
>> +	int i;
>> +
>> +	spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
>> +	usb_kill_anchored_urbs(&ns2_usb->bulk_out_anchor);
>> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
>> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_out[i=
].data,
>> +			ns2_usb->bulk_out[i].urb->transfer_dma);
>> +		usb_free_urb(ns2_usb->bulk_out[i].urb);
>> +	}
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
>> +
>> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
>> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
>> +	cancel_work_sync(&ns2_usb->message_in_work);
>> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
>> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, ns2_usb->bulk_in[i]=
=2Edata,
>> +			ns2_usb->bulk_in[i].urb->transfer_dma);
>> +		usb_free_urb(ns2_usb->bulk_in[i].urb);
>> +	}
>> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
>> +
>> +	switch2_controller_detach_cfg(ns2_usb->cfg.parent);
>=20
> As we have allocated ns2_usb with devm_kzalloc, don't we need to free i=
t
> with devm_kfree again?

Devres will automatically free it when the device is freed. As this is th=
e callback for the device going away, it's freed directly after this func=
tion exits. That's why I'm using devm_kzalloc instead of kzalloc.

>=20
> Cheers,
> Silvan
>=20
>> +}
>> +
>> +#define SWITCH2_CONTROLLER(vend, prod) \
>> +	USB_DEVICE_AND_INTERFACE_INFO(vend, prod, USB_CLASS_VENDOR_SPEC, 0, =
0)
>> +
>> +static const struct usb_device_id switch2_usb_devices[] =3D {
>> +	{ SWITCH2_CONTROLLER(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_=
NS2_JOYCONL) },
>> +	{ SWITCH2_CONTROLLER(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_=
NS2_JOYCONR) },
>> +	{ SWITCH2_CONTROLLER(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_=
NS2_PROCON) },
>> +	{ SWITCH2_CONTROLLER(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_=
NS2_GCCON) },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(usb, switch2_usb_devices);
>> +
>> +static struct usb_driver switch2_usb =3D {
>> +	.name		=3D "switch2",
>> +	.id_table	=3D switch2_usb_devices,
>> +	.probe		=3D switch2_usb_probe,
>> +	.disconnect	=3D switch2_usb_disconnect,
>> +};
>> +module_usb_driver(switch2_usb);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Vicki Pfau <vi@endrift.com>");
>> +MODULE_DESCRIPTION("Driver for Nintendo Switch 2 Controllers");
>=20
>=20

Vicki
