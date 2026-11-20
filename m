Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795214183;
	b=n0+m3W88IzbpYNCnMxM2IOnQGC953eyNV8On7halJqAdsLIiBa6b6ezQGB+IJOlo0sx3
	 fIiTzUWUxeiRM85sSVmh1IpCsBhMo+YVNeOdTBghOyudb+q6ETd1DHEvNTDyzY8/W/KCD
	 GqJwiHoVerZfaIMJaowxBZO21QIIh415LSRBHd5LX2WhkF4AXBt4L8txqYQDor/4t4/+5
	 nqL2aoaypfHkE5e+3+bHtYrDmUZ2/buFIoqK/Ca23yedMlHZ5VXB0BW5qr/sEGqGgpGHM
	 mH+wlnmJa/MPb7Nc9xbsFp1+xQP2n5neQxytvUjvkyHdnwOt/82SI6/hso6OIjphW0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795214183;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LI62TlkKF7SE72mFPwGFMzusKh7ch0L+DlHxc/4ud2I=;
	b=QdJU691LlRC0X9UilGidFUBqByA1yI8q84FfnQ3e8i1r/dEL/NNmi8aPTzpH5Gdmx82s
	 227I3ouhuDqUSMqDmrYK1YI0enQszlkv7qryd+MOTgdPuZ/sQ8hWcZnd8vA9ek4Fbrp3P
	 4q0ut31wzbT7qs1edk8r4V0aUN6LnZ51OsSXyoLcc7u2mZQ98s1eYTd2bjKclvC42DCUG
	 9O15PNtoEABGyt5jXiX2eT/Z0WIi7SdOyhgYmIJOR8Me8pS3NbrIAXR17ErbmvubrOP7q
	 yP4oolw7OgydytOSFQdhu68Y9mzmsO9JqFfCYf7oV5lyGdyQpX+UKISVFGCPaBWO7gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="eRRP/wob";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C46606A692
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 22:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30C46606A692
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=eRRP/wob
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67db8985419so1983033d50.1
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 14:36:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795214180; cv=none;
        d=google.com; s=arc-20260327;
        b=b4WV8tibGeymTLblMzz3C/iefw7slGKbv8EYx1ovZQWEzLQ7W4t2dL/ezzcGYp05JZ
         WBth5mNMx1Y3u/q89PkwWQk12fIrHQYS2AaFLWW3crE9CaWXfRNqgBnjBBhpLKoEcwRa
         4UuCmv7YUm3ZLzCb+SUtoiU8147PtIhc0fb0wMqaUq3aBkXqzur6jKTkDy4UgITSVn/M
         lWx33v0Q1aQTZlPGR8zdAVRijLAnuzJ+KHN7h7ZBrXZFAtqdhKK0Bhw5x8/cKTSrvyh/
         UOSQ+LcfT1giCwlcJ3YSnkn0endofIQQZIYE5gKNAd21QdqVtA0evtefATzn/h7THHBf
         Katw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LI62TlkKF7SE72mFPwGFMzusKh7ch0L+DlHxc/4ud2I=;
        fh=osfj9leewLfc4MqIYaUjfG4KfpRUNqFnByXZRUnRoVs=;
        b=jrG2vEo304mwucFzLVCGKnKo/W7Ay54c0ljJ6YzEeecf/TEySezgeTDI2aKmhiU9UH
         wZq7d3etTfDpFGPcZYBkmIzyh17OY26KqMcZzlF6Hr0bFyR6EHBLU7Ny/aTJ4L3y2Ya2
         rdcJ4nnkFx2VW7cXCdZY0ie51doMDatUfKutpyWhLr3Vzq9xg0OzP4EX9KpN33fPnVr8
         1SovKBPTrk5TJjLA9zJAY0EH1uUSTQph31ddcTPWOZDaAVMTcDzCDHXAXiLysUUY6zIV
         G1ao6krxi2ihRLnBUEqdvUaB9SslY/aBouEgU+Xi5gLN1eGXt/0CC7cutnCKADKFiWTW
         4xvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795214180; x=1795818980; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LI62TlkKF7SE72mFPwGFMzusKh7ch0L+DlHxc/4ud2I=;
        b=eRRP/wobXJsITiQgwsuDY/DjVunwMvvWHB85pcB9gVCy7jztOH8pY+CbLv82/7Pdfy
         AmW9MnMAweg8pQ3eF3ZsvbkqBBRV+3sH9RWiwZ1JxlyHoKht12tMnzVRkBGKPjs6vBL7
         /0EtvKedEhSr+Fe3XjtOuSHiEG10trzsvsTHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795214180; x=1795818980;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LI62TlkKF7SE72mFPwGFMzusKh7ch0L+DlHxc/4ud2I=;
        b=EQIO+M7tOxrFFj+lEOtO0lI2dPnOICFuHtRs09+i29xfTe0s5RkANxkZRtBzgcQKE3
         6UTn591Zyltq87SH5oUKWYpbuAMfLItewNjN6gho/uRyamY1VKMqNkQfx85xw9Gjak8d
         j5kx/JyzSf4ySstfSklHsWKqF315W8bV1TGEYRzZ/PTfopQEABwZuMIBCUY8ASTtNkHe
         E4egCKSQp2rb/LRnisKn/N7W68X2BTAF4D81M7vYAJPjc/h7MVmA2Cf6UGHH2vjJJFG7
         8JuPFppeevDq10hvOFbOjhQv0I0cgmCSui1dT/CbaeeMc5YQTd597qXnS4OdNkYkXASs
         qrog==
X-Gm-Message-State: APuU4Z++GSBLcyH1SDsm3VIEZokhjdfSOwuflgsJQ9CXFwMrcjYAdzN8
	5PTHoGx6V1a/EzQ2Jf2ewlgAMZm4t3cqyp76s3GAQWwDMRZjdTDlZVZxl4AtPejWidZH+zTkGPG
	AY9edXIJXU6UrfuwBuprUPLS5g3iDAPRnUoxJA3sh
X-Gm-Gg: AZFdTZeLn8rlWqpQ8T9iZsQnHJlJ2vQ0VpOQkTwplnn3UbWbTXQJ7zC916nfz5BADDv
	XshzGkUmFd6GERbnWNuTSZJilNEh+dC4wdvwgdJVrz4GWvifkcd+d1Qhm/t/k1bpZB8CSDSti7C
	Gzz8BtJXVZ7vQ4XxNzXqnWipTbliPYgPta80nsv3AeV/v0SVcVqrHHhC5HeZvo6D8QmmWWoTtJ/
	xl1viQBQyAmlqXcPOl9ryELBw2bmMR5Zp5WkJmULGrtkVHWl9DoSt0/1ZyGFCefTOwnXlZCkade
	Pc1osmhxKCcwicJXXQshvtB5JgGnOdtWQWa0mJPpYBMvOE+67Ok3I5sqD3kmhCsklz6ExDi8Eww
	7ElC/PKzc7WOKa7Aqjzsk3YRGDpSCZU9Fgs/XIrKTjfRrYe4HgaR/s28fJRm5YfF3Vok=
X-Received: by 2002:a05:690c:6b09:b0:8b3:33cf:1fd6 with SMTP id
 00721157ae682-8b5204da8cbmr22654577b3.46.1795214180401; Fri, 20 Nov 2026
 14:36:20 -0800 (PST)
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
 <20261024-send-upstream-v7-10-abad13174b43@chromium.org> <sashiko-outbox-183486@kernel.org>
In-Reply-To: <sashiko-outbox-183486@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 20 Nov 2026 14:36:09 -0800
X-Gm-Features: AclHuK-uqG9_uXU3EVhPHyRTDXChIzvp0O_bkgQvn7hhRNcrLduMWOI_Cxiv4hw
Message-ID: <CAEe3GZGLP5PtW1HD1R_wm6+WeUf=7pVbCb3iKbihorEKy-4VkA@mail.gmail.com>
Subject: Re: [PATCH v7 10/11] HID: spi-hid: add power management implementation
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 6:19=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
> - [High] hid: spi-hid: unhandled deassert_reset() failure in spi_hid_resu=
me()
> - [Medium] HID: spi-hid: race and missed hid_driver_reset_resume() in spi=
_hid_resume()
> --
>
> commit 9bd51942caad3c04cffc9fdd14002340e1980586
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
> HID: spi-hid: add power management implementation
>
> This patch adds system sleep power management callbacks to the HID over S=
PI
> transport driver, handling device power down, reset synchronization, and =
wake
> IRQ setup across suspend and resume.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 4ff93d22715cd..3b8874ca0e1cc 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
>
> [ ... ]
>
> > @@ -231,6 +239,147 @@ static const char *spi_hid_power_mode_string(enum=
 hidspi_power_state power_state
> >       }
> >  }
> >
> > +/*
> > + * Wait for the device descriptor response after reset; the device the=
n takes
> > + * requests. Set READY here: the report descriptor check that normally=
 sets it
> > + * needs power_lock, which callers hold.
> > + */
> > +static int spi_hid_wait_for_reset(struct spi_hid *shid)
> > +{
> > +     unsigned long timeout =3D msecs_to_jiffies(SPI_HID_RESET_TIMEOUT =
+
> > +                                              SPI_HID_RESP_TIMEOUT);
> > +
> > +     if (!wait_for_completion_timeout(&shid->reset_done, timeout)) {
> > +             dev_warn(&shid->spi->dev,
> > +                      "Device descriptor not received after reset\n");
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     set_bit(SPI_HID_READY, &shid->flags);
> > +     return 0;
> > +}
> > +
> > +static int spi_hid_suspend(struct spi_hid *shid)
> > +{
> > +     int error;
> > +     struct device *dev =3D &shid->spi->dev;
> > +
> > +     /*
> > +      * Stop reset_work until resume; pending steps keep their flags. =
The
> > +      * IRQ stays on so a request in flight gets its response.
> > +      */
> > +     disable_work_sync(&shid->reset_work);
> > +
> > +     /* HID driver suspend may talk to the device; responses need the =
IRQ. */
> > +     scoped_guard(mutex, &shid->power_lock) {
> > +             if (shid->power_state !=3D HIDSPI_OFF && shid->hid) {
> > +                     error =3D hid_driver_suspend(shid->hid, PMSG_SUSP=
END);
> > +                     if (error) {
> > +                             dev_err(dev, "%s failed to suspend hid dr=
iver: %d\n",
> > +                                     __func__, error);
> > +                             enable_work(&shid->reset_work);
> > +                             /* Redo a schedule_work() dropped while d=
isabled. */
> > +                             schedule_work(&shid->reset_work);
> > +                             return error;
> > +                     }
> > +             }
> > +     }
> > +
> > +     /* disable_irq() waits for a running IRQ thread. */
> > +     disable_irq(shid->spi->irq);
> > +
> > +     guard(mutex)(&shid->power_lock);
> > +     if (!device_may_wakeup(dev)) {
> > +             if (shid->power_state !=3D HIDSPI_OFF) {
> > +                     /* Device is fully reset on resume; drop stale st=
ate. */
> > +                     clear_bit(SPI_HID_READY, &shid->flags);
> > +                     clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
> > +                     clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
> > +                     clear_bit(SPI_HID_ERROR, &shid->flags);
> > +                     set_bit(SPI_HID_RESET_PENDING, &shid->flags);
> > +
> > +                     shid->ops->assert_reset(shid->ops);
> > +
> > +                     error =3D shid->ops->power_down(shid->ops);
> > +                     if (error)
> > +                             dev_err(dev, "%s: could not power down: %=
d\n", __func__, error);
> > +
> > +                     /* Held in reset either way; resume resets it. */
> > +                     shid->power_state =3D HIDSPI_OFF;
> > +             }
> > +     }
> > +     return 0;
> > +}
> > +
> > +static int spi_hid_resume(struct spi_hid *shid)
> > +{
> > +     int error;
> > +     struct device *dev =3D &shid->spi->dev;
> > +     bool was_reset =3D false;
> > +
> > +     guard(mutex)(&shid->power_lock);
> > +     enable_work(&shid->reset_work);
> > +     if (test_bit(SPI_HID_DEAD, &shid->flags)) {
> > +             /* Stay off; only balance disable_*() in suspend. */
> > +             enable_irq(shid->spi->irq);
> > +             return 0;
> > +     }
> > +
> > +     if (!device_may_wakeup(dev)) {
> > +             if (shid->power_state =3D=3D HIDSPI_OFF) {
> > +                     shid->ops->assert_reset(shid->ops);
> > +
> > +                     shid->ops->sleep_minimal_reset_delay(shid->ops);
> > +
> > +                     error =3D shid->ops->power_up(shid->ops);
> > +                     if (error) {
> > +                             dev_err(dev, "%s: could not power up: %d\=
n", __func__, error);
> > +                             /* Suspend runs next even if resume fails=
. */
> > +                             enable_irq(shid->spi->irq);
> > +                             return error;
> > +                     }
> > +                     shid->power_state =3D HIDSPI_ON;
> > +                     reinit_completion(&shid->reset_done);
> > +                     error =3D shid->ops->deassert_reset(shid->ops);
> > +                     if (error)
> > +                             dev_err(dev, "%s: failed to deassert rese=
t: %d\n",
> > +                                     __func__, error);
> > +                     else
> > +                             was_reset =3D true;
> > +             }
> > +     }
>
> [Severity: High]
> What happens in spi_hid_resume() if shid->ops->deassert_reset(shid->ops)
> fails (or if was_reset is true while shid->hid is still NULL and the rese=
t
> times out)?
>
> When deassert_reset() fails in spi_hid_error_handler(), the driver sets
> SPI_HID_ERROR and schedules shid->reset_work because a device held in res=
et
> will not assert a reset-response IRQ:
>
> drivers/hid/spi-hid/spi-hid-core.c:spi_hid_error_handler() {
>         ...
>         error =3D shid->ops->deassert_reset(shid->ops);
>         if (error) {
>                 dev_err(dev, "failed to deassert reset: %d\n", error);
>                 set_bit(SPI_HID_ERROR, &shid->flags);
>                 schedule_work(&shid->reset_work);
>         }
> }
>
> In spi_hid_resume(), however, a deassert_reset() failure only logs the er=
ror
> and leaves was_reset false. Because spi_hid_suspend() cleared SPI_HID_REA=
DY,
> SPI_HID_RESET_RESPONSE, SPI_HID_CREATE_DEVICE, and SPI_HID_ERROR before
> powering down, shid->reset_work is not scheduled, spi_hid_wait_for_reset(=
) is
> skipped, and spi_hid_resume() returns 0 when !test_bit(SPI_HID_READY,
> &shid->flags).
>
> Similarly, because spi_hid_wait_for_reset() is gated inside if (shid->hid=
), if
> shid->hid was not yet created before suspend and the post-resume reset ti=
mes
> out, nothing sets SPI_HID_ERROR or schedules shid->reset_work.
>
> Could this leave the device permanently held in reset with its regulator
> enabled in HIDSPI_ON and no recovery work queued?

No. The next suspend powers the device down and the following resume
retries the reset.

>
> > +
> > +     enable_irq(shid->spi->irq);
> > +
> > +     /*
> > +      * For devices that may wake up, process work that was pending wh=
ile
> > +      * suspend had reset_work disabled. Otherwise suspend already dro=
pped it.
> > +      */
> > +     if (test_bit(SPI_HID_RESET_RESPONSE, &shid->flags) ||
> > +         test_bit(SPI_HID_CREATE_DEVICE, &shid->flags) ||
> > +         test_bit(SPI_HID_ERROR, &shid->flags))
> > +             schedule_work(&shid->reset_work);
> > +
> > +     if (shid->hid) {
> > +             if (was_reset && spi_hid_wait_for_reset(shid)) {
> > +                     /* No reset response: let recovery retry. */
> > +                     set_bit(SPI_HID_ERROR, &shid->flags);
> > +                     schedule_work(&shid->reset_work);
> > +                     return -ETIMEDOUT;
> > +             }
> > +             /* HID requests would fail while the device is not ready.=
 */
> > +             if (!test_bit(SPI_HID_READY, &shid->flags))
> > +                     return 0;
> > +             error =3D hid_driver_reset_resume(shid->hid);
> > +             if (error) {
> > +                     dev_err(dev, "%s: failed to reset resume hid driv=
er: %d\n",
> > +                             __func__, error);
> > +                     return error;
> > +             }
> > +     }
> > +     return 0;
> > +}
>
> [Severity: Medium]
> On the wakeup path (when device_may_wakeup(dev) is true and was_reset is
> false), how does hid_driver_reset_resume(shid->hid) interact with a pendi=
ng
> reset_work?
>
> When spi_hid_irq_error() sets SPI_HID_ERROR or spi_hid_process_input_repo=
rt()
> sets SPI_HID_RESET_RESPONSE in the IRQ thread, SPI_HID_READY is not clear=
ed
> immediately. Instead, SPI_HID_READY is cleared later when shid->reset_wor=
k
> runs spi_hid_error_handler() (which must first acquire shid->power_lock) =
or
> spi_hid_reset_response().
>
> Because spi_hid_resume() holds shid->power_lock across the entire functio=
n,
> scheduling shid->reset_work and immediately checking test_bit(SPI_HID_REA=
DY,
> &shid->flags) means:
>
> 1. If SPI_HID_ERROR or SPI_HID_RESET_RESPONSE was set while SPI_HID_READY=
 is
> still set, spi_hid_resume() sees SPI_HID_READY set and calls
> hid_driver_reset_resume(shid->hid) right before shid->reset_work runs and
> resets the device.
>
> 2. Conversely, if SPI_HID_READY was already cleared (for example, after a=
 sync
> request timeout or while SPI_HID_CREATE_DEVICE is pending), spi_hid_resum=
e()
> returns 0 early at !test_bit(SPI_HID_READY, &shid->flags). Once
> shid->reset_work later completes in spi_hid_refresh_device():
>
> drivers/hid/spi-hid/spi-hid-core.c:spi_hid_refresh_device() {
>         ...
>         /* Same report descriptor, so no need to create a new hid device.=
 */
>         if (new_crc32 =3D=3D shid->report_descriptor_crc32) {
>                 shid->reset_attempts =3D 0;
>                 set_bit(SPI_HID_READY, &shid->flags);
>                 return;
>         }
> }
>
> it sets SPI_HID_READY and returns without calling
> hid_driver_reset_resume(shid->hid), leaving the HID driver in the suspend=
ed
> state set by spi_hid_suspend().
>
> Should spi_hid_resume() coordinate with pending reset work on the wakeup =
path
> so hid_driver_reset_resume() runs after the reset completes?

This requires an error or reset response to be pending at resume on a
wakeup-enabled device. Waiting for reset_work here would need
restructuring resume, since reset_work also takes power_lock. Leaving
it as is for this series.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-send-ups=
tream-v7-0-abad13174b43@chromium.org?part=3D10
