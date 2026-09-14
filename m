Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96552B9BA
	for <linux-input@vger.kernel.org>; Mon, 14 Sep 2026 00:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789344879; cv=pass; b=G00oOjFMjlmgR1e9OS6+02+XLGCpaIKBEI92+3q0FuFDQ+fPIe9ZKcxuqeuBMpY33asJoN45/B7CJz8rJeWWf1o+ZuoA8rBMxlEyw73fIpZGROKY70pmhXR342xOKaAvpV2bS0ic39aHPFIwCP7qVCZYdfyaRulXZtsWkX9+4H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789344879; c=relaxed/simple;
	bh=0KQvZGf2eNt3Mx4LM9oUUNQs5a57MPGyv6ITNoGIRz0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=q0Fgu9ZPSmo34xEHJmbTKsY56v+B/TrgBvdWwuFRtHusxpORmAsrqXtxui225IBGdpsqnF02sPsCOYbNgdQjBMCKMInXl7JyWvhtjaRZSCkd8H/ceC7WXSYB6+E7z9FceBYzXSZH7lddXWijONJ2KlGbYlc3JO2HQdfj4ZFjoj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiHjtiAk; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiHjtiAk"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-87f4e914a45so23860857b3.2
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2026 17:14:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789344876; cv=none;
        d=google.com; s=arc-20260327;
        b=iHmj7n1WJNOnyTXdKKQ4h9jl/KjtIHnh5ZBkAG2ulZLe1cjwQz9t8+Or9F+yncTkCh
         kBMlHpoHiYHsze2RQb5wUlliEwX8WAfe3siX93ElVg9dIA1LoKXwI71bytRTLr1zlQ8s
         k5pI2AOYyANnfmX0EGUdGl3IdoMxZSc/RfAmZ2B12vwJvalQXbT1eTH1ajZhR9M8HOaQ
         XpGIe02JlMvmw7UyDq5y6cLiAMik2tEmDWZjLQxkZTZJTynf+zjSU9Cw7+U+Ogy9eqTZ
         kqpNb9vUL5nzLeLyGjhC9YvjBF+hG7NuhuHDcsd9/M5wEcSEHy7XVPQpgTyttV0Ijlki
         cLLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=r/2B6U178W1eE+E/+IiAkp0EgjU8HZfxoZmvFhcpv4k=;
        fh=zm0eqUIu58e8TZ1PMEnGqkth6QStBbmOMnPL72qCE7I=;
        b=rgmKk/6HQWUuKgIaTIkaw/EwiEs2J/ENYomNgZ+ifSbQmhuFs1QRkZR/SUnpdJ++lm
         iUkwJzUUqynWHx56MYXClWmvVdBk9Bu5iKVKNJ1hjqCbuhcP5SkRw3N3ijTo4c2GHaAR
         XYCN8rR0IcblNn2hVRU3Hl4NBiRgZ8NpjeaAzHVQ4q/covksRIBIdYvtXWXfBY20J0hH
         dAnk42spz1l2nNGhshEvn42c9C4fqkPwHwyifcRGnY3Wf9lmwiBPZKYM6wM58Tvo0L4o
         jIgVYsb1rWRZPVIJM5+Njoa1Sdt+hLq9TNjU8eGaPWD1OV4zGPjaZKnu9RVWl7eoHYW2
         xVFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789344876; x=1789949676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r/2B6U178W1eE+E/+IiAkp0EgjU8HZfxoZmvFhcpv4k=;
        b=fiHjtiAkjSgYLmiqKxZ5O08Gz70TSq0sAhFsyh1+/osuEJ/rd79HGXHvz68W3Xc2F1
         yfmj51NLOwlKWV4AlZ+0WQlDo8v8hTmO0/C+c5DAUhYm7D7NPOa71MHTVcNM2Y1hMQrD
         yRpZ6GTqlkuTAVRjj3fqtXkYz4g4qCkuiYuryMIHFmJplVvVFFFyCwIRr1Qzkq7Irvxw
         NWTw3MN2g7Hf4ohsKcBXzqAsc6/J1Mq45HqoCTqdpOQO6FrF3lfEHuCfS656N9QwatD4
         +I/jVDp/HildcG/Vur76QcQtEBisJAR2XHfQeEvS9F/umJkjL5+KPVhIwRaZf6N1uFA/
         scaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789344876; x=1789949676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=r/2B6U178W1eE+E/+IiAkp0EgjU8HZfxoZmvFhcpv4k=;
        b=eYk1msq6c9MpSpq04J6XdwqRyT0VkeB5nijHI/pFv+VifLa7cnzCS098ZMOE+fFgMy
         iC+w9GZ2DpO1OsckVVw9xhDMNA/sdIyr7xn/3M1nr9secjucWiefqgy05a6eLQa5KXl1
         y53ER5fgEXDBCtd8pzTAU7sekUuiHb6bNNZ8ig30GJSmVyl46GUy2WCnXDdJF4KScbM2
         tqYl59vF3aDcNSvEFR8JPPRPIB+4iTDbzBdM8u6ofAgyPLgnYVS5h18HD6euswIdcVNr
         c6ldxFb6VCPiTyHEJtqJPHSQjfg7PfJa0kK1ZdMHRl+mUOq8gt6NB9xd3jrAh4015Nhz
         HNDg==
X-Gm-Message-State: AFuF++k0pY9UDWRra3uNtKxk3po8gYrEK7Tu7CmLXdRXEGngJudex1XV
	O3JmeUmL2VSM5i92xttG7vwJhu7oHb6ISfNlo3uBVzYfqypM7Cs22H1HyDMb/gJ1nbN1VharUat
	wSo8kY4Mshx8+/+HkyVUCoupFW9UVcwMv+lTJc9A=
X-Gm-Gg: AYBFou2kqH4O8zcH61H92Jsr+Pxqzw+i4FGhSyXJGdGncNmQgGh/wnbHileq6oe2QMU
	+8Ztfz6lW2UYMiFisR/rv82ohXDzTjy27IoeqsGmZtiZkn9uOr0wohhpk0gV7aKkoHlLsKgDb3q
	cEFL1RlviUGFbRvVDehf5j0NteSTjQJVlM4bqPOfdrXLy4xs6WkbreFLmt5Jq7lxJOKqQw+w99x
	krk56JJOEAW7tAFBvMFyEl+x+05yWOo2cAnkcw7a3KXzY459ahfS5G2hn+9/pLeliPvVkIWRAAi
	c9tGF9RbumLYkzniiv9hthha/IxI+S/WD1xTc6TvxU1VjJ23CJyT+vaPD0lIJ15CysXVKu2ECse
	/RaT+wUADQfDbMuE47Kw6URc6q7iKSigQAC9jBg==
X-Received: by 2002:a05:690c:9990:b0:85e:688f:3c52 with SMTP id
 00721157ae682-88d218333fbmr1035137b3.33.1789344876540; Sun, 13 Sep 2026
 17:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pujito Adnyana <zhee.tou@gmail.com>
Date: Mon, 14 Sep 2026 08:14:24 +0800
X-Gm-Features: AcwNN1UQSyl0b5EaIAq6TuIl5Dr2LpHbX5QEkrm4mUgWJ7xH8SeB5qeZ3wf1RWA
Message-ID: <CAEkMyrhPTh1Ws0Co6zHBq1aMhrhgam4yPBgbXAMPrffyAKpT4Q@mail.gmail.com>
Subject: Internal keyboard dead on ADVAN 1405 (APN21S-140P3-CS): i8042
 controller OK, keyboard device never ACKs
To: linux-input@vger.kernel.org
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

The internal keyboard on an ADVAN 1405 laptop (AMD Ryzen 5 3500U,
Picasso) does not work under Linux. The keyboard works correctly in
the BIOS setup utility and in the GRUB menu, so the hardware, the FPC
cable and the embedded controller are all functional up to the point
where the kernel takes over the i8042 port. An external USB keyboard
works fine, and the I2C-HID touchpad on the same machine works fine.

The i8042 controller itself passes its self-test and responds
correctly to every controller-level command. The keyboard device
behind it never acknowledges a single keyboard-level command, and no
scancodes are ever delivered.

System information
Model:        ADVAN 1405 (family "soulmate plus")
Baseboard:    SU / APN21S-140P3-CS
BIOS:         American Megatrends 2.03, 09/05/2024
CPU:          AMD Ryzen 5 3500U with Radeon Vega Mobile Gfx (Picasso)
Kernel:       6.19.10-300.fc44.x86_64
Distribution: Fedora 44 (Workstation)
Firmware:     UEFI, Secure Boot disabled

DMI strings, for a potential quirk entry:

sys_vendor:      ADVAN
product_name:    1405
board_vendor:    SU
board_name:      APN21S-140P3-CS

This is not a regression introduced by a recent kernel: the same
problem was observed on Ubuntu before this machine was moved to
Fedora.

Symptoms
Internal keyboard produces no input at all under Linux, in the
graphical session and on the text console alike. Not even the Caps
Lock LED reacts.
The same keyboard works in the BIOS setup utility.
The same keyboard works in the GRUB menu (arrow keys and Enter
navigate the boot entries correctly), i.e. it is still alive after
UEFI hands over to the bootloader.
An external USB keyboard (04d9:0203) works normally.
The I2C-HID touchpad (093A:0255 on AMDI0010:01) works normally.
Kernel messages

Without debugging enabled:

i8042: PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
i8042: PNP: PS/2 appears to have AUX port disabled, if this is incorrect
       please boot with i8042.nopnp
serio: i8042 KBD port at 0x60,0x64 irq 1
atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
atkbd serio0: Failed to enable keyboard on isa0060/serio0
input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4

The input device is registered, but it never emits an event.

i8042.debug trace

Booted with i8042.debug=3D1 i8042.unmask_kbd_data=3D1:

i8042: [0] 20 -> i8042 (command)
i8042: [1] 65 <- i8042 (return)
i8042: [1] 20 -> i8042 (command)
i8042: [1] 65 <- i8042 (return)
i8042: [1] 60 -> i8042 (command)
i8042: [1] 74 -> i8042 (parameter)
i8042: [1] 60 -> i8042 (command)
i8042: [1] 65 -> i8042 (parameter)
serio: i8042 KBD port at 0x60,0x64 irq 1
i8042: [2] f5 -> i8042 (kbd-data)
i8042: [211] ed -> i8042 (kbd-data)
i8042: [418] f4 -> i8042 (kbd-data)
input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input4

Observations:

Controller-level traffic is entirely normal. The CCB reads back as
0x65 (keyboard interrupt enabled, keyboard clock enabled, translation
enabled), is temporarily set to 0x74 during probing, and is restored
to 0x65.
A controller self-test (aa -> 55) passes whenever it is issued.
Every keyboard-level command (f5 disable scanning, ed set LEDs, f3 set
typematic, f4 enable scanning) is sent and never acknowledged. The
~205 ms spacing between consecutive commands is the command timeout.

Forcing a reconnect via

echo -n "reconnect" > /sys/devices/platform/i8042/serio0/drvctl

reproduces the same pattern. On one occasion, and only once across
many attempts, a late acknowledgement did arrive:

i8042: [943273] f6 -> i8042 (kbd-data)
i8042: [943474] fa <- i8042 (flush, kbd)
i8042: [943474] Interrupt 1, without any data

The fa arrived roughly 200 ms after the command was sent =E2=80=94 just pas=
t
the timeout, so the driver had already given up and the byte was
discarded during the flush. The accompanying "Interrupt 1, without any
data" suggests IRQ 1 was asserted while OBF was not yet set when the
kernel sampled the status register.

No <- i8042 (interrupt, kbd) line is ever produced, under any
configuration, when a key is pressed.

ACPI

The keyboard is declared in the DSDT as follows:

Scope (_SB.PCI0.SBRG)
{
    Device (PS2K)
    {
        Name (_HID, "MSFT0001")
        Name (_CID, EisaId ("PNP0303"))
        Method (_STA, 0, NotSerialized)
        {
            Return (0x0F)
        }
        Name (_CRS, Buffer (0x16)
        {
            0x47, 0x01, 0x60, 0x00, 0x60, 0x00, 0x00, 0x01,
            0x47, 0x01, 0x64, 0x00, 0x64, 0x00, 0x00, 0x01,
            0x23, 0x02, 0x00, 0x19, 0x79, 0x00
        })
        Name (_PRS, Buffer (0x18) { ... })
        Method (_PSW, 1, NotSerialized)
        {
            KBFG =3D Arg0
        }
    }
}

Points worth noting:

_STA returns 0x0F unconditionally. There is no _OSI-dependent branch,
so the firmware is not hiding the device from non-Windows systems. For
completeness, several acpi_osi=3D variants were tried anyway and made no
difference. (acpi_osi=3D! on its own additionally kills the backlight on
this machine and leaves the display blank.)
Resources are entirely conventional: ports 0x60 and 0x64, IRQ 1.
_HID is MSFT0001 with PNP0303 only as _CID. Linux matches on the _CID
and enumeration succeeds, so this does not appear to be the problem,
but it is unusual enough to mention.

The keyboard device and the embedded controller share a parent scope:

MSFT0001:00 -> .../LNXSYBUS:00/PNP0A08:00/device:3a/MSFT0001:00
PNP0C09:00  -> .../LNXSYBUS:00/PNP0A08:00/device:3a/PNP0C09:00

This suggests the PS/2 keyboard is emulated by the EC rather than
being an independent PS/2 device. The EC itself initialises without
complaint:

ACPI: EC: EC started
ACPI: EC: interrupt blocked
ACPI: EC: EC_CMD/EC_SC=3D0x66, EC_DATA=3D0x62
ACPI: EC: interrupt unblocked
ACPI: EC: event unblocked
ACPI: EC: GPE=3D0x3
Kernel parameters tried, without success

Individually and in combination:

i8042.dumbkbd
i8042.nopnp
i8042.reset
i8042.reset=3Dnever
i8042.nomux
i8042.noloop
i8042.notimeout
i8042.probe_defer
i8042.unmask_kbd_data
atkbd.reset=3D1
acpi_osi=3D! acpi_osi=3D"Windows 2015"
acpi_osi=3DLinux

i8042.dumbkbd is of particular interest. With it, f5/ed/f3/f4 are
never sent, the CCB is left at 0x65, and the keyboard is left in
whatever state the firmware handed over =E2=80=94 yet still no scancodes
arrive. This suggests the firmware leaves scanning disabled on
ExitBootServices, so the keyboard genuinely needs the f4 that never
gets acknowledged. That leaves no working path: with f4 the command
times out, without f4 the keyboard is never enabled.

A cold EC reset (full power off, adapter removed, power button held
for 60 seconds) was performed before testing and changed nothing. The
machine has no Windows installation left, so no cross-check against
the vendor OS is available.

Question

Is there a way to make atkbd tolerate an acknowledgement that arrives
just past the command timeout, or to retry enabling scanning after the
initial probe? If a DMI quirk is the right mechanism here, I am happy
to test patches and provide any further data needed.

Full dmesg output, the decompiled DSDT and acpidump output are
available on request, or can be attached if preferred.

Thanks for your time.
Pujito Adnyana
+6285935178773
zhee.tou@gmail.com
