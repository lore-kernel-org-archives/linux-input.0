Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD083E639B
	for <linux-input@vger.kernel.org>; Thu, 21 May 2026 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394942; cv=pass; b=pczgvu9+Mzumm+UbrATX+Zv1BB7H4//oyvrb+nWEM+0UhcOZvbVKsM857fhtlieKD8Rs8HPSZLoc/HqrnnkbRE5WFY3JEgFedCWn1SausbkphL4r9GvDibp2xSLYdAy4j7TKu4NMIys7qGw078Ir4i4QbMcRgcHxV3pb2LNA6v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394942; c=relaxed/simple;
	bh=o591EfCrBKJ/Puw0l3AvamBm38+M7I+6R/thvk+ljHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EuUOtXDszWmcoJ786DQKvYxlVFc1cPWbheQvD0ftE14Kk2dtOVMRIyGijtGFnS/OTZwHLU8ZgKlzLK82faUWh0ah6b3iPcH8sV1qIvOgvfyJu87ST9uhb/+8njJS5Of07usavmmjFcKm2ZyUaupSgVwjcxzdQKEXXl6Ta/NrPzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIcN6OXr; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIcN6OXr"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8b4eb1fd5d0so81765196d6.0
        for <linux-input@vger.kernel.org>; Thu, 21 May 2026 13:22:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779394939; cv=none;
        d=google.com; s=arc-20240605;
        b=OUVtwAXPHmp39u612NhruzL1hN6wPCneF7ueuCmqKXRm2W+T/cl3KxrjQrubhsIyFd
         lTyIfeuMBLxeregXIruR+V3UHylvj2YIhaGnJTk48gpx2fvuZAufuPU7cPE4xzsmoFar
         efkMTTfGWeSdbpgxEQVD8DnaSPSWu3a0ytQLxmqurRf3UdpD8ld85o/GBmW6QMvoEuHC
         DZ0VUf+V3StxnACB/LhB6xPEf29l2kp9GhWdgrLzRsQrdZBcYcrUHCtocmERYNpOn1Am
         3fZbIuCCe5A3pV9kVQNXh1htieXTQ7kn6DZ8MWYaTSx+SPSaop+7UYIurRLWNRi7Xnxl
         hQJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OQXtlNIN0ybe0+k0sM/989MG5RJJanc5Evv/cVIyO9k=;
        fh=zD8+mmlbfEB+vlEVrr/FJuLew1qXFjZUL4BpbUf+i5c=;
        b=OjT9i5eNRQrwzKNO7xcakLcoi/dIk2LpJPKnpCzJMalLp5slYrpy7XYJafc9MVaHEY
         GXkuC8fZdxmzao7TuXdfwAs3Qwx52RphhYPlULV7LZGpXaqht9OEQB5s2w9rrQMhxa5O
         /2KAAWG1B5nGRSJIiLG6FFAtuPbcmqqURp2Nl8lcRAvJCxkPCaoC7+iZw+MB8kCM9TuP
         EdNEbJ/kpP593VIMleoiic1H9JikiKBxxZLriq4DjO/OkYpZduvLiypttz5nXWvBfMNz
         ydFc8QqT9Do8/khS4FjOwFVL79MnAqxHjN2azWInX/cCoMoeRt1ntso1KHqQWVANM9m5
         Ntgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779394939; x=1779999739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQXtlNIN0ybe0+k0sM/989MG5RJJanc5Evv/cVIyO9k=;
        b=pIcN6OXr9JqjQUP1/LNlEcz66tfUpIMQjTT1oUBDmyJFD5E7wb3HoFMmP8/ZL5P7jZ
         6HmGqPHN/5Pqbrq4XB1oW6PGGP/Ziqqtexbpwdi62ytP9kcRfHQYIfqGRhSu8aWpkcsY
         SOmOcE7t9oaFhxWMObHclGtDbYixyNtO3YgEu3G2qudXkR6KQRYZjEDDVgYQ/vSs97Ye
         pLCzSwjSYNccydpSgDqxXdWPvZudw3Xjq7ugFmS/vLEVHtNghT0I6SRBKTxJLZfIEQLe
         jBfmhL4ndfN3aCT83qCvchSICEtBa5sd2YJ3/ss4lAWLY/sJNahVVHcKqFd+smkYGF1I
         RTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779394939; x=1779999739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OQXtlNIN0ybe0+k0sM/989MG5RJJanc5Evv/cVIyO9k=;
        b=kVfZw5bVZ0GeVtl9I2AdcenRYh7zzibxaVQWH+GMsXJfJZi6YdeNTyzFVyQOZx9ppC
         0617rfxs+3CNOlsMQAZG//DZu/BCUARkNR0eGUfyqrOndoGhrWLL6a9gem5Gn6tbS4Rh
         TZXb/icLqrdT2PfJ3q85qw2EclTbXRSYFTvhmvp/mpSO6ZMVBpP8M5sI5kfdKIaytbpU
         aKltn7j/aAoojdsKvjjUS8KTpmmSAEJS1oDnfaTexiy3xK+ocjWjh/e39W7kgoqR49QI
         +2+xDK7GXlte4WkgDqYbGoEE+54EYjYRohKE67IUErKwEOiZgb3gww1P5bRWsyFvre4a
         frAw==
X-Forwarded-Encrypted: i=1; AFNElJ/hl5HvHXOf7JRCsYytcca69O7NuRNHI+BuVyfkvMOwJKwpJ3X/Q0UGld2LWhqUzg29/C0nvwxHEx/Gbg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsmDo4P1mK1xrowco4U7Ezpd6lSNTiFVHvp7CXVrmgOIQEv7Y4
	Lvvz/qXtcCsQmNzMnMGpQthHET5/Rs1qFgQYopc5zuHGmA8Bj3+JSVn/Ux6F2IFXPThgJ1Zky3V
	ksZQsoDmNHpg+HFOv4MXMgJHUoftzjEc=
X-Gm-Gg: Acq92OHJy/2Tsw/5Ov/0wAdiu/SdqbsVdV12AVJaDpW4VOiMcdsugIF16MomDBOld2R
	WaykT1PyUspOpHo2iSkrGa8fc1sZin3mnNvT97rsMUEKrhSUz+8uuZbXkna3Nxu4sP7CfbF98L2
	XHVj+REqOvMQliz94Dn7nf8NAvzJ7jLkpHSbutetrgA0WVcZhy22uez4Eon8VfqXELSqoitFrqj
	LGlqItsguT+l+GUNNP6W+zcpJhvSTsLoDsyhI4vfk/hKk0BAbXLFt/fS1Grt8telka/iFARM/gm
	R8db8/RK1vIFGMpEyA==
X-Received: by 2002:a05:6214:5c06:b0:8ca:21b5:2e3f with SMTP id
 6a1803df08f44-8cc7b5003eamr15734176d6.6.1779394939156; Thu, 21 May 2026
 13:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521031750.498110-1-andrewmaney05@gmail.com> <ag6qqUZKiTlfU4Rb@beelink>
In-Reply-To: <ag6qqUZKiTlfU4Rb@beelink>
From: Andrew Maney <andrewmaney05@gmail.com>
Date: Thu, 21 May 2026 16:22:07 -0400
X-Gm-Features: AVHnY4KTZbOqw_9tlVEA1dJaO9hZdGc-Xr2j_s0_GnfPf2m-xBiito2MfM7jMpQ
Message-ID: <CAO1jzHj6AAB_hkitjsGJDXeN5iiSWcrEdCMeZeuruXmhfwZzYQ@mail.gmail.com>
Subject: Re: [PATCH v3] HID: Expose LattePanda IOTA UPS as a power_supply device
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 2:54=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.=
org> wrote:
>
> On May 20 2026, Andrew Maney wrote:
> > This driver exposes the DFRobot LattePanda IOTA UPS board as a standard
> > power_supply device, allowing desktop environments and power management
> > tools such as UPower and systemd-logind to display battery status,
> > remaining capacity, and charging status without any special
> > configuration. It also enables automatic suspend or shutdown on low
> > battery and power profile configuration via any tool that supports the
> > standard power_supply interface.
> >
> > The UPS presents itself as an Arduino Leonardo HID device running custo=
m
> > firmware (VID 0x2341, PID 0x8036). It reports status and capacity via
> > HID reports 0x07 and 0x0C respectively.
>
> As sashiko detected, you are using a standard Arduino Leonardo and not
> making any specific detections. So I was thinking that maybe we should
> implement that feature as a HID-BPF program on top of the generic HID
> handling.
>
> However, the handling of battery supplies in the HID generic core is not
> entirely filling all of the requirements here, but that's something I
> wanted to do for a couple of month but I have been swamped with other
> projects.
>
> Anyway, I wanted to understand why this product was using a generic
> Leonardo PID, and: https://wiki.dfrobot.com/dfr1247#tech_specs
>
> "it leverages the standard HID-UPS protocol to be natively recognized by
> Windows as a battery-powered device"
>
> So. Instead of working on a custom driver, why not simply implement (or
> finish the generic implementation) of HID-UPS in hid-input.c?
>
> Cheers,
> Benjamin
>

Hi Benjamin,

Thank you for the feedback! I'll look into the HID-UPS implementation or a
HID-BPF program.

I should mention that the kernel does already detect the IOTA UPS via the
generic HID-UPS support, but the updates that it receives are so slow that
it becomes practically unusable for a device with smaller capacity batterie=
s
like this. Changes can take several minutes or more to be detected. I
originally went with a driver that reads the HID reports directly because i=
t
was providing updates far faster.

I implemented a check in driver v4 that verifies that the device's HID repo=
rts
are what's expected before binding to it. In theory, that should prevent th=
e
driver from binding to other Arduino Leonardo devices, but I agree that fix=
ing
the generic HID-UPS implementation would be a better long-term solution.

Which approach do you think would be more suitable for this, completing the
HID-UPS implementation or a HID-BPF program? I'm happy to work on either,
though as a first-time kernel contributor I'd appreciate any pointers
on where to
start.

Thanks,
Andrew

> >
> > The charge limit (80% or 100%) is configured via a physical DIP switch
> > on the UPS board and cannot be detected automatically. Userspace can
> > inform the driver of the configured limit via
> > charge_control_end_threshold.
> >
> > ---
> >
> > Changes in v3:
> > - Deferred power_supply registration to workqueue to avoid blocking pro=
be
> > - Fixed kernel panic when instantiated via uhid by checking hid_is_usb(=
)
> >   before dereferencing USB-specific structures
> >
> > - Fixed ERR_PTR dereference in raw_event by only assigning ups->psu on
> >   successful registration
> >
> > - Fixed data race on ups->charge_limit using spin_lock_irqsave()
> > - Removed TIME_TO_EMPTY_NOW and TIME_TO_FULL_NOW properties to avoid
> > spurious shutdowns
> >
> > - Changed plugged-in but not charging state from FULL to NOT_CHARGING
> > - Used devm_kasprintf() for a unique sysfs name in order to support
> > multiple devices
> >
> > - Added POWER_SUPPLY and HIDRAW dependencies to Kconfig
> > - Used %pe for more human-readable error messages
> >
> > Changes in v2:
> > - Rebased on top of the current tree
> > - Moved vendor and device IDs to drivers/hid/hid-ids.h
> > - Added Kconfig entry under HID bus support -> Special HID drivers
> > - Added build rule to drivers/hid/Makefile
> >
> > Signed-off-by: Andrew Maney <andrewmaney05@gmail.com>
> > ---
> >  MAINTAINERS                           |   6 +
> >  drivers/hid/Kconfig                   |  10 +
> >  drivers/hid/Makefile                  |   1 +
> >  drivers/hid/hid-ids.h                 |   3 +
> >  drivers/hid/hid-lattepanda-iota-ups.c | 409 ++++++++++++++++++++++++++
> >  5 files changed, 429 insertions(+)
> >  create mode 100644 drivers/hid/hid-lattepanda-iota-ups.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 10e825318..d80721c2c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -11416,6 +11416,12 @@ F:   include/uapi/linux/hid*
> >  F:   samples/hid/
> >  F:   tools/testing/selftests/hid/
> >
> > +HID LATTEPANDA IOTA UPS DRIVER
> > +M:   Andrew Maney <andrewmaney05@gmail.com>
> > +L:   linux-input@vger.kernel.org
> > +S:   Maintained
> > +F:   drivers/hid/hid-lattepanda-iota-ups.c
> > +
> >  HID LOGITECH DRIVERS
> >  R:   Filipe La=C3=ADns <lains@riseup.net>
> >  L:   linux-input@vger.kernel.org
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index ff2f580b6..21ffc2fd0 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -510,6 +510,16 @@ config HID_KYSONA
> >       Say Y here if you have a Kysona M600 mouse
> >       and want to be able to read its battery capacity.
> >
> > +config HID_LATTEPANDA_IOTA_UPS
> > +     tristate "LattePanda IOTA UPS"
> > +     depends on USB_HID && USB_HIDDEV && X86 && POWER_SUPPLY
> > +     help
> > +     Support for the LattePanda IOTA UPS (DFRobot, VID 0x2341 PID 0x80=
36).
> > +     Exposes the battery status and capacity via the power_supply inte=
rface.
> > +
> > +     To compile as a module, choose M here: the module will be
> > +     called hid-lattepanda-iota-ups.
> > +
> >  config HID_UCLOGIC
> >       tristate "UC-Logic"
> >       depends on USB_HID
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index 0597fd6a4..d7ad3fc8f 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -74,6 +74,7 @@ obj-$(CONFIG_HID_KENSINGTON)        +=3D hid-kensingt=
on.o
> >  obj-$(CONFIG_HID_KEYTOUCH)   +=3D hid-keytouch.o
> >  obj-$(CONFIG_HID_KYE)                +=3D hid-kye.o
> >  obj-$(CONFIG_HID_KYSONA)     +=3D hid-kysona.o
> > +obj-$(CONFIG_HID_LATTEPANDA_IOTA_UPS)        +=3D hid-lattepanda-iota-=
ups.o
> >  obj-$(CONFIG_HID_LCPOWER)    +=3D hid-lcpower.o
> >  obj-$(CONFIG_HID_LENOVO)     +=3D hid-lenovo.o
> >  obj-$(CONFIG_HID_LENOVO_GO)  +=3D hid-lenovo-go.o
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 4657d96fb..6ded2c943 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -859,6 +859,9 @@
> >  #define USB_DEVICE_ID_LD_HYBRID              0x2090
> >  #define USB_DEVICE_ID_LD_HEATCONTROL 0x20A0
> >
> > +#define USB_VENDOR_ID_LATTEPANDA_IOTA        0x2341
> > +#define USB_DEVICE_ID_LATTEPANDA_IOTA_UPS    0x8036
> > +
> >  #define USB_VENDOR_ID_LENOVO         0x17ef
> >  #define USB_DEVICE_ID_LENOVO_TPKBD   0x6009
> >  #define USB_DEVICE_ID_LENOVO_CUSBKBD 0x6047
> > diff --git a/drivers/hid/hid-lattepanda-iota-ups.c b/drivers/hid/hid-la=
ttepanda-iota-ups.c
> > new file mode 100644
> > index 000000000..f5d522695
> > --- /dev/null
> > +++ b/drivers/hid/hid-lattepanda-iota-ups.c
> > @@ -0,0 +1,409 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <linux/power_supply.h>
> > +#include <linux/completion.h>
> > +#include <linux/workqueue.h>
> > +#include <linux/module.h>
> > +#include <linux/spinlock.h>
> > +#include <linux/hid.h>
> > +#include <linux/usb.h>
> > +#include "hid-ids.h"
> > +
> > +#define REPORT_ID_CAPACITY   0x0C
> > +#define REPORT_ID_STATUS     0x07
> > +
> > +#define STATUS_DISCHARGING   BIT(1)
> > +#define STATUS_PLUGGED_IN    BIT(0)
> > +#define STATUS_CHARGING              BIT(2)
> > +
> > +MODULE_AUTHOR("Andrew Maney");
> > +MODULE_DESCRIPTION("LattePanda IOTA UPS power supply driver");
> > +MODULE_LICENSE("GPL");
> > +
> > +struct iota_ups {
> > +     struct power_supply_desc psu_desc;
> > +     struct power_supply *psu;
> > +     struct hid_device *hiddev;
> > +     spinlock_t lock; /* Protects cached HID report values */
> > +
> > +     /* Cached values that are updated from HID reports */
> > +     bool plugged_in;
> > +     char serial[64];
> > +     int charge_limit;
> > +     int psu_status;
> > +     int capacity;
> > +
> > +     /*
> > +      * Wait for both status and capacity reports before registering
> > +      * with the power_supply core, so initial values are correct and
> > +      * not erroneous.
> > +      */
> > +     struct completion got_initial_data;
> > +     struct work_struct register_work;
> > +     bool got_capacity;
> > +     bool data_ready;
> > +     bool got_status;
> > +};
> > +
> > +static enum power_supply_property iota_ups_properties[] =3D {
> > +     POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> > +     POWER_SUPPLY_PROP_SERIAL_NUMBER,
> > +     POWER_SUPPLY_PROP_MANUFACTURER,
> > +     POWER_SUPPLY_PROP_MODEL_NAME,
> > +     POWER_SUPPLY_PROP_TECHNOLOGY,
> > +     POWER_SUPPLY_PROP_CAPACITY,
> > +     POWER_SUPPLY_PROP_PRESENT,
> > +     POWER_SUPPLY_PROP_ONLINE,
> > +     POWER_SUPPLY_PROP_STATUS,
> > +     POWER_SUPPLY_PROP_SCOPE,
> > +};
> > +
> > +static const struct hid_device_id iota_ups_devices[] =3D {
> > +     { HID_USB_DEVICE(USB_VENDOR_ID_LATTEPANDA_IOTA,
> > +             USB_DEVICE_ID_LATTEPANDA_IOTA_UPS) },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(hid, iota_ups_devices);
> > +
> > +static int iota_ups_get_property(struct power_supply *supply,
> > +                              enum power_supply_property psp,
> > +                              union power_supply_propval *val)
> > +{
> > +     struct iota_ups *ups =3D power_supply_get_drvdata(supply);
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&ups->lock, flags);
> > +
> > +     switch (psp) {
> > +     case POWER_SUPPLY_PROP_STATUS:
> > +             val->intval =3D ups->psu_status;
> > +             break;
> > +
> > +     /* Remaining capacity as a percentage from 0 to 100 */
> > +     case POWER_SUPPLY_PROP_CAPACITY:
> > +             val->intval =3D ups->capacity;
> > +             break;
> > +
> > +     /* The UPS is always present if the driver is loaded */
> > +     case POWER_SUPPLY_PROP_PRESENT:
> > +             val->intval =3D 1;
> > +             break;
> > +
> > +     /* Whether mains power is connected */
> > +     case POWER_SUPPLY_PROP_ONLINE:
> > +             val->intval =3D ups->plugged_in ? 1 : 0;
> > +             break;
> > +
> > +     /*
> > +      * The UPS board supplies power to the IOTA and any
> > +      * peripherals connected to it, therefore its scope
> > +      * is system-wide.
> > +      */
> > +     case POWER_SUPPLY_PROP_SCOPE:
> > +             val->intval =3D POWER_SUPPLY_SCOPE_SYSTEM;
> > +             break;
> > +
> > +     /* V1.0 only accepts 18650 Li-ion cells */
> > +     case POWER_SUPPLY_PROP_TECHNOLOGY:
> > +             val->intval =3D POWER_SUPPLY_TECHNOLOGY_LION;
> > +             break;
> > +
> > +     /* 80% or 100%, configured via a DIP switch on the UPS board */
> > +     case POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD:
> > +             val->intval =3D ups->charge_limit;
> > +             break;
> > +
> > +     case POWER_SUPPLY_PROP_MANUFACTURER:
> > +             val->strval =3D "DFRobot";
> > +             break;
> > +
> > +     case POWER_SUPPLY_PROP_MODEL_NAME:
> > +             val->strval =3D "LattePanda IOTA UPS";
> > +             break;
> > +
> > +     /* Retrieved from the USB descriptor */
> > +     case POWER_SUPPLY_PROP_SERIAL_NUMBER:
> > +             val->strval =3D ups->serial;
> > +             break;
> > +
> > +     default:
> > +             spin_unlock_irqrestore(&ups->lock, flags);
> > +             return -EINVAL;
> > +     }
> > +
> > +     spin_unlock_irqrestore(&ups->lock, flags);
> > +     return 0;
> > +}
> > +
> > +static int iota_ups_set_property(struct power_supply *supply,
> > +                              enum power_supply_property psp,
> > +                              const union power_supply_propval *val)
> > +{
> > +     struct iota_ups *ups =3D power_supply_get_drvdata(supply);
> > +
> > +     if (psp =3D=3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD) {
> > +             unsigned long flags;
> > +
> > +             /*
> > +              * V1.0 supports 80% and 100% charge limits only, which i=
s
> > +              * set via a DIP switch on the board. This property allow=
s
> > +              * userspace to inform the driver which limit is configur=
ed.
> > +              */
> > +             if (val->intval !=3D 80 && val->intval !=3D 100)
> > +                     return -EINVAL;
> > +
> > +             spin_lock_irqsave(&ups->lock, flags);
> > +             ups->charge_limit =3D val->intval;
> > +             spin_unlock_irqrestore(&ups->lock, flags);
> > +             return 0;
> > +     }
> > +
> > +     return -EINVAL;
> > +}
> > +
> > +static int iota_ups_property_is_writable(struct power_supply *supply,
> > +                                      enum power_supply_property psp)
> > +{
> > +     return psp =3D=3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD;
> > +}
> > +
> > +static int iota_ups_raw_event(struct hid_device *hdev,
> > +                           struct hid_report *report,
> > +                           u8 *data, int size)
> > +{
> > +     struct iota_ups *ups =3D hid_get_drvdata(hdev);
> > +     unsigned long flags;
> > +     bool changed =3D false;
> > +
> > +     /* All of the UPS's reports are at least 2 bytes */
> > +     if (size < 2)
> > +             return 0;
> > +
> > +     spin_lock_irqsave(&ups->lock, flags);
> > +
> > +     switch (data[0]) {
> > +     case REPORT_ID_STATUS: {
> > +             u8 status =3D data[1];
> > +             int new_status;
> > +             bool plugged_in =3D !!(status & STATUS_PLUGGED_IN);
> > +
> > +             /*
> > +              * The UPS status is determined as follows:
> > +              * Battery full:
> > +              *      UPS is plugged in
> > +              *      Battery is at full capacity
> > +              *
> > +              * Battery charging:
> > +              *      UPS is plugged in
> > +              *      Battery is not at full capacity
> > +              *
> > +              * Battery discharging:
> > +              *      UPS is not plugged in
> > +              *
> > +              * Battery not charging:
> > +              *      UPS is plugged in
> > +              *      UPS has halted charging for some reason
> > +              *
> > +              * Unknown:
> > +              *      None of the above conditions are met
> > +              */
> > +             if (status & STATUS_CHARGING) {
> > +                     if (ups->capacity >=3D ups->charge_limit)
> > +                             new_status =3D POWER_SUPPLY_STATUS_FULL;
> > +                     else
> > +                             new_status =3D POWER_SUPPLY_STATUS_CHARGI=
NG;
> > +
> > +             } else if (status & STATUS_DISCHARGING) {
> > +                     new_status =3D POWER_SUPPLY_STATUS_DISCHARGING;
> > +
> > +             } else if (plugged_in) {
> > +                     new_status =3D POWER_SUPPLY_STATUS_NOT_CHARGING;
> > +
> > +             } else {
> > +                     new_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > +             }
> > +
> > +             if (new_status !=3D ups->psu_status ||
> > +                 plugged_in !=3D ups->plugged_in) {
> > +                     ups->plugged_in =3D plugged_in;
> > +                     ups->psu_status =3D new_status;
> > +                     changed =3D true;
> > +             }
> > +
> > +             ups->got_status =3D true;
> > +             break;
> > +     }
> > +
> > +     case REPORT_ID_CAPACITY: {
> > +             int new_cap =3D clamp((int)data[1], 0, 100);
> > +
> > +             if (new_cap !=3D ups->capacity) {
> > +                     ups->capacity =3D new_cap;
> > +                     changed =3D true;
> > +             }
> > +
> > +             ups->got_capacity =3D true;
> > +             break;
> > +     }
> > +     }
> > +
> > +     /*
> > +      * Signal that the UPS is ready to be registered because we have
> > +      * received both capacity and status reports.
> > +      */
> > +     if (!ups->data_ready && ups->got_status && ups->got_capacity) {
> > +             ups->data_ready =3D true;
> > +             complete(&ups->got_initial_data);
> > +     }
> > +
> > +     spin_unlock_irqrestore(&ups->lock, flags);
> > +
> > +     /*
> > +      * Notify the power_supply core outside the spinlock to avoid
> > +      * a deadlock; power_supply_changed() may call back into
> > +      * get_property() which acquires the same lock.
> > +      */
> > +     if (changed && ups->psu)
> > +             power_supply_changed(ups->psu);
> > +
> > +     return 0;
> > +}
> > +
> > +static void iota_ups_register_work(struct work_struct *work)
> > +{
> > +     struct iota_ups *ups =3D container_of(work, struct iota_ups, regi=
ster_work);
> > +     struct power_supply_config psu_config =3D {};
> > +     struct power_supply *psu;
> > +
> > +     /*
> > +      * Wait for both status and capacity reports before registering.
> > +      * The device sends reports every ~1 second, so 3 seconds is safe=
.
> > +      * We wait here in order to prevent registration in an unknown
> > +      * state, since this could cause emergency shutdowns or other
> > +      * undesired effects.
> > +      */
> > +     wait_for_completion_timeout(&ups->got_initial_data,
> > +                                 msecs_to_jiffies(3000));
> > +
> > +     /* Configure the UPS's power supply properties */
> > +     ups->psu_desc.name =3D devm_kasprintf(&ups->hiddev->dev, GFP_KERN=
EL,
> > +                                         "lattepanda-iota-ups.%s",
> > +                                         dev_name(&ups->hiddev->dev));
> > +
> > +     if (!ups->psu_desc.name) {
> > +             hid_err(ups->hiddev, "failed to allocate power supply nam=
e\n");
> > +             return;
> > +     }
> > +
> > +     ups->psu_desc.property_is_writeable =3D iota_ups_property_is_writ=
able;
> > +     ups->psu_desc.num_properties        =3D ARRAY_SIZE(iota_ups_prope=
rties);
> > +     ups->psu_desc.get_property          =3D iota_ups_get_property;
> > +     ups->psu_desc.set_property          =3D iota_ups_set_property;
> > +     ups->psu_desc.properties            =3D iota_ups_properties;
> > +     ups->psu_desc.type                  =3D POWER_SUPPLY_TYPE_BATTERY=
;
> > +     psu_config.drv_data                 =3D ups;
> > +
> > +     /* Register the UPS as a power_supply device */
> > +     psu =3D devm_power_supply_register(&ups->hiddev->dev, &ups->psu_d=
esc, &psu_config);
> > +     if (IS_ERR(psu)) {
> > +             hid_err(ups->hiddev, "power supply registration failed: %=
pe\n", psu);
> > +             return;
> > +     }
> > +
> > +     /*
> > +      * Finally, notify the power_supply core so userspace reads the c=
orrect
> > +      * initial state immediately after registration.
> > +      */
> > +     ups->psu =3D psu;
> > +     power_supply_changed(ups->psu);
> > +     hid_info(ups->hiddev, "LattePanda IOTA UPS registered as a power_=
supply device\n");
> > +}
> > +
> > +static int iota_ups_probe(struct hid_device *hdev,
> > +                       const struct hid_device_id *id)
> > +{
> > +     struct iota_ups *ups;
> > +     int ret;
> > +
> > +     ups =3D devm_kzalloc(&hdev->dev, sizeof(*ups), GFP_KERNEL);
> > +     if (!ups)
> > +             return -ENOMEM;
> > +
> > +     ups->hiddev =3D hdev;
> > +     ups->psu_status =3D POWER_SUPPLY_STATUS_UNKNOWN;
> > +
> > +     /* 50% is a safe default if wait_for_completion_timeout() times o=
ut. */
> > +     ups->capacity =3D 50;
> > +
> > +     /*
> > +      * Default to 100% to prevent unexpected shutdowns.
> > +      * Userspace can update this via charge_control_end_threshold.
> > +      */
> > +     ups->charge_limit =3D 100;
> > +
> > +     init_completion(&ups->got_initial_data);
> > +     spin_lock_init(&ups->lock);
> > +     hid_set_drvdata(hdev, ups);
> > +
> > +     /*
> > +      * Retrieve the UPS's serial number from the USB descriptor. If t=
he device is not
> > +      * a USB device, we can use the unique device identifier as the s=
erial number.
> > +      */
> > +     if (hid_is_usb(hdev)) {
> > +             struct usb_device *udev =3D to_usb_device(hdev->dev.paren=
t->parent);
> > +
> > +             if (udev->serial)
> > +                     strscpy(ups->serial, udev->serial, sizeof(ups->se=
rial));
> > +             else
> > +                     strscpy(ups->serial, "Unknown", sizeof(ups->seria=
l));
> > +     } else {
> > +             if (*hdev->uniq)
> > +                     strscpy(ups->serial, hdev->uniq, sizeof(ups->seri=
al));
> > +             else
> > +                     strscpy(ups->serial, "Unknown", sizeof(ups->seria=
l));
> > +     }
> > +
> > +     ret =3D hid_parse(hdev);
> > +     if (ret) {
> > +             hid_err(hdev, "HID parse failed: %pe\n", ERR_PTR(ret));
> > +             return ret;
> > +     }
> > +
> > +     ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> > +     if (ret) {
> > +             hid_err(hdev, "HID hw start failed: %pe\n", ERR_PTR(ret))=
;
> > +             return ret;
> > +     }
> > +
> > +     ret =3D hid_hw_open(hdev);
> > +     if (ret) {
> > +             hid_err(hdev, "HID hw open failed: %pe\n", ERR_PTR(ret));
> > +             goto err_stop;
> > +     }
> > +
> > +     /* Probe for the UPS in a worker queue so we don't halt the enume=
ration thread */
> > +     INIT_WORK(&ups->register_work, iota_ups_register_work);
> > +     schedule_work(&ups->register_work);
> > +     return 0;
> > +
> > +err_stop:
> > +     hid_hw_stop(hdev);
> > +     return ret;
> > +}
> > +
> > +static void iota_ups_remove(struct hid_device *hdev)
> > +{
> > +     struct iota_ups *ups =3D hid_get_drvdata(hdev);
> > +
> > +     cancel_work_sync(&ups->register_work);
> > +     hid_hw_close(hdev);
> > +     hid_hw_stop(hdev);
> > +}
> > +
> > +static struct hid_driver iota_ups_driver =3D {
> > +     .name =3D "lattepanda-iota-ups",
> > +     .id_table =3D iota_ups_devices,
> > +     .probe =3D iota_ups_probe,
> > +     .remove =3D iota_ups_remove,
> > +     .raw_event =3D iota_ups_raw_event,
> > +};
> > +module_hid_driver(iota_ups_driver);
> > --
> > 2.54.0
> >
> >
