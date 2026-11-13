Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794608350;
	b=nB8Jd5nyJ8aIkh31ssVYPFB2kZwdn6YrC+7bvqWdzqmpHd065uBglHzdDQ9/FjYOea9w
	 C3u2zKAUBObKvNDPZq2ZG6P/XaQ7FNX3SX4PKnjxKg0e+zBNhywdPAOFpcPCLc56jdkPh
	 ZZpS3iS1l6BvnCaujGnYIHEqtRjvY+BP+sWdflWSBoJo95eaGdbF1qZduPFsNskVyKikn
	 jkcyKqUkMG+2EUbXVog3Mdn1rtrfJ3oAsC4k5CvfDHACZXRffciQ/ZZcpUPf6+Yy9phnw
	 OJKnx/pLoxdz8B2MyWTKI8uNwhM6GPCy/BWDWLdqc0wtHj7qv5534J461Aat6ECFbSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794608350;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=4vlq1oeX7Au1tA4wPZzNfORNQPCbMh2wdaNfr5fGVQQ=;
	b=WA81TlyT9ecI9XA+aveU3zRL1VpouKc9uFqmqbEEVvsCT8TbNunl5Kg8Dw35Ke5HEM11
	 2Oq1NTg7cCwsNWPSuTgkKMp8eAqt3BW7pSMLeBXKQYQQJlDuQtWcy6/UEHlCzUnoT0Op4
	 blmqy3dStEB9sO7c5nR99pjYWouZoCrMUA9CzY3TNa6TQLJKeyyJ+k7nN5sDaqgaNbii8
	 Wv5kr0AgQtmqT+ce7nESIFbFzjhRRiJz7A52iXKhowoz3m6cKZdbSd/0hdJXoLCTHiEW7
	 PYdwzDFYVdu4pmuJ33/6HAHEqaRaX0KYSbXChOqWay9ZzEHEYyxlBmmBoo+IX9V+pWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IiM+kcdw;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A09606A335;
	Fri, 13 Nov 2026 22:19:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67A09606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=IiM+kcdw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794608346; x=1826144346;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qKwKs4o/qujMa+3DLgurUxzswP++9XrL5Nd3dmkVW/0=;
  b=IiM+kcdw20bKbT2iyPeD7ML6tBD0dVfRk15j7QOXHQvNHf2uZG+AhqY5
   MKkRtUNAYHwgqhu1MJ7TYA7F80yxX8yIzvJYBKgMgpxhR1khfPoyKz+7s
   y3wAUeHTty1m1Eex6kTealy1iEqEw+gZciFvCZ+oZy3gdHwYTQHAuRKgM
   ugVoAt5f/9pI1dc4ik2UBSm+SJC4ViP+hrDJpz+Gu/STlpyRNTmZEzuSp
   uEUPUWZYr4X4Ewy1dd/cpgMahjy5gulDdO/k2Y9lQnXtouXn3fAjSwKoq
   dP/q38eeYdmNVl3tlHBDtEgxCU8UcJdcBDVliTIjUTe+mj+xAsKI4PA05
   A==;
X-CSE-ConnectionGUID: sj0qW5SxThmQJKcttVyI8Q==
X-CSE-MsgGUID: xn6dvloDR5O+WPT5l7RMLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3318927"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3318927"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 14:19:05 -0800
X-CSE-ConnectionGUID: 8EHO8ah8R+CtWVZhCDISBw==
X-CSE-MsgGUID: IiiZpPK7RA++MCpjIq6KQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="8971503"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.214])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 14:19:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sat, 14 Nov 2026 00:18:58 +0200 (EET)
To: =?ISO-8859-15?Q?Mat=EDas_Mart=EDnez?= <hello@matias.me>
cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
    linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Antheas Kapenekakis <lkml@antheas.dev>, 
    Denis Benato <denis.benato@linux.dev>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    "Derek J . Clark" <derekjohn.clark@gmail.com>, Armin Wolf <W_Armin@gmx.de>
Subject: Re: [PATCH v5] HID: ayaneo: Add AYANEO 3 detachable controller
 driver
In-Reply-To: <20261113212729.15925-1-hello@matias.me>
Message-ID: <5262048f-50d3-4fe5-59e3-e5fbbba8a17e@linux.intel.com>
References: <20261113212729.15925-1-hello@matias.me>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1731197562-1794608338=:6498"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1731197562-1794608338=:6498
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 13 Nov 2026, Mat=C3=ADas Mart=C3=ADnez wrote:

> The AYANEO 3 handheld has a detachable controller with swappable
> modules ("Magic Modules"). The controller exposes three USB HID
> interfaces behind 1c4f:0002 (a generic SigmaMicro VID/PID): a gamepad,
> a keyboard for the extra buttons, and a vendor interface accepting
> 65-byte commands.
>=20
> Add a driver claiming every interface of the shared ID. Interfaces
> other than the AYANEO 3 vendor interface are started as transparent
> generic devices, with reset_resume mirrored from hid-generic:
> hid-generic yields any device that another driver's id table matches,
> so refusing those probes would leave the input interfaces driverless
> when the driver is present at boot.
>=20
> On the vendor interface the driver provides module identification
> (module_left/module_right sysfs attributes), software eject of the
> modules (eject sysfs attribute, blocking until the firmware confirms
> the release handshake and a minimum settle time has passed), a
> configuration reset (reset), rumble strength selection
> (rumble_intensity), and RGB control of the joystick rings as a
> multicolor LED class device ("<device name>:rgb:joystick_rings";
> userspace such as InputPlumber matches the function suffix). The
> firmware's fixed-tempo effects are exposed through the LED effect
> attribute (monocolor, breathe, rainbow), matching the attribute names
> established by hid-lenovo-go.
>=20
> This complements the ayaneo-ec platform driver, which exposes module
> attach state and controller power. A full physical eject is performed
> by writing to eject and then cutting power through ayaneo-ec's
> controller_power attribute; that orchestration is deliberately left
> to userspace.
>=20
> The protocol was reverse engineered in the Handheld Daemon project by
> Antheas Kapenekakis. Tested on an AYANEO 3: module identification,
> RGB solid, breathing and rainbow at several brightness levels, rumble
> level selection, gamepad and keyboard input through the transparent
> interfaces, a full eject/reinsert/repower cycle with the re-enumerated
> interfaces binding cleanly, and repeated driver unbinds under a
> concurrent brightness-write load.
>=20
> Signed-off-by: Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> ---
> Changes in v5:
> - Trim the code comments per review: drop the observations that
>   restate the adjacent code and the aside about a separate led-class
>   core fix, and keep the ordering, locking and wire-protocol
>   rationale. No functional change. [Antheas Kapenekakis]
>=20
> Notes
> -----
> reset_resume is the post-reset path, not a plain resume hook. It runs
> only when the device was reset while suspended, where the controller's
> firmware state is lost regardless of how normal resume behaves;
> ordinary resume works and the driver does not hook it. The transparent
> interfaces defer to hidinput_reset_resume exactly as hid-generic does,
> and the vendor interface reapplies the cached config only if userspace
> had configured it.
>=20
> Default intensity (answering the v4 question): the multicolor LED class
> computes each channel as brightness * intensity / max. The subled
> intensities start at zero, so with the defaults a brightness write
> would show the LED "on" while emitting no light. Defaulting them to
> full makes a brightness-only write produce white, the least surprising
> behaviour on a device with no config read-back.
>=20
> effect/effect_index are documented in this driver's own ABI file, as
> sysfs-driver-hid-lenovo-go and -go-s already document the same
> per-device LED attributes. Consolidating the three into one shared
> description would be better; I can send that as a follow-up (a generic
> doc plus removal of the duplicates from all three files), but it
> crosses into the hid-lenovo-go maintainers' files, so I kept it out of
> this patch rather than block the driver on it.
>=20
> eject scope: a write-only eject attribute that drives a firmware
> release handshake follows existing practice. greybus exposes the same
> on its detachable modules (drivers/greybus/module.c, DEVICE_ATTR_WO),
> and ACPI uses an eject attribute for ejectable hardware
> (drivers/acpi/device_sysfs.c). This driver is more conservative than
> greybus, which commands the physical eject itself: here only the
> firmware handshake is in the kernel, and the power cut is left to
> userspace through ayaneo-ec. If the HID maintainers would prefer eject
> left entirely to userspace, the module-identification and LED parts
> stand on their own and I can resend without it.
>=20
> The id_table matches the generic SigmaMicro 1c4f:0002, shared with
> unrelated keyboards (see hid-quirks.c). This is deliberate: the AYANEO 3
> controller presents under that ID, and claiming it lets the non-vendor
> interfaces start transparently instead of being stranded (hid-generic
> yields any id-table match). On hardware that is not an AYANEO 3 the
> driver still binds and starts the device transparently, and sets
> HID_QUIRK_INPUT_PER_APP on that path, which hid-generic does not. I can
> gate that quirk on the DMI match so foreign devices get plain
> hid-generic behaviour if you prefer.
>=20
> checkpatch flags the -ENOSYS check in ayaneo_send() as a misuse; it is
> the standard hid_hw_output_report() fallback (the transport returns
> -ENOSYS when it has no output report path).
>=20
> v3: https://lore.kernel.org/linux-input/20260917160722.89391-1-hello@mati=
as.me/
> v4: https://lore.kernel.org/linux-input/20260925061941.75121-1-hello@mati=
as.me/
>=20
>  .../ABI/testing/sysfs-driver-hid-ayaneo       |  75 ++
>  MAINTAINERS                                   |   7 +
>  drivers/hid/Kconfig                           |  17 +
>  drivers/hid/Makefile                          |   1 +
>  drivers/hid/hid-ayaneo.c                      | 856 ++++++++++++++++++
>  5 files changed, 956 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-ayaneo
>  create mode 100644 drivers/hid/hid-ayaneo.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-ayaneo b/Document=
ation/ABI/testing/sysfs-driver-hid-ayaneo
> new file mode 100644
> index 000000000..525b08277
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-ayaneo
> @@ -0,0 +1,75 @@
> +What:=09=09/sys/bus/hid/drivers/hid-ayaneo/<dev>/module_left
> +What:=09=09/sys/bus/hid/drivers/hid-ayaneo/<dev>/module_right
> +Date:=09=09September 2026
> +KernelVersion:=097.4
> +Contact:=09Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +=09=09Reports the type of the module currently inserted in the
> +=09=09left/right slot of the AYANEO 3 detachable controller, as
> +=09=09the raw identifier reported by the controller firmware in
> +=09=09hexadecimal (e.g. "0x04"). Bits 0-5 encode the module
> +=09=09type, bit 6 indicates the module is inserted rotated.
> +
> +=09=09Reading these attributes queries the controller and can
> +=09=09take up to a second.
> +
> +What:=09=09/sys/bus/hid/drivers/hid-ayaneo/<dev>/eject
> +Date:=09=09September 2026
> +KernelVersion:=097.4
> +Contact:=09Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +=09=09Write-only. Writing "left", "right" or "both" asks the
> +=09=09controller firmware to release the corresponding
> +=09=09module(s). The write blocks until the firmware confirms
> +=09=09the release handshake (typically a few seconds). The
> +=09=09module is physically released once controller power is
> +=09=09subsequently cut through the ayaneo-ec platform driver's
> +=09=09controller_power attribute. That final step is left to
> +=09=09userspace.
> +
> +What:=09=09/sys/bus/hid/drivers/hid-ayaneo/<dev>/reset
> +Date:=09=09September 2026
> +KernelVersion:=097.4
> +Contact:=09Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +=09=09Write-only. Writing "1" asks the controller firmware to
> +=09=09perform a quick reset of the controller configuration.
> +
> +What:=09=09/sys/bus/hid/drivers/hid-ayaneo/<dev>/rumble_intensity
> +Date:=09=09September 2026
> +KernelVersion:=097.4
> +Contact:=09Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +=09=09Controls the vibration strength of the AYANEO 3 controller
> +=09=09rumble motors. Reading returns the selected level. Supported
> +=09=09writes are the values listed by rumble_intensity_index.
> +=09=09Defaults to "medium", matching the firmware default.
> +
> +What:=09=09/sys/bus/hid/drivers/hid-ayaneo/<dev>/rumble_intensity_index
> +Date:=09=09September 2026
> +KernelVersion:=097.4
> +Contact:=09Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +=09=09Read-only. Space-separated list of the supported
> +=09=09rumble_intensity values: "off low medium high".
> +
> +What:=09=09/sys/class/leds/<dev>:rgb:joystick_rings/effect
> +Date:=09=09September 2026
> +KernelVersion:=097.4
> +Contact:=09Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +=09=09Controls the firmware LED effect of the joystick rings.
> +
> +=09=09Values are "monocolor", "breathe" or "rainbow", as listed
> +=09=09by the effect_index attribute. "rainbow" is a
> +=09=09firmware-timed colour cycle whose hue and tempo are fixed
> +=09=09by the firmware: brightness scales its amplitude and the
> +=09=09multi_intensity values are ignored while it is selected.
> +
> +What:=09=09/sys/class/leds/<dev>:rgb:joystick_rings/effect_index
> +Date:=09=09September 2026
> +KernelVersion:=097.4
> +Contact:=09Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +=09=09Read-only. Space-separated list of the supported effect
> +=09=09values: "monocolor breathe rainbow".
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4a69da715..7be0ff5b5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4535,6 +4535,13 @@ F:=09Documentation/devicetree/bindings/spi/axiado,=
ax3000-spi.yaml
>  F:=09drivers/spi/spi-axiado.c
>  F:=09drivers/spi/spi-axiado.h
> =20
> +AYANEO 3 CONTROLLER HID DRIVER
> +M:=09Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +L:=09linux-input@vger.kernel.org
> +S:=09Maintained
> +F:=09Documentation/ABI/testing/sysfs-driver-hid-ayaneo
> +F:=09drivers/hid/hid-ayaneo.c
> +
>  AYANEO PLATFORM EC DRIVER
>  M:=09Antheas Kapenekakis <lkml@antheas.dev>
>  L:=09platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 2481bc01c..1babbee85 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -205,6 +205,23 @@ config HID_AUREAL
>  =09help
>  =09Support for Aureal Cy se W-01RN Remote Controller and other Aureal de=
rived remotes.
> =20
> +config HID_AYANEO
> +=09tristate "AYANEO 3 detachable controller support"
> +=09depends on USB_HID
> +=09depends on DMI
> +=09depends on LEDS_CLASS_MULTICOLOR
> +=09help
> +=09  Provides support for the detachable controller ("Magic Modules")
> +=09  of the AYANEO 3 handheld: module identification, software eject
> +=09  and RGB control of the joystick rings. Complements the ayaneo-ec
> +=09  platform driver, which handles module attach state and controller
> +=09  power.
> +
> +=09  Say Y or M here if you have an AYANEO 3.
> +
> +=09  To compile this driver as a module, choose M here: the
> +=09  module will be called hid-ayaneo.
> +
>  config HID_BELKIN
>  =09tristate "Belkin Flip KVM and Wireless keyboard"
>  =09help
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 43a8eb0f3..116dafb2d 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_HID_APPLETB_KBD)=09+=3D hid-appletb-kbd.o
>  obj-$(CONFIG_HID_CREATIVE_SB0540)=09+=3D hid-creative-sb0540.o
>  obj-$(CONFIG_HID_ASUS)=09=09+=3D hid-asus.o
>  obj-$(CONFIG_HID_AUREAL)=09+=3D hid-aureal.o
> +obj-$(CONFIG_HID_AYANEO)=09+=3D hid-ayaneo.o
>  obj-$(CONFIG_HID_BELKIN)=09+=3D hid-belkin.o
>  obj-$(CONFIG_HID_BETOP_FF)=09+=3D hid-betopff.o
>  obj-$(CONFIG_HID_BIGBEN_FF)=09+=3D hid-bigbenff.o
> diff --git a/drivers/hid/hid-ayaneo.c b/drivers/hid/hid-ayaneo.c
> new file mode 100644
> index 000000000..a6c2dee79
> --- /dev/null
> +++ b/drivers/hid/hid-ayaneo.c
> @@ -0,0 +1,856 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * HID driver for the AYANEO 3 detachable controller ("Magic Modules").
> + *
> + * The AYANEO 3 controller exposes three USB HID interfaces behind
> + * VID 0x1c4f PID 0x0002 (a generic SigmaMicro ID): a gamepad, a
> + * keyboard for the extra buttons, and a vendor interface (application
> + * usage 0xff000001) accepting 65-byte commands.
> + *
> + * On the vendor interface the driver provides module identification,
> + * software eject, RGB control of the joystick rings (as a multicolor
> + * LED class device), rumble intensity and configuration reset. Other
> + * interfaces are started as transparent generic devices.
> + *
> + * It complements the ayaneo-ec platform driver, which exposes module
> + * attach state and controller power. A full eject is: write to this
> + * driver's "eject" attribute, then power the controller off through
> + * ayaneo-ec's controller_power once the eject completes.
> + *
> + * The protocol was reverse engineered in the Handheld Daemon project by
> + * Antheas Kapenekakis.
> + *
> + * Command format (65 bytes, unnumbered report):
> + *   [0]   report id (0)
> + *   [1:3] little-endian sum of bytes 7..64
> + *   [3]   command
> + *   [4]   subcommand
> + *   [5:]  payload
> + * The device replies with a 64-byte report echoing the subcommand at
> + * byte 3.
> + *
> + * Copyright (C) 2026 Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> + */
> +
> +#include <linux/build_bug.h>
> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
> +#include <linux/delay.h>
> +#include <linux/dmi.h>
> +#include <linux/hid.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/spinlock.h>
> +#include <linux/sysfs.h>
> +#include <linux/unaligned.h>
> +#include <linux/workqueue.h>
> +
> +#include "hid-ids.h"
> +
> +#define AYA3_REPORT_SIZE=0965
> +#define AYA3_RESP_SIZE=09=0964
> +
> +/*
> + * Empirical timings, inherited from Handheld Daemon's implementation of
> + * this protocol and validated on hardware: the device answers within
> + * 300ms or not at all, needs about half a second to settle after a
> + * reset before accepting new configuration, and completes an eject
> + * handshake within a few seconds. A minimum settle also separates the
> + * eject command from the power cut (AYA_MIN_EJECT in Handheld Daemon).
> + */
> +#define AYA3_CMD_TIMEOUT_MS=09300
> +#define AYA3_CMD_ATTEMPTS=093
> +#define AYA3_RESET_SETTLE_MS=09500
> +#define AYA3_EJECT_POLL_MS=09400
> +#define AYA3_EJECT_POLLS=0920
> +#define AYA3_EJECT_MIN_MS=093000
> +
> +/* Subcommands (byte 4). Byte 3 is 0x00 except for the config command. *=
/
> +#define AYA3_SUBCMD_CHECK=090x08
> +#define AYA3_CMD_CONFIG=09=090x21
> +#define AYA3_SUBCMD_CONFIG=090x09
> +
> +/* Bits that stay set in the eject status byte after an eject completes =
*/
> +#define AYA3_EJECT_DONE_MASK=090x11
> +
> +/* Application usage of the vendor interface's first collection */
> +#define AYA3_APP_USAGE=09=09(HID_UP_MSVENDOR | 0x0001)
> +
> +/* Config command eject/reset field */
> +#define AYA3_EJECT_LEFT=09=090x07
> +#define AYA3_EJECT_RIGHT=090x70
> +#define AYA3_RESET=09=090x88
> +
> +/* Config command RGB modes */
> +#define AYA3_RGB_SOLID=09=090x01
> +#define AYA3_RGB_PULSE=09=090x02
> +#define AYA3_RGB_RAINBOW=090x03
> +#define AYA3_RGB_OFF=09=090xff
> +
> +/* Config command vibration levels, stored in the high nibble */
> +enum aya3_vibration {
> +=09AYA3_VIBRATION_LOW=09=3D 0x1,
> +=09AYA3_VIBRATION_MEDIUM=09=3D 0x2,
> +=09AYA3_VIBRATION_HIGH=09=3D 0x3,
> +=09AYA3_VIBRATION_OFF=09=3D 0x4,
> +};
> +
> +/* Firmware LED effects selectable through the LED "effect" attribute */
> +enum aya3_effect {
> +=09AYA3_EFFECT_MONOCOLOR,
> +=09AYA3_EFFECT_BREATHE,
> +=09AYA3_EFFECT_RAINBOW,
> +};
> +
> +static const char * const ayaneo_effect_names[] =3D {
> +=09[AYA3_EFFECT_MONOCOLOR]=09=3D "monocolor",
> +=09[AYA3_EFFECT_BREATHE]=09=3D "breathe",
> +=09[AYA3_EFFECT_RAINBOW]=09=3D "rainbow",
> +};
> +
> +struct aya3_rgb {
> +=09u8 mode;
> +=09u8 r;
> +=09u8 g;
> +=09u8 b;
> +} __packed;

Add include.

> +
> +/* csum is the little-endian sum of bytes 7..64; unk* fields are zero. *=
/
> +struct aya3_config {
> +=09u8 report_id;
> +=09__le16 csum;
> +=09u8 cmd;
> +=09u8 subcmd;
> +=09u8 unk5[3];
> +=09struct aya3_rgb right;
> +=09struct aya3_rgb left;
> +=09u8 unk16[4];
> +=09u8 eject;
> +=09u8 unk21;
> +=09u8 sensitivity[2];
> +=09u8 vibration;
> +=09u8 unk25[7];
> +=09u8 magic;
> +=09u8 unk33[32];
> +} __packed;
> +static_assert(sizeof(struct aya3_config) =3D=3D AYA3_REPORT_SIZE);
> +
> +/* Replies echo the subcommand they answer at byte 3 */
> +struct aya3_resp {
> +=09u8 unk0[3];
> +=09u8 subcmd;
> +=09u8 unk4[15];
> +=09u8 eject_status;
> +=09u8 unk20[12];
> +=09u8 module_left;
> +=09u8 module_right;
> +=09u8 unk34[30];
> +} __packed;
> +static_assert(sizeof(struct aya3_resp) =3D=3D AYA3_RESP_SIZE);
> +
> +struct ayaneo {
> +=09struct hid_device *hdev;
> +=09/* DMA-safe command buffer; guarded by lock */
> +=09u8 *xfer;
> +=09/* Serializes commands and cached-config access */
> +=09struct mutex lock;
> +=09/* Protects the reply-matching state shared with raw_event */
> +=09spinlock_t resp_lock;
> +=09struct completion resp_done;
> +=09struct aya3_resp resp;
> +=09u8 resp_expect;
> +=09bool resp_pending;
> +
> +=09/* No traffic is sent unless userspace asks; persists across resets. =
*/
> +=09bool configured;
> +
> +=09u8 rgb[3];
> +=09u8 brightness;
> +=09u8 effect;
> +=09u8 vibration;
> +
> +=09struct led_classdev_mc mcled;
> +=09struct mc_subled subleds[3];
> +};
> +
> +static int ayaneo_send(struct ayaneo *aya)
> +{
> +=09int ret;
> +
> +=09ret =3D hid_hw_output_report(aya->hdev, aya->xfer, AYA3_REPORT_SIZE);
> +=09if (ret =3D=3D -ENOSYS)
> +=09=09ret =3D hid_hw_raw_request(aya->hdev, aya->xfer[0], aya->xfer,
> +=09=09=09=09=09 AYA3_REPORT_SIZE, HID_OUTPUT_REPORT,
> +=09=09=09=09=09 HID_REQ_SET_REPORT);
> +=09if (ret < 0)
> +=09=09return ret;
> +=09return 0;
> +}
> +
> +/**
> + * ayaneo_cmd() - send the command in aya->xfer and wait for the reply
> + * @aya: driver data with the fully built 65-byte command in @aya->xfer
> + * @resp: destination for the reply, or NULL to discard it
> + * @attempts: how many times to send before giving up
> + *
> + * The device echoes the subcommand byte of the command it is answering,
> + * which ayaneo_raw_event() uses to match replies. Unanswered commands a=
re
> + * retried up to @attempts times.
> + *
> + * Context: process context. The caller must hold @aya->lock, which
> + *          protects @aya->xfer and the reply state.
> + * Return: 0 on success, -ETIMEDOUT if every attempt went unanswered, or
> + *         a negative errno if sending failed.
> + */
> +static int ayaneo_cmd(struct ayaneo *aya, struct aya3_resp *resp, int at=
tempts)
> +{
> +=09int attempt, ret;
> +
> +=09lockdep_assert_held(&aya->lock);
> +
> +=09for (attempt =3D 0; attempt < attempts; attempt++) {
> +=09=09scoped_guard(spinlock_irqsave, &aya->resp_lock) {
> +=09=09=09reinit_completion(&aya->resp_done);
> +=09=09=09aya->resp_expect =3D aya->xfer[4];
> +=09=09=09aya->resp_pending =3D true;
> +=09=09}
> +
> +=09=09ret =3D ayaneo_send(aya);
> +=09=09if (ret) {
> +=09=09=09scoped_guard(spinlock_irqsave, &aya->resp_lock)
> +=09=09=09=09aya->resp_pending =3D false;
> +=09=09=09return ret;
> +=09=09}
> +
> +=09=09if (wait_for_completion_timeout(&aya->resp_done,
> +=09=09=09=09=09=09msecs_to_jiffies(AYA3_CMD_TIMEOUT_MS))) {
> +=09=09=09/*
> +=09=09=09 * raw_event clears resp_pending before completing, so
> +=09=09=09 * nothing else writes aya->resp: the copy is safe unlocked.
> +=09=09=09 */
> +=09=09=09if (resp)
> +=09=09=09=09memcpy(resp, &aya->resp, sizeof(*resp));
> +=09=09=09return 0;
> +=09=09}
> +=09}
> +=09scoped_guard(spinlock_irqsave, &aya->resp_lock)
> +=09=09aya->resp_pending =3D false;
> +=09return -ETIMEDOUT;
> +}
> +
> +static void ayaneo_checksum(u8 *buf)
> +{
> +=09u16 sum =3D 0;
> +=09int i;
> +
> +=09for (i =3D 7; i < AYA3_REPORT_SIZE; i++)

AYA3_CHECKSUM_STARTOFFSET ?

> +=09=09sum +=3D buf[i];
> +=09put_unaligned_le16(sum, buf + 1);
> +}
> +
> +static int ayaneo_check(struct ayaneo *aya, struct aya3_resp *resp,
> +=09=09=09int attempts)
> +{
> +=09memset(aya->xfer, 0, AYA3_REPORT_SIZE);
> +=09aya->xfer[4] =3D AYA3_SUBCMD_CHECK;
> +=09return ayaneo_cmd(aya, resp, attempts);
> +}
> +
> +/*
> + * The config command sets RGB, vibration and the eject/reset field at
> + * once. It can also carry joystick sensitivity; those bytes are left
> + * zero so the firmware setting is not clobbered on every RGB update.
> + */
> +static int ayaneo_send_config(struct ayaneo *aya, u8 eject)
> +{
> +=09static const struct aya3_config template =3D {
> +=09=09.cmd =3D AYA3_CMD_CONFIG,
> +=09=09.subcmd =3D AYA3_SUBCMD_CONFIG,
> +=09=09.magic =3D 0x01,
> +=09};
> +=09struct aya3_config *cfg =3D (struct aya3_config *)aya->xfer;
> +=09u8 mode =3D AYA3_RGB_OFF;
> +=09int ret;
> +
> +=09if (aya->effect =3D=3D AYA3_EFFECT_RAINBOW) {
> +=09=09if (aya->brightness)
> +=09=09=09mode =3D AYA3_RGB_RAINBOW;
> +=09} else if (aya->rgb[0] || aya->rgb[1] || aya->rgb[2]) {
> +=09=09mode =3D aya->effect =3D=3D AYA3_EFFECT_BREATHE ?
> +=09=09=09AYA3_RGB_PULSE : AYA3_RGB_SOLID;
> +=09}
> +
> +=09*cfg =3D template;
> +=09cfg->right.mode =3D mode;
> +=09if (mode =3D=3D AYA3_RGB_RAINBOW) {
> +=09=09/*
> +=09=09 * The firmware generates hue and tempo itself. The RGB
> +=09=09 * payload only scales the amplitude. Handheld Daemon
> +=09=09 * derives it as HSV(275, 100, brightness), which is
> +=09=09 * (7/12 * v, 0, v) in RGB.
> +=09=09 */
> +=09=09cfg->right.r =3D aya->brightness * 7 / 12;
> +=09=09cfg->right.g =3D 0;
> +=09=09cfg->right.b =3D aya->brightness;
> +=09} else {
> +=09=09cfg->right.r =3D aya->rgb[0];
> +=09=09cfg->right.g =3D aya->rgb[1];
> +=09=09cfg->right.b =3D aya->rgb[2];
> +=09}
> +=09cfg->left =3D cfg->right;
> +=09cfg->eject =3D eject;
> +=09cfg->vibration =3D aya->vibration << 4;

Is this scaling (needs named define) or a field (needs named define +=20
FIELD_PREP()) ?

> +=09ayaneo_checksum(aya->xfer);

Can this return the checksum and you assign it here?

> +
> +=09ret =3D ayaneo_cmd(aya, NULL, AYA3_CMD_ATTEMPTS);
> +=09if (!ret)
> +=09=09aya->configured =3D true;
> +=09return ret;
> +}
> +
> +static int ayaneo_raw_event(struct hid_device *hdev, struct hid_report *=
report,
> +=09=09=09    u8 *data, int size)
> +{
> +=09struct ayaneo *aya =3D hid_get_drvdata(hdev);
> +=09const struct aya3_resp *resp =3D (const struct aya3_resp *)data;
> +
> +=09/* Transparent interfaces have no driver data */
> +=09if (!aya)
> +=09=09return 0;
> +
> +=09guard(spinlock_irqsave)(&aya->resp_lock);
> +
> +=09if (!aya->resp_pending || size < AYA3_RESP_SIZE)
> +=09=09return 0;
> +=09/*
> +=09 * Replies carry no sequence number, only the subcommand echo. A
> +=09 * late reply to a timed-out command can thus complete a newer
> +=09 * command with the same subcommand. Such replies are snapshots
> +=09 * of the same query milliseconds apart, so this is harmless.
> +=09 * Replies to a different subcommand are dropped here.
> +=09 */
> +=09if (resp->subcmd !=3D aya->resp_expect)
> +=09=09return 0;
> +
> +=09memcpy(&aya->resp, data, sizeof(aya->resp));
> +=09aya->resp_pending =3D false;
> +=09complete(&aya->resp_done);
> +=09return 0;
> +}
> +
> +static ssize_t ayaneo_module_show(struct device *dev, char *buf, bool ri=
ght)
> +{
> +=09struct ayaneo *aya =3D dev_get_drvdata(dev);
> +=09struct aya3_resp resp;
> +=09int ret =3D 0;
> +
> +=09scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock)
> +=09=09ret =3D ayaneo_check(aya, &resp, AYA3_CMD_ATTEMPTS);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09return sysfs_emit(buf, "0x%02x\n",
> +=09=09=09  right ? resp.module_right : resp.module_left);
> +}
> +
> +static ssize_t module_left_show(struct device *dev,
> +=09=09=09=09struct device_attribute *attr, char *buf)
> +{
> +=09return ayaneo_module_show(dev, buf, false);
> +}
> +static DEVICE_ATTR_RO(module_left);
> +
> +static ssize_t module_right_show(struct device *dev,
> +=09=09=09=09 struct device_attribute *attr, char *buf)
> +{
> +=09return ayaneo_module_show(dev, buf, true);
> +}
> +static DEVICE_ATTR_RO(module_right);
> +
> +static ssize_t eject_store(struct device *dev, struct device_attribute *=
attr,
> +=09=09=09   const char *buf, size_t count)
> +{
> +=09struct ayaneo *aya =3D dev_get_drvdata(dev);
> +=09struct aya3_resp resp;
> +=09u8 eject;
> +=09int ret =3D 0, err, i;

Reverse xmas-tree order.

> +
> +=09if (sysfs_streq(buf, "left"))
> +=09=09eject =3D AYA3_EJECT_LEFT;
> +=09else if (sysfs_streq(buf, "right"))
> +=09=09eject =3D AYA3_EJECT_RIGHT;
> +=09else if (sysfs_streq(buf, "both"))
> +=09=09eject =3D AYA3_EJECT_LEFT | AYA3_EJECT_RIGHT;
> +=09else
> +=09=09return -EINVAL;
> +
> +=09scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +=09=09unsigned long deadline =3D jiffies +
> +=09=09=09=09=09 msecs_to_jiffies(AYA3_EJECT_MIN_MS);
> +
> +=09=09ret =3D ayaneo_send_config(aya, eject);
> +=09=09if (ret)
> +=09=09=09break;
> +
> +=09=09/*
> +=09=09 * Wait for the firmware to report the eject as done: no
> +=09=09 * bits outside AYA3_EJECT_DONE_MASK set, matching
> +=09=09 * Handheld Daemon's verification. The in-progress state
> +=09=09 * is reported from the first poll, and the minimum-time
> +=09=09 * floor below guards the power-cut step regardless.
> +=09=09 */
> +=09=09ret =3D -ETIMEDOUT;
> +=09=09for (i =3D 0; i < AYA3_EJECT_POLLS; i++) {
> +=09=09=09if (msleep_interruptible(AYA3_EJECT_POLL_MS)) {
> +=09=09=09=09ret =3D -EINTR;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09=09err =3D ayaneo_check(aya, &resp, 1);
> +=09=09=09if (err =3D=3D -ETIMEDOUT)
> +=09=09=09=09continue;=09/* busy mid-eject, keep polling */
> +=09=09=09if (err) {
> +=09=09=09=09ret =3D err;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09=09if (!(resp.eject_status & ~AYA3_EJECT_DONE_MASK)) {
> +=09=09=09=09ret =3D 0;
> +=09=09=09=09break;
> +=09=09=09}
> +=09=09}
> +
> +=09=09/*
> +=09=09 * The firmware wants a minimum time between the eject
> +=09=09 * command and the power cut that follows this write.
> +=09=09 */
> +=09=09if (!ret && time_before(jiffies, deadline)) {
> +=09=09=09if (msleep_interruptible(jiffies_to_msecs(deadline -
> +=09=09=09=09=09=09=09=09  jiffies)))
> +=09=09=09=09ret =3D -EINTR;
> +=09=09}
> +=09}
> +=09return ret ? ret : count;
> +}
> +static DEVICE_ATTR_WO(eject);
> +
> +static ssize_t reset_store(struct device *dev, struct device_attribute *=
attr,
> +=09=09=09   const char *buf, size_t count)
> +{
> +=09struct ayaneo *aya =3D dev_get_drvdata(dev);
> +=09bool value;
> +=09int ret;
> +
> +=09ret =3D kstrtobool(buf, &value);
> +=09if (ret)
> +=09=09return ret;
> +=09if (!value)
> +=09=09return count;
> +
> +=09scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +=09=09ret =3D ayaneo_send_config(aya, AYA3_RESET);
> +=09=09if (!ret) {
> +=09=09=09msleep(AYA3_RESET_SETTLE_MS);
> +=09=09=09ret =3D ayaneo_send_config(aya, 0);
> +=09=09}
> +=09}
> +=09return ret ? ret : count;
> +}
> +static DEVICE_ATTR_WO(reset);
> +
> +/*
> + * Rumble intensity names, index-aligned with the wire values through
> + * ayaneo_rumble_levels below.
> + */
> +static const char * const ayaneo_rumble_names[] =3D {
> +=09"off", "low", "medium", "high",
> +};
> +
> +static const u8 ayaneo_rumble_levels[] =3D {
> +=09AYA3_VIBRATION_OFF,
> +=09AYA3_VIBRATION_LOW,
> +=09AYA3_VIBRATION_MEDIUM,
> +=09AYA3_VIBRATION_HIGH,
> +};
> +
> +static ssize_t rumble_intensity_show(struct device *dev,
> +=09=09=09=09     struct device_attribute *attr, char *buf)
> +{
> +=09struct ayaneo *aya =3D dev_get_drvdata(dev);
> +=09u8 level;
> +=09int i;
> +
> +=09/*
> +=09 * Single-byte snapshot; writers serialize on aya->lock, and a
> +=09 * racing update is harmless, while taking the mutex here would
> +=09 * block trivial reads behind a multi-second eject.
> +=09 */
> +=09level =3D READ_ONCE(aya->vibration);
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(ayaneo_rumble_levels); i++) {

Add include.

> +=09=09if (ayaneo_rumble_levels[i] =3D=3D level)
> +=09=09=09return sysfs_emit(buf, "%s\n", ayaneo_rumble_names[i]);
> +=09}
> +=09return -EINVAL;
> +}
> +
> +static ssize_t rumble_intensity_store(struct device *dev,
> +=09=09=09=09      struct device_attribute *attr,
> +=09=09=09=09      const char *buf, size_t count)
> +{
> +=09struct ayaneo *aya =3D dev_get_drvdata(dev);
> +=09u8 previous;
> +=09int ret;
> +
> +=09ret =3D sysfs_match_string(ayaneo_rumble_names, buf);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {

ACQUIRE + ACQUIRE_ERR() is better interface for _intr & other=20
conditions.

> +=09=09previous =3D aya->vibration;
> +=09=09aya->vibration =3D ayaneo_rumble_levels[ret];
> +=09=09ret =3D ayaneo_send_config(aya, 0);
> +=09=09if (ret) {
> +=09=09=09aya->vibration =3D previous;
> +=09=09=09return ret;
> +=09=09}
> +=09}
> +=09return count;
> +}
> +static DEVICE_ATTR_RW(rumble_intensity);
> +
> +static ssize_t rumble_intensity_index_show(struct device *dev,
> +=09=09=09=09=09   struct device_attribute *attr,
> +=09=09=09=09=09   char *buf)
> +{
> +=09ssize_t count =3D 0;
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(ayaneo_rumble_names); i++)
> +=09=09count +=3D sysfs_emit_at(buf, count, "%s ",
> +=09=09=09=09       ayaneo_rumble_names[i]);

I'd put this on oneline. No useful information is lost with the last two=20
chars out of screen even on 80 char view.

If you insist on keeping it like this, add braces as with any other=20
multiline construct in a body.

> +
> +=09if (count)
> +=09=09buf[count - 1] =3D '\n';
> +
> +=09return count;
> +}
> +static DEVICE_ATTR_RO(rumble_intensity_index);
> +
> +static struct attribute *ayaneo_attrs[] =3D {
> +=09&dev_attr_module_left.attr,
> +=09&dev_attr_module_right.attr,
> +=09&dev_attr_eject.attr,
> +=09&dev_attr_reset.attr,
> +=09&dev_attr_rumble_intensity.attr,
> +=09&dev_attr_rumble_intensity_index.attr,
> +=09NULL
> +};
> +
> +static const struct attribute_group ayaneo_group =3D {
> +=09.attrs =3D ayaneo_attrs,
> +};
> +
> +static int ayaneo_led_set(struct led_classdev *cdev, enum led_brightness=
 value)
> +{
> +=09struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +=09struct ayaneo *aya =3D container_of(mc, struct ayaneo, mcled);

Add include.

> +=09int ret =3D 0, i;
> +
> +=09scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +=09=09led_mc_calc_color_components(mc, value);
> +=09=09aya->brightness =3D min_t(unsigned int, value, 255);
> +=09=09for (i =3D 0; i < 3; i++)

ARRAY_SIZE()

> +=09=09=09aya->rgb[i] =3D min_t(unsigned int,
> +=09=09=09=09=09    aya->subleds[i].brightness, 255);

min(aya->subleds[i].brightness, U8_MAX) ?

> +
> +=09=09ret =3D ayaneo_send_config(aya, 0);
> +=09=09if (ret)
> +=09=09=09hid_err(aya->hdev,
> +=09=09=09=09"failed to update RGB config: %d\n", ret);
> +=09}
> +=09return ret;
> +}
> +
> +static ssize_t effect_show(struct device *dev, struct device_attribute *=
attr,
> +=09=09=09   char *buf)
> +{
> +=09struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +=09struct ayaneo *aya =3D container_of(lcdev_to_mccdev(cdev),
> +=09=09=09=09=09  struct ayaneo, mcled);
> +=09u8 effect;
> +
> +=09/*
> +=09 * Single-byte snapshot; writers serialize on aya->lock, and a
> +=09 * racing update is harmless, while taking the mutex here would
> +=09 * block trivial reads behind a multi-second eject.
> +=09 */
> +=09effect =3D READ_ONCE(aya->effect);
> +
> +=09return sysfs_emit(buf, "%s\n", ayaneo_effect_names[effect]);
> +}
> +
> +static ssize_t effect_store(struct device *dev, struct device_attribute =
*attr,
> +=09=09=09    const char *buf, size_t count)
> +{
> +=09struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +=09struct ayaneo *aya =3D container_of(lcdev_to_mccdev(cdev),
> +=09=09=09=09=09  struct ayaneo, mcled);
> +=09u8 previous;
> +=09int ret;
> +
> +=09ret =3D sysfs_match_string(ayaneo_effect_names, buf);
> +=09if (ret < 0)
> +=09=09return ret;
> +
> +=09scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +=09=09previous =3D aya->effect;
> +=09=09if (previous =3D=3D ret)
> +=09=09=09return count;
> +=09=09aya->effect =3D ret;

I think better naming would make this much more readable. Renaming=20
previous -> old_val and ret -> val would make it much more readable.

You can keep ret for this:

> +=09=09ret =3D ayaneo_send_config(aya, 0);
> +=09=09if (ret) {
> +=09=09=09aya->effect =3D previous;
> +=09=09=09return ret;
> +=09=09}
> +=09}
> +=09return count;
> +}
> +static DEVICE_ATTR_RW(effect);
> +
> +static ssize_t effect_index_show(struct device *dev,
> +=09=09=09=09 struct device_attribute *attr, char *buf)
> +{
> +=09ssize_t count =3D 0;
> +=09int i;
> +
> +=09for (i =3D 0; i < ARRAY_SIZE(ayaneo_effect_names); i++)
> +=09=09count +=3D sysfs_emit_at(buf, count, "%s ",
> +=09=09=09=09       ayaneo_effect_names[i]);

Braces if it doesn't fit to one line. I suspect it's same as the previous=
=20
one though and could be one line without any loss of clarity.

> +
> +=09if (count)
> +=09=09buf[count - 1] =3D '\n';
> +
> +=09return count;
> +}
> +static DEVICE_ATTR_RO(effect_index);
> +
> +static struct attribute *ayaneo_led_attrs[] =3D {
> +=09&dev_attr_effect.attr,
> +=09&dev_attr_effect_index.attr,
> +=09NULL
> +};
> +
> +static const struct attribute_group ayaneo_led_group =3D {
> +=09.attrs =3D ayaneo_led_attrs,
> +};
> +
> +/*
> + * The final LED write issued by the unregister needs its reply; callers
> + * keep IO working (probe leaves it started, remove re-enables it).
> + */
> +static void ayaneo_unregister_led(struct ayaneo *aya)
> +{
> +=09led_classdev_multicolor_unregister(&aya->mcled);
> +=09flush_work(&aya->mcled.led_cdev.set_brightness_work);
> +}
> +
> +static int ayaneo_register_led(struct ayaneo *aya)
> +{
> +=09struct led_classdev *cdev =3D &aya->mcled.led_cdev;
> +=09int ret, i;
> +
> +=09aya->subleds[0].color_index =3D LED_COLOR_ID_RED;
> +=09aya->subleds[1].color_index =3D LED_COLOR_ID_GREEN;
> +=09aya->subleds[2].color_index =3D LED_COLOR_ID_BLUE;
> +=09/*
> +=09 * Full intensity by default so brightness writes produce light
> +=09 * before userspace sets multi_intensity (querying the firmware
> +=09 * for its value would break the no-probe-traffic policy).
> +=09 */
> +=09for (i =3D 0; i < 3; i++)

ARRAY_SIZE()

> +=09=09aya->subleds[i].intensity =3D 255;

U8_MAX ?

> +=09aya->mcled.subled_info =3D aya->subleds;
> +=09aya->mcled.num_colors =3D 3;
> +
> +=09cdev->name =3D devm_kasprintf(&aya->hdev->dev, GFP_KERNEL,
> +=09=09=09=09    "%s:rgb:joystick_rings",
> +=09=09=09=09    dev_name(&aya->hdev->dev));
> +=09if (!cdev->name)
> +=09=09return -ENOMEM;
> +=09cdev->color =3D LED_COLOR_ID_RGB;
> +=09cdev->brightness =3D 0;
> +=09cdev->max_brightness =3D 255;

U8_MAX ?

> +=09cdev->brightness_set_blocking =3D ayaneo_led_set;
> +
> +=09/*
> +=09 * Not devm: the LED must be unregistered before hid_hw_stop(), or a
> +=09 * racing brightness write could reach a torn-down transport.
> +=09 */
> +=09ret =3D led_classdev_multicolor_register(&aya->hdev->dev, &aya->mcled=
);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/*
> +=09 * The multicolor class adds its own groups at registration, so the
> +=09 * effect attributes are added after and tied to the LED device.
> +=09 */
> +=09ret =3D devm_device_add_group(cdev->dev, &ayaneo_led_group);
> +=09if (ret)
> +=09=09ayaneo_unregister_led(aya);
> +=09return ret;
> +}
> +
> +static const struct dmi_system_id ayaneo_dmi_table[] =3D {
> +=09{
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +=09=09=09DMI_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
> +=09=09},
> +=09},
> +=09{}
> +};
> +
> +static int ayaneo_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> +{
> +=09struct ayaneo *aya;
> +=09int ret;
> +
> +=09ret =3D hid_parse(hdev);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09/*
> +=09 * The VID/PID is a generic SigmaMicro ID shared by the gamepad,
> +=09 * keyboard and vendor interfaces, and by unrelated devices on
> +=09 * other machines. Refusing those probes would strand them, as
> +=09 * hid-generic yields any device that another driver's id table
> +=09 * matches. Everything that is not the AYANEO 3 vendor interface
> +=09 * is therefore started as a transparent generic device, exactly
> +=09 * as hid-generic would have started it.
> +=09 */
> +=09if (!dmi_check_system(ayaneo_dmi_table) || !hid_is_usb(hdev) ||
> +=09    !hdev->maxcollection ||
> +=09    hdev->collection->type !=3D HID_COLLECTION_APPLICATION ||
> +=09    hdev->collection->usage !=3D AYA3_APP_USAGE) {
> +=09=09hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;
> +=09=09return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +=09}
> +
> +=09aya =3D devm_kzalloc(&hdev->dev, sizeof(*aya), GFP_KERNEL);
> +=09if (!aya)
> +=09=09return -ENOMEM;
> +
> +=09aya->xfer =3D devm_kzalloc(&hdev->dev, AYA3_REPORT_SIZE, GFP_KERNEL);
> +=09if (!aya->xfer)
> +=09=09return -ENOMEM;
> +
> +=09aya->hdev =3D hdev;
> +=09aya->vibration =3D AYA3_VIBRATION_MEDIUM;
> +=09init_completion(&aya->resp_done);
> +=09spin_lock_init(&aya->resp_lock);
> +=09ret =3D devm_mutex_init(&hdev->dev, &aya->lock);
> +=09if (ret)
> +=09=09return ret;
> +=09hid_set_drvdata(hdev, aya);
> +
> +=09ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09ret =3D hid_hw_open(hdev);
> +=09if (ret)
> +=09=09goto err_stop;
> +
> +=09/*
> +=09 * Report delivery is off during probe by default, but the LED and
> +=09 * attributes go live below and their first commands need replies, so
> +=09 * leave IO started.
> +=09 */
> +=09hid_device_io_start(hdev);
> +
> +=09ret =3D ayaneo_register_led(aya);
> +=09if (ret)
> +=09=09goto err_close;
> +
> +=09ret =3D sysfs_create_group(&hdev->dev.kobj, &ayaneo_group);
> +=09if (ret)
> +=09=09goto err_led;
> +
> +=09return 0;
> +
> +err_led:
> +=09ayaneo_unregister_led(aya);
> +err_close:
> +=09hid_hw_close(hdev);
> +err_stop:
> +=09hid_hw_stop(hdev);
> +=09return ret;
> +}
> +
> +static void ayaneo_remove(struct hid_device *hdev)
> +{
> +=09struct ayaneo *aya =3D hid_get_drvdata(hdev);
> +
> +=09if (!aya) {
> +=09=09hid_hw_stop(hdev);
> +=09=09return;
> +=09}
> +
> +=09/*
> +=09 * The HID core stops report delivery before remove, but the final
> +=09 * LED write and the group removal's in-flight attribute callers
> +=09 * still need replies. Re-enable IO for the teardown writes.
> +=09 */
> +=09hid_device_io_start(hdev);
> +=09sysfs_remove_group(&hdev->dev.kobj, &ayaneo_group);
> +=09led_classdev_multicolor_unregister(&aya->mcled);
> +=09/*
> +=09 * A brightness store racing the unregister can requeue
> +=09 * set_brightness_work after led_classdev_unregister()'s flush, so
> +=09 * flush it again before stopping IO, while the transport is up.
> +=09 */
> +=09flush_work(&aya->mcled.led_cdev.set_brightness_work);
> +=09hid_device_io_stop(hdev);
> +=09hid_hw_close(hdev);
> +=09hid_hw_stop(hdev);
> +}
> +
> +static int ayaneo_reset_resume(struct hid_device *hdev)
> +{
> +=09struct ayaneo *aya =3D hid_get_drvdata(hdev);
> +=09int ret =3D 0;
> +
> +=09/* Transparent interfaces: mirror hid-generic's reset_resume */
> +=09if (!aya) {
> +=09=09if (hdev->claimed & HID_CLAIMED_INPUT)
> +=09=09=09hidinput_reset_resume(hdev);
> +=09=09return 0;
> +=09}
> +
> +=09scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +=09=09if (aya->configured)
> +=09=09=09ret =3D ayaneo_send_config(aya, 0);

With ACQUIRE(), you can just return right away and drop ret variable.

> +=09}
> +=09return ret;
> +}
> +
> +static const struct hid_device_id ayaneo_devices[] =3D {
> +=09{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO,
> +=09=09=09 USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD) },
> +=09{}
> +};
> +MODULE_DEVICE_TABLE(hid, ayaneo_devices);
> +
> +static struct hid_driver ayaneo_driver =3D {
> +=09.name =3D "hid-ayaneo",
> +=09.id_table =3D ayaneo_devices,
> +=09.probe =3D ayaneo_probe,
> +=09.remove =3D ayaneo_remove,
> +=09.raw_event =3D ayaneo_raw_event,
> +=09.reset_resume =3D ayaneo_reset_resume,
> +};
> +module_hid_driver(ayaneo_driver);
> +
> +MODULE_AUTHOR("Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>");
> +MODULE_DESCRIPTION("AYANEO 3 detachable controller driver");
> +MODULE_LICENSE("GPL");
>=20
> base-commit: 720806515cb6921ab05caaa6f470f7054b56385e
>=20

--=20
 i.

--8323328-1731197562-1794608338=:6498--
