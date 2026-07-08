Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77293D6CD5
	for <linux-input@vger.kernel.org>; Wed,  8 Jul 2026 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541334; cv=none; b=AZbeXEahgQyMTJsFTnFetjItf3uFfD7yeZ4gfzl8sNbc+cBfcACxXIZAnwuv7UzhBUcIyrHJN2SrFBqteWihQ1tCQ9CvnqCMl10eFQtnn9/4NdtjwSlDAutrMWDOQKo8AelmiYKfVO/z1wkIXbPLzmzBkxy+jbXHfJlY4FcqZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541334; c=relaxed/simple;
	bh=sJxyjr1xIkJlkg4Q9lYUU27xg+lWu0tCHukAh2G80xE=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=PMJOvANynhoyMSuhfW/bErE2C1K3714NR9O7lPih4GDqrRBzNEr3d+eLK7yh8dqyBw/Vc8wyguNkIXA6M+2c+P5oe3+ywROzwa0Jp3bftU89SrzKEBU40IDBuDMnLPmEB4es7QczFJvVJmrj2exn491jymv4Vl2JBNXqzPM0HXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nCFxFSWS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCFxFSWS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493c19bad03so10687505e9.2
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 13:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783541322; x=1784146122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Ut9HX7OR28vkBmlvG84hzAg1s4fn0iVXAp6xhUcUw/c=;
        b=nCFxFSWScmcs88S2OtfkPRtUPoPHF3mr9nZc2Z65dfItKfNrcg9RtaBaVNWl98Jsvm
         NIVhZ1dUHr7ekm9MXigXTeC5xMRJHC4ibWItDB+L00SpVn6eiEBqYUn3rpQLiJUqw1A/
         A6LCJ2WV5uxKSesV22giJhUkRf5epd/Ulu8q+k7VMSH9KtG7XnCjJvGXgRR18kAKhwkf
         b29DB+hnwvnjD9fe/uKVaYwNWvG98+yrFx1xN8Y7QGEPnNyFPV83HC4eyAO3sb3wV/l7
         sbC2vQ7hzfPdd8S9oDA8AodIxzcQyJ/3IPX6bbw11s6wrske4gNDKpKAPEMhYOGshHrO
         MZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783541322; x=1784146122;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:in-reply-to:references:from:subject:cc:to:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ut9HX7OR28vkBmlvG84hzAg1s4fn0iVXAp6xhUcUw/c=;
        b=cP5wjN6D7uRhyyT1L0LYAShkATDhhYRAW1J7jquXNln0x+S/ZTWcy5VtsiApnfa35s
         0xFM6GiBCwnEKinN3Zvheq0PY/OSsIJ5QQMLLD/j+ZxYjbra8YT8jfxVrVc3/qAtZHEO
         J37WFhqxCCgPJSKILacj8Fbv08YG/OvwhjBPLKIKzlNMFOx9xBb1/oZgGWtXNg8tcYxl
         xikZMVPwZp1BaZkuBj3aUThArfknpxvuzIIJRMHAbMFBiQkqVVOl7WiUpjO2YLx0LnqN
         /1G3NkMkmsgVrR74vc/bl4HZjzuGINTlNqxftfB05K2qD7Y4+AYBaNrlLyP5evaidVPg
         c2TA==
X-Forwarded-Encrypted: i=1; AHgh+RqorUqtuy6hcdUlxg2hD4KL9yz0D/sy84gCjzNMLkG0C3vsUpZX1VJ6Xl3qZVVXwvL+p4YTqeejLZueAg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6jkwT1MsUBHjEJDVYoyGyLPLAP/bqg9Yz1ryKtECtKmwPl5sC
	q25WYvzc7JPXHo95nIKM4xJeXPWpD/tv8H4XXUuRR/XRxfWNHMKi083w
X-Gm-Gg: AfdE7cnScY6OUPKhCekXuK0ZsvE6nANDJSdpfegtPhKQK6PYi7m5LUbPd1X7BRB7aFG
	mrO0UP0kyPAuh18Cpchl2gVdX0Sf5JfLaWAMT7ZQgx/PYT57KkxOI2lnixErBI3GJ7R7zQrMbfV
	mJl3Nh2rAC8IWT2i8IapgXkFkYbFFXOuB8ekjtrmLafwRetxjJ3XpYkgc4XamXz+Fz6TsgDPNcQ
	BBj7f8EzO/AHnnsMwouHznSxphCfYlxFRZs1I05nFEmzHS2cRfE/FDdsG7wGPJnB7AJKtC+/8ez
	cHryUY+hm6hw3TCc3mFP2zMPW72v84grM/s86dyPbeC0XrXSdeJoMd1DsNRliIOgTBOz4upLfQm
	Z3XyknOz2ap76V45mu1sri2V7cKt3FQRXmL1ewFLCbXmZrtxEUweIMRM6eZQ/6nufkqbTypFuvK
	SkYLpV
X-Received: by 2002:a05:600c:3e07:b0:493:de89:61b with SMTP id 5b1f17b1804b1-493e6868766mr42066915e9.26.1783541321164;
        Wed, 08 Jul 2026 13:08:41 -0700 (PDT)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e5a61135sm53387625e9.1.2026.07.08.13.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 13:08:40 -0700 (PDT)
Date: Wed, 08 Jul 2026 22:08:39 +0200
To: Vicki Pfau <vi@endrift.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org
Subject: Re: [PATCH v11 1/3] HID: nintendo: Add preliminary Switch 2
 controller driver
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20260702214704.1859350-1-vi@endrift.com>
 <20260702214704.1859350-2-vi@endrift.com>
 <2RB9AEPZHD3VD.3OBFQALQF980M@homearch.localdomain>
 <6e649d0b-a86c-4d63-859b-7fd89e71081f@endrift.com>
In-Reply-To: <6e649d0b-a86c-4d63-859b-7fd89e71081f@endrift.com>
Message-Id: <31CMJE1Z9X3TY.2OAY3O849D9HS@homearch.localdomain>
User-Agent: mblaze/1.4-3-ga04b747 (2026-07-03)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Vicki Pfau <vi@endrift.com> wrote:
> Hi Silvan,
>=20
> On 7/4/26 12:36 PM, Silvan Jegen wrote:
> > Heyhey!
> >=20
> > Some comments and questions below.
> >=20
> > Vicki Pfau <vi@endrift.com> wrote:
> >> This adds a new driver for the Switch 2 controllers. The Switch 2 uses=
 an
> >> unusual split-interface design such that input and rumble occur on the=
 main
> >> HID interface, but all other communication occurs over a "configuratio=
n"
> >> interface. This is the case on both USB and Bluetooth, so this new dri=
ver
> >> uses a split-driver design with the HID interface being the "main" dri=
ver
> >> and the configuration interface is a secondary driver that looks up to=
 the
> >> HID interface, sharing resources on a common struct.
> >>
> >> Due to using a non-standard pairing interface as well as Bluetooth
> >> communications being extremely limited in the kernel, a custom interfa=
ce
> >> between userspace and the kernel will need to be designed, along with
> >> bringup in BlueZ. That is beyond the scope of this initial patch, whic=
h
> >> only contains the generic HID and USB configuration interface drivers.=

> >>
> >> This initial work supports general input for the Joy-Con 2, Pro Contro=
ller
> >> 2, and GameCube NSO controllers. IMU, rumble and battery support is no=
t yet
> >> present.
> >>
> >> Signed-off-by: Vicki Pfau <vi@endrift.com>
> >> ---
> >>  MAINTAINERS                                   |    1 +
> >>  drivers/hid/Kconfig                           |   11 +-
> >>  drivers/hid/hid-ids.h                         |    4 +
> >>  drivers/hid/hid-nintendo.c                    | 1278 ++++++++++++++++=
-
> >>  drivers/hid/hid-nintendo.h                    |   72 +
> >>  drivers/input/joystick/Kconfig                |   11 +
> >>  drivers/input/joystick/Makefile               |    1 +
> >>  drivers/input/joystick/nintendo-switch2-usb.c |  468 ++++++
> >>  8 files changed, 1836 insertions(+), 10 deletions(-)
> >>  create mode 100644 drivers/hid/hid-nintendo.h
> >>  create mode 100644 drivers/input/joystick/nintendo-switch2-usb.c
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 4ecd282f8f52..778982ab298e 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -19051,6 +19051,7 @@ F:	drivers/scsi/nsp32*
> >> =20
> >>  NINTENDO HID DRIVER
> >>  M:	Daniel J. Ogorchock <djogorchock@gmail.com>
> >> +M:	Vicki Pfau <vi@endrift.com>
> >>  L:	linux-input@vger.kernel.org
> >>  S:	Maintained
> >>  F:	drivers/hid/hid-nintendo*
> >> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> >> index f9bcaeb66385..19c77c323ec9 100644
> >> --- a/drivers/hid/Kconfig
> >> +++ b/drivers/hid/Kconfig
> >> @@ -843,10 +843,13 @@ config HID_NINTENDO
> >>  	depends on LEDS_CLASS
> >>  	select POWER_SUPPLY
> >>  	help
> >> -	Adds support for the Nintendo Switch Joy-Cons, NSO, Pro Controller.
> >> -	All controllers support bluetooth, and the Pro Controller also suppo=
rts
> >> -	its USB mode. This also includes support for the Nintendo Switch Onl=
ine
> >> -	Controllers which include the NES, Genesis, SNES, and N64 controller=
s.
> >> +	Adds support for the Nintendo Switch Joy-Cons, NSO, Pro Controller, =
as
> >> +	well as Nintendo Switch 2 Joy-Cons, Pro Controller, and NSO GameCube=

> >> +	controllers. All Switch controllers support bluetooth, and the Pro
> >> +	Controller also supports its USB mode. This also includes support fo=
r
> >> +	the Nintendo Switch Online Controllers which include the NES, Genesi=
s,
> >> +	SNES, and N64 controllers. Switch 2 controllers currently only suppo=
rt
> >> +	USB mode.
> >> =20
> >>  	To compile this driver as a module, choose M here: the
> >>  	module will be called hid-nintendo.
> >> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> >> index 1059922baaac..9ba62b8fb894 100644
> >> --- a/drivers/hid/hid-ids.h
> >> +++ b/drivers/hid/hid-ids.h
> >> @@ -1103,6 +1103,10 @@
> >>  #define USB_DEVICE_ID_NINTENDO_SNESCON	0x2017
> >>  #define USB_DEVICE_ID_NINTENDO_GENCON	0x201e
> >>  #define USB_DEVICE_ID_NINTENDO_N64CON	0x2019
> >> +#define USB_DEVICE_ID_NINTENDO_NS2_JOYCONR	0x2066
> >> +#define USB_DEVICE_ID_NINTENDO_NS2_JOYCONL	0x2067
> >> +#define USB_DEVICE_ID_NINTENDO_NS2_PROCON	0x2069
> >> +#define USB_DEVICE_ID_NINTENDO_NS2_GCCON	0x2073
> >> =20
> >>  #define USB_VENDOR_ID_NOVATEK		0x0603
> >>  #define USB_DEVICE_ID_NOVATEK_PCT	0x0600
> >> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> >> index e7302ec01ff1..e21c36921832 100644
> >> --- a/drivers/hid/hid-nintendo.c
> >> +++ b/drivers/hid/hid-nintendo.c
> >> @@ -1,11 +1,13 @@
> >>  // SPDX-License-Identifier: GPL-2.0+
> >>  /*
> >> - * HID driver for Nintendo Switch Joy-Cons and Pro Controllers
> >> + * HID driver for Nintendo Switch Joy-Cons and Pro Controllers, as we=
ll as
> >> + * Nintendo Switch 2 Joy-Cons, Pro Controller, and GameCube Controlle=
r
> >>   *
> >>   * Copyright (c) 2019-2021 Daniel J. Ogorchock <djogorchock@gmail.com=
>
> >>   * Portions Copyright (c) 2020 Nadia Holmquist Pedersen <nadia@nhp.sh=
>
> >>   * Copyright (c) 2022 Emily Strickland <linux@emily.st>
> >>   * Copyright (c) 2023 Ryan McClelland <rymcclel@gmail.com>
> >> + * Copyright (c) 2026 Valve Software
> >>   *
> >>   * The following resources/projects were referenced for this driver:
> >>   *   https://github.com/dekuNukem/Nintendo_Switch_Reverse_Engineering=

> >> @@ -13,6 +15,8 @@
> >>   *   https://github.com/FrotBot/SwitchProConLinuxUSB
> >>   *   https://github.com/MTCKC/ProconXInput
> >>   *   https://github.com/Davidobot/BetterJoyForCemu
> >> + *   https://gist.github.com/shinyquagsire23/66f006b46c56216acbaac6c1=
e2279b64
> >> + *   https://github.com/ndeadly/switch2_controller_research
> >>   *   hid-wiimote kernel hid driver
> >>   *   hid-logitech-hidpp driver
> >>   *   hid-sony driver
> >> @@ -29,6 +33,7 @@
> >>   */
> >> =20
> >>  #include "hid-ids.h"
> >> +#include "hid-nintendo.h"
> >>  #include <linux/unaligned.h>
> >>  #include <linux/delay.h>
> >>  #include <linux/device.h>
> >> @@ -41,6 +46,8 @@
> >>  #include <linux/module.h>
> >>  #include <linux/power_supply.h>
> >>  #include <linux/spinlock.h>
> >> +#include <linux/usb.h>
> >> +#include "usbhid/usbhid.h"
> >> =20
> >>  /*
> >>   * Reference the url below for the following HID report defines:
> >> @@ -2662,7 +2669,7 @@ static int joycon_ctlr_handle_event(struct joyco=
n_ctlr *ctlr, u8 *data,
> >>  	return ret;
> >>  }
> >> =20
> >> -static int nintendo_hid_event(struct hid_device *hdev,
> >> +static int joycon_event(struct hid_device *hdev,
> >>  			      struct hid_report *report, u8 *raw_data, int size)
> >>  {
> >>  	struct joycon_ctlr *ctlr =3D hid_get_drvdata(hdev);
> >> @@ -2673,7 +2680,7 @@ static int nintendo_hid_event(struct hid_device =
*hdev,
> >>  	return joycon_ctlr_handle_event(ctlr, raw_data, size);
> >>  }
> >> =20
> >> -static int nintendo_hid_probe(struct hid_device *hdev,
> >> +static int joycon_probe(struct hid_device *hdev,
> >>  			    const struct hid_device_id *id)
> >>  {
> >>  	int ret;
> >> @@ -2777,7 +2784,7 @@ static int nintendo_hid_probe(struct hid_device =
*hdev,
> >>  	return ret;
> >>  }
> >> =20
> >> -static void nintendo_hid_remove(struct hid_device *hdev)
> >> +static void joycon_remove(struct hid_device *hdev)
> >>  {
> >>  	struct joycon_ctlr *ctlr =3D hid_get_drvdata(hdev);
> >>  	unsigned long flags;
> >> @@ -2796,7 +2803,7 @@ static void nintendo_hid_remove(struct hid_devic=
e *hdev)
> >>  	hid_hw_stop(hdev);
> >>  }
> >> =20
> >> -static int nintendo_hid_resume(struct hid_device *hdev)
> >> +static int joycon_resume(struct hid_device *hdev)
> >>  {
> >>  	struct joycon_ctlr *ctlr =3D hid_get_drvdata(hdev);
> >>  	int ret;
> >> @@ -2819,7 +2826,7 @@ static int nintendo_hid_resume(struct hid_device=
 *hdev)
> >>  	return ret;
> >>  }
> >> =20
> >> -static int nintendo_hid_suspend(struct hid_device *hdev, pm_message_t=
 message)
> >> +static int joycon_suspend(struct hid_device *hdev, pm_message_t messa=
ge)
> >>  {
> >>  	struct joycon_ctlr *ctlr =3D hid_get_drvdata(hdev);
> >> =20
> >> @@ -2838,7 +2845,1208 @@ static int nintendo_hid_suspend(struct hid_de=
vice *hdev, pm_message_t message)
> >>  	return 0;
> >>  }
> >> =20
> >> +/*
> >> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> + * Switch 2 support
> >> + * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> >> + */
> >> +#define NS2_BTNR_B	BIT(0)
> >> +#define NS2_BTNR_A	BIT(1)
> >> +#define NS2_BTNR_Y	BIT(2)
> >> +#define NS2_BTNR_X	BIT(3)
> >> +#define NS2_BTNR_R	BIT(4)
> >> +#define NS2_BTNR_ZR	BIT(5)
> >> +#define NS2_BTNR_PLUS	BIT(6)
> >> +#define NS2_BTNR_RS	BIT(7)
> >> +
> >> +#define NS2_BTNL_DOWN	BIT(0)
> >> +#define NS2_BTNL_RIGHT	BIT(1)
> >> +#define NS2_BTNL_LEFT	BIT(2)
> >> +#define NS2_BTNL_UP	BIT(3)
> >> +#define NS2_BTNL_L	BIT(4)
> >> +#define NS2_BTNL_ZL	BIT(5)
> >> +#define NS2_BTNL_MINUS	BIT(6)
> >> +#define NS2_BTNL_LS	BIT(7)
> >> +
> >> +#define NS2_BTN3_C	BIT(4)
> >> +#define NS2_BTN3_SR	BIT(6)
> >> +#define NS2_BTN3_SL	BIT(7)
> >> +
> >> +#define NS2_BTN_JCR_HOME	BIT(0)
> >> +#define NS2_BTN_JCR_GR		BIT(2)
> >> +#define NS2_BTN_JCR_C		NS2_BTN3_C
> >> +#define NS2_BTN_JCR_SR		NS2_BTN3_SR
> >> +#define NS2_BTN_JCR_SL		NS2_BTN3_SL
> >> +
> >> +#define NS2_BTN_JCL_CAPTURE	BIT(0)
> >> +#define NS2_BTN_JCL_GL		BIT(2)
> >> +#define NS2_BTN_JCL_SR		NS2_BTN3_SR
> >> +#define NS2_BTN_JCL_SL		NS2_BTN3_SL
> >> +
> >> +#define NS2_BTN_PRO_HOME	BIT(0)
> >> +#define NS2_BTN_PRO_CAPTURE	BIT(1)
> >> +#define NS2_BTN_PRO_GR		BIT(2)
> >> +#define NS2_BTN_PRO_GL		BIT(3)
> >> +#define NS2_BTN_PRO_C		NS2_BTN3_C
> >> +
> >> +#define NS2_BTN_GC_HOME		BIT(0)
> >> +#define NS2_BTN_GC_CAPTURE	BIT(1)
> >> +#define NS2_BTN_GC_C		NS2_BTN3_C
> >> +
> >> +#define NS2_TRIGGER_RANGE	4095
> >> +#define NS2_AXIS_MIN		-32768
> >> +#define NS2_AXIS_MAX		32767
> >> +
> >> +#define NS2_MAX_PLAYER_ID	8
> >> +
> >> +#define NS2_MAX_INIT_RETRIES	4
> >> +
> >> +#define NS2_FLASH_ADDR_SERIAL			0x13002
> >> +#define NS2_FLASH_ADDR_FACTORY_PRIMARY_CALIB	0x130a8
> >> +#define NS2_FLASH_ADDR_FACTORY_SECONDARY_CALIB	0x130e8
> >> +#define NS2_FLASH_ADDR_FACTORY_TRIGGER_CALIB	0x13140
> >> +#define NS2_FLASH_ADDR_USER_PRIMARY_CALIB	0x1fc040
> >> +#define NS2_FLASH_ADDR_USER_SECONDARY_CALIB	0x1fc080
> >> +
> >> +#define NS2_FLASH_SIZE_SERIAL 0x10
> >> +#define NS2_FLASH_SIZE_FACTORY_AXIS_CALIB 9
> >> +#define NS2_FLASH_SIZE_FACTORY_TRIGGER_CALIB 2
> >> +#define NS2_FLASH_SIZE_USER_AXIS_CALIB 11
> >> +
> >> +#define NS2_USER_CALIB_MAGIC 0xa1b2
> >> +
> >> +#define NS2_FEATURE_BUTTONS	BIT(0)
> >> +#define NS2_FEATURE_ANALOG	BIT(1)
> >> +#define NS2_FEATURE_IMU		BIT(2)
> >=20
> > Two tabs instead of one?
> >=20
>=20
> Yes, Linux uses a tabstop of 8 and this is how it lines up with that ts.

Then let's leave it as is!
=20
> >=20
> >> +#define NS2_FEATURE_MOUSE	BIT(4)
> >=20
> > This one doesn't seem to be used (yet). Not sure if that is intended
> > or not.
>=20
> I don't see that as a problem. It's code as documentation, even if
> it's not used yet.

Works for me!

>=20
> >=20
> >> +#define NS2_FEATURE_RUMBLE	BIT(5)
> >> +#define NS2_FEATURE_MAGNETO	BIT(7)
> >=20
> > Ditto.
> >=20
> >> +
> >> +enum switch2_subcmd_flash {
> >> +	NS2_SUBCMD_FLASH_READ_BLOCK =3D 0x01,
> >> +	NS2_SUBCMD_FLASH_WRITE_BLOCK =3D 0x02,
> >> +	NS2_SUBCMD_FLASH_ERASE_BLOCK =3D 0x03,
> >> +	NS2_SUBCMD_FLASH_READ =3D 0x04,
> >> +	NS2_SUBCMD_FLASH_WRITE =3D 0x05,
> >> +};
> >> +
> >> +enum switch2_subcmd_init {
> >> +	NS2_SUBCMD_INIT_SELECT_REPORT =3D 0xa,
> >> +	NS2_SUBCMD_INIT_USB =3D 0xd,
> >> +};
> >> +
> >> +enum switch2_subcmd_feature_select {
> >> +	NS2_SUBCMD_FEATSEL_GET_INFO =3D 0x1,
> >> +	NS2_SUBCMD_FEATSEL_SET_MASK =3D 0x2,
> >> +	NS2_SUBCMD_FEATSEL_CLEAR_MASK =3D 0x3,
> >> +	NS2_SUBCMD_FEATSEL_ENABLE =3D 0x4,
> >> +	NS2_SUBCMD_FEATSEL_DISABLE =3D 0x5,
> >> +};
> >> +
> >> +enum switch2_subcmd_grip {
> >> +	NS2_SUBCMD_GRIP_GET_INFO =3D 0x1,
> >> +	NS2_SUBCMD_GRIP_ENABLE_BUTTONS =3D 0x2,
> >> +	NS2_SUBCMD_GRIP_GET_INFO_EXT =3D 0x3,
> >> +};
> >> +
> >> +enum switch2_subcmd_led {
> >> +	NS2_SUBCMD_LED_P1 =3D 0x1,
> >> +	NS2_SUBCMD_LED_P2 =3D 0x2,
> >> +	NS2_SUBCMD_LED_P3 =3D 0x3,
> >> +	NS2_SUBCMD_LED_P4 =3D 0x4,
> >> +	NS2_SUBCMD_LED_ALL_ON =3D 0x5,
> >> +	NS2_SUBCMD_LED_ALL_OFF =3D 0x6,
> >> +	NS2_SUBCMD_LED_PATTERN =3D 0x7,
> >> +	NS2_SUBCMD_LED_BLINK =3D 0x8,
> >> +};
> >> +
> >> +enum switch2_subcmd_fw_info {
> >> +	NS2_SUBCMD_FW_INFO_GET =3D 0x1,
> >> +};
> >> +
> >> +enum switch2_ctlr_type {
> >> +	NS2_CTLR_TYPE_JCL =3D 0x00,
> >> +	NS2_CTLR_TYPE_JCR =3D 0x01,
> >> +	NS2_CTLR_TYPE_PRO =3D 0x02,
> >> +	NS2_CTLR_TYPE_GC =3D 0x03,
> >> +};
> >> +
> >> +enum switch2_report_id {
> >> +	NS2_REPORT_UNIFIED =3D 0x05,
> >> +	NS2_REPORT_JCL =3D 0x07,
> >> +	NS2_REPORT_JCR =3D 0x08,
> >> +	NS2_REPORT_PRO =3D 0x09,
> >> +	NS2_REPORT_GC =3D 0x0a,
> >> +};
> >> +
> >> +enum switch2_init_step {
> >> +	NS2_INIT_READ_SERIAL,
> >> +	NS2_INIT_GET_FIRMWARE_INFO,
> >> +	NS2_INIT_READ_FACTORY_PRIMARY_CALIB,
> >> +	NS2_INIT_READ_FACTORY_SECONDARY_CALIB,
> >> +	NS2_INIT_READ_FACTORY_TRIGGER_CALIB,
> >> +	NS2_INIT_READ_USER_PRIMARY_CALIB,
> >> +	NS2_INIT_READ_USER_SECONDARY_CALIB,
> >> +	NS2_INIT_SET_FEATURE_MASK,
> >> +	NS2_INIT_ENABLE_FEATURES,
> >> +	NS2_INIT_GRIP_BUTTONS,
> >> +	NS2_INIT_REPORT_FORMAT,
> >> +	NS2_INIT_INPUT,
> >> +	NS2_INIT_SET_PLAYER_LEDS,
> >> +	NS2_INIT_FINISH,
> >> +	NS2_INIT_DONE,
> >> +};
> >> +
> >> +struct switch2_version_info {
> >> +	uint8_t major;
> >> +	uint8_t minor;
> >> +	uint8_t patch;
> >> +	uint8_t ctlr_type;
> >> +	__le32 unk;
> >> +	int8_t dsp_major;
> >> +	int8_t dsp_minor;
> >> +	int8_t dsp_patch;
> >> +	int8_t dsp_type;
> >> +};
> >> +
> >> +struct switch2_axis_calibration {
> >> +	uint16_t neutral;
> >> +	uint16_t negative;
> >> +	uint16_t positive;
> >> +};
> >> +
> >> +struct switch2_stick_calibration {
> >> +	struct switch2_axis_calibration x;
> >> +	struct switch2_axis_calibration y;
> >> +};
> >> +
> >> +struct switch2_controller {
> >> +	struct hid_device *hdev;
> >> +	struct switch2_cfg_intf *cfg;
> >> +	struct kref refcount;
> >> +
> >> +	char name[64];
> >> +	char phys[64];
> >> +	struct list_head entry;
> >> +	struct mutex lock;
> >> +
> >> +	enum switch2_ctlr_type ctlr_type;
> >> +	enum switch2_init_step init_step;
> >> +	int init_retries;
> >> +	struct input_dev __rcu *input;
> >> +	char serial[NS2_FLASH_SIZE_SERIAL + 1];
> >> +	struct switch2_version_info version;
> >> +
> >> +	struct switch2_stick_calibration stick_calib[2];
> >> +	uint8_t lt_zero;
> >> +	uint8_t rt_zero;
> >> +
> >> +	uint32_t player_id;
> >> +	struct led_classdev *leds;
> >> +};
> >> +
> >> +static DEFINE_MUTEX(switch2_controllers_lock);
> >> +static LIST_HEAD(switch2_controllers);
> >> +
> >> +struct switch2_ctlr_button_mapping {
> >> +	uint32_t code;
> >> +	int byte;
> >> +	uint32_t bit;
> >> +};
> >> +
> >> +static const struct switch2_ctlr_button_mapping ns2_left_joycon_butto=
n_mappings[] =3D {
> >> +	{ BTN_DPAD_LEFT,	0, NS2_BTNL_LEFT,	},
> >> +	{ BTN_DPAD_UP,		0, NS2_BTNL_UP,		},
> >> +	{ BTN_DPAD_DOWN,	0, NS2_BTNL_DOWN,	},
> >> +	{ BTN_DPAD_RIGHT,	0, NS2_BTNL_RIGHT,	},
> >> +	{ BTN_TL,		0, NS2_BTNL_L,		},
> >> +	{ BTN_TL2,		0, NS2_BTNL_ZL,		},
> >> +	{ BTN_SELECT,		0, NS2_BTNL_MINUS,	},
> >> +	{ BTN_THUMBL,		0, NS2_BTNL_LS,		},
> >> +	{ KEY_RECORD,		1, NS2_BTN_JCL_CAPTURE,	},
> >> +	{ BTN_GRIPR,		1, NS2_BTN_JCL_SL,	},
> >> +	{ BTN_GRIPR2,		1, NS2_BTN_JCL_SR,	},
> >> +	{ BTN_GRIPL,		1, NS2_BTN_JCL_GL,	},
> >> +	{ /* sentinel */ },
> >> +};
> >> +
> >> +static const struct switch2_ctlr_button_mapping ns2_right_joycon_butt=
on_mappings[] =3D {
> >> +	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
> >> +	{ BTN_EAST,	0, NS2_BTNR_B,		},
> >> +	{ BTN_NORTH,	0, NS2_BTNR_X,		},
> >> +	{ BTN_WEST,	0, NS2_BTNR_Y,		},
> >> +	{ BTN_TR,	0, NS2_BTNR_R,		},
> >> +	{ BTN_TR2,	0, NS2_BTNR_ZR,		},
> >> +	{ BTN_START,	0, NS2_BTNR_PLUS,	},
> >> +	{ BTN_THUMBR,	0, NS2_BTNR_RS,		},
> >> +	{ BTN_C,	1, NS2_BTN_JCR_C,	},
> >> +	{ BTN_MODE,	1, NS2_BTN_JCR_HOME,	},
> >> +	{ BTN_GRIPL2,	1, NS2_BTN_JCR_SL,	},
> >> +	{ BTN_GRIPL,	1, NS2_BTN_JCR_SR,	},
> >> +	{ BTN_GRIPR,	1, NS2_BTN_JCR_GR,	},
> >> +	{ /* sentinel */ },
> >> +};
> >> +
> >> +static const struct switch2_ctlr_button_mapping ns2_procon_mappings[]=
 =3D {
> >> +	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
> >> +	{ BTN_EAST,	0, NS2_BTNR_B,		},
> >> +	{ BTN_NORTH,	0, NS2_BTNR_X,		},
> >> +	{ BTN_WEST,	0, NS2_BTNR_Y,		},
> >> +	{ BTN_TL,	1, NS2_BTNL_L,		},
> >> +	{ BTN_TR,	0, NS2_BTNR_R,		},
> >> +	{ BTN_TL2,	1, NS2_BTNL_ZL,		},
> >> +	{ BTN_TR2,	0, NS2_BTNR_ZR,		},
> >> +	{ BTN_SELECT,	1, NS2_BTNL_MINUS,	},
> >> +	{ BTN_START,	0, NS2_BTNR_PLUS,	},
> >> +	{ BTN_THUMBL,	1, NS2_BTNL_LS,		},
> >> +	{ BTN_THUMBR,	0, NS2_BTNR_RS,		},
> >> +	{ BTN_MODE,	2, NS2_BTN_PRO_HOME	},
> >> +	{ KEY_RECORD,	2, NS2_BTN_PRO_CAPTURE	},
> >> +	{ BTN_GRIPR,	2, NS2_BTN_PRO_GR	},
> >> +	{ BTN_GRIPL,	2, NS2_BTN_PRO_GL	},
> >> +	{ BTN_C,	2, NS2_BTN_PRO_C	},
> >> +	{ /* sentinel */ },
> >> +};
> >> +
> >> +static const struct switch2_ctlr_button_mapping ns2_gccon_mappings[] =
=3D {
> >> +	{ BTN_SOUTH,	0, NS2_BTNR_A,		},
> >> +	{ BTN_EAST,	0, NS2_BTNR_B,		},
> >> +	{ BTN_NORTH,	0, NS2_BTNR_X,		},
> >> +	{ BTN_WEST,	0, NS2_BTNR_Y,		},
> >> +	{ BTN_TL2,	1, NS2_BTNL_L,		},
> >> +	{ BTN_TR2,	0, NS2_BTNR_R,		},
> >> +	{ BTN_TL,	1, NS2_BTNL_ZL,		},
> >> +	{ BTN_TR,	0, NS2_BTNR_ZR,		},
> >> +	{ BTN_SELECT,	1, NS2_BTNL_MINUS,	},
> >> +	{ BTN_START,	0, NS2_BTNR_PLUS,	},
> >> +	{ BTN_MODE,	2, NS2_BTN_GC_HOME	},
> >> +	{ KEY_RECORD,	2, NS2_BTN_GC_CAPTURE	},
> >> +	{ BTN_C,	2, NS2_BTN_GC_C		},
> >> +	{ /* sentinel */ },
> >> +};
> >> +
> >> +static const uint8_t switch2_init_cmd_data[] =3D {
> >> +	/*
> >> +	 * The last 6 bytes of this packet are the MAC address of
> >> +	 * the console, but we don't need that for USB
> >> +	 */
> >> +	0x01, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
> >> +};
> >> +
> >> +static const uint8_t switch2_one_data[] =3D { 0x01, 0x00, 0x00, 0x00 =
};
> >> +
> >> +static const uint8_t switch2_feature_mask[] =3D {
> >> +	NS2_FEATURE_BUTTONS | NS2_FEATURE_ANALOG | NS2_FEATURE_IMU,
> >> +	0x00, 0x00, 0x00
> >> +};
> >> +
> >> +static int switch2_init_controller(struct switch2_controller *ns2);
> >> +
> >> +static void switch2_init_step_done(struct switch2_controller *ns2, en=
um switch2_init_step step)
> >> +{
> >> +	if (ns2->init_step !=3D step)
> >> +		return;
> >> +
> >> +	ns2->init_retries =3D 0;
> >> +	ns2->init_step++;
> >> +}
> >> +
> >> +static inline bool switch2_ctlr_is_joycon(enum switch2_ctlr_type type=
)
> >> +{
> >> +	return type =3D=3D NS2_CTLR_TYPE_JCL || type =3D=3D NS2_CTLR_TYPE_JC=
R;
> >> +}
> >> +
> >> +static struct switch2_controller *switch2_get_controller(const char *=
phys)
> >> +{
> >> +	struct switch2_controller *ns2;
> >> +
> >> +	guard(mutex)(&switch2_controllers_lock);
> >> +	list_for_each_entry(ns2, &switch2_controllers, entry) {
> >> +		if (strncmp(ns2->phys, phys, sizeof(ns2->phys)) =3D=3D 0) {
> >> +			if (kref_get_unless_zero(&ns2->refcount))
> >> +				return ns2;
> >> +		}
> >> +	}
> >> +	ns2 =3D kzalloc(sizeof(*ns2), GFP_KERNEL);
> >> +	if (!ns2)
> >> +		return ERR_PTR(-ENOMEM);
> >> +
> >> +	kref_init(&ns2->refcount);
> >> +	mutex_init(&ns2->lock);
> >> +	INIT_LIST_HEAD(&ns2->entry);
> >> +	list_add(&ns2->entry, &switch2_controllers);
> >> +	strscpy(ns2->phys, phys, sizeof(ns2->phys));
> >> +	return ns2;
> >> +}
> >> +
> >> +static void switch2_controller_put(struct switch2_controller *ns2)
> >> +{
> >> +	struct input_dev *input;
> >> +
> >> +	mutex_lock(&ns2->lock);
> >> +	rcu_read_lock();
> >> +	input =3D rcu_dereference(ns2->input);
> >> +	rcu_read_unlock();
> >> +
> >> +	rcu_assign_pointer(ns2->input, NULL);
> >> +	synchronize_rcu();
> >> +
> >> +	ns2->init_step =3D 0;
> >> +	mutex_unlock(&ns2->lock);
> >> +
> >> +	if (input)
> >> +		input_unregister_device(input);
> >> +}
> >> +
> >> +static void switch2_kref_put(struct kref *refcount)
> >> +{
> >> +	struct switch2_controller *ns2 =3D container_of(refcount,
> >> +					struct switch2_controller, refcount);
> >> +
> >> +	guard(mutex)(&switch2_controllers_lock);
> >> +	list_del_init(&ns2->entry);
> >> +	mutex_destroy(&ns2->lock);
> >> +	kfree(ns2);
> >> +}
> >> +
> >> +static int switch2_set_leds(struct switch2_controller *ns2)
> >> +{
> >> +	int i;
> >> +	uint8_t message[8] =3D { 0 };
> >> +
> >> +	for (i =3D 0; i < JC_NUM_LEDS; i++)
> >> +		message[0] |=3D (!!ns2->leds[i].brightness) << i;
> >> +
> >> +	if (!ns2->cfg)
> >> +		return -ENOTCONN;
> >> +	return ns2->cfg->send_command(NS2_CMD_LED, NS2_SUBCMD_LED_PATTERN,
> >> +		&message, sizeof(message),
> >> +		ns2->cfg);
> >> +}
> >> +
> >> +static int switch2_player_led_brightness_set(struct led_classdev *led=
,
> >> +					    enum led_brightness brightness)
> >> +{
> >> +	struct device *dev =3D led->dev->parent;
> >> +	struct input_dev *input =3D to_input_dev(dev);
> >> +	struct switch2_controller *ns2 =3D input_get_drvdata(input);
> >> +
> >> +	if (!ns2)
> >> +		return -ENODEV;
> >> +
> >> +	guard(mutex)(&ns2->lock);
> >> +	return switch2_set_leds(ns2);
> >> +}
> >> +
> >> +static void switch2_config_buttons(struct input_dev *idev,
> >> +	const struct switch2_ctlr_button_mapping button_mappings[])
> >> +{
> >> +	const struct switch2_ctlr_button_mapping *button;
> >> +
> >> +	for (button =3D button_mappings; button->code; button++)
> >> +		input_set_capability(idev, EV_KEY, button->code);
> >> +}
> >> +
> >> +static int switch2_input_ref(struct input_dev *input)
> >> +{
> >> +	struct switch2_controller *ns2 =3D input_get_drvdata(input);
> >> +
> >> +	kref_get(&ns2->refcount);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void switch2_input_deref(struct input_dev *input)
> >> +{
> >> +	struct switch2_controller *ns2 =3D input_get_drvdata(input);
> >> +
> >> +	kref_put(&ns2->refcount, switch2_kref_put);
> >> +}
> >> +
> >> +static int switch2_init_input(struct switch2_controller *ns2)
> >> +{
> >> +	struct input_dev *input;
> >> +	struct hid_device *hdev =3D ns2->hdev;
> >> +	int player_led_pattern;
> >> +	int i;
> >> +	int ret;
> >> +
> >> +	rcu_read_lock();
> >> +	input =3D rcu_dereference(ns2->input);
> >> +	rcu_read_unlock();
> >> +
> >> +	if (input) {
> >> +		switch2_init_step_done(ns2, NS2_INIT_INPUT);
> >> +		return 0;
> >> +	}
> >> +
> >> +	input =3D input_allocate_device();
> >> +	if (!input)
> >> +		return -ENOMEM;
> >> +
> >> +	input_set_drvdata(input, ns2);
> >> +	input->open =3D switch2_input_ref;
> >> +	input->close =3D switch2_input_deref;
> >> +	input->dev.parent =3D &hdev->dev;
> >> +	input->id.bustype =3D hdev->bus;
> >> +	input->id.vendor =3D hdev->vendor;
> >> +	input->id.product =3D hdev->product;
> >> +	input->id.version =3D hdev->version;
> >> +	input->uniq =3D ns2->serial;
> >> +	input->name =3D ns2->name;
> >> +	input->phys =3D hdev->phys;
> >> +
> >> +	switch (ns2->ctlr_type) {
> >> +	case NS2_CTLR_TYPE_JCL:
> >> +		input_set_abs_params(input, ABS_X, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
> >> +		input_set_abs_params(input, ABS_Y, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
> >> +		switch2_config_buttons(input, ns2_left_joycon_button_mappings);
> >> +		break;
> >> +	case NS2_CTLR_TYPE_JCR:
> >> +		input_set_abs_params(input, ABS_X, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
> >> +		input_set_abs_params(input, ABS_Y, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
> >> +		switch2_config_buttons(input, ns2_right_joycon_button_mappings);
> >> +		break;
> >> +	case NS2_CTLR_TYPE_GC:
> >> +		input_set_abs_params(input, ABS_X, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
> >> +		input_set_abs_params(input, ABS_Y, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
> >> +		input_set_abs_params(input, ABS_RX, NS2_AXIS_MIN, NS2_AXIS_MAX, 32,=
 128);
> >> +		input_set_abs_params(input, ABS_RY, NS2_AXIS_MIN, NS2_AXIS_MAX, 32,=
 128);
> >> +		input_set_abs_params(input, ABS_Z, 0, NS2_TRIGGER_RANGE, 32, 128);
> >> +		input_set_abs_params(input, ABS_RZ, 0, NS2_TRIGGER_RANGE, 32, 128);=

> >> +		input_set_abs_params(input, ABS_HAT0X, -1, 1, 0, 0);
> >> +		input_set_abs_params(input, ABS_HAT0Y, -1, 1, 0, 0);
> >> +		switch2_config_buttons(input, ns2_gccon_mappings);
> >> +		break;
> >> +	case NS2_CTLR_TYPE_PRO:
> >> +		input_set_abs_params(input, ABS_X, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
> >> +		input_set_abs_params(input, ABS_Y, NS2_AXIS_MIN, NS2_AXIS_MAX, 32, =
128);
> >> +		input_set_abs_params(input, ABS_RX, NS2_AXIS_MIN, NS2_AXIS_MAX, 32,=
 128);
> >> +		input_set_abs_params(input, ABS_RY, NS2_AXIS_MIN, NS2_AXIS_MAX, 32,=
 128);
> >> +		input_set_abs_params(input, ABS_HAT0X, -1, 1, 0, 0);
> >> +		input_set_abs_params(input, ABS_HAT0Y, -1, 1, 0, 0);
> >> +		switch2_config_buttons(input, ns2_procon_mappings);
> >> +		break;
> >> +	default:
> >> +		input_free_device(input);
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	hid_info(ns2->hdev, "Firmware version %u.%u.%u (type %i)\n", ns2->ve=
rsion.major,
> >> +		ns2->version.minor, ns2->version.patch, ns2->version.ctlr_type);
> >> +	if (ns2->version.dsp_type >=3D 0)
> >> +		hid_info(ns2->hdev, "DSP version %u.%u.%u\n", ns2->version.dsp_majo=
r,
> >> +			ns2->version.dsp_minor, ns2->version.dsp_patch);
> >> +
> >> +	ret =3D input_register_device(input);
> >> +	if (ret < 0) {
> >> +		hid_err(ns2->hdev, "Failed to register input; ret=3D%d\n", ret);
> >> +		input_free_device(input);
> >> +		return ret;
> >> +	}
> >> +
> >> +	player_led_pattern =3D ns2->player_id % JC_NUM_LED_PATTERNS;
> >> +	hid_dbg(hdev, "assigned player %d led pattern", player_led_pattern +=
 1);
> >> +
> >> +	ns2->leds =3D devm_kcalloc(&input->dev, JC_NUM_LEDS, sizeof(*ns2->le=
ds), GFP_KERNEL);
> >> +	if (!ns2->leds) {
> >> +		hid_err(ns2->hdev, "Failed to allocate LEDs\n");
> >> +		input_unregister_device(input);
> >> +		return -ENOMEM;
> >> +	}
> >> +
> >> +	for (i =3D 0; i < JC_NUM_LEDS; i++) {
> >> +		struct led_classdev *led =3D &ns2->leds[i];
> >> +
> >> +		led->brightness =3D joycon_player_led_patterns[player_led_pattern][=
i];
> >> +		led->max_brightness =3D 1;
> >> +		led->brightness_set_blocking =3D switch2_player_led_brightness_set;=

> >> +		led->flags =3D LED_CORE_SUSPENDRESUME | LED_HW_PLUGGABLE | LED_RETA=
IN_AT_SHUTDOWN;
> >> +		char *name =3D devm_kasprintf(&input->dev, GFP_KERNEL, "%s:%s:%s",
> >> +				      dev_name(&input->dev),
> >> +				      "green",
> >> +				      joycon_player_led_names[i]);
> >> +
> >> +		if (!name) {
> >> +			dev_err(&input->dev, "Failed to allocate name for player %d LED; r=
et=3D%d\n",
> >> +				i + 1, ret);
> >> +			break;
> >> +		}
> >> +
> >> +		led->name =3D name;
> >> +		ret =3D devm_led_classdev_register(&input->dev, led);
> >> +		if (ret < 0) {
> >> +			dev_err(&input->dev, "Failed to register player %d LED; ret=3D%d\n=
",
> >> +				i + 1, ret);
> >> +			break;
> >> +		}
> >> +	}
> >> +
> >> +	rcu_assign_pointer(ns2->input, input);
> >> +	synchronize_rcu();
> >> +
> >> +	switch2_init_step_done(ns2, NS2_INIT_INPUT);
> >> +	return switch2_init_controller(ns2);
> >> +}
> >> +
> >> +static bool switch2_parse_stick_calibration(struct switch2_stick_cali=
bration *calib,
> >> +	const uint8_t *data)
> >> +{
> >> +	static const uint8_t UNCALIBRATED[9] =3D {
> >> +		0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF
> >> +	};
> >> +	if (memcmp(UNCALIBRATED, data, sizeof(UNCALIBRATED)) =3D=3D 0)
> >> +		return false;
> >> +
> >> +	calib->x.neutral =3D data[0];
> >> +	calib->x.neutral |=3D (data[1] & 0x0F) << 8;
> >> +
> >> +	calib->y.neutral =3D data[1] >> 4;
> >> +	calib->y.neutral |=3D data[2] << 4;
> >> +
> >> +	calib->x.positive =3D data[3];
> >> +	calib->x.positive |=3D (data[4] & 0x0F) << 8;
> >> +
> >> +	calib->y.positive =3D data[4] >> 4;
> >> +	calib->y.positive |=3D data[5] << 4;
> >> +
> >> +	calib->x.negative =3D data[6];
> >> +	calib->x.negative |=3D (data[7] & 0x0F) << 8;
> >> +
> >> +	calib->y.negative =3D data[7] >> 4;
> >> +	calib->y.negative |=3D data[8] << 4;
> >> +
> >> +	return true;
> >> +}
> >> +
> >> +static void switch2_handle_flash_read(struct switch2_controller *ns2,=
 uint8_t size,
> >> +	uint32_t address, const uint8_t *data)
> >> +{
> >> +	bool ok;
> >> +
> >> +	switch (address) {
> >> +	case NS2_FLASH_ADDR_SERIAL:
> >> +		if (size !=3D NS2_FLASH_SIZE_SERIAL)
> >> +			return;
> >> +		memcpy(ns2->serial, data, size);
> >> +		switch2_init_step_done(ns2, NS2_INIT_READ_SERIAL);
> >> +		break;
> >> +	case NS2_FLASH_ADDR_FACTORY_PRIMARY_CALIB:
> >> +		if (size !=3D NS2_FLASH_SIZE_FACTORY_AXIS_CALIB)
> >> +			return;
> >> +		switch2_init_step_done(ns2, NS2_INIT_READ_FACTORY_PRIMARY_CALIB);
> >> +		ok =3D switch2_parse_stick_calibration(&ns2->stick_calib[0], data);=

> >> +		if (ns2->hdev) {
> >> +			if (ok) {
> >> +				hid_dbg(ns2->hdev, "Got factory primary stick calibration:\n");
> >> +				hid_dbg(ns2->hdev, "Left max: %i, neutral: %i, right max: %i\n",
> >> +					ns2->stick_calib[0].x.negative,
> >> +					ns2->stick_calib[0].x.neutral,
> >> +					ns2->stick_calib[0].x.positive);
> >> +				hid_dbg(ns2->hdev, "Down max: %i, neutral: %i, up max: %i\n",
> >> +					ns2->stick_calib[0].y.negative,
> >> +					ns2->stick_calib[0].y.neutral,
> >> +					ns2->stick_calib[0].y.positive);
> >> +			} else {
> >> +				hid_dbg(ns2->hdev, "Factory primary stick calibration not present=
\n");
> >> +			}
> >> +		}
> >> +		break;
> >> +	case NS2_FLASH_ADDR_FACTORY_SECONDARY_CALIB:
> >> +		if (size !=3D NS2_FLASH_SIZE_FACTORY_AXIS_CALIB)
> >> +			return;
> >> +		switch2_init_step_done(ns2, NS2_INIT_READ_FACTORY_SECONDARY_CALIB);=

> >> +		ok =3D switch2_parse_stick_calibration(&ns2->stick_calib[1], data);=

> >> +		if (ns2->hdev) {
> >> +			if (ok) {
> >> +				hid_dbg(ns2->hdev, "Got factory secondary stick calibration:\n");=

> >> +				hid_dbg(ns2->hdev, "Left max: %i, neutral: %i, right max: %i\n",
> >> +					ns2->stick_calib[1].x.negative,
> >> +					ns2->stick_calib[1].x.neutral,
> >> +					ns2->stick_calib[1].x.positive);
> >> +				hid_dbg(ns2->hdev, "Down max: %i, neutral: %i, up max: %i\n",
> >> +					ns2->stick_calib[1].y.negative,
> >> +					ns2->stick_calib[1].y.neutral,
> >> +					ns2->stick_calib[1].y.positive);
> >> +			} else {
> >> +				hid_dbg(ns2->hdev, "Factory secondary stick calibration not prese=
nt\n");
> >> +			}
> >> +		}
> >> +		break;
> >> +	case NS2_FLASH_ADDR_FACTORY_TRIGGER_CALIB:
> >> +		if (size !=3D NS2_FLASH_SIZE_FACTORY_TRIGGER_CALIB)
> >> +			return;
> >> +		switch2_init_step_done(ns2, NS2_INIT_READ_FACTORY_TRIGGER_CALIB);
> >> +		if (data[0] !=3D 0xFF && data[1] !=3D 0xFF) {
> >> +			ns2->lt_zero =3D data[0];
> >> +			ns2->rt_zero =3D data[1];
> >> +
> >> +			if (ns2->hdev) {
> >> +				hid_dbg(ns2->hdev, "Got factory trigger calibration:\n");
> >> +				hid_dbg(ns2->hdev, "Left zero point: %i\n", ns2->lt_zero);
> >> +				hid_dbg(ns2->hdev, "Right zero point: %i\n", ns2->rt_zero);
> >> +			}
> >> +		} else if (ns2->hdev) {
> >> +			hid_dbg(ns2->hdev, "Factory trigger calibration not present\n");
> >> +		}
> >> +		break;
> >> +	case NS2_FLASH_ADDR_USER_PRIMARY_CALIB:
> >> +		if (size !=3D NS2_FLASH_SIZE_USER_AXIS_CALIB)
> >> +			return;
> >> +		switch2_init_step_done(ns2, NS2_INIT_READ_USER_PRIMARY_CALIB);
> >> +		if (get_unaligned_le16((__le16 *)data) !=3D NS2_USER_CALIB_MAGIC) {=

> >> +			if (ns2->hdev)
> >> +				hid_dbg(ns2->hdev, "No user primary stick calibration present\n")=
;
> >> +			break;
> >> +		}
> >> +
> >> +		ok =3D switch2_parse_stick_calibration(&ns2->stick_calib[0], &data[=
2]);
> >> +		if (ns2->hdev) {
> >> +			if (ok) {
> >> +				hid_dbg(ns2->hdev, "Got user primary stick calibration:\n");
> >> +				hid_dbg(ns2->hdev, "Left max: %i, neutral: %i, right max: %i\n",
> >> +					ns2->stick_calib[0].x.negative,
> >> +					ns2->stick_calib[0].x.neutral,
> >> +					ns2->stick_calib[0].x.positive);
> >> +				hid_dbg(ns2->hdev, "Down max: %i, neutral: %i, up max: %i\n",
> >> +					ns2->stick_calib[0].y.negative,
> >> +					ns2->stick_calib[0].y.neutral,
> >> +					ns2->stick_calib[0].y.positive);
> >> +			} else {
> >> +				hid_dbg(ns2->hdev, "No user primary stick calibration present\n")=
;
> >> +			}
> >> +		}
> >> +		break;
> >> +	case NS2_FLASH_ADDR_USER_SECONDARY_CALIB:
> >> +		if (size !=3D NS2_FLASH_SIZE_USER_AXIS_CALIB)
> >> +			return;
> >> +		switch2_init_step_done(ns2, NS2_INIT_READ_USER_SECONDARY_CALIB);
> >> +		if (get_unaligned_le16((__le16 *)data) !=3D NS2_USER_CALIB_MAGIC) {=

> >> +			if (ns2->hdev)
> >> +				hid_dbg(ns2->hdev, "No user secondary stick calibration present\n=
");
> >> +			break;
> >> +		}
> >> +
> >> +		ok =3D switch2_parse_stick_calibration(&ns2->stick_calib[1], &data[=
2]);
> >> +		if (ns2->hdev) {
> >> +			if (ok) {
> >> +				hid_dbg(ns2->hdev, "Got user secondary stick calibration:\n");
> >> +				hid_dbg(ns2->hdev, "Left max: %i, neutral: %i, right max: %i\n",
> >> +					ns2->stick_calib[1].x.negative,
> >> +					ns2->stick_calib[1].x.neutral,
> >> +					ns2->stick_calib[1].x.positive);
> >> +				hid_dbg(ns2->hdev, "Down max: %i, neutral: %i, up max: %i\n",
> >> +					ns2->stick_calib[1].y.negative,
> >> +					ns2->stick_calib[1].y.neutral,
> >> +					ns2->stick_calib[1].y.positive);
> >> +			} else {
> >> +				hid_dbg(ns2->hdev, "No user secondary stick calibration present\n=
");
> >> +			}
> >> +		}
> >> +		break;
> >=20
> > nit: this break is redundant and could be removed.
>=20
> I always put breaks at the end of switch statements, for
> consistency. I'm pretty sure that's common with C coders, and plenty
> of kernel code does this.
> >> +	}
> >> +}
> >> +
> >> +static void switch2_report_buttons(struct input_dev *input, const uin=
t8_t *bytes,
> >> +	const struct switch2_ctlr_button_mapping button_mappings[])
> >> +{
> >> +	const struct switch2_ctlr_button_mapping *button;
> >> +
> >> +	for (button =3D button_mappings; button->code; button++)
> >> +		input_report_key(input, button->code, bytes[button->byte] & button-=
>bit);
> >> +}
> >> +
> >> +static void switch2_report_axis(struct input_dev *input, struct switc=
h2_axis_calibration *calib,
> >> +	int axis, bool invert, int value)
> >> +{
> >> +	if (calib && calib->neutral && calib->negative && calib->positive) {=

> >> +		value -=3D calib->neutral;
> >> +		value *=3D NS2_AXIS_MAX + 1;
> >> +		if (value < 0)
> >> +			value /=3D calib->negative;
> >=20
> > We might want to make sure that calib->{negative,positive} are not zero=

> > (at calibration parsing time) in order to avoid a div-by-zero issue
>=20
> I could go either way on this. Sure, it'd clean up this side a bit,
> but I don't think it's important enough to iterate this just for that.

It would need some kind of malicious or malfunctioning device reporting
these, so I don't think the risk is very high in practice.

>=20
> >=20
> >> +		else
> >> +			value /=3D calib->positive;
> >> +	} else {
> >> +		value =3D (value - 2048) * 16;
> >> +	}
> >> +
> >> +	if (invert)
> >> +		value =3D -value;
> >> +	input_report_abs(input, axis,
> >> +		clamp(value, NS2_AXIS_MIN, NS2_AXIS_MAX));
> >> +}
> >> +
> >> +static void switch2_report_stick(struct input_dev *input, struct swit=
ch2_stick_calibration *calib,
> >> +	int x, bool invert_x, int y, bool invert_y, const uint8_t *data)
> >> +{
> >> +	switch2_report_axis(input, &calib->x, x, invert_x, data[0] | ((data[=
1] & 0x0F) << 8));
> >> +	switch2_report_axis(input, &calib->y, y, invert_y, (data[1] >> 4) | =
(data[2] << 4));
> >> +}
> >> +
> >> +static void switch2_report_trigger(struct input_dev *input, uint8_t z=
ero, int abs, uint8_t data)
> >> +{
> >> +	int value =3D (NS2_TRIGGER_RANGE + 1) * (data - zero);
> >> +
> >> +	if (zero !=3D 232)
> >> +		value /=3D (232 - zero);
> >> +	input_report_abs(input, abs, clamp(value, 0, NS2_TRIGGER_RANGE));
> >> +}
> >> +
> >> +static int switch2_event(struct hid_device *hdev, struct hid_report *=
report, uint8_t *raw_data,
> >> +	int size)
> >> +{
> >> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
> >> +	struct input_dev *input;
> >> +
> >> +	if (report->type !=3D HID_INPUT_REPORT)
> >> +		return 0;
> >> +
> >> +	if (size < 15)
> >> +		return -EINVAL;
> >> +
> >> +	guard(rcu)();
> >> +	input =3D rcu_dereference(ns2->input);
> >> +
> >> +	if (!input)
> >> +		return 0;
> >> +
> >> +	switch (report->id) {
> >> +	case NS2_REPORT_UNIFIED:
> >> +		/*
> >> +		 * TODO
> >> +		 * This won't be sent unless the report type gets changed via comma=
nd
> >> +		 * 03-0A, but we should support it at some point regardless.
> >> +		 */
> >> +		break;
> >> +	case NS2_REPORT_JCL:
> >> +		switch2_report_stick(input, &ns2->stick_calib[0], ABS_X, false,
> >> +			ABS_Y, true, &raw_data[6]);
> >> +		switch2_report_buttons(input, &raw_data[3], ns2_left_joycon_button_=
mappings);
> >> +		break;
> >> +	case NS2_REPORT_JCR:
> >> +		switch2_report_stick(input, &ns2->stick_calib[0], ABS_X, false,
> >> +			ABS_Y, true, &raw_data[6]);
> >> +		switch2_report_buttons(input, &raw_data[3], ns2_right_joycon_button=
_mappings);
> >> +		break;
> >> +	case NS2_REPORT_GC:
> >> +		input_report_abs(input, ABS_HAT0X,
> >> +			!!(raw_data[4] & NS2_BTNL_RIGHT) -
> >> +			!!(raw_data[4] & NS2_BTNL_LEFT));
> >> +		input_report_abs(input, ABS_HAT0Y,
> >> +			!!(raw_data[4] & NS2_BTNL_DOWN) -
> >> +			!!(raw_data[4] & NS2_BTNL_UP));
> >> +		switch2_report_buttons(input, &raw_data[3], ns2_gccon_mappings);
> >> +		switch2_report_stick(input, &ns2->stick_calib[0], ABS_X, false,
> >> +			ABS_Y, true, &raw_data[6]);
> >> +		switch2_report_stick(input, &ns2->stick_calib[1], ABS_RX, false,
> >> +			ABS_RY, true, &raw_data[9]);
> >> +		switch2_report_trigger(input, ns2->lt_zero, ABS_Z, raw_data[13]);
> >> +		switch2_report_trigger(input, ns2->rt_zero, ABS_RZ, raw_data[14]);
> >> +		break;
> >> +	case NS2_REPORT_PRO:
> >> +		input_report_abs(input, ABS_HAT0X,
> >> +			!!(raw_data[4] & NS2_BTNL_RIGHT) -
> >> +			!!(raw_data[4] & NS2_BTNL_LEFT));
> >> +		input_report_abs(input, ABS_HAT0Y,
> >> +			!!(raw_data[4] & NS2_BTNL_DOWN) -
> >> +			!!(raw_data[4] & NS2_BTNL_UP));
> >> +		switch2_report_buttons(input, &raw_data[3], ns2_procon_mappings);
> >> +		switch2_report_stick(input, &ns2->stick_calib[0], ABS_X, false,
> >> +			ABS_Y, true, &raw_data[6]);
> >> +		switch2_report_stick(input, &ns2->stick_calib[1], ABS_RX, false,
> >> +			ABS_RY, true, &raw_data[9]);
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	input_sync(input);
> >> +	return 0;
> >> +}
> >> +
> >> +static int switch2_features_enable(struct switch2_controller *ns2, in=
t features)
> >> +{
> >> +	__le32 feature_bits =3D __cpu_to_le32(features);
> >> +
> >> +	if (!ns2->cfg)
> >=20
> > From what I can tell switch2_features_enable is only called from
> > switch2_init_controller, which is already checking that ns2->cfg is not=

> > NULL (while holding the ns2->lock). So I would assume that this check i=
s
> > not necessary
>=20
> For now this is the case. In the future we might use it from other
> places to save battery when used wirelessly, e.g. disabling the IMU
> when it's not in use.

Fair enough!

>=20
> >=20
> >> +		return -ENOTCONN;
> >> +	return ns2->cfg->send_command(NS2_CMD_FEATSEL, NS2_SUBCMD_FEATSEL_EN=
ABLE,
> >> +		&feature_bits, sizeof(feature_bits),
> >> +		ns2->cfg);
> >> +}
> >> +
> >> +static int switch2_read_flash(struct switch2_controller *ns2, uint32_=
t address,
> >> +	uint8_t size)
> >> +{
> >> +	uint8_t message[8] =3D { size, 0x7e };
> >> +
> >> +	if (!ns2->cfg)
> >> +		return -ENOTCONN;
> >=20
> > See above.
>=20
> Above wouldn't be the case here. I guess it is redundant, but it's
> a bit of a case of better safe than sorry if it ever does get
> reused. I'd imagine the compiler optimizes it out anyway, as this
> function is small enough to get inlined and have the check eaten by
> common subexpression elimination.
>=20
> >=20
> >> +	put_unaligned_le32(address, &message[4]);
> >> +	return ns2->cfg->send_command(NS2_CMD_FLASH, NS2_SUBCMD_FLASH_READ, =
message,
> >> +		sizeof(message), ns2->cfg);
> >> +}
> >> +
> >> +static int switch2_set_player_id(struct switch2_controller *ns2, uint=
32_t player_id)
> >> +{
> >> +	int i;
> >> +	int player_led_pattern =3D player_id % JC_NUM_LED_PATTERNS;
> >> +
> >> +	for (i =3D 0; i < JC_NUM_LEDS; i++)
> >> +		ns2->leds[i].brightness =3D joycon_player_led_patterns[player_led_p=
attern][i];
> >> +
> >> +	return switch2_set_leds(ns2);
> >> +}
> >> +
> >> +static int switch2_set_report_format(struct switch2_controller *ns2, =
enum switch2_report_id fmt)
> >> +{
> >> +	__le32 format_id =3D __cpu_to_le32(fmt);
> >> +
> >> +	if (!ns2->cfg)
> >> +		return -ENOTCONN;
> >> +	return ns2->cfg->send_command(NS2_CMD_INIT, NS2_SUBCMD_INIT_SELECT_R=
EPORT,
> >> +		&format_id, sizeof(format_id),
> >> +		ns2->cfg);
> >> +}
> >> +
> >> +int switch2_init_controller(struct switch2_controller *ns2)
> >> +{
> >> +	if (ns2->init_step =3D=3D NS2_INIT_DONE)
> >> +		return 0;
> >> +
> >> +	if (!ns2->cfg)
> >> +		return -ENOTCONN;
> >> +
> >> +	if (ns2->init_retries > NS2_MAX_INIT_RETRIES) {
> >> +		if (ns2->init_retries =3D=3D NS2_MAX_INIT_RETRIES + 1) {
> >=20
> > Couldn't we get rid of this if-clause and the ns2->init_retries++ after=

> > it? That would mean we would potentially log the error message earlier
> > but I don't think that would be an issue
>=20
> The point of this is to avoid log spam: this function can get called
> repeatedly after init_retries has exceeded the limit, but we only
> want to log it once. We then increment it one more time to indicate

If reducing the log spam is the goal, this approach seems fine to me.


> it's already been logged so we don't printit further times. The
> other option would be to move the check to the other place where
> init_retries gets incremented, but it's functionally equivalent.
>=20
> >=20
> >=20
> >> +			if (ns2->cfg)
> >=20
> > We check this a few lines up so unless this somehow can get set
> > to NULL again (even though we seem to be holding ns2->lock whenever
> > switch2_init_controller is called) I don't think we need to check this
> > a second time
>=20
> Yeah this is redundant, you're right. I probably got overly paranoid
> while dealing with sashiko's nonsense.

:)

>=20
> >=20
> >> +				dev_err(ns2->cfg->dev, "Failed to configure controller\n");
> >> +			ns2->init_retries++;
> >> +		}
> >> +		return -EIO;
> >> +	}
> >> +
> >> +	ns2->init_retries++;
> >> +	switch (ns2->init_step) {
> >> +	case NS2_INIT_READ_SERIAL:
> >> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_SERIAL,
> >> +			NS2_FLASH_SIZE_SERIAL);
> >> +	case NS2_INIT_GET_FIRMWARE_INFO:
> >> +		return ns2->cfg->send_command(NS2_CMD_FW_INFO, NS2_SUBCMD_FW_INFO_G=
ET,
> >> +			NULL, 0, ns2->cfg);
> >> +	case NS2_INIT_READ_FACTORY_PRIMARY_CALIB:
> >> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_FACTORY_PRIMARY_CALIB=
,
> >> +			NS2_FLASH_SIZE_FACTORY_AXIS_CALIB);
> >> +	case NS2_INIT_READ_FACTORY_SECONDARY_CALIB:
> >> +		if (switch2_ctlr_is_joycon(ns2->ctlr_type)) {
> >> +			switch2_init_step_done(ns2, ns2->init_step);
> >> +			return switch2_init_controller(ns2);
> >> +		}
> >> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_FACTORY_SECONDARY_CAL=
IB,
> >> +			NS2_FLASH_SIZE_FACTORY_AXIS_CALIB);
> >> +	case NS2_INIT_READ_FACTORY_TRIGGER_CALIB:
> >> +		if (ns2->ctlr_type !=3D NS2_CTLR_TYPE_GC) {
> >> +			switch2_init_step_done(ns2, ns2->init_step);
> >> +			return switch2_init_controller(ns2);
> >> +		}
> >> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_FACTORY_TRIGGER_CALIB=
,
> >> +			NS2_FLASH_SIZE_FACTORY_TRIGGER_CALIB);
> >> +	case NS2_INIT_READ_USER_PRIMARY_CALIB:
> >> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_USER_PRIMARY_CALIB,
> >> +			NS2_FLASH_SIZE_USER_AXIS_CALIB);
> >> +	case NS2_INIT_READ_USER_SECONDARY_CALIB:
> >> +		if (switch2_ctlr_is_joycon(ns2->ctlr_type)) {
> >> +			switch2_init_step_done(ns2, ns2->init_step);
> >> +			return switch2_init_controller(ns2);
> >> +		}
> >> +		return switch2_read_flash(ns2, NS2_FLASH_ADDR_USER_SECONDARY_CALIB,=

> >> +			NS2_FLASH_SIZE_USER_AXIS_CALIB);
> >> +	case NS2_INIT_SET_FEATURE_MASK:
> >> +		return ns2->cfg->send_command(NS2_CMD_FEATSEL, NS2_SUBCMD_FEATSEL_S=
ET_MASK,
> >> +			switch2_feature_mask, sizeof(switch2_feature_mask), ns2->cfg);
> >> +	case NS2_INIT_ENABLE_FEATURES:
> >> +		return switch2_features_enable(ns2, NS2_FEATURE_BUTTONS | NS2_FEATU=
RE_ANALOG);
> >> +	case NS2_INIT_GRIP_BUTTONS:
> >> +		if (!switch2_ctlr_is_joycon(ns2->ctlr_type)) {
> >> +			switch2_init_step_done(ns2, ns2->init_step);
> >> +			return switch2_init_controller(ns2);
> >> +		}
> >> +		return ns2->cfg->send_command(NS2_CMD_GRIP, NS2_SUBCMD_GRIP_ENABLE_=
BUTTONS,
> >> +			switch2_one_data, sizeof(switch2_one_data),
> >> +			ns2->cfg);
> >> +	case NS2_INIT_REPORT_FORMAT:
> >> +		switch (ns2->ctlr_type) {
> >> +		case NS2_CTLR_TYPE_JCL:
> >> +			return switch2_set_report_format(ns2, NS2_REPORT_JCL);
> >> +		case NS2_CTLR_TYPE_JCR:
> >> +			return switch2_set_report_format(ns2, NS2_REPORT_JCR);
> >> +		case NS2_CTLR_TYPE_PRO:
> >> +			return switch2_set_report_format(ns2, NS2_REPORT_PRO);
> >> +		case NS2_CTLR_TYPE_GC:
> >> +			return switch2_set_report_format(ns2, NS2_REPORT_GC);
> >> +		default:
> >> +			switch2_init_step_done(ns2, ns2->init_step);
> >> +			return switch2_init_controller(ns2);
> >> +		}
> >> +	case NS2_INIT_INPUT:
> >> +		if (ns2->hdev)
> >> +			return switch2_init_input(ns2);
> >> +		break;
> >> +	case NS2_INIT_SET_PLAYER_LEDS:
> >> +		return switch2_set_player_id(ns2, ns2->player_id);
> >> +	case NS2_INIT_FINISH:
> >> +		return ns2->cfg->send_command(NS2_CMD_INIT, NS2_SUBCMD_INIT_USB,
> >> +			switch2_init_cmd_data, sizeof(switch2_init_cmd_data), ns2->cfg);
> >> +	default:
> >> +		WARN_ON_ONCE(1);
> >> +		break;
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >> +int switch2_receive_command(struct switch2_controller *ns2,
> >> +	const uint8_t *message, size_t length)
> >> +{
> >> +	const struct switch2_cmd_header *header;
> >> +	int ret =3D 0;
> >> +
> >> +	if (length < 8)
> >=20
> > Shouldn't this check for 'length < 9' as otherwise
> >=20
> > message =3D &message[8];
> >=20
> > would index the ninth byte which is out of range (i.e. off-by-one issue=
)?
>=20
> No, 8 byte messages are valid. &message[8] would point to an empty
> message as a result. message[8] is technically the ninth byte if
> present, but when length is 0 it's functionally just an empty array.

Right! When length is 0, no byte will be accessed anymore anyways and
this is fine. Please disregard!

>=20
> >=20
> >=20
> >> +		return -EINVAL;
> >> +
> >> +	print_hex_dump_debug("got cmd: ", DUMP_PREFIX_OFFSET, 16, 1, message=
, length, false);
> >> +
> >> +	mutex_lock(&ns2->lock);
> >> +
> >> +	header =3D (const struct switch2_cmd_header *)message;
> >> +	if (!(header->flags & NS2_FLAG_OK)) {
> >> +		if (ns2->cfg)
> >> +			dev_warn(ns2->cfg->dev, "Packet error %02x replying to command %x:=
%x",
> >> +				header->flags, header->command, header->subcommand);
> >> +		ret =3D -EIO;
> >> +		goto exit;
> >> +	}
> >> +	message =3D &message[8];
> >> +	length -=3D 8;
> >=20
> > Shouldn't this be 'length -=3D 9' (as arrays are zero-indexed)?
>=20
> No, see above. Length becomes 0, which is valid.
>=20
> >=20
> >> +
> >> +	switch (header->command) {
> >> +	case NS2_CMD_FLASH:
> >> +		if (header->subcommand =3D=3D NS2_SUBCMD_FLASH_READ) {
> >> +			uint8_t read_size;
> >> +			uint32_t read_address;
> >> +
> >> +			if (length < 8) {
> >=20
> > Shouldn't this be 'if (length < 9)' as well?
>=20
> No, the original length would be 16 so the message minus the header is st=
ill at least 8 bytes.
>=20
> >=20
> >> +				ret =3D -EINVAL;
> >> +				goto exit;
> >> +			}
> >> +			read_size =3D message[0];
> >> +			read_address =3D get_unaligned_le32(&message[4]);
> >> +			if (length < read_size + 8) {
> >=20
> > Should it check for
> >=20
> > if (length < read_size + 9) {
> >=20
> > as we are taking a pointer to the ninth byte with '&message[8]'?
>=20
> Still no.
>=20
> >=20
> >=20
> >> +				ret =3D -EINVAL;
> >> +				goto exit;
> >> +			}
> >> +			switch2_handle_flash_read(ns2, read_size, read_address, &message[8=
]);
> >> +		}
> >> +		break;
> >> +	case NS2_CMD_INIT:
> >> +		if (header->subcommand =3D=3D NS2_SUBCMD_INIT_USB)
> >> +			switch2_init_step_done(ns2, NS2_INIT_FINISH);
> >> +		else if (header->subcommand =3D=3D NS2_SUBCMD_INIT_SELECT_REPORT)
> >> +			switch2_init_step_done(ns2, NS2_INIT_REPORT_FORMAT);
> >> +		break;
> >> +	case NS2_CMD_GRIP:
> >> +		if (header->subcommand =3D=3D NS2_SUBCMD_GRIP_ENABLE_BUTTONS)
> >> +			switch2_init_step_done(ns2, NS2_INIT_GRIP_BUTTONS);
> >> +		break;
> >> +	case NS2_CMD_LED:
> >> +		if (header->subcommand =3D=3D NS2_SUBCMD_LED_PATTERN)
> >> +			switch2_init_step_done(ns2, NS2_INIT_SET_PLAYER_LEDS);
> >> +		break;
> >> +	case NS2_CMD_FEATSEL:
> >> +		if (header->subcommand =3D=3D NS2_SUBCMD_FEATSEL_SET_MASK)
> >> +			switch2_init_step_done(ns2, NS2_INIT_SET_FEATURE_MASK);
> >> +		else if (header->subcommand =3D=3D NS2_SUBCMD_FEATSEL_ENABLE)
> >> +			switch2_init_step_done(ns2, NS2_INIT_ENABLE_FEATURES);
> >> +		break;
> >> +	case NS2_CMD_FW_INFO:
> >> +		if (header->subcommand =3D=3D NS2_SUBCMD_FW_INFO_GET) {
> >> +			if (length < sizeof(ns2->version)) {
> >> +				ret =3D -EINVAL;
> >> +				goto exit;
> >> +			}
> >> +			memcpy(&ns2->version, message, sizeof(ns2->version));
> >> +			ns2->ctlr_type =3D ns2->version.ctlr_type;
> >> +			switch2_init_step_done(ns2, NS2_INIT_GET_FIRMWARE_INFO);
> >> +		}
> >> +		break;
> >> +	default:
> >> +		break;
> >> +	}
> >> +
> >> +exit:
> >> +	if (ns2->init_step < NS2_INIT_DONE)
> >> +		switch2_init_controller(ns2);
> >> +
> >> +	mutex_unlock(&ns2->lock);
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(switch2_receive_command);
> >> +
> >> +int switch2_controller_attach_cfg(const char *phys, struct switch2_cf=
g_intf *cfg)
> >> +{
> >> +	struct switch2_controller *ns2 =3D switch2_get_controller(phys);
> >> +	int ret =3D 0;
> >> +
> >> +	if (IS_ERR(ns2))
> >> +		return PTR_ERR(ns2);
> >> +
> >> +	mutex_lock(&ns2->lock);
> >> +	if (ns2->cfg) {
> >> +		ret =3D -EBUSY;
> >> +		goto out;
> >> +	}
> >> +	cfg->parent =3D ns2;
> >> +	ns2->cfg =3D cfg;
> >> +
> >> +	if (ns2->hdev)
> >> +		ret =3D switch2_init_controller(ns2);
> >> +
> >> +	if (ret < 0) {
> >> +		cfg->parent =3D NULL;
> >> +		ns2->cfg =3D NULL;
> >> +	}
> >> +
> >> +out:
> >> +	mutex_unlock(&ns2->lock);
> >> +
> >> +	if (ret < 0)
> >> +		kref_put(&ns2->refcount, switch2_kref_put);
> >> +	return ret;
> >> +}
> >> +EXPORT_SYMBOL_GPL(switch2_controller_attach_cfg);
> >> +
> >> +void switch2_controller_detach_cfg(struct switch2_controller *ns2)
> >> +{
> >> +	mutex_lock(&ns2->lock);
> >> +	if (!ns2->cfg || WARN_ON(ns2 !=3D ns2->cfg->parent)) {
> >> +		mutex_unlock(&ns2->lock);
> >> +		return;
> >> +	}
> >> +	ns2->cfg->parent =3D NULL;
> >> +	ns2->cfg =3D NULL;
> >> +	mutex_unlock(&ns2->lock);
> >> +	switch2_controller_put(ns2);
> >> +	kref_put(&ns2->refcount, switch2_kref_put);
> >> +}
> >> +EXPORT_SYMBOL_GPL(switch2_controller_detach_cfg);
> >> +
> >> +static int switch2_probe(struct hid_device *hdev, const struct hid_de=
vice_id *id)
> >> +{
> >> +	struct switch2_controller *ns2;
> >> +	struct usb_device *udev;
> >> +	char phys[64];
> >> +	int ret;
> >> +
> >> +	if (!hid_is_usb(hdev))
> >> +		return -ENODEV;
> >> +
> >> +	udev =3D hid_to_usb_dev(hdev);
> >> +	if (usb_make_path(udev, phys, sizeof(phys)) < 0)
> >> +		return -EINVAL;
> >> +
> >> +	ret =3D hid_parse(hdev);
> >> +	if (ret) {
> >> +		hid_err(hdev, "parse failed %d\n", ret);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ns2 =3D switch2_get_controller(phys);
> >> +	if (IS_ERR(ns2))
> >> +		return PTR_ERR(ns2);
> >> +
> >> +	mutex_lock(&ns2->lock);
> >> +	if (ns2->hdev) {
> >> +		mutex_unlock(&ns2->lock);
> >> +		hid_err(hdev,
> >> +			"Second hdev tried to claim same controller, first=3D%p vs second=3D=
%p\n",
> >> +			ns2->hdev, hdev);
> >> +		kref_put(&ns2->refcount, switch2_kref_put);
> >> +		return -EBUSY;
> >> +	}
> >> +	ns2->hdev =3D hdev;
> >> +	hid_set_drvdata(hdev, ns2);
> >> +
> >> +	switch (hdev->product | (hdev->vendor << 16)) {
> >> +	default:
> >> +		strscpy(ns2->name, hdev->name, sizeof(ns2->name));
> >> +		break;
> >> +	/* Some controllers have slightly wrong names so we override them */=

> >> +	case USB_DEVICE_ID_NINTENDO_NS2_JOYCONR | (USB_VENDOR_ID_NINTENDO <<=
 16):
> >> +		/* Missing the "2" in the name */
> >> +		strscpy(ns2->name, "Nintendo Joy-Con 2 (R)", sizeof(ns2->name));
> >> +		break;
> >> +	case USB_DEVICE_ID_NINTENDO_NS2_GCCON | (USB_VENDOR_ID_NINTENDO << 1=
6):
> >> +		/* Has "Nintendo" in the name twice */
> >> +		strscpy(ns2->name, "Nintendo GameCube Controller", sizeof(ns2->name=
));
> >> +		break;
> >> +	}
> >> +
> >> +	ns2->player_id =3D U32_MAX;
> >> +	ret =3D ida_alloc(&nintendo_player_id_allocator, GFP_KERNEL);
> >> +	if (ret < 0)
> >> +		hid_warn(hdev, "Failed to allocate player ID, skipping; ret=3D%d\n"=
, ret);
> >> +	else
> >> +		ns2->player_id =3D ret;
> >> +
> >> +	ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> >> +	if (ret) {
> >> +		hid_err(hdev, "hw_start failed %d\n", ret);
> >> +		goto err_cleanup;
> >> +	}
> >> +
> >> +	ret =3D hid_hw_open(hdev);
> >> +	if (ret) {
> >> +		hid_err(hdev, "hw_open failed %d\n", ret);
> >> +		goto err_stop;
> >> +	}
> >> +
> >> +	ret =3D 0;
> >> +	if (ns2->cfg)
> >> +		ret =3D switch2_init_controller(ns2);
> >> +
> >> +	if (!ret) {
> >> +		mutex_unlock(&ns2->lock);
> >> +		return 0;
> >> +	}
> >> +
> >> +	hid_hw_close(hdev);
> >> +err_stop:
> >> +	hid_hw_stop(hdev);
> >> +err_cleanup:
> >> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);
> >> +	ns2->hdev =3D NULL;
> >> +	mutex_unlock(&ns2->lock);
> >> +	switch2_controller_put(ns2);
> >> +	kref_put(&ns2->refcount, switch2_kref_put);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static void switch2_remove(struct hid_device *hdev)
> >> +{
> >> +	struct switch2_controller *ns2 =3D hid_get_drvdata(hdev);
> >> +
> >> +	switch2_controller_put(ns2);
> >> +	mutex_lock(&ns2->lock);
> >> +	ns2->hdev =3D NULL;
> >> +	ida_free(&nintendo_player_id_allocator, ns2->player_id);
> >> +	mutex_unlock(&ns2->lock);
> >> +	kref_put(&ns2->refcount, switch2_kref_put);
> >> +	hid_hw_close(hdev);
> >> +	hid_hw_stop(hdev);
> >> +}
> >> +
> >>  static const struct hid_device_id nintendo_hid_devices[] =3D {
> >> +	/* Switch devices */
> >>  	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
> >>  			 USB_DEVICE_ID_NINTENDO_PROCON) },
> >>  	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
> >> @@ -2863,10 +4071,67 @@ static const struct hid_device_id nintendo_hid=
_devices[] =3D {
> >>  			 USB_DEVICE_ID_NINTENDO_N64CON) },
> >>  	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_HORI,
> >>  			 USB_DEVICE_ID_HORI_WIRELESS_SWITCH_PAD) },
> >> +	/* Switch 2 devices */
> >> +	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
> >> +			 USB_DEVICE_ID_NINTENDO_NS2_JOYCONL) },
> >> +	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
> >> +			 USB_DEVICE_ID_NINTENDO_NS2_JOYCONR) },
> >> +	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
> >> +			 USB_DEVICE_ID_NINTENDO_NS2_PROCON) },
> >> +	{ HID_USB_DEVICE(USB_VENDOR_ID_NINTENDO,
> >> +			 USB_DEVICE_ID_NINTENDO_NS2_GCCON) },
> >>  	{ }
> >>  };
> >>  MODULE_DEVICE_TABLE(hid, nintendo_hid_devices);
> >> =20
> >> +static bool nintendo_is_switch2(struct hid_device *hdev)
> >> +{
> >> +	return hdev->vendor =3D=3D USB_VENDOR_ID_NINTENDO &&
> >> +		hdev->product >=3D USB_DEVICE_ID_NINTENDO_NS2_JOYCONR;
> >> +}
> >> +
> >> +static void nintendo_hid_remove(struct hid_device *hdev)
> >> +{
> >> +	if (nintendo_is_switch2(hdev))
> >> +		switch2_remove(hdev);
> >> +	else
> >> +		joycon_remove(hdev);
> >> +}
> >> +
> >> +static int nintendo_hid_event(struct hid_device *hdev,
> >> +			      struct hid_report *report, u8 *raw_data, int size)
> >> +{
> >> +	if (nintendo_is_switch2(hdev))
> >> +		return switch2_event(hdev, report, raw_data, size);
> >> +	else
> >> +		return joycon_event(hdev, report, raw_data, size);
> >> +}
> >> +
> >> +static int nintendo_hid_probe(struct hid_device *hdev,
> >> +			    const struct hid_device_id *id)
> >> +{
> >> +	if (nintendo_is_switch2(hdev))
> >> +		return switch2_probe(hdev, id);
> >> +	else
> >> +		return joycon_probe(hdev, id);
> >> +}
> >> +
> >> +static int nintendo_hid_resume(struct hid_device *hdev)
> >> +{
> >> +	if (nintendo_is_switch2(hdev))
> >> +		return 0;
> >> +	else
> >> +		return joycon_resume(hdev);
> >> +}
> >> +
> >> +static int nintendo_hid_suspend(struct hid_device *hdev, pm_message_t=
 message)
> >> +{
> >> +	if (nintendo_is_switch2(hdev))
> >> +		return 0;
> >> +	else
> >> +		return joycon_suspend(hdev, message);
> >> +}
> >> +
> >>  static struct hid_driver nintendo_hid_driver =3D {
> >>  	.name		=3D "nintendo",
> >>  	.id_table	=3D nintendo_hid_devices,
> >> @@ -2894,4 +4159,5 @@ MODULE_LICENSE("GPL");
> >>  MODULE_AUTHOR("Ryan McClelland <rymcclel@gmail.com>");
> >>  MODULE_AUTHOR("Emily Strickland <linux@emily.st>");
> >>  MODULE_AUTHOR("Daniel J. Ogorchock <djogorchock@gmail.com>");
> >> +MODULE_AUTHOR("Vicki Pfau <vi@endrift.com>");
> >>  MODULE_DESCRIPTION("Driver for Nintendo Switch Controllers");
> >> diff --git a/drivers/hid/hid-nintendo.h b/drivers/hid/hid-nintendo.h
> >> new file mode 100644
> >> index 000000000000..7aff22f30266
> >> --- /dev/null
> >> +++ b/drivers/hid/hid-nintendo.h
> >> @@ -0,0 +1,72 @@
> >> +/* SPDX-License-Identifier: GPL-2.0+ */
> >> +/*
> >> + * HID driver for Nintendo Switch 2 controllers
> >> + *
> >> + * Copyright (c) 2025 Valve Software
> >> + *
> >> + * This driver is based on the following work:
> >> + *   https://gist.github.com/shinyquagsire23/66f006b46c56216acbaac6c1=
e2279b64
> >> + *   https://github.com/ndeadly/switch2_controller_research
> >> + */
> >> +
> >> +#ifndef __HID_NINTENDO_H
> >> +#define __HID_NINTENDO_H
> >> +
> >> +#include <linux/bits.h>
> >> +
> >> +#define NS2_FLAG_OK	BIT(0)
> >> +#define NS2_FLAG_NACK	BIT(2)
> >> +
> >> +enum switch2_cmd {
> >> +	NS2_CMD_NFC =3D 0x01,
> >> +	NS2_CMD_FLASH =3D 0x02,
> >> +	NS2_CMD_INIT =3D 0x03,
> >> +	NS2_CMD_GRIP =3D 0x08,
> >> +	NS2_CMD_LED =3D 0x09,
> >> +	NS2_CMD_VIBRATE =3D 0x0a,
> >> +	NS2_CMD_BATTERY =3D 0x0b,
> >> +	NS2_CMD_FEATSEL =3D 0x0c,
> >> +	NS2_CMD_FW_UPD =3D 0x0d,
> >> +	NS2_CMD_FW_INFO =3D 0x10,
> >> +	NS2_CMD_BT_PAIR =3D 0x15,
> >> +};
> >> +
> >> +enum switch2_direction {
> >> +	NS2_DIR_IN =3D 0x00,
> >> +	NS2_DIR_OUT =3D 0x90,
> >> +};
> >> +
> >> +enum switch2_transport {
> >> +	NS2_TRANS_USB =3D 0x00,
> >> +	NS2_TRANS_BT =3D 0x01,
> >> +};
> >> +
> >> +struct switch2_cmd_header {
> >> +	uint8_t command;
> >> +	uint8_t flags;
> >> +	uint8_t transport;
> >> +	uint8_t subcommand;
> >> +	uint8_t unk1;
> >> +	uint8_t length;
> >> +	uint16_t unk2;
> >> +};
> >> +static_assert(sizeof(struct switch2_cmd_header) =3D=3D 8);
> >> +
> >> +struct device;
> >> +struct switch2_controller;
> >> +struct switch2_cfg_intf {
> >> +	struct switch2_controller *parent;
> >> +	struct device *dev;
> >> +
> >> +	int (*send_command)(enum switch2_cmd command, uint8_t subcommand,
> >> +		const void *message, size_t length,
> >> +		struct switch2_cfg_intf *intf);
> >> +};
> >> +
> >> +int switch2_controller_attach_cfg(const char *phys, struct switch2_cf=
g_intf *cfg);
> >> +void switch2_controller_detach_cfg(struct switch2_controller *control=
ler);
> >> +
> >> +int switch2_receive_command(struct switch2_controller *controller,
> >> +	const uint8_t *message, size_t length);
> >> +
> >> +#endif
> >> diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/K=
config
> >> index 7755e5b454d2..868262c6ccd9 100644
> >> --- a/drivers/input/joystick/Kconfig
> >> +++ b/drivers/input/joystick/Kconfig
> >> @@ -422,4 +422,15 @@ config JOYSTICK_SEESAW
> >>  	  To compile this driver as a module, choose M here: the module will=
 be
> >>  	  called adafruit-seesaw.
> >> =20
> >> +config JOYSTICK_NINTENDO_SWITCH2_USB
> >> +	tristate "Wired Nintendo Switch 2 controller support"
> >> +	depends on HID_NINTENDO
> >> +	depends on USB
> >> +	help
> >> +	  Say Y here if you want to enable support for wired Nintendo Switch=
 2
> >> +	  controllers.
> >> +
> >> +	  To compile this driver as a module, choose M here: the
> >> +	  module will be called nintendo-switch2-usb.
> >> +
> >>  endif
> >> diff --git a/drivers/input/joystick/Makefile b/drivers/input/joystick/=
Makefile
> >> index 9976f596a920..8f92900ae885 100644
> >> --- a/drivers/input/joystick/Makefile
> >> +++ b/drivers/input/joystick/Makefile
> >> @@ -34,6 +34,7 @@ obj-$(CONFIG_JOYSTICK_SIDEWINDER)	+=3D sidewinder.o
> >>  obj-$(CONFIG_JOYSTICK_SPACEBALL)	+=3D spaceball.o
> >>  obj-$(CONFIG_JOYSTICK_SPACEORB)		+=3D spaceorb.o
> >>  obj-$(CONFIG_JOYSTICK_STINGER)		+=3D stinger.o
> >> +obj-$(CONFIG_JOYSTICK_NINTENDO_SWITCH2_USB)	+=3D nintendo-switch2-usb=
.o
> >>  obj-$(CONFIG_JOYSTICK_TMDC)		+=3D tmdc.o
> >>  obj-$(CONFIG_JOYSTICK_TURBOGRAFX)	+=3D turbografx.o
> >>  obj-$(CONFIG_JOYSTICK_TWIDJOY)		+=3D twidjoy.o
> >> diff --git a/drivers/input/joystick/nintendo-switch2-usb.c b/drivers/i=
nput/joystick/nintendo-switch2-usb.c
> >> new file mode 100644
> >> index 000000000000..a6999a0a26ae
> >> --- /dev/null
> >> +++ b/drivers/input/joystick/nintendo-switch2-usb.c
> >> @@ -0,0 +1,468 @@
> >> +// SPDX-License-Identifier: GPL-2.0+
> >> +/*
> >> + * USB driver for Nintendo Switch 2 controllers configuration interfa=
ce
> >> + *
> >> + * Copyright (c) 2025 Valve Software
> >> + *
> >> + * This driver is based on the following work:
> >> + *   https://gist.github.com/shinyquagsire23/66f006b46c56216acbaac6c1=
e2279b64
> >> + *   https://github.com/ndeadly/switch2_controller_research
> >> + */
> >> +
> >> +#include "../../hid/hid-ids.h"
> >> +#include "../../hid/hid-nintendo.h"
> >> +#include <linux/module.h>
> >> +#include <linux/usb/input.h>
> >> +
> >> +#define NS2_BULK_SIZE 64
> >> +#define NS2_IN_URBS 2
> >> +#define NS2_OUT_URBS 4
> >> +
> >> +static struct usb_driver switch2_usb;
> >> +
> >> +enum switch2_urb_state {
> >> +	NS2_URB_FREE,
> >> +	NS2_URB_OUT,
> >> +	NS2_URB_IN,
> >> +};
> >> +
> >> +struct switch2_urb {
> >> +	struct urb *urb;
> >> +	uint8_t *data;
> >> +	enum switch2_urb_state state;
> >> +};
> >> +
> >> +struct switch2_usb {
> >> +	struct switch2_cfg_intf cfg;
> >> +	struct usb_device *udev;
> >> +
> >> +	struct switch2_urb bulk_in[NS2_IN_URBS];
> >> +	struct usb_anchor bulk_in_anchor;
> >> +	bool shutdown;
> >> +	spinlock_t bulk_in_lock;
> >> +
> >> +	struct switch2_urb bulk_out[NS2_OUT_URBS];
> >> +	struct usb_anchor bulk_out_anchor;
> >> +	spinlock_t bulk_out_lock;
> >> +
> >> +	struct work_struct message_in_work;
> >> +};
> >> +
> >> +static void switch2_bulk_in(struct urb *urb)
> >> +{
> >> +	struct switch2_usb *ns2_usb =3D urb->context;
> >> +	int i;
> >> +	bool schedule =3D false;
> >> +	unsigned long flags;
> >> +
> >> +	switch (urb->status) {
> >> +	case 0:
> >> +		schedule =3D true;
> >> +		break;
> >> +	case -ECONNRESET:
> >> +	case -ENOENT:
> >> +	case -ESHUTDOWN:
> >> +	case -EPIPE:
> >> +		break;
> >> +	default:
> >> +		dev_dbg(&ns2_usb->udev->dev, "unknown input urb status: %d\n", urb-=
>status);
> >> +		break;
> >> +	}
> >> +
> >> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> >> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> >> +		int err;
> >> +		struct switch2_urb *ns2_urb;
> >> +
> >> +		if (ns2_usb->bulk_in[i].urb =3D=3D urb) {
> >> +			if (schedule) {
> >> +				ns2_usb->bulk_in[i].state =3D NS2_URB_IN;
> >> +				continue;
> >> +			} else {
> >=20
> > nit: this else is redundant as we are continue-ing above anyways.
>=20
> Below you mean? I guess technically, yeah.
>=20
> >=20
> >> +				ns2_usb->bulk_in[i].state =3D NS2_URB_FREE;
> >> +			}
> >> +		}
> >> +
> >> +		if (ns2_usb->bulk_in[i].state !=3D NS2_URB_FREE)
> >> +			continue;
> >> +
> >> +		/*
> >> +		 * We want exactly one bulk in URB scheduled at a time, so only
> >> +		 * reschedule this immediately if nothing else is scheduled
> >> +		 * currently.
> >> +		 */
> >> +		if (!usb_anchor_empty(&ns2_usb->bulk_in_anchor) || ns2_usb->shutdow=
n)
> >> +			continue;
> >> +
> >> +		ns2_urb =3D &ns2_usb->bulk_in[i];
> >> +		if (!ns2_urb)
> >=20
> > AFAICT ns2_urb will never be NULL here so we can remove this check.
>=20
> This is kind of a result of dealing with sashiko's obsession with
> hypothetical concurrency bugs. I would have to think way too hard to
> figure out if it's conceivably possible compared to whatever sashiko
> spits out so if I can get it to shut up it's worth it to me. Worst
> case scenario it will never trigger, so it's harmless.

It is somewhat confusing for the reader of the code, but I'm fine
either way.

>=20
> >=20
> >> +			continue;
> >> +
> >> +		usb_anchor_urb(ns2_urb->urb, &ns2_usb->bulk_in_anchor);
> >> +		err =3D usb_submit_urb(ns2_urb->urb, GFP_ATOMIC);
> >> +		if (err) {
> >> +			usb_unanchor_urb(ns2_urb->urb);
> >> +			dev_dbg(&ns2_usb->udev->dev, "failed to queue input urb: %d\n", er=
r);
> >> +		} else {
> >> +			ns2_urb->state =3D NS2_URB_OUT;
> >> +		}
> >> +	}
> >> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> >> +
> >> +	if (schedule)
> >> +		schedule_work(&ns2_usb->message_in_work);
> >> +}
> >> +
> >> +static void switch2_bulk_out(struct urb *urb)
> >> +{
> >> +	struct switch2_usb *ns2_usb =3D urb->context;
> >> +	int i;
> >> +
> >> +	guard(spinlock_irqsave)(&ns2_usb->bulk_out_lock);
> >> +
> >> +	switch (urb->status) {
> >> +	case 0:
> >> +		break;
> >> +	case -ECONNRESET:
> >> +	case -ENOENT:
> >> +	case -ESHUTDOWN:
> >> +	case -EPIPE:
> >> +		break;
> >> +	default:
> >> +		dev_dbg(&ns2_usb->udev->dev, "unknown output urb status: %d\n", urb=
->status);
> >> +		break;
> >> +	}
> >> +
> >> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> >> +		if (ns2_usb->bulk_out[i].urb !=3D urb)
> >> +			continue;
> >> +
> >> +		ns2_usb->bulk_out[i].state =3D NS2_URB_FREE;
> >> +		break;
> >> +	}
> >> +}
> >> +
> >> +static int switch2_usb_send_cmd(enum switch2_cmd command, uint8_t sub=
command,
> >> +	const void *message, size_t size, struct switch2_cfg_intf *cfg)
> >> +{
> >> +	struct switch2_usb *ns2_usb =3D (struct switch2_usb *)cfg;
> >> +	struct switch2_urb *urb =3D NULL;
> >> +	int i;
> >> +	int ret;
> >> +	unsigned long flags;
> >> +
> >> +	struct switch2_cmd_header header =3D {
> >> +		command, NS2_DIR_OUT | NS2_FLAG_OK, NS2_TRANS_USB, subcommand, 0, s=
ize
> >> +	};
> >> +
> >> +	if (WARN_ON(size > 56))
> >> +		return -EINVAL;
> >> +
> >> +	spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
> >> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> >> +		if (ns2_usb->bulk_out[i].state !=3D NS2_URB_FREE)
> >> +			continue;
> >> +
> >> +		urb =3D &ns2_usb->bulk_out[i];
> >> +		urb->state =3D NS2_URB_OUT;
> >> +		break;
> >> +	}
> >> +	spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
> >> +
> >> +	if (!urb) {
> >> +		dev_warn(&ns2_usb->udev->dev, "output queue full, dropping message\=
n");
> >> +		return -ENOBUFS;
> >> +	}
> >> +
> >> +	memcpy(urb->data, &header, sizeof(header));
> >> +	if (message && size)
> >> +		memcpy(&urb->data[8], message, size);
> >> +	urb->urb->transfer_buffer_length =3D size + sizeof(header);
> >> +
> >> +	print_hex_dump_debug("sending cmd: ", DUMP_PREFIX_OFFSET, 16, 1, urb=
->data,
> >> +		size + sizeof(header), false);
> >> +
> >> +	usb_anchor_urb(urb->urb, &ns2_usb->bulk_out_anchor);
> >> +	ret =3D usb_submit_urb(urb->urb, GFP_KERNEL);
> >> +	if (ret) {
> >> +		if (ret !=3D -ENODEV)
> >> +			dev_warn(&ns2_usb->udev->dev, "failed to submit output urb: %i", r=
et);
> >> +		spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
> >> +		urb->state =3D NS2_URB_FREE;
> >> +		spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
> >> +		usb_unanchor_urb(urb->urb);
> >> +		return ret;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void switch2_usb_message_in_work(struct work_struct *work)
> >> +{
> >> +	struct switch2_usb *ns2_usb =3D container_of(work, struct switch2_us=
b, message_in_work);
> >> +	struct switch2_urb *urb;
> >> +	int err;
> >> +	int i;
> >> +	unsigned long flags;
> >> +
> >> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> >> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> >> +		urb =3D &ns2_usb->bulk_in[i];
> >> +		if (urb->state !=3D NS2_URB_IN)
> >> +			continue;
> >> +		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> >> +
> >> +		if (ns2_usb->cfg.parent) {
> >> +			err =3D switch2_receive_command(ns2_usb->cfg.parent,
> >> +				urb->urb->transfer_buffer, urb->urb->actual_length);
> >> +			if (err)
> >> +				dev_dbg(&ns2_usb->udev->dev, "receive command failed: %d\n", err)=
;
> >> +		} else {
> >> +			dev_err(&ns2_usb->udev->dev,
> >> +				"Got message before controller is fully set up; discarding\n");
> >> +		}
> >> +
> >> +		spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> >> +		urb->state =3D NS2_URB_FREE;
> >> +		/*
> >> +		 * We want exactly one bulk in URB scheduled at a time, so only
> >> +		 * reschedule this immediately if nothing else is scheduled
> >> +		 * currently.
> >> +		 */
> >> +		if (!usb_anchor_empty(&ns2_usb->bulk_in_anchor) || ns2_usb->shutdow=
n)
> >> +			continue;
> >> +
> >> +		usb_anchor_urb(urb->urb, &ns2_usb->bulk_in_anchor);
> >> +		err =3D usb_submit_urb(urb->urb, GFP_ATOMIC);
> >> +		if (err) {
> >> +			usb_unanchor_urb(urb->urb);
> >> +			dev_dbg(&ns2_usb->udev->dev,
> >> +				"failed to queue input urb: %d\n", err);
> >> +		} else {
> >> +			urb->state =3D NS2_URB_OUT;
> >> +		}
> >> +	}
> >> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> >> +}
> >> +
> >> +static int switch2_usb_probe(struct usb_interface *intf, const struct=
 usb_device_id *id)
> >> +{
> >> +	struct switch2_usb *ns2_usb;
> >> +	struct usb_device *udev;
> >> +	struct usb_endpoint_descriptor *bulk_in, *bulk_out;
> >> +	struct urb *urb;
> >> +	uint8_t *data;
> >> +	char phys[64];
> >> +	int ret;
> >> +	int i;
> >> +	unsigned long flags;
> >> +
> >> +	udev =3D interface_to_usbdev(intf);
> >> +	if (usb_make_path(udev, phys, sizeof(phys)) < 0)
> >> +		return -EINVAL;
> >> +
> >> +	ret =3D usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &b=
ulk_out, NULL, NULL);
> >> +	if (ret) {
> >> +		dev_err(&intf->dev, "failed to find bulk EPs\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	ns2_usb =3D devm_kzalloc(&intf->dev, sizeof(*ns2_usb), GFP_KERNEL);
> >> +	if (!ns2_usb)
> >> +		return -ENOMEM;
> >> +
> >> +	init_usb_anchor(&ns2_usb->bulk_out_anchor);
> >> +	spin_lock_init(&ns2_usb->bulk_out_lock);
> >> +	init_usb_anchor(&ns2_usb->bulk_in_anchor);
> >> +	spin_lock_init(&ns2_usb->bulk_in_lock);
> >> +	INIT_WORK(&ns2_usb->message_in_work, switch2_usb_message_in_work);
> >> +
> >> +	ns2_usb->udev =3D udev;
> >> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> >> +		urb =3D usb_alloc_urb(0, GFP_KERNEL);
> >> +		if (!urb) {
> >> +			ret =3D -ENOMEM;
> >> +			goto err_free_in;
> >> +		}
> >> +
> >> +		data =3D usb_alloc_coherent(udev, NS2_BULK_SIZE, GFP_KERNEL,
> >> +			&urb->transfer_dma);
> >> +		if (!data) {
> >> +			usb_free_urb(urb);
> >> +			ret =3D -ENOMEM;
> >> +			goto err_free_in;
> >> +		}
> >> +
> >> +		spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> >> +		usb_fill_bulk_urb(urb, udev,
> >> +			usb_rcvbulkpipe(udev, bulk_in->bEndpointAddress),
> >> +			data, NS2_BULK_SIZE, switch2_bulk_in, ns2_usb);
> >> +		urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> >> +
> >> +		ns2_usb->bulk_in[i].urb =3D urb;
> >> +		ns2_usb->bulk_in[i].data =3D data;
> >> +		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> >> +	}
> >> +
> >> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> >> +		urb =3D usb_alloc_urb(0, GFP_KERNEL);
> >> +		if (!urb) {
> >> +			ret =3D -ENOMEM;
> >> +			goto err_free_out;
> >> +		}
> >> +
> >> +		data =3D usb_alloc_coherent(udev, NS2_BULK_SIZE, GFP_KERNEL,
> >> +			&urb->transfer_dma);
> >> +		if (!data) {
> >> +			usb_free_urb(urb);
> >> +			ret =3D -ENOMEM;
> >> +			goto err_free_out;
> >> +		}
> >> +
> >> +		spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
> >> +		usb_fill_bulk_urb(urb, udev,
> >> +			usb_sndbulkpipe(udev, bulk_out->bEndpointAddress),
> >> +			data, NS2_BULK_SIZE, switch2_bulk_out, ns2_usb);
> >> +		urb->transfer_flags |=3D URB_NO_TRANSFER_DMA_MAP;
> >> +
> >> +		ns2_usb->bulk_out[i].urb =3D urb;
> >> +		ns2_usb->bulk_out[i].data =3D data;
> >> +		spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
> >> +	}
> >> +
> >> +	usb_set_intfdata(intf, ns2_usb);
> >> +
> >> +	ns2_usb->cfg.dev =3D &ns2_usb->udev->dev;
> >> +	ns2_usb->cfg.send_command =3D switch2_usb_send_cmd;
> >> +
> >> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> >> +	ns2_usb->bulk_in[0].state =3D NS2_URB_OUT;
> >> +	usb_anchor_urb(ns2_usb->bulk_in[0].urb, &ns2_usb->bulk_in_anchor);
> >> +	ret =3D usb_submit_urb(ns2_usb->bulk_in[0].urb, GFP_ATOMIC);
> >> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> >> +
> >> +	if (ret < 0)
> >> +		goto err_free_out;
> >> +
> >> +	ret =3D switch2_controller_attach_cfg(phys, &ns2_usb->cfg);
> >> +	if (ret < 0)
> >> +		goto err_free_out;
> >> +
> >> +	return 0;
> >> +
> >> +err_free_out:
> >> +	usb_kill_anchored_urbs(&ns2_usb->bulk_out_anchor);
> >> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> >> +		spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
> >> +		urb =3D ns2_usb->bulk_out[i].urb;
> >> +		data =3D ns2_usb->bulk_out[i].data;
> >> +		if (!urb) {
> >> +			spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
> >> +			continue;
> >> +		}
> >> +
> >> +		ns2_usb->bulk_out[i].urb =3D NULL;
> >> +		ns2_usb->bulk_out[i].data =3D NULL;
> >> +		spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
> >> +
> >> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, data, urb->transfer=
_dma);
> >> +		usb_free_urb(urb);
> >> +	}
> >> +err_free_in:
> >> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> >> +	ns2_usb->shutdown =3D true;
> >> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> >> +
> >> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
> >> +	cancel_work_sync(&ns2_usb->message_in_work);
> >> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> >> +		spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> >> +		urb =3D ns2_usb->bulk_in[i].urb;
> >> +		data =3D ns2_usb->bulk_in[i].data;
> >> +		if (!urb) {
> >> +			spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> >> +			continue;
> >> +		}
> >> +
> >> +		ns2_usb->bulk_in[i].urb =3D NULL;
> >> +		ns2_usb->bulk_in[i].data =3D NULL;
> >> +		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> >> +
> >> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, data, urb->transfer=
_dma);
> >> +		usb_free_urb(urb);
> >> +	}
> >> +	devm_kfree(&intf->dev, ns2_usb);
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static void switch2_usb_disconnect(struct usb_interface *intf)
> >> +{
> >> +	struct switch2_usb *ns2_usb =3D usb_get_intfdata(intf);
> >> +	unsigned long flags;
> >> +	struct urb *urb;
> >> +	uint8_t *data;
> >> +	int i;
> >> +
> >> +	/* Prevent any further IN URBs from being scheduled */
> >> +	spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> >> +	ns2_usb->shutdown =3D true;
> >> +	spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> >> +
> >> +	usb_kill_anchored_urbs(&ns2_usb->bulk_in_anchor);
> >> +	cancel_work_sync(&ns2_usb->message_in_work);
> >> +	for (i =3D 0; i < NS2_IN_URBS; i++) {
> >> +		spin_lock_irqsave(&ns2_usb->bulk_in_lock, flags);
> >> +		urb =3D ns2_usb->bulk_in[i].urb;
> >=20
> > In other clean-up cases we are checking this to be NULL. We might have
> > to do so here as well unless we know that it will never be NULL on
> > switch2_usb_disconnect (otherwise we will have a NULL pointer deref a
> > few lines down).
>=20
> This is the only place where it can become NULL and it's not called
> more than once. In the cleanup cases in probe it's because they hadn't
> become not NULL yet, but if they do they will never become NULL again
> until here. We only go through this list once (it's freed after this
> returns due to devres allocation), so it's not an issue.

Thanks for the explanation!

>=20
> >=20
> >> +		data =3D ns2_usb->bulk_in[i].data;
> >> +		ns2_usb->bulk_in[i].urb =3D NULL;
> >> +		ns2_usb->bulk_in[i].data =3D NULL;
> >> +		spin_unlock_irqrestore(&ns2_usb->bulk_in_lock, flags);
> >> +
> >> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, data, urb->transfer=
_dma);
> >> +		usb_free_urb(urb);
> >> +	}
> >> +
> >> +	/*
> >> +	 * We need to detach *before* we kill the out URBs to make sure no
> >> +	 * further URBs get scheduled by the HID endpoint in the meantime.
> >> +	 */
> >> +	switch2_controller_detach_cfg(ns2_usb->cfg.parent);
> >> +
> >> +	usb_kill_anchored_urbs(&ns2_usb->bulk_out_anchor);
> >> +	for (i =3D 0; i < NS2_OUT_URBS; i++) {
> >> +		spin_lock_irqsave(&ns2_usb->bulk_out_lock, flags);
> >> +		urb =3D ns2_usb->bulk_out[i].urb;
> >=20
> > See above.
>=20
> See above.
>=20
> >=20
> >> +		data =3D ns2_usb->bulk_out[i].data;
> >> +		ns2_usb->bulk_out[i].urb =3D NULL;
> >> +		ns2_usb->bulk_out[i].data =3D NULL;
> >> +		spin_unlock_irqrestore(&ns2_usb->bulk_out_lock, flags);
> >> +
> >> +		usb_free_coherent(ns2_usb->udev, NS2_BULK_SIZE, data, urb->transfer=
_dma);
> >> +		usb_free_urb(urb);
> >> +	}
> >> +}
> >> +
> >> +#define SWITCH2_CONTROLLER(vend, prod) \
> >> +	USB_DEVICE_AND_INTERFACE_INFO(vend, prod, USB_CLASS_VENDOR_SPEC, 0, =
0)
> >> +
> >> +static const struct usb_device_id switch2_usb_devices[] =3D {
> >> +	{ SWITCH2_CONTROLLER(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_=
NS2_JOYCONL) },
> >> +	{ SWITCH2_CONTROLLER(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_=
NS2_JOYCONR) },
> >> +	{ SWITCH2_CONTROLLER(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_=
NS2_PROCON) },
> >> +	{ SWITCH2_CONTROLLER(USB_VENDOR_ID_NINTENDO, USB_DEVICE_ID_NINTENDO_=
NS2_GCCON) },
> >> +	{ }
> >> +};
> >> +MODULE_DEVICE_TABLE(usb, switch2_usb_devices);
> >> +
> >> +static struct usb_driver switch2_usb =3D {
> >> +	.name		=3D "nintendo-switch2",
> >> +	.id_table	=3D switch2_usb_devices,
> >> +	.probe		=3D switch2_usb_probe,
> >> +	.disconnect	=3D switch2_usb_disconnect,
> >> +};
> >> +module_usb_driver(switch2_usb);
> >> +
> >> +MODULE_LICENSE("GPL");
> >> +MODULE_AUTHOR("Vicki Pfau <vi@endrift.com>");
> >> +MODULE_DESCRIPTION("Driver for Nintendo Switch 2 Controllers");
> >=20
> > Thanks for all the work on this!
> >=20
> > Cheers,
> > Silvan
>=20
> Vicki

with this, this series is

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>

I have also tested the Switch 2 Pro controller functionality with
"evtest". So that part is also

Tested-by: Silvan Jegen <s.jegen@gmail.com>

I have tried to test the force-feedback functionality with "fftest" as
well. I only had partial success, but I assume this is due to my lack
of knowledge about how force-feedback and/or "fftest" works on Linux.

Cheers,
Silvan
