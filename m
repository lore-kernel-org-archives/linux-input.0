Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B481A2F8EB1
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 02:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576586; cv=pass; b=PkdeNR8vrWfvsS0K1GOPRG7JXqs+bQ0Njed3SqtU0sY6l0AEC3iBt8cf42hoPTotbYGT0xlFpfke/VhBsu0xLy/FttJOjITaecEpMyqJ8BlzSer9pppuMIQSD/FTI1cLl7MfwiapEjC93TR3XLiJtsjGqDy4j3wAqvdsMvfTPrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576586; c=relaxed/simple;
	bh=7+5DjOPIrFAOwoNcTuEVWTZZROvc1qsJq95Mf/niBic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2zUinKC0U1m10KRWibBwRDEYCk61JYJxkw7B3bE9YR8u8+cy54+ezgk3w8GWmcY1or+5O8+tW8fOxVqwtRJJu+0PkOoT9Y6MEyijUe2R7h5wgzqulyka2kN1pnYa+LRskCzTPWWQKIsPQo+qDe35spDv5Z4WjFwpEJTdmu+7bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XagVdGlb; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XagVdGlb"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ce9df49c5fso63696336d6.1
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 19:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781576583; cv=none;
        d=google.com; s=arc-20240605;
        b=UG/hOpkFBo3Yum4es5gGd5BS8o2qAzdZ6BlEIe+sgOlmUjNuxrdNlFVLAOsD4vSCnB
         8j/fkiL5k9KcHyTdKY4hHwneMP5Ex53k2hYAzUdjS3CRm5Gi9zxdv1abOA036Vun8oE+
         s4/i1iSuIGGMKuR/XjwvE4Dg6JwT0Fd161Vx3zwiBAkevP8cBrC25zl0uQJwt+rNKmKP
         k9DA3xRO5M/XYyNB/TzFeik8cD5TH/cV9aRheR9dzT23tgsxhj9yWj4UjKJnNbYcbwXv
         SG39fWvRecwx6GVEARdnWiPUDxG0MLbU0sys2P88YM1ALqeTemp7s7YDCkLpmBGbG6qY
         k60w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q1dNV87/uNqM3rOplHk1aHURCzCCXxhTP4TKADqkwNY=;
        fh=IBiT43vu05OaLV71NtSQn/bekYaGW+dh55oVmP0v0/k=;
        b=ESflSNX8BWJmza/4jsYHb6m0zwShqFRvNF6bjOB1CPpbbpNDxLFlHVdVSvh/V011kU
         qZ8caVzNG3VbESY9J8XsiyTxcubo86jP12FVIkPyUZX1C++7BXkiE/DaJxqCBG85Wg7a
         GwuB5UyB5sf5ey9qbXiyWwVx3fQYBYpaNIjXM3kHi/G3JUPw+hZSHI7+cl8y3STDYCch
         8DgL21TxAbkriaKGe43d0QWqhpP+1ZwpDRtXe3A/ksEiB4VskUxis5UaGZOYOr6fckwR
         IA8FNjXrM1xo546b93Ga7ufoxm4uFmNpaJm6099PX7T1XKg91FC5u5F+EfVSUvRXEjUg
         gVKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781576583; x=1782181383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1dNV87/uNqM3rOplHk1aHURCzCCXxhTP4TKADqkwNY=;
        b=XagVdGlbYnwhYLmH+WIN4yvdk40obvWW7lAbVntXDk0SOs2zKdmGHr0QNmPhaEacQe
         Wxb7Tl1SkJisYS1DWjHK1NScS1/94AyjozH85lWRUUl6KDNwG3sFc7qY3/pezqOWQ5ke
         EaoU8Exjm7hP1ps3w8FjSTcWekjVF7za5+53sNPxpR6DRTlZLJELXJx+tF5Pf/mGurqL
         U3Q/5xqGxTKI8qOQzzxb0p/6UJ6z/zAAbqDg60r/ELlRcEZE5OLTw9i4GuyXSyCrEWn2
         9jYTHnqV/f6RnXbC6HR4hxdcvJz4M8/T4KK/U14SxrYoWQOrmwkGHIgrxZitihH2pX/J
         8A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781576583; x=1782181383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1dNV87/uNqM3rOplHk1aHURCzCCXxhTP4TKADqkwNY=;
        b=nijZM9sdkCuU9GckOirZuTjnIAluhFoCzSQhCmlAaTWsVFboJOd21Ea+Z9b9RSgVw5
         aoNxndNRgGDmiGOPnvawn4qzjemG6u7UygxBKUC95/ez+D7qH4iAHFFvbYCSZAMqPLdq
         zM7FSekFid/04yqJM6wBCnenP5bCQLHGST7/LPnnQCa6VoLq/ClqADFyYjVgy33mv5VO
         4MjOuCkY1B2ybeKRkq++WkDLs74oPHA8NkqVRznPcFUodskl/zy9yw6/T7szrMH/0blT
         f4RrjEWcdNBewCDK6+OjBshA8nlAvM8QyHtBJl26GZAcUlylfaYItweMnjZw9V6SB4gc
         rw2A==
X-Forwarded-Encrypted: i=1; AFNElJ+UhzjLZmnskwo5z/UQazfOLaaBoqWHHjdGM30XFgzZLS6sNHcvljlUQOWovLDoPGPgMXRGfQ+HVni3zw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwfBT0W6ggF5oxGM7mu5a1wyYDBbM7+QV9vuiAF8nHwtH62n3ei
	UCEPgBNmUHfWcnIlsjZcvH5nEhOaAAO2ssVoX03Z0AHmnKxN68CfcWgIExAN/dgn8yDjl5M4tsE
	mKyoVUgF0zNkU1JHQskkg3uT8td0gr8Y=
X-Gm-Gg: Acq92OGrz3rcGVvod/Drw/VC5weXrfb8RPNQHVZZTbUDg6bVAm6JJf7V/EiSd5qtIIf
	B95kQ4yrU3+iqNtNngT7MaJCPnmZsOpzCMoMY0c3I7XW+hJ8wbDbGdtvditvP7n4wZswNJMc/qA
	udwII4wWyLPiE8KNSpqd2M5ABNMVXOB1CGPEPXAz6sMIN8ygrGKbpB2BaOjRrX2dOMeSdpK9PM8
	bFPSwqfpGYmn5EPLHNYeDa9pG0X/kPsSIZ6yv90O4Hsdx3PyympjcC7N6xtbEarlKxxhtjBwoLM
	1x4qb5M=
X-Received: by 2002:a05:6214:3993:b0:8ce:b018:89ff with SMTP id
 6a1803df08f44-8d44f8fc7a0mr216260946d6.36.1781576583365; Mon, 15 Jun 2026
 19:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521031750.498110-1-andrewmaney05@gmail.com>
 <ag6qqUZKiTlfU4Rb@beelink> <CAO1jzHj6AAB_hkitjsGJDXeN5iiSWcrEdCMeZeuruXmhfwZzYQ@mail.gmail.com>
 <ah2iNcGB-xsEHC0r@beelink>
In-Reply-To: <ah2iNcGB-xsEHC0r@beelink>
From: Andrew Maney <andrewmaney05@gmail.com>
Date: Mon, 15 Jun 2026 22:22:52 -0400
X-Gm-Features: AVVi8CfDizBDLjW2XeIHsgnTc607CYBEV0Q_E77Gta8KEYSoe-EkTtbpTiyW61E
Message-ID: <CAO1jzHgkRcL1Qe4234D1zV10WqTbVRo=-q4tALthCEOpKj6wGw@mail.gmail.com>
Subject: Re: [PATCH v3] HID: Expose LattePanda IOTA UPS as a power_supply device
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, sorry for the late response. I've gotten quite busy recently.

I'll work in the kernel implementation, it will probably be easier to get g=
oing
with the cleanup code you have. In the meantime, I'll look deeper into the
HID-UPS specification so I can write a proper implementation.

Thanks,
Andrew

On Mon, Jun 1, 2026 at 11:24=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On May 21 2026, Andrew Maney wrote:
> > On Thu, May 21, 2026 at 2:54=E2=80=AFAM Benjamin Tissoires <bentiss@ker=
nel.org> wrote:
> > >
> > > On May 20 2026, Andrew Maney wrote:
> > > > This driver exposes the DFRobot LattePanda IOTA UPS board as a stan=
dard
> > > > power_supply device, allowing desktop environments and power manage=
ment
> > > > tools such as UPower and systemd-logind to display battery status,
> > > > remaining capacity, and charging status without any special
> > > > configuration. It also enables automatic suspend or shutdown on low
> > > > battery and power profile configuration via any tool that supports =
the
> > > > standard power_supply interface.
> > > >
> > > > The UPS presents itself as an Arduino Leonardo HID device running c=
ustom
> > > > firmware (VID 0x2341, PID 0x8036). It reports status and capacity v=
ia
> > > > HID reports 0x07 and 0x0C respectively.
> > >
> > > As sashiko detected, you are using a standard Arduino Leonardo and no=
t
> > > making any specific detections. So I was thinking that maybe we shoul=
d
> > > implement that feature as a HID-BPF program on top of the generic HID
> > > handling.
> > >
> > > However, the handling of battery supplies in the HID generic core is =
not
> > > entirely filling all of the requirements here, but that's something I
> > > wanted to do for a couple of month but I have been swamped with other
> > > projects.
> > >
> > > Anyway, I wanted to understand why this product was using a generic
> > > Leonardo PID, and: https://wiki.dfrobot.com/dfr1247#tech_specs
> > >
> > > "it leverages the standard HID-UPS protocol to be natively recognized=
 by
> > > Windows as a battery-powered device"
> > >
> > > So. Instead of working on a custom driver, why not simply implement (=
or
> > > finish the generic implementation) of HID-UPS in hid-input.c?
> > >
> > > Cheers,
> > > Benjamin
> > >
> >
> > Hi Benjamin,
> >
> > Thank you for the feedback! I'll look into the HID-UPS implementation o=
r a
> > HID-BPF program.
> >
> > I should mention that the kernel does already detect the IOTA UPS via t=
he
> > generic HID-UPS support, but the updates that it receives are so slow t=
hat
> > it becomes practically unusable for a device with smaller capacity batt=
eries
> > like this. Changes can take several minutes or more to be detected. I
> > originally went with a driver that reads the HID reports directly becau=
se it
> > was providing updates far faster.
> >
> > I implemented a check in driver v4 that verifies that the device's HID =
reports
> > are what's expected before binding to it. In theory, that should preven=
t the
> > driver from binding to other Arduino Leonardo devices, but I agree that=
 fixing
> > the generic HID-UPS implementation would be a better long-term solution=
.
> >
> > Which approach do you think would be more suitable for this, completing=
 the
> > HID-UPS implementation or a HID-BPF program? I'm happy to work on eithe=
r,
> > though as a first-time kernel contributor I'd appreciate any pointers
> > on where to
> > start.
>
> Honestly, if the device is compliant with HID-UPS, you should work in
> the kernel implementation. A HID-BPF would be used to fix device issues,
> but if the kernel is not correct enough you can't do much in just a
> HID-BPF.
>
> If I'm not wrong, the HID-UPS implementation we have currently is the
> hid_battery_* functions. And that implementation assumes a HID connected
> device is a separate device, not a power supply of the main machine. So
> you'll have to deal with a few new HID fields.
>
> Also, I've started the cleanup work on the hid_battery code a couple of
> months ago and never got the chance to send it. Maybe I should send it
> so you can have a better environment with testing.
>
> Cheers,
> Benjamin
>
> >
> > Thanks,
> > Andrew
> >
> > > >
> > > > The charge limit (80% or 100%) is configured via a physical DIP swi=
tch
> > > > on the UPS board and cannot be detected automatically. Userspace ca=
n
> > > > inform the driver of the configured limit via
> > > > charge_control_end_threshold.
> > > >
> > > > ---
> > > >
> > > > Changes in v3:
> > > > - Deferred power_supply registration to workqueue to avoid blocking=
 probe
> > > > - Fixed kernel panic when instantiated via uhid by checking hid_is_=
usb()
> > > >   before dereferencing USB-specific structures
> > > >
> > > > - Fixed ERR_PTR dereference in raw_event by only assigning ups->psu=
 on
> > > >   successful registration
> > > >
> > > > - Fixed data race on ups->charge_limit using spin_lock_irqsave()
> > > > - Removed TIME_TO_EMPTY_NOW and TIME_TO_FULL_NOW properties to avoi=
d
> > > > spurious shutdowns
> > > >
> > > > - Changed plugged-in but not charging state from FULL to NOT_CHARGI=
NG
> > > > - Used devm_kasprintf() for a unique sysfs name in order to support
> > > > multiple devices
> > > >
> > > > - Added POWER_SUPPLY and HIDRAW dependencies to Kconfig
> > > > - Used %pe for more human-readable error messages
> > > >
> > > > Changes in v2:
> > > > - Rebased on top of the current tree
> > > > - Moved vendor and device IDs to drivers/hid/hid-ids.h
> > > > - Added Kconfig entry under HID bus support -> Special HID drivers
> > > > - Added build rule to drivers/hid/Makefile
> > > >
> > > > Signed-off-by: Andrew Maney <andrewmaney05@gmail.com>
> > > > ---
> > > >  MAINTAINERS                           |   6 +
> > > >  drivers/hid/Kconfig                   |  10 +
> > > >  drivers/hid/Makefile                  |   1 +
> > > >  drivers/hid/hid-ids.h                 |   3 +
> > > >  drivers/hid/hid-lattepanda-iota-ups.c | 409 ++++++++++++++++++++++=
++++
> > > >  5 files changed, 429 insertions(+)
> > > >  create mode 100644 drivers/hid/hid-lattepanda-iota-ups.c
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 10e825318..d80721c2c 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -11416,6 +11416,12 @@ F:   include/uapi/linux/hid*
> > > >  F:   samples/hid/
> > > >  F:   tools/testing/selftests/hid/
> > > >
> > > > +HID LATTEPANDA IOTA UPS DRIVER
> > > > +M:   Andrew Maney <andrewmaney05@gmail.com>
> > > > +L:   linux-input@vger.kernel.org
> > > > +S:   Maintained
> > > > +F:   drivers/hid/hid-lattepanda-iota-ups.c
> > > > +
> > > >  HID LOGITECH DRIVERS
> > > >  R:   Filipe La=C3=ADns <lains@riseup.net>
> > > >  L:   linux-input@vger.kernel.org
> > > > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > > > index ff2f580b6..21ffc2fd0 100644
> > > > --- a/drivers/hid/Kconfig
> > > > +++ b/drivers/hid/Kconfig
> > > > @@ -510,6 +510,16 @@ config HID_KYSONA
> > > >       Say Y here if you have a Kysona M600 mouse
> > > >       and want to be able to read its battery capacity.
> > > >
> > > > +config HID_LATTEPANDA_IOTA_UPS
> > > > +     tristate "LattePanda IOTA UPS"
> > > > +     depends on USB_HID && USB_HIDDEV && X86 && POWER_SUPPLY
> > > > +     help
> > > > +     Support for the LattePanda IOTA UPS (DFRobot, VID 0x2341 PID =
0x8036).
> > > > +     Exposes the battery status and capacity via the power_supply =
interface.
> > > > +
> > > > +     To compile as a module, choose M here: the module will be
> > > > +     called hid-lattepanda-iota-ups.
> > > > +
> > > >  config HID_UCLOGIC
> > > >       tristate "UC-Logic"
> > > >       depends on USB_HID
> > > > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > > > index 0597fd6a4..d7ad3fc8f 100644
> > > > --- a/drivers/hid/Makefile
> > > > +++ b/drivers/hid/Makefile
> > > > @@ -74,6 +74,7 @@ obj-$(CONFIG_HID_KENSINGTON)        +=3D hid-kens=
ington.o
> > > >  obj-$(CONFIG_HID_KEYTOUCH)   +=3D hid-keytouch.o
> > > >  obj-$(CONFIG_HID_KYE)                +=3D hid-kye.o
> > > >  obj-$(CONFIG_HID_KYSONA)     +=3D hid-kysona.o
> > > > +obj-$(CONFIG_HID_LATTEPANDA_IOTA_UPS)        +=3D hid-lattepanda-i=
ota-ups.o
> > > >  obj-$(CONFIG_HID_LCPOWER)    +=3D hid-lcpower.o
> > > >  obj-$(CONFIG_HID_LENOVO)     +=3D hid-lenovo.o
> > > >  obj-$(CONFIG_HID_LENOVO_GO)  +=3D hid-lenovo-go.o
> > > > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > > > index 4657d96fb..6ded2c943 100644
> > > > --- a/drivers/hid/hid-ids.h
> > > > +++ b/drivers/hid/hid-ids.h
> > > > @@ -859,6 +859,9 @@
> > > >  #define USB_DEVICE_ID_LD_HYBRID              0x2090
> > > >  #define USB_DEVICE_ID_LD_HEATCONTROL 0x20A0
> > > >
> > > > +#define USB_VENDOR_ID_LATTEPANDA_IOTA        0x2341
> > > > +#define USB_DEVICE_ID_LATTEPANDA_IOTA_UPS    0x8036
> > > > +
> > > >  #define USB_VENDOR_ID_LENOVO         0x17ef
> > > >  #define USB_DEVICE_ID_LENOVO_TPKBD   0x6009
> > > >  #define USB_DEVICE_ID_LENOVO_CUSBKBD 0x6047
> > > > diff --git a/drivers/hid/hid-lattepanda-iota-ups.c b/drivers/hid/hi=
d-lattepanda-iota-ups.c
> > > > new file mode 100644
> > > > index 000000000..f5d522695
> > > > --- /dev/null
> > > > +++ b/drivers/hid/hid-lattepanda-iota-ups.c
> > > > @@ -0,0 +1,409 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +#include <linux/power_supply.h>
> > > > +#include <linux/completion.h>
> > > > +#include <linux/workqueue.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/spinlock.h>
> > > > +#include <linux/hid.h>
> > > > +#include <linux/usb.h>
> > > > +#include "hid-ids.h"
> > > > +
> > > > +#define REPORT_ID_CAPACITY   0x0C
> > > > +#define REPORT_ID_STATUS     0x07
> > > > +
> > > > +#define STATUS_DISCHARGING   BIT(1)
> > > > +#define STATUS_PLUGGED_IN    BIT(0)
> > > > +#define STATUS_CHARGING              BIT(2)
> > > > +
> > > > +MODULE_AUTHOR("Andrew Maney");
> > > > +MODULE_DESCRIPTION("LattePanda IOTA UPS power supply driver");
> > > > +MODULE_LICENSE("GPL");
> > > > +
> > > > +struct iota_ups {
> > > > +     struct power_supply_desc psu_desc;
> > > > +     struct power_supply *psu;
> > > > +     struct hid_device *hiddev;
> > > > +     spinlock_t lock; /* Protects cached HID report values */
> > > > +
> > > > +     /* Cached values that are updated from HID reports */
> > > > +     bool plugged_in;
> > > > +     char serial[64];
> > > > +     int charge_limit;
> > > > +     int psu_status;
> > > > +     int capacity;
> > > > +
> > > > +     /*
> > > > +      * Wait for both status and capacity reports before registeri=
ng
> > > > +      * with the power_supply core, so initial values are correct =
and
> > > > +      * not erroneous.
> > > > +      */
> > > > +     struct completion got_initial_data;
> > > > +     struct work_struct register_work;
> > > > +     bool got_capacity;
> > > > +     bool data_ready;
> > > > +     bool got_status;
> > > > +};
> > > > +
> > > > +static enum power_supply_property iota_ups_properties[] =3D {
> > > > +     POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> > > > +     POWER_SUPPLY_PROP_SERIAL_NUMBER,
> > > > +     POWER_SUPPLY_PROP_MANUFACTURER,
> > > > +     POWER_SUPPLY_PROP_MODEL_NAME,
> > > > +     POWER_SUPPLY_PROP_TECHNOLOGY,
> > > > +     POWER_SUPPLY_PROP_CAPACITY,
> > > > +     POWER_SUPPLY_PROP_PRESENT,
> > > > +     POWER_SUPPLY_PROP_ONLINE,
> > > > +     POWER_SUPPLY_PROP_STATUS,
> > > > +     POWER_SUPPLY_PROP_SCOPE,
> > > > +};
> > > > +
> > > > +static const struct hid_device_id iota_ups_devices[] =3D {
> > > > +     { HID_USB_DEVICE(USB_VENDOR_ID_LATTEPANDA_IOTA,
> > > > +             USB_DEVICE_ID_LATTEPANDA_IOTA_UPS) },
> > > > +     { }
> > > > +};
> > > > +MODULE_DEVICE_TABLE(hid, iota_ups_devices);
> > > > +
> > > > +static int iota_ups_get_property(struct power_supply *supply,
> > > > +                              enum power_supply_property psp,
> > > > +                              union power_supply_propval *val)
> > > > +{
> > > > +     struct iota_ups *ups =3D power_supply_get_drvdata(supply);
> > > > +     unsigned long flags;
> > > > +
> > > > +     spin_lock_irqsave(&ups->lock, flags);
> > > > +
> > > > +     switch (psp) {
> > > > +     case POWER_SUPPLY_PROP_STATUS:
> > > > +             val->intval =3D ups->psu_status;
> > > > +             break;
> > > > +
> > > > +     /* Remaining capacity as a percentage from 0 to 100 */
> > > > +     case POWER_SUPPLY_PROP_CAPACITY:
> > > > +             val->intval =3D ups->capacity;
> > > > +             break;
> > > > +
> > > > +     /* The UPS is always present if the driver is loaded */
> > > > +     case POWER_SUPPLY_PROP_PRESENT:
> > > > +             val->intval =3D 1;
> > > > +             break;
> > > > +
> > > > +     /* Whether mains power is connected */
> > > > +     case POWER_SUPPLY_PROP_ONLINE:
> > > > +             val->intval =3D ups->plugged_in ? 1 : 0;
> > > > +             break;
> > > > +
> > > > +     /*
> > > > +      * The UPS board supplies power to the IOTA and any
> > > > +      * peripherals connected to it, therefore its scope
> > > > +      * is system-wide.
> > > > +      */
> > > > +     case POWER_SUPPLY_PROP_SCOPE:
> > > > +             val->intval =3D POWER_SUPPLY_SCOPE_SYSTEM;
> > > > +             break;
> > > > +
> > > > +     /* V1.0 only accepts 18650 Li-ion cells */
> > > > +     case POWER_SUPPLY_PROP_TECHNOLOGY:
> > > > +             val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> > > > +             break;
> > > > +
> > > > +     /* 80% or 100%, configured via a DIP switch on the UPS board =
*/
> > > > +     case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> > > > +             val->intval =3D ups->charge_limit;
> > > > +             break;
> > > > +
> > > > +     case POWER_SUPPLY_PROP_MANUFACTURER:
> > > > +             val->strval =3D "DFRobot";
> > > > +             break;
> > > > +
> > > > +     case POWER_SUPPLY_PROP_MODEL_NAME:
> > > > +             val->strval =3D "LattePanda IOTA UPS";
> > > > +             break;
> > > > +
> > > > +     /* Retrieved from the USB descriptor */
> > > > +     case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> > > > +             val->strval =3D ups->serial;
> > > > +             break;
> > > > +
> > > > +     default:
> > > > +             spin_unlock_irqrestore(&ups->lock, flags);
> > > > +             return -EINVAL;
> > > > +     }
> > > > +
> > > > +     spin_unlock_irqrestore(&ups->lock, flags);
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static int iota_ups_set_property(struct power_supply *supply,
> > > > +                              enum power_supply_property psp,
> > > > +                              const union power_supply_propval *va=
l)
> > > > +{
> > > > +     struct iota_ups *ups =3D power_supply_get_drvdata(supply);
> > > > +
> > > > +     if (psp =3D=3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD=
) {
> > > > +             unsigned long flags;
> > > > +
> > > > +             /*
> > > > +              * V1.0 supports 80% and 100% charge limits only, whi=
ch is
> > > > +              * set via a DIP switch on the board. This property a=
llows
> > > > +              * userspace to inform the driver which limit is conf=
igured.
> > > > +              */
> > > > +             if (val->intval !=3D 80 && val->intval !=3D 100)
> > > > +                     return -EINVAL;
> > > > +
> > > > +             spin_lock_irqsave(&ups->lock, flags);
> > > > +             ups->charge_limit =3D val->intval;
> > > > +             spin_unlock_irqrestore(&ups->lock, flags);
> > > > +             return 0;
> > > > +     }
> > > > +
> > > > +     return -EINVAL;
> > > > +}
> > > > +
> > > > +static int iota_ups_property_is_writable(struct power_supply *supp=
ly,
> > > > +                                      enum power_supply_property p=
sp)
> > > > +{
> > > > +     return psp =3D=3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESH=
OLD;
> > > > +}
> > > > +
> > > > +static int iota_ups_raw_event(struct hid_device *hdev,
> > > > +                           struct hid_report *report,
> > > > +                           u8 *data, int size)
> > > > +{
> > > > +     struct iota_ups *ups =3D hid_get_drvdata(hdev);
> > > > +     unsigned long flags;
> > > > +     bool changed =3D false;
> > > > +
> > > > +     /* All of the UPS's reports are at least 2 bytes */
> > > > +     if (size < 2)
> > > > +             return 0;
> > > > +
> > > > +     spin_lock_irqsave(&ups->lock, flags);
> > > > +
> > > > +     switch (data[0]) {
> > > > +     case REPORT_ID_STATUS: {
> > > > +             u8 status =3D data[1];
> > > > +             int new_status;
> > > > +             bool plugged_in =3D !!(status & STATUS_PLUGGED_IN);
> > > > +
> > > > +             /*
> > > > +              * The UPS status is determined as follows:
> > > > +              * Battery full:
> > > > +              *      UPS is plugged in
> > > > +              *      Battery is at full capacity
> > > > +              *
> > > > +              * Battery charging:
> > > > +              *      UPS is plugged in
> > > > +              *      Battery is not at full capacity
> > > > +              *
> > > > +              * Battery discharging:
> > > > +              *      UPS is not plugged in
> > > > +              *
> > > > +              * Battery not charging:
> > > > +              *      UPS is plugged in
> > > > +              *      UPS has halted charging for some reason
> > > > +              *
> > > > +              * Unknown:
> > > > +              *      None of the above conditions are met
> > > > +              */
> > > > +             if (status & STATUS_CHARGING) {
> > > > +                     if (ups->capacity >=3D ups->charge_limit)
> > > > +                             new_status =3D POWER_SUPPLY_STATUS_FU=
LL;
> > > > +                     else
> > > > +                             new_status =3D POWER_SUPPLY_STATUS_CH=
ARGING;
> > > > +
> > > > +             } else if (status & STATUS_DISCHARGING) {
> > > > +                     new_status =3D POWER_SUPPLY_STATUS_DISCHARGIN=
G;
> > > > +
> > > > +             } else if (plugged_in) {
> > > > +                     new_status =3D POWER_SUPPLY_STATUS_NOT_CHARGI=
NG;
> > > > +
> > > > +             } else {
> > > > +                     new_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > > > +             }
> > > > +
> > > > +             if (new_status !=3D ups->psu_status ||
> > > > +                 plugged_in !=3D ups->plugged_in) {
> > > > +                     ups->plugged_in =3D plugged_in;
> > > > +                     ups->psu_status =3D new_status;
> > > > +                     changed =3D true;
> > > > +             }
> > > > +
> > > > +             ups->got_status =3D true;
> > > > +             break;
> > > > +     }
> > > > +
> > > > +     case REPORT_ID_CAPACITY: {
> > > > +             int new_cap =3D clamp((int)data[1], 0, 100);
> > > > +
> > > > +             if (new_cap !=3D ups->capacity) {
> > > > +                     ups->capacity =3D new_cap;
> > > > +                     changed =3D true;
> > > > +             }
> > > > +
> > > > +             ups->got_capacity =3D true;
> > > > +             break;
> > > > +     }
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * Signal that the UPS is ready to be registered because we h=
ave
> > > > +      * received both capacity and status reports.
> > > > +      */
> > > > +     if (!ups->data_ready && ups->got_status && ups->got_capacity)=
 {
> > > > +             ups->data_ready =3D true;
> > > > +             complete(&ups->got_initial_data);
> > > > +     }
> > > > +
> > > > +     spin_unlock_irqrestore(&ups->lock, flags);
> > > > +
> > > > +     /*
> > > > +      * Notify the power_supply core outside the spinlock to avoid
> > > > +      * a deadlock; power_supply_changed() may call back into
> > > > +      * get_property() which acquires the same lock.
> > > > +      */
> > > > +     if (changed && ups->psu)
> > > > +             power_supply_changed(ups->psu);
> > > > +
> > > > +     return 0;
> > > > +}
> > > > +
> > > > +static void iota_ups_register_work(struct work_struct *work)
> > > > +{
> > > > +     struct iota_ups *ups =3D container_of(work, struct iota_ups, =
register_work);
> > > > +     struct power_supply_config psu_config =3D {};
> > > > +     struct power_supply *psu;
> > > > +
> > > > +     /*
> > > > +      * Wait for both status and capacity reports before registeri=
ng.
> > > > +      * The device sends reports every ~1 second, so 3 seconds is =
safe.
> > > > +      * We wait here in order to prevent registration in an unknow=
n
> > > > +      * state, since this could cause emergency shutdowns or other
> > > > +      * undesired effects.
> > > > +      */
> > > > +     wait_for_completion_timeout(&ups->got_initial_data,
> > > > +                                 msecs_to_jiffies(3000));
> > > > +
> > > > +     /* Configure the UPS's power supply properties */
> > > > +     ups->psu_desc.name =3D devm_kasprintf(&ups->hiddev->dev, GFP_=
KERNEL,
> > > > +                                         "lattepanda-iota-ups.%s",
> > > > +                                         dev_name(&ups->hiddev->de=
v));
> > > > +
> > > > +     if (!ups->psu_desc.name) {
> > > > +             hid_err(ups->hiddev, "failed to allocate power supply=
 name\n");
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     ups->psu_desc.property_is_writeable =3D iota_ups_property_is_=
writable;
> > > > +     ups->psu_desc.num_properties        =3D ARRAY_SIZE(iota_ups_p=
roperties);
> > > > +     ups->psu_desc.get_property          =3D iota_ups_get_property=
;
> > > > +     ups->psu_desc.set_property          =3D iota_ups_set_property=
;
> > > > +     ups->psu_desc.properties            =3D iota_ups_properties;
> > > > +     ups->psu_desc.type                  =3D POWER_SUPPLY_TYPE_BAT=
TERY;
> > > > +     psu_config.drv_data                 =3D ups;
> > > > +
> > > > +     /* Register the UPS as a power_supply device */
> > > > +     psu =3D devm_power_supply_register(&ups->hiddev->dev, &ups->p=
su_desc, &psu_config);
> > > > +     if (IS_ERR(psu)) {
> > > > +             hid_err(ups->hiddev, "power supply registration faile=
d: %pe\n", psu);
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     /*
> > > > +      * Finally, notify the power_supply core so userspace reads t=
he correct
> > > > +      * initial state immediately after registration.
> > > > +      */
> > > > +     ups->psu =3D psu;
> > > > +     power_supply_changed(ups->psu);
> > > > +     hid_info(ups->hiddev, "LattePanda IOTA UPS registered as a po=
wer_supply device\n");
> > > > +}
> > > > +
> > > > +static int iota_ups_probe(struct hid_device *hdev,
> > > > +                       const struct hid_device_id *id)
> > > > +{
> > > > +     struct iota_ups *ups;
> > > > +     int ret;
> > > > +
> > > > +     ups =3D devm_kzalloc(&hdev->dev, sizeof(*ups), GFP_KERNEL);
> > > > +     if (!ups)
> > > > +             return -ENOMEM;
> > > > +
> > > > +     ups->hiddev =3D hdev;
> > > > +     ups->psu_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > > > +
> > > > +     /* 50% is a safe default if wait_for_completion_timeout() tim=
es out. */
> > > > +     ups->capacity =3D 50;
> > > > +
> > > > +     /*
> > > > +      * Default to 100% to prevent unexpected shutdowns.
> > > > +      * Userspace can update this via charge_control_end_threshold=
.
> > > > +      */
> > > > +     ups->charge_limit =3D 100;
> > > > +
> > > > +     init_completion(&ups->got_initial_data);
> > > > +     spin_lock_init(&ups->lock);
> > > > +     hid_set_drvdata(hdev, ups);
> > > > +
> > > > +     /*
> > > > +      * Retrieve the UPS's serial number from the USB descriptor. =
If the device is not
> > > > +      * a USB device, we can use the unique device identifier as t=
he serial number.
> > > > +      */
> > > > +     if (hid_is_usb(hdev)) {
> > > > +             struct usb_device *udev =3D to_usb_device(hdev->dev.p=
arent->parent);
> > > > +
> > > > +             if (udev->serial)
> > > > +                     strscpy(ups->serial, udev->serial, sizeof(ups=
->serial));
> > > > +             else
> > > > +                     strscpy(ups->serial, "Unknown", sizeof(ups->s=
erial));
> > > > +     } else {
> > > > +             if (*hdev->uniq)
> > > > +                     strscpy(ups->serial, hdev->uniq, sizeof(ups->=
serial));
> > > > +             else
> > > > +                     strscpy(ups->serial, "Unknown", sizeof(ups->s=
erial));
> > > > +     }
> > > > +
> > > > +     ret =3D hid_parse(hdev);
> > > > +     if (ret) {
> > > > +             hid_err(hdev, "HID parse failed: %pe\n", ERR_PTR(ret)=
);
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> > > > +     if (ret) {
> > > > +             hid_err(hdev, "HID hw start failed: %pe\n", ERR_PTR(r=
et));
> > > > +             return ret;
> > > > +     }
> > > > +
> > > > +     ret =3D hid_hw_open(hdev);
> > > > +     if (ret) {
> > > > +             hid_err(hdev, "HID hw open failed: %pe\n", ERR_PTR(re=
t));
> > > > +             goto err_stop;
> > > > +     }
> > > > +
> > > > +     /* Probe for the UPS in a worker queue so we don't halt the e=
numeration thread */
> > > > +     INIT_WORK(&ups->register_work, iota_ups_register_work);
> > > > +     schedule_work(&ups->register_work);
> > > > +     return 0;
> > > > +
> > > > +err_stop:
> > > > +     hid_hw_stop(hdev);
> > > > +     return ret;
> > > > +}
> > > > +
> > > > +static void iota_ups_remove(struct hid_device *hdev)
> > > > +{
> > > > +     struct iota_ups *ups =3D hid_get_drvdata(hdev);
> > > > +
> > > > +     cancel_work_sync(&ups->register_work);
> > > > +     hid_hw_close(hdev);
> > > > +     hid_hw_stop(hdev);
> > > > +}
> > > > +
> > > > +static struct hid_driver iota_ups_driver =3D {
> > > > +     .name =3D "lattepanda-iota-ups",
> > > > +     .id_table =3D iota_ups_devices,
> > > > +     .probe =3D iota_ups_probe,
> > > > +     .remove =3D iota_ups_remove,
> > > > +     .raw_event =3D iota_ups_raw_event,
> > > > +};
> > > > +module_hid_driver(iota_ups_driver);
> > > > --
> > > > 2.54.0
> > > >
> > > >
> >
