Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7BB40244C
	for <linux-input@vger.kernel.org>; Thu, 14 May 2026 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778766884; cv=pass; b=ZMrt9VeMblTTTg4taX9oU7P5337VGL4xCyUIGmfD+ttQdPmKjuBqKXOVLz42Z4jygSHguZPh/BpzUiQHEXgxptrVNVbzqRQCuADWl3a7KPl0DVrFq81J31G+Q6zoxlPtOw5jVKCtE/jlnAjIdaGV/byOVqD50SoXf1XS64UbxL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778766884; c=relaxed/simple;
	bh=ZEzprdMfJ7nMk4D7he84mrRA4QUGO6FIF+ftWRayMp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BhCvm59dHut96gb9nI3UtwsVo7EY7ePVKB85nwNhymWuG0d0oVfoQ9xgKxd+xvsVl/aGVWIKsD1+O/RGS/WxBYre+vC08XW55es4mFO2xiOVTNHqSLrpjPnqrUBQ2ZJJoGk9cv/a4h91S0Ggp7Gayrnq8iFWeGnIkBPy0EUEUak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhhDYImX; arc=pass smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhhDYImX"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8b6dd874471so104575096d6.0
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 06:54:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778766880; cv=none;
        d=google.com; s=arc-20240605;
        b=BQAh/dxF7clJ8IixfHd6Dtc/TmWq4TE8mlgTbK9cHgegdO7pSQGrTVREA3RfuI87x1
         nzlPwikXXzB+GPFiEe2lTl9EVt0JipY7n82lBxRezmTf4wp6uS7nLO+RShN2hmLFrSvO
         C58DHQJHrvKZ7cfZKSN96V6AR6axuOUsCWNIaVHGLbrvIRxE6V/vpz6IiveJqhzmu0fy
         1v6tW00Qfpi2XB/sG5ygkNVzzDJX1fCCbq9ocUgIv74kI5gQz9N1sQetGq2+Ucdj0n7M
         Dkjs1KPrKVRFFrlBCEc4C/F5xuv1Se3L2cbz8e6xYGF2WMS8862VqunZG1gL/i6LBT/s
         tdoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jUf5ENwrvYCD59sribRgmCCruN7lvNNZBafmSJJQq2k=;
        fh=dfvPRi+t5KvUF1qpgNVmacxvd83mvku6fE8K+/2kbH8=;
        b=la2/uNraC7eB0wb0/+q1Qp0IrPnOfv2N2T35HsKi9p6xKRXN2Pwy00zEKDHyAVqmKe
         um22K96c9tTFIiOHrOoG8rigSDdc9NDXtEI8uTClOJ/UYYVeJ2r+Nrsd/lLSjOmYXKro
         RK0N6SeutAJPjsWof732D8XG1qUipKMarx5LOasS3LrU1L/SEvkfmaIRMEKr46x7/pJ9
         3jCuizyCQwgZ2OXadKkHyav8UuxysW4l7RGHeHtHgJhDh+K57vDGdjYt8rDuOf3oHy1w
         jeWeZ+OkJ+bFligYpJjm+6F1sBkG1lSt3oV5Ka1VbRXVeS0E+thWPXJ5Rg45DvmhTOOP
         xRVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778766880; x=1779371680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jUf5ENwrvYCD59sribRgmCCruN7lvNNZBafmSJJQq2k=;
        b=dhhDYImXgpvxQ5pFfYfyL4NWrbHLn4Ysatfp3DPHAsw10R0OODg2xQ2+TPIgwXjixh
         66M98nXM5xZ1o1wekObitnWRDktzWvDWDIkgRipN1/lJutNLuiBdFfpEFk4Mk/bGHVRz
         91MK+xl7xrOXw9LwKKq6eKUWRvOdJm3tv3jWeHFQQj04rkQGDD1Dkw0lbRli0ZzNZMu7
         xArw8pg9TcCqMj3rMDYPACaiwe+CR8czZ1VQWFfLONCWbXpAo65rZoG9i+LvFYwtMvWk
         863NfaE+ANzlbcJtlZe/wbbyGnQWrGnRdI8dwGfqern02g5AIkQrDSmwDG5o+W2M7wsQ
         Q4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778766880; x=1779371680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jUf5ENwrvYCD59sribRgmCCruN7lvNNZBafmSJJQq2k=;
        b=bsc3uV/od9yVwyxmtIXiPZXYpEKKYJc9Q4jQ3iA1gU8xt66l5yCGAM2kM3DhfJKLTv
         lrrjHxBb55pDwrBeVrvT+8vXlKaA4vTOILH6tXQyNbwEJqY60MTTWHT9XBXKTJ2W1zkY
         vHJa5EYIo+t9U7oRuWu+JAD6AaWG1zIbUmlo9hj7jJjWU7ArIwqESyT99rwRhzWDW6u8
         mQMbt6zVEbBZ3qq05iK1gNWPuG2uGEqehmwxvmGxxCCft/V42jyeob4SK9OZAfE3NK4K
         JzVhJufmO7UgwqpjOFN89aXDZoIh+5bsKdoWKYKF5T7JGr6vsCXlzaUTVA8qqBiRC4Bx
         ALLw==
X-Gm-Message-State: AOJu0YwkWtpZ6AX2fgnF8NQPvrO00u2qAJNxIsESfwGu+r+3BffRFy6Y
	+mZAIZvgQhTuNQdfJpCwUYbpEI4hP6W03WrtXc0nozYg/Tj8v3xif7gby5yBNW3//u85MqrMCNf
	dbh6EFgdSCzt2d79Mt3XvB8FzXNQUu7A=
X-Gm-Gg: Acq92OEjQ3uH/1gZywQAQnDa+51wB9gKjYFz1ijUiL1YxNDe0cewq6OGizfygudu5WT
	jcLP+Jm+8v52kJOrLcskT3rLln7aWFwT0FqXcsXFnJnBaGzDHOeebMpI2IdjoExRryvtwf//XOg
	73An9IpfVF5JWXETzL1doHj5YUIPsYQoY92UbYsnhWEth2jTezgQx+aYWPCBMbr2xj3DUModUPo
	EQ4r9CZlJYie+oahKSg59fVQn9VmpiHD9TqoIy4FxhMTwXWO0nzNvk3BYH6xgr0PSrDHJI/isPx
	7bb+3tHQ
X-Received: by 2002:a05:6214:5294:b0:8bd:de6d:c340 with SMTP id
 6a1803df08f44-8c7bb4b1cafmr127540116d6.26.1778766879720; Thu, 14 May 2026
 06:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513231445.3213501-4-derekjohn.clark@gmail.com> <20260514125337.950E8C2BCB3@smtp.kernel.org>
In-Reply-To: <20260514125337.950E8C2BCB3@smtp.kernel.org>
From: Derek John Clark <derekjohn.clark@gmail.com>
Date: Thu, 14 May 2026 06:54:28 -0700
X-Gm-Features: AVHnY4L5lwdI44FHg0fPESrXT2M7Uo8LeL1z1SpAOCehX6GQjcM26_P8E8Nou_A
Message-ID: <CAFqHKT=MuPUajfGFR19iKNpTeEMMymqriHXNf+XyprB60D08vQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] HID: hid-msi: Add RGB control interface
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 5:53=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 7 potential issu=
e(s) to consider:
> - [Critical] The `speed_show` function incorrectly casts the LED class de=
vice to a HID device, resulting in an invalid pointer dereference and a gua=
ranteed kernel panic.
> - [Critical] Missing bounds check on `frame->frame_count` from the USB de=
vice leads to an out-of-bounds read of kernel memory.
> - [High] Re-arming `rgb_queue` from sysfs attributes after it has been ex=
plicitly cancelled in `claw_remove` leads to a Use-After-Free.
> - [High] The `guard(mutex)` macro in `claw_hw_output_report()` is incorre=
ctly used inside a block scope, providing absolutely no synchronization.
> - [High] Concurrent modification of shared RGB state without lock protect=
ion causes data races and memory corruption.
> - [High] Every RGB state change triggers a `SYNC_TO_ROM` command, causing=
 severe flash memory degradation.
> - [Medium] An early return in `cfg_setup_fn` silently drops core gamepad =
sysfs attributes if RGB initialization fails.
> --
>
> commit a90ff4a0f03b6df7827bfbcd222f977138b9d280
> Author: Derek J. Clark <derekjohn.clark@gmail.com>
>
> HID: hid-msi: Add RGB control interface
>
> Adds RGB control interface for MSI Claw devices. The MSI Claw uses a
> fairly unique RGB interface. It has 9 total zones (4 per joystick ring
> and 1 for the ABXY buttons), and supports up to 8 sequential frames of
> RGB zone data.
>
> > --- a/drivers/hid/hid-msi.c
> > +++ b/drivers/hid/hid-msi.c
>
> [ ... ]
>
> > @@ -308,15 +368,52 @@ static int claw_profile_event(struct claw_drvdata=
 *drvdata, struct claw_command_
> >               for (i =3D 0; i < CLAW_KEYS_MAX; i++)
> >                       codes[i] =3D (cmd_rep->data[6 + i] !=3D 0xff) ? c=
md_rep->data[6 + i] : 0x00;
> >               break;
> > +     case CLAW_RGB_PENDING:
> > +             frame =3D (struct rgb_report *)cmd_rep->data;
> > +             rgb_addr =3D drvdata->rgb_addr;
> > +             read_addr =3D be16_to_cpu(frame->read_addr);
> > +             frame_calc =3D (read_addr - rgb_addr) / CLAW_RGB_FRAME_OF=
FSET;
> > +             if (frame_calc > U8_MAX) {
> > +                     dev_err(drvdata->led_mc.led_cdev.dev, "Got unsupp=
orted frame index: %x\n",
> > +                             frame_calc);
> > +                     ret =3D -EINVAL;
> > +                     goto err_pending;
> > +             }
> > +             f_idx =3D frame_calc;
> > +
> > +             if (f_idx >=3D CLAW_RGB_MAX_FRAMES) {
> > +                     dev_err(drvdata->led_mc.led_cdev.dev, "Got illega=
l frame index: %x\n",
> > +                             f_idx);
> > +                     ret =3D -EINVAL;
> > +                     goto err_pending;
> > +             }
> > +
> > +             /* Always treat the first frame as the truth for these co=
nstants */
> > +             if (f_idx =3D=3D 0) {
> > +                     drvdata->rgb_frame_count =3D frame->frame_count;
>
> drvdata->rgb_frame_count is assigned directly from the hardware packet.
> Should there be a bounds check here to ensure it is less than or equal to
> CLAW_RGB_MAX_FRAMES?
>
> Later, claw_write_rgb_state() uses drvdata->rgb_frame_count as the upper
> bound for a loop reading from drvdata->rgb_frames. If a device sends a
> frame count greater than 8, could this read out-of-bounds kernel memory
> and send it back to the USB device?

I'll add a bounds check, though again it is unlikely with the previous chec=
ks.

> > +                     /* Invert device speed (20-0) to sysfs speed (0-2=
0) */
> > +                     drvdata->rgb_speed =3D frame->speed;
> > +                     drvdata->led_mc.led_cdev.brightness =3D frame->br=
ightness;
> > +                     drvdata->led_mc.subled_info[0].intensity =3D fram=
e->zone_data.zone[0].red;
> > +                     drvdata->led_mc.subled_info[1].intensity =3D fram=
e->zone_data.zone[0].green;
> > +                     drvdata->led_mc.subled_info[2].intensity =3D fram=
e->zone_data.zone[0].blue;
> > +             }
> > +
> > +             memcpy(&drvdata->rgb_frames[f_idx], &frame->zone_data,
> > +                    sizeof(struct rgb_frame));
>
> claw_profile_event() modifies drvdata->rgb_frames and
> drvdata->rgb_frame_count from the HID raw event handler context.
> Simultaneously, claw_rgb_queue_fn() runs in a workqueue and calls
> functions that overwrite these exact same fields.
>
> Since there are no locks protecting these updates, could a background
> worker read torn state or corrupt the frame arrays while they are being
> actively updated by the asynchronous device response?

I'll add another mutex I suppose.

> [ ... ]
>
> > @@ -759,6 +856,397 @@ static const struct attribute_group claw_gamepad_=
attr_group =3D {
> >       .is_visible =3D claw_gamepad_attr_is_visible,
> >  };
> >
> > +/* Read RGB config from device */
> > +static int claw_read_rgb_config(struct hid_device *hdev)
> > +{
>
> [ ... ]
>
> > +/* Send RGB configuration to device */
> > +static int claw_write_rgb_state(struct claw_drvdata *drvdata)
> > +{
> > +     struct rgb_report report =3D { 0x01, 0x0000, CLAW_RGB_FRAME_OFFSE=
T, 0x00,
> > +                     drvdata->rgb_frame_count, 0x09, drvdata->rgb_spee=
d,
> > +                     drvdata->led_mc.led_cdev.brightness };
> > +     u16 write_addr =3D drvdata->rgb_addr;
> > +     size_t len =3D sizeof(report);
> > +     int f, ret;
> > +
> > +     if (!drvdata->rgb_addr)
> > +             return -ENODEV;
> > +
> > +     if (!drvdata->rgb_frame_count)
> > +             return -EINVAL;
> > +
> > +     guard(mutex)(&drvdata->rom_mutex);
> > +     /* Loop through (up to) 8 pages of RGB data */
> > +     for (f =3D 0; f < drvdata->rgb_frame_count; f++) {
> > +             report.zone_data =3D drvdata->rgb_frames[f];
> > +
> > +             /* Set the MCU address to write the frame data to */
> > +             report.read_addr =3D cpu_to_be16(write_addr);
> > +
> > +             /* Serialize the rgb_report and write it to MCU */
> > +             ret =3D claw_hw_output_report(drvdata->hdev, CLAW_COMMAND=
_TYPE_WRITE_PROFILE_DATA,
> > +                                         (u8 *)&report, len, 8);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             /* Increment the write addr by the offset for the next fr=
ame */
> > +             write_addr +=3D CLAW_RGB_FRAME_OFFSET;
> > +     }
> > +
> > +     ret =3D claw_hw_output_report(drvdata->hdev, CLAW_COMMAND_TYPE_SY=
NC_TO_ROM, NULL, 0, 8);
>
> Does sending CLAW_COMMAND_TYPE_SYNC_TO_ROM on every RGB state change
> cause excessive flash memory degradation?
>
> Because claw_apply_rgb_state() is triggered by unthrottled sysfs writes
> (such as rapidly changing a brightness slider), this might cause hundreds
> of NVRAM writes per second and potentially degrade the MCU's flash
> endurance.

This is throttled by mod_delayed_work, where each subsequent call
under 50ms resets the timer.

> [ ... ]
>
> > +static ssize_t effect_store(struct device *dev,
> > +                         struct device_attribute *attr,
> > +                         const char *buf, size_t count)
> > +{
> > +     struct led_classdev *led_cdev =3D dev_get_drvdata(dev);
> > +     struct led_classdev_mc *led_mc =3D container_of(led_cdev, struct =
led_classdev_mc, led_cdev);
> > +     struct claw_drvdata *drvdata =3D container_of(led_mc, struct claw=
_drvdata, led_mc);
> > +     int ret;
> > +
> > +     ret =3D sysfs_match_string(claw_rgb_effect_text, buf);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     drvdata->rgb_effect =3D ret;
> > +     mod_delayed_work(system_wq, &drvdata->rgb_queue, msecs_to_jiffies=
(50));
> > +
> > +     return count;
> > +}
>
> Is there a potential use-after-free here if sysfs attributes are written
> after the device is removed?
>
> In claw_remove(), the driver attempts to tear down the worker using
> cancel_delayed_work_sync(&drvdata->rgb_queue). However, the sysfs files
> and LED endpoints remain active because devm cleanup executes after
> claw_remove() completes.
>
> A concurrent write to a sysfs attribute like effect_store could call
> mod_delayed_work() and re-arm the work item, causing it to execute after
> drvdata has been freed.
> [ ... ]
>
> > +static ssize_t speed_show(struct device *dev, struct device_attribute =
*attr,
> > +                       char *buf)
> > +{
> > +     struct hid_device *hdev =3D to_hid_device(dev);
> > +     struct claw_drvdata *drvdata =3D hid_get_drvdata(hdev);
>
> Is the dev parameter passed to speed_show actually a hid_device?
>
I forgot to fix this.

> The rgb_attr_group sysfs group is attached to the LED class device
> (led_cdev.dev), not the parent HID device. The macro to_hid_device(dev)
> blindly performs a container_of cast, which will yield an invalid pointer
> for hdev.
>
> Dereferencing it with hid_get_drvdata(hdev) will likely cause a kernel
> panic when this world-readable attribute is accessed.
>
> [ ... ]
>
> > @@ -772,6 +1260,13 @@ static void cfg_setup_fn(struct work_struct *work=
)
> >               return;
> >       }
> >
> > +     ret =3D claw_read_rgb_config(drvdata->hdev);
> > +     if (ret) {
> > +             dev_err(drvdata->led_mc.led_cdev.dev,
> > +                     "Failed to setup device, can't read RGB config: %=
d\n", ret);
> > +             return;
> > +     }
> > +
> >       /* Add sysfs attributes after we get the device state */
> >       ret =3D devm_device_add_group(&drvdata->hdev->dev, &claw_gamepad_=
attr_group);
>
> If claw_read_rgb_config() fails due to a temporary USB error or
> unsupported firmware, this early return skips the subsequent
> devm_device_add_group call.
>
> Does this unintentionally break the device's core gamepad configuration
> interface simply because the RGB initialization failed?

The expectation is that if any of these error there is a problem with
the kernel or the device hardware. This is intentional.

> This isn't a new bug introduced by this patch, but does the guard() in
> claw_hw_output_report() provide any synchronization?
>
> claw_hw_output_report() {
>     if (timeout) {
>         guard(mutex)(&drvdata->cfg_mutex);
>         reinit_completion(&drvdata->send_cmd_complete);
>     }
>     ...
> }
>
> Because the guard is declared inside the block, the mutex is immediately
> released at the closing brace before hid_hw_output_report() and
> wait_for_completion_interruptible_timeout() are ever called. This seems
> to leave the I/O operations unprotected against concurrent threads, which
> this patch introduces via the new RGB workers.
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260513231445.32=
13501-1-derekjohn.clark@gmail.com?part=3D3
