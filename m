Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5CB46C82A
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 17:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247806; cv=pass; b=YF9ZQZ+HEzuqGdCQhiCZdqpTQ0HMHpPako0WTrJLX0OSRXOvPe0Z4LtFpdBxQrVayhm9s88rnWLbHi7k3s54o4JkiAHBosyU3h4LUTHMsz31ZuRNMykhgq77u7OC6c/dyqWzeFbrbXU2l/8MbbO5dydDvVoWQPRwJlUD0v7xd24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247806; c=relaxed/simple;
	bh=MQi8gDLxZ00zQxu8L8w6TUjdhk0EmiUxnn8U9Ksso/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IALZUS77N/pJzxAbHR65I3k9WLFMImtj/yPaBKOBECCSocHaQPlXixGNKqXR6BM5Hx4s7LiIvEQLnEe2J7/Zp+l42Z43mTG9gYiIaDekk1l9icL4+hWawLapFJWX4kRqagGARDezPcvsi2nXJ98/LLUzYmcH7u/BSlT+LLVnsZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=eFf/SBTE; arc=pass smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="eFf/SBTE"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-448b69cfc6dso66002fac.3
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 10:43:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787247802; cv=none;
        d=google.com; s=arc-20260327;
        b=RfNUBmIGF03JAZsEY7EjejZ8PI0wg088kGOvSa/IDrOw/2fayTKoZ7xuifWNlWjS6j
         PezQWp01c7UqbZ/EdDnTFffzNA8gbnGt9PY+kPs1S2IayFrF7xf84Z9APXySqlf7mA8l
         ZrmeVtlYrdfQaJeVhowL9Abw/nEXDgx0qtgO1xH/pk5ynDUXKs4OdNfXY5NIIug4kO0N
         RN5jxlHRr7d53WMH+pT6pFYKgEUZQYOmpAJa7bEWvEIRQQbJkn+HazhgfELRN3kiZE+m
         JvAf1UoWxWEBIncZYodjFKWxttsblS/q0hgMb1iJDnDUdlPabbHBcGs1G9/7eDGXW459
         iOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=7eL6FQ/USBPX2RQ0Gd6bBRBvrCoiJLr6erKFtCfBdHw=;
        fh=PTyic5uMP6w+v8Fm8KoqZ32rfUzVBy/1Ol/aNVLN2LA=;
        b=AY3yM6OxNs8jRIdTt3Xk5YWgAR2oig/4bsh5vkRKIikN9H04Ajt+dQbYssKOAv6ut1
         ZWQ2yzBWLDiojsCAsUh/k21eMLjPA3ukEdRBxqhfpp596VjFPTDNDaKoGPwOczTFNwdh
         sFSS6HDoPnskq4vLePhSeBiU0GLde+wL3nj9iurVA7e9Rw58UIHw2/ccGOebBfPHaiEm
         uJMm5Do2aeO/hVXAB/f/nGe5od805+C27z6HaCroj/uGTDkcsLDcat68r600uxIn3ocr
         F8BFuxKDACkPUAAjYclYcZkUs32Vd5jVHpPL5uKCTF7AkwuDTI1zFdk1gOycDoOYpycY
         M2wQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1787247802; x=1787852602; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7eL6FQ/USBPX2RQ0Gd6bBRBvrCoiJLr6erKFtCfBdHw=;
        b=eFf/SBTEj8l731GxDy6oOoKJ4N+lIITJ5ScK6m+N++KHtWMZy5QtbaMVFHruviKkZJ
         BGujtBxO4GtFq2m76uweAnqxHF0tUk3EpRiz4ub7KGB1AJi/7eZUJxiohTNp9ptsP8kt
         N7w/mC3IgRE2qbu7f3wDhbXpm6i9gZC0Skn2YDQsqfQ7RmS+2/67M8rq9642NOauCZMb
         OivKuiAjyDjzftMYsRZcJHEM+8VsQ+K0yaNwfxDkieLN3toD5ycfEqEurGieKYADrgpA
         7aQYNooj6AUpoIpy67qLqnTteIvajo13zDLjEYeTMMSzrv2noJFQ3e/9a8uGs3nIIkRT
         KAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787247802; x=1787852602;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7eL6FQ/USBPX2RQ0Gd6bBRBvrCoiJLr6erKFtCfBdHw=;
        b=PNuGlVq42fe0FVr/3CCmaNm78NWPSg/ZYiAsVnZWKyHmt0jJdlne3jOtpeh6LOI7Ja
         dyhP1T/Fb8BXIMQqya7CD8ql6jDdR1uF1jCfpNHJPuhiT/ZYLzskoraTtPmS8Km6wtBL
         ddN3KaennsDOS6j/YG2R/25CZUJsJNKy9fYumX22jUdyNDI8HlCU9ka8SNcrtSNtIe2B
         7CPt6OwQ1+62CD7IOsj0rlvln0iC6XnJ8m/r7mB6BRJCiToiqjGo5Vzfe+NKCoCEIHi3
         XRH6Y22TTezoAEhLRPUEK+QedF3xW669dPwRoP09jqmyHYFxcsUOaljT6e2HZHJT+Ini
         WUvw==
X-Forwarded-Encrypted: i=1; AHgh+RoGnyomlHHzhDIYMWT9Pg44irbMGUmhuvsuwBU0RkTP+NBWIrVtOOI9pil59jI+wDG8Ae/pHAmxbJQeDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwP6VIPh1DgOoyt0ocxXQAkfPa+kuhfnOsfr6YR+xUka0UqAa8I
	7bHBd3O/e7/iAoC2p8kayKJisgHuXbVopYuGHQQEdxbzrkh4yTEhaV3XDy7Ey5oRNsI5dOUG1Kl
	jEK9C6NczdT55Hogcs0eaIhDQT5Yd4MExoW4aRW2ATA==
X-Gm-Gg: AR+sD12K0DfL/ZPXTplpwmZUjtJB3DAxI9Q/IY+6o11lirUZ4JaFA3dURoy+N3PAtfW
	ET1cGGL3rtoAl54Kp/3mDbeVKhiszZpBYUQdMhbJUXz16nAhJW7uBJGrwHCprr6TvIVWkcMCYpS
	auIEKaHKYGsymycEvTfdr1A1asQeaY+i537E2o5uvbN7rlg3SRXT0f73ybWfAx2he+qMUFcj3Kj
	gtkhjKSHaHCHquCdJCLCI1SxvB89KY5Gp95YF+lc5q1Qw8FqH46RTVToOkJ/FqaVxjFtNEQ3o1O
	MYvk2wWlQJ40Pm/j3sfZeEgtPMc3u67Mv16rXTeetZwa0+CJbMbMjOfQdXizCbWulEr4Q0ivlXF
	R6mNg5Ex/Ou4yGrfoP1cAI7B2FhffpY7HatdxmQhxjDTTyIVGvlGVkI9UuA0x
X-Received: by 2002:a05:6870:610e:b0:45e:de9f:e019 with SMTP id
 586e51a60fabf-462f69bebc7mr14233259fac.21.1787247802475; Thu, 20 Aug 2026
 10:43:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820065340.3765457-1-gonglinkai@kylinos.cn>
In-Reply-To: <20260820065340.3765457-1-gonglinkai@kylinos.cn>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 20 Aug 2026 18:43:05 +0100
X-Gm-Features: AcwNN1W2Lre5-E7B9PhxwavzSSjkrGP8rkzlLuGb6eam34DkKNdWQZ4y079Jp24
Message-ID: <CAPY8ntBO5Rk6dEcRc9SgYKpgF6=KBxg7STpLT02whQ8pY-BW0w@mail.gmail.com>
Subject: Re: [PATCH] Input: raspberrypi-ts - reject out-of-range point counts
 and slot IDs
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Nicolas Saenz Julienne <nsaenz@kernel.org>, Rob Herring <robh@kernel.org>, Eric Anholt <eric@anholt.net>, 
	linux-input@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Linkai

On Thu, 20 Aug 2026 at 08:29, Linkai Gong <gonglinkai@kylinos.cn> wrote:
>
> rpi_ts_poll() copies a firmware snapshot and walks regs.point[] using
> num_points. The array has RPI_TS_MAX_SUPPORTED_POINTS entries, and the
> GPU is documented to report 0-10 points (99 invalidates the copy).
>
> A corrupted count would index past that snapshot. Slot IDs are a 4-bit
> field (0-15) while only 10 MT slots are allocated. Drop the whole frame
> instead of clamping, so a bad report cannot update a subset of contacts.

This touch driver is only used with the original Pi DSI display when
used with the legacy, firmware driven, display stack. Raspberry Pi
have considered that display stack deprecated for at least 4 years.
Our guidance is to use the edt-ft5x06 driver alongside the vc4 DRM driver.

TBH I'd support dropping this driver entirely. Will anyone object if I
send a patch to do that?

> Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkai Gong <gonglinkai@kylinos.cn>
> ---
>  drivers/input/touchscreen/raspberrypi-ts.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
> index 841d39a449b3..bd63d95c094b 100644
> --- a/drivers/input/touchscreen/raspberrypi-ts.c
> +++ b/drivers/input/touchscreen/raspberrypi-ts.c
> @@ -78,6 +78,7 @@ static void rpi_ts_poll(struct input_dev *input)
>                  ts->fw_regs_va + offsetof(struct rpi_ts_regs, num_points));
>
>         if (regs.num_points == RPI_TS_NPOINTS_REG_INVALIDATE ||
> +           regs.num_points > RPI_TS_MAX_SUPPORTED_POINTS ||
>             (regs.num_points == 0 && ts->known_ids == 0))
>                 return;
>
> @@ -87,6 +88,9 @@ static void rpi_ts_poll(struct input_dev *input)
>                 touchid = (regs.point[i].yh >> 4) & 0xf;
>                 event_type = (regs.point[i].xh >> 6) & 0x03;
>
> +               if (touchid >= RPI_TS_MAX_SUPPORTED_POINTS)
> +                       return;
> +

Can you just abort here?
If this was with i > 0 then there has already been 1 or more
input_mt_slot(), input_mt_report_slot_state(), and
touchscreen_report_pos() calls which update the device state.
True input_mt_sync_frame() / input_sync() haven't been called to
report the event to userspace, but my gut feel is that the next poll
won't necessarily reset those events in the device state. I'm happy to
be corrected by someone who knows the input subsystem better.

  Dave

>                 modified_ids |= BIT(touchid);
>
>                 if (event_type == RPI_TS_FTS_TOUCH_DOWN ||
> --
> 2.25.1
>
>
