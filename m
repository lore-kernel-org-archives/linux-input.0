Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792631069;
	b=d51oRlDTEexh3xCM03KcU7+wPs1RdnTMII/pEHFWwQ9NTO29PynHjtD23wmthXBNGPbQ
	 QLG1r/U1KvS8IpcIJ8Sg6FBERqOTPqZYF92I8EtmtEwPR5eeqC7zPAJPRt89egsBok6BD
	 7rKkQHrjAXAH+55WYw50u8bZHlYTrIDvsRJCHHn+5VPzw+Vi6EbDJ3rQqVDAVnfEhR/Up
	 6KJ2JgLRgC1kLjB6oihPfmmbmLbY/XnGWfVwLvmUbyX7LqL7j16WbGKx77FKyB+ENt6Wx
	 0Zy0HgUb3zPkWFbAq58Qa96LjKzgsFggwD7n+gcfVe6Wo8G7C9CnT0LqIot0vZbvo9g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792631069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2N69jyScx9r+9l2VBP1mJqCRwo6k0hIdHhaFT1Otwr8=;
	b=xgYUCAk5FC/hvorwOyq75gO3tengGqXvtK82J7GOTl7a5XonhxWuxA+jVyqlwCfw1+LY
	 Vy/FHkZZN+fb5RqIkGOSbZcYPjxdzlvm9B8vPB7Jsvds8ACvhO29JVks4OzzbeTQIavwR
	 3kOXPcgX++7YTtuemeVVbmbcR5hnFQiRMgLluZEEyCjqWfdqja4j6BZ5JuhmdPRcelcsx
	 W1dUDTP2tFfKuGpY0xuReT5cCb2btOI1/ta6Kn6P6xYqHBVSab2L8w0Wmr2F75Z4qECx8
	 A3SeDoD6keZzp4+n4Ad+hlklu6ZrQwUn1H/eeabaVLPDAMjv3zhHZGj7+rRZuSRtV+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="BB/CW8sL";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40207606A31B
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 01:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40207606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=BB/CW8sL
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8ac4806e210so12859547b3.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 18:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792631067; cv=none;
        d=google.com; s=arc-20260327;
        b=H4mNDwb2GOTjI7iGfpHNrB8hbnKKnEUDTJCqkjNer5cTRnYNrkD/h8X/JqbXd2ObrY
         QjYLcIJOVMLAMvJ2Dd57+DB1XClzUlmNt0Mb9TOOuD458U6dBmoklVv8ZHBqWQH5QPVh
         ANx94dj+PaRPwmtSGvFw8/l+9HM3Vy6n/3muymqg3/riQ44IM4uLDCscjqs43i5/qO58
         8Z/3vqly/d+DuVWvZAOhGKr4IkieBxyezpsJAmy5Y+wFS660yuo6IeLosrBCeDx6KUx8
         ufXbENEUgtt3uM3X1RCqY/qkKSFPFiNQoXJDWy7z759cXcBetibpGQDWOBGFFZxUvzLA
         bNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2N69jyScx9r+9l2VBP1mJqCRwo6k0hIdHhaFT1Otwr8=;
        fh=osfj9leewLfc4MqIYaUjfG4KfpRUNqFnByXZRUnRoVs=;
        b=ECOOMYDMHOLfkS7qQ184sPP7gjW/hVfCWqUnE/h8B3xFAFfuzXAcGUKfGD+L2WqlI/
         KbfJqfxjuWfXIaQpXr//L3Ycrpu7GFPbL3F9+qAbyNJ7YEABsXT+SOl57qd84CK+wV+t
         M3dSfn9LhqT9CvbtQs0fM+smkXPeXgPY6JYC/VVlWy1JVDhiBHASVoLQinPkldDAYASG
         AT5C6C6AlJrKk7Lql95z3m5oIZ6DxVHhF3SDq8TxtpYuqFmHH2YhpB8M2grMFIHRA4HG
         uP+pm8lbYUDy17KhFx9oNVXJuMt4WV4mOC8Q5JgPw+x+6YPGtYJg5+kh4gHDiJJ50zCg
         BXbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1792631067; x=1793235867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2N69jyScx9r+9l2VBP1mJqCRwo6k0hIdHhaFT1Otwr8=;
        b=BB/CW8sLwv6KEh4sJj1MVGCADRTHOxN/SpfAZWoNHFImF1yLHDYdJtLyvy4faAYs7I
         kwSKmhS54fsqUSe+s+9tqd2ascr9+AonNPKSbj7q9JLLpkuK87pwdJKLmh1b+wGOxq+Y
         LtKBKbpXBJ8124Qgo9yr0BDHo/awgWmFRWxSs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792631067; x=1793235867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2N69jyScx9r+9l2VBP1mJqCRwo6k0hIdHhaFT1Otwr8=;
        b=Gs8jN8sv9mz+flvR4gyuFkAqgs8gZ2TJDpf2k6w3VchMxQ3nWnP0He/fOxguNwSprf
         8xmQesLWA1WSdxR3jaVo+Jm8XakoDtHFISwjovrOrhhk0skhSFbGEhbAHsdUxd3ZSisk
         I37JIj73fjlrcPrMfM8DJ5E3NJMt+cl+5caVnOW2hIq/OcLD/vVUld9QqzQPqE70Nhu5
         OKFTvI0DuWjRLAem7qgp0Mg2V3fujBP+otZDEFgdqoxx6zjU2P9+shoYphOaHK09WB2d
         dGgjwcZ+FlcdbkU59BnE4l8nmz520QHXkI2PW2jwPlGxvCvTSob9dQ+CXQMK3TpgW0Va
         aHZA==
X-Gm-Message-State: AFq9FYIMi7PIrOAZVQoxgCBtj0E6rJH+fPJqenkcs14Q6IYKWKB4r0K1
	/zBojHzwYof39lHquZDzQqgMcRtKmkQQMJU7HcWJo0Ir9x2gU9gjpowxjd4N0vjSFwW42ArJOAm
	05lI9v55/ofqRBS2xY86risuilXUvHtBY251Wj8rX
X-Gm-Gg: AYBFou3tmHlP5gYsZYhVFGNvOg9K25LfHAUnsLACRqM1j/5Kv1bQCIGDJphKB2LeGLL
	uMQfnpiA9sQHhUTd6QoYIabv73Q7wr+b27aceP1kRp3RQhgES+Qa4Y2DEmQ2XkB2dZm3k0jLVpX
	38x2JLjbFHE4zJIg0jjUY0NamzY0S/DX+TnIuREGVPAWwQ5tDcYUNf+KeOBZS6xhVlkwNAQMAFw
	wANcRHMw2/f6kuCZQYk/6g0qjVe6vOLZd0nOvEW9u8U4v+rnemABVCKt/yZxyuEzyNtUVp4mptL
	MoSy8ZeGGaiCol4cICVinOfZUzHwlrxiwHVbJIvjpHvJ+KZc999qN1Hg9cxrfhZqQeIMqBHpeHl
	CfBewG0DDgaHHAGOBU75smPb/ctzDk31GQJiXszABkf2Y2R52GtHT0GazYTFQ0tqd1zE=
X-Received: by 2002:a05:690c:82:b0:873:5c0f:27c with SMTP id
 00721157ae682-8b134011208mr24568907b3.38.1792631067188; Wed, 21 Oct 2026
 18:04:27 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019-send-upstream-v6-0-cb9ba4b3d6fa@chromium.org>
 <20261019-send-upstream-v6-5-cb9ba4b3d6fa@chromium.org> <sashiko-outbox-178141@kernel.org>
In-Reply-To: <sashiko-outbox-178141@kernel.org>
From: Jingyuan Liang <jingyliang@chromium.org>
Date: Wed, 21 Oct 2026 18:04:14 -0700
X-Gm-Features: AclHuK_7MEonbj-plERBp_u7uIfhvllKXXeKsliOj5B3dUvz_UTx7eT5kN-XFx0
Message-ID: <CAEe3GZHxqLD7n0Bg45FuVL7bkFFddTsZeX78b_oJ8k27zJRWvg@mail.gmail.com>
Subject: Re: [PATCH v6 05/11] HID: spi-hid: add HID SPI protocol implementation
To: sashiko-reviews@lists.linux.dev
Cc: linux-input@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, 
	dmitry.torokhov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:22=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [High] hid: spi-hid: spi_hid_bus_validate_header() rejects descriptors =
> max_input
> - [High] hid: spi-hid: spi_hid_dev_desc_response() clears reset_attempts =
too early
> - [Medium] hid: spi-hid: spi_hid_bus_validate_header() allows 0-length re=
port body
> - [Medium] hid: spi-hid: stale flags and duplicate SPI_HID_ERROR cause sp=
urious resets
> - [Medium] hid: spi-hid: unaborted sync request in __spi_hid_sync_request=
() on reset
> --
>
> commit 68d1db2b55c0e004ec2c06854ae93db414465298
> Author: Jingyuan Liang <jingyliang@chromium.org>
>
> HID: spi-hid: add HID SPI protocol implementation
>
> This commit implements the HID Over SPI Protocol Specification 1.0 in
> drivers/hid/spi-hid/spi-hid-core.c, handling SPI input/output transfers,
> descriptor parsing, interrupt processing, and error recovery resets.
>
> > diff --git a/drivers/hid/spi-hid/spi-hid-core.c b/drivers/hid/spi-hid/s=
pi-hid-core.c
> > index fca7a44eeb9f9..90b2c2fea6501 100644
> > --- a/drivers/hid/spi-hid/spi-hid-core.c
> > +++ b/drivers/hid/spi-hid/spi-hid-core.c
>
> [ ... ]
>
> > @@ -187,17 +350,94 @@ static const char *spi_hid_power_mode_string(enum=
 hidspi_power_state power_state
> >
> >  static void spi_hid_stop_hid(struct spi_hid *shid)
> >  {
> > -     struct hid_device *hid =3D shid->hid;
> > +     struct hid_device *hid;
> >
> > -     shid->hid =3D NULL;
> > -     clear_bit(SPI_HID_READY, &shid->flags);
> > +     scoped_guard(mutex, &shid->io_lock) {
> > +             hid =3D shid->hid;
> > +             shid->hid =3D NULL;
> > +             clear_bit(SPI_HID_READY, &shid->flags);
> > +     }
> >
> >       if (hid)
> >               hid_destroy_device(hid);
> >  }
> >
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
> > +             if (error) {
> > +                     dev_err(dev, "failed to disable regulator\n");
> > +                     shid->regulator_error_count++;
> > +                     shid->regulator_last_error =3D error;
> > +             }
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
>
> [Severity: Medium]
> Should spi_hid_error_handler() also clear pending SPI_HID_RESET_RESPONSE,
> SPI_HID_CREATE_DEVICE, and SPI_HID_ERROR bits in shid->flags here?

Will fix this in v7.

>
> Furthermore, in __spi_hid_sync_request(), a timeout already sets
> SPI_HID_ERROR and schedules shid->reset_work, but its callers
> (spi_hid_reset_response(), spi_hid_report_descriptor_request(), and
> spi_hid_get_request()) unconditionally set SPI_HID_ERROR and schedule
> shid->reset_work a second time on error:

Calling them twice has no extra effect. At worst this causes one
extra reset, bounded by reset_attempts.

>
>   spi_hid_get_request()
>     __spi_hid_sync_request()
>       set_bit(SPI_HID_ERROR, &shid->flags);
>       schedule_work(&shid->reset_work);
>       return -ETIMEDOUT;
>     set_bit(SPI_HID_ERROR, &shid->flags);
>     schedule_work(&shid->reset_work);
>
> If shid->reset_work starts on another CPU after the first schedule_work()
> and clears SPI_HID_ERROR via test_and_clear_bit(), the caller can set
> SPI_HID_ERROR and queue shid->reset_work again. If cancel_work() cancels
> the work item without clearing the flag bits, the stale SPI_HID_ERROR bit
> remains set in shid->flags and will trigger a second reset when
> spi_hid_reset_work() later checks pending flags to reschedule itself. And
> if the second schedule_work() runs after cancel_work(), reset_work will r=
un
> a second time immediately.
>
> Also, if spi_hid_get_request() is called while SPI_HID_READY is cleared,
> __spi_hid_send_output_report() returns -ENODEV, which spi_hid_get_request=
()
> treats as a fatal error by setting SPI_HID_ERROR and scheduling a hardwar=
e
> reset.

Will fix this in v7.

>
> Finally, in spi_hid_reset_work(), SPI_HID_RESET_RESPONSE and
> SPI_HID_CREATE_DEVICE are checked before SPI_HID_ERROR in the if/else-if
> chain, so if SPI_HID_ERROR is set while one of those bits is pending, the
> worker will attempt normal initialization before running
> spi_hid_error_handler().

This ordering is intentional.

>
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
> [ ... ]
>
> > @@ -234,39 +491,208 @@ static int spi_hid_send_output_report(struct spi=
_hid *shid,
> >                                     struct spi_hid_output_report *repor=
t)
> >  {
> >       guard(mutex)(&shid->output_lock);
> > -     return __spi_hid_send_output_report(shid, report);
> > +     return __spi_hid_send_output_report(shid, report, 0);
> >  }
> >
> >  static int __spi_hid_sync_request(struct spi_hid *shid,
> >                                 struct spi_hid_output_report *report)
> >  {
> >       struct device *dev =3D &shid->spi->dev;
> >       int error;
> >
> > -     reinit_completion(&shid->output_done);
> > -
> > -     error =3D __spi_hid_send_output_report(shid, report);
> > +     error =3D __spi_hid_send_output_report(shid, report,
> > +                                          spi_hid_response_type(report=
->report_type));
> >       if (error)
> >               return error;
> >
> > -     error =3D wait_for_completion_interruptible_timeout(&shid->output=
_done,
> > -                                                       msecs_to_jiffie=
s(SPI_HID_RESP_TIMEOUT));
> > -     if (error =3D=3D 0) {
> > -             dev_err(dev, "Response timed out\n");
> > -             return -ETIMEDOUT;
> > +     if (wait_for_completion_timeout(&shid->output_done,
> > +                                     msecs_to_jiffies(SPI_HID_RESP_TIM=
EOUT)))
> > +             return 0;
> > +
> > +     /* Drop late responses and block new HID requests until the reset=
. */
> > +     scoped_guard(mutex, &shid->io_lock) {
> > +             shid->expected_response =3D 0;
> > +             clear_bit(SPI_HID_READY, &shid->flags);
> >       }
> > -     if (error < 0)
> > -             return error;
> >
> > -     return 0;
> > +     dev_err(dev, "Response timed out\n");
> > +     /* The device may still answer later: resync it with a reset. */
> > +     set_bit(SPI_HID_ERROR, &shid->flags);
> > +     schedule_work(&shid->reset_work);
> > +     return -ETIMEDOUT;
> >  }
>
> [Severity: Medium]
> What happens if a spontaneous firmware reset (RESET_RESPONSE in
> spi_hid_process_input_report()) or an IRQ error (spi_hid_error_handler())
> occurs while a synchronous request is waiting on shid->output_done in
> __spi_hid_sync_request() with shid->output_lock held?
>
> Because neither the RESET_RESPONSE path nor spi_hid_error_handler() abort=
s
> the in-flight request or wakes shid->output_done, the waiter continues
> holding shid->output_lock for the full SPI_HID_RESP_TIMEOUT (blocking
> spi_hid_reset_response() in reset_work) and then sets SPI_HID_ERROR and
> schedules reset_work when the timeout expires, resetting the device a
> second time after recovery.

The waiter times out after SPI_HID_RESP_TIMEOUT (1s) and triggers one
extra reset, bounded by reset_attempts. This only happens if the
device resets during a request, so I'd like to keep it as is for now
and look at aborting in-flight requests in a follow-up.

>
> [ ... ]
>
> > +static int spi_hid_dev_desc_response(struct spi_hid *shid,
> > +                                  struct spi_hid_input_report *body)
> > +{
> > +     struct hidspi_dev_descriptor *raw =3D
> > +             (struct hidspi_dev_descriptor *)shid->input->content;
> > +     struct device *dev =3D &shid->spi->dev;
> > +
> > +     /* Validate device descriptor length before parsing */
> > +     if (body->content_length !=3D HIDSPI_DEVICE_DESCRIPTOR_SIZE) {
> > +             dev_err(dev, "Invalid content length %d, expected %zu\n",
> > +                     body->content_length, HIDSPI_DEVICE_DESCRIPTOR_SI=
ZE);
> > +             return -EPROTO;
> > +     }
> > +
> > +     if (le16_to_cpu(raw->dev_desc_len) !=3D HIDSPI_DEVICE_DESCRIPTOR_=
SIZE) {
> > +             dev_err(dev, "Invalid wDeviceDescLength %d, expected %zu\=
n",
> > +                     le16_to_cpu(raw->dev_desc_len),
> > +                     HIDSPI_DEVICE_DESCRIPTOR_SIZE);
> > +             return -EPROTO;
> > +     }
> > +
> > +     if (le16_to_cpu(raw->bcd_ver) !=3D SPI_HID_SUPPORTED_VERSION) {
> > +             dev_err(dev, "Unsupported device descriptor version %4x\n=
",
> > +                     le16_to_cpu(raw->bcd_ver));
> > +             return -EPROTONOSUPPORT;
> > +     }
> > +
> > +     /* Fail before reset_attempts is cleared so resets stay bounded. =
*/
> > +     if (!le16_to_cpu(raw->rep_desc_len) ||
> > +         le16_to_cpu(raw->rep_desc_len) > HID_MAX_DESCRIPTOR_SIZE) {
> > +             dev_err(dev, "Invalid wReportDescLength %d, max %d\n",
> > +                     le16_to_cpu(raw->rep_desc_len),
> > +                     HID_MAX_DESCRIPTOR_SIZE);
> > +             return -EPROTO;
> > +     }
> > +
> > +     spi_hid_parse_dev_desc(raw, &shid->desc);
> > +
> > +     /* Reset attempts at every device descriptor fetch */
> > +     shid->reset_attempts =3D 0;
> > +     set_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
> > +     schedule_work(&shid->reset_work);
> > +
> > +     return 0;
> > +}
>
> [Severity: High]
> Does clearing shid->reset_attempts =3D 0 here in spi_hid_dev_desc_respons=
e()
> cause an unbounded reset loop if fetching or validating the report
> descriptor subsequently fails?
>
> When SPI_HID_CREATE_DEVICE runs spi_hid_create_device() -> hid_add_device=
()
> -> spi_hid_ll_parse() (or spi_hid_refresh_device()), it calls
> spi_hid_report_descriptor_request(). If that request times out or fails
> validation in spi_hid_dev_irq(), SPI_HID_ERROR is set and
> spi_hid_error_handler() increments shid->reset_attempts from 0 to 1 and
> resets the device.
>
> After the reset, if the device responds to DEVICE_DESCRIPTOR again,
> spi_hid_dev_desc_response() resets shid->reset_attempts back to 0 before
> REPORT_DESCRIPTOR is retried, so shid->reset_attempts oscillates between =
0
> and 1 and never reaches SPI_HID_MAX_RESET_ATTEMPTS. Should
> shid->reset_attempts only be cleared once the report descriptor is fetche=
d
> and SPI_HID_READY is set?

Will fix this in v7.

>
> [ ... ]
>
> > @@ -334,13 +766,205 @@ static int spi_hid_create_device(struct spi_hid =
*shid)
>
> [ ... ]
>
> > +static int spi_hid_bus_validate_header(struct spi_hid *shid,
> > +                                    struct spi_hid_input_header *heade=
r)
> > +{
> > +     struct device *dev =3D &shid->spi->dev;
> > +     /*
> > +      * Body capacity of shid->input, matching spi_hid_alloc_buffers()=
.
> > +      * shid->bufsize only changes with the IRQ disabled, so it is sta=
ble here.
> > +      */
> > +     u32 max_body =3D round_up(sizeof(shid->input->header) +
> > +                             sizeof(shid->input->body) + shid->bufsize=
, 4) -
> > +                    sizeof(shid->input->header);
> > +
> > +     if (header->version !=3D SPI_HID_INPUT_HEADER_VERSION) {
> > +             dev_err(dev, "Unknown input report version (v 0x%x)\n",
> > +                     header->version);
> > +             return -EINVAL;
> > +     }
> > +
> > +     /*
> > +      * report_length is device-provided and is used as the size of th=
e body
> > +      * transfer, so it must never exceed the input buffer.
> > +      */
> > +     if (header->report_length > max_body) {
> > +             dev_err(dev, "Input report too big: %u > %u\n",
> > +                     header->report_length, max_body);
> > +             return -EMSGSIZE;
> > +     }
>
> [Severity: Medium]
> Can header->report_length be 0 (or smaller than sizeof(shid->input->body)=
)
> here?
>
> In spi_hid_populate_input_header(), header->report_length is computed as
> (get_unaligned_le16(&buf[1]) & 0x3fff) * 4. If a malformed header or bus
> glitch during reset produces a length of 0, spi_hid_bus_validate_header()
> returns 0 because it only checks the upper bound.
>
> In spi_hid_dev_irq(), that bypasses the SPI_HID_RESET_PENDING check,
> performs a 0-byte body read via spi_hid_input_sync(), and then parses sta=
le
> bytes from shid->input->body in spi_hid_process_input_report(), triggerin=
g
> spi_hid_irq_error(). Should spi_hid_bus_validate_header() reject
> header->report_length < sizeof(shid->input->body)?

Will fix this in v7.

>
> > +
> > +     if (shid->desc.max_input_length !=3D 0 &&
> > +         header->report_length > shid->desc.max_input_length) {
> > +             dev_err(dev, "Input report body size %u > max expected of=
 %u\n",
> > +                     header->report_length, shid->desc.max_input_lengt=
h);
> > +             return -EMSGSIZE;
> > +     }
>
> [Severity: High]
> Won't this check in spi_hid_bus_validate_header() reject
> REPORT_DESCRIPTOR_RESPONSE (and post-reset DEVICE_DESCRIPTOR_RESPONSE)
> whenever the descriptor packet is larger than shid->desc.max_input_length=
?
>
> During initialization:
>
>   spi_hid_dev_desc_response()
>     spi_hid_parse_dev_desc(raw, &shid->desc)
>       desc->max_input_length =3D le16_to_cpu(raw->max_input_len);
>     set_bit(SPI_HID_CREATE_DEVICE, &shid->flags);
>     schedule_work(&shid->reset_work);
>
> When spi_hid_reset_work() then calls spi_hid_create_device() ->
> hid_add_device() -> spi_hid_ll_parse() ->
> spi_hid_report_descriptor_request(), shid->desc.max_input_length is alrea=
dy
> populated with wMaxInputLength.
>
> When the device replies with REPORT_DESCRIPTOR_RESPONSE, spi_hid_dev_irq(=
)
> calls spi_hid_bus_validate_header() before reading the body or knowing th=
e
> report type. Since wMaxInputLength is the maximum length of input reports
> while wReportDescLength (up to HID_MAX_DESCRIPTOR_SIZE =3D 4096) is typic=
ally
> much larger, header->report_length > shid->desc.max_input_length will fai=
l
> with -EMSGSIZE and trigger spi_hid_irq_error() on every attempt until the
> device is aborted. (Note also the comment in spi_hid_find_max_report() th=
at
> some devices set wMaxInputLength to an inaccurate length.)

Will fix this in v7.

>
> > +
> > +     if (header->last_fragment_flag !=3D 1) {
> > +             dev_err(dev, "Multi-fragment reports not supported\n");
> > +             return -EOPNOTSUPP;
> > +     }
>
> [ ... ]
>
> > @@ -365,6 +989,8 @@ static int spi_hid_get_request(struct spi_hid *shid=
, u8 content_id,
> >               dev_err(dev,
> >                       "Expected get request response not received! Erro=
r %d\n",
> >                       error);
> > +             set_bit(SPI_HID_ERROR, &shid->flags);
> > +             schedule_work(&shid->reset_work);
> >               return error;
> >       }
>
> [ ... ]
>
> > @@ -397,9 +1023,81 @@ static int spi_hid_set_request(struct spi_hid *sh=
id, u8 *arg_buf, u16 arg_len,
> >       return spi_hid_sync_request(shid, &report);
> >  }
> >
> > -/* This is a placeholder. Will be implemented in the next patch. */
> > +/* Schedule a reset to recover from an error in the IRQ handler. */
> > +static irqreturn_t spi_hid_irq_error(struct spi_hid *shid)
> > +{
> > +     set_bit(SPI_HID_ERROR, &shid->flags);
> > +     schedule_work(&shid->reset_work);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  static irqreturn_t spi_hid_dev_irq(int irq, void *_shid)
> >  {
> > +     struct spi_hid *shid =3D _shid;
> > +     struct device *dev =3D &shid->spi->dev;
> > +     struct spi_hid_input_header header;
> > +     int error =3D 0;
> > +
> > +     scoped_guard(mutex, &shid->io_lock) {
> > +             if (shid->power_state =3D=3D HIDSPI_OFF) {
> > +                     dev_warn(dev, "Device is off, ignoring interrupt\=
n");
> > +                     return IRQ_NONE;
> > +             }
> > +
> > +             error =3D spi_hid_input_sync(shid, shid->input->header,
> > +                                        sizeof(shid->input->header), t=
rue);
> > +             if (error) {
> > +                     dev_err(dev, "Failed to transfer header: %d\n", e=
rror);
> > +                     return spi_hid_irq_error(shid);
> > +             }
> > +
> > +             if (shid->input_message.status < 0) {
> > +                     dev_warn(dev, "Error reading header: %d\n",
> > +                              shid->input_message.status);
> > +                     shid->bus_error_count++;
> > +                     shid->bus_last_error =3D shid->input_message.stat=
us;
> > +                     return spi_hid_irq_error(shid);
> > +             }
> > +
> > +             spi_hid_populate_input_header(shid->input->header, &heade=
r);
> > +
> > +             error =3D spi_hid_bus_validate_header(shid, &header);
> > +             if (error) {
> > +                     if (!test_bit(SPI_HID_RESET_PENDING, &shid->flags=
)) {
> > +                             dev_err(dev, "Failed to validate header: =
%d\n", error);
> > +                             print_hex_dump(KERN_ERR, "spi_hid: header=
 buffer: ",
> > +                                            DUMP_PREFIX_NONE, 16, 1, s=
hid->input->header,
> > +                                            sizeof(shid->input->header=
), false);
> > +                             shid->bus_error_count++;
> > +                             shid->bus_last_error =3D error;
> > +                             return spi_hid_irq_error(shid);
> > +                     }
> > +                     return IRQ_HANDLED;
> > +             }
> > +
> > +             error =3D spi_hid_input_sync(shid, shid->input->body, hea=
der.report_length,
> > +                                        false);
>
> [ ... ]
>
> > @@ -479,6 +1177,8 @@ static int spi_hid_ll_start(struct hid_device *hid=
)
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-send-ups=
tream-v6-0-cb9ba4b3d6fa@chromium.org?part=3D5
