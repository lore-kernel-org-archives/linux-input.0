Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793472480;
	b=mliqCAChHzSH2ATKX1JUkF4blpMrW+f/9RbZ/eA5OjhPzP5DnOfake8tuclCLsS6aoMB
	 8XmjjwbxlyN8+yOxEWUy5aXAaHcqu0E7UnHj4JizrIVpcTPVIhJkMbQwjDnpVCS6eFVVk
	 436VvZrUT1wDiO0waRc9wdtmYtDtYIQM4074XFgXK5vUwqdYhGgg12efoaU4uZdA9iKhy
	 O/3iQm/5FcTRCKj/fWJ9lTKmpIIgCtk3BdB1UPZ5x09CkrmKXNn9WbngnKRJBRS/ZN88b
	 OtcHiL9UthQq6TTQrwMtZNz8bY3049xpJto23TP4hpmIzUwRdq44taHwq9mOwF6kQBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793472480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OsAJufUwx/rly65UeH7Yxg2hRFLBDQv8W6ubwyY/8R4=;
	b=ohJLEiiLxEiUaP4Llsb4tzST8jASVfUFahj0YvuaC9NPMkFtCiKqRTxvlLFoJIgfMb1i
	 2mQtLIjuPd4xo4XRwRcW5DnFwlzqDf5RapacBblb1yVUIZvNAYSnyYRhYhNU2gNFg2xoK
	 nk47vbQ0ubP58naYtAc+FtZUblTyVa5tCyVEW2gML7qIykPZbUMYMI+KrCIMjcZtTj9Kt
	 5kt0n+goKdl49tYyjXnWMvtoqhK5TbfCHsUyK9t1qsEvvM7QJ05lk7Y+kHelUxXQxd5zL
	 Z88Ibaiv7BttO1yLbndk6aKe6HnPk/QOCGu9RmUGNnAe2Nx6ucMM1P5Wfvb7tYqYUCw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=M3lg3PN5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.51
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE5D606A31A
	for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 18:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EE5D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=M3lg3PN5
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-4a85c656c58so1148071fac.3
        for <linux-input@vger.kernel.org>; Sat, 31 Oct 2026 11:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793472479; cv=none;
        d=google.com; s=arc-20260327;
        b=oTzNfA/fFCPT5qBdPsHwVsOMj2L9YYeDYQQM3KCXk6bGG1hVGuXkqBCXEdvVTI+1yd
         AqKG3s1owFAr9inGOzQGmW5mbYUPUtPiHoO6SY/KFCA7gsHm6FfhlvLWo7Ws8vMjah/v
         WbpA+Mi4aT34svwUnwJZt7pf4qcDiH2TLZLz4lKEsHAl/bMTNbcFE7sK1KaakZcPjG6N
         2PuaoX9mj3o4/QpyvDZNzWIT6ym48a3IcIeJdBhE9OIlZeGS2AHKnoyLkaTIQ5K50wfS
         9y5CW0bnKck2HzoEkW+Dio8vj+jzZ2GH3p5vk4MZC5XLUIRdarSKzNxbu0wMNFcnwAOL
         Dc7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=OsAJufUwx/rly65UeH7Yxg2hRFLBDQv8W6ubwyY/8R4=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=QFXg8CAJB9x3TLGcrg3rl5EcPP5S/OHNWLA3g7iJqZFoyJiUwz1AUus6F1KmU6azTC
         gLfIl/AFOwpRznAAR1vbaJ7J1gRsLVqefbE2FS7I8XAxokY7EuGRWGs4LJ7oAitCj2Oc
         sIQ+QnXP9SqRHBJASfSPKLenzgt0pYUxTN3WRNU4PyuSEOMtlk2ol8rXAunLh1k0YgJX
         EhJU4NYUCvH4The9dSVlK0zSaWGk+WWumF2ARrt5sURpcA9YoYy2CY2P5MPpJeZZ1mxS
         HhGvdv7SRKuB8do2NkM1dpT73EkerqtxoAxqwnCf4ux2CoVWX/q8rr3q/miiAwgbt6Ty
         qzWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1793472479; x=1794077279; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OsAJufUwx/rly65UeH7Yxg2hRFLBDQv8W6ubwyY/8R4=;
        b=M3lg3PN5isKn/7ZiwS0qJ0/6XksyuzadAl6LP4JHHjUQKzHWlKbCkq1rBxdTFVgDTF
         U6/P0/XCNXHec4txO+o8Bf0WYAm1yrEaS5TcIdFHCSApvAMJWPE5B3y/IIKBvyHw8cIO
         fvv6Hb3kDIk/c0AuwWSZik+QiggutCsL/G4v+hwTyXVCAZR2GZwNu5uOIAsWdmGIt2Tl
         yCOMCvCZiV/PIX3LlCdzPW4FzbtOU80C8gPigxU9eZYnhps1xv9EKwyNFYpBNCPkcLJp
         NzderIXUOCCQuNFoNQvqbDQwHvQ6t5qjT9fedNL8nomuTHoniWLdKT6Ez6bl12zsO+sE
         5+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793472479; x=1794077279;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OsAJufUwx/rly65UeH7Yxg2hRFLBDQv8W6ubwyY/8R4=;
        b=TCGVEu72f0k7DFA/8Q3Q52uimVJJpXVMmIDZe+stS46MFA5G6SH+GTCM3GVOO1pz/b
         fP04Tl0L1nBV4iCiw+/G6+EqF9EgGygVxtFIwU0LhqzN5e1x2LZREz8gib5MmyZZ6Xbj
         TUbzBJgs7cIS0dHoPZq5elZXAmhG+I73F94zz+DQJuIB/KcIX1boXRhBI6pIi9wizzX0
         aD8chJp1vTMTi3+45DuZZ4LNh4e+fwmDDgeOrnCV7tBs4Kxf5+EQAxSz/SfBhrFDwtiW
         tTezWkLkUw5fHckpNkzCZYtWputFu04VM/Fs9Ow/3W4Tm10aG1STOjzlfAi4EZqmSUE7
         drGQ==
X-Gm-Message-State: AFq9FYKCI4BPFZ08JIqKOutRcUHeAVrnujPIq46BlAMKxTt3QyexvjZc
	Dh6AMxnMoSdyYWODSxTcWJRL5dQbx8e5vIqyhf8xPcGDMHREW52Fj03u0Iafui7sZ0ZeAanJZVu
	E1uusRZHwAo2doUpv4h+H6oyA7u+5cEYL1YPG
X-Gm-Gg: AYBFou3CXziWw79MMOmwE4/S7JDnbgYcexGBB1Ug/wZefD/hwcREx9YuhxYXYQutjDq
	fG5t+dcFsh6mRWdSWKSuyEA7xm/1fKkt+KhZIqAkAAte9utkpxCnVvBOULXuftwjuxQVHy+hRBW
	ucOt7wZxrXSPMN55/rQbLXy1/mgyR4IQdx+0mXMkFwy5v4IDHWpFfcq1TfCarRboyG/5Cc7L6ud
	kNqTx9I7cJ06m4jn+9OhNbJxaOgEGIZ0TmDM2n9/nxQdgt817n1KM/2ChuWnIqIExFatXx63+JV
	zmYdJiAE+N7GrYpWdM9qBG4ZpIYtWRdXbRFELd1+vooBY37sMoJV4sH0g99ebs70VdvLbTDRpJJ
	86kIK7i2nmLApfP7h6lSTTAKXvbZzE5zyo78fnGjmrbrj77IXksHnMaJPivNSw+Qiv8rKjTg=
X-Received: by 2002:a05:6870:de10:b0:4a7:5256:4643 with SMTP id
 586e51a60fabf-4a9072cd014mr3523253fac.3.1793472478982; Sat, 31 Oct 2026
 11:47:58 -0700 (PDT)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Jannis Haesihus <ador43@googlemail.com>
Date: Sat, 31 Oct 2026 19:47:48 +0100
X-Gm-Features: AclHuK--mVydONffoOxCQ5JSQ6Mm-A9DabOw9tQt81v-Cs3JSzqmRI2XZm_Uz6A
Message-ID: <CAKW8xf_AE4do5yBnHsfnPiXVAkJifPB4=Gt6Q4T0ZmddUN0Sqw@mail.gmail.com>
Subject: [BUG] HID: steelseries: Arctis 7 receiver disconnects since 7.3
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there,

I noticed following bug:

System

    Distro: CachyOS, KDE Plasma
    Kernel: 7.3.0-4-cachyos (updated from 7.2.9-2 on 2026-10-24)
    Device: SteelSeries Arctis 7 wireless headset, USB receiver
1038:12ad (bcdDevice 1.19)

Behavior
Since the update to kernel 7.3, the USB receiver of my Arctis 7 keeps
disconnecting even though it stays plugged in (its LED stays on). KDE
shows =E2=80=9CUSB Device Removed=E2=80=9D notifications. It only happens w=
hile the
headset is switched off. As long as the headset is on and connected to
the receiver, it stays stable. Replugging the receiver several times
sometimes makes it stay connected for a while. The problem did not
occur on kernel 7.2.

Kernel log

kernel: hid-steelseries-arctis 0003:1038:12AD.0009:
input,hiddev99,hidraw5: USB HID v1.11 Device [SteelSeries  Steelseries
Arctis 7] on usb-0000:00:14.0-10/input5
kernel: usb usb1-port10: disabled by hub (EMI?), re-enabling...
kernel: usb 1-10: USB disconnect, device number 22
kernel: usb 1-10: new full-speed USB device number 23 using xhci_hcd
kernel: usb 1-10: device descriptor read/64, error -110

What I ruled out

    USB autosuspend: Disabled via udev rule, and power/control is on
for the device. The problem persisted.
    USB port / hardware: The problem also occurred on a rear motherboard po=
rt.
    Receiver defect: The receiver works stably on a Windows laptop.
    Interference from the Xbox wireless adapter plugged into the same
PC: With the driver blacklisted and the adapter plugged back in, there
are no disconnects.

Finding / workaround
Blacklisting the new driver fixes the issue completely:

echo 'blacklist hid-steelseries-arctis' > /etc/modprobe.d/no-arctis.conf

With the module not loaded, the receiver stays connected even with the
headset switched off for an extended time. Audio works normally via
snd-usb-audio. Only the battery reporting is lost.

Suspected cause
Kernel 7.3 newly binds hid-steelseries-arctis to the Arctis 7
(previously only Arctis 1/9 were handled). The driver=E2=80=99s status/batt=
ery
polling seems to make the receiver stop responding when no headset is
connected. The result is a timeout (-110), and the hub disables and
resets the port.

Best regards,

Jannis
