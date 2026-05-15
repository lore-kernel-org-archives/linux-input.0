Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CC1E5724
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 00:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778804702; cv=pass; b=j7Yg6D2Z0RD1NCUgX2yMsAtN7tpE64jYpMy7cgkEWWinmlhokx1vWZCrup2VzfvrhXkoRCNTBKdlu4P8sMUFEiEFWFjALiIdbMK9jloZtyTsaeWuK9S/Fmlkq3joh8QurlEf0lS3+yteNmf5mMcM3rPQ2vufCG7HpUdRlpfb3cw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778804702; c=relaxed/simple;
	bh=K871+pGIP1NzejKUiG1MEO4ti/+MsA2yb4IZUH/K96w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjMO/toAtN8fOJgya+ixB4qxlEvrDMo//YBrIed/CF9r2HUhPWn9p9rXX3obN/RRCE7O3mX25cwUDY24YrIF/+NOdaN5AaDIfg6VRvibyZyUaw21vs/ZalJAJsEkjXe3ilAklARCWCunS7U8YdQ/3c5STJ0gyjA/KV/1XGpvKxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAvsmH1m; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAvsmH1m"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8b3d6b215cfso127999186d6.3
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 17:25:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778804700; cv=none;
        d=google.com; s=arc-20240605;
        b=cCCFryJ4dVKV70Q5vcy7H7XyS9Pld7INeywFBt9Hl4lEUvoFOWj8uiUAcPuPpqL9x9
         4vfEB/h6yP96o7spwMe9EhmS1G43T0xefa0uzKW/aR3K9K+9nrL6wg0l93c+i9CVFKTX
         oFcyrg7Ea5HPHWg04bzHcz14h8voq4KV0WPUlEuFtpO6o3pWWO2RwnlsaJTLP0koaHTQ
         0E49nDVhdrU7Qtka26WaD4ycFbKgSymlcc2VrMkn3ceWixXl7QUZgcFFjEfO1KZklAt0
         YhfR25fxHjf6BlTQ5a8cIVztX2qetaqs1GSu95sSbgHTmkyr52ZRqdRX25EQhs7e+Mh2
         6eng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t3/9zsBGRo1OaAkS5aFHkNdTHJVrH4TRyw2nmNFqF2k=;
        fh=yP9nXh3uEx2Oi4EohrO5J9pTgsj4qmV+0fif0Msznug=;
        b=hlWFp0Kslt2O2dqj9/4yVWJocAFj+G16oRZhiy2UBm6cdtSqUdjRX4JgLhMMeuzCG+
         gKDj2ttCAvwsKqlp0W59C6treBzkHfZn0lxiUiwvp+CfunNoOxEXa3EzkawSEawd6P1Y
         qOf5sdDDp3FwX9FYhRqhUHFbukk7iwAp2rFJWt+Po2BWK1Tha0b9k1AGBgVo3mJq22F9
         fyL80EScUsBAYCCcJYmsxIFh4LrdIhfQTSaU/Lu99LDWlYcu+bsOcg9nY0jH7bLX4G0o
         3dykTYMP6HpJW0xwDjhFlZIyaldYBd9R1LdUrmmELMN9xbfgizAKZ+kkuignQ00yG1tC
         eIcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778804700; x=1779409500; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t3/9zsBGRo1OaAkS5aFHkNdTHJVrH4TRyw2nmNFqF2k=;
        b=JAvsmH1mfjLRIIRiydBS0MRdBvy9M4KTCY1/uRiuhu5CVz76U2k+4/1T/lM+sXK8HL
         FXQ4yWvLttU9weLP/tHmmj0yLuqZi7w+xedG2wgAmfiF1QkPMoEiTUEYPIduj9bdLysx
         xiWAf2l1c4TsUW/pmms2THkICFWeLqP6eHixwDdRJxg+xrmMmawQ2v5GObGqEdijCqUt
         nFfJlKXyGugK8PqQcZR4d9NvqHGg4DbDsYPEIaAbJ0Caf4Mx8JXs0n3FbiDMVn/IgQXo
         +2EbG/VpCQaVcnhJfecjXT2GlwLtdP3PaJNULk4ncE6iY4s8KpqmKvPW5e7mopnoDh4s
         bImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778804700; x=1779409500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3/9zsBGRo1OaAkS5aFHkNdTHJVrH4TRyw2nmNFqF2k=;
        b=ee0p0FZMMZLzlylh038G98XSVnWjOROKRkyQfxMm6zmKK9lTxFkXMqEU44LkzJ/Gzy
         2tgMZIU6I5tbUytj1CzlmR+JmEUimnosyYivRTFi4/Eoin4GK9WMxyVZyaXbWC80ofct
         Z+LlUsFYsP3Zs44ZR2l9rNkU7ZOgGdRL0bF6zNuAlQOyQGxTXJO5jad/HtrScxF8QMBw
         8aXes9Czp6bFEiUEvniomPOqalRZ0v4DBxwoOpEz4P9uPWJxMn4sQiqvScvXzWggm01N
         MFfjFsRVWqdEM/yRfsaEnC1mlwQhAtD8yLl3ItbEYbCh0WVb6evK52icTXuh2qfe7emd
         1FiA==
X-Gm-Message-State: AOJu0Yzpakm0+61nYBxfWURvuPZC3b+kU7rGPx9D1anHVCi1Vu0upglY
	llVaYKuesnjDo3WbEpSBh7wddeAcm/9iTDRWmO8iTKpVQs1r1Vonue+B/VPH1PuPyrgq3fjuD6W
	nQxLEj03N2m7KWHDCvxmM6/S3JW2XY8TM3D0U
X-Gm-Gg: Acq92OHrCtsJKDrHR2NadsEsiIL9N8ceX7mlCmAGZniCyX4Peaov0u7wV8NenTCLZNg
	2JrzgiDmYiZLy6wEGHSv+kAYcHBVfpi/OPQFnTjRUpK+A4mYvprWcjvhDLoXOz+sCfdAi/6sY/x
	xBzb+rSbMmMQFZd/1io+QvR5Os+Rt2a5mNGHlpYX31CZoInSpxAFSrt+8zmVQxLH+ONcmxdBcmI
	cEyCLxtTHKX64bph32wQfW26onapYBOQtOfBURfms+7u/x52P5xFAzHk95jO+JHjo1K84lS6wve
	6ndfDtad/5bMUWY8
X-Received: by 2002:a05:6214:3f86:b0:8ca:164c:a851 with SMTP id
 6a1803df08f44-8ca164cab11mr3792766d6.41.1778804699859; Thu, 14 May 2026
 17:24:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513155723.230707-1-andrewmaney05@gmail.com> <20260514065043.1F11AC2BCC7@smtp.kernel.org>
In-Reply-To: <20260514065043.1F11AC2BCC7@smtp.kernel.org>
From: Andrew Maney <andrewmaney05@gmail.com>
Date: Thu, 14 May 2026 20:24:47 -0400
X-Gm-Features: AVHnY4LTy48LZkM9GvpbK4JwtBCoc-eeUzEJoDhb0pBeE9B9IEmlG-o2DGeB93U
Message-ID: <CAO1jzHiiTKaSnT1mkVPCfBAcGNGKdB3UY9uWp-qAzVFqH2ZEjw@mail.gmail.com>
Subject: Re: [PATCH] HID: Expose LattePanda IOTA UPS as a power_supply device
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, bentiss@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 2:50=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 7 potential issu=
e(s) to consider:
> - [High] Kernel panic due to invalid type cast when transport is not USB =
(e.g. uhid).
> - [High] Kernel panic from dereferencing an ERR_PTR in the raw event hand=
ler.
> - [High] Exposing fabricated 0 values for unsupported TIME_TO_EMPTY prope=
rties causes immediate system shutdown.
> - [Medium] Hardcoded sysfs name prevents multiple devices and causes prob=
e failure.
> - [Medium] Data race on `ups->charge_limit`.
> - [Low] Missing `POWER_SUPPLY` dependency in Kconfig causes build failure=
s.
> - [Low] Driver synchronously blocks the probe path for 3 seconds.
> --
>
> commit 7d140ce589ec6c637bec5ce8b0c27bf8634322c6
> Author: Andrew Maney <andrewmaney05@gmail.com>
> Subject: HID: Expose LattePanda IOTA UPS as a power_supply device
>
> This commit adds a driver for the LattePanda IOTA UPS. It exposes battery
> status, capacity, and charging status via the power_supply subsystem by p=
arsing
> custom HID reports.
>
> > diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> > --- a/drivers/hid/Kconfig
> > +++ b/drivers/hid/Kconfig
> > @@ -105,6 +105,16 @@ config HID_HAPTIC
> >
> >  menu "Special HID drivers"
> >
> > +config HID_LATTEPANDA_IOTA_UPS
> > +     tristate "LattePanda IOTA UPS"
> > +     depends on USB_HID && X86
>
> If the kernel is configured with CONFIG_POWER_SUPPLY=3Dm and
> CONFIG_HID_LATTEPANDA_IOTA_UPS=3Dy, will the built-in HID driver fail to =
link
> against the modular power supply core? Should this include a dependency o=
n
> POWER_SUPPLY?
>
> > diff --git a/drivers/hid/hid-lattepanda-iota-ups.c b/drivers/hid/hid-la=
ttepanda-iota-ups.c
> > --- /dev/null
> > +++ b/drivers/hid/hid-lattepanda-iota-ups.c
> [ ... ]
> > +static enum power_supply_property iota_ups_properties[] =3D {
> > +     POWER_SUPPLY_PROP_STATUS,
> > +     POWER_SUPPLY_PROP_CAPACITY,
> > +     POWER_SUPPLY_PROP_PRESENT,
> > +     POWER_SUPPLY_PROP_ONLINE,
> > +     POWER_SUPPLY_PROP_SCOPE,
> > +     POWER_SUPPLY_PROP_TECHNOLOGY,
> > +     POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD,
> > +     POWER_SUPPLY_PROP_CAPACITY_LEVEL,
> > +     POWER_SUPPLY_PROP_TIME_TO_EMPTY_NOW,
> > +     POWER_SUPPLY_PROP_TIME_TO_FULL_NOW,
>
> If the hardware doesn't support reporting time remaining, is it safe to
> include these properties and return 0?
>
> Returning 0 seconds remaining while discharging can signal to userspace p=
ower
> daemons like UPower or systemd-logind that the battery is empty, which mi=
ght
> trigger an immediate emergency suspend or shutdown. Could these unsupport=
ed
> properties be omitted from the array entirely?
>
> [ ... ]
> > +static int iota_ups_set_property(struct power_supply *supply,
> > +                              enum power_supply_property psp,
> > +                              const union power_supply_propval *val)
> > +{
> > +     struct iota_ups *ups =3D power_supply_get_drvdata(supply);
> > +
> > +     if (psp =3D=3D POWER_SUPPLY_PROP_CHARGE_CONTROL_END_THRESHOLD) {
> > +             /*
> > +              * V1.0 supports 80% and 100% charge limits only, set via
> > +              * DIP switch on the board. This property allows userspac=
e
> > +              * to inform the driver which limit is configured.
> > +              */
> > +             if (val->intval !=3D 80 && val->intval !=3D 100)
> > +                     return -EINVAL;
> > +             ups->charge_limit =3D val->intval;
>
> Does this introduce a data race on ups->charge_limit?
>
> This field is modified here without holding ups->lock, but it is concurre=
ntly
> read in iota_ups_raw_event() and iota_ups_get_property() where it is
> protected by spin_lock_irqsave(). Should this assignment also be
> protected by the spinlock?
>
> [ ... ]
> > +static int iota_ups_raw_event(struct hid_device *hdev,
> > +                           struct hid_report *report,
> > +                           u8 *data, int size)
> > +{
> > +     struct iota_ups *ups =3D hid_get_drvdata(hdev);
> [ ... ]
> > +     /*
> > +      * Notify the power_supply core outside the spinlock. This
> > +      * triggers UPower's PropertiesChanged signal with the new values=
.
> > +      */
> > +     if (changed && ups->psu)
> > +             power_supply_changed(ups->psu);
>
> Could ups->psu contain an error pointer here?
>
> In iota_ups_probe(), if devm_power_supply_register() fails, it returns an
> error pointer like ERR_PTR(-ENOMEM), which gets directly assigned to ups-=
>psu.
>
> Because hid_hw_start() is called earlier, raw HID events can be processed
> concurrently before the hardware is stopped in the error path. Since an e=
rror
> pointer is not NULL, the check (changed && ups->psu) would pass, and
> power_supply_changed() would be called with the error pointer, leading to=
 a
> crash.
>
> Would it be safer to assign the return value of devm_power_supply_registe=
r()
> to a local variable first, and only update ups->psu on success?
>
> [ ... ]
> > +static int iota_ups_probe(struct hid_device *hdev,
> > +                       const struct hid_device_id *id)
> > +{
> [ ... ]
> > +     /* Retrieve serial number from the USB descriptor */
> > +     udev =3D to_usb_device(hdev->dev.parent->parent);
> > +     if (udev->serial)
> > +             strscpy(ups->serial, udev->serial, sizeof(ups->serial));
>
> Can this cause a kernel panic if the HID device is instantiated via users=
pace
> mock drivers like uhid?
>
> When using uhid (which allows setting the bus type to BUS_USB), the paren=
t
> device is the uhid character device, not a usb_interface. Dereferencing t=
he
> resulting struct usb_device pointer would perform an out-of-bounds memory
> read.
>
> Should the driver verify the transport layer using hid_is_usb() before
> dereferencing USB-specific structures, or simply use hdev->uniq instead?
>
> [ ... ]
> > +     /*
> > +      * Wait for both status and capacity reports before registering.
> > +      * The device sends reports every ~1 second; 3 seconds is safe.
> > +      */
> > +     wait_for_completion_timeout(&ups->got_initial_data,
> > +                                 msecs_to_jiffies(3000));
>
> Does blocking the probe path for 3 seconds cause issues for device
> enumeration?
>
> Calling wait_for_completion_timeout() synchronously stalls the kernel's
> device enumeration thread for that bus, which can unnecessarily delay the
> overall system boot process or stall the handling of other devices during
> hotplug.
>
> Could the registration be deferred, or could the device be registered
> immediately with an unknown state instead of blocking?
>
> > +
> > +     ups->psu_desc.name                      =3D "lattepanda-iota-ups"=
;
>
> Is it possible to have multiple of these UPS devices connected to a singl=
e
> system?
>
> If a second device is plugged in, it will attempt to register a sysfs
> directory with the exact same hardcoded name, which fails with -EEXIST.
>
> This probe failure would then trigger the error pointer panic mentioned
> earlier. Should the driver dynamically construct a unique name using
> devm_kasprintf() with dev_name(&hdev->dev)?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513155723.23=
0707-1-andrewmaney05@gmail.com?part=3D1

Thanks for the detailed review! I'll do the following in v3:
* Remove TIME_TO_EMPTY_NOW and TIME_TO_FULL_NOW to avoid spurious
shutdowns. The UPS board doesn't currently have any way to report
these values as of right now.
* Add the POWER_SUPPLY requirement to Kconfig.
* Fix the data race for ups->charge_limit in set_property.
* Address the 3 second probe delay, it may not be needed. Registering
the UPS immediately with an unknown state may not be safe if its
reports are misinterpreted.
* Fix ERR_PTR panic with a local variable.
* Fix uhid panic with hid_is_usb() before dereferencing.
* Use devm_kasprintf() for a unique sysfs name. It is not currently
possible to have more than one UPS board connected to the IOTA, but
I'll implement this as a safeguard in case future hardware revisions
add support for multiple boards.

Thanks,
Andrew
