Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773EC3AE188
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785569745; cv=pass; b=ZIMNxdcWWw+WDZ9lR8ZqG8zjbJqbujalIDd5THm3JsvKn+OTIq5gMIFSAaAXjMygiWG/zlPp8wEjAq+L8SI5XlH4P5LrpspOpN/KoYGsvZYHjxBIN8SJu9Ew1b/HYkyGpGS6OZ0eL+wjizxgdEbKRlJlo15ztSrMOr4H5kX9hXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785569745; c=relaxed/simple;
	bh=3c7cSJmfyPQSNSMzWThpuuHDLhNHEjOoh6KtHZSmSgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJ8oU54zV1g8jOP7ssjxan/bejft0hM9pdgVk7b3LqFfwri6v/xQsCDV7bkpWJkFqyw1MmUk5YmbA0wy8642y3q/B2bEJjkNKPhtA2X3UXLp0sP+01/m977HCjqrY/cwam5rs8Oj2WjS2iej7OO895DfWuqRcoGVE/x6D+Fb+1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9DP8Y4n; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9DP8Y4n"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8485b358552so2016064b3a.2
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 00:35:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785569741; cv=none;
        d=google.com; s=arc-20260327;
        b=QNtieHSyNVGEZFNleU9hQmqSsU7l3THsMRwnuH5xVdNWVbv9KmpzrgfOwc82Bd5Ipp
         T4v7Jxe3h+TqpTK7L1qR4+syjo0ltso+aW8P6I3cmkMdBr7U01Dau6TLBXxJwkA8gyk3
         KU0iKASHTH4p0A2xKsrY0Uzojh7gj3rQDQPi+kYarX+ze1wApPzqA5hAck7ONi/ui3lO
         zqNvxKLRQaH30Qp/Yj9GtLF6Y7b24JBfttEsZt+0+j2PBC83kkQC0RXXXI0ni7R8Y2HQ
         g0Bej8jBbQyGlUadvZDzhQLSUjZ5F/zLapBI6HZt7rcfn2Y84pAXiGccpu9Yu6iuQa+g
         OP/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o7GC7J2+xwGFf+p5+42ZnMnP7uNQVjbmbvVlPsFUY+U=;
        fh=3FH17cQ2BbYCCkpQ7jJHQCsMZAh86x/6oJqamqUCDHM=;
        b=A/DGgQJmOayPS0jQn5/GvPa1VUtouwp9fNkclBzq4A5kDnejhPiCdC47RLsAurGbc1
         MKV/cDWx5psB6L2o9fYd1K1B46XAFbeDvHDnBj+yAaTLUjeduW7+MMXbhMe4P1sQOO9b
         BgM/as8k1KJNhc7o6jGr1RjXGL7JaGqkioiiYEx/gByTr0sJcdWrJYfk7AVwc7H+Ga56
         772HsTaue2xQgbulz9RHrJPetbXtYu5ujK/T/tYebWgmilOYIMZ3Zhx/d4dw6aLzwcCw
         wov7g63qAy+AfIYDgwQXRmjxsj6VWA146fC13obwySyvhnrcO8643wWloERmCL7PV3/D
         DVlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785569741; x=1786174541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o7GC7J2+xwGFf+p5+42ZnMnP7uNQVjbmbvVlPsFUY+U=;
        b=D9DP8Y4n1fuDsPcVMAq2lzrjY51iSHsHIlf8uHK2neAfTNykQRoig7Jd4Ekv/XnEjC
         lhek1J4LdV3RlcWoUAJsCziMyQNKup4mfHfPjGY2OwKbZP5X5KFnfnekhtkMqXZUORKB
         SQ6Ubb6ZBU0F6QXFoLoRoJgMchqniUYtTALmtya2964wNwls2hy8ECoWLfaxA9yrc7iD
         sBugzmt3/O9EN582nOWS1H3+JnGqeOnfXjlLk4H6TMyYPJMSoZh7I9RO7m57Xauru/R4
         PsNb1fkd2AoMqrcArurid9MXrJrJkY476L8njEf+0BxvmClGxb1GmZXsTUUutxftJ/oH
         WWhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785569741; x=1786174541;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o7GC7J2+xwGFf+p5+42ZnMnP7uNQVjbmbvVlPsFUY+U=;
        b=LryrbZeUT59EjztdCgg9mjXxUkR6MoNSRPF4joB3gKZ+Rl3ePRqE/X+zY3bHISPrsg
         2RVOReHfOHcYj1OXTsKjP+bdTwtx5ya3M+iUB1jsLCXt+Is9n8DpG+oEn7uBkRGsVb3r
         HCH27WpI+nRKeXukOkxa3/dme75RZ+vPpQK3kz0/w+wkR/MUR+uc3oCucisP6vmeR6Hz
         nqWG9VwFa/TgpaMud7eZmTPrpxBoB96NMt9Lb26hEfrwCWXpJZm3Nm6fyXLjLRAVAeMS
         ITRHYDcv34VyzFcy98mhw7rNWp1XJtfOArAPwhDub+stmIs+BF3C7b1F+hVg73ffoGEE
         LZbA==
X-Forwarded-Encrypted: i=1; AHgh+RrP6gCnUX3dMU+SItmpvF3F9Wxk94UFk9NfiITLSVk2YgEfLobDA/YKbDQBwuqQ9D/vhuYu3rS3xEcSLQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyIFxoudcfO7MURSPVaj6wpYYIT3giQQ1rPSisrdKmQ/isOJNeL
	rhRJh01sNlE4Z9fdRUKid76G/BybvAGRU+vYRHRm3w7jtQ29yPEpzKSTgnqlGVcsFKw8IKrPcvl
	au/letheYHFuHI2z6MaiIKx2R2PJF9qY=
X-Gm-Gg: AR+sD11GO+3tSgohOZ55XMbQx1G5TtzKD7HfYN0VVnCsif/1aWQzpZPsG8WyoA0c7Hq
	YFv2HQ3jXDSQ8XHOflLy0F6O3Zsrg+Y4iZEsv2RPkQ+7HE4tGYoyoy7Azq2BgC1qKHTt1ZLH0WT
	B7Wa1ZBWeTxsIcLnqP2GujR5dp4WTg7wvd8SyefFgjCum9/hP6Blzz7mGsw2L0JGO2Dmf3fm0hg
	BMl+RI0XCz64hXctGeFX2lRcJIXHmxXA24hMwUhrKg1VDwlEh4Gl/gRgLJwGgYvVkPnh8HRp7xS
	+gwevwxByZt/Je64rwD0SczIr7yYnOL73VLo2C531ZEmtbGJO1ny7Ac=
X-Received: by 2002:a05:6a00:8007:b0:848:7f56:1e44 with SMTP id
 d2e1a72fcca58-84ee47c1e13mr2202882b3a.7.1785569740583; Sat, 01 Aug 2026
 00:35:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725072813.339112-1-mapengyu@gmail.com> <20260725072813.339112-2-mapengyu@gmail.com>
 <20260725074840.615DA1F000E9@smtp.kernel.org>
In-Reply-To: <20260725074840.615DA1F000E9@smtp.kernel.org>
From: Pengyu Ma <mapengyu@gmail.com>
Date: Sat, 1 Aug 2026 15:35:28 +0800
X-Gm-Features: AUfX_mycvzhEbi1USa0PGM60Pe01VOc2MAFKX3emwizdL-PSF4E-lawyn8bpKGI
Message-ID: <CALSz7m2FcQfyR3JyrmcekT=VwbGOB8BuPOoTq4h8ycg-g9W+Vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] Input: xpad - add wired Beitong BTP-KP20D support
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 25, 2026 at 3:48=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 2 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Probe error path after input_register_device() causes a Use-Afte=
r-Free risk because xpad driver data is unconditionally freed while the inp=
ut device is visible to userspace.
>
> Pre-existing issues:
> - [Critical] The probe error path frees the output URB (irq_out) and its =
DMA buffer without killing the active URB, causing memory corruption.
> --
>
> --- Patch [2]: [PATCH 2/2] Input: xpad - add wired Beitong BTP-KP20D supp=
ort ---
> commit ec428f1a8b8e609c623920e0839f0af31cf70bb0
> Author: Aaron Ma <mapengyu@gmail.com>
>
> Input: xpad - add wired Beitong BTP-KP20D support
>
> The wired BTP-KP20D resets itself when its interrupt-IN pipe is idle
> for a few seconds, causing periodic re-enumeration whenever no
> userspace client holds the input device open. Add a FLAG_KEEPALIVE
> quirk that keeps the input URB running from probe to disconnect,
> mirroring the XTYPE_XBOX360W URB lifecycle.
>
> > diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpa=
d.c
> > index 1616047e65f5e..5369b880c6a08 100644
> > --- a/drivers/input/joystick/xpad.c
> > +++ b/drivers/input/joystick/xpad.c
>
> [ ... ]
>
> > @@ -2227,9 +2232,22 @@ static int xpad_probe(struct usb_interface *intf=
, const struct usb_device_id *id
> >               error =3D xpad_init_input(xpad);
> >               if (error)
> >                       goto err_deinit_output;
> > +
> > +             if (xpad->keepalive) {
> > +                     /*
> > +                      * The device resets itself when the interrupt-IN=
 pipe
> > +                      * is idle for a few seconds, so keep the URB run=
ning
> > +                      * from probe until disconnect.
> > +                      */
> > +                     error =3D xpad_start_input(xpad);
> > +                     if (error)
> > +                             goto err_deinit_input;
>
> [Severity: High]
> If xpad_start_input() fails here, we jump to err_deinit_input which
> unregisters the input device, and eventually falls through to kfree(xpad)
> in xpad_probe().
>
> Because xpad_init_input() has already successfully called
> input_register_device(), the device is visible to userspace.
>
> Could a local user open the evdev node immediately after registration and
> issue an EVIOCSFF ioctl concurrently? If so, input_ff_upload() would call
> xpad_play_effect(), which might dereference xpad after it has been freed
> since input_unregister_device() does not block concurrent ioctls that
> have already passed the evdev->exist check.
>

The EVIOCSFF UAF is not reachable. EVIOCSFF calls input_ff_upload(),
whose memless upload callback is ml_ff_upload(), not xpad_play_effect().
xpad_play_effect() is called later from the memless FF timer. During
unregistration, ml_ff_stop() calls timer_shutdown_sync() before xpad is
freed, so that callback cannot outlive xpad.



> > +             }
> >       }
> >       return 0;
> >
> > +err_deinit_input:
> > +     xpad_deinit_input(xpad);
> >  err_deinit_output:
> >       xpad_deinit_output(xpad);
>
> [Severity: Critical]
> This is a pre-existing issue, but this new fallible xpad_start_input()
> call creates a new way to trigger it.
>
> If we take the error path to err_deinit_output after xpad_init_input()
> succeeds (which calls xpad_led_probe() and submits the irq_out URB for
> Xbox 360 controllers), xpad_deinit_output() will free the irq_out URB
> and its odata DMA buffer.
>
> However, it does not appear to call xpad_stop_output() or usb_kill_urb().
> Can this lead to memory corruption if the USB host controller continues
> writing to the freed odata DMA buffer, and the URB completion handler
> xpad_irq_out() executes and dereferences the freed xpad structure?
>

The output URB issue is valid. I added xpad_stop_output() before
xpad_deinit_output() in the probe error path, matching xpad_disconnect().

Thanks,
Aaron

> >  err_free_in_urb:
> >       usb_free_urb(xpad->irq_in);
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725072813.33=
9112-1-mapengyu@gmail.com?part=3D2
