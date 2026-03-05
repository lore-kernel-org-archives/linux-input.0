Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE4B3803DB
	for <linux-input@vger.kernel.org>; Thu,  5 Mar 2026 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772734085; cv=pass; b=jB0KUMkQA53m3e4Zbygd8oi8eRSXKw0qMTDAtW9LsrQzykpnwTtjsIx+FtgvuHjY0H3Y5maaxoKoY+C37iW2F3qVgU3kzk9mk6LYBEXBAcTh423Op9MW6CoEUys89fGNjUqVxyxd4T4smcUYL7a7zvvUHR2f1szAG4YRkreG40w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772734085; c=relaxed/simple;
	bh=s2nmTFJM9eCKJKdI5awxzJ+bi91G6yzRj6C+K7jK5Po=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RDNpjZppwkBeywz1cl+NViGeIer1TsJyKWR79zd39+N5MhDeyJGc1hVsDjcqBoc49K1c2j0Iz/pIO9Vnp+RG7I8qdcKy5WNpErx8Ol9CF0+kbrCUWsyzCLBdoQ0FgRKz0/WqFv/JxjK8ee/mxc/+16gdXb+v38NNwo1F1Z5uR6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGKLSsZb; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGKLSsZb"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-679ed01869fso3161816eaf.0
        for <linux-input@vger.kernel.org>; Thu, 05 Mar 2026 10:08:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772734083; cv=none;
        d=google.com; s=arc-20240605;
        b=RQas1lY6zEQnFJbRgPyC8a9w9Zx3HFl249St1196urV7mw8EhaxWcCmlLZXi1g6oBX
         sTIl2Wo0h/JQjQ/8FnZ3PfqLC5EzZqaVEvmv+uPyQpa6BgIrzNL5aV1ohWS+VlfSRv+L
         xCB2knhsnuNglPipErzQZ+r0PilcHDoosU00BeV699usoCHXZ4AzZ60k46mzV5ywDj9f
         CM1CuhBp1kdHWsD0wXh6Wzx7BtW3wPuPjxHHk/rY82IsL5GUCWI0h3XS7mnNRcJf85sG
         h5j1G3OpBDQfZRHQuD0xI3ZvaWJ0PBFJJABdDyzIuAWlTuntMWponTTe1yf7NR+a2ynE
         tQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s2nmTFJM9eCKJKdI5awxzJ+bi91G6yzRj6C+K7jK5Po=;
        fh=y7YEEQHl9xisAUve2IvZpJmNnpsB/uhZc3YMDBJMEPM=;
        b=QGqCV04CZdqVKNczBsnHojIUK1GA4rMcuAt58gZlJnDCbUhsTS/xsIFhupZlqHA5+A
         6wGVLTYzzg2h3D4FFc66RMIyogm3oFQ9555dFzqGpKeYlEREq5OQ8qvXUOlim/Uo6aI2
         hAqvcykuKRrOpGP1Hvu/8B/WHKNRfJfxbgtb+SdXGeHcDYgR5URfNZBWdqFSIoI0KClj
         uET6yP8EVXfG3sVDq/ylMTg+GkvwdDdJ4DyU9m+qoq0dSBA3ns2gU3ptJ/TdyuKqTkBV
         WeABNY5/RgAJmvu4i+4q86bWKRzp8iY1p90Rt8/rcjrVVFBH3bBKYcgfd7mtKVKuzDYu
         yEdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772734083; x=1773338883; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s2nmTFJM9eCKJKdI5awxzJ+bi91G6yzRj6C+K7jK5Po=;
        b=FGKLSsZbn/2UeqILgRP96+X83NbxO61CSXgmrdoBr+z5QDMxTVpnhFi8sv7/U0WhKj
         B+QqVj7TSBUyRv4ewuVXbDX7QuA6fuCqK1ZsmdK0aWT7FDp+Ks4uYZ+mPu+UaT+6GWsB
         nEGCktuaFLQrK8SAYfcH9SGFky8KQfGd1tPpFGSp5qCPbNuPnOmD0AQcDQxDwgVWFmuz
         sWf0D+soaTi/GPx+CSHcBjwItSz4BOcYvrIUhgTFbHViMzEz2Gx9onTIH0l154vOLHBR
         95ebN1FJXoh146PG/AW+aNaqcPWbXsmGN9BnwkMzej2IVs70xCTV17WF/SDV3aNp6p4S
         qMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772734083; x=1773338883;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s2nmTFJM9eCKJKdI5awxzJ+bi91G6yzRj6C+K7jK5Po=;
        b=oVSmVMN46FL8WgTiCAVRvzXBn+xtTLBVHvYQhWCLoeHRaxmZA7BFPQioLpyJ4vGYNW
         RpXo8Ns/ADcYXCO5O77Paa2rXzuCuUL8AkkksUVb27Jif6sM/crpvAYRdXm26ptZiUZL
         L3+4+9IZE0ibj+VMotv42QyDrfDWlq92e/3mqNBK4mvUiDddNUPRr7pCV88JOKBlFY9P
         7TwnfhrCZBl+ElC9SvbhoD8+i3scbW1oHWCyzn3uRY424yO9UgXxaSuhbKR0rOr7RozI
         h/NWTMvOk+v8cqxAOAsRu47QsFa+tmOheRbLO6M3WpoNLJn+hW9i1QMr/o2oBjUOht8c
         1C0A==
X-Gm-Message-State: AOJu0YzyGEOHSjCEmunub0MshIOmgfgJgBtv0oxNZJwWYnXbEghyaKI1
	DjMtWKBlh2WysB7Pbse5Cfwuj9kJjxmR4f7bEGx6O+MgyfK1E67Dr/Jar8AjIE4jhw0ZzungMx/
	u7EyGMBwmaoZWkmKslTISKwwF5Iql7WoSvePm
X-Gm-Gg: ATEYQzzmqAYyg+sOjkWtAL2yIukW9C8gcG1AhC6D94uFqFar//9+rln4hlOhXJiMvtf
	w9H1qg1jyJ2P98CTnEMQVZvMvkCdaiNUDv2FJjYYXD/8umOjhqt6/MfQqnv3/n0gUVc5CQNEpSo
	RxLxgWSa5L516hOWZDuvROG53AnNT2OmwcGfgxmzxNmXvTH0Dj49jaJTkI+lrBnbV+jVYbKwh1A
	eKcLsCM5GHEpFMhbedXhIj6/pMfPSKSYifKSW8ocrAS3fn2lWjmSOBmdAX8+kEKo8EEx9s3EMII
	Lap6Hz/azMsdYIg0eK7rWg==
X-Received: by 2002:a05:6820:210c:b0:679:92c7:2bfa with SMTP id
 006d021491bc7-67b1775ef53mr3685861eaf.45.1772734083290; Thu, 05 Mar 2026
 10:08:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
 <CANkKV91Zfp_Bn_koM=Tb5vHQbog2Ja72C819aL-49kQ6PWA_Ow@mail.gmail.com>
In-Reply-To: <CANkKV91Zfp_Bn_koM=Tb5vHQbog2Ja72C819aL-49kQ6PWA_Ow@mail.gmail.com>
From: =?UTF-8?B?UsOhY3ogTcOhdMOp?= <raczm0812@gmail.com>
Date: Thu, 5 Mar 2026 19:07:52 +0100
X-Gm-Features: AaiRm51Raf-y2de-B2FAM9JLv7VRR7UXKPzLnoPFCQ0guVESPck3kTB0HA12eoA
Message-ID: <CANkKV93wfs7oxU8kiyPWeafOs+ugpZSPLQrea7wtoSuGEG+pPw@mail.gmail.com>
Subject: Re: [6.18.] ThinkPad T14 Gen 2 AMD (LEN2073) - Synaptics touchpad
 remains PS/2, intertouch=1 ineffective, lost sync events
To: linux-input@vger.kernel.org, linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I did some additional checks on my system with kernel 6.18.13-200.fc43.x86_=
64:

1. Kernel configuration (relevant parts):

$ grep -i "RMI\|SMBus" /boot/config-$(uname -r)
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
CONFIG_RMI4_CORE=3Dm
CONFIG_RMI4_I2C=3Dm
CONFIG_RMI4_SMB=3Dm
CONFIG_HID_RMI=3Dm
CONFIG_I2C_HID=3Dy
CONFIG_I2C_HID_ACPI=3Dm

2. dmesg output (filtered):

[ 1.615300] psmouse serio1: synaptics: Trying to set up SMBus access
[ 1.618151] psmouse serio1: synaptics: SMbus companion is not ready yet
[ 17.949336] psmouse serio1: TouchPad at isa0060/serio1/input0 lost
sync at byte 1
[ 17.962506] psmouse serio1: issuing reconnect request
(repeats multiple times)

3. libinput reports:

$ sudo libinput list-devices | grep -i SynPS
Device: SynPS/2 Synaptics TouchPad

Interpretation:

- The touchpad is recognized as a SynPS/2 device, i.e., fallback PS/2 mode.
- SMBus/RMI4 driver stack does not get loaded, despite the kernel
config enabling modules.
- The "SMBus companion is not ready yet" messages indicate that
psmouse attempts SMBus access but cannot reach the device.
- I2C controllers are functional, yet the touchpad does not enumerate
as an I2C HID device.

Workarounds:

- Using psmouse.proto=3Dimps avoids lost sync events, confirming
fallback to generic PS/2 handling.

Observation regarding previous reports:

- Unlike the 2021 report on ThinkPad P14s Gen 2 (AMD), I do not see
any "bad SMBus base address" messages in dmesg.
- The kernel attempts SMBus access, but fails because the RMI4/hid-rmi
stack does not initialize. The device simply falls back to PS/2 mode.
- Therefore, this does not appear to be the same base address issue as
the earlier P14s case.

Conclusion:

- Behavior strongly suggests a missing DMI quirk or regression in the
SMBus detection logic in combination with i2c_piix4 on this Lenovo
ThinkPad T14 Gen 2 (AMD) with LEN2073 touchpad.
- This is reproducible on multiple 6.18.x kernel versions on Fedora 43
stock kernels.

I can provide full dmesg, libinput outputs, and acpidump if required.

Best regards,
Mate Racz

R=C3=A1cz M=C3=A1t=C3=A9 <raczm0812@gmail.com> ezt =C3=ADrta (id=C5=91pont:=
 2026. m=C3=A1rc. 4., Sze, 16:02):
>
> This might be related to the earlier report from 2021:
>
> https://lore.kernel.org/linux-input/3d6f7f74-3214-4c03-b352-a2a0d27ea42b@=
amd.com/
>
> and a similar report from 2025:
>
> https://lore.kernel.org/linux-input/b2d0af40-876e-4a2d-99a2-236b583e9497@=
gmail.com/
>
> The 2021 report describes incorrect SMBus address detection with
> i2c_piix4 on ThinkPad P14s Gen 2 (AMD), resulting in RMI4/SMBus not
> functioning correctly and the device remaining in PS/2 mode.
>
> On my system (LEN2073), the behaviour appears very similar:
> - intertouch has no effect
> - "SMBus companion is not ready yet" in dmesg
> - device stays in PS/2 mode
>
> It seems possible that the same underlying piix4 SMBus detection
> issue is still present.
