Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AB9369206
	for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773426055; cv=pass; b=NOHzcT/+o8VFijteVBdqDv/JjkERA1ykfyZ3TstER1BV4PtdGC4enj5tq5oKf6YFYd9Nvhci+UW6By20TD3J4EZh37UNSYQ5eWS2hCSLXHRTKnST4w5Z24kK5zu33xN9QqFCHuWRaoxc+tGvS9SB0TTn0EbJYTJY4b7YeHUhlnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773426055; c=relaxed/simple;
	bh=EAp5x2rvQX6uIdeKkeZkn7Jqf9cqkZjas5/z+DsY61s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pVOLuDsZ30y/xWQ414I0KKqFupdfHVsBmcIGxGYI58wWtmB9O4Bi8fAv1YWnk7TxBKZAF+txP8GuaHUBbC4h9GlApqTeI0mb2r0Uxp2CNUrSTcrhAc9Qx5gTFUOKflZ+d3sL3iofhk1C66YbP+ZUTHyw5b+WP8iWz9+Pp0xwIdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work; spf=pass smtp.mailfrom=frame.work; dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b=bO+GhSbX; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=frame.work
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=frame.work
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=frame.work header.i=@frame.work header.b="bO+GhSbX"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-64ad46a44easo2497395d50.0
        for <linux-input@vger.kernel.org>; Fri, 13 Mar 2026 11:20:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773426053; cv=none;
        d=google.com; s=arc-20240605;
        b=YnkFDN8YStctkfCvr1ycbFwuOkOGot+sfWeE/z6I37YCXuGlwBx2TFfdT/L24eh378
         NZMvLu0ue3Zcy09L32aJEp74waRKCeE3UcW359xVWQjNn4yVPosDZ0YYJzlZPLGctbvR
         HRJxL5NCBQlKb+vRTDu7nXUBB6ZYVYI8wcnDKiU9dPb3TiMt/EL+M1TIqbyv7I8hlHH+
         1L03+Du83znGn6yIQPdIRe/BFNs9eMUQmG/VZ+zeosjipSpCI6EizhSzMgFwhlC7j4u0
         R2Zp0BeOnxw0wtrKhxf80sY6gEXfL3BpEdMiAQEz8Y8wzwOthnZCzYGVliEYnun+v+6N
         gxcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2BPb8ZrMTnk8czj+k5rwj3Z1X4vcTwgPV+skAjAYhEk=;
        fh=ZTHFrkQCW6mcmXo04FE7z9E3BNdsqWyzGa2bHaTNtSE=;
        b=OiVxy71NK4V1IgO1TdvqeXhIfS3MCfEmTI/LbdvVnpCgOO+zvVkn0M43f8b2TXL6u1
         i30HPRsVXRucevw5cJt7+PKDdRbnc+PefG+2N9/ucSZCzp8Jyy7u3vC8/1xRttieCcsl
         ql0sbV9JVIKPjlLXiHPyNWQ8K0gnCEmecYkG6i2UvKfXoDNrj/MV4g91v9FTf1W/H4+6
         6mpti8x5KA6SF6iMIVSGV1IU5IlBNX++d03EswFoFhEF9iALhjOBAUc8O3MVJVd2gjyW
         scAgHhWNu/FHLNdPSEwjatv79GNdIMFqBsqFugwPJ4AeDMrpvdONjC1OtQzHDk1dXKbW
         FB9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=frame.work; s=google; t=1773426053; x=1774030853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BPb8ZrMTnk8czj+k5rwj3Z1X4vcTwgPV+skAjAYhEk=;
        b=bO+GhSbXhJblROPMmeFumr2sVncqP7+BvsI7RGXZkrPsOioZ6a84YphHbRLIWu1dk5
         yQ6JR7ojZrJG1MOwiuiGsTQeFoBp7Hn8l2O7x1TDARt8r1lsqLMuVBkFyadgJ+XGMB6g
         kRShg/pSGUOrVsJdJtQyj8kKiKILziqSgagKG0lWrWLYxU4oyhhAN3eTTVTHmsRkDkVV
         3/BdhW9v7R3jGiO6u5KPmJvDHsb8+Ri6CUr2tJsrR7gMaHsmiZp7qHqI/QDDNhGLe/LJ
         JaEtfy5tfwOyonkrrZ5rv9OjOT0cPxxl267eaC2fuHU7V+LkHLs/c47DS2I7ZU7sQD4f
         9V0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773426053; x=1774030853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2BPb8ZrMTnk8czj+k5rwj3Z1X4vcTwgPV+skAjAYhEk=;
        b=P4LKc4Zp+BxhVBQoxrXiuWfv8CefUDsGxaEW/jAWIEy68MeGKttszdpis90do0QGaw
         Rpi4V0RiorzTy5tz6dKqGQXQmMtrB8WOGsKPamdGzVVGOQnAuXlNDBPP8tMzR55Za9Bv
         dw3a2pOlSGMZhlAsQn/+3WShhfv1RgIcxEPoJs2n2EJwZNj+NIo5MlpwLM13WRdkUiXz
         NdujTHZZXAkEQAUq/94UzANKgrhUp2TFJLVSR3+3KYaFrbDD/38jmmEY2YhabSZMCK2R
         LiuBRoXHBbaZ1aSUGeetF1gxdoZGrI78Sbv9pYPY6sZzgJJxpruTsxqNB82byvUM2R5Q
         USpA==
X-Gm-Message-State: AOJu0YwP2lxuUo0F6L8jD/IO8RBUbjvCrtnYiOGNF7V7xK73DRfst2oX
	dD4xR2t8pZITdlf39RZoIodp6Wp14vokbetn3o4GBLJHOFWHVG/uUbPEAjzSBzKNhOoaFlCRrPD
	uef1/v9eFt6E1SHZtTFESrV7wHdZ7kzn/sMalLXw4/w==
X-Gm-Gg: ATEYQzyo+YvKv2zuBHgHkKNXa7q3bemFqOvQoFC9qs7OgiYC5VebQzGfH8yd9Q7i8Zl
	lGLVbrl7jeB3qA3fnUAIRcQvP6nl33/+0FaRMhq4Eh52Gy4vHAVWFa45tvw8NeN64Gc4wtbuMoC
	SXNL+GnAfozI6o1ArTK+sTKlx2Bp2JDslq2KhPzyktRWNTGVhemJbC98cYovnS9ih0FOeuFV2SF
	XBAk3j9d6qVc/4gcCqtVzjl185gHoNRa8ClLhLMfq31f7ptDePdUfP761Ro/NtGbeL53TayqO/+
	B4apCcT237h51SjTTzHTfAXLkyNnmQYlo5UiyYWX2lOF6rimqGmb8Q5wHeWZuwjN8rbtkR+9ubz
	LU/GXggMOPhhP4zI/IHggTxs=
X-Received: by 2002:a53:bbd1:0:b0:649:b234:3903 with SMTP id
 956f58d0204a3-64e63070b23mr3317285d50.59.1773426052697; Fri, 13 Mar 2026
 11:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313175659.268094-1-dhs@frame.work> <20260313175659.268094-5-dhs@frame.work>
 <6b53a537-9989-4b34-b033-402773c871be@amd.com>
In-Reply-To: <6b53a537-9989-4b34-b033-402773c871be@amd.com>
From: Daniel Schaefer <dhs@frame.work>
Date: Sat, 14 Mar 2026 02:20:16 +0800
X-Gm-Features: AaiRm50LAF_Jxr4PTGv9XPdGQzPsDA06FYdEm89VLjhssiSAc-jdeXqpfI1mRaQ
Message-ID: <CAAjcXz5nhCb5EC848zQ=+CAj5ePtHne_FyFxSdpiqohF-t_3_A@mail.gmail.com>
Subject: Re: [PATCH 4/4] HID: core: Export device version via
 HID_FIRMWARE_VERSION uevent
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-input@vger.kernel.org, Richard Hughes <richard@hughsie.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, linux@frame.work
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  Isn't this in
> hid.git#for-7.1/lenovo-v2

Oh yes okay, I with this already in place, I should make my patches
set hdev->firmware_version instead of hdev->version.
Will send another series and drop my last patch in favor of yours:
https://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git/commit/?h=3Dfor=
-7.1/lenovo-v2&id=3D6ca9029c823b7853e980585e757343e0e84227cd


On Sat, Mar 14, 2026 at 2:00=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
>
>
> On 3/13/2026 12:56 PM, Daniel Schaefer wrote:
> > Expose the HID device version to userspace via the new
> > HID_FIRMWARE_VERSION uevent property. This enables userspace tools
> > (such as fwupd and hidapi) to retrieve device firmware version
> > information, providing parity with Windows HidD_GetAttributes() API
> > which returns VID, PID, and VersionNumber.
> >
> > The version is exported as a 4-digit uppercase hexadecimal value
> > (e.g., "0100" for version 1.0), consistent with how USB devices
> > report bcdDevice.
> >
> > fwupd can handle this since:
> > https://github.com/fwupd/fwupd/commit/fb0d4cc98abe253003ea0e1837277fd42=
971e0de
> > But the kernel hasn't yet exposed this.
> >
> > hidapi patch is in-flight: https://github.com/libusb/hidapi/pull/777
> >
> > Cc: Richard Hughes <richard@hughsie.com>
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: Benjamin Tissoires <bentiss@kernel.org>
> > Cc: linux@frame.work
> > Signed-off-by: Daniel Schaefer <dhs@frame.work>
> > ---
> >   drivers/hid/hid-core.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index da57cbf0af26..c2075d5b40c3 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2884,6 +2884,9 @@ static int hid_uevent(const struct device *dev, s=
truct kobj_uevent_env *env)
> >       if (add_uevent_var(env, "HID_UNIQ=3D%s", hdev->uniq))
> >               return -ENOMEM;
> >
> > +     if (add_uevent_var(env, "HID_FIRMWARE_VERSION=3D%04X", hdev->vers=
ion))
> > +             return -ENOMEM;
> > +
> >       if (add_uevent_var(env, "MODALIAS=3Dhid:b%04Xg%04Xv%08Xp%08X",
> >                          hdev->bus, hdev->group, hdev->vendor, hdev->pr=
oduct))
> >               return -ENOMEM;
>
> Isn't this in
>
> hid.git#for-7.1/lenovo-v2
