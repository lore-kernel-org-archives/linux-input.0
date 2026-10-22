Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792651128;
	b=xwfGBNSv7J7VYQ8gVWnthSnsRaZI2sz6CqM82WFkqZLPRYJ1XLkDe+SbDGyW+G5L5oDM
	 7wCJnz/ju6y1OiOHoddqC/GWdrUokXfgc4JMpUK11DvVOAEpWw07U8Q21Krkhh1P0Mz4q
	 U/79gEC9w9/vqI5wNb4Rp3Krk9qoXeqND5ghsI3S6WpcYFVgyTekeHnCiENLPZn9HoJyT
	 PWQagbCtVTv1wFsN0tV5UhxroM4/nRHKb65gpA8ZvIFksQihmOfUKN4y0L/9K+pqTycKM
	 SGAEmMmljUnjySOwpi0pY4dwi9Xj82SOR1We8YH6YUldOi6lspJgwghrPXg/3zNLjZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=aQznmrBcOzLH4jRYZXZQn3XWbZhhtR15oZ4OwTFZX2A=;
	b=cuRDtZYd05OpqqZ+NnI9eCtYCScTW6wx7YVraXeuzjpaICOgrYMoUVc2kWpuETKv2mN8
	 xZSb58YAIXKhTF6Db9me9zjKn2dyqXcE79nFQbyz3scsGxwtuymR3HITYTVnWaMGlG5y2
	 3BW9IPw/sNzp6412wTHMAr8VvcRNp09wM2MfymV+G1R72TjFq67kYaaS2gQ++TosZZjQC
	 dS3VTclwGcexh1oalR6fJtXdlTirhKCs1lLn8mBaKJcnZp5MI4/fnsSUyw6RnACmJeyka
	 9GaLC5tMN+GRHsXVmS2quX1R4nW/3AwTs9hRRZ4dU9ZV4RUuTlWRsxyoT5LUwWadxOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vobcu7tv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40958606A319
	for <linux-input@vger.kernel.org>; Thu, 22 Oct 2026 06:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40958606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Vobcu7tv
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bccecba199so1413849e87.1
        for <linux-input@vger.kernel.org>; Wed, 21 Oct 2026 23:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792651126; cv=none;
        d=google.com; s=arc-20260327;
        b=mGz0PYthSwJp4kP2V19tON+XtDWwHJKAySizElRI/ZM0j/DrYsKJpyqHVHyhml6rm0
         6jX5rvPOJv6SlbSPJN3NIgg0cNWbeSkDRbtLeHkZrUHWnzNxD7cjAUNvzhXpyzOverS8
         nUNjYD0v0sK/S3aD7lQDcBkV+PPN5duVarw9j0T5ZizuxvBlUet6NA3ClWTM8L+T6yKx
         JlZRHFDucHtAjvYFDkw1NwBQ6creiMQiTaIONcielUMVXtdk8kxV/5LU7kO9MbeT3TVZ
         KKRp3BhQb4JwEsIImmWl2hQbTbjMtKI7rbenLkh8PKInH2YMq0rlf36n8P/iVtaYSNdO
         bK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=aQznmrBcOzLH4jRYZXZQn3XWbZhhtR15oZ4OwTFZX2A=;
        fh=NSgzkeHIZ8n5u3UQTELtvs2rL2gofNpFvXaV2CQ81vA=;
        b=h8ZyYJN77t/dJ5drjQNXIw0UeLjQqGSlReby9kRTHSjKn202GlzFfKyP3hW1TwiBKh
         FDPcWazpoF7qtLpoKmD7gnqz4C557l5qHIFt6FMhLjVLRTt02JC1Uukvg8a+K8bfZxWw
         hicMG1+r1ajMM8XFUNlwVJ9zlB+ushfQT2N87Q3AMGV1qW3sSrGG82tjaS3ytyrO6BJ3
         HtBIUlDJ3mC1Fgce4h/aihaudew7z30wDo7QaKvP20+hII15NE9oxl4LqEejvXaSsI/M
         Gzckr1OSmhAUKJZUrPHlOGSWmbIe5O2IwsmHd5bckRZJMwsruds/45U4a0CF7WBILrG9
         h0Sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792651126; x=1793255926; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aQznmrBcOzLH4jRYZXZQn3XWbZhhtR15oZ4OwTFZX2A=;
        b=Vobcu7tvQuS5Bv3L8Kf3PgLL4yEGtz0NbdmswDEhm85ydC8uk14Ww+hl9c9lWQDaow
         9UaJO1UA8jFabMvF/fqIFsoYJSZzqZZhokX6YUvjwzzovdUAZju/Kj73zmqVD8FzKv0w
         zn8mrxOYh5r3cSd88po20+EC1HRXVnc2MLcSdsg6y5FWCDM9se6YaujQe6nfdjdETtGd
         L3ROe8yMXClq53TZCWNzPVeXu0ywnbFIT/HRthqXcUebcD2RFRyem5AADsFWEEhL7R8w
         nXtHDizXsVH5XpCtG6QQUEM8WM0xN2PeD5q6NEfnBYyvIQg/hXBioTNclNZbNYL20o6x
         WjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792651126; x=1793255926;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aQznmrBcOzLH4jRYZXZQn3XWbZhhtR15oZ4OwTFZX2A=;
        b=fuV5jWLyqRIOAVWwoTSV0EYC9A6xWfXDhfSuxf0Aia4sP6UZ6hu2s12tV6bymolnl2
         yXrHMM0+wUpq1AP6bJF87yr1fYnsucdxQaBvGvFHBfzT9eNfM7cmNu6lAHN7wdLY+wW0
         Z2YQdZxyca49GQ1h6ukHC5icrGzeqM3WhT02DZKwCVnFa2zG/nUWGYcTef9LYMvvfOTM
         l3zWNho6gqRT1gukgpFXYs3odFLATrgcbt/14RUnf4sklFtNqX9RaWq5+4QLv+vQ0Z4V
         EwCWsksgTPXKU9RgHgGUd7xw2Hr/XPS9OrcLX7ooQXc50EDes074ZJPLa7JtXw5ztVLH
         Kb1Q==
X-Gm-Message-State: AFq9FYJEfbjzIruWv7OZ5GGvezd+ukyxoqpu5kIW0usLL7HjLAUW3Irf
	vdrYlmZ18InSVmLrYKndIX98AGhXak2NNQz7/3PWOLypbSMNT8R8YNSiJI7T6TrrkIAHeAXiFMZ
	ISRB0XfwXv+gm6cg4NYpbqQ7CtGxeOzY=
X-Gm-Gg: AYBFou0UdhiXs4ZzNrr20vVwHF4QRmhvYA/GYouZR7S6WcSlo/WlOmsOx3MLpPTEZWm
	+AmyNVx1kuJBKN3ClZenDf6psq/Fa+9eGGR3lzE+xK3S5qPWnK1CWu/GXnfCRCvY99abDd23pqM
	GKPhEO2J7LftFpptmohu7IyqCQYpnIQ3Gcy6j4Pdv6Tp2r8r8i+9klMoVj/suw6c+TPaNSqHA3g
	xDgScELUHH2crdB8UGU4hbv1Wa20+l3uWrEb40Vu0M1CEHBwEQoUZzxN8JUI7vzTwslFoBxGW9S
	wlNAGQKeqcz5kEL3754q86puBnNtLnCmElpHbzL8TMODy2XLoGYZAgTDzDmYTkHDwFHpbld1+3y
	MAmUU+IWBEXe8P/T/D8MlD6LTcAloxU5WMvgIMNQzwe7tYKcdcZiqqLE=
X-Received: by 2002:a05:6512:3f08:b0:5be:4ed3:95a5 with SMTP id
 2adb3069b0e04-5bfa1bf964fmr1830849e87.42.1792651126147; Wed, 21 Oct 2026
 23:38:46 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 21 Oct 2026 23:38:45 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 21 Oct 2026 23:38:45 -0700
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <ataOD1M2R_6mFJKi@google.com>
References: <CAN52AYvyTzrAnreG8iB_a9WFeOxUsvkTHgaVaaU-+A3_pRMe-g@mail.gmail.com>
 <atJz_OR-rIVb-RDW@google.com> <CAN52AYs19_b749avEjT-1ZaNZs6qp+3YyTHJgxRiAJTLyhJedg@mail.gmail.com>
 <ataOD1M2R_6mFJKi@google.com>
From: Jame Jao <jaojame6@gmail.com>
Date: Wed, 21 Oct 2026 23:38:45 -0700
X-Gm-Features: AclHuK_RnM07CT-aEGJ4sBFRTBefBTKdKdRQB1r22_DzSOTeQDGxmnYunlcLJ9E
Message-ID: <CAN52AYsVUtLLw3JEzvMSHFJniN7DdYfe8HypVUkPPw_UoHzA9Q@mail.gmail.com>
Subject: Re: [PATCH] Input: atkbd - skip deactivate for Xiaomi Redmi Book Pro
 14 2026
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

Eason is the nickname I commonly use, and my formal name is jao jame.
The sender and the patch author/sign-off are the same person.

Thanks,
jao jame


On Mon, 19 Oct 2026 14:40:31 -0700, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Jame,
>
> On Sat, Oct 17, 2026 at 01:03:47AM -0400, Jame Jao wrote:
> > Hi Dmitry,
> >
> > thanks, the quirk works.  Patch below; it is also attached as
> > atkbd-tm2426.patch in case anything gets wrapped on the way.
> >
> > Test setup: Xiaomi Redmi Book Pro 14 2026, board TM2426, BIOS RMAPT4B0P0909
> > (2026-05-21).  Arch linux-zen 7.2.9 build with this patch on top; the only
> > other local change in that build is an unrelated platform/x86
> > suspend/resume patch, input code is otherwise untouched.
> >
> > With i8042.dumbkbd=1 removed from the kernel command line and the quirk
> > active:
> >
> >   uname -r        7.2.9-zen1-1.2-zen
> >
> >   /proc/bus/input/devices
> >   N: Name="AT Translated Set 2 keyboard"
> >   P: Phys=isa0060/serio0/input0
> >   H: Handlers=sysrq kbd leds event3
> >   B: EV=120013          (EV_LED is present; dumbkbd used to give EV=100013)
> >
> >   /sys/class/leds
> >   input3::capslock  input3::numlock  input3::scrolllock
> >
> >   writing input3::capslock/brightness 1 then 0 round-trips, and the Caps
> >   Lock lamp follows the key again.
> >
> > The built-in keyboard produced 127 key events with 34 distinct key codes
> > during the test, so it really is usable without the workaround.
> >
> > Minor observation: the two "Spurious ACK" lines in dmesg come from an old
> > local userspace helper that pokes /dev/port for the LED; that helper is
> > redundant now and I am removing it.
> >
> > From: Eason <jaojame6@gmail.com>
> > Subject: [PATCH] Input: atkbd - skip deactivate for Xiaomi Redmi Book
> > Pro 14 2026
> >
> > The built-in keyboard of the Xiaomi Redmi Book Pro 14 2026 (board TM2426)
> > types in GRUB but stops delivering keystrokes once the kernel has booted.
> > The same failure mode is already handled for the sibling machines
> > "Xiaomi Book Pro 14" (TM2424) and "REDMI Book Pro 16 2026" (TM2425) by
> > skipping ATKBD_CMD_RESET_DIS in atkbd_probe(), which the embedded
> > controller that emulates the PS/2 keyboard does not survive.
> >
> > Add the TM2426 DMI entry with the same callback.  Testing without
> > i8042.dumbkbd=1 on this machine, the built-in keyboard delivers key
> > events again, and the driver now registers the LED class devices that
> > dumbkbd used to remove (input3::capslock, input3::numlock,
> > input3::scrolllock).  Writing input3::capslock/brightness round-trips and
> > the Caps Lock lamp follows the key again.
> >
> > Tested-by: Eason <jaojame6@gmail.com>
> > Signed-off-by: Eason <jaojame6@gmail.com>
>
> Thank you for the patch but why the From and SOB does not match the
> sender?
>
> Thanks.
>
> --
> Dmitry
