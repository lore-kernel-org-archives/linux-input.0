Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795213631;
	b=X4uQyKBQfgIcxHmL8yFc7acsFEqvjP3gdRrraaVs6y8bRtwwE44C/24abYNlGD9H/3Cf
	 WTgq4seqAVJF7Jb+PHGl1gHhVHZN/txsvu0rbYLMGOHzU625u8k9V+XGHh9tPKgtk/gjq
	 uooRPk31DqWLSWCxAr4/HM5aa7TwZD1cae6BKIL8G8zeiHL03fYr2DtP1MB54P05VtB6C
	 VzKqu0sRDx0uFZkzAyPUW20hG3onXEcsXeIetwF93e++RQsg+HqY8gbuAsBhU3FuglwVi
	 iZctVPxsYdjF+sYcecJJ+mVmNSnNWhbEvglM01TFz1e80ZTeufufFkaJSRR6EF8N4WA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795213631;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=sJC40Ryd2PolMbpdkwtiGQ16pRLfcNP+ySmcSLjXvR8=;
	b=MESjguzFWzf93yuhWJsaIWxw00bLdC7CdMUPziB7BkHBO0YfEyHLWH55u+els2xxjhOP
	 4TfzP8wxedCHNeveNF8Vm70N9H3tzxUNMAH293vgfGXGU3+eP/EzojF75qg0yg/HRsPOE
	 whB4IAWLZU6ZhBmFMol9WHw/2zXSvEhoWLZ7ZYZm4CQRaa8jy9E2w+vHK212MQxrbfKGh
	 Mx3prTLA/z3788r/R7Movw82X+PWcND0I81mQjofxljG/wmi055F2UV4Mb0Z8c1mpDkjH
	 ubUHK+DmoZiMMNrbHm0Na6/K46o8hVi68vRL7QiVyV+jJIjqTG3lZ62qf3E6MCtsVXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UQk6FM5+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.54
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E86606A688
	for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 22:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40E86606A688
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=UQk6FM5+
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67da7d18f2fso1592377d50.0
        for <linux-input@vger.kernel.org>; Fri, 20 Nov 2026 14:27:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795213630; cv=none;
        d=google.com; s=arc-20260327;
        b=Y1gzJkdpiVCFIpIBn159SLVw7hcP/RM4e+0hUf8bVznhj3OAIvAT1afbCvuZMxtDb4
         c5HhvwdCxTOUd68VCPxE86rnkYF/Ow5BAi4n8Rqn2WvQ3uH6DYM4Zr6AASfN9u9rtu6F
         WJnPNBJPt2eLqz1DZXrhsYs/zOoTNUMOCNpDLcqZTzWSCQBnrgtO90YHJL8RzJ6ZMlES
         FcA8IKE3rIb29NWB/QP41HjvW6t7Ou1XgEjB24u3Ns25e+1j1F0VbgM0rIusqpLyq+vj
         4ip0ol+s9rmO7x0JxRbBk9GKJiZh+VDa5QH8erOBIMIdkTCk3G3prtKahHM+vcxgk5ez
         KtOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sJC40Ryd2PolMbpdkwtiGQ16pRLfcNP+ySmcSLjXvR8=;
        fh=osfj9leewLfc4MqIYaUjfG4KfpRUNqFnByXZRUnRoVs=;
        b=sY5/yWfYUjHxxTxIIvZO+iflwlJiFPLT8aUIewIJuRwXkj9dcOAjyysBE9+DDty0U8
         GEUZg0duybNBbnxAlpZWzcTcPcTwcSSZQ2NNLJP3yXXXVANKzZOm1fmJvVxqIg9MG1EM
         piQ3YYkrigNeD7iLpJ5zrB+m4zg1QgjvjPALXvdWdSb6xkyEutbHsJ7e/UAQfxF9V7hU
         tILIBCJy/CuRI+pDEhvgPiENiflNeKHqu6GUZFqxNyipHg94MmBF6yWqNQvDKg+gET6D
         t6vOKF5zB87IuOYKyc8Gyl+ShDA4phXw1u3Ty9TiVtjffQFUsEhS1lLbGeTFIBBPb2jf
         g8+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795213630; x=1795818430; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sJC40Ryd2PolMbpdkwtiGQ16pRLfcNP+ySmcSLjXvR8=;
        b=UQk6FM5+o+UkxufhHZpQOY1DaZE/HTRDHtROlDGxniaXPynqpL9Ci0q2cTzPqaeBIj
         Fth3RB/w1AbzD2pwEEyZSs9KAUSdgYC2tOlhihGQr7OWXvSRIinEsreJh9OLud45PIl2
         lzsMU/j2ZVz8xKNfk7AnqJht1XYU8jalveVQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795213630; x=1795818430;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sJC40Ryd2PolMbpdkwtiGQ16pRLfcNP+ySmcSLjXvR8=;
        b=ZnDSIys7IgLsVDeHLFd3wTPSlwqXFwj/C4t1pQLNl8W6rn3u5ctn7AAO3WVcVpI4H4
         MBlw1JM8lMD4P3BxWY6kY+sunngleHPOhMAiSuYjILvK5CV8YBGs4HjStru+aDkiEzwN
         XJblEfTn96CJJ/vdP1JPJgeBfDgZVHlOeOXkJnjqa5aebw4fQg0DdwxxtRRGzuUEpVEZ
         rHWTzto67JdJzBRvblvWxRdb3emTL06RamJald9XW0Ezoyy/6hpqYHEq8qFcDyExS+65
         hPqH2TMJGV7IGl9czb124rSdT3nBlpfFPyWOFpdZX5ob4fBSNc0lDzIm1480UqBVodiU
         bKJw==
X-Gm-Message-State: APuU4Z/L6142g0MeodTpzlNXhNRDZvWZZwiesacNNFTQnMp1RmzwA5Q/
	+XHsSC2SQSBhtQKO1ezEjHqti/3HKq115crUiCzAUKvxvLxHpbV1l0+DIImnr0GVxhchdjZMLyk
	x+IE4zTAlQ24VXFyfTlUWSU5xZn9xPdsvVu6Kkrom
X-Gm-Gg: AZFdTZfoY7B1Gs2Yzd87ONRmHAaGyMh2D5tcW/l99EUQ/G6FVJkn8oB5wQ8C5KthoM9
	svIPdWfddUkm4KmuwFgn5uh68E2XVO+pnOYyzv7pmbMTNqx9kuxq3cVQf7wxBvS5qrIMcdyczov
	GQhJFoCrgewvZXmUP0+axdDulmgQ4K1O1RR+2aZMH2lztFdpyLAcq68850TzFXN/ngKVXPRUEc8
	QoZI520XZNVYQczIkmddWEGR5U8S0XrgnAC140x87nbcTmnX2VdjuKWzlqFQkABU+lIATpMIq9v
	jxHGg8vKSXDTvG7w76uWTDb4RuFcpewoirrnwRJ/uUEnHn6VKkT0XITMgSdY7cntU+X8jvvWJDa
	R0cRBIBPJHtRvA2r2TSrvrFnTxY/ilCJFsRSv59TeKo+BzLRfHuQaxD1sg17gbkvyNEM=
X-Received: by 2002:a05:690e:e87:b0:677:c90f:46bf with SMTP id
 956f58d0204a3-67dec4202b0mr2356631d50.17.1795213629927; Fri, 20 Nov 2026
 14:27:09 -0800 (PST)
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
 <20261024-send-upstream-v7-5-abad13174b43@chromium.org> <sashiko-outbox-183485@kernel.org>
In-Reply-To: <sashiko-outbox-183485@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Fri, 20 Nov 2026 14:26:58 -0800
X-Gm-Features: Aa3M54qZWOnlCO2Ri2HHPaWV1QD3dKmEZ7zroVjs3jsWx80nUbk_TphKVz5rLYk
Message-ID: <CAEe3GZH-+M+PJpSm7ML5AEbcz9Ti+EoFJhi7+L-=PK3L6+770w@mail.gmail.com>
Subject: Re: [PATCH v7 05/11] HID: spi-hid: add HID SPI protocol implementation
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 6:13=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
> - [Medium] HID: spi-hid: spi_hid_reset_work() runs pre-error work before =
SPI_HID_ERROR
> - [Medium] HID: spi-hid: sync requests not aborted or serialized on reset=
 in error path
> - [Medium] HID: spi-hid: duplicate reset scheduled on timeout in spi_hid_=
get_request()
> --
>
> commit 921e27cc043191cc71704b14d2cdca05f5da7a1c
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
> HID: spi-hid: add HID SPI protocol implementation
>
> This commit implements the HID over SPI protocol in spi-hid-core.c,
> adding interrupt handling, input report processing, synchronous output
> request/response tracking, and error recovery via device reset.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index 54c278ac8803b..cd4d763840098 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
> [ ... ]
> > @@ -172,17 +333,96 @@ static const char *spi_hid_power_mode_string(enum=
 hidspi_power_state power_state
> [ ... ]
> > +static void spi_hid_error_handler(struct spi_hid *shid)
> > +{
> > +     struct device *dev =3D &shid->spi->dev;
> > +     int error;
> > +
> > +     guard(mutex)(&shid->power_lock);
> > +     if (shid->power_state =3D=3D HIDSPI_OFF)
> > +             return;
> > +
> > +     disable_irq(shid->spi->irq);
> > +
> > +     if (shid->reset_attempts++ >=3D SPI_HID_MAX_RESET_ATTEMPTS) {
> > +             dev_err(dev, "unresponsive device, aborting\n");
> > +             spi_hid_stop_hid(shid);
> > +             shid->ops->assert_reset(shid->ops);
> > +             error =3D shid->ops->power_down(shid->ops);
> > +             if (error)
> > +                     dev_err(dev, "failed to disable regulator: %d\n",=
 error);
> > +             shid->power_state =3D HIDSPI_OFF;
> > +             /* Dead device: leave the IRQ permanently disabled. */
> > +             return;
> > +     }
> > +
> > +     clear_bit(SPI_HID_READY, &shid->flags);
> > +     set_bit(SPI_HID_RESET_PENDING, &shid->flags);
> > +
> > +     shid->ops->assert_reset(shid->ops);
> > +
> > +     shid->power_state =3D HIDSPI_OFF;
> > +
> > +     /*
> > +      * We want to cancel pending reset work as the device is being re=
set
> > +      * to recover from an error. cancel_work_sync will put us in a de=
adlock
> > +      * because this function is scheduled in 'reset_work' and we shou=
ld
> > +      * avoid waiting for itself.
> > +      */
> > +     cancel_work(&shid->reset_work);
> > +
> > +     /* Drop work requested before this reset. */
> > +     clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
> > +     clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
> > +     clear_bit(SPI_HID_ERROR, &shid->flags);
> > +
> > +     shid->ops->sleep_minimal_reset_delay(shid->ops);
> > +
> > +     shid->power_state =3D HIDSPI_ON;
> > +
> > +     shid->ops->deassert_reset(shid->ops);
> > +
> > +     enable_irq(shid->spi->irq);
> > +}
>
> [Severity: Medium]
> What happens if a synchronous request is waiting on shid->output_done in
> __spi_hid_sync_request() while an interrupt error in spi_hid_dev_irq() ->
> spi_hid_irq_error() or a spontaneous RESET_RESPONSE in
> spi_hid_process_input_report() triggers a reset?
>
> In __spi_hid_sync_request(), the caller holds shid->output_lock while
> waiting in wait_for_completion_timeout(&shid->output_done, ...). However,
> spi_hid_error_handler() only acquires shid->power_lock: it does not
> serialize with shid->output_lock or shid->io_lock, nor does it clear
> shid->expected_response or complete shid->output_done to abort an in-flig=
ht
> request.
>
> Because of this:
> 1. A thread in __spi_hid_send_output_report() that already passed the
>    test_bit(SPI_HID_READY, &shid->flags) check before acquiring
>    shid->io_lock can perform spi_hid_output() on the SPI bus while
>    spi_hid_error_handler() has asserted reset and set shid->power_state t=
o
>    HIDSPI_OFF.
> 2. When the device finishes resetting and sends RESET_RESPONSE,
>    spi_hid_reset_response() -> spi_hid_sync_request() blocks on
>    shid->output_lock until the pre-reset waiter's 1000 ms timeout expires=
.
> 3. Once wait_for_completion_timeout() in __spi_hid_sync_request() finally
>    times out, the pre-reset caller sets SPI_HID_ERROR and schedules
>    shid->reset_work again, triggering a second hardware reset after the
>    first recovery completes and incrementing shid->reset_attempts a secon=
d
>    time.
>
> Should the error and reset paths abort any in-flight request (or serializ=
e
> with shid->output_lock / shid->io_lock) so that pre-reset waiters do not
> stall recovery and schedule a stale reset on timeout?

The pending waiter times out and triggers one more reset, after which
the device recovers. I'll keep the current locking here.

>
> [ ... ]
> > @@ -324,13 +752,206 @@ static int spi_hid_create_device(struct spi_hid =
*shid)
> [ ... ]
> > +static void spi_hid_reset_work(struct work_struct *work)
> > +{
> > +     struct spi_hid *shid =3D
> > +             container_of(work, struct spi_hid, reset_work);
> > +     struct device *dev =3D &shid->spi->dev;
> > +     int error =3D 0;
> > +     bool resched =3D false;
> > +
> > +     if (test_and_clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags)) {
> > +             spi_hid_reset_response(shid);
> > +             resched =3D true;
> > +     } else if (test_and_clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags=
)) {
> > +             guard(mutex)(&shid->power_lock);
> > +             if (shid->power_state !=3D HIDSPI_OFF) {
> > +                     if (!shid->hid) {
> > +                             error =3D spi_hid_create_device(shid);
> > +                             if (error) {
> > +                                     dev_err(dev, "%s: Failed to creat=
e hid device: %d\n",
> > +                                             __func__, error);
> > +                             }
> > +                     } else {
> > +                             spi_hid_refresh_device(shid);
> > +                     }
> > +             } else {
> > +                     dev_err(dev, "%s: Powered off, returning\n", __fu=
nc__);
> > +             }
> > +             resched =3D true;
> > +     } else if (test_and_clear_bit(SPI_HID_ERROR, &shid->flags)) {
> > +             spi_hid_error_handler(shid);
> > +     }
>
> [Severity: Medium]
> Should spi_hid_reset_work() check SPI_HID_ERROR before
> SPI_HID_RESET_RESPONSE and SPI_HID_CREATE_DEVICE?
>
> In spi_hid_error_handler(), the code clears SPI_HID_RESET_RESPONSE and
> SPI_HID_CREATE_DEVICE with the comment:
>
>         /* Drop work requested before this reset. */
>         clear_bit(SPI_HID_RESET_RESPONSE, &shid->flags);
>         clear_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
>         clear_bit(SPI_HID_ERROR, &shid->flags);
>
> However, because spi_hid_error_handler() is only called from the final
> else-if branch in spi_hid_reset_work(), it cannot run while
> SPI_HID_RESET_RESPONSE or SPI_HID_CREATE_DEVICE is set. If an error sets
> SPI_HID_ERROR while either of those bits is pending (for example, an IRQ
> error in spi_hid_dev_irq() -> spi_hid_irq_error() after
> spi_hid_dev_desc_response() sets SPI_HID_CREATE_DEVICE),
> spi_hid_reset_work() will first execute spi_hid_reset_response() or
> spi_hid_create_device() / spi_hid_refresh_device(), reschedule itself, an=
d
> only then run spi_hid_error_handler() to immediately reset the newly
> created or refreshed HID device.

This results in one extra descriptor request before the reset. The
HID device is kept since the report descriptor CRC is unchanged.

>
> [ ... ]
> > @@ -355,6 +976,15 @@ static int spi_hid_get_request(struct spi_hid *shi=
d, u8 content_id,
> >               dev_err(dev,
> >                       "Expected get request response not received! Erro=
r %d\n",
> >                       error);
> > +             /*
> > +              * -ENODEV: the device is not ready (e.g. a reset is in
> > +              * progress), so the GET_FEATURE request was not sent.
> > +              * Don't start another reset on top of the one already ru=
nning.
> > +              */
> > +             if (error !=3D -ENODEV) {
> > +                     set_bit(SPI_HID_ERROR, &shid->flags);
> > +                     schedule_work(&shid->reset_work);
> > +             }
> >               return error;
> >       }
>
> [Severity: Medium]
> Won't a timed-out request in spi_hid_get_request() schedule a duplicate
> reset?
>
> When __spi_hid_sync_request() times out waiting on shid->output_done, it
> already sets SPI_HID_ERROR and schedules shid->reset_work before returnin=
g
> -ETIMEDOUT:
>
>         dev_err(dev, "Response timed out\n");
>         /* The device may still answer later: resync it with a reset. */
>         set_bit(SPI_HID_ERROR, &shid->flags);
>         schedule_work(&shid->reset_work);
>         return -ETIMEDOUT;
>
> Because spi_hid_reset_work() -> spi_hid_error_handler() does not take
> shid->output_lock, the worker thread on another CPU can immediately begin
> running spi_hid_reset_work() and clear SPI_HID_ERROR while
> spi_hid_get_request() (and similarly spi_hid_report_descriptor_request()
> and spi_hid_reset_response()) receives -ETIMEDOUT and sets SPI_HID_ERROR
> and schedules shid->reset_work a second time. This triggers two
> back-to-back hardware resets and increments shid->reset_attempts twice fo=
r
> a single timeout.

__spi_hid_sync_request() already schedules the reset on timeout, so
the second set_bit()/schedule_work() is a no-op while the work is
pending.

>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024-send-ups=
tream-v7-0-abad13174b43@chromium.org?part=3D5
