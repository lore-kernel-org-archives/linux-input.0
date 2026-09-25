Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CE0419303
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 10:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330495; cv=none; b=YBgEghf64fQnGRn/MacUGL7rd7ORgejA8J1a2xR0PvgXksVk+l0VhkKrATlZmmxmZ1HK8Yx43kjVjxmGyCaJ2iF9J5U3ARq6TkoYXgx1F7i1+WjyqYHRcoICfcaATkniZjEYv7MsS2pg6eHCTdwZL3Ty1Y8ASt7NOv/tQzRibHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330495; c=relaxed/simple;
	bh=C+rHaY0h/+Me6NKzWRRxHlmPFYJarUTbKkmWNL6V+Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3ks0545OismWfLmhZX4Dk09XDoKNd49ENyWVVorYvlwZC40b8pNH5NqFrcHuGtnN00M3erBqGjnPbXx06IxmlMc6/36ffdoYNOgoi0MTNCnW4jxOlvtWAWqtphmolghJhdgMfSP6xEGI7ztwtRVeHLhoelK/UlpNXOE8WBKkLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=GxF+gvQD; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="GxF+gvQD"
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 480C55E68A
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 13:01:21 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id 43F985E6CB
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 13:01:17 +0300 (EEST)
Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 84B401FF9CC
	for <linux-input@vger.kernel.org>; Fri, 25 Sep 2026 13:01:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1790330476;
	bh=pFYdOjqocs/GtRUkoMoRjE9kGYYx8XXRejLxo5Mb52A=;
	h=Received:From:Subject:To;
	b=GxF+gvQDHGygxRvglsuFzC9LYatff/CDp3FtuOR6kD/QB5Fpck7Zo5UHS0PuJdDuK
	 zjK715hn5pukE+ivfoUt0Cj0MzT63DAmE63FHRubEkf6b9AGpOMhvAchb/sOX5ykMU
	 lXa0WVTVAn1LLxwLSh8jdQG+0cWfZgdwLy18oBfQTNxg8xxOuMkJgy8RoAOqljFg5I
	 kgACzXA0+hBgxyngplMZvJ07I7uvCM4FkV5uQH4+sAoOA43IoGicK2tmyG2imUikau
	 oF/CCNCJKdwwlfQueF3vwvj6+1PppudUOHfxGwQnPuQw+Z/2oCLTFagxFMcqTYrbiX
	 K+7UTnwx8gW5Q==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 74.125.228.42) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pz2-f42.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pz2-f42.google.com with SMTP id
 41be03b00d2f7-cc433d52421so242296a12.3
        for <linux-input@vger.kernel.org>;
 Fri, 25 Sep 2026 03:01:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AKwUvBwATNpwrbvfV+LOMqcesDuEBx5viSctKHHKsJYHz3xcYb6WohrmeRsGZlAZTpiFdQBECdSbkjrmnmcHCQ==@vger.kernel.org
X-Gm-Message-State: AFuF++m7Sf0zYLkpIURkG7gN8v2C00Wd+gfEgAZEp9kFakL3D1+KZKUZ
	sMUOSAA8qE/q5afTDsq6orx0WRHMsWN1ncbiT2R0UF2sN75crGZrl7x6/LxoKucEmMAou5lTKOM
	sXMocyK92Xwvk+jqK5OAGS6W1EFiVmG4=
X-Received: by 2002:a05:6a20:6a06:b0:3bf:7e2a:e874 with SMTP id
 adf61e73a8af0-3de0e71362fmr4719931637.1.1790330472350; Fri, 25 Sep 2026
 03:01:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925061941.75121-1-hello@matias.me>
In-Reply-To: <20260925061941.75121-1-hello@matias.me>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Fri, 25 Sep 2026 12:01:00 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwEDBCs3zmCb6xbTBd48F+tbFOtZC-sC+F5uGvo82UL4zg@mail.gmail.com>
X-Gm-Features: AclHuK8OPFoZFYEHfxj_6vAA4uCtxh1TZY-lMDR2Xx5TtcFCN60Bf55KUcP5sR0
Message-ID: 
 <CAGwozwEDBCs3zmCb6xbTBd48F+tbFOtZC-sC+F5uGvo82UL4zg@mail.gmail.com>
Subject: Re: [PATCH v4] HID: ayaneo: Add AYANEO 3 detachable controller driver
To: =?UTF-8?B?TWF0w61hcyBNYXJ0w61uZXo=?= <hello@matias.me>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Denis Benato <denis.benato@linux.dev>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Armin Wolf <W_Armin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <179033047545.3626052.4344808052128735103@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Fri, 25 Sept 2026 at 08:20, Mat=C3=ADas Mart=C3=ADnez <hello@matias.me> =
wrote:
>
> The AYANEO 3 handheld has a detachable controller with swappable
> modules ("Magic Modules"). The controller exposes three USB HID
> interfaces behind 1c4f:0002 (a generic SigmaMicro VID/PID): a gamepad,
> a keyboard for the extra buttons, and a vendor interface accepting
> 65-byte commands.
>
> Add a driver claiming every interface of the shared ID. Interfaces
> other than the AYANEO 3 vendor interface are started as transparent
> generic devices, with reset_resume mirrored from hid-generic:
> hid-generic yields any device that another driver's id table matches,
> so refusing those probes would leave the input interfaces driverless
> when the driver is present at boot.
>
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
>
> This complements the ayaneo-ec platform driver, which exposes module
> attach state and controller power. A full physical eject is performed
> by writing to eject and then cutting power through ayaneo-ec's
> controller_power attribute; that orchestration is deliberately left
> to userspace.
>
> The protocol was reverse engineered in the Handheld Daemon project by
> Antheas Kapenekakis. Tested on an AYANEO 3: module identification,
> RGB solid, breathing and rainbow at several brightness levels, rumble
> level selection, gamepad and keyboard input through the transparent
> interfaces, a full eject/reinsert/repower cycle with the re-enumerated
> interfaces binding cleanly, and repeated driver unbinds under a
> concurrent brightness-write load.
>
> Signed-off-by: Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> ---
> Changes in v4:
> - Sent as a fresh thread. [Derek J. Clark]
> - Expose the firmware effects through effect/effect_index on the LED
>   device (monocolor, breathe, rainbow) and drop the hw_pattern
>   trigger interface and its ABI document. [Antheas Kapenekakis]
>   The attributes are documented in this driver's ABI file, following
>   the per-driver precedent set by sysfs-driver-hid-lenovo-go-s.
>   Antheas suggested generalizing the lenovo-go file instead, but that
>   left it internally inconsistent (its other entries on the same LED
>   keep the go: prefix) and placed this driver's ABI outside its
>   MAINTAINERS entry, so the lenovo-go-s model won.

That is fine. You should have asked for me to clarify. This driver
does not need to own that sysfs entry.

> - Add the firmware's fixed-tempo colour cycle as the "rainbow"
>   effect. It was in Handheld Daemon all along and I had missed it.
>   [sknowledge1]
> - Claim all interfaces of the shared SigmaMicro ID and start the
>   non-vendor ones as transparent generic devices, including
>   hid-generic's reset_resume behaviour: hid-generic yields any device
>   another driver's id table matches, so the previous -ENODEV probes
>   could leave the input interfaces driverless with the driver present
>   at boot. [reported by sknowledge1]
> - Reapply the configuration on reset_resume, only once one was
>   successfully applied at userspace's request.
> - Remove the sysfs attribute group before tearing down the transport
>   in remove, and keep IO enabled from probe on so attribute callers
>   and the final LED write always see their replies. [teardown reply
>   issue reported by sknowledge1]
> - Protect the reply-matching state shared with raw_event with a
>   spinlock instead of bare READ_ONCE/WRITE_ONCE.
> - Expose the vibration strength as rumble_intensity plus an index
>   attribute instead of hardcoding a level. [Antheas Kapenekakis]
> - Drop the probe-time status check, so the driver generates no
>   traffic unless userspace asks. [Antheas Kapenekakis]
> - Make the eject polling interruptible with single command attempts,
>   and enforce the firmware's minimum eject settle time before the
>   write returns (inherited from Handheld Daemon's AYA_MIN_EJECT).
> - Default the subled intensities to full so brightness writes produce
>   light before userspace configures colours.

You mean the opposite? Writes to colors produce full brightness if
brightness is not written? Because the other way is not a problem. You
can skip led writes if a color has not been provided.

> - Use the hid-ids.h defines for the shared SigmaMicro ID; tighten the
>   vendor-collection gate; build the _index strings from the arrays.
> - Dropped Denis' v1 Reviewed-by given the extent of this rework.
> - Reword comments, fix the trailer order, Kconfig module sentence.
>
> Note: checkpatch flags the -ENOSYS check in ayaneo_send() as a
> misuse; it is the standard hid_hw_output_report() fallback (the
> transport returns -ENOSYS when it has no output report path).
>
> v3: https://lore.kernel.org/linux-input/20260917160722.89391-1-hello@mati=
as.me/
>
>  .../ABI/testing/sysfs-driver-hid-ayaneo       |  75 ++
>  MAINTAINERS                                   |   7 +
>  drivers/hid/Kconfig                           |  17 +
>  drivers/hid/Makefile                          |   1 +
>  drivers/hid/hid-ayaneo.c                      | 888 ++++++++++++++++++
>  5 files changed, 988 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-ayaneo
>  create mode 100644 drivers/hid/hid-ayaneo.c
>
> diff --git a/Documentation/ABI/testing/sysfs-driver-hid-ayaneo b/Document=
ation/ABI/testing/sysfs-driver-hid-ayaneo
> new file mode 100644
> index 000000000..525b08277
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-hid-ayaneo
> @@ -0,0 +1,75 @@
> +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/module_left
> +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/module_right
> +Date:          September 2026
> +KernelVersion: 7.4
> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +               Reports the type of the module currently inserted in the
> +               left/right slot of the AYANEO 3 detachable controller, as
> +               the raw identifier reported by the controller firmware in
> +               hexadecimal (e.g. "0x04"). Bits 0-5 encode the module
> +               type, bit 6 indicates the module is inserted rotated.
> +
> +               Reading these attributes queries the controller and can
> +               take up to a second.
> +
> +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/eject
> +Date:          September 2026
> +KernelVersion: 7.4
> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +               Write-only. Writing "left", "right" or "both" asks the
> +               controller firmware to release the corresponding
> +               module(s). The write blocks until the firmware confirms
> +               the release handshake (typically a few seconds). The
> +               module is physically released once controller power is
> +               subsequently cut through the ayaneo-ec platform driver's
> +               controller_power attribute. That final step is left to
> +               userspace.
> +
> +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/reset
> +Date:          September 2026
> +KernelVersion: 7.4
> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +               Write-only. Writing "1" asks the controller firmware to
> +               perform a quick reset of the controller configuration.
> +
> +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/rumble_intensity
> +Date:          September 2026
> +KernelVersion: 7.4
> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +               Controls the vibration strength of the AYANEO 3 controlle=
r
> +               rumble motors. Reading returns the selected level. Suppor=
ted
> +               writes are the values listed by rumble_intensity_index.
> +               Defaults to "medium", matching the firmware default.
> +
> +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/rumble_intensity_in=
dex
> +Date:          September 2026
> +KernelVersion: 7.4
> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +               Read-only. Space-separated list of the supported
> +               rumble_intensity values: "off low medium high".
> +
> +What:          /sys/class/leds/<dev>:rgb:joystick_rings/effect
> +Date:          September 2026
> +KernelVersion: 7.4
> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +               Controls the firmware LED effect of the joystick rings.
> +
> +               Values are "monocolor", "breathe" or "rainbow", as listed
> +               by the effect_index attribute. "rainbow" is a
> +               firmware-timed colour cycle whose hue and tempo are fixed
> +               by the firmware: brightness scales its amplitude and the
> +               multi_intensity values are ignored while it is selected.
> +
> +What:          /sys/class/leds/<dev>:rgb:joystick_rings/effect_index
> +Date:          September 2026
> +KernelVersion: 7.4
> +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +Description:
> +               Read-only. Space-separated list of the supported effect
> +               values: "monocolor breathe rainbow".

You cannot add a new sysfs entry for an existing ABI. You must correct
the original one or move the led registrations to their own unique
file and correct them.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8ffd8336..a82546467 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4508,6 +4508,13 @@ F:       Documentation/devicetree/bindings/spi/axi=
ado,ax3000-spi.yaml
>  F:     drivers/spi/spi-axiado.c
>  F:     drivers/spi/spi-axiado.h
>
> +AYANEO 3 CONTROLLER HID DRIVER
> +M:     Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> +L:     linux-input@vger.kernel.org
> +S:     Maintained
> +F:     Documentation/ABI/testing/sysfs-driver-hid-ayaneo
> +F:     drivers/hid/hid-ayaneo.c
> +
>  AYANEO PLATFORM EC DRIVER
>  M:     Antheas Kapenekakis <lkml@antheas.dev>
>  L:     platform-driver-x86@vger.kernel.org
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 0e3a0ccd6..0ff27b11b 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -205,6 +205,23 @@ config HID_AUREAL
>         help
>         Support for Aureal Cy se W-01RN Remote Controller and other Aurea=
l derived remotes.
>
> +config HID_AYANEO
> +       tristate "AYANEO 3 detachable controller support"
> +       depends on USB_HID
> +       depends on DMI
> +       depends on LEDS_CLASS_MULTICOLOR
> +       help
> +         Provides support for the detachable controller ("Magic Modules"=
)
> +         of the AYANEO 3 handheld: module identification, software eject
> +         and RGB control of the joystick rings. Complements the ayaneo-e=
c
> +         platform driver, which handles module attach state and controll=
er
> +         power.
> +
> +         Say Y or M here if you have an AYANEO 3.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called hid-ayaneo.
> +
>  config HID_BELKIN
>         tristate "Belkin Flip KVM and Wireless keyboard"
>         help
> diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> index 79384d905..2f74f2867 100644
> --- a/drivers/hid/Makefile
> +++ b/drivers/hid/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_HID_APPLETB_KBD) +=3D hid-appletb-kbd.o
>  obj-$(CONFIG_HID_CREATIVE_SB0540)      +=3D hid-creative-sb0540.o
>  obj-$(CONFIG_HID_ASUS)         +=3D hid-asus.o
>  obj-$(CONFIG_HID_AUREAL)       +=3D hid-aureal.o
> +obj-$(CONFIG_HID_AYANEO)       +=3D hid-ayaneo.o
>  obj-$(CONFIG_HID_BELKIN)       +=3D hid-belkin.o
>  obj-$(CONFIG_HID_BETOP_FF)     +=3D hid-betopff.o
>  obj-$(CONFIG_HID_BIGBEN_FF)    +=3D hid-bigbenff.o
> diff --git a/drivers/hid/hid-ayaneo.c b/drivers/hid/hid-ayaneo.c
> new file mode 100644
> index 000000000..6bbfcc54a
> --- /dev/null
> +++ b/drivers/hid/hid-ayaneo.c
> @@ -0,0 +1,888 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * HID driver for the AYANEO 3 detachable controller ("Magic Modules").
> + *
> + * The AYANEO 3 controller exposes three USB HID interfaces behind
> + * VID 0x1c4f PID 0x0002 (a generic SigmaMicro ID): a gamepad, a
> + * keyboard for the extra buttons, and a vendor interface (application
> + * usage 0xff000001) accepting 65-byte commands.
> + *
> + * The driver claims every interface of the shared ID because
> + * hid-generic yields any device another driver's id table matches.
> + * Interfaces other than the AYANEO 3 vendor interface are started as
> + * transparent generic devices. On the vendor interface it provides:
> + *  - module identification (which module type is inserted on each side)
> + *  - software eject of the left/right modules
> + *  - RGB control of the joystick rings as a multicolor LED class device
> + *  - rumble intensity selection
> + *  - configuration reset
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
> +#define AYA3_REPORT_SIZE       65
> +#define AYA3_RESP_SIZE         64
> +
> +/*
> + * Empirical timings, inherited from the Handheld Daemon
> + * implementation of this protocol and validated on hardware: the
> + * device answers well within 300ms or not at all, needs about half
> + * a second to settle after a reset before it accepts a new
> + * configuration, and completes an eject handshake within a few
> + * seconds (polled below at a rate that keeps the sysfs write
> + * responsive). The firmware also wants a minimum settle time between
> + * an eject command and the subsequent power cut (value inherited from
> + * Handheld Daemon's AYA_MIN_EJECT).
> + */
> +#define AYA3_CMD_TIMEOUT_MS    300
> +#define AYA3_CMD_ATTEMPTS      3
> +#define AYA3_RESET_SETTLE_MS   500
> +#define AYA3_EJECT_POLL_MS     400
> +#define AYA3_EJECT_POLLS       20
> +#define AYA3_EJECT_MIN_MS      3000
> +
> +/* Subcommands (byte 4). Byte 3 is 0x00 except for the config command. *=
/
> +#define AYA3_SUBCMD_CHECK      0x08
> +#define AYA3_CMD_CONFIG                0x21
> +#define AYA3_SUBCMD_CONFIG     0x09
> +
> +/* Bits that stay set in the eject status byte after an eject completes =
*/
> +#define AYA3_EJECT_DONE_MASK   0x11
> +
> +/* Application usage of the vendor interface's first collection */
> +#define AYA3_APP_USAGE         (HID_UP_MSVENDOR | 0x0001)
> +
> +/* Config command eject/reset field */
> +#define AYA3_EJECT_LEFT                0x07
> +#define AYA3_EJECT_RIGHT       0x70
> +#define AYA3_RESET             0x88
> +
> +/* Config command RGB modes */
> +#define AYA3_RGB_SOLID         0x01
> +#define AYA3_RGB_PULSE         0x02
> +#define AYA3_RGB_RAINBOW       0x03
> +#define AYA3_RGB_OFF           0xff
> +
> +/* Config command vibration levels, stored in the high nibble */
> +enum aya3_vibration {
> +       AYA3_VIBRATION_LOW      =3D 0x1,
> +       AYA3_VIBRATION_MEDIUM   =3D 0x2,
> +       AYA3_VIBRATION_HIGH     =3D 0x3,
> +       AYA3_VIBRATION_OFF      =3D 0x4,
> +};
> +
> +/* Firmware LED effects selectable through the LED "effect" attribute */
> +enum aya3_effect {
> +       AYA3_EFFECT_MONOCOLOR,
> +       AYA3_EFFECT_BREATHE,
> +       AYA3_EFFECT_RAINBOW,
> +};
> +
> +static const char * const ayaneo_effect_names[] =3D {
> +       [AYA3_EFFECT_MONOCOLOR] =3D "monocolor",
> +       [AYA3_EFFECT_BREATHE]   =3D "breathe",
> +       [AYA3_EFFECT_RAINBOW]   =3D "rainbow",
> +};
> +
> +struct aya3_rgb {
> +       u8 mode;
> +       u8 r;
> +       u8 g;
> +       u8 b;
> +} __packed;
> +
> +/*
> + * The 65-byte config command. The checksum is the little-endian sum of
> + * bytes 7..64. The unk* fields are sent as zero.
> + */
> +struct aya3_config {
> +       u8 report_id;
> +       __le16 csum;
> +       u8 cmd;
> +       u8 subcmd;
> +       u8 unk5[3];
> +       struct aya3_rgb right;
> +       struct aya3_rgb left;
> +       u8 unk16[4];
> +       u8 eject;
> +       u8 unk21;
> +       u8 sensitivity[2];
> +       u8 vibration;
> +       u8 unk25[7];
> +       u8 magic;
> +       u8 unk33[32];
> +} __packed;
> +static_assert(sizeof(struct aya3_config) =3D=3D AYA3_REPORT_SIZE);
> +
> +/* Replies echo the subcommand they answer at byte 3 */
> +struct aya3_resp {
> +       u8 unk0[3];
> +       u8 subcmd;
> +       u8 unk4[15];
> +       u8 eject_status;
> +       u8 unk20[12];
> +       u8 module_left;
> +       u8 module_right;
> +       u8 unk34[30];
> +} __packed;
> +static_assert(sizeof(struct aya3_resp) =3D=3D AYA3_RESP_SIZE);
> +
> +struct ayaneo {
> +       struct hid_device *hdev;
> +       /* DMA-safe command buffer; guarded by lock */
> +       u8 *xfer;
> +       /* Serializes commands and cached-config access */
> +       struct mutex lock;
> +       /* Protects the reply-matching state shared with raw_event */
> +       spinlock_t resp_lock;
> +       struct completion resp_done;
> +       struct aya3_resp resp;
> +       u8 resp_expect;
> +       bool resp_pending;
> +
> +       /*
> +        * True once a configuration was successfully applied. The driver
> +        * sends no traffic unless userspace asked, and that policy
> +        * extends across resets.
> +        */
> +       bool configured;
> +
> +       u8 rgb[3];
> +       u8 brightness;
> +       u8 effect;
> +       u8 vibration;
> +
> +       struct led_classdev_mc mcled;
> +       struct mc_subled subleds[3];
> +};
> +
> +static int ayaneo_send(struct ayaneo *aya)
> +{
> +       int ret;
> +
> +       ret =3D hid_hw_output_report(aya->hdev, aya->xfer, AYA3_REPORT_SI=
ZE);
> +       if (ret =3D=3D -ENOSYS)
> +               ret =3D hid_hw_raw_request(aya->hdev, aya->xfer[0], aya->=
xfer,
> +                                        AYA3_REPORT_SIZE, HID_OUTPUT_REP=
ORT,
> +                                        HID_REQ_SET_REPORT);
> +       if (ret < 0)
> +               return ret;
> +       return 0;
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
> +       int attempt, ret;
> +
> +       lockdep_assert_held(&aya->lock);
> +
> +       for (attempt =3D 0; attempt < attempts; attempt++) {
> +               scoped_guard(spinlock_irqsave, &aya->resp_lock) {
> +                       reinit_completion(&aya->resp_done);
> +                       aya->resp_expect =3D aya->xfer[4];
> +                       aya->resp_pending =3D true;
> +               }
> +
> +               ret =3D ayaneo_send(aya);
> +               if (ret) {
> +                       scoped_guard(spinlock_irqsave, &aya->resp_lock)
> +                               aya->resp_pending =3D false;
> +                       return ret;
> +               }
> +
> +               if (wait_for_completion_timeout(&aya->resp_done,
> +                                               msecs_to_jiffies(AYA3_CMD=
_TIMEOUT_MS))) {
> +                       /*
> +                        * raw_event cleared resp_pending before completi=
ng,
> +                        * so nothing else writes aya->resp: the copy is
> +                        * safe unlocked.
> +                        */
> +                       if (resp)
> +                               memcpy(resp, &aya->resp, sizeof(*resp));
> +                       return 0;
> +               }
> +       }
> +       scoped_guard(spinlock_irqsave, &aya->resp_lock)
> +               aya->resp_pending =3D false;
> +       return -ETIMEDOUT;
> +}
> +
> +static void ayaneo_checksum(u8 *buf)
> +{
> +       u16 sum =3D 0;
> +       int i;
> +
> +       for (i =3D 7; i < AYA3_REPORT_SIZE; i++)
> +               sum +=3D buf[i];
> +       put_unaligned_le16(sum, buf + 1);
> +}
> +
> +static int ayaneo_check(struct ayaneo *aya, struct aya3_resp *resp,
> +                       int attempts)
> +{
> +       memset(aya->xfer, 0, AYA3_REPORT_SIZE);
> +       aya->xfer[4] =3D AYA3_SUBCMD_CHECK;
> +       return ayaneo_cmd(aya, resp, attempts);
> +}
> +
> +/*
> + * The config command sets everything at once: RGB for both rings,
> + * vibration strength and the eject/reset field. The command can also
> + * carry joystick sensitivity. Those bytes are left zero so the
> + * firmware setting is not clobbered on every RGB update.
> + */
> +static int ayaneo_send_config(struct ayaneo *aya, u8 eject)
> +{
> +       static const struct aya3_config template =3D {
> +               .cmd =3D AYA3_CMD_CONFIG,
> +               .subcmd =3D AYA3_SUBCMD_CONFIG,
> +               .magic =3D 0x01,
> +       };
> +       struct aya3_config *cfg =3D (struct aya3_config *)aya->xfer;
> +       u8 mode =3D AYA3_RGB_OFF;
> +       int ret;
> +
> +       if (aya->effect =3D=3D AYA3_EFFECT_RAINBOW) {
> +               if (aya->brightness)
> +                       mode =3D AYA3_RGB_RAINBOW;
> +       } else if (aya->rgb[0] || aya->rgb[1] || aya->rgb[2]) {
> +               mode =3D aya->effect =3D=3D AYA3_EFFECT_BREATHE ?
> +                       AYA3_RGB_PULSE : AYA3_RGB_SOLID;
> +       }
> +
> +       *cfg =3D template;
> +       cfg->right.mode =3D mode;
> +       if (mode =3D=3D AYA3_RGB_RAINBOW) {
> +               /*
> +                * The firmware generates hue and tempo itself. The RGB
> +                * payload only scales the amplitude. Handheld Daemon
> +                * derives it as HSV(275, 100, brightness), which is
> +                * (7/12 * v, 0, v) in RGB.
> +                */
> +               cfg->right.r =3D aya->brightness * 7 / 12;
> +               cfg->right.g =3D 0;
> +               cfg->right.b =3D aya->brightness;
> +       } else {
> +               cfg->right.r =3D aya->rgb[0];
> +               cfg->right.g =3D aya->rgb[1];
> +               cfg->right.b =3D aya->rgb[2];
> +       }
> +       cfg->left =3D cfg->right;
> +       cfg->eject =3D eject;
> +       cfg->vibration =3D aya->vibration << 4;
> +       ayaneo_checksum(aya->xfer);
> +
> +       ret =3D ayaneo_cmd(aya, NULL, AYA3_CMD_ATTEMPTS);
> +       if (!ret)
> +               aya->configured =3D true;
> +       return ret;
> +}
> +
> +static int ayaneo_raw_event(struct hid_device *hdev, struct hid_report *=
report,
> +                           u8 *data, int size)
> +{
> +       struct ayaneo *aya =3D hid_get_drvdata(hdev);
> +       const struct aya3_resp *resp =3D (const struct aya3_resp *)data;
> +
> +       /* Transparent interfaces have no driver data */
> +       if (!aya)
> +               return 0;
> +
> +       guard(spinlock_irqsave)(&aya->resp_lock);
> +
> +       if (!aya->resp_pending || size < AYA3_RESP_SIZE)
> +               return 0;
> +       /*
> +        * Replies carry no sequence number, only the subcommand echo. A
> +        * late reply to a timed-out command can thus complete a newer
> +        * command with the same subcommand. Such replies are snapshots
> +        * of the same query milliseconds apart, so this is harmless.
> +        * Replies to a different subcommand are dropped here.
> +        */
> +       if (resp->subcmd !=3D aya->resp_expect)
> +               return 0;
> +
> +       memcpy(&aya->resp, data, sizeof(aya->resp));
> +       aya->resp_pending =3D false;
> +       complete(&aya->resp_done);
> +       return 0;
> +}
> +
> +static ssize_t ayaneo_module_show(struct device *dev, char *buf, bool ri=
ght)
> +{
> +       struct ayaneo *aya =3D dev_get_drvdata(dev);
> +       struct aya3_resp resp;
> +       int ret =3D 0;
> +
> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock)
> +               ret =3D ayaneo_check(aya, &resp, AYA3_CMD_ATTEMPTS);
> +       if (ret)
> +               return ret;
> +
> +       return sysfs_emit(buf, "0x%02x\n",
> +                         right ? resp.module_right : resp.module_left);
> +}
> +
> +static ssize_t module_left_show(struct device *dev,
> +                               struct device_attribute *attr, char *buf)
> +{
> +       return ayaneo_module_show(dev, buf, false);
> +}
> +static DEVICE_ATTR_RO(module_left);
> +
> +static ssize_t module_right_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf=
)
> +{
> +       return ayaneo_module_show(dev, buf, true);
> +}
> +static DEVICE_ATTR_RO(module_right);
> +
> +static ssize_t eject_store(struct device *dev, struct device_attribute *=
attr,
> +                          const char *buf, size_t count)
> +{
> +       struct ayaneo *aya =3D dev_get_drvdata(dev);
> +       struct aya3_resp resp;
> +       u8 eject;
> +       int ret =3D 0, err, i;
> +
> +       if (sysfs_streq(buf, "left"))
> +               eject =3D AYA3_EJECT_LEFT;
> +       else if (sysfs_streq(buf, "right"))
> +               eject =3D AYA3_EJECT_RIGHT;
> +       else if (sysfs_streq(buf, "both"))
> +               eject =3D AYA3_EJECT_LEFT | AYA3_EJECT_RIGHT;
> +       else
> +               return -EINVAL;
> +
> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +               unsigned long deadline =3D jiffies +
> +                                        msecs_to_jiffies(AYA3_EJECT_MIN_=
MS);
> +
> +               ret =3D ayaneo_send_config(aya, eject);
> +               if (ret)
> +                       break;
> +
> +               /*
> +                * Wait for the firmware to report the eject as done: no
> +                * bits outside AYA3_EJECT_DONE_MASK set, matching
> +                * Handheld Daemon's verification. The firmware reports
> +                * the in-progress state from the first poll, and the
> +                * minimum-time floor below guards the power-cut step
> +                * regardless. Userspace must then cut power through
> +                * ayaneo-ec's controller_power for the module to be
> +                * physically released.
> +                */
> +               ret =3D -ETIMEDOUT;
> +               for (i =3D 0; i < AYA3_EJECT_POLLS; i++) {
> +                       if (msleep_interruptible(AYA3_EJECT_POLL_MS)) {
> +                               ret =3D -EINTR;
> +                               break;
> +                       }
> +                       err =3D ayaneo_check(aya, &resp, 1);
> +                       if (err =3D=3D -ETIMEDOUT)
> +                               continue;       /* busy mid-eject, keep p=
olling */
> +                       if (err) {
> +                               ret =3D err;
> +                               break;
> +                       }
> +                       if (!(resp.eject_status & ~AYA3_EJECT_DONE_MASK))=
 {
> +                               ret =3D 0;
> +                               break;
> +                       }
> +               }
> +
> +               /*
> +                * The firmware wants a minimum time between the eject
> +                * command and the power cut that follows this write.
> +                */
> +               if (!ret && time_before(jiffies, deadline)) {
> +                       if (msleep_interruptible(jiffies_to_msecs(deadlin=
e -
> +                                                                 jiffies=
)))
> +                               ret =3D -EINTR;
> +               }
> +       }
> +       return ret ? ret : count;
> +}
> +static DEVICE_ATTR_WO(eject);
> +
> +static ssize_t reset_store(struct device *dev, struct device_attribute *=
attr,
> +                          const char *buf, size_t count)
> +{
> +       struct ayaneo *aya =3D dev_get_drvdata(dev);
> +       bool value;
> +       int ret;
> +
> +       ret =3D kstrtobool(buf, &value);
> +       if (ret)
> +               return ret;
> +       if (!value)
> +               return count;
> +
> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +               ret =3D ayaneo_send_config(aya, AYA3_RESET);
> +               if (!ret) {
> +                       msleep(AYA3_RESET_SETTLE_MS);
> +                       ret =3D ayaneo_send_config(aya, 0);
> +               }
> +       }
> +       return ret ? ret : count;
> +}
> +static DEVICE_ATTR_WO(reset);
> +
> +/*
> + * Rumble intensity names, index-aligned with the wire values through
> + * ayaneo_rumble_levels below.
> + */
> +static const char * const ayaneo_rumble_names[] =3D {
> +       "off", "low", "medium", "high",
> +};
> +
> +static const u8 ayaneo_rumble_levels[] =3D {
> +       AYA3_VIBRATION_OFF,
> +       AYA3_VIBRATION_LOW,
> +       AYA3_VIBRATION_MEDIUM,
> +       AYA3_VIBRATION_HIGH,
> +};
> +
> +static ssize_t rumble_intensity_show(struct device *dev,
> +                                    struct device_attribute *attr, char =
*buf)
> +{
> +       struct ayaneo *aya =3D dev_get_drvdata(dev);
> +       u8 level;
> +       int i;
> +
> +       /*
> +        * Single-byte snapshot; writers serialize on aya->lock, and a
> +        * racing update is harmless, while taking the mutex here would
> +        * block trivial reads behind a multi-second eject.
> +        */
> +       level =3D READ_ONCE(aya->vibration);
> +
> +       for (i =3D 0; i < ARRAY_SIZE(ayaneo_rumble_levels); i++) {
> +               if (ayaneo_rumble_levels[i] =3D=3D level)
> +                       return sysfs_emit(buf, "%s\n", ayaneo_rumble_name=
s[i]);
> +       }
> +       return -EINVAL;
> +}
> +
> +static ssize_t rumble_intensity_store(struct device *dev,
> +                                     struct device_attribute *attr,
> +                                     const char *buf, size_t count)
> +{
> +       struct ayaneo *aya =3D dev_get_drvdata(dev);
> +       u8 previous;
> +       int ret;
> +
> +       ret =3D sysfs_match_string(ayaneo_rumble_names, buf);
> +       if (ret < 0)
> +               return ret;
> +
> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +               previous =3D aya->vibration;
> +               aya->vibration =3D ayaneo_rumble_levels[ret];
> +               ret =3D ayaneo_send_config(aya, 0);
> +               if (ret) {
> +                       aya->vibration =3D previous;
> +                       return ret;
> +               }
> +       }
> +       return count;
> +}
> +static DEVICE_ATTR_RW(rumble_intensity);
> +
> +static ssize_t rumble_intensity_index_show(struct device *dev,
> +                                          struct device_attribute *attr,
> +                                          char *buf)
> +{
> +       ssize_t count =3D 0;
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(ayaneo_rumble_names); i++)
> +               count +=3D sysfs_emit_at(buf, count, "%s ",
> +                                      ayaneo_rumble_names[i]);
> +
> +       if (count)
> +               buf[count - 1] =3D '\n';
> +
> +       return count;
> +}
> +static DEVICE_ATTR_RO(rumble_intensity_index);
> +
> +static struct attribute *ayaneo_attrs[] =3D {
> +       &dev_attr_module_left.attr,
> +       &dev_attr_module_right.attr,
> +       &dev_attr_eject.attr,
> +       &dev_attr_reset.attr,
> +       &dev_attr_rumble_intensity.attr,
> +       &dev_attr_rumble_intensity_index.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group ayaneo_group =3D {
> +       .attrs =3D ayaneo_attrs,
> +};
> +
> +static int ayaneo_led_set(struct led_classdev *cdev, enum led_brightness=
 value)
> +{
> +       struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> +       struct ayaneo *aya =3D container_of(mc, struct ayaneo, mcled);
> +       int ret =3D 0, i;
> +
> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +               led_mc_calc_color_components(mc, value);
> +               aya->brightness =3D min_t(unsigned int, value, 255);
> +               for (i =3D 0; i < 3; i++)
> +                       aya->rgb[i] =3D min_t(unsigned int,
> +                                           aya->subleds[i].brightness, 2=
55);
> +
> +               ret =3D ayaneo_send_config(aya, 0);
> +               if (ret)
> +                       hid_err(aya->hdev,
> +                               "failed to update RGB config: %d\n", ret)=
;
> +       }
> +       return ret;
> +}
> +
> +static ssize_t effect_show(struct device *dev, struct device_attribute *=
attr,
> +                          char *buf)
> +{
> +       struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +       struct ayaneo *aya =3D container_of(lcdev_to_mccdev(cdev),
> +                                         struct ayaneo, mcled);
> +       u8 effect;
> +
> +       /*
> +        * Single-byte snapshot; writers serialize on aya->lock, and a
> +        * racing update is harmless, while taking the mutex here would
> +        * block trivial reads behind a multi-second eject.
> +        */
> +       effect =3D READ_ONCE(aya->effect);
> +
> +       return sysfs_emit(buf, "%s\n", ayaneo_effect_names[effect]);
> +}
> +
> +static ssize_t effect_store(struct device *dev, struct device_attribute =
*attr,
> +                           const char *buf, size_t count)
> +{
> +       struct led_classdev *cdev =3D dev_get_drvdata(dev);
> +       struct ayaneo *aya =3D container_of(lcdev_to_mccdev(cdev),
> +                                         struct ayaneo, mcled);
> +       u8 previous;
> +       int ret;
> +
> +       ret =3D sysfs_match_string(ayaneo_effect_names, buf);
> +       if (ret < 0)
> +               return ret;
> +
> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +               previous =3D aya->effect;
> +               if (previous =3D=3D ret)
> +                       return count;
> +               aya->effect =3D ret;
> +               ret =3D ayaneo_send_config(aya, 0);
> +               if (ret) {
> +                       aya->effect =3D previous;
> +                       return ret;
> +               }
> +       }
> +       return count;
> +}
> +static DEVICE_ATTR_RW(effect);
> +
> +static ssize_t effect_index_show(struct device *dev,
> +                                struct device_attribute *attr, char *buf=
)
> +{
> +       ssize_t count =3D 0;
> +       int i;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(ayaneo_effect_names); i++)
> +               count +=3D sysfs_emit_at(buf, count, "%s ",
> +                                      ayaneo_effect_names[i]);
> +
> +       if (count)
> +               buf[count - 1] =3D '\n';
> +
> +       return count;
> +}
> +static DEVICE_ATTR_RO(effect_index);
> +
> +static struct attribute *ayaneo_led_attrs[] =3D {
> +       &dev_attr_effect.attr,
> +       &dev_attr_effect_index.attr,
> +       NULL
> +};
> +
> +static const struct attribute_group ayaneo_led_group =3D {
> +       .attrs =3D ayaneo_led_attrs,
> +};
> +
> +/*
> + * The final LED write issued by the unregister needs its reply. Callers
> + * guarantee IO is working: probe leaves IO started after hid_hw_open,
> + * and remove re-enables it explicitly.
> + */
> +static void ayaneo_unregister_led(struct ayaneo *aya)
> +{
> +       led_classdev_multicolor_unregister(&aya->mcled);
> +       flush_work(&aya->mcled.led_cdev.set_brightness_work);
> +}
> +
> +static int ayaneo_register_led(struct ayaneo *aya)
> +{
> +       struct led_classdev *cdev =3D &aya->mcled.led_cdev;
> +       int ret, i;
> +
> +       aya->subleds[0].color_index =3D LED_COLOR_ID_RED;
> +       aya->subleds[1].color_index =3D LED_COLOR_ID_GREEN;
> +       aya->subleds[2].color_index =3D LED_COLOR_ID_BLUE;
> +       /*
> +        * Full intensity by default so brightness writes produce light
> +        * before userspace sets multi_intensity (querying the firmware
> +        * for its value would break the no-probe-traffic policy).
> +        */
> +       for (i =3D 0; i < 3; i++)
> +               aya->subleds[i].intensity =3D 255;
> +       aya->mcled.subled_info =3D aya->subleds;
> +       aya->mcled.num_colors =3D 3;
> +
> +       cdev->name =3D devm_kasprintf(&aya->hdev->dev, GFP_KERNEL,
> +                                   "%s:rgb:joystick_rings",
> +                                   dev_name(&aya->hdev->dev));
> +       if (!cdev->name)
> +               return -ENOMEM;
> +       cdev->color =3D LED_COLOR_ID_RGB;
> +       cdev->brightness =3D 0;
> +       cdev->max_brightness =3D 255;
> +       cdev->brightness_set_blocking =3D ayaneo_led_set;
> +
> +       /*
> +        * Not devm: the LED must be unregistered before hid_hw_stop() in
> +        * remove, or a concurrent brightness write could reach a torn
> +        * down transport.
> +        */
> +       ret =3D led_classdev_multicolor_register(&aya->hdev->dev, &aya->m=
cled);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * The multicolor class installs its own groups during
> +        * registration, so the effect attributes are added afterwards.
> +        * They are tied to the LED device and vanish with it.
> +        */
> +       ret =3D devm_device_add_group(cdev->dev, &ayaneo_led_group);
> +       if (ret)
> +               ayaneo_unregister_led(aya);
> +       return ret;
> +}
> +
> +static const struct dmi_system_id ayaneo_dmi_table[] =3D {
> +       {
> +               .matches =3D {
> +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +                       DMI_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
> +               },
> +       },
> +       {}
> +};
> +
> +static int ayaneo_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> +{
> +       struct ayaneo *aya;
> +       int ret;
> +
> +       ret =3D hid_parse(hdev);
> +       if (ret)
> +               return ret;
> +
> +       /*
> +        * The VID/PID is a generic SigmaMicro ID shared by the gamepad,
> +        * keyboard and vendor interfaces, and by unrelated devices on
> +        * other machines. Refusing those probes would strand them, as
> +        * hid-generic yields any device that another driver's id table
> +        * matches. Everything that is not the AYANEO 3 vendor interface
> +        * is therefore started as a transparent generic device, exactly
> +        * as hid-generic would have started it.
> +        */
> +       if (!dmi_check_system(ayaneo_dmi_table) || !hid_is_usb(hdev) ||
> +           !hdev->maxcollection ||
> +           hdev->collection->type !=3D HID_COLLECTION_APPLICATION ||
> +           hdev->collection->usage !=3D AYA3_APP_USAGE) {
> +               hdev->quirks |=3D HID_QUIRK_INPUT_PER_APP;
> +               return hid_hw_start(hdev, HID_CONNECT_DEFAULT);
> +       }
> +
> +       aya =3D devm_kzalloc(&hdev->dev, sizeof(*aya), GFP_KERNEL);
> +       if (!aya)
> +               return -ENOMEM;
> +
> +       aya->xfer =3D devm_kzalloc(&hdev->dev, AYA3_REPORT_SIZE, GFP_KERN=
EL);
> +       if (!aya->xfer)
> +               return -ENOMEM;
> +
> +       aya->hdev =3D hdev;
> +       aya->vibration =3D AYA3_VIBRATION_MEDIUM;
> +       init_completion(&aya->resp_done);
> +       spin_lock_init(&aya->resp_lock);
> +       ret =3D devm_mutex_init(&hdev->dev, &aya->lock);
> +       if (ret)
> +               return ret;
> +       hid_set_drvdata(hdev, aya);
> +
> +       ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D hid_hw_open(hdev);
> +       if (ret)
> +               goto err_stop;
> +
> +       /*
> +        * Report delivery is off during probe by default, but the LED
> +        * and attributes go live below and their first commands need
> +        * replies. Leave IO started (the HID core supports probe
> +        * returning with IO started).
> +        */
> +       hid_device_io_start(hdev);
> +
> +       ret =3D ayaneo_register_led(aya);
> +       if (ret)
> +               goto err_close;
> +
> +       ret =3D sysfs_create_group(&hdev->dev.kobj, &ayaneo_group);
> +       if (ret)
> +               goto err_led;
> +
> +       return 0;
> +
> +err_led:
> +       ayaneo_unregister_led(aya);
> +err_close:
> +       hid_hw_close(hdev);
> +err_stop:
> +       hid_hw_stop(hdev);
> +       return ret;
> +}
> +
> +static void ayaneo_remove(struct hid_device *hdev)
> +{
> +       struct ayaneo *aya =3D hid_get_drvdata(hdev);
> +
> +       /* Transparent interfaces carry no driver state */
> +       if (!aya) {
> +               hid_hw_stop(hdev);
> +               return;
> +       }
> +
> +       /*
> +        * The HID core stops report delivery before calling remove, but
> +        * the final LED write issued by the unregister below needs its
> +        * reply, and the group removal waits for in-flight attribute
> +        * callers, which need working replies to finish promptly.
> +        * Re-enable IO for the teardown writes.
> +        */
> +       hid_device_io_start(hdev);
> +       sysfs_remove_group(&hdev->dev.kobj, &ayaneo_group);
> +       led_classdev_multicolor_unregister(&aya->mcled);
> +       /*
> +        * A brightness store racing with the unregister can requeue
> +        * set_brightness_work after the flush inside
> +        * led_classdev_unregister() runs but before the sysfs node is
> +        * removed. Flush again now that nothing can requeue it, while
> +        * the transport is still up. This double flush papers over a
> +        * led-class ordering gap (the flush runs before
> +        * device_unregister) that affects any brightness_set_blocking
> +        * driver and deserves a core fix separately.
> +        */

Too much detail in comments. Obvious observations need not be listed.
This applies to most comments in the current driver. E.g., the generic
vid/pid note may remain.

> +       flush_work(&aya->mcled.led_cdev.set_brightness_work);
> +       hid_device_io_stop(hdev);
> +       hid_hw_close(hdev);
> +       hid_hw_stop(hdev);
> +}
> +
> +static int ayaneo_reset_resume(struct hid_device *hdev)
> +{
> +       struct ayaneo *aya =3D hid_get_drvdata(hdev);
> +       int ret =3D 0;
> +
> +       /* Transparent interfaces resume exactly as hid-generic would */
> +       if (!aya) {
> +               if (hdev->claimed & HID_CLAIMED_INPUT)
> +                       hidinput_reset_resume(hdev);
> +               return 0;
> +       }
> +
> +       scoped_cond_guard(mutex_intr, return -EINTR, &aya->lock) {
> +               if (aya->configured)
> +                       ret =3D ayaneo_send_config(aya, 0);
> +       }
> +       return ret;
> +}
> +
> +static const struct hid_device_id ayaneo_devices[] =3D {
> +       { HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO,
> +                        USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD) },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(hid, ayaneo_devices);
> +
> +static struct hid_driver ayaneo_driver =3D {
> +       .name =3D "hid-ayaneo",
> +       .id_table =3D ayaneo_devices,
> +       .probe =3D ayaneo_probe,
> +       .remove =3D ayaneo_remove,
> +       .raw_event =3D ayaneo_raw_event,
> +       .reset_resume =3D ayaneo_reset_resume,

Review the use of reset_resume. It is only used for buggy devices.
Doesn't resume work? Is it needed in your usage? does the device not
restore colors after sleep?

I think these are all my comments. Given you are still doing changes
for stability's shake, this will need to be tested for a bit longer.

Best,
Antheas

> +};
> +module_hid_driver(ayaneo_driver);
> +
> +MODULE_AUTHOR("Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>");
> +MODULE_DESCRIPTION("AYANEO 3 detachable controller driver");
> +MODULE_LICENSE("GPL");
> --
> 2.54.0 (Apple Git-157)
>
>

