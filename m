Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5E199D8
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 23:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862471; cv=none; b=EdmvHSuevZubCeAflmvRu5ogGP7enq2pxflcR4L6tN9RH5zLTOuD+0URLYWwW+54dfh9YCl8j/4rtRb6S/zWozL8s2eN936CForzLu8YH/Y7a1SVaBEueTrwyuCf6Z+aBRtb64BlGyqTAusV/qKZ7JEpCjePAc4LssCa3dEjIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862471; c=relaxed/simple;
	bh=20PLqPpyfyLY9581er7CVgbvh5rydTKebWNvzyDTgUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oWx4FvE+WfeRirsNCCbtaDhP7Kac4nmtvZ85wgRMGe46KXlBpRdCGEiYCITgVtfb35rgpxoVWF7ga7EK5LgGf8CTKKMsuHCodvM/zyhAZoYl2qL3eqOi/Itqf7CSMwWVeBZvelip2WlHsrks1dh1qpdbdKrN2Vf3YNyzUHSV24w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUmZApbM; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUmZApbM"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493bc8fda98so270145e9.0
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 16:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782862465; x=1783467265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0MdygMayZBOVO887Wq9zJPKr4JAp61ap8fAwnld5WA0=;
        b=UUmZApbMcWD69YZtmgOolwGR3JaK3R81Ewc1c46QuTHHqwP7oxJE0ioqsvH1LEdeOT
         bi5A9MKjb0xPvdJVO42oYYjObDXUtC/zitji0ySMVbTZuCcOTlAjZN4qS0HmwKVEoIcI
         5CxzGqCH2/g8rS6ojzk1OJMS9i6uuac2nLa5daD7m9UwkqzL5OBgiMZ+7VNY1Kiy/V9p
         is1KlEb9hcgIY+7nJUXdCrmwyIhuoESloJfW+7h+jNI9mgLNLsbpYaodNjQmDNa3NJaA
         ThvKZEIRujnf1VEyV1nP51fhBs8lCFr5/gOVNIvLHppqHdhRNQccibfLRAyx22qUkNuP
         VFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782862465; x=1783467265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MdygMayZBOVO887Wq9zJPKr4JAp61ap8fAwnld5WA0=;
        b=C4WXyDvdoc12u/USf0G96GtHo2W69V8t4gVHOV18FgJTOMAB3eiE222MU70SATrl6J
         sx9bCt4FN05MHCqcgJo9uhkBfAFsR7yIgQoE40I+c5XU1I6pr+qDuBnzkiAo//zfpja3
         Q+c5OBZDxZSs9CZoc1p7oNHnymuRLx88jC0pr+pcv3K8dMMkXSGPhJgDXPWIZW2YoDjN
         K67kmkRJfHJyddfyldND0GrBvNHbQQHqsgK0bzQGN4jcFsJjWzVPlvOXwqF7p8YpYOzQ
         jAz2mTfvTpsWwjPHNa2C8z/cY1fwIXz2x51ckBNi3Utf9Jbmi1SNi8kCBfcXub9H5fFt
         DtLg==
X-Gm-Message-State: AOJu0YwzKjkKimVD4zfslYi59iWIFmPs9rlhcTXQUKej3V++X+bkWDsh
	sO/oOjeO5jEFDKKFKJ+lJFHYUpPl1N1HoAsXMjGPq2S/ZfKcyciNaJhV
X-Gm-Gg: AfdE7cksPqtdSsE11Sr+ll26VOTjS4KXZmFZ8b3N/Z74Xo55qVmKhvAr2hQPR4ztvuM
	sQ+UGhnsayRTBc4x7cyv0N/dq69EQ0wuXQ7ZJGFd6JK7XQvoc+holfgNd4jkSFDE1fuzyxoBNrQ
	/q5bixU+b2b337pZnojTEG8tkX0eLZDFBwDgXZpaaPzuiwxmAXFbX+xvonqGGR6NbSlf2vbqhVk
	b4GLtYuCpM3ts1bx1M7ddsPELZ08q5NZBbjLACwFLFGr0shTeuMVV1JVygs/HBslPsNSuclGiPx
	aAxy0vY+AQvaCpxteVL74FhLXzZ+WcX0LBIWJyYKE8XYtvVBt+r4i084SHNrGiPPrxTGcCP3HWR
	W+ci5bwTyM+qlYsITBzcOl41cT8UJ0p1WKOuPfYmFnJmc6nrujulJuqULWaTm1rnzdllXMnSdLG
	B5Xhix41pT8qKWRHb2WjH3PKQEx1gu0B/JyyR8ypWC2UlScOoF83I=
X-Received: by 2002:a05:600c:8411:b0:493:a893:1200 with SMTP id 5b1f17b1804b1-493b82815d4mr71849705e9.5.1782862464121;
        Tue, 30 Jun 2026 16:34:24 -0700 (PDT)
Received: from nixos-office ([2001:8a0:e962:d100:42af:a70c:10b8:87c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef183e7sm24797975e9.2.2026.06.30.16.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 16:34:23 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH v3] HID: cleanup help indentation in kconfig
Date: Wed,  1 Jul 2026 00:34:16 +0100
Message-ID: <20260630233416.520117-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The indentation in this kconfig was all over the place:
Half of the 'help' texts were not indented, while the other
half indented by the more standard 2 spaces shown in the
kconfig documentation.

Let's standardize to 2 spaces.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
v3: fix even more lines' indentation (sashiko, again)
Link to v2:
https://lore.kernel.org/all/20260630150134.514348-1-julianbraha@gmail.com/

v2: fix 2 more lines' indentation, thanks sashiko
Link to v1:
https://lore.kernel.org/all/20260630142043.496559-1-julianbraha@gmail.com/


 drivers/hid/Kconfig | 662 ++++++++++++++++++++++----------------------
 1 file changed, 331 insertions(+), 331 deletions(-)

diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index f9bcaeb66385..9f72b8b5966b 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -38,77 +38,77 @@ config HID_BATTERY_STRENGTH
 	select POWER_SUPPLY
 	default n
 	help
-	This option adds support of reporting battery strength (for HID devices
-	that support this feature) through power_supply class so that userspace
-	tools, such as upower, can display it.
+	  This option adds support of reporting battery strength (for HID devices
+	  that support this feature) through power_supply class so that userspace
+	  tools, such as upower, can display it.
 
 config HIDRAW
 	bool "/dev/hidraw raw HID device support"
 	help
-	Say Y here if you want to support HID devices (from the USB
-	specification standpoint) that aren't strictly user interface
-	devices, like monitor controls and Uninterruptible Power Supplies.
+	  Say Y here if you want to support HID devices (from the USB
+	  specification standpoint) that aren't strictly user interface
+	  devices, like monitor controls and Uninterruptible Power Supplies.
 
-	This module supports these devices separately using a separate
-	event interface on /dev/hidraw.
+	  This module supports these devices separately using a separate
+	  event interface on /dev/hidraw.
 
-	There is also a /dev/hiddev configuration option in the USB HID
-	configuration menu. In comparison to hiddev, this device does not process
-	the hid events at all (no parsing, no lookups). This lets applications
-	to work on raw hid events when they want to, and avoid using transport-specific
-	userspace libhid/libusb libraries.
+	  There is also a /dev/hiddev configuration option in the USB HID
+	  configuration menu. In comparison to hiddev, this device does not process
+	  the hid events at all (no parsing, no lookups). This lets applications
+	  to work on raw hid events when they want to, and avoid using transport-specific
+	  userspace libhid/libusb libraries.
 
-	If unsure, say Y.
+	  If unsure, say Y.
 
 config UHID
 	tristate "User-space I/O driver support for HID subsystem"
 	default n
 	help
-	Say Y here if you want to provide HID I/O Drivers from user-space.
-	This allows to write I/O drivers in user-space and feed the data from
-	the device into the kernel. The kernel parses the HID reports, loads the
-	corresponding HID Device Driver or provides input devices on top of your
-	user-space device.
+	  Say Y here if you want to provide HID I/O Drivers from user-space.
+	  This allows to write I/O drivers in user-space and feed the data from
+	  the device into the kernel. The kernel parses the HID reports, loads the
+	  corresponding HID Device Driver or provides input devices on top of your
+	  user-space device.
 
-	This driver cannot be used to parse HID-reports in user-space and write
-	special HID-drivers. You should use hidraw for that.
-	Instead, this driver allows to write the transport-layer driver in
-	user-space like USB-HID and Bluetooth-HID do in kernel-space.
+	  This driver cannot be used to parse HID-reports in user-space and write
+	  special HID-drivers. You should use hidraw for that.
+	  Instead, this driver allows to write the transport-layer driver in
+	  user-space like USB-HID and Bluetooth-HID do in kernel-space.
 
-	If unsure, say N.
+	  If unsure, say N.
 
-	To compile this driver as a module, choose M here: the
-	module will be called uhid.
+	  To compile this driver as a module, choose M here: the
+	  module will be called uhid.
 
 config HID_GENERIC
 	tristate "Generic HID driver"
 	default HID
 	help
-	Support for generic devices on the HID bus. This includes most
-	keyboards and mice, joysticks, tablets and digitizers.
+	  Support for generic devices on the HID bus. This includes most
+	  keyboards and mice, joysticks, tablets and digitizers.
 
-	To compile this driver as a module, choose M here: the module
-	will be called hid-generic.
+	  To compile this driver as a module, choose M here: the module
+	  will be called hid-generic.
 
-	If unsure, say Y.
+	  If unsure, say Y.
 
 config HID_HAPTIC
 	bool "Haptic touchpad support"
 	default n
 	help
-	Support for touchpads with force sensors and haptic actuators instead of a
-	traditional button.
-	Adds extra parsing and FF device for the hid multitouch driver.
-	It can be used for Elan 2703 haptic touchpad.
+	  Support for touchpads with force sensors and haptic actuators instead of a
+	  traditional button.
+	  Adds extra parsing and FF device for the hid multitouch driver.
+	  It can be used for Elan 2703 haptic touchpad.
 
-	If unsure, say N.
+	  If unsure, say N.
 
 menu "Special HID drivers"
 
 config HID_A4TECH
 	tristate "A4TECH mice"
 	help
-	Support for some A4TECH mice with two scroll wheels.
+	  Support for some A4TECH mice with two scroll wheels.
 
 config HID_ACCUTOUCH
 	tristate "Accutouch touch device"
@@ -118,44 +118,44 @@ config HID_ACCUTOUCH
 
 	  The driver works around a problem in the reported device capabilities
 	  which causes userspace to detect the device as a mouse rather than
-          a touchscreen.
+	  a touchscreen.
 
 	  Say Y here if you have a Accutouch 2216 touch controller.
 
 config HID_ACRUX
 	tristate "ACRUX game controller support"
 	help
-	Say Y here if you want to enable support for ACRUX game controllers.
+	  Say Y here if you want to enable support for ACRUX game controllers.
 
 config HID_ACRUX_FF
 	bool "ACRUX force feedback support"
 	depends on HID_ACRUX
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you want to enable force feedback support for ACRUX
-	game controllers.
+	  Say Y here if you want to enable force feedback support for ACRUX
+	  game controllers.
 
 config HID_APPLE
 	tristate "Apple {i,Power,Mac}Books"
 	depends on LEDS_CLASS
 	depends on NEW_LEDS
 	help
-	Support for some Apple devices which less or more break
-	HID specification.
+	  Support for some Apple devices which less or more break
+	  HID specification.
 
-	Say Y here if you want support for keyboards of	Apple iBooks, PowerBooks,
-	MacBooks, MacBook Pros and Apple Aluminum.
+	  Say Y here if you want support for keyboards of	Apple iBooks, PowerBooks,
+	  MacBooks, MacBook Pros and Apple Aluminum.
 
 config HID_APPLEIR
 	tristate "Apple infrared receiver"
 	depends on (USB_HID)
 	help
-	Support for Apple infrared remote control. All the Apple computers from
+	  Support for Apple infrared remote control. All the Apple computers from
 	  2005 onwards include such a port, except the unibody Macbook (2009),
 	  and Mac Pros. This receiver is also used in the Apple TV set-top box
 	  prior to the 2010 model.
 
-	Say Y here if you want support for Apple infrared remote control.
+	  Say Y here if you want support for Apple infrared remote control.
 
 config HID_APPLETB_BL
 	tristate "Apple Touch Bar Backlight"
@@ -191,34 +191,34 @@ config HID_ASUS
 	depends on ASUS_WMI || ASUS_WMI=n
 	select POWER_SUPPLY
 	help
-	Support for Asus notebook built-in keyboard and touchpad via i2c, and
-	the Asus Republic of Gamers laptop keyboard special keys.
+	  Support for Asus notebook built-in keyboard and touchpad via i2c, and
+	  the Asus Republic of Gamers laptop keyboard special keys.
 
-	Supported devices:
-	- EeeBook X205TA
-	- VivoBook E200HA
-	- GL553V series
-	- GL753V series
+	  Supported devices:
+	  - EeeBook X205TA
+	  - VivoBook E200HA
+	  - GL553V series
+	  - GL753V series
 
 config HID_AUREAL
 	tristate "Aureal"
 	help
-	Support for Aureal Cy se W-01RN Remote Controller and other Aureal derived remotes.
+	  Support for Aureal Cy se W-01RN Remote Controller and other Aureal derived remotes.
 
 config HID_BELKIN
 	tristate "Belkin Flip KVM and Wireless keyboard"
 	help
-	Support for Belkin Flip KVM and Wireless keyboard.
+	  Support for Belkin Flip KVM and Wireless keyboard.
 
 config HID_BETOP_FF
 	tristate "Betop Production Inc. force feedback support"
 	depends on USB_HID
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you want to enable force feedback support for devices by
-	BETOP Production Ltd.
-	Currently the following devices are known to be supported:
-	 - BETOP 2185 PC & BFM MODE
+	  Say Y here if you want to enable force feedback support for devices by
+	  BETOP Production Ltd.
+	  Currently the following devices are known to be supported:
+	  - BETOP 2185 PC & BFM MODE
 
 config HID_BIGBEN_FF
 	tristate "BigBen Interactive Kids' gamepad support"
@@ -235,54 +235,54 @@ config HID_BIGBEN_FF
 config HID_CHERRY
 	tristate "Cherry Cymotion keyboard"
 	help
-	Support for Cherry Cymotion keyboard.
+	  Support for Cherry Cymotion keyboard.
 
 config HID_CHICONY
 	tristate "Chicony devices"
 	depends on USB_HID
 	help
-	Support for Chicony Tactical pad and special keys on Chicony keyboards.
+	  Support for Chicony Tactical pad and special keys on Chicony keyboards.
 
 config HID_CORSAIR
 	tristate "Corsair devices"
 	depends on USB_HID && LEDS_CLASS
 	select POWER_SUPPLY
 	help
-	Support for Corsair devices that are not fully compliant with the
-	HID standard.
-	Support for Corsair Void headsets.
+	  Support for Corsair devices that are not fully compliant with the
+	  HID standard.
+	  Support for Corsair Void headsets.
 
-	Supported devices:
-	- Vengeance K90
-	- Scimitar PRO RGB
-	- Corsair Void headsets
+	  Supported devices:
+	  - Vengeance K90
+	  - Scimitar PRO RGB
+	  - Corsair Void headsets
 
 config HID_COUGAR
 	tristate "Cougar devices"
 	help
-	Support for Cougar devices that are not fully compliant with the
-	HID standard.
+	  Support for Cougar devices that are not fully compliant with the
+	  HID standard.
 
-	Supported devices:
-	- Cougar 500k Gaming Keyboard
+	  Supported devices:
+	  - Cougar 500k Gaming Keyboard
 
 config HID_MACALLY
 	tristate "Macally devices"
 	help
-	Support for Macally devices that are not fully compliant with the
-	HID standard.
+	  Support for Macally devices that are not fully compliant with the
+	  HID standard.
 
-	supported devices:
-	- Macally ikey keyboard
+	  supported devices:
+	  - Macally ikey keyboard
 
 config HID_PRODIKEYS
 	tristate "Prodikeys PC-MIDI Keyboard support"
 	depends on USB_HID && SND
 	select SND_RAWMIDI
 	help
-	Support for Prodikeys PC-MIDI Keyboard device support.
-	Say Y here to enable support for this device.
-	- Prodikeys PC-MIDI keyboard.
+	  Support for Prodikeys PC-MIDI Keyboard device support.
+	  Say Y here to enable support for this device.
+	    - Prodikeys PC-MIDI keyboard.
 	  The Prodikeys PC-MIDI acts as a USB Audio device, with one MIDI
 	  input and one MIDI output. These MIDI jacks appear as
 	  a sound "card" in the ALSA sound system.
@@ -293,97 +293,97 @@ config HID_PRODIKEYS
 config HID_CMEDIA
 	tristate "CMedia audio chips"
 	help
-	Support for CMedia CM6533 HID audio jack controls
-        and HS100B mute buttons.
+	  Support for CMedia CM6533 HID audio jack controls
+	  and HS100B mute buttons.
 
 config HID_CP2112
 	tristate "Silicon Labs CP2112 HID USB-to-SMBus Bridge support"
 	depends on USB_HID && HIDRAW && I2C && GPIOLIB
 	select GPIOLIB_IRQCHIP
 	help
-	Support for Silicon Labs CP2112 HID USB to SMBus Master Bridge.
-	This is a HID device driver which registers as an i2c adapter
-	and gpiochip to expose these functions of the CP2112. The
-	customizable USB descriptor fields are exposed as sysfs attributes.
+	  Support for Silicon Labs CP2112 HID USB to SMBus Master Bridge.
+	  This is a HID device driver which registers as an i2c adapter
+	  and gpiochip to expose these functions of the CP2112. The
+	  customizable USB descriptor fields are exposed as sysfs attributes.
 
 config HID_CREATIVE_SB0540
 	tristate "Creative SB0540 infrared receiver"
 	depends on USB_HID
 	help
-	Support for Creative infrared SB0540-compatible remote controls, such
-	as the RM-1500 and RM-1800 remotes.
+	  Support for Creative infrared SB0540-compatible remote controls, such
+	  as the RM-1500 and RM-1800 remotes.
 
-	Say Y here if you want support for Creative SB0540 infrared receiver.
+	  Say Y here if you want support for Creative SB0540 infrared receiver.
 
 config HID_CYPRESS
 	tristate "Cypress mouse and barcode readers"
 	help
-	Support for cypress mouse and barcode readers.
+	  Support for cypress mouse and barcode readers.
 
 config HID_DRAGONRISE
 	tristate "DragonRise Inc. game controller"
 	help
-	Say Y here if you have DragonRise Inc. game controllers.
-	These might be branded as:
-	- Tesun USB-703
-	- Media-tech MT1504 "Rogue"
-	- DVTech JS19 "Gear"
-	- Defender Game Master
+	  Say Y here if you have DragonRise Inc. game controllers.
+	  These might be branded as:
+	    - Tesun USB-703
+	    - Media-tech MT1504 "Rogue"
+	    - DVTech JS19 "Gear"
+	    - Defender Game Master
 
 config DRAGONRISE_FF
 	bool "DragonRise Inc. force feedback"
 	depends on HID_DRAGONRISE
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you want to enable force feedback support for DragonRise Inc.
-	game controllers.
+	  Say Y here if you want to enable force feedback support for DragonRise Inc.
+	  game controllers.
 
 config HID_EMS_FF
 	tristate "EMS Production Inc. force feedback support"
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you want to enable force feedback support for devices by
-	EMS Production Ltd.
-	Currently the following devices are known to be supported:
-	 - Trio Linker Plus II
+	  Say Y here if you want to enable force feedback support for devices by
+	  EMS Production Ltd.
+	  Currently the following devices are known to be supported:
+	    - Trio Linker Plus II
 
 config HID_ELAN
 	tristate "ELAN USB Touchpad Support"
 	depends on LEDS_CLASS && USB_HID
 	help
-	Say Y to enable support for the USB ELAN touchpad
-	Currently the following devices are known to be supported:
-	 - HP Pavilion X2 10-p0XX.
+	  Say Y to enable support for the USB ELAN touchpad
+	  Currently the following devices are known to be supported:
+	    - HP Pavilion X2 10-p0XX.
 
 config HID_ELECOM
 	tristate "ELECOM HID devices"
 	help
-	Support for ELECOM devices:
-	  - BM084 Bluetooth Mouse
-	  - EX-G Trackballs (M-XT3DRBK, M-XT3URBK)
-	  - DEFT Trackballs (M-DT1DRBK, M-DT1URBK, M-DT2DRBK, M-DT2URBK)
-	  - HUGE Trackballs (M-HT1DRBK, M-HT1URBK)
-	  - HUGE Plus Trackball (M-HT1MRBK)
+	  Support for ELECOM devices:
+	    - BM084 Bluetooth Mouse
+	    - EX-G Trackballs (M-XT3DRBK, M-XT3URBK)
+	    - DEFT Trackballs (M-DT1DRBK, M-DT1URBK, M-DT2DRBK, M-DT2URBK)
+	    - HUGE Trackballs (M-HT1DRBK, M-HT1URBK)
+	    - HUGE Plus Trackball (M-HT1MRBK)
 
 config HID_ELO
 	tristate "ELO USB 4000/4500 touchscreen"
 	depends on USB_HID
 	help
-	Support for the ELO USB 4000/4500 touchscreens. Note that this is for
-	different devices than those handled by CONFIG_TOUCHSCREEN_USB_ELO.
+	  Support for the ELO USB 4000/4500 touchscreens. Note that this is for
+	  different devices than those handled by CONFIG_TOUCHSCREEN_USB_ELO.
 
 config HID_EVISION
 	tristate "EVision Keyboards Support"
 	depends on HID
 	help
-	Support for some EVision keyboards. Note that this is needed only when
-	applying customization using userspace programs.
-	Support for some EVision devices requiring report descriptor fixups.
+	  Support for some EVision keyboards. Note that this is needed only when
+	  applying customization using userspace programs.
+	  Support for some EVision devices requiring report descriptor fixups.
 
 config HID_EZKEY
 	tristate "Ezkey BTC 8193 keyboard"
 	help
-	Support for Ezkey BTC 8193 keyboard.
+	  Support for Ezkey BTC 8193 keyboard.
 
 config HID_FT260
 	tristate "FTDI FT260 USB HID to I2C host support"
@@ -399,12 +399,12 @@ config HID_FT260
 config HID_GEMBIRD
 	tristate "Gembird Joypad"
 	help
-	Support for Gembird JPD-DualForce 2.
+	  Support for Gembird JPD-DualForce 2.
 
 config HID_GFRM
 	tristate "Google Fiber TV Box remote control support"
 	help
-	Support for Google Fiber TV Box remote controls
+	  Support for Google Fiber TV Box remote controls
 
 config HID_GLORIOUS
 	tristate "Glorious PC Gaming Race mice"
@@ -416,14 +416,14 @@ config HID_HOLTEK
 	tristate "Holtek HID devices"
 	depends on USB_HID
 	help
-	Support for Holtek based devices:
-	  - Holtek On Line Grip based game controller
-	  - Trust GXT 18 Gaming Keyboard
-	  - Sharkoon Drakonia / Perixx MX-2000 gaming mice
-	  - Tracer Sniper TRM-503 / NOVA Gaming Slider X200 /
-	    Zalman ZM-GM1
-	  - SHARKOON DarkGlider Gaming mouse
-	  - LEETGION Hellion Gaming Mouse
+	  Support for Holtek based devices:
+	    - Holtek On Line Grip based game controller
+	    - Trust GXT 18 Gaming Keyboard
+	    - Sharkoon Drakonia / Perixx MX-2000 gaming mice
+	    - Tracer Sniper TRM-503 / NOVA Gaming Slider X200 /
+	      Zalman ZM-GM1
+	    - SHARKOON DarkGlider Gaming mouse
+	    - LEETGION Hellion Gaming Mouse
 
 config HOLTEK_FF
 	bool "Holtek On Line Grip force feedback support"
@@ -452,14 +452,14 @@ config HID_GOOGLE_HAMMER
 	select INPUT_VIVALDIFMAP
 	depends on USB_HID && LEDS_CLASS && CROS_EC
 	help
-	Say Y here if you have a Google Hammer device.
+	  Say Y here if you have a Google Hammer device.
 
 config HID_GOOGLE_STADIA_FF
 	tristate "Google Stadia force feedback"
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you want to enable force feedback support for the Google
-	Stadia controller.
+	  Say Y here if you want to enable force feedback support for the Google
+	  Stadia controller.
 
 config HID_VIVALDI
 	tristate "Vivaldi Keyboard"
@@ -475,51 +475,51 @@ config HID_GT683R
 	tristate "MSI GT68xR LED support"
 	depends on LEDS_CLASS && USB_HID
 	help
-	Say Y here if you want to enable support for the three MSI GT68xR LEDs
+	  Say Y here if you want to enable support for the three MSI GT68xR LEDs
 
-	This driver support following modes:
-	  - Normal: LEDs are fully on when enabled
-	  - Audio:  LEDs brightness depends on sound level
-	  - Breathing: LEDs brightness varies at human breathing rate
+	  This driver support following modes:
+	    - Normal: LEDs are fully on when enabled
+	    - Audio:  LEDs brightness depends on sound level
+	    - Breathing: LEDs brightness varies at human breathing rate
 
-	Currently the following devices are know to be supported:
-	  - MSI GT683R
+	  Currently the following devices are know to be supported:
+	    - MSI GT683R
 
 config HID_KEYTOUCH
 	tristate "Keytouch HID devices"
 	help
-	Support for Keytouch HID devices not fully compliant with
-	the specification. Currently supported:
+	  Support for Keytouch HID devices not fully compliant with
+	  the specification. Currently supported:
 		- Keytouch IEC 60945
 
 config HID_KYE
 	tristate "KYE/Genius devices"
 	help
-	Support for KYE/Genius devices not fully compliant with HID standard:
-	- Ergo Mouse
-	- EasyPen i405X tablet
-	- MousePen i608X tablet
-	- EasyPen M610X tablet
+	  Support for KYE/Genius devices not fully compliant with HID standard:
+	  - Ergo Mouse
+	  - EasyPen i405X tablet
+	  - MousePen i608X tablet
+	  - EasyPen M610X tablet
 
 config HID_KYSONA
 	tristate "Kysona devices"
 	depends on USB_HID
 	help
-	Support for Kysona mice.
+	  Support for Kysona mice.
 
-	Say Y here if you have a Kysona M600 mouse
-	and want to be able to read its battery capacity.
+	  Say Y here if you have a Kysona M600 mouse
+	  and want to be able to read its battery capacity.
 
 config HID_UCLOGIC
 	tristate "UC-Logic"
 	depends on USB_HID
 	help
-	Support for UC-Logic and Huion tablets.
+	  Support for UC-Logic and Huion tablets.
 
 config HID_WALTOP
 	tristate "Waltop"
 	help
-	Support for Waltop tablets.
+	  Support for Waltop tablets.
 
 config HID_VIEWSONIC
 	tristate "ViewSonic/Signotec"
@@ -530,11 +530,11 @@ config HID_VRC2
 	tristate "VRC-2 Car Controller"
 	depends on HID
 	help
-        Support for VRC-2 which is a 2-axis controller often used in
-        car simulators.
+	  Support for VRC-2 which is a 2-axis controller often used in
+	  car simulators.
 
-        To compile this driver as a module, choose M here: the
-        module will be called hid-vrc2.
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-vrc2.
 
 config HID_XIAOMI
 	tristate "Xiaomi"
@@ -545,95 +545,95 @@ config HID_XIAOMI
 config HID_GYRATION
 	tristate "Gyration remote control"
 	help
-	Support for Gyration remote control.
+	  Support for Gyration remote control.
 
 config HID_ICADE
 	tristate "ION iCade arcade controller"
 	help
-	Support for the ION iCade arcade controller to work as a joystick.
+	  Support for the ION iCade arcade controller to work as a joystick.
 
-	To compile this driver as a module, choose M here: the
-	module will be called hid-icade.
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-icade.
 
 config HID_ITE
 	tristate "ITE devices"
 	help
-	Support for ITE devices not fully compliant with HID standard.
+	  Support for ITE devices not fully compliant with HID standard.
 
 config HID_JABRA
 	tristate "Jabra USB HID Driver"
 	help
-	Support for Jabra USB HID devices.
+	  Support for Jabra USB HID devices.
 
-	Prevents mapping of vendor defined HID usages to input events. Without
-	this driver HID	reports from Jabra devices may incorrectly be seen as
-	mouse button events.
-	Say M here if you may ever plug in a Jabra USB device.
+	  Prevents mapping of vendor defined HID usages to input events. Without
+	  this driver HID	reports from Jabra devices may incorrectly be seen as
+	  mouse button events.
+	  Say M here if you may ever plug in a Jabra USB device.
 
 config HID_TWINHAN
 	tristate "Twinhan IR remote control"
 	help
-	Support for Twinhan IR remote control.
+	  Support for Twinhan IR remote control.
 
 config HID_KENSINGTON
 	tristate "Kensington Slimblade Trackball"
 	help
-	Support for Kensington Slimblade Trackball.
+	  Support for Kensington Slimblade Trackball.
 
 config HID_LCPOWER
 	tristate "LC-Power"
 	help
-	Support for LC-Power RC1000MCE RF remote control.
+	  Support for LC-Power RC1000MCE RF remote control.
 
 config HID_LED
 	tristate "Simple RGB LED support"
 	depends on LEDS_CLASS
 	help
-	Support for simple RGB LED devices. Currently supported are:
-	- Riso Kagaku Webmail Notifier
-	- Dream Cheeky Webmail Notifier and Friends Alert
-	- ThingM blink(1)
-	- Delcom Visual Signal Indicator Generation 2
-	- Greynut Luxafor
+	  Support for simple RGB LED devices. Currently supported are:
+	  - Riso Kagaku Webmail Notifier
+	  - Dream Cheeky Webmail Notifier and Friends Alert
+	  - ThingM blink(1)
+	  - Delcom Visual Signal Indicator Generation 2
+	  - Greynut Luxafor
 
-	To compile this driver as a module, choose M here: the
-	module will be called hid-led.
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-led.
 
 config HID_LENOVO
 	tristate "Lenovo / Thinkpad devices"
 	depends on LEDS_CLASS
 	help
-	Support for IBM/Lenovo devices that are not fully compliant with HID standard.
+	  Support for IBM/Lenovo devices that are not fully compliant with HID standard.
 
-	Say Y if you want support for horizontal scrolling of the IBM/Lenovo
-	Scrollpoint mice or the non-compliant features of the Lenovo Thinkpad
-	standalone keyboards, e.g:
-	- ThinkPad USB Keyboard with TrackPoint (supports extra LEDs and trackpoint
-	  configuration)
-	- ThinkPad Compact Bluetooth Keyboard with TrackPoint (supports Fn keys)
-	- ThinkPad Compact USB Keyboard with TrackPoint (supports Fn keys)
+	  Say Y if you want support for horizontal scrolling of the IBM/Lenovo
+	  Scrollpoint mice or the non-compliant features of the Lenovo Thinkpad
+	  standalone keyboards, e.g:
+	  - ThinkPad USB Keyboard with TrackPoint (supports extra LEDs and trackpoint
+	    configuration)
+	  - ThinkPad Compact Bluetooth Keyboard with TrackPoint (supports Fn keys)
+	  - ThinkPad Compact USB Keyboard with TrackPoint (supports Fn keys)
 
 config HID_LENOVO_GO
 	tristate "HID Driver for Lenovo Legion Go Series Controllers"
 	depends on USB_HID
 	depends on LEDS_CLASS_MULTICOLOR
 	help
-	Support for Lenovo Legion Go devices with detachable controllers.
+	  Support for Lenovo Legion Go devices with detachable controllers.
 
-	Say Y here to include configuration interface support for the Lenovo Legion Go
-	and Legion Go 2 Handheld Console Controllers. Say M here to compile this
-	driver as a module. The module will be called hid-lenovo-go.
+	  Say Y here to include configuration interface support for the Lenovo Legion Go
+	  and Legion Go 2 Handheld Console Controllers. Say M here to compile this
+	  driver as a module. The module will be called hid-lenovo-go.
 
 config HID_LENOVO_GO_S
 	tristate "HID Driver for Lenovo Legion Go S Controller"
 	depends on USB_HID
 	depends on LEDS_CLASS_MULTICOLOR
 	help
-	Support for Lenovo Legion Go S Handheld Console Controller.
+	  Support for Lenovo Legion Go S Handheld Console Controller.
 
-	Say Y here to include configuration interface support for the Lenovo Legion Go
-	S. Say M here to compile this driver as a module. The module will be called
-	hid-lenovo-go-s.
+	  Say Y here to include configuration interface support for the Lenovo Legion Go
+	  S. Say M here to compile this driver as a module. The module will be called
+	  hid-lenovo-go-s.
 
 config HID_LETSKETCH
 	tristate "Letsketch WP9620N tablets"
@@ -655,7 +655,7 @@ config HID_LOGITECH
 	depends on LEDS_CLASS
 	depends on LEDS_CLASS_MULTICOLOR
 	help
-	Support for Logitech devices that are not fully compliant with HID standard.
+	  Support for Logitech devices that are not fully compliant with HID standard.
 
 config HID_LOGITECH_DJ
 	tristate "Logitech receivers full support"
@@ -664,23 +664,23 @@ config HID_LOGITECH_DJ
 	depends on HID_LOGITECH
 	select HID_LOGITECH_HIDPP
 	help
-	Say Y if you want support for Logitech receivers and devices.
-	Logitech receivers are capable of pairing multiple Logitech compliant
-	devices to the same receiver. Without this driver it will be handled by
-	generic USB_HID driver and all incoming events will be multiplexed
-	into a single mouse and a single keyboard device.
+	  Say Y if you want support for Logitech receivers and devices.
+	  Logitech receivers are capable of pairing multiple Logitech compliant
+	  devices to the same receiver. Without this driver it will be handled by
+	  generic USB_HID driver and all incoming events will be multiplexed
+	  into a single mouse and a single keyboard device.
 
 config HID_LOGITECH_HIDPP
 	tristate "Logitech HID++ devices support"
 	depends on HID_LOGITECH
 	select POWER_SUPPLY
 	help
-	Support for Logitech devices relying on the HID++ Logitech specification
+	  Support for Logitech devices relying on the HID++ Logitech specification
 
-	Say Y if you want support for Logitech devices relying on the HID++
-	specification. Such devices are the various Logitech Touchpads (T650,
-	T651, TK820), some mice (Zone Touch mouse), or even keyboards (Solar
-	Keyboard).
+	  Say Y if you want support for Logitech devices relying on the HID++
+	  specification. Such devices are the various Logitech Touchpads (T650,
+	  T651, TK820), some mice (Zone Touch mouse), or even keyboards (Solar
+	  Keyboard).
 
 config LOGITECH_FF
 	bool "Logitech force feedback support"
@@ -740,31 +740,31 @@ config LOGIWHEELS_FF
 config HID_MAGICMOUSE
 	tristate "Apple Magic Mouse/Trackpad multi-touch support"
 	help
-	Support for the Apple Magic Mouse/Trackpad multi-touch.
+	  Support for the Apple Magic Mouse/Trackpad multi-touch.
 
-	Say Y here if you want support for the multi-touch features of the
-	Apple Wireless "Magic" Mouse and the Apple Wireless "Magic" Trackpad.
+	  Say Y here if you want support for the multi-touch features of the
+	  Apple Wireless "Magic" Mouse and the Apple Wireless "Magic" Trackpad.
 
 config HID_MALTRON
 	tristate "Maltron L90 keyboard"
 	help
-	Adds support for the volume up, volume down, mute, and play/pause buttons
-	of the Maltron L90 keyboard.
+	  Adds support for the volume up, volume down, mute, and play/pause buttons
+	  of the Maltron L90 keyboard.
 
 config HID_MAYFLASH
 	tristate "Mayflash game controller adapter force feedback"
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have HJZ Mayflash PS3 game controller adapters
-	and want to enable force feedback support.
+	  Say Y here if you have HJZ Mayflash PS3 game controller adapters
+	  and want to enable force feedback support.
 
 config HID_MEGAWORLD_FF
 	tristate "Mega World based game controller force feedback support"
 	depends on USB_HID
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have a Mega World based game controller and want
-	to have force feedback support for it.
+	  Say Y here if you have a Mega World based game controller and want
+	  to have force feedback support for it.
 
 config HID_RAKK
 	tristate "Rakk support"
@@ -778,18 +778,18 @@ config HID_RAKK
 config HID_REDRAGON
 	tristate "Redragon keyboards"
 	help
-    Support for Redragon keyboards that need fix-ups to work properly.
+	  Support for Redragon keyboards that need fix-ups to work properly.
 
 config HID_MICROSOFT
 	tristate "Microsoft non-fully HID-compliant devices"
 	select INPUT_FF_MEMLESS
 	help
-	Support for Microsoft devices that are not fully compliant with HID standard.
+	  Support for Microsoft devices that are not fully compliant with HID standard.
 
 config HID_MONTEREY
 	tristate "Monterey Genius KB29E keyboard"
 	help
-	Support for Monterey Genius KB29E.
+	  Support for Monterey Genius KB29E.
 
 config HID_MULTITOUCH
 	tristate "HID Multitouch panels"
@@ -843,35 +843,35 @@ config HID_NINTENDO
 	depends on LEDS_CLASS
 	select POWER_SUPPLY
 	help
-	Adds support for the Nintendo Switch Joy-Cons, NSO, Pro Controller.
-	All controllers support bluetooth, and the Pro Controller also supports
-	its USB mode. This also includes support for the Nintendo Switch Online
-	Controllers which include the NES, Genesis, SNES, and N64 controllers.
+	  Adds support for the Nintendo Switch Joy-Cons, NSO, Pro Controller.
+	  All controllers support bluetooth, and the Pro Controller also supports
+	  its USB mode. This also includes support for the Nintendo Switch Online
+	  Controllers which include the NES, Genesis, SNES, and N64 controllers.
 
-	To compile this driver as a module, choose M here: the
-	module will be called hid-nintendo.
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-nintendo.
 
 config NINTENDO_FF
 	bool "Nintendo Switch controller force feedback support"
 	depends on HID_NINTENDO
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have a Nintendo Switch controller and want to enable
-	force feedback support for it. This works for both joy-cons, the pro
-	controller, and the NSO N64 controller. For the pro controller, both
-	rumble motors can be controlled individually.
+	  Say Y here if you have a Nintendo Switch controller and want to enable
+	  force feedback support for it. This works for both joy-cons, the pro
+	  controller, and the NSO N64 controller. For the pro controller, both
+	  rumble motors can be controlled individually.
 
 config HID_NTI
 	tristate "NTI keyboard adapters"
 	help
-	Support for the "extra" Sun keyboard keys on keyboards attached
-	through Network Technologies USB-SUN keyboard adapters.
+	  Support for the "extra" Sun keyboard keys on keyboards attached
+	  through Network Technologies USB-SUN keyboard adapters.
 
 config HID_NTRIG
 	tristate "N-Trig touch screen"
 	depends on USB_HID
 	help
-	Support for N-Trig touch screen.
+	  Support for N-Trig touch screen.
 
 config HID_NVIDIA_SHIELD
 	tristate "NVIDIA SHIELD devices"
@@ -896,14 +896,14 @@ config NVIDIA_SHIELD_FF
 config HID_ORTEK
 	tristate "Ortek PKB-1700/WKB-2000/Skycable wireless keyboard and mouse trackpad"
 	help
-	There are certain devices which have LogicalMaximum wrong in the keyboard
-	usage page of their report descriptor. The most prevailing ones so far
-	are manufactured by Ortek, thus the name of the driver. Currently
-	supported devices by this driver are
+	  There are certain devices which have LogicalMaximum wrong in the keyboard
+	  usage page of their report descriptor. The most prevailing ones so far
+	  are manufactured by Ortek, thus the name of the driver. Currently
+	  supported devices by this driver are
 
-	   - Ortek PKB-1700
-	   - Ortek WKB-2000
-	   - Skycable wireless presenter
+	    - Ortek PKB-1700
+	    - Ortek WKB-2000
+	    - Skycable wireless presenter
 
 config HID_OXP
 	tristate "OneXPlayer handheld controller configuration support"
@@ -946,7 +946,7 @@ config HID_PENMOUNT
 config HID_PETALYNX
 	tristate "Petalynx Maxter remote control"
 	help
-	Support for Petalynx Maxter remote control.
+	  Support for Petalynx Maxter remote control.
 
 config HID_PICOLCD
 	tristate "PicoLCD (graphic version)"
@@ -1038,77 +1038,77 @@ config PLAYSTATION_FF
 	  PlayStation game controllers.
 
 config HID_PXRC
-       tristate "PhoenixRC HID Flight Controller"
-       depends on HID
-       help
-       Support for PhoenixRC HID Flight Controller, a 8-axis flight controller.
+	tristate "PhoenixRC HID Flight Controller"
+	depends on HID
+	help
+	  Support for PhoenixRC HID Flight Controller, a 8-axis flight controller.
 
-       To compile this driver as a module, choose M here: the
-       module will be called hid-pxrc.
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-pxrc.
 
 config HID_RAPOO
 	tristate "Rapoo non-fully HID-compliant devices"
 	help
-	Support for Rapoo devices that are not fully compliant with the
-	HID standard.
+	  Support for Rapoo devices that are not fully compliant with the
+	  HID standard.
 
 config HID_RAZER
 	tristate "Razer non-fully HID-compliant devices"
 	help
-	Support for Razer devices that are not fully compliant with the
-	HID standard.
+	  Support for Razer devices that are not fully compliant with the
+	  HID standard.
 
 config HID_PRIMAX
 	tristate "Primax non-fully HID-compliant devices"
 	help
-	Support for Primax devices that are not fully compliant with the
-	HID standard.
+	  Support for Primax devices that are not fully compliant with the
+	  HID standard.
 
 config HID_RETRODE
 	tristate "Retrode 2 USB adapter for vintage video games"
 	depends on USB_HID
 	help
-	Support for
-	  * Retrode 2 cartridge and controller adapter
+	  Support for
+	    * Retrode 2 cartridge and controller adapter
 
 config HID_ROCCAT
 	tristate "Roccat device support"
 	depends on USB_HID
 	help
-	Support for Roccat devices.
-	Say Y here if you have a Roccat mouse or keyboard and want
-	support for its special functionalities.
+	  Support for Roccat devices.
+	  Say Y here if you have a Roccat mouse or keyboard and want
+	  support for its special functionalities.
 
 config HID_SAITEK
 	tristate "Saitek (Mad Catz) non-fully HID-compliant devices"
 	help
-	Support for Saitek devices that are not fully compliant with the
-	HID standard.
+	  Support for Saitek devices that are not fully compliant with the
+	  HID standard.
 
-	Supported devices:
-	- PS1000 Dual Analog Pad
-	- Saitek R.A.T.7, R.A.T.9, M.M.O.7 Gaming Mice
-	- Mad Catz R.A.T.5, R.A.T.9 Gaming Mice
+	  Supported devices:
+	  - PS1000 Dual Analog Pad
+	  - Saitek R.A.T.7, R.A.T.9, M.M.O.7 Gaming Mice
+	  - Mad Catz R.A.T.5, R.A.T.9 Gaming Mice
 
 config HID_SAMSUNG
 	tristate "Samsung InfraRed remote control or keyboards"
 	depends on USB_HID
 	help
-	Support for Samsung InfraRed remote control or keyboards.
+	  Support for Samsung InfraRed remote control or keyboards.
 
 config HID_SEMITEK
 	tristate "Semitek USB keyboards"
 	help
-	Support for Semitek USB keyboards that are not fully compliant
-	with the HID standard.
+	  Support for Semitek USB keyboards that are not fully compliant
+	  with the HID standard.
 
-	There are many variants, including:
-	- GK61, GK64, GK68, GK84, GK96, etc.
-	- SK61, SK64, SK68, SK84, SK96, etc.
-	- Dierya DK61/DK66
-	- Tronsmart TK09R
-	- Woo-dy
-	- X-Bows Nature/Knight
+	  There are many variants, including:
+	  - GK61, GK64, GK68, GK84, GK96, etc.
+	  - SK61, SK64, SK68, SK84, SK96, etc.
+	  - Dierya DK61/DK66
+	  - Tronsmart TK09R
+	  - Woo-dy
+	  - X-Bows Nature/Knight
 
 config HID_SIGMAMICRO
 	tristate "SiGma Micro-based keyboards"
@@ -1128,58 +1128,58 @@ config HID_SONY
 	select POWER_SUPPLY
 	select CRC32
 	help
-	Support for
+	  Support for
 
-	  * Sixaxis controllers for PS3
-	  * Buzz controllers
-	  * Blu-ray Disc Remote Control for PS3
-	  * Logitech Harmony adapter for PS3
-	  * Guitar Hero Live PS3, Wii U and PS4 guitars
-	  * Guitar Hero PS3 and PC guitars
-	  * Rock Band 1, 2 and 3 PS3 and Wii instruments
-	  * Rock Band 4 PS4 and PS5 guitars
-	  * DJ Hero Turntable for PS3
+	    * Sixaxis controllers for PS3
+	    * Buzz controllers
+	    * Blu-ray Disc Remote Control for PS3
+	    * Logitech Harmony adapter for PS3
+	    * Guitar Hero Live PS3, Wii U and PS4 guitars
+	    * Guitar Hero PS3 and PC guitars
+	    * Rock Band 1, 2 and 3 PS3 and Wii instruments
+	    * Rock Band 4 PS4 and PS5 guitars
+	    * DJ Hero Turntable for PS3
 
 config SONY_FF
 	bool "Sony PS2/3/4 accessories force feedback support"
 	depends on HID_SONY
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have a Sony PS2/3/4 accessory and want to enable
-	force feedback support for it.
+	  Say Y here if you have a Sony PS2/3/4 accessory and want to enable
+	  force feedback support for it.
 
 config HID_SPEEDLINK
 	tristate "Speedlink VAD Cezanne mouse support"
 	help
-	Support for Speedlink Vicious and Divine Cezanne mouse.
+	  Support for Speedlink Vicious and Divine Cezanne mouse.
 
 config HID_STEAM
 	tristate "Steam Controller/Deck support"
 	select POWER_SUPPLY
 	help
-	Say Y here if you have a Steam Controller or Deck if you want to use it
-	without running the Steam Client. It supports both the wired and
-	the wireless adaptor.
+	  Say Y here if you have a Steam Controller or Deck if you want to use it
+	  without running the Steam Client. It supports both the wired and
+	  the wireless adaptor.
 
 config STEAM_FF
 	bool "Steam Deck force feedback support"
 	depends on HID_STEAM
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you want to enable force feedback support for the Steam
-	Deck.
+	  Say Y here if you want to enable force feedback support for the Steam
+	  Deck.
 
 config HID_STEELSERIES
 	tristate "Steelseries devices support"
 	depends on USB_HID
 	help
-	Support for Steelseries SRW-S1 steering wheel, and the Steelseries
-	Arctis 1 Wireless for XBox headset.
+	  Support for Steelseries SRW-S1 steering wheel, and the Steelseries
+	  Arctis 1 Wireless for XBox headset.
 
 config HID_SUNPLUS
 	tristate "Sunplus wireless desktop"
 	help
-	Support for Sunplus wireless desktop.
+	  Support for Sunplus wireless desktop.
 
 config HID_RMI
 	tristate "Synaptics RMI4 device support"
@@ -1190,9 +1190,9 @@ config HID_RMI
 	select RMI4_F30
 	select RMI4_F3A
 	help
-	Support for Synaptics RMI4 touchpads.
-	Say Y here if you have a Synaptics RMI4 touchpads over i2c-hid or usbhid
-	and want support for its special functionalities.
+	  Support for Synaptics RMI4 touchpads.
+	  Say Y here if you have a Synaptics RMI4 touchpads over i2c-hid or usbhid
+	  and want support for its special functionalities.
 
 config HID_GREENASIA
 	tristate "GreenAsia (Product ID 0x12) game controller support"
@@ -1205,59 +1205,59 @@ config GREENASIA_FF
 	depends on HID_GREENASIA
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have a GreenAsia (Product ID 0x12) based game controller
-	(like MANTA Warrior MM816 and SpeedLink Strike2 SL-6635) or adapter
-	and want to enable force feedback support for it.
+	  Say Y here if you have a GreenAsia (Product ID 0x12) based game controller
+	  (like MANTA Warrior MM816 and SpeedLink Strike2 SL-6635) or adapter
+	  and want to enable force feedback support for it.
 
 config HID_HYPERV_MOUSE
 	tristate "Microsoft Hyper-V mouse driver"
 	depends on HYPERV_VMBUS
 	help
-	Select this option to enable the Hyper-V mouse driver.
+	  Select this option to enable the Hyper-V mouse driver.
 
 config HID_SMARTJOYPLUS
 	tristate "SmartJoy PLUS PS2/USB adapter support"
 	help
-	Support for SmartJoy PLUS PS2/USB adapter, Super Dual Box,
-	Super Joy Box 3 Pro, Super Dual Box Pro, and Super Joy Box 5 Pro.
+	  Support for SmartJoy PLUS PS2/USB adapter, Super Dual Box,
+	  Super Joy Box 3 Pro, Super Dual Box Pro, and Super Joy Box 5 Pro.
 
-	Note that DDR (Dance Dance Revolution) mode is not supported, nor
-	is pressure sensitive buttons on the pro models.
+	  Note that DDR (Dance Dance Revolution) mode is not supported, nor
+	  is pressure sensitive buttons on the pro models.
 
 config SMARTJOYPLUS_FF
 	bool "SmartJoy PLUS PS2/USB adapter force feedback support"
 	depends on HID_SMARTJOYPLUS
 	select INPUT_FF_MEMLESS
 	help
-	Say Y here if you have a SmartJoy PLUS PS2/USB adapter and want to
-	enable force feedback support for it.
+	  Say Y here if you have a SmartJoy PLUS PS2/USB adapter and want to
+	  enable force feedback support for it.
 
 config HID_TIVO
 	tristate "TiVo Slide Bluetooth remote control support"
 	help
-	Say Y if you have a TiVo Slide Bluetooth remote control.
+	  Say Y if you have a TiVo Slide Bluetooth remote control.
 
 config HID_TOPSEED
 	tristate "TopSeed Cyberlink, BTC Emprex, Conceptronic remote control support"
 	help
-	Say Y if you have a TopSeed Cyberlink or BTC Emprex or Conceptronic
-	CLLRCMCE remote control.
+	  Say Y if you have a TopSeed Cyberlink or BTC Emprex or Conceptronic
+	  CLLRCMCE remote control.
 
 config HID_TOPRE
 	tristate "Topre REALFORCE keyboards"
 	depends on HID
 	help
 	  Say Y for N-key rollover support on Topre REALFORCE R2 108/87 key and
-          Topre REALFORCE R3S 87 key keyboards.
+	  Topre REALFORCE R3S 87 key keyboards.
 
 config HID_THINGM
 	tristate "ThingM blink(1) USB RGB LED"
 	depends on LEDS_CLASS
 	select HID_LED
 	help
-	Support for the ThingM blink(1) USB RGB LED. This driver has been
-	merged into the generic hid led driver. Config symbol HID_THINGM
-	just selects HID_LED and will be removed soon.
+	  Support for the ThingM blink(1) USB RGB LED. This driver has been
+	  merged into the generic hid led driver. Config symbol HID_THINGM
+	  just selects HID_LED and will be removed soon.
 
 config HID_THRUSTMASTER
 	tristate "ThrustMaster devices support"
@@ -1332,23 +1332,23 @@ config HID_WIIMOTE
 	select POWER_SUPPLY
 	select INPUT_FF_MEMLESS
 	help
-	Support for Nintendo Wii and Wii U Bluetooth peripherals. Supported
-	devices are the Wii Remote and its extension devices, but also devices
-	based on the Wii Remote like the Wii U Pro Controller or the
-	Wii Balance Board.
+	  Support for Nintendo Wii and Wii U Bluetooth peripherals. Supported
+	  devices are the Wii Remote and its extension devices, but also devices
+	  based on the Wii Remote like the Wii U Pro Controller or the
+	  Wii Balance Board.
 
-	Support for all official Nintendo extensions is available, however, 3rd
-	party extensions might not be supported. Please report these devices to:
+	  Support for all official Nintendo extensions is available, however, 3rd
+	  party extensions might not be supported. Please report these devices to:
 	  http://github.com/dvdhrm/xwiimote/issues
 
-	Other Nintendo Wii U peripherals that are IEEE 802.11 based (including
-	the Wii U Gamepad) might be supported in the future. But currently
-	support is limited to Bluetooth based devices.
+	  Other Nintendo Wii U peripherals that are IEEE 802.11 based (including
+	  the Wii U Gamepad) might be supported in the future. But currently
+	  support is limited to Bluetooth based devices.
 
-	If unsure, say N.
+	  If unsure, say N.
 
-	To compile this driver as a module, choose M here: the
-	module will be called hid-wiimote.
+	  To compile this driver as a module, choose M here: the
+	  module will be called hid-wiimote.
 
 config HID_WINWING
 	tristate "WinWing Orion2 throttle support"
@@ -1371,9 +1371,9 @@ config HID_WINWING
 config HID_XINMO
 	tristate "Xin-Mo non-fully compliant devices"
 	help
-	Support for Xin-Mo devices that are not fully compliant with the HID
-	standard. Currently only supports the Xin-Mo Dual Arcade. Say Y here
-	if you have a Xin-Mo Dual Arcade controller.
+	  Support for Xin-Mo devices that are not fully compliant with the HID
+	  standard. Currently only supports the Xin-Mo Dual Arcade. Say Y here
+	  if you have a Xin-Mo Dual Arcade controller.
 
 config HID_ZEROPLUS
 	tristate "Zeroplus based game controller support"
@@ -1391,7 +1391,7 @@ config ZEROPLUS_FF
 config HID_ZYDACRON
 	tristate "Zydacron remote control support"
 	help
-	Support for Zydacron remote control.
+	  Support for Zydacron remote control.
 
 config HID_SENSOR_HUB
 	tristate "HID Sensors framework support"
@@ -1425,9 +1425,9 @@ config HID_SENSOR_CUSTOM_SENSOR
 config HID_ALPS
 	tristate "Alps HID device support"
 	help
-	Support for Alps I2C HID touchpads and StickPointer.
-	Say Y here if you have a Alps touchpads over i2c-hid or usbhid
-	and want support for its special functionalities.
+	  Support for Alps I2C HID touchpads and StickPointer.
+	  Say Y here if you have a Alps touchpads over i2c-hid or usbhid
+	  and want support for its special functionalities.
 
 config HID_MCP2200
 	tristate "Microchip MCP2200 HID USB-to-GPIO bridge"
@@ -1444,11 +1444,11 @@ config HID_MCP2221
 	imply GPIOLIB
 	imply IIO
 	help
-	Provides I2C and SMBUS host adapter functionality over USB-HID
-	through MCP2221 device.
+	  Provides I2C and SMBUS host adapter functionality over USB-HID
+	  through MCP2221 device.
 
-	To compile this driver as a module, choose M here: the module
-	will be called hid-mcp2221.ko.
+	  To compile this driver as a module, choose M here: the module
+	  will be called hid-mcp2221.ko.
 
 config HID_KUNIT_TEST
 	tristate "KUnit tests for HID" if !KUNIT_ALL_TESTS
-- 
2.54.0

