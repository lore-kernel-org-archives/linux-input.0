Received: from relay15.grserver.gr (relay15.grserver.gr [46.62.234.254])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A373955EA
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 22:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.62.234.254
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787610679; cv=none; b=Y9qAs+YYE6EWqisVnd0yZ/qbUS20jDcGvTiL5cF5Ni0dwMCbPpQquDslXNeVAqbopoUpF9qHeH5dTJiLn9J6ZdrG+YduKIMPgsc79hYNKQs/cLYwz7rma43yGt7JQcrSOFRVqzPH+Rhe2K56CHkBF7CQhVhfh21BQOyv8vS4818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787610679; c=relaxed/simple;
	bh=0fekVFLbz51hAP0OGK4JxCZMEB656CtVYdU9ROIDfaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k2cl0SIQXIN3HZjbDzsXyqtL2eAKpQ0woZcPoFn9b3STCexsmUhuUrvMxWIUsW5pHtvHyueTbeJO/il9uT14Zz9cdeDsEKwQy/cpgJf0/eDYxkb1j1qJ0GeWWnH/5C1pCSbozFIz05NTybEOqUDIZRAAxLXb51eMfbucyQEsZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=BjLmzApV; arc=none smtp.client-ip=46.62.234.254
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="BjLmzApV"
Received: from relay15 (localhost [127.0.0.1])
	by relay15.grserver.gr (Proxmox) with ESMTP id CE1433EB61
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 22:25:19 +0000 (UTC)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay15.grserver.gr (Proxmox) with ESMTPS id 2C20B3EB54
	for <linux-input@vger.kernel.org>; Mon, 24 Aug 2026 22:25:18 +0000 (UTC)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 416ED1FFD94
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 01:25:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1787610317;
	bh=J6kQlrj3XSk4a+dVWpO524PgiJ+4qccttwTkW/5mHGQ=;
	h=Received:From:Subject:To;
	b=BjLmzApV0I9sn7o9Q2ppCaGqW8OOf8AELProZxjzOsn5BE8y3pYEhNLbGRVdJQx+m
	 kOcPtVqvcb95lrS8CIMiFBAjMeViUZR7753j1QxjS0i2LVGiHGDt7Ij14NxU8+JOUx
	 7tpEg8gruCrmHLAVimy8HP36rjeFV6EmHIJj3HUcoGxSsnc7drG3RkN06HW7shCYFs
	 lvHOR2d8jGSOitpGT+hBB6UZ4jqhEZ/bzwptEDnR1Zr/yyidxCeDS4gRmF8UoqpHUn
	 JcEqzwEhiE+RQKkfY0T3QAkn8b1PYCxWDwrBnnddktMXAcmgd3UnfNo/2pe3USiZMh
	 olSam+RowCnmw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.214.180) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pl1-f180.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cee9b74ee1so32446205ad.3
        for <linux-input@vger.kernel.org>;
 Mon, 24 Aug 2026 15:25:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AHgh+RrUle9t+E1/39vfJ7UKfOf6OX8abLY+BkhMc2V8ILkbRX/1UXEnDUInUIsDsnX/BBmbnvCG7KdFutyUyg==@vger.kernel.org
X-Gm-Message-State: AFuF++lTf3a3i8axwTSkh23mz2yTSGAYa4wcbcnO0VM1s0r//WgXm2i9
	3cuhZbF/kNYMOovLWU0AJSyc7my/4i7VDQm2XpD2scOyuIBMF3gEvFJQWQEjjmQJrMkjZwzCpfB
	B5Sr9lW4N0BN7jFegLW/g16+lyPlHxSI=
X-Received: by 2002:a17:903:230b:b0:2c9:c991:3bf0 with SMTP id
 d9443c01a7336-2d670c27184mr363636415ad.8.1787610315860; Mon, 24 Aug 2026
 15:25:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824215041.79892-1-hello@matias.me>
 <CAGwozwEFLc4vGX290Tw4RdbtD7af4C9F-Ms20E_KUorL_j-jpQ@mail.gmail.com>
In-Reply-To: 
 <CAGwozwEFLc4vGX290Tw4RdbtD7af4C9F-Ms20E_KUorL_j-jpQ@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 25 Aug 2026 00:25:04 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwECcyX6vxJmiBhfO2DfOE6VbkURCArY6gvaqgXJEkA8BQ@mail.gmail.com>
X-Gm-Features: AcwNN1WYyaJDfjzSlcjKY3DAoog73bdLobAUixB4m1q_pwTc8-BwjVE-KHbd2X0
Message-ID: 
 <CAGwozwECcyX6vxJmiBhfO2DfOE6VbkURCArY6gvaqgXJEkA8BQ@mail.gmail.com>
Subject: Re: [PATCH] HID: ayaneo: Add AYANEO 3 detachable controller driver
To: =?UTF-8?Q?Mati=CC=81as_Marti=CC=81nez?= <hello@matias.me>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, Denis Benato <denis.benato@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-PPP-Message-ID: 
 <178761031761.3939811.17170036309037647703@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.6 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 25 Aug 2026 at 00:00, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> On Mon, 24 Aug 2026 at 23:50, Mati=CC=81as Marti=CC=81nez <hello@matias.m=
e> wrote:
> >
> > The AYANEO 3 handheld has a detachable controller with swappable
> > modules ("Magic Modules"). The controller exposes three USB HID
> > interfaces behind 1c4f:0002 (a generic SigmaMicro VID/PID, hence the
> > DMI gate): a gamepad, a keyboard for the extra buttons, and a vendor
> > interface accepting 65-byte commands.
> >
> > Add a driver for the vendor interface providing module identification
> > (module_left/module_right sysfs attributes), software eject of the
> > modules (eject sysfs attribute, blocking until the firmware confirms
> > the release handshake), and RGB control of the joystick rings as a
> > multicolor LED class device ("<device name>:rgb:joystick_rings";
> > userspace such as InputPlumber matches the function suffix).
> >
> > This complements the ayaneo-ec platform driver, which exposes module
> > attach state and controller power. A full physical eject is performed
> > by writing to eject and then cutting power through ayaneo-ec's
> > controller_power attribute; that orchestration is deliberately left
> > to userspace.
>
> If you need userspace coordination anyway, including the multiple
> timing hacks I had to implement, the question of having to route this
> through the kernel arises.
>
> > The protocol was reverse engineered in the Handheld Daemon project by
> > Antheas Kapenekakis. Tested on an AYANEO 3: module identification,
> > RGB, and a full eject/reinsert/repower cycle.
> >
> > Signed-off-by: Mati=CC=81as Marti=CC=81nez <hello@matias.me>
> > Reviewed-by: Denis Benato <denis.benato@linux.dev>
> > ---
> >  .../ABI/testing/sysfs-driver-hid-ayaneo       |  36 ++
> >  MAINTAINERS                                   |   7 +
> >  drivers/hid/Kconfig                           |  14 +
> >  drivers/hid/Makefile                          |   1 +
> >  drivers/hid/hid-ayaneo.c                      | 471 ++++++++++++++++++
> >  5 files changed, 529 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-ayaneo
> >  create mode 100644 drivers/hid/hid-ayaneo.c
> >
> > diff --git a/Documentation/ABI/testing/sysfs-driver-hid-ayaneo b/Docume=
ntation/ABI/testing/sysfs-driver-hid-ayaneo
> > new file mode 100644
> > index 000000000..807c4fc9d
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-hid-ayaneo
> > @@ -0,0 +1,36 @@
> > +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/module_left
> > +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/module_right
> > +Date:          August 2026
> > +KernelVersion: 7.3
> > +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> > +Description:
> > +               Reports the type of the module currently inserted in th=
e
> > +               left/right slot of the AYANEO 3 detachable controller, =
as
> > +               the raw identifier reported by the controller firmware =
in
> > +               hexadecimal (e.g. "0x04"). Bits 0-5 encode the module
> > +               type, bit 6 indicates the module is inserted rotated.
> > +
> > +               Reading these attributes queries the controller and can
> > +               take up to a second.
> > +
> > +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/eject
> > +Date:          August 2026
> > +KernelVersion: 7.3
> > +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> > +Description:
> > +               Write-only. Writing "left", "right" or "both" asks the
> > +               controller firmware to release the corresponding
> > +               module(s). The write blocks until the firmware confirms
> > +               the release handshake (typically a few seconds). The
> > +               module is physically released once controller power is
> > +               subsequently cut through the ayaneo-ec platform driver'=
s
> > +               controller_power attribute; that final step is left to
> > +               userspace.
> > +
> > +What:          /sys/bus/hid/drivers/hid-ayaneo/<dev>/reset
> > +Date:          August 2026
> > +KernelVersion: 7.3
> > +Contact:       Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> > +Description:
> > +               Write-only. Writing "1" asks the controller firmware to
> > +               perform a quick reset of the controller configuration.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6ecfe6c9e..360f01d39 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4469,6 +4469,13 @@ F:       Documentation/devicetree/bindings/spi/a=
xiado,ax3000-spi.yaml
> >  F:     drivers/spi/spi-axiado.c
> >  F:     drivers/spi/spi-axiado.h
> >
> > +AYANEO 3 CONTROLLER HID DRIVER
> > +M:     Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> > +L:     linux-input@vger.kernel.org
> > +S:     Maintained
> > +F:     Documentation/ABI/testing/sysfs-driver-hid-ayaneo
> > +F:     drivers/hid/hid-ayaneo.c
> > +
> >  AYANEO PLATFORM EC DRIVER
> >  M:     Antheas Kapenekakis <lkml@antheas.dev>
> >  L:     platform-driver-x86@vger.kernel.org
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > index aa7fa11a0..9693a0233 100644
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -205,6 +205,20 @@ config HID_AUREAL
> >         help
> >         Support for Aureal Cy se W-01RN Remote Controller and other Aur=
eal derived remotes.
> >
> > +config HID_AYANEO
> > +       tristate "AYANEO 3 detachable controller support"
> > +       depends on USB_HID
> > +       depends on DMI
> > +       depends on LEDS_CLASS_MULTICOLOR
> > +       help
> > +         Provides support for the detachable controller ("Magic Module=
s")
> > +         of the AYANEO 3 handheld: module identification, software eje=
ct
> > +         and RGB control of the joystick rings. Complements the ayaneo=
-ec
> > +         platform driver, which handles module attach state and contro=
ller
> > +         power.
> > +
> > +         Say Y or M here if you have an AYANEO 3.
> > +
> >  config HID_BELKIN
> >         tristate "Belkin Flip KVM and Wireless keyboard"
> >         help
> > diff --git a/drivers/hid/Makefile b/drivers/hid/Makefile
> > index 48a863b24..60add9348 100644
> > --- a/drivers/hid/Makefile
> > +++ b/drivers/hid/Makefile
> > @@ -35,6 +35,7 @@ obj-$(CONFIG_HID_APPLETB_KBD) +=3D hid-appletb-kbd.o
> >  obj-$(CONFIG_HID_CREATIVE_SB0540)      +=3D hid-creative-sb0540.o
> >  obj-$(CONFIG_HID_ASUS)         +=3D hid-asus.o
> >  obj-$(CONFIG_HID_AUREAL)       +=3D hid-aureal.o
> > +obj-$(CONFIG_HID_AYANEO)       +=3D hid-ayaneo.o
> >  obj-$(CONFIG_HID_BELKIN)       +=3D hid-belkin.o
> >  obj-$(CONFIG_HID_BETOP_FF)     +=3D hid-betopff.o
> >  obj-$(CONFIG_HID_BIGBEN_FF)    +=3D hid-bigbenff.o
> > diff --git a/drivers/hid/hid-ayaneo.c b/drivers/hid/hid-ayaneo.c
> > new file mode 100644
> > index 000000000..61c64617f
> > --- /dev/null
> > +++ b/drivers/hid/hid-ayaneo.c
> > @@ -0,0 +1,471 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * HID driver for the AYANEO 3 detachable controller ("Magic Modules")=
.
> > + *
> > + * The AYANEO 3 controller exposes three USB HID interfaces behind
> > + * VID 0x1c4f PID 0x0002 (a generic SigmaMicro ID, hence the DMI gate)=
:
> > + * a gamepad, a keyboard for the extra buttons, and a vendor interface
> > + * (application usage 0xff000001) accepting 65-byte commands.
> > + *
> > + * This driver binds the vendor interface and provides:
> > + *  - module identification (which module type is inserted on each sid=
e)
> > + *  - software eject of the left/right modules
> > + *  - RGB control of the joystick rings as a multicolor LED class devi=
ce
> > + *
> > + * It complements the ayaneo-ec platform driver, which exposes module
> > + * attach state and controller power. A full eject is: write to this
> > + * driver's "eject" attribute, then power the controller off through
> > + * ayaneo-ec's controller_power once the eject completes.
> > + *
> > + * The protocol was reverse engineered in the Handheld Daemon project =
by
> > + * Antheas Kapenekakis.
> > + *
> > + * Command format (65 bytes, unnumbered report):
> > + *   [0]   report id (0)
> > + *   [1:3] little-endian sum of bytes 7..64
> > + *   [3]   command
> > + *   [4]   subcommand
> > + *   [5:]  payload
> > + * The device replies with a 64-byte report echoing the subcommand at
> > + * byte 3.
> > + *
> > + * Copyright (C) 2026 Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/dmi.h>
> > +#include <linux/hid.h>
> > +#include <linux/led-class-multicolor.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/sysfs.h>
> > +#include <linux/unaligned.h>
> > +
> > +#define AYA3_REPORT_SIZE       65
> > +#define AYA3_RESP_SIZE         64
> > +#define AYA3_CMD_TIMEOUT_MS    300
> > +#define AYA3_CMD_ATTEMPTS      3
> > +
> > +/* Subcommands (byte 4); byte 3 is 0x00 except for the config command =
*/
> > +#define AYA3_SUBCMD_CHECK      0x08
> > +#define AYA3_CMD_CONFIG                0x21
> > +#define AYA3_SUBCMD_CONFIG     0x09
> > +
> > +/* CHECK response fields */
> > +#define AYA3_RESP_CMD          3
> > +#define AYA3_RESP_EJECT_STATUS 19
> > +#define AYA3_RESP_MODULE_LEFT  32
> > +#define AYA3_RESP_MODULE_RIGHT 33
> > +/* Bits that stay set in the eject status byte after an eject complete=
s */
> > +#define AYA3_EJECT_DONE_MASK   0x11
> > +
> > +/* Config command eject/reset field */
> > +#define AYA3_EJECT_LEFT                0x07
> > +#define AYA3_EJECT_RIGHT       0x70
> > +#define AYA3_RESET             0x88
> > +
> > +/* Config command RGB modes */
> > +#define AYA3_RGB_SOLID         0x01
> > +#define AYA3_RGB_OFF           0xff
> > +
> > +#define AYA3_VIBRATION_DEFAULT 0x02    /* medium */
> > +
> > +struct aya3 {
> > +       struct hid_device *hdev;
> > +       /* DMA-safe command buffer; guarded by lock */
> > +       u8 *xfer;
> > +       /* Serializes commands and cached-config access */
> > +       struct mutex lock;
> > +       struct completion resp_done;
> > +       u8 resp[AYA3_RESP_SIZE];
> > +       u8 resp_expect;
> > +       bool resp_pending;
> > +
> > +       u8 rgb[3];
> > +       u8 vibration;
> > +
> > +       struct led_classdev_mc mcled;
> > +       struct mc_subled subleds[3];
> > +};
> > +
> > +static int aya3_send(struct aya3 *aya)
> > +{
> > +       int ret;
> > +
> > +       ret =3D hid_hw_output_report(aya->hdev, aya->xfer, AYA3_REPORT_=
SIZE);
> > +       if (ret =3D=3D -ENOSYS)
> > +               ret =3D hid_hw_raw_request(aya->hdev, aya->xfer[0], aya=
->xfer,
> > +                                        AYA3_REPORT_SIZE, HID_OUTPUT_R=
EPORT,
> > +                                        HID_REQ_SET_REPORT);
> > +       if (ret < 0)
> > +               return ret;
> > +       return 0;
> > +}
> > +
> > +/**
> > + * aya3_cmd() - send the command in aya->xfer and wait for the reply
> > + * @aya: driver data; @aya->xfer holds the fully built 65-byte command
> > + * @resp: destination for the AYA3_RESP_SIZE-byte reply, or NULL to
> > + *        discard it
> > + *
> > + * The device echoes the subcommand byte of the command it is answerin=
g,
> > + * which aya3_raw_event() uses to match replies. Unanswered commands a=
re
> > + * retried up to AYA3_CMD_ATTEMPTS times.
> > + *
> > + * Context: process context; the caller must hold @aya->lock, which
> > + *          protects @aya->xfer and the reply state.
> > + * Return: 0 on success, -ETIMEDOUT if every attempt went unanswered, =
or
> > + *         a negative errno if sending failed.
> > + */
> > +static int aya3_cmd(struct aya3 *aya, u8 *resp)
> > +{
> > +       int attempt, ret;
> > +
> > +       lockdep_assert_held(&aya->lock);
> > +
> > +       for (attempt =3D 0; attempt < AYA3_CMD_ATTEMPTS; attempt++) {
> > +               reinit_completion(&aya->resp_done);
> > +               aya->resp_expect =3D aya->xfer[4];
> > +               WRITE_ONCE(aya->resp_pending, true);
> > +
> > +               ret =3D aya3_send(aya);
> > +               if (ret) {
> > +                       WRITE_ONCE(aya->resp_pending, false);
> > +                       return ret;
> > +               }
> > +
> > +               if (wait_for_completion_timeout(&aya->resp_done,
> > +                                               msecs_to_jiffies(AYA3_C=
MD_TIMEOUT_MS))) {
> > +                       if (resp)
> > +                               memcpy(resp, aya->resp, AYA3_RESP_SIZE)=
;
> > +                       return 0;
> > +               }
> > +       }
> > +       WRITE_ONCE(aya->resp_pending, false);
> > +       return -ETIMEDOUT;
> > +}
> > +
> > +static void aya3_checksum(u8 *buf)
> > +{
> > +       u16 sum =3D 0;
> > +       int i;
> > +
> > +       for (i =3D 7; i < AYA3_REPORT_SIZE; i++)
> > +               sum +=3D buf[i];
> > +       put_unaligned_le16(sum, buf + 1);
> > +}
> > +
> > +static int aya3_check(struct aya3 *aya, u8 *resp)
> > +{
> > +       memset(aya->xfer, 0, AYA3_REPORT_SIZE);
> > +       aya->xfer[4] =3D AYA3_SUBCMD_CHECK;
> > +       return aya3_cmd(aya, resp);
> > +}
> > +
> > +/*
> > + * The config command sets everything at once: RGB for both rings,
> > + * vibration strength, joystick sensitivity, and the eject/reset field=
.
> > + */
> > +static int aya3_send_config(struct aya3 *aya, u8 eject)
> > +{
> > +       static const u8 template[AYA3_REPORT_SIZE] =3D {
> > +               [3] =3D AYA3_CMD_CONFIG,
> > +               [4] =3D AYA3_SUBCMD_CONFIG,
> > +               [22] =3D 0x33,
> > +               [23] =3D 0x22,    /* joystick sensitivity 100%/100% */
> > +               [32] =3D 0x01,
> > +               [37] =3D 0x64,
> > +               [38] =3D 0x64,
>
> Overwriting joystick sensitivity is a bit problematic. Can you see if
> dropping those four bytes still allows RGB to go through? This might
> be preferable. Otherwise you might have to implement those endpoints
> as well, and handle the issue of multiple writes (ie setting joystick
> left, right and RGB produces three writes instead of one).
>
> > +       };
> > +       u8 *buf =3D aya->xfer;
> > +       u8 mode =3D (aya->rgb[0] || aya->rgb[1] || aya->rgb[2]) ?
> > +                 AYA3_RGB_SOLID : AYA3_RGB_OFF;
>
> Consider implementing the pulsing mode it offers, there should be an
> accepted ABI for it somewhere...
>
> > +
> > +       memcpy(buf, template, AYA3_REPORT_SIZE);
> > +       /* Right ring, then left ring: mode, R, G, B */
> > +       buf[8] =3D mode;
> > +       memcpy(buf + 9, aya->rgb, 3);
> > +       buf[12] =3D mode;
> > +       memcpy(buf + 13, aya->rgb, 3);
> > +       buf[20] =3D eject;
> > +       buf[24] =3D aya->vibration << 4;
> > +       aya3_checksum(buf);
> > +
> > +       return aya3_cmd(aya, NULL);
> > +}
> > +
> > +static int aya3_raw_event(struct hid_device *hdev, struct hid_report *=
report,
> > +                         u8 *data, int size)
> > +{
> > +       struct aya3 *aya =3D hid_get_drvdata(hdev);
> > +
> > +       if (!READ_ONCE(aya->resp_pending) || size < AYA3_RESP_SIZE)
> > +               return 0;
> > +       if (data[AYA3_RESP_CMD] !=3D aya->resp_expect)
> > +               return 0;
> > +
> > +       memcpy(aya->resp, data, AYA3_RESP_SIZE);
> > +       WRITE_ONCE(aya->resp_pending, false);
> > +       complete(&aya->resp_done);
> > +       return 0;
> > +}
> > +
> > +static ssize_t aya3_module_show(struct device *dev, char *buf, int off=
set)
> > +{
> > +       struct aya3 *aya =3D dev_get_drvdata(dev);
> > +       u8 resp[AYA3_RESP_SIZE];
> > +       int ret;
> > +
> > +       ret =3D mutex_lock_interruptible(&aya->lock);
> > +       if (ret)
> > +               return ret;
> > +       ret =3D aya3_check(aya, resp);
> > +       mutex_unlock(&aya->lock);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return sysfs_emit(buf, "0x%02x\n", resp[offset]);
> > +}
> > +
> > +static ssize_t module_left_show(struct device *dev,
> > +                               struct device_attribute *attr, char *bu=
f)
> > +{
> > +       return aya3_module_show(dev, buf, AYA3_RESP_MODULE_LEFT);
> > +}
> > +static DEVICE_ATTR_RO(module_left);
> > +
> > +static ssize_t module_right_show(struct device *dev,
> > +                                struct device_attribute *attr, char *b=
uf)
> > +{
> > +       return aya3_module_show(dev, buf, AYA3_RESP_MODULE_RIGHT);
> > +}
> > +static DEVICE_ATTR_RO(module_right);
> > +
> > +static ssize_t eject_store(struct device *dev, struct device_attribute=
 *attr,
> > +                          const char *buf, size_t count)
> > +{
> > +       struct aya3 *aya =3D dev_get_drvdata(dev);
> > +       u8 resp[AYA3_RESP_SIZE];
> > +       u8 eject;
> > +       int ret, i;
> > +
> > +       if (sysfs_streq(buf, "left"))
> > +               eject =3D AYA3_EJECT_LEFT;
> > +       else if (sysfs_streq(buf, "right"))
> > +               eject =3D AYA3_EJECT_RIGHT;
> > +       else if (sysfs_streq(buf, "both"))
> > +               eject =3D AYA3_EJECT_LEFT | AYA3_EJECT_RIGHT;
> > +       else
> > +               return -EINVAL;
> > +
> > +       ret =3D mutex_lock_interruptible(&aya->lock);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D aya3_send_config(aya, eject);
> > +       if (ret)
> > +               goto out;
> > +
> > +       /*
> > +        * Wait for the firmware to report the eject as done. Userspace
> > +        * must then cut power through ayaneo-ec's controller_power for
> > +        * the module to be physically released.
> > +        */
> > +       ret =3D -ETIMEDOUT;
> > +       for (i =3D 0; i < 20; i++) {
> > +               msleep(400);

Almost forgot. Magic value.

> > +               if (aya3_check(aya, resp))
> > +                       continue;
> > +               if (!(resp[AYA3_RESP_EJECT_STATUS] & ~AYA3_EJECT_DONE_M=
ASK)) {
> > +                       ret =3D 0;
> > +                       break;
> > +               }
> > +       }
> > +out:
> > +       mutex_unlock(&aya->lock);
> > +       return ret ? ret : count;
> > +}
> > +static DEVICE_ATTR_WO(eject);
> > +
> > +static ssize_t reset_store(struct device *dev, struct device_attribute=
 *attr,
> > +                          const char *buf, size_t count)
> > +{
> > +       struct aya3 *aya =3D dev_get_drvdata(dev);
> > +       bool value;
> > +       int ret;
> > +
> > +       ret =3D kstrtobool(buf, &value);
> > +       if (ret)
> > +               return ret;
> > +       if (!value)
> > +               return count;
> > +
> > +       ret =3D mutex_lock_interruptible(&aya->lock);
> > +       if (ret)
> > +               return ret;
> > +       ret =3D aya3_send_config(aya, AYA3_RESET);
> > +       if (!ret) {
> > +               msleep(500);

Magic value. You need to justify those.

> > +               ret =3D aya3_send_config(aya, 0);
> > +       }
> > +       mutex_unlock(&aya->lock);
> > +       return ret ? ret : count;
> > +}
> > +static DEVICE_ATTR_WO(reset);
> > +
> > +static struct attribute *aya3_attrs[] =3D {
> > +       &dev_attr_module_left.attr,
> > +       &dev_attr_module_right.attr,
> > +       &dev_attr_eject.attr,
> > +       &dev_attr_reset.attr,
> > +       NULL
> > +};
> > +ATTRIBUTE_GROUPS(aya3);
> > +
> > +static int aya3_led_set(struct led_classdev *cdev, enum led_brightness=
 value)
> > +{
> > +       struct led_classdev_mc *mc =3D lcdev_to_mccdev(cdev);
> > +       struct aya3 *aya =3D container_of(mc, struct aya3, mcled);
> > +       int ret, i;
> > +
> > +       ret =3D mutex_lock_interruptible(&aya->lock);
> > +       if (ret)
> > +               return ret;
> > +
> > +       led_mc_calc_color_components(mc, value);
> > +       for (i =3D 0; i < 3; i++)
> > +               aya->rgb[i] =3D min_t(unsigned int, aya->subleds[i].bri=
ghtness, 255);
> > +
> > +       ret =3D aya3_send_config(aya, 0);
> > +       if (ret)
> > +               hid_err(aya->hdev, "failed to update RGB config: %d\n",=
 ret);
> > +       mutex_unlock(&aya->lock);
> > +       return ret;
> > +}
> > +
> > +static int aya3_register_led(struct aya3 *aya)
> > +{
> > +       struct led_classdev *cdev =3D &aya->mcled.led_cdev;
> > +
> > +       aya->subleds[0].color_index =3D LED_COLOR_ID_RED;
> > +       aya->subleds[1].color_index =3D LED_COLOR_ID_GREEN;
> > +       aya->subleds[2].color_index =3D LED_COLOR_ID_BLUE;
> > +       aya->mcled.subled_info =3D aya->subleds;
> > +       aya->mcled.num_colors =3D 3;
> > +
> > +       cdev->name =3D devm_kasprintf(&aya->hdev->dev, GFP_KERNEL,
> > +                                   "%s:rgb:joystick_rings",
> > +                                   dev_name(&aya->hdev->dev));
> > +       if (!cdev->name)
> > +               return -ENOMEM;
> > +       cdev->brightness =3D 0;
> > +       cdev->max_brightness =3D 255;
> > +       cdev->brightness_set_blocking =3D aya3_led_set;
> > +
> > +       return devm_led_classdev_multicolor_register(&aya->hdev->dev,
> > +                                                    &aya->mcled);
> > +}
>
> The ABI for the LEDs is ok, especially if you implement pulsing mode mode=
.
>
> Best,
> Antheas
>
> > +
> > +static const struct dmi_system_id aya3_dmi_table[] =3D {
> > +       {
> > +               .matches =3D {
> > +                       DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> > +                       DMI_MATCH(DMI_BOARD_NAME, "AYANEO 3"),
> > +               },
> > +       },
> > +       {}
> > +};
> > +
> > +static int aya3_probe(struct hid_device *hdev, const struct hid_device=
_id *id)
> > +{
> > +       struct aya3 *aya;
> > +       int ret;
> > +
> > +       /* The VID/PID is a generic SigmaMicro ID; bind on AYANEO 3 onl=
y */
> > +       if (!dmi_check_system(aya3_dmi_table))
> > +               return -ENODEV;
> > +
> > +       if (!hid_is_usb(hdev))
> > +               return -ENODEV;
> > +
> > +       ret =3D hid_parse(hdev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Bind only the vendor interface, not the gamepad/keyboard one=
s */
> > +       if (hdev->collection->usage !=3D (HID_UP_MSVENDOR | 0x0001))
> > +               return -ENODEV;
> > +
> > +       aya =3D devm_kzalloc(&hdev->dev, sizeof(*aya), GFP_KERNEL);
> > +       if (!aya)
> > +               return -ENOMEM;
> > +
> > +       aya->xfer =3D devm_kzalloc(&hdev->dev, AYA3_REPORT_SIZE, GFP_KE=
RNEL);
> > +       if (!aya->xfer)
> > +               return -ENOMEM;
> > +
> > +       aya->hdev =3D hdev;
> > +       aya->vibration =3D AYA3_VIBRATION_DEFAULT;
> > +       init_completion(&aya->resp_done);
> > +       ret =3D devm_mutex_init(&hdev->dev, &aya->lock);
> > +       if (ret)
> > +               return ret;
> > +       hid_set_drvdata(hdev, aya);
> > +
> > +       ret =3D hid_hw_start(hdev, HID_CONNECT_HIDRAW);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret =3D hid_hw_open(hdev);
> > +       if (ret)
> > +               goto err_stop;
> > +
> > +       /* Input reports are not delivered during probe by default */
> > +       hid_device_io_start(hdev);
> > +
> > +       scoped_guard(mutex, &aya->lock)
> > +               ret =3D aya3_check(aya, NULL);
> > +       if (ret)
> > +               hid_warn(hdev, "controller did not answer status check:=
 %d\n",
> > +                        ret);
> > +
> > +       ret =3D aya3_register_led(aya);
> > +       if (ret)
> > +               goto err_close;
> > +
> > +       return 0;
> > +
> > +err_close:
> > +       hid_hw_close(hdev);
> > +err_stop:
> > +       hid_hw_stop(hdev);
> > +       return ret;
> > +}
> > +
> > +static void aya3_remove(struct hid_device *hdev)
> > +{
> > +       hid_hw_close(hdev);
> > +       hid_hw_stop(hdev);
> > +}
> > +
> > +static const struct hid_device_id aya3_devices[] =3D {
> > +       { HID_USB_DEVICE(0x1c4f, 0x0002) },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(hid, aya3_devices);
> > +
> > +static struct hid_driver aya3_driver =3D {
> > +       .name =3D "hid-ayaneo",
> > +       .id_table =3D aya3_devices,
> > +       .probe =3D aya3_probe,
> > +       .remove =3D aya3_remove,
> > +       .raw_event =3D aya3_raw_event,
> > +       .driver =3D {
> > +               .dev_groups =3D aya3_groups,
> > +       },
> > +};
> > +module_hid_driver(aya3_driver);
> > +
> > +MODULE_AUTHOR("Mat=C3=ADas Mart=C3=ADnez <hello@matias.me>");
> > +MODULE_DESCRIPTION("AYANEO 3 detachable controller driver");
> > +MODULE_LICENSE("GPL");
> >
> > base-commit: a8fcb3dbf9024da44f1614c42ea16001f4b860b0
> > --
> > 2.54.0 (Apple Git-157)
> >
> >

