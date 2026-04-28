Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46E37F721;
	Tue, 28 Apr 2026 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387168; cv=none; b=hxrQww8EFRpA7/WRP+VIiGYQRNe371d5EFEHYzsyEp5WrQbGGph9v8VeKrzgOQECad/5o7wRYA3UO6KmVhX4n13hj6Ww6naHgmwumtMQhO4QR6+eK+CNuSBhJx6ACVtTWD/V1oLn6YYiKkOBQQIA8g03EfG3dF85UCGfs/CXdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387168; c=relaxed/simple;
	bh=ZIOmJF84j9CeMlA2RuJRVPOXdSmI6iOB+bl+19SOFhY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kt4NUGPDCHff1B5doNc3RfoPSh5c4tc9HYP/7Vu7Ikcq1Nei8vUlKovSaIsA2Qg8OQ8jway/pqJvzOlN/RRjyG06kSQIjX+Gsw12BOxOeQzMivt+Dumqv9frY3yMloNFC+7vnb6aY78/10+7SB4wtzKd173wxxiR4ZgrTtiO6m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxQ9k5x2; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxQ9k5x2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777387165; x=1808923165;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ZIOmJF84j9CeMlA2RuJRVPOXdSmI6iOB+bl+19SOFhY=;
  b=QxQ9k5x28ohdXKMrFmMWnRVAHupH4BmLHZEx99vt9un4uu1xzpEklC3j
   vP8VMJEvZjn8jQN/0rz+bPOCIH1AIMVyGKIZLjoeqA8h5OobU/2SYy0ck
   fn1ou6Fkrp9LhRnDNkTqgFKeoMoKp/vX5llA/nwWX54q8ZRnVZ6e3HM+I
   6z2qtkJRAoLxCOG4TkG4zb6HQzu1uRH4MmzFbbexiGiSSO59F7NkvMVuO
   RRpqJAiSHuWCSY9gZ+z1MpSZyIXqxthT0jOw3hvrD8lbrkuQXpFrFPDKG
   oNLfHNDrys8nUS0277dbiSh29lsjUksGfKNyahyNbGVLbdurEsPw4QJ1A
   A==;
X-CSE-ConnectionGUID: 79MEHTP6Tgqp3N9wKbh+9Q==
X-CSE-MsgGUID: BL4guV0NS/ihSl7MtDdwFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="77328270"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="77328270"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:39:24 -0700
X-CSE-ConnectionGUID: BnVuRRY6RRiNE9HVX7/tKw==
X-CSE-MsgGUID: TbqfHw9QRW6nI5qx4O9vpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="232950967"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.1])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 07:39:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 Apr 2026 17:39:17 +0300 (EEST)
To: Dave Carey <carvsdriver@gmail.com>, Hans de Goede <hdegoede@redhat.com>, 
    Pit Henrich <pithenrich2d@googlemail.com>
cc: platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    linux-input@vger.kernel.org
Subject: Re: [PATCH] platform/x86/lenovo: Add Yoga Book 9 keyboard dock
 detection driver
In-Reply-To: <20260425132323.82809-1-carvsdriver@gmail.com>
Message-ID: <9459f535-d140-a431-3f76-a5d8623f3e2d@linux.intel.com>
References: <20260425132323.82809-1-carvsdriver@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1698080933-1777385484=:1128"
Content-ID: <1fc8a187-de42-6e72-9b64-a86ca44c9de3@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1698080933-1777385484=:1128
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <c243bb24-82fa-51a3-13f6-ecf83f7d3f5e@linux.intel.com>

On Sat, 25 Apr 2026, Dave Carey wrote:

> The Lenovo Yoga Book 9 14IAH10 ships with a detachable Bluetooth keyboard
> that magnetically attaches to the bottom (secondary) screen in one of two
> positions.

> The Embedded Controller tracks the attachment state in a 2-bit
> field called BKBD and signals changes via WMI event GUID
> 806BD2A2-177B-481D-BFB5-3BA0BB4A2285 (notify ID 0xEB on the WM10 ACPI
> device).

Please put this in depth explanation in own paragraph.

> The current BKBD state is read via WMI query GUID
> E7F300FA-21CD-4003-ADAC-2696135982E6 (WQAF method),=20

This seems mostly duplicate of what was said previously.

>which returns an
> 8-byte buffer: bytes [0..3] hold the LFID constant 0x00060000 and bytes
> [4..7] hold the BKBD value.
>
> BKBD encoding:
>   0 =3D keyboard detached
>   1 =3D keyboard docked on top half of bottom screen
>   2 =3D keyboard docked on bottom half of bottom screen
>   3 =3D reserved (not observed in practice)

These two can be combined with the in depth explanation paragraph.

> This driver:
>   - Registers as a WMI driver on the event GUID.

Unnecessary / obvious.

>   - Queries BKBD state on probe and on each WMI notification.
>   - Reports SW_TABLET_MODE=3D1 when detached, SW_TABLET_MODE=3D0 when doc=
ked
>     in either position (a physical keyboard is present in both cases).
>   - Exposes the raw BKBD value via a read-only sysfs attribute
>     "keyboard_position" for use by userspace (e.g. to distinguish between
>     the two docked positions for different UI layouts).

Please write this without bullet points. Bullet points usually break=20
relationships between sentences.

> Tested on: Lenovo Yoga Book 9 14IAH10 (model 83KJ), kernel 6.19.
>=20
> Signed-off-by: Dave Carey <carvsdriver@gmail.com>
> ---
>  .../testing/sysfs-driver-lenovo-yb9-kbdock    |  21 ++
>  MAINTAINERS                                   |   6 +
>  drivers/platform/x86/lenovo/Kconfig           |  14 ++
>  drivers/platform/x86/lenovo/Makefile          |   1 +
>  drivers/platform/x86/lenovo/yb9-kbdock.c      | 216 ++++++++++++++++++
>  5 files changed, 258 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbd=
ock
>  create mode 100644 MAINTAINERS
>  create mode 100644 drivers/platform/x86/lenovo/yb9-kbdock.c
>=20
> diff --git a/Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock b/D=
ocumentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
> new file mode 100644
> index 0000000..bb57690
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
> @@ -0,0 +1,21 @@
> +What:=09=09/sys/bus/wmi/drivers/lenovo-yb9-kbdock/<guid>/keyboard_positi=
on
> +Date:=09=09April 2026
> +KernelVersion:=096.10
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
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=09=090   detached  =E2=80=94 keyboard is not docked to any screen
> +=09=091   top-half  =E2=80=94 keyboard docked on the top half of the bot=
tom screen
> +=09=092   bottom-half =E2=80=94 keyboard docked on the bottom half of th=
e bottom screen
> +=09=09=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Interesting, I wonder if this is similar physically to what is being added=
=20
here:

https://lore.kernel.org/all/20260419102724.91451-1-pithenrich2d@gmail.com/

?

If yes, we may have to take another look at how to create the interface=20
for this.

You didn't document unknown but return it (maybe it should return some=20
-Exx code instead?).

> +=09=09The value is formatted as "<n> (<name>)\n", e.g. "1 (top-half)\n".
> +
> +=09=09SW_TABLET_MODE input events are also emitted: 0 when the keyboard
> +=09=09is docked (either position), 1 when detached.
> diff --git a/MAINTAINERS b/MAINTAINERS
> new file mode 100644
> index 0000000..cb765b4
> --- /dev/null
> +++ b/MAINTAINERS
> @@ -0,0 +1,6 @@
> +LENOVO YOGA BOOK 9 KEYBOARD DOCK DRIVER
> +M:=09Dave Carey <carvsdriver@gmail.com>
> +L:=09platform-driver-x86@vger.kernel.org
> +S:=09Maintained
> +F:=09Documentation/ABI/testing/sysfs-driver-lenovo-yb9-kbdock
> +F:=09drivers/platform/x86/lenovo/yb9-kbdock.c
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
> index 0000000..693e287
> --- /dev/null
> +++ b/drivers/platform/x86/lenovo/yb9-kbdock.c
> @@ -0,0 +1,216 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Lenovo Yoga Book 9 keyboard-dock detection
> + *
> + * The Yoga Book 9 ships with a detachable Bluetooth keyboard that magne=
tically
> + * attaches to the bottom screen in one of two positions.  The EC tracks
> + * attachment state in a 2-bit field called BKBD and signals changes via=
 WMI
> + * event 0xEB on the WM10 ACPI device.
> + *
> + * BKBD values:
> + *   0 =3D keyboard detached
> + *   1 =3D keyboard docked on the top half of the bottom screen
> + *   2 =3D keyboard docked on the bottom half of the bottom screen
> + *   3 =3D reserved / not observed
>
> + * This driver registers for the WMI event GUID, queries BKBD on probe a=
nd on
> + * each event, reports SW_TABLET_MODE=3D0 when the keyboard is docked (e=
ither
> + * position) and SW_TABLET_MODE=3D1 when detached, and exposes the raw B=
KBD
> + * value in sysfs as "keyboard_position".

I don't think the functional description on this level is warranted in the=
=20
top comment (may place it below where you define things but if naming is=20
obvious, some comments may not even be necessary).

> + * Copyright (C) 2026 Dave Carey <carvsdriver@gmail.com>
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/wmi.h>
> +
> +/*
> + * WM10 ACPI device (_UID "GMZN"):
> + *   Event GUID =E2=80=94 notify ID 0xEB fires on keyboard attachment ch=
ange.
> + *   Query GUID =E2=80=94 object "AF", maps to WQAF(); returns 8-byte bu=
ffer
> + *                {LFID=3D0x00060000, BKBD[31:0]}.
> + */
> +#define YB9_KBDOCK_EVENT_GUID=09"806BD2A2-177B-481D-BFB5-3BA0BB4A2285"
> +#define YB9_KBDOCK_QUERY_GUID=09"E7F300FA-21CD-4003-ADAC-2696135982E6"
> +
> +#define YB9_KBDOCK_QUERY_INSTANCE=090
> +
> +/* BKBD encoding =E2=80=94 keyboard always docks on the bottom screen */
> +#define BKBD_DETACHED=09=090
> +#define BKBD_TOP_HALF=09=091=09/* docked on top half of bottom screen */
> +#define BKBD_BOTTOM_HALF=092=09/* docked on bottom half of bottom screen=
 */
> +
> +static const struct dmi_system_id yb9_kbdock_dmi_table[] =3D {
> +=09{
> +=09=09/* Lenovo Yoga Book 9 14IAH10 */
> +=09=09.matches =3D {
> +=09=09=09DMI_MATCH(DMI_SYS_VENDOR,   "LENOVO"),
> +=09=09=09DMI_MATCH(DMI_PRODUCT_NAME, "83KJ"),
> +=09=09},
> +=09},
> +=09{ }
> +};

Normally these appear towards the end of the file.

> +
> +struct yb9_kbdock_priv {
> +=09struct input_dev *input_dev;
> +=09unsigned int bkbd;=09/* last read BKBD value (0-3) */
> +};
> +
> +/* Read current BKBD state via WQAF.  Returns 0-3 or -errno. */
> +static int yb9_kbdock_query(struct wmi_device *wdev)
> +{
> +=09struct acpi_buffer out =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +=09union acpi_object *obj;
> +=09acpi_status status;
> +=09u32 bkbd;
> +
> +=09status =3D wmi_query_block(YB9_KBDOCK_QUERY_GUID,
> +=09=09=09=09 YB9_KBDOCK_QUERY_INSTANCE, &out);

This interface has been deprecated.

> +=09if (ACPI_FAILURE(status)) {
> +=09=09dev_warn(&wdev->dev, "WQAF query failed: %s\n",
> +=09=09=09 acpi_format_exception(status));
> +=09=09return -EIO;
> +=09}
> +
> +=09obj =3D out.pointer;
> +=09if (!obj) {
> +=09=09dev_warn(&wdev->dev, "WQAF returned NULL\n");
> +=09=09return -EIO;
> +=09}
> +
> +=09/*
> +=09 * WQAF returns an 8-byte buffer: bytes [0..3] =3D LFID (0x00060000),
> +=09 * bytes [4..7] =3D BKBD value.  Guard against short buffers.

One space is enough.

> +=09 */
> +=09if (obj->type =3D=3D ACPI_TYPE_BUFFER && obj->buffer.length >=3D 8) {
> +=09=09memcpy(&bkbd, obj->buffer.pointer + 4, sizeof(bkbd));
> +=09=09bkbd &=3D 0x3;

Can this literal be named with a define? Should it use FIELD_GET()=20
(don't forget the header if you start to use FIELD_GET())?

> +=09} else if (obj->type =3D=3D ACPI_TYPE_INTEGER) {
> +=09=09bkbd =3D obj->integer.value & 0x3;

Same question here.

> +=09} else {
> +=09=09dev_warn(&wdev->dev,
> +=09=09=09 "WQAF: unexpected result type %d len %u\n",
> +=09=09=09 obj->type,
> +=09=09=09 obj->type =3D=3D ACPI_TYPE_BUFFER
> +=09=09=09=09? obj->buffer.length : 0);

Put the last two lines to one line.

> +=09=09kfree(obj);
> +=09=09return -EIO;
> +=09}
> +
> +=09kfree(obj);

Please use __free() instead of duplicating kfree()s.

When converting to __free(), don't use ... =3D NULL; pattern, instead place=
=20
the variable declaration mid-function as instructed in the long comment in=
=20
cleanup.h.

> +=09return (int)bkbd;

Unnecessary cast. And your types are a major mess between int and=20
unsigned types.

> +}
> +
> +static void yb9_kbdock_update(struct wmi_device *wdev)
> +{
> +=09struct yb9_kbdock_priv *priv =3D dev_get_drvdata(&wdev->dev);
> +=09int bkbd;
> +=09int tablet_mode;

Please use reverse-xmas tree order where there are no internal=20
dependencies between local variables that prevent usinbg it.

> +
> +=09bkbd =3D yb9_kbdock_query(wdev);
> +=09if (bkbd < 0)
> +=09=09return;
> +
> +=09priv->bkbd =3D bkbd;
> +
> +=09/*
> +=09 * Report tablet mode only when the keyboard is fully detached.
> +=09 * Both docked positions (top-half and bottom-half of the bottom scre=
en)
> +=09 * indicate a physical keyboard is present =E2=80=94 report laptop mo=
de.
> +=09 */
> +=09tablet_mode =3D (bkbd =3D=3D BKBD_DETACHED) ? 1 : 0;
> +
> +=09input_report_switch(priv->input_dev, SW_TABLET_MODE, tablet_mode);
> +=09input_sync(priv->input_dev);
> +
> +=09dev_dbg(&wdev->dev, "BKBD=3D%u tablet_mode=3D%d\n", bkbd, tablet_mode=
);

Missing include.

> +}
> +
> +static void yb9_kbdock_notify(struct wmi_device *wdev, union acpi_object=
 *data)
> +{
> +=09yb9_kbdock_update(wdev);
> +}
> +
> +/* sysfs: keyboard_position =E2=80=94 exposes raw BKBD value */
> +static ssize_t keyboard_position_show(struct device *dev,
> +=09=09=09=09      struct device_attribute *attr, char *buf)
> +{
> +=09struct yb9_kbdock_priv *priv =3D dev_get_drvdata(dev);
> +=09static const char * const names[] =3D {
> +=09=09"detached", "top-half", "bottom-half", "unknown"

Use comma for all non-terminating entries.

> +=09};
> +=09unsigned int bkbd =3D priv->bkbd;
> +
> +=09if (bkbd > 3)

How can this happen without it being bug in the driver? Didn't you mask it=
=20
when reading the value?

So maybe

=09if (WARN_ON_ONCE(bkbd > 3))
=09=09return -EINVAL;

> +=09=09bkbd =3D 3;
> +=09return sysfs_emit(buf, "%u (%s)\n", bkbd, names[bkbd]);
> +}
> +static DEVICE_ATTR_RO(keyboard_position);
> +
> +static struct attribute *yb9_kbdock_attrs[] =3D {
> +=09&dev_attr_keyboard_position.attr,
> +=09NULL,
> +};
> +ATTRIBUTE_GROUPS(yb9_kbdock);
> +
> +static int yb9_kbdock_probe(struct wmi_device *wdev, const void *ctx)
> +{
> +=09struct yb9_kbdock_priv *priv;
> +=09struct input_dev *input_dev;
> +=09int err;
> +
> +=09if (!dmi_check_system(yb9_kbdock_dmi_table)) {
> +=09=09dev_dbg(&wdev->dev, "not a Yoga Book 9, skipping\n");
> +=09=09return -ENODEV;
> +=09}
> +
> +=09priv =3D devm_kzalloc(&wdev->dev, sizeof(*priv), GFP_KERNEL);
> +=09if (!priv)
> +=09=09return -ENOMEM;
> +
> +=09input_dev =3D devm_input_allocate_device(&wdev->dev);
> +=09if (!input_dev)
> +=09=09return -ENOMEM;
> +
> +=09input_dev->name =3D "Lenovo Yoga Book 9 keyboard dock switch";
> +=09input_dev->phys =3D YB9_KBDOCK_EVENT_GUID "/input0";
> +=09input_dev->id.bustype =3D BUS_HOST;
> +=09input_set_capability(input_dev, EV_SW, SW_TABLET_MODE);
> +
> +=09err =3D input_register_device(input_dev);
> +=09if (err) {
> +=09=09dev_err(&wdev->dev, "failed to register input device: %d\n", err);
> +=09=09return err;
> +=09}
> +
> +=09priv->input_dev =3D input_dev;
> +=09dev_set_drvdata(&wdev->dev, priv);
> +
> +=09/* Report initial state */
> +=09yb9_kbdock_update(wdev);
> +=09return 0;
> +}
> +
> +static const struct wmi_device_id yb9_kbdock_wmi_id_table[] =3D {
> +=09{ .guid_string =3D YB9_KBDOCK_EVENT_GUID },
> +=09{ }
> +};
> +MODULE_DEVICE_TABLE(wmi, yb9_kbdock_wmi_id_table);
> +
> +static struct wmi_driver yb9_kbdock_driver =3D {
> +=09.driver =3D {
> +=09=09.name =3D "lenovo-yb9-kbdock",
> +=09=09.dev_groups =3D yb9_kbdock_groups,
> +=09},
> +=09.id_table =3D yb9_kbdock_wmi_id_table,
> +=09.probe    =3D yb9_kbdock_probe,
> +=09.notify   =3D yb9_kbdock_notify,
> +};
> +module_wmi_driver(yb9_kbdock_driver);
> +
> +MODULE_AUTHOR("Dave Carey <carvsdriver@gmail.com>");
> +MODULE_DESCRIPTION("Lenovo Yoga Book 9 keyboard dock detection");
> +MODULE_LICENSE("GPL");
>=20

--=20
 i.
--8323328-1698080933-1777385484=:1128--
