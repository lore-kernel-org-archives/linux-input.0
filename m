Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795214534;
	b=Fdtf5v9dAz6dWLEt3Zn3EX0e42YmClQ623VsOkIXYrQpqvq/00fXr+e46SKHMn7/tQwF
	 Ra+Ok9FBaHJbWPOwAmTSGzuCIleMI9oU3DVV9tUusvRbuB/FWTeN2WpcXfHJItEUCB5ng
	 16lra6qK7FO3xZTDLryKpZQvjWbpIXqm92uiTL8bKCsa8vrBDMcilc5hyVe0IsbqvDem3
	 pWKrqqFEG4y3loMBhlFxpe5wcrGSHM6LEzGdf5IXmgrTKaJuhgK124LP8RJLY5y52ZuUm
	 6WaoFAAcWjDcG8S9HoeNv0sjhm/BJ4G1D2dAUsiNBJm/xmu8nRZyEcIEu279zHy2K8Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=vQU4s0s9jpO6QmWD/0jmrJPFOrD2Wfw5sN63JkEaowU=;
	b=Tc8pwegLdrId8/yaIHBwKbNtsvCEbG7lzAe/scByxYnTtBqJJH7YkpVg+shiqRyVYhPz
	 Yn7L8I2sZliPYuw3HfIhfiG5C7inLxqYVTPjSJBgxiCkrlsJrMsdw8GTZJtJZIRX0ICCP
	 iZZ0HxtLCqjS5qyzxEBZ5nHULa91wA0c4DELO3nIkV6aJXpLU/L11A/ittF1Lofk5Pkfm
	 Zv9l665zc/xn0h7hcYc6PS0z4H0QgihcOvO9fvz+Y6YhIi6LefwjrtptSVIxrymYX78IL
	 5QcnoPlNpHwpfZmz9VabelS1fKnEB+8tHqaNMz+r89jacojZ0v+NkrJh+HH2yuY9uJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fvNFs6YW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE99606A6B4
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 22:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE99606A6B4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=fvNFs6YW
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c6a0abc2eso1693416d50.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 14:42:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795214531; cv=none;
        d=google.com; s=arc-20260327;
        b=QJzcI00kGpsFuUXGaUokqKh1iosYRgMAyG2WT2YVDLPGIg0po6ZmvUlbVLL5693cOn
         bblmci/ZbIYfl1Tzy4IPzwZrA8wGoedTMLln8lr5VorTMoJw5EjG3QGM6Wr+tg9wKpXY
         prQS5hCiCHqSz/N2AB5wTS4KHRORIntPk/fEq7E/TlI3MJQ2hV/qdrU7QM9teUHlmlY5
         fDrezLgedOZkP7HddfrFPXFWDbwnCb2ihuB3sLfMqRQbiXs2JCSIGu9QOKdI9ZXB1KPF
         vIOyz184mL4kt3OzCxFCsU21MnzBQqdZ2N4KFnvROIDEe9sLUBzoHs+xubCkdlLOQQ0K
         aAGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vQU4s0s9jpO6QmWD/0jmrJPFOrD2Wfw5sN63JkEaowU=;
        fh=osfj9leewLfc4MqIYaUjfG4KfpRUNqFnByXZRUnRoVs=;
        b=q5flkMNwA4+LdVMoimahivIesqPkMeqo2C3XgZPTKGNVPyQUJ1qHp/YVRJ3f9Cq5A8
         VuR72IGQUyyHMC9Y0ot9sA5q8rOyK2qlsB/1l31ppu0PcY8AhF5DrOxZh88KSxrl9O0z
         vEmPyqNtWNkC+gmzIkoxcN2l0dCsCZHVYbMZoZ67LYA+rvHM5G3UoFBn4AbatWC/G+q8
         kzWeoK6gEmwJfjNsVoVOGipsX9KO6SPGZABV5bSe6XnyXwPx5wlOvnhKCWz/2iFY/3Q+
         El/LenNVnoYp4pac7L6usYXVArzOIzEiF/NGAEPZBxZusxaE8+HGmGACXxtk3kAV9gK4
         Zlxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795214531; x=1795819331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vQU4s0s9jpO6QmWD/0jmrJPFOrD2Wfw5sN63JkEaowU=;
        b=fvNFs6YWasf+wplVYmHAek4F/XoGdUzQF5xAHO5IGZp5CRRMRRxkruN3V+DWI4+hCW
         oHgp2SRsfzcmufJj7ymjrsKVE0kw4s8HdIeYBoJqV5T7lhTewU9l1CwTZk4K5ZUFxWIh
         2dqCA02YjCgAuB7cdfi9YfOGibXePz+tK2myU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214531; x=1795819331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vQU4s0s9jpO6QmWD/0jmrJPFOrD2Wfw5sN63JkEaowU=;
        b=UKdyqalAfsCP+YJRYWf3GBUMWoZ+pguQwpvOnsYNdXonCxMmz1/S/Qgpa/BzIFPKLb
         z6kjZgH1EpuIcHEM7BtADcLxn0t5zEIYP273hx+yo2doQptsNN2V/SSfbCBDGyJGeVY6
         X5Q6MS1YgFk8e0HUtSpKPXtPi6V3t70Hvn7sQ4QSyBOco4Ka0IcLVKQidWEVcFXUzQhw
         7Im6JmfTBo++EpPB7x0PfWnpDJaPdvIAwCGRPDQv6B0PlQy15rFPXRIhAmLz9H0KGJqU
         v/jvmAs/rOaJGNHUYTx670XTqrGRiLCbe40UuwSfMvCt77S8JHNXSDh0Ajv73kH4DJq5
         ENow==
X-Gm-Message-State: APuU4Z+Eo56Df/Ggfxc9VL8AWc830SfNnECa+z04x+mCqvTAgvbLGlGK
	yda0B2LFWyeoGXYliU45F0iVUxBGYirM3j/nI6h4BX7rss/GZVhMsn9J3eamYDkbmgw7W+KaJVx
	EuY5YqtV8xDZWnlVNxSZtnRvkfLUdHoKLc4dvH355
X-Gm-Gg: AZFdTZdGtx5Agymemome43j+NYLSpET5KJJbwCgi7g8CYk2THW3oAHbdF1toZP39Xzu
	dR3VX21OMkz3QI53Yt7l6h4Q7t05iJ1rTlpb1xnTyHK9yf4qygfXYv9jdrYdnqpqZS7+ItA3MhX
	Eowb+/7vBZCiXk4ubY1YzArbpsL1AGh74WPqmYWYFh8+0SQyXfiCu7mfWjPjmefBID28ixnx0Pq
	3ESDIJob+WSxyjlxXxuT1hZpdjGj/M39Ik0RzMVRiD1jDcCLp6nCXlC//yFZ8JytHw/p/mgq4r3
	afeDLklpdul7ZUxLPGOnWtEYTOtDob5mzDX1lVrDLhO4siG+eIsUvOftOM4vFNjOQP+SMZ8m5Zk
	J+2+JHejI05n9X7ftMSXbibkGkxYRwQIT9F42U9+bAQDqe9LoCz/c2nAtZ+OIUeLTbAE=
X-Received: by 2002:a05:690e:1918:b0:67d:e4c3:d838 with SMTP id
 956f58d0204a3-67df440a008mr1910475d50.29.1795214531587; Fri, 20 Nov 2026
 14:42:11 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024-send-upstream-v7-0-abad13174b43@chromium.org>
 <20261024-send-upstream-v7-11-abad13174b43@chromium.org> <sashiko-outbox-183484@kernel.org>
In-Reply-To: <sashiko-outbox-183484@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 20 Nov 2026 14:42:00 -0800
X-Gm-Features: Aa3M54qwBjwBmrAzhDq76JOH0mkyHB45HQlbB0ykD_xKYZsQBf4Gvgfm3ggVaBs
Message-ID: <CAEe3GZHSuQ2c2gOJPgJDu08T2+m+2RHLmcpGsE_0o+=UX96F_A@mail.gmail.com>
Subject: Re: [PATCH v7 11/11] HID: spi-hid: add panel follower support
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 6:10=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [Medium] HID: spi-hid: unrecovered deassert_reset() failure in spi_hid_=
resume()
> - [Medium] HID: spi-hid: improper wakeup teardown for panel followers in =
probe
> --
>
> commit 35d9a38c1b6ffa8dbb3ab740ec9ce120c5b2e7a1
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
> HID: spi-hid: add panel follower support
>
> This commit adds DRM panel follower support to spi-hid so that a follower
> device powers up and suspends in coordination with its panel rather than
> during initial probe and standard system PM callbacks.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 3b8874ca0e1cc..496b33cdf3d46 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
>
> [ ... ]
>
> > @@ -325,28 +328,30 @@ static int spi_hid_resume(struct spi_hid *shid)
> >               return 0;
> >       }
> >
> > -     if (!device_may_wakeup(dev)) {
> > -             if (shid->power_state =3D=3D HIDSPI_OFF) {
> > -                     shid->ops->assert_reset(shid->ops);
> > +     /*
> > +      * Check power_state, not device_may_wakeup(): power/wakeup can c=
hange
> > +      * while the device is off.
> > +      */
> > +     if (shid->power_state =3D=3D HIDSPI_OFF) {
> > +             shid->ops->assert_reset(shid->ops);
> >
> > -                     shid->ops->sleep_minimal_reset_delay(shid->ops);
> > +             shid->ops->sleep_minimal_reset_delay(shid->ops);
> >
> > -                     error =3D shid->ops->power_up(shid->ops);
> > -                     if (error) {
> > -                             dev_err(dev, "%s: could not power up: %d\=
n", __func__, error);
> > -                             /* Suspend runs next even if resume fails=
. */
> > -                             enable_irq(shid->spi->irq);
> > -                             return error;
> > -                     }
> > -                     shid->power_state =3D HIDSPI_ON;
> > -                     reinit_completion(&shid->reset_done);
> > -                     error =3D shid->ops->deassert_reset(shid->ops);
> > -                     if (error)
> > -                             dev_err(dev, "%s: failed to deassert rese=
t: %d\n",
> > -                                     __func__, error);
> > -                     else
> > -                             was_reset =3D true;
> > +             error =3D shid->ops->power_up(shid->ops);
> > +             if (error) {
> > +                     dev_err(dev, "%s: could not power up: %d\n", __fu=
nc__, error);
> > +                     /* Suspend runs next even if resume fails. */
> > +                     enable_irq(shid->spi->irq);
> > +                     return error;
> >               }
> > +             shid->power_state =3D HIDSPI_ON;
> > +             reinit_completion(&shid->reset_done);
> > +             error =3D shid->ops->deassert_reset(shid->ops);
> > +             if (error)
> > +                     dev_err(dev, "%s: failed to deassert reset: %d\n"=
,
> > +                             __func__, error);
> > +             else
> > +                     was_reset =3D true;
> >       }
>
> [Severity: Medium]
> What happens if shid->ops->deassert_reset(shid->ops) fails in
> spi_hid_resume()?
>
> For non-followers, initial power-up goes through spi_hid_dev_init(), whic=
h
> powers down the device and returns the error when deassert_reset() fails.
> For panel followers, spi_hid_core_probe() leaves shid->power_state as
> HIDSPI_OFF and shid->hid as NULL, and spi_hid_panel_follower_work() relie=
s
> on spi_hid_resume() for the initial power-up as well as subsequent resume=
s.
>
> When deassert_reset() fails in spi_hid_resume(), was_reset remains false
> while shid->power_state is set to HIDSPI_ON and the IRQ is enabled with t=
he
> device still held in reset:
>
> drivers/hid/spi-hid/spi-hid-core.c:spi_hid_resume() {
>     ...
>         if (shid->hid) {
>                 if (was_reset && spi_hid_wait_for_reset(shid)) {
>                         /* No reset response: let recovery retry. */
>                         set_bit(SPI_HID_ERROR, &shid->flags);
>                         schedule_work(&shid->reset_work);
>                         return -ETIMEDOUT;
>                 }
>                 /* HID requests would fail while the device is not ready.=
 */
>                 if (!test_bit(SPI_HID_READY, &shid->flags))
>                         return 0;
>     ...
> }
>
> On the first power-up of a panel follower, shid->hid is NULL, so
> spi_hid_resume() returns 0 without scheduling shid->reset_work. On subseq=
uent
> resumes where shid->hid is non-NULL, was_reset is false and SPI_HID_READY=
 was
> cleared during spi_hid_suspend(), so spi_hid_resume() again returns 0 wit=
hout
> setting SPI_HID_ERROR or scheduling shid->reset_work.
>
> Should a deassert_reset() failure in spi_hid_resume() trigger recovery (o=
r
> clean up and return the error) so the device is not left powered on in re=
set
> and permanently uninitialized?

Same as the 10/11 comment; the next panel prepare retries the power
up.

>
> > @@ -1447,6 +1452,108 @@ static struct hid_ll_driver spi_hid_ll_driver =
=3D {
>
> [ ... ]
>
> > +static int spi_hid_register_panel_follower(struct spi_hid *shid)
> > +{
> > +     struct device *dev =3D &shid->spi->dev;
> > +
> > +     shid->panel_follower.funcs =3D &spi_hid_panel_follower_prepare_fu=
ncs;
> > +
> > +     /*
> > +      * If we're not in control of our own power up/power down then we=
 can't
> > +      * do the logic to manage wakeups. Give a warning if a user thoug=
ht
> > +      * that was possible then force the capability off.
> > +      */
> > +     if (device_can_wakeup(dev)) {
> > +             dev_warn(dev, "Can't wakeup if following panel\n");
> > +             device_set_wakeup_capable(dev, false);
> > +     }
> > +
> > +     return drm_panel_add_follower(dev, &shid->panel_follower);
> > +}
>
> [ ... ]
>
> > @@ -1523,21 +1618,19 @@ int spi_hid_core_probe(struct spi_device *spi, =
struct spihid_ops *ops,
> >               }
> >       }
> >
> > -     error =3D shid->ops->power_up(shid->ops);
> > -     if (error) {
> > -             dev_err(dev, "%s: could not power up: %d\n", __func__, er=
ror);
> > -             return error;
> > -     }
> > -
> > -     error =3D shid->ops->deassert_reset(shid->ops);
> > -     if (error) {
> > -             dev_err(dev, "%s: failed to deassert reset: %d\n", __func=
__, error);
> > -             shid->ops->power_down(shid->ops);
> > -             return error;
> > +     if (shid->is_panel_follower) {
> > +             /* Like the IRQ: the first panel_prepared resume enables =
it. */
> > +             disable_work(&shid->reset_work);
> > +             error =3D spi_hid_register_panel_follower(shid);
>
> [Severity: Medium]
> Does calling device_set_wakeup_capable(dev, false) in
> spi_hid_register_panel_follower() after devm_pm_set_wake_irq() in
> spi_hid_core_probe() leave the wake IRQ configured and leak
> dev->power.wakeup if wakeup was enabled on the device before probe?
>
> In spi_hid_core_probe(), if the firmware node marked the device as wakeup
> capable (for example via acpi_bind_one()), device_can_wakeup(dev) is true=
 and
> devm_pm_set_wake_irq(dev, spi->irq) attaches a wake IRQ before
> shid->is_panel_follower is checked:
>
> drivers/hid/spi-hid/spi-hid-core.c:spi_hid_core_probe() {
>     ...
>         if (device_can_wakeup(dev)) {
>                 error =3D devm_pm_set_wake_irq(dev, spi->irq);
>                 if (error) {
>                         dev_err(dev, "%s: failed to set wake IRQ\n", __fu=
nc__);
>                         return error;
>                 }
>         }
>
>         if (shid->is_panel_follower) {
>                 /* Like the IRQ: the first panel_prepared resume enables =
it. */
>                 disable_work(&shid->reset_work);
>                 error =3D spi_hid_register_panel_follower(shid);
>     ...
> }
>
> Furthermore, if a wakeup_source was attached to dev->power.wakeup (for
> example via sysfs power/wakeup before async or deferred probe completes),
> calling device_set_wakeup_capable(dev, false) directly sets
> dev->power.can_wakeup =3D false without detaching the wakeup source first=
.
> Subsequent calls to device_wakeup_disable(dev), including from
> device_pm_remove() on unbind, check dev->power.can_wakeup and return earl=
y:
>
> drivers/base/power/wakeup.c:device_wakeup_disable() {
>         struct wakeup_source *ws;
>
>         if (!dev || !dev->power.can_wakeup)
>                 return;
>
>         ws =3D device_wakeup_detach(dev);
>         wakeup_source_unregister(ws);
> }
>
> Should spi_hid_register_panel_follower() use device_init_wakeup(dev, fals=
e)
> (which calls device_wakeup_disable(dev) before clearing wakeup capability=
),
> and should spi_hid_core_probe() skip devm_pm_set_wake_irq() when
> shid->is_panel_follower is true?

This follows i2c-hid's panel follower handling. The wake IRQ is
not armed once can_wakeup is cleared, and the SPI core doesn't
enable wakeup before probe.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-send-ups=
tream-v7-0-abad13174b43@chromium.org?part=3D11
