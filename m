Received: from mail-vs2-f37.google.com (mail-vs2-f37.google.com [74.125.227.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E8FEEC3
	for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 07:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790752823; cv=pass; b=Ay1+GX4qXGQupALlr2HRDjwsc7eai/qtCvwUTbk9/p1umwBvndnqeWRYr34hUy2KjemmxjiBz4JFGnPt6ZMPXMQ6/X4CQ6hEzbhuTFMglxJ4HiHMtHHABieNnbakNVssbrb+94wW+JANcMeyyj7yVPS6bXgXQtmEQrrEd/k9zXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790752823; c=relaxed/simple;
	bh=qGt0YsFYcN017fQvszpRHzy5hsd1xvba1wbomW7VY3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1XFTHXxinLSsW6a7gNuJ4jXTOaPEtydvWQRu6vKRe9LIfDoUzU9pvxvTdig/JP0HHkgTGKFUgrhnHxEYUx3CvK4H8qSxn0hby7Qte+3akKCZR1LIl8/k3m9BJwCVGT+Qw8oHPAv9qyFtLQli56fmLeFv3SREaaqzjtZE7Sw3NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFst5/W8; arc=pass smtp.client-ip=74.125.227.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFst5/W8"
Received: by mail-vs2-f37.google.com with SMTP id ada2fe7eead31-7b9e0149da6so513852137.0
        for <linux-input@vger.kernel.org>; Wed, 30 Sep 2026 00:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790752820; cv=none;
        d=google.com; s=arc-20260327;
        b=awa9tAp1nCrDZyueVwYbsL8nm5c29SMFdhCke7/47H5O8udnDpdHSeFwH8phA0w9ge
         PXtq1aot2KH+amvIskDEWQbdJo0dTbEUSia0HzN/caYgmKA7218rrxF8nvFCzI5PiFD2
         M8I6lCcGi1/53DAuQKxAW+Dr/SFhUCC6OTvJ4Gdg3J/Q7LL3rI21VTGhc4eVzvyeWzEA
         UcX8Yp+mJh04ZELYjQZkYKt0mESIY8qpSSsnlsD6BGZlJIeuCpf7ZtyeEKkTyYUvmMF3
         OtEUybNe6R66aprW4tTtcuqSAAr8cngmOXqNHhf3khHOCGadgwZNTGEfSDKGd3mfhio1
         bbOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tRhP5/3LMDdFdRUnOnnSO2A2XycO9Quxua+nOknp1LU=;
        fh=HbwVldrbF5brNQEjLduHVHDVZFT8ThJsWFkSVYkOKOM=;
        b=NR7mj+rFHNwE0gmTH4XwLKqqTC0Hp/H44N+RXQOnSeDMT62urbaGBEU2y8HT6t0zlH
         kgekM5oYArZodJfax+uXt/WUW/yVNsbuUqEmLaFAv5iL8rxSO6pRVm3nKnWxcLKJi0MZ
         6p5GC/FYuTaRMbMeLTb8JR7DM9zqOwFTG9NRz0ZaKr54IQr66TdavHxIj6BDYBIyEqB0
         S0KZ0rRDuxxziV/Zf1/cCQ/2uhwwQ43/OxaedjR3eaX0kDyfPT8u+UVWQkc3KQnn6n6O
         bjxIH+zocXHG8yR0ZAEVwf0pIIrj6ioK7j2zy0ueOQmBN9q2xImMSB4c4VdJqc6D7BMJ
         tlgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790752820; x=1791357620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tRhP5/3LMDdFdRUnOnnSO2A2XycO9Quxua+nOknp1LU=;
        b=LFst5/W8AlAceh9ifbj6c0MpKsajAaW+/APzNmDbs7qqyEyuKuwlT1uKKjCLVS72t/
         MDZ5tcH4QpyMcHBGgIPKD4fKmQt/696cT86ufU47rVTc+BBo8MLjMX7EtQ8oV1D7bOjm
         ey8FSUp6lIxwuCtkKevgjYVZeedzd45M65vgiIrsD9JcAj65mnjSYlYJuO9wK6Nstv5K
         iB13OXgo8JivwEcA4Eekl/4rYRTbxYDvMQKO5BHBGVZj0mhTY9TP8sx5ypQu55gS213k
         ZNttvk4UArduiSQ1CAfFtEPNCKylwnFqAYsW9xwCE3Loh+OmuXUfDJlQqRRAH73yknQC
         6OEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790752820; x=1791357620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tRhP5/3LMDdFdRUnOnnSO2A2XycO9Quxua+nOknp1LU=;
        b=2WvtTc9nzYTutFI7PPSqyVqjP4COFstBfm/Ri7ILIAHRt1YKq1J46uqLPgMFNKGPKV
         PyRETIOyRrgG9S1ALHqtmGJ4SAu5QHQZYZ3kefaEEwVPCgMCjLxcQ5SrgxO8LIgJRSmj
         aH1hg15TkzPHGoW/ooyV5oL30yXg0tWORMq8C7nLxgwa8DgRNXMxkl99evOIGJzU91J7
         ssBTz8YBgvZjcKiTzUF+4+R0iQG3c5rdN5ZMSYliDntdveGVUq4s5FouY3NMjgj1EPQd
         4IOMaIKBs5kBg4EdQ/kYLQOm/mlWvuPe9uCPrvjDsW4ukoPTKygoKbC4NcNzj6h3p7gU
         lCKQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6tiaVrdJRBAmgnxpIrpf4SxSkpTpO2oDsLtumnl6oSXaYb7zhVm59OBrKS4J0RUQFKGlHSxZnn+svhg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJo1++MUCul7TdNWkjXDKh6RRXYGRpWOi2hNVmFtxWW5WoL0FJY
	iWK1lMwwwLj2noMYomxmfxHSf1CZE2BTrlN0gWQRfSQFKc9qrHgoIrhN5LNQEc8RuaO81/6bBUV
	goCtggOewdbTfWnLE07wWk1fwlLn4x08=
X-Gm-Gg: AYBFou0H2vYj84B3JT3JyQ9JEJ59wN2LoAI6iUG3bBBGR1eUYgXA+OBnXSuqq6gvw+i
	3UJmpkJ/KqzzKgGDuzzPWMRMyQ0ZAyFohLkSMSy6cIV79ltHObAnCJ/JY8C/nWdfPeRF9PHvHJ2
	FF2vd4l9v9bMNqvCdmxg8m64o86st8J7HI5OKDvmN+3ArDTYNF0Ngd43VHL8DQIZbAxlbPbMuAv
	EXttcnusmG8L88etYTHov7ow7mijP1q5KtjPiUUYdkAdHNUKIyme66ex3DQG2nqsSEvwurrOsZ5
	d0QGnckxMvebHhGDiMYFBpIJip36Hsu2T2kiLi6yB/K1EpUX+VJxyj9xr6D4GPO1ihDFdPnGsI9
	YnkB1oz5xdycqB4brvIM/cnyy8U1Rk5uYLW+iHIEXgQnmjBvkwRwDPaaWBi130pEmZJfY/290TA
	==
X-Received: by 2002:a05:6102:6a8b:b0:7a7:7961:b14d with SMTP id
 ada2fe7eead31-7be727addccmr57937137.12.1790752820234; Wed, 30 Sep 2026
 00:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-b4-elan2514-irq-route-v1-1-44671bf01d05@gmail.com> <20260930063500.7D2B31F00899@smtp.kernel.org>
In-Reply-To: <20260930063500.7D2B31F00899@smtp.kernel.org>
From: Waqar Gulzar <iamwaqargulzar@gmail.com>
Date: Wed, 30 Sep 2026 12:20:07 +0500
X-Gm-Features: AclHuK9IFTRHVM_07XLjX37kXd5ttmHGtWIewbnT6PdHeLfO8q_q-f65p6pYENE
Message-ID: <CADeB2Yr5WZ2mbWCv7YT4YWS-jaD=XvSXvyjffdsTFtwdg3ijow@mail.gmail.com>
Subject: Re: [PATCH] HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP
 OmniBook X Flip 16
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 30 Sept 2026 at 11:35, <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Medium] hid: i2c-hid-acpi: IRQ routing quirk bypassed on resume if wak=
eup enabled
> --
>
> commit c1ea0adbfc4956d2ccd0cfccdc56448c010e7ac2
> Author: Waqar Gulzar <iamwaqargulzar@gmail.com>
>
> HID: i2c-hid-acpi: restore touchscreen IRQ routing on HP OmniBook X Flip =
16
>
> The HP OmniBook X Flip 16 firmware disconnects the ELAN2514 touchscreen
> interrupt from the IO-APIC in its power resource _ON method, which Linux
> runs at probe and resume. This patch re-enables the routing through the
> firmware's own helper from i2c-hid-acpi's power_up hook.
>
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142384
> Link: https://github.com/testyfishy/hp-omnibook-flip16-touchscreen-fix
> Link: https://github.com/iamwaqargulzar/hp-omnibook-x-flip-16-linux-touch=
screen-pen-fix
>
> > diff --git a/drivers/hid/i2c-hid/i2c-hid-acpi.c b/drivers/hid/i2c-hid/i=
2c-hid-acpi.c
> > index 9371db200fc4d..b6348ee3d422b 100644
> > --- a/drivers/hid/i2c-hid/i2c-hid-acpi.c
> > +++ b/drivers/hid/i2c-hid/i2c-hid-acpi.c
>
> [ ... ]
>
> > @@ -85,6 +140,9 @@ static int i2c_hid_acpi_probe(struct i2c_client *cli=
ent)
> >       ihid_acpi->adev =3D adev;
> >       ihid_acpi->ops.shutdown_tail =3D i2c_hid_acpi_shutdown_tail;
> >       ihid_acpi->ops.restore_sequence =3D i2c_hid_acpi_restore_sequence=
;
> > +     if (acpi_dev_hid_uid_match(ihid_acpi->adev, "ELAN2514", NULL) &&
> > +         dmi_check_system(i2c_hid_acpi_irq_route_dmi))
> > +             ihid_acpi->ops.power_up =3D i2c_hid_acpi_restore_irq_rout=
e;
>
> [Severity: Medium]
> Will this quirk be reliably applied on resume if the device has wakeup en=
abled?
>
> The quirk is hooked up to the power_up callback. However, in
> i2c_hid_core_resume() the core driver conditionally skips the power_up
> callback if wakeup is enabled:
>
> drivers/hid/i2c-hid/i2c-hid-core.c:i2c_hid_core_resume() {
>     ...
>         if (!device_may_wakeup(&client->dev))
>                 i2c_hid_core_power_up(ihid);
>     ...
> }
>
> If the user or system enables wakeup for the touchscreen,
> i2c_hid_core_resume() skips i2c_hid_core_power_up(). If the device's ACPI
> power resource was turned off during sleep, _ON will execute on resume an=
d
> break the IRQ routing again, but the power_up quirk will not run to fix i=
t.
>
> Does the quirk need to run unconditionally on resume instead of being tie=
d
> to the core's power management logic?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-b4-elan2=
514-irq-route-v1-1-44671bf01d05@gmail.com?part=3D1


> Will this quirk be reliably applied on resume if the device has wakeup en=
abled?

On the affected boards it cannot have wakeup enabled. The touchscreen's
ACPI device (\_SB.PC00.I2C4.TPL1) has no _PRW, so it is not wakeup-capable:
there is no power/wakeup attribute for the i2c client, it is not listed in
/proc/acpi/wakeup, and device_may_wakeup() is always false. So
i2c_hid_core_resume() always calls power_up here, which matches the test
result (the IRQ stays idle after s2idle resume).

I agree the dependency is implicit. If the maintainers prefer, I can send a
v2 that either documents this assumption in a comment or makes the routing
fix independent of the wakeup state.

Thanks,
Waqar
