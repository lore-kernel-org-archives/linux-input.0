Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8D4356767;
	Wed, 22 Jul 2026 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784731387; cv=none; b=akMiMfCGTTmWn+CcXfQBSrX9zjY4tsX8RDgeVyx9dG/rvgPUvuqH/VGrjU7VP2rSWYzeGKSHoIW/Eh7el4iiHHiyPDiJhgZ+lSeoRzHVhdxQPPm5oZpkYUvaoUi3q19KtFh1gPGp5gJbaROaTMUfefl6ikV/RtR/gCtaNXMwPec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784731387; c=relaxed/simple;
	bh=rXioocdgzNlrdc4UE2M1ZkVIIxtFS9Ex0kV75VzD98Q=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Qsh2Nc1jTlQ2w0eO1bdNT7OqBbgKpyGT77Mqnrj5e1Nyqt/MfiksdVZRuJkG+jmA8iBHoanCT1UQPkyTcfdgsi2EB4Nb+v2U981Ye1rIS3bBNcEt1eG6jqsu5vhdcOvwFTjTzfpWinWbquiJojg2x2HJR4NKHe+VjrA+iQUYiIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GwaXSIe6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GwaXSIe6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784731385; x=1816267385;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rXioocdgzNlrdc4UE2M1ZkVIIxtFS9Ex0kV75VzD98Q=;
  b=GwaXSIe6r/hh5NYjrTSZchOfOblcBWfYmHkG3joldp0dCdbLElRfYYgS
   /PhPGUz6+PPRhGQVNnrx3wdM36Hdni4ZNqQzbtSbccgwsMWsjUiPhjOGo
   53p12sSs8DQ5f6sGTxJcspb586I0+/uTl7yHVEZmHt/dt1LnXx6OnybDu
   PZEIA4CAKbLO1ZiF7nTCz5LkKyYh1Sbiv3u6nNj3mdQirg/jPMn30n2vs
   ua4cyPa7wCm1qT5WUi6nGJRr8cUb+K6bzD4HZVZNrBOZxjXCqLBUGBI5r
   IIl3IbUFwl//Teiz+F5xCzIyJtTgwrtXKIiWbp/a9+cAhZtSrAYGTwZFJ
   g==;
X-CSE-ConnectionGUID: zCB3g9/XRJidX8oiNr45hQ==
X-CSE-MsgGUID: 3l/2I0BdQRyY130v7kpStQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="85239738"
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="85239738"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 07:43:02 -0700
X-CSE-ConnectionGUID: h505YzZQSjeA7+P0udkm9Q==
X-CSE-MsgGUID: 4Y689gFJToWzctAmomcCUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,178,1779174000"; 
   d="scan'208";a="281390491"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.200])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 07:42:59 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 22 Jul 2026 17:42:56 +0300 (EEST)
To: Dave Carey <carvsdriver@gmail.com>
cc: platform-driver-x86@vger.kernel.org, hdegoede@redhat.com, W_Armin@gmx.de, 
    jikos@kernel.org, linux-input@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, 
    Hans de Goede <johannes.goede@oss.qualcomm.com>
Subject: Re: [PATCH v13 2/2] platform/x86/lenovo: Add Yoga Book 9 keyboard
 dock detection driver
In-Reply-To: <20260722142712.814597-3-carvsdriver@gmail.com>
Message-ID: <15943a77-07e3-9449-7e2f-2d72f345dfa2@linux.intel.com>
References: <20260722142712.814597-1-carvsdriver@gmail.com> <20260722142712.814597-3-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-529663240-1784731376=:1198"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-529663240-1784731376=:1198
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 22 Jul 2026, Dave Carey wrote:

> The Lenovo Yoga Book 9 14IAH10 ships with a detachable Bluetooth keyboard
> that magnetically attaches to the bottom (secondary) screen in one of two
> positions.  The Embedded Controller tracks the attachment state in a 2-bi=
t
> field called BKBD and signals changes via WMI event GUID
> 806BD2A2-177B-481D-BFB5-3BA0BB4A2285 (notify ID 0xEB on the WM10 ACPI
> device, _UID "GMZN").
>=20
> The device contains embedded BMOF data (WQDD, 20705 bytes) documenting
> both WMI interfaces used by this driver:
>=20
>   LENOVO_BTKBD_EVENT (event GUID): WmiDataId(1) uint32 Status.
>   The ACPI _WED(0xEB) method returns EC.BKBD directly as an integer,
>   so the notify callback receives BKBD without a separate query.
>=20
>   LENOVO_FEATURE_STATUS_DATA (block GUID, WQAF method): returns an
>   8-byte buffer {uint32 IDs=3D0x00060000, uint32 Status=3DBKBD}.
>   Used for the initial state read on probe and after resume.
>=20
> BKBD encoding:
>   0 =3D keyboard detached
>   1 =3D keyboard docked on top half of bottom screen
>   2 =3D keyboard docked on bottom half of bottom screen
>   3 =3D reserved (not observed in practice)
>=20
> This driver registers two WMI drivers sharing a module-level
> BLOCKING_NOTIFIER_HEAD:
>=20
>   - The event driver (LENOVO_BTKBD_EVENT) uses .notify_new() to receive
>     a pre-parsed wmi_buffer and fires the notifier chain with the BKBD
>     value extracted from the buffer.
>=20
>   - The block driver (LENOVO_FEATURE_STATUS_DATA) owns the input_dev in
>     its per-device private struct.  At probe time it registers a
>     notifier_block on the chain and reads the initial BKBD state via
>     wmidev_query_block().  The WMI buffer is parsed as
>     struct lenovo_feature_status { __le32 id; __le32 status; }, and the
>     ID field is verified before the status is used.
>=20
>   - SW_TABLET_MODE=3D1 is reported when the keyboard is detached;
>     SW_TABLET_MODE=3D0 when docked in either position (keyboard present).
>=20
>   - The raw BKBD value is exposed via read-only sysfs attribute
>     "keyboard_position".
>=20
>   - BKBD state is re-read via wmidev_query_block() on resume from
>     suspend or hibernation.
>=20
> Tested on: Lenovo Yoga Book 9 14IAH10 (model 83KJ), kernel 7.0.
>=20
> Acked-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Dave Carey <carvsdriver@gmail.com>
> ---
> v13:
> - Resend of v12: patch was corrupted in transit.  git-send-email chose
>   quoted-printable encoding (triggered by non-ASCII in the changelog)
>   which encoded '=3D' as '=3D3D', corrupting the RST table separators in
>   the ABI doc and breaking git-am.  No content changes from v12.
>=20
> v12:
> - Add #include <linux/sysfs.h> (for sysfs_emit; Ilpo J=C3=A4rvinen)
> - Add #include <linux/types.h> (for __le32 and __packed; Ilpo J=C3=A4rvin=
en)
>=20
> v11 (addressing Armin Wolf's v10 review):
> - ABI doc: correct Date to "June 2027" and KernelVersion to "7.3"
>=20
> v10 (addressing Armin Wolf's v9 review):
> - Update ABI doc: Date: June 2026, KernelVersion: 6.16
> - Add #include <linux/compiler_attributes.h> and <linux/types.h>
> - yb9_kbdock_query(): change return to pointer-out u32 *bkbd
> - struct yb9_kbdock_data: add spinlock_t lock
> - yb9_kbdock_report(): hold lock across input_report_switch + input_sync
> - yb9_kbdock_sync(): return int, propagate query error to callers
> - yb9_kbdock_resume(), yb9_kbdock_block_probe(): propagate sync error
> - struct wmi_buffer out: remove zero-initializer
> - yb9_kbdock_notify_new(): drop manual length check; use
>   .min_event_size =3D sizeof(__le32) in struct wmi_driver instead
>=20
>  .../testing/sysfs-driver-lenovo-yb9-kbdock    |  19 ++
>  MAINTAINERS                                   |   7 +
>  drivers/platform/x86/lenovo/Kconfig           |  14 +
>  drivers/platform/x86/lenovo/Makefile          |   1 +
>  drivers/platform/x86/lenovo/yb9-kbdock.c      | 312 ++++++++++++++++++
>  5 files changed, 353 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbd=
ock
>  create mode 100644 drivers/platform/x86/lenovo/yb9-kbdock.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock b/D=
ocumentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
> new file mode 100644
> index 0000000..ebe713a
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
> @@ -0,0 +1,19 @@
> +What:=09=09/sys/bus/wmi/drivers/lenovo-yb9-kbdock/<guid>/keyboard_positi=
on
> +Date:=09=09June 2027
> +KernelVersion:=097.3
> +Contact:=09Dave Carey <carvsdriver@gmail.com>
> +Description:
> +=09=09Read-only attribute reporting the current keyboard dock position
> +=09=09as reported by the Embedded Controller on the Lenovo Yoga Book 9
> +=09=0914IAH10.
> +
> +=09=09Possible values:
> +
> +=09=09=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=09=090   keyboard is not docked to any screen (detached)
> +=09=091   keyboard docked on the top half of the bottom screen
> +=09=092   keyboard docked on the bottom half of the bottom screen
> +=09=09=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=09=09SW_TABLET_MODE input events are also emitted: 0 when the keyboard
> +=09=09is docked (either position), 1 when detached.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e1..00e8275 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14479,6 +14479,13 @@ L:=09platform-driver-x86@vger.kernel.org
>  S:=09Maintained
>  F:=09drivers/platform/x86/lenovo/wmi-hotkey-utilities.c
> =20
> +LENOVO YOGA BOOK 9 KEYBOARD DOCK DRIVER
> +M:=09Dave Carey <carvsdriver@gmail.com>
> +L:=09platform-driver-x86@vger.kernel.org
> +S:=09Maintained
> +F:=09Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
> +F:=09drivers/platform/x86/lenovo/yb9-kbdock.c
> +
>  LETSKETCH HID TABLET DRIVER
>  M:=09Hans de Goede <hansg@kernel.org>
>  L:=09linux-input@vger.kernel.org
> diff --git a/drivers/platform/x86/lenovo/Kconfig b/drivers/platform/x86/l=
enovo/Kconfig
> index 9c48487..938b361 100644
> --- a/drivers/platform/x86/lenovo/Kconfig
> +++ b/drivers/platform/x86/lenovo/Kconfig
> @@ -43,6 +43,20 @@ config LENOVO_WMI_CAMERA
>  =09  To compile this driver as a module, choose M here: the module
>  =09  will be called lenovo-wmi-camera.
> =20
> +config LENOVO_YB9_KBDOCK
> +=09tristate "Lenovo Yoga Book 9 keyboard dock detection"
> +=09depends on ACPI_WMI
> +=09depends on DMI
> +=09depends on INPUT
> +=09help
> +=09  Say Y here to enable keyboard dock detection on the Lenovo Yoga Boo=
k 9
> +=09  14IAH10.  The detachable Bluetooth keyboard magnetically attaches t=
o
> +=09  either screen; this driver reports SW_TABLET_MODE input events base=
d
> +=09  on the attachment state and exposes the raw position in sysfs.
> +
> +=09  To compile this driver as a module, choose M here: the module will =
be
> +=09  called lenovo-yb9-kbdock.
> +
>  config LENOVO_YMC
>  =09tristate "Lenovo Yoga Tablet Mode Control"
>  =09depends on ACPI_WMI
> diff --git a/drivers/platform/x86/lenovo/Makefile b/drivers/platform/x86/=
lenovo/Makefile
> index 7b2128e..2842d7d 100644
> --- a/drivers/platform/x86/lenovo/Makefile
> +++ b/drivers/platform/x86/lenovo/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_THINKPAD_LMI)=09+=3D think-lmi.o
>  obj-$(CONFIG_THINKPAD_ACPI)=09+=3D thinkpad_acpi.o
> =20
>  lenovo-target-$(CONFIG_LENOVO_WMI_HOTKEY_UTILITIES)=09+=3D wmi-hotkey-ut=
ilities.o
> +lenovo-target-$(CONFIG_LENOVO_YB9_KBDOCK)=09+=3D yb9-kbdock.o
>  lenovo-target-$(CONFIG_LENOVO_YMC)=09+=3D ymc.o
>  lenovo-target-$(CONFIG_YOGABOOK)=09+=3D yogabook.o
>  lenovo-target-$(CONFIG_YT2_1380)=09+=3D yoga-tab2-pro-1380-fastcharger.o
> diff --git a/drivers/platform/x86/lenovo/yb9-kbdock.c b/drivers/platform/=
x86/lenovo/yb9-kbdock.c
> new file mode 100644
> index 0000000..69c68a0
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo/yb9-kbdock.c
> @@ -0,0 +1,312 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Lenovo Yoga Book 9 keyboard-dock detection
> + *
> + * The Yoga Book 9 ships with a detachable Bluetooth keyboard that magne=
tically
> + * attaches to the bottom screen in one of two positions.  The EC tracks
> + * attachment state in a 2-bit field called BKBD and signals changes via=
 WMI
> + * event 0xEB on the WM10 ACPI device (_UID "GMZN").
> + *
> + * BKBD values:
> + *   0 =3D keyboard detached
> + *   1 =3D keyboard docked on the top half of the bottom screen
> + *   2 =3D keyboard docked on the bottom half of the bottom screen
> + *   3 =3D reserved / not observed
> + *
> + * Two WMI interfaces are used (documented in embedded BMOF, WQDD, 20705=
 bytes):
> + *
> + *   LENOVO_BTKBD_EVENT (event GUID, 806BD2A2-...)
> + *     WmiDataId(1) uint32 Status =E2=80=94 _WED(0xEB) returns EC.BKBD d=
irectly.
> + *     The notify callback receives BKBD as an integer; no separate quer=
y needed.
> + *
> + *   LENOVO_FEATURE_STATUS_DATA (block GUID, E7F300FA-...)
> + *     WmiDataId(1) uint32 IDs   =3D 0x00060000 (feature selector)
> + *     WmiDataId(2) uint32 Status =3D BKBD value
> + *     Used on probe and resume to read initial state.
> + *
> + * The event driver (LENOVO_BTKBD_EVENT) fires a notifier chain on each =
WMI
> + * event.  The block driver (LENOVO_FEATURE_STATUS_DATA) owns the input_=
dev
> + * and registers a notifier_block to receive those events, eliminating t=
he
> + * need for shared global state or a mutex.
> + *
> + * SW_TABLET_MODE=3D1 is reported when the keyboard is detached;
> + * SW_TABLET_MODE=3D0 when docked in either position (keyboard present).
> + * The raw BKBD value is exposed via the sysfs attribute "keyboard_posit=
ion".
> + *
> + * Copyright (C) 2026 Dave Carey <carvsdriver@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/cleanup.h>
> +#include <linux/dev_printk.h>
> +#include <linux/dmi.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/notifier.h>
> +#include <linux/pm.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>
> +#include <linux/wmi.h>

Hi,

Are you sure you sent the latest version, AFAICT, v12 had this:

+#include <linux/acpi.h>
+#include <linux/cleanup.h>
+#include <linux/compiler_attributes.h>
+#include <linux/dev_printk.h>
=2E..
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+#include <linux/wmi.h>

?

--=20
 i.

--8323328-529663240-1784731376=:1198--
