Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C782B376BE4
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 11:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773057280; cv=pass; b=BCNVp/tYPN++5x79fotKrAnMvicuhicZJdcNz0cbr2N8ZifJS+RpOlRoePLu522uaCYhg6dWUvC/aAP90N2Ca6ntRN9Wq9JLA2vLyjfljb4QFWJUmns04Tl7pQSnpXF8z++3Bzvln7JP8kjyd5o/GmU5KkZNLuEXXOvM3HVhk+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773057280; c=relaxed/simple;
	bh=ZRP4v7PWPX+zmV8EvqiA/mk3c8DRZ7Oi6bAtzLpOn+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mL5qYzEhYFfAZ2zeKGQtmmdWgd8SXG9LxfPoAJW2mPp0dnOuY0KLfulqJXJVDFJbAquAXglTL1YWRG336T1loRzrqbkgIPfuBp+czPqlAcq9RwXxCy91051LRKl1pAjiZwmsKzjM7urkOXUHzKXvh+sI4nHiRcc5JQWXzwA7/Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUQMcRoG; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUQMcRoG"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4042905015cso4056985fac.0
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2026 04:54:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773057277; cv=none;
        d=google.com; s=arc-20240605;
        b=GVWutP0II/qu5CEMoYKPVEPOLh0s9MEZb9p8cdXOeMhLh/sbo8Ryobk3InSPmfZgIe
         Jy3oaohPSiMiq4O2IcOkKWRpCXo2ySof66fdHewoYlmhtSF2DzKfNhc6l/U1G4HHaYJE
         VDEvaS0MT+x3MqvJmyC/2f7MKNY2LzSpCUglXgvbGLsPnTzZ6LNa3f+CnwLZiptKz6SZ
         JCgNXLfMlsDgDs2EbRIfK5DZo+qbbpHREHhaA+wtZWPJycFUIiQrH6XMAJULmRhqd6lM
         shsdVYp4pvaVOGR1mqtn60qlCuCSeuulVShcKw2xYCxm479U6LhXf81HzvPo7FRI/kF/
         SY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZRP4v7PWPX+zmV8EvqiA/mk3c8DRZ7Oi6bAtzLpOn+E=;
        fh=94j/QdI3VMo4wehU8E8r5TH0TIH68rDgdNs5tne0BjY=;
        b=XqAi4CIGztwfBnmXzIgltP4AScNO1JwORU4BE2BnlaGy3TNcKKA1oERSX8XnLP88/v
         9vW6nQC8jF6gccbELIkL/cCvZCmvibnijym24OPl6ANiXidiaRBKL3D8Kh3tHZLG4PNl
         fOTOl6T0xvmbEbsd9hpuC095amu84/+rarLngTlQQo/B4qZsE0As2tpt+oK0WVi5Rx+d
         aMPVA+OQmKrEi4qf7wSE4pchpcIV/sEnt0WqP72ayesrFMxxeFdnoABM/3sGfSHnwwkr
         dkYj3RPjOSdmWbebCXKKB+pq16kTrv1j97nkKUOo6oxVADhdo05Xvd7JS9P5Ig92Dwe3
         oRtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773057277; x=1773662077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRP4v7PWPX+zmV8EvqiA/mk3c8DRZ7Oi6bAtzLpOn+E=;
        b=QUQMcRoGLyu4JfPBGFjiqnete61bbmd5v/hk62JonSuwQ5HfS5vcEmoP9GgH3qgPF/
         b0vRmL+ApSbZlEEQBkZkNR5lo/UQl/1D4feFoO/1aU4cbOgU0K/nsfjEabAOp7hwr03o
         +BYsLrcKm1uLRdx5KAErSusshfM6hsj3GF+r3mlKT+tn2AgRw6P+/QsO0BGeog5EY6KC
         64ZPXkDyFqMuZGgT2kSuBfS3gYNENrlra8QegaFi4nl01ABC7rpZafo34WCfQwvpQb9c
         R6AMkdQF1fZnIrXmM9IO9/u794A2o2kJpkeiIhaojoZF+lg9GD3PK2i6UzVRNu4BPE+w
         zJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773057277; x=1773662077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRP4v7PWPX+zmV8EvqiA/mk3c8DRZ7Oi6bAtzLpOn+E=;
        b=RcRPU3U/TuzKgXBm94K09dZcxENd2QpkbWuM+QYJbkW0Yn7QNUsoKI4dbzo9S24GVK
         ibZ8MooFdeW5uvPUSxwk+JazXgEWuIluEcolSagKpsT+oVyq90ViYOLdi52bQoTCsx6U
         FkxinIdTdIKD68uOEyzpu6jMUCmVxdV6K8YdCza4pPqiRvt4nYNomLJ9hZZy2ytyu2MY
         xOBdExNHpIKPPn5gV6PiuIitamNR37Hx3y3XDepE5kU7eJvv6E16+insvoi7nEZDUxWV
         yYi6EfOSkU8u9LEgkmuD5C28RKl6Pj10RdC/9j0bKcq/62a+fxnwDsk5K4jXGFBkBjAG
         p4EQ==
X-Gm-Message-State: AOJu0Yy/8i7ZKvvbyNU8g/DCabTM1mQA6XUj15bgWy07xueO4Awonr5X
	FCQsS/6BTiESS9wBac2X/PCj4AP3rDyhkzn7fm6+UYIcHmS+QMHawDoMEwEVaboywFZn7Tia9OA
	fe7D4eeDME7YWCpwjdGNIBf4ynm+9geI=
X-Gm-Gg: ATEYQzzxkIENG78AhglUtSB/yn5QrN8elQuTfkQpnMYUxUfpqB2HCOYMBsJK0ftuAmB
	Q2i6DDHlFS6Uk6/8sJNu4P/7rLFG8WGkxzcM7w3Kb50Z8By5m/sm988GAKKaOJLCwtGwoCIdreB
	E4+Ms5vV07gVrp2/f6SSS+xe9lUVl/fptuxyf8ixQ/4y7E4bRZGW0nW3O8tLmROtQp8ItZov9zh
	CJ40eJdFnZwcesdo48Fw3i90AIcos66MJRF0YFAvnbDV7OG2D8Z2dxCXYf90IbLkHq1YamYlW4N
	Gb+20iFUDm3W/CjsEBFp
X-Received: by 2002:a05:6870:37ce:b0:3d2:4319:38eb with SMTP id
 586e51a60fabf-416e448be4amr6727108fac.47.1773057277508; Mon, 09 Mar 2026
 04:54:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
 <CANkKV91Zfp_Bn_koM=Tb5vHQbog2Ja72C819aL-49kQ6PWA_Ow@mail.gmail.com>
 <CANkKV93wfs7oxU8kiyPWeafOs+ugpZSPLQrea7wtoSuGEG+pPw@mail.gmail.com> <68d90523-33dc-451f-a825-72eaa1c4bcb8@leemhuis.info>
In-Reply-To: <68d90523-33dc-451f-a825-72eaa1c4bcb8@leemhuis.info>
From: =?UTF-8?B?UsOhY3ogTcOhdMOp?= <raczm0812@gmail.com>
Date: Mon, 9 Mar 2026 12:54:25 +0100
X-Gm-Features: AaiRm51LDGipFhqZVVF8l-P-IJc1_ce37qNAFaXZWS4J57r1zOIpXrOgouSBTr0
Message-ID: <CANkKV91attPiZ4+6DQKcgG10apUbF6k5hs7aJBrfsnfc5jQCew@mail.gmail.com>
Subject: Re: [6.18.] ThinkPad T14 Gen 2 AMD (LEN2073) - Synaptics touchpad
 remains PS/2, intertouch=1 ineffective, lost sync events
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thorsten,

Thanks for the response.

I have not yet tested with 7.0-rc, but I will try building and booting the
latest mainline release candidate and report whether the issue is still
present.

One additional observation: the touchpad PNP ID on this system is
LEN2073. I noticed that this ID does not appear in the Synaptics SMBus
whitelist in drivers/input/mouse/synaptics.c.

Because of this I am wondering whether the device might simply be
missing from the whitelist rather than this being a regression.

I'll first verify the behaviour on 7.0-rc and then investigate further
(if needed I can also attempt a bisect).

Best regards,
Mate

Thorsten Leemhuis <regressions@leemhuis.info> ezt =C3=ADrta (id=C5=91pont: =
2026.
m=C3=A1rc. 9., H, 9:12):
>
> Hi!
>
> On 3/5/26 19:07, R=C3=A1cz M=C3=A1t=C3=A9 wrote:
> >
> > I did some additional checks on my system with kernel 6.18.13-200.fc43.=
x86_64:
>
> Have you tried if 7.0-rc is still affected?
>
> And if it is: could you bisect? See
> https://docs.kernel.org/admin-guide/bug-bisect.html
> for details. Without a bisection developers developers from both
> subsystems involved (i2c, input) might not look into this, as everyone
> will suspect it might be some change to the other subsystems that causes
> this.
>
> Ciao, Thorsten
>
> > 1. Kernel configuration (relevant parts):
> >
> > $ grep -i "RMI\|SMBus" /boot/config-$(uname -r)
> > CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
> > CONFIG_RMI4_CORE=3Dm
> > CONFIG_RMI4_I2C=3Dm
> > CONFIG_RMI4_SMB=3Dm
> > CONFIG_HID_RMI=3Dm
> > CONFIG_I2C_HID=3Dy
> > CONFIG_I2C_HID_ACPI=3Dm
> >
> > 2. dmesg output (filtered):
> >
> > [ 1.615300] psmouse serio1: synaptics: Trying to set up SMBus access
> > [ 1.618151] psmouse serio1: synaptics: SMbus companion is not ready yet
> > [ 17.949336] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
> > sync at byte 1
> > [ 17.962506] psmouse serio1: issuing reconnect request
> > (repeats multiple times)
> >
> > 3. libinput reports:
> >
> > $ sudo libinput list-devices | grep -i SynPS
> > Device: SynPS/2 Synaptics TouchPad
> >
> > Interpretation:
> >
> > - The touchpad is recognized as a SynPS/2 device, i.e., fallback PS/2 m=
ode.
> > - SMBus/RMI4 driver stack does not get loaded, despite the kernel
> > config enabling modules.
> > - The "SMBus companion is not ready yet" messages indicate that
> > psmouse attempts SMBus access but cannot reach the device.
> > - I2C controllers are functional, yet the touchpad does not enumerate
> > as an I2C HID device.
> >
> > Workarounds:
> >
> > - Using psmouse.proto=3Dimps avoids lost sync events, confirming
> > fallback to generic PS/2 handling.
> >
> > Observation regarding previous reports:
> >
> > - Unlike the 2021 report on ThinkPad P14s Gen 2 (AMD), I do not see
> > any "bad SMBus base address" messages in dmesg.
> > - The kernel attempts SMBus access, but fails because the RMI4/hid-rmi
> > stack does not initialize. The device simply falls back to PS/2 mode.
> > - Therefore, this does not appear to be the same base address issue as
> > the earlier P14s case.
> >
> > Conclusion:
> >
> > - Behavior strongly suggests a missing DMI quirk or regression in the
> > SMBus detection logic in combination with i2c_piix4 on this Lenovo
> > ThinkPad T14 Gen 2 (AMD) with LEN2073 touchpad.
> > - This is reproducible on multiple 6.18.x kernel versions on Fedora 43
> > stock kernels.
> >
> > I can provide full dmesg, libinput outputs, and acpidump if required.
> >
> > Best regards,
> > Mate Racz
> >
> > R=C3=A1cz M=C3=A1t=C3=A9 <raczm0812@gmail.com> ezt =C3=ADrta (id=C5=91p=
ont: 2026. m=C3=A1rc. 4., Sze, 16:02):
> >>
> >> This might be related to the earlier report from 2021:
> >>
> >> https://lore.kernel.org/linux-input/3d6f7f74-3214-4c03-b352-a2a0d27ea4=
2b@amd.com/
> >>
> >> and a similar report from 2025:
> >>
> >> https://lore.kernel.org/linux-input/b2d0af40-876e-4a2d-99a2-236b583e94=
97@gmail.com/
> >>
> >> The 2021 report describes incorrect SMBus address detection with
> >> i2c_piix4 on ThinkPad P14s Gen 2 (AMD), resulting in RMI4/SMBus not
> >> functioning correctly and the device remaining in PS/2 mode.
> >>
> >> On my system (LEN2073), the behaviour appears very similar:
> >> - intertouch has no effect
> >> - "SMBus companion is not ready yet" in dmesg
> >> - device stays in PS/2 mode
> >>
> >> It seems possible that the same underlying piix4 SMBus detection
> >> issue is still present.
>
