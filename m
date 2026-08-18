Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA005442364
	for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787066176; cv=pass; b=YjHxx3iseYexE7X3btCVRvnlGpaN/9/Ds4ra9i0QYg8EAhtj1PwQe6Jms/4ZKuiUh3fmU3Ok1wzQnHg0XHZf0K4fZojpZnkkjnuioVt50E+woUBESRdAC0+wG+AtI9rM1PUN4XrY/v6+cpFyXuEnktxKltLhc8QN9weOhVNWkYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787066176; c=relaxed/simple;
	bh=eGJJab867uvsf5NclkUXMme04KoVj5RHsKjaewfMaLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9KGM2j0UBPROXY2nQEs0SwGihttei5sYIpAWATyvFcHg9YtdvR0zZ3Wyy9fKZevw4OufSBWHRKhF4n+6FginZpmv8ynAttstZP46aDGFkzaTJgSt9YeT5eoUgTdCz1dA/bgq9HdzYGfVRYNX2QHDuc1PGhFYrAoC3y70FmbKOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KSTSGVi0; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KSTSGVi0"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aebd52488cso5089409e87.2
        for <linux-input@vger.kernel.org>; Tue, 18 Aug 2026 08:16:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787066173; cv=none;
        d=google.com; s=arc-20260327;
        b=ZPw2LuAGLbo2THm25zrNkMyp2npzzxnkajhQcTBPECoSEh3JojUOCFspkGm3mZUWmr
         R0/4Mj51GUMcr0NwhYb0ckAel6S0LVGihDKrZKaQ8cOmG7b4HiyimVos54ytJHgTUr6F
         KcS0NIdCFlGUf0pCFBiJGkJa8ym3LhfNWZMVyyf++zCnbVgRyD2g1StrZlv32+7jB0QV
         JHa4XDpXCnD0V7im24zHgPHwH3n52bwzdc0X09V+bu1BGSG1ykcVF0Ta0LWR0j3/N4gI
         fcRWWp3Yj8r91OTtS6S6o0UiRlxtCWWe/TLDcKao4zxRGCrVAxn65zyWS5q5sTX6782V
         2oCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1RDa5zFrmqkniYcgR8oSaFQpVXG5p0Kn0ZxoS4csmqk=;
        fh=KJDsuZc2hDgs0zzggoD5hRVRx7Jknx1/PxCQliBAUyg=;
        b=gpa82fq8P3F82Zkz2PctmQOW8w+D3KyPsBzIuziccHSlSA/SuB08wSnOhk8Ga7LyKp
         6R/05JXKtcnnechwZixjZ3whiH4TIhbbW/mPn89ZQJSeORR59L9ow5TXTLE1ag6pNPPs
         +ywUI9BvA0PjqA/jCQTXCMTYyPxh6LbfYoG1hXK3kh8k4Obja8a0tPnKCLLNtYcG8ZmI
         TOeOpDjIXBPhlfegRmaq4ZzQPFIRNvtiJvEqe+GkwFWhpT8DK50z+03zNf8WXrvVlPh3
         ga8jtzOzEQdBLy+G0Q5XZRB5Ert8s416WB/ExsmImDUdFPbBZDo4+puKc0DQaCHicaQI
         saJQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787066173; x=1787670973; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1RDa5zFrmqkniYcgR8oSaFQpVXG5p0Kn0ZxoS4csmqk=;
        b=KSTSGVi06AeOrWhuD5SNNqKma7PdheNjopY323hUmvKXGu3QnMsHiLVDuZCD88IkW+
         Th7MGN+IZHX+LzpCEDPEq8BmzCN6QUTBjHwFvOiW63SVjEVsSwc/+ldqYzEmu7dc1a60
         9sv34njGvyZg1XiKuAWWhTDzynNtxGlLgKTmwHCvvzCtTy9D85tBNlhz9lEiggh0IsTc
         n+DwlNclx6geL6gTFgN2QbIAv3QUpEcLrl6R7Cm1Sa3IgfSYAQKOEbpoqWd1LyB3ylC4
         +Qf1lrGr3ONi4ifWRlgrUWL1ENIqAYT7yfLJfrnb+cGo61IQl40+QdV8rRioZ4oiHw/X
         ebbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787066173; x=1787670973;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1RDa5zFrmqkniYcgR8oSaFQpVXG5p0Kn0ZxoS4csmqk=;
        b=dmUdDim/L8tYV8eKbAOgztBMgZes14tnNfl7Qcc5K38HOmP4dVCtat2UYnX/+7RSEY
         sFnKqzNza/bFjpr753BfF+79yhS8Qw5iBOL2fjd1fJfn6bcwgevnxRXpTfoYzsVL0aBI
         MsCouF4KPsJ50L97r8f7XAYKKNd5FvV5ihi3frPDLVkNNUtTi6irO5IXCYUMkma9SMkz
         iq+ioXYsbJsNNSqd7RrWTCh0Rl9FU8RuMEKjHEKpq01Cqkhwg/ZpthaqkWzOc8jODgXp
         55H3VauYYSda88mloBsVAu+nmVcABS69NJZgVK47Co+CzABdyW6ZOfEbrTyHKcOXvGK8
         dssA==
X-Forwarded-Encrypted: i=1; AHgh+RqhZqClFHRHbhlvsIHuRjyfnXmW487DJpk/c/y3jx3A0sl89BZnqpdzW8A9LXRM1qAVFxj1IjdUgWdehA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3kXl5Ty/TIhG4PbTJv10oXkCe5Tiop99bxDOTPGqOxAau8qal
	xd5324cvssqq6/5spTXl0b9Vt9IZrDSxkjNSiRhon0uvK2tGq8PX/5viU6moabhO53cjZGcjDH5
	b7mGTWyQAU3Op3w0kXHzqFJf4OnMnsWM=
X-Gm-Gg: AR+sD10GV9IfLFwmoPhFHe30xR2QCr8jUG5TrHWeVPBm+qP2yZLUwDfzh39HMenltmz
	gtbEngd+hMYZZAY2bEaO+NgkyljkSzthlhdwpejZCtstVGdsyBmH7yyzVbajteaUX72CvOmWe7s
	yumu12Fdt4gY0WTsOuiqIEUHFVBqbE3f/cGB/NUl5iQ5EU5BUYqAgFxPoLrkqcmD2eeL8hxHdih
	Vaq7mVX11134+0jYkKUCTLRsCjeaBjkp4sHWBbgsfZ3hl8+aFoTLTyneTQ/NDr1+PwfdCxBqXhr
	I8n1jQotv3aRbXe3RAFbDxcS4csWUa8ZnaFB4o1e2SF5/w==
X-Received: by 2002:a05:6512:6885:20b0:5ae:b59e:aa45 with SMTP id
 2adb3069b0e04-5b459112c65mr3729273e87.17.1787066172623; Tue, 18 Aug 2026
 08:16:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818085623.18467-1-panz.development@gmail.com> <20260818091544.88C9C1F000E9@smtp.kernel.org>
In-Reply-To: <20260818091544.88C9C1F000E9@smtp.kernel.org>
From: Panz Dev <panz.development@gmail.com>
Date: Tue, 18 Aug 2026 17:16:00 +0200
X-Gm-Features: AcwNN1VMnPmDNOJhVB0oCKWsNxY1TRgJpbIec1-q_7fnJx8iHxJ9XkijskYeOV8
Message-ID: <CAFinCN8mF9W43cCRXq1LJK2mf=gB5=ger3eOXp0PukQRKegD+w@mail.gmail.com>
Subject: Re: [PATCH] HID: asus: fix touchpad multitouch initialization regression
To: Denis Benato <denis.benato@linux.dev>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Thanks for the fast reply!
Good catch on the UAF risk. It turns out simply adding `if
(!drvdata->tp)` to skip the keyboard init loop was actually all that
was needed to fix the touchpad probe on the E200HA.

That way, `asus_start_multitouch()` stays safely inside the claimed
input check as before without touching any of the security logic, and
the && condition doesn't need to be changed back to ||.

I've tested this on hardware (ASUS E200HA and VivoBook Flip 14
TP401MA) and just sent v2.

Sincerely,
PANZ

On Tue, Aug 18, 2026 at 11:15=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
>
> New issues:
> - [High] Unconditionally calling `asus_start_multitouch()` outside the `H=
ID_CLAIMED_INPUT` check introduces a Use-After-Free if input registration f=
ails.
>
> Pre-existing issues:
> - [High] Incorrect cleanup order in `asus_remove()` creates a Use-After-F=
ree race condition by cancelling the workqueue before disabling hardware ev=
ents.
> - [High] Missing `hid_is_usb()` check in `asus_kbd_register_leds()` allow=
s an invalid cast to `usb_interface`, causing out-of-bounds reads or crashe=
s.
> - [Medium] Modifying `input->name` after device registration creates a da=
ta race and violates input subsystem API requirements.
> --
>
> --- Patch [1]: [PATCH] HID: asus: fix touchpad multitouch initialization =
regression ---
> commit 53becd94719f665ca15fc8c3f4b7876a402da45f
> Author: Panz Dev <panz.development@gmail.com>
>
> HID: asus: fix touchpad multitouch initialization regression
>
> This patch fixes probe regressions for ASUS I2C/HID touchpads by skipping
> keyboard report initialization for touchpads and moving
> asus_start_multitouch() outside the claimed input check block.
>
> > diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> > index 3f5e96900b67a..72b93bdeb4e8f 100644
> > --- a/drivers/hid/hid-asus.c
> > +++ b/drivers/hid/hid-asus.c
> [ ... ]
> > @@ -1327,12 +1329,12 @@ static int asus_probe(struct hid_device *hdev, =
const struct hid_device_id *id)
> >                       drvdata->input->name =3D "Asus TouchPad";
> >               else
> >                       drvdata->input->name =3D "Asus Keyboard";
>
> [Severity: Medium]
> This is a pre-existing issue, but can modifying drvdata->input->name here
> after device registration (which occurs earlier during hid_hw_start) crea=
te a
> data race?
>
> If a userspace process like udev reads the name attribute concurrently, m=
ight
> it read the default string or race with the pointer reassignment?
>
> > +     }
> >
> > -             if (drvdata->tp) {
> > -                     ret =3D asus_start_multitouch(hdev);
> > -                     if (ret)
> > -                             goto err_stop_hw;
> > -             }
> > +     if (drvdata->tp) {
> > +             ret =3D asus_start_multitouch(hdev);
> > +             if (ret)
> > +                     goto err_stop_hw;
> >       }
>
> [Severity: High]
> Does moving asus_start_multitouch() outside the HID_CLAIMED_INPUT check
> introduce a use-after-free regression if input registration fails?
>
> If input_register_device() fails during hid_hw_start(), hidinput_connect(=
)
> frees the allocated input_dev and returns an error without setting
> HID_CLAIMED_INPUT.
>
> Since the HID_CLAIMED_INPUT safety guard is now removed, the driver
> will force the touchpad hardware to start sending reports. When the hardw=
are
> interrupt arrives, asus_raw_event() intercepts it and routes to
> asus_report_input():
>
> drivers/hid/hid-asus.c:asus_raw_event() {
>     ...
>         if (drvdata->tp && data[0] =3D=3D INPUT_REPORT_ID)
>                 return asus_report_input(drvdata, data, size);
>     ...
> }
>
> This blindly dereferences the freed drvdata->input pointer, which was ass=
igned
> earlier in asus_input_configured():
>
> drivers/hid/hid-asus.c:asus_report_input() {
>     ...
>                 input_mt_slot(drvdat->input, i);
>                 input_mt_report_slot_state(drvdat->input, toolType, down)=
;
>     ...
> }
>
> Is it possible for this to cause a use-after-free, for instance if trigge=
red
> via uhid device spoofing or resource allocation failures during probe?
>
> >
> >       return 0;
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does the cleanup order in
> asus_remove() create a use-after-free race condition?
>
> In asus_remove(), the driver calls:
>
> drivers/hid/hid-asus.c:asus_remove() {
>     ...
>         if (drvdata->quirks & QUIRK_HID_FN_LOCK)
>                 cancel_work_sync(&drvdata->fn_lock_sync_work);
>
>         hid_hw_stop(hdev);
>     ...
> }
>
> If the device sends a KEY_FN_ESC report via hardware interrupt immediatel=
y
> after cancel_work_sync() returns but before hid_hw_stop() completes, migh=
t
> asus_event() re-queue the work via schedule_work()? Once asus_remove()
> finishes, the devm-managed drvdata is freed, which could leave the work i=
tem
> scheduled and lead to a use-after-free when the worker executes.
>
> [Severity: High]
> This is a pre-existing issue, but could the lack of a hid_is_usb() check =
in
> asus_kbd_register_leds() allow an invalid cast?
>
> When handling the QUIRK_ROG_ALLY_XPAD quirk:
>
> drivers/hid/hid-asus.c:asus_kbd_register_leds() {
>     ...
>         if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
>                 intf =3D to_usb_interface(hdev->dev.parent);
>                 udev =3D interface_to_usbdev(intf);
>     ...
> }
>
> If the device is connected via another transport (like Bluetooth, I2C, or
> spoofed via uhid), the parent device is not a USB interface. Would callin=
g
> interface_to_usbdev() on this invalid pointer lead to out-of-bounds
> memory access or a crash?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818085623.18=
467-1-panz.development@gmail.com?part=3D1
