Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DAA3BC660
	for <linux-input@vger.kernel.org>; Thu,  2 Apr 2026 11:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775127986; cv=pass; b=hZqOXfty1IfNX2Psi1Wyt5fB4AIzdBt0UwgMYemDFbZgjx92pRDZbQz6lf+i+xaAnTOoP0UchAyqDmhPK7V9ZLQZqy0BhlRA7UvqVJv5pDfnVsRyPJG4vXgySbXQrNvS+t2oQM4a4vhpX/18XKxdJLvNT30bS2N6cjyTuysJIy8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775127986; c=relaxed/simple;
	bh=NSh6yIN0BHnkGF7khR3HCZiFXn+Vf6SCCfxbZ/iwsQU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=mc/Bv9vSgGwdRtz/yxAkexPEdmdrqnERIilDwPmr/BFX5vrCUzMaj8Nt+a91JGHlnEBWHm5VsqLw612Z88JcOVOc2XkvK+X6bD6+xpKDmXqEfuH3vRodKOulJktmKztXf1IVxjHt1dR7mrb04c3aIV2ENmxU6S8YKq/nrshXnTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6MQaG1p; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6MQaG1p"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7653db148so436475a34.2
        for <linux-input@vger.kernel.org>; Thu, 02 Apr 2026 04:06:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775127982; cv=none;
        d=google.com; s=arc-20240605;
        b=VRyaWutNFExj5kBCWKbmhTjOhMrazsfS27HMx4evqWXymXULcP0mn14kQN7ZpBa5je
         ig+R8j9m0aMuDNBy2Br8WI3XBKlhvu/Vwsy6nX/BQFNKBrno/g3PZHLLO0/7qXLC6Otp
         w/TzbE9Rwodk7Clt16ZNfOTzhbROAaLWFFVnCSINcXzVZF0VdoZxDNKvqjUF0Dq9Oxm8
         2smjz8FIuBRprKAyN5btAttHe/67oyuyUn2SVi4RLqd9XSW6oU2KuSfHGUrzLArId+7y
         XKksce+Q2AAP/CCVgGoKHMwWZraucQ4DgdzO05nC0D+3PpKjrHiNxLTxlORADbWj63Oi
         h3cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=rWCiKiJiKUSTMQNR96CjMBWL+6C7IlDR052GDEapvx4=;
        fh=Xq6RRb9M3aHxcP3JXJsOxF302/V4FDVhjnoKYC9vUfg=;
        b=QJSXXPXT1qWWAKm9+x5liwz/I2v3s27m3oYFjYDr+vfpsDl1Dh2zBekLXPsmEGBYIS
         YsHTwCvXx/8bZqmzXyRnUNDBT6cLHLDSlhFCjZ//KERcPkGmUqUzEr4sAPUgQ0BE/Af7
         1yMDeMWvo5wNZMgJOhJdMh6xtqjpFiJ8A/KKogr3s8LtrVkgGSiAQZFglQiEEjDi9Tot
         Ixms8jETF8HmbCV44G3uM/dk3IbirBY9Q6jZjXOD9dPpwfIy4UwBACyJIzoxqq+yNb+M
         KpkkRBWuHLrBdUsAzeh/Aur83fX2BEbismsTvwLcT1f8PbaGOUl0chVmQbzYtXQPZXgs
         CHzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775127982; x=1775732782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rWCiKiJiKUSTMQNR96CjMBWL+6C7IlDR052GDEapvx4=;
        b=G6MQaG1pURHpLku9X7N2Ohznho2Qoa6O+BeWvYtmnWYUnFaBnggWNMMGP1/tIaJvje
         ShvveJNoJxJ+DkyTd0oIcpUY/0RFH/+6EePX0YoJD0j5CLBAzWwZNm6C9arPvg3uI659
         hsUmGf/X9LCSJ32+I9c58Mh5f/c3sLi0Ao53UJONi4fD0fPJG307cewWfVUPtxr2uvjW
         AmTxx1p7xGaUVbdPG7zkGpnmG0anPtuiWbbWxR15Ef8M22Xa3NcYQqRp62EQjh0MOQDy
         7NtkNOyMaNqibSX2CJjt7v9xilgb+K4flwud3Up0W0mrdyNG0XyutJiuPmtMGGXywFmH
         zHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775127982; x=1775732782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWCiKiJiKUSTMQNR96CjMBWL+6C7IlDR052GDEapvx4=;
        b=p54jtlFJeG+pY0e3I2JNtvXKFt6uBBQiHQLMlOiWsuUg+CgW9hkgq5bsQBaRulXpNm
         2lDUIQSEDWIqIWJjHZrVtEgVz5/T/+pHIpolCAsjw4tIWJSI1fzaaq+tXi4frJgPXQBg
         1SJ6wcPsklznBvgAbSXhGQm3H7hXf/iEZMOeb+TxnHspg/9rJnp+D4VaPOx9lVIuJkMY
         UzGRFtsTjZqHYdFTMieAXen3o6Mv7CAHJxhsl9O30SrOdWILOmAsiz9yLmuZEzolkPI7
         3BPjkz1gNAmtD235SaIOZk7syWt6gm+psvBbqRxYa8Wdnxn5CsoYqKiOot2/WSXri1lr
         r3fA==
X-Gm-Message-State: AOJu0YwMZDz7jbOXTkw4PSpsr/zBJn9MFBdSE5yczl2P74O/cBBl1tk+
	nL7PmOQjCyIh09sV22Fn71IuWzI0HjmcFM8lKXghRn753DttYU1jE8BgsF9S8afzSK7nvkueRyZ
	mR2xgQOq/bvtBvLGCjDaSfWP1sX6ek5nYhtCf
X-Gm-Gg: ATEYQzzTlEPiwXPprwHfYpiN5UKxWaEvTFvvOY7p97640kFDaszeNyZ781X0oCdM6za
	/gJNcJs7IBAYsaAXYCRWp/hhiLQ7BycX9wz9PO8Bb8qFHQsUKhKI9DiViAcZMsnpzPcr5fE2vA1
	eTJMmKr+jK2R5bkghVavuk/bOQzrzjQQwIaSZj1CFXw65Ekrk2b9rtHyXDk1hvyinM5zxdRdpMo
	7bBmdYlaViw09Sfuwo9c77f74u/XFNOWF/l7U0vlEz4EL5DmTk227ownEsxurVG5dU9RYgDqqDQ
	HMuvAho=
X-Received: by 2002:a05:6820:3083:b0:67e:1be2:59e1 with SMTP id
 006d021491bc7-680a5edb59amr1590758eaf.18.1775127982160; Thu, 02 Apr 2026
 04:06:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris <elvis.kelly@gmail.com>
Date: Thu, 2 Apr 2026 12:06:10 +0100
X-Gm-Features: AQROBzBNDxAuU-KMO-uvc38zCeOJyYWCPXLGXXp1y5prZAlk0AUOvHhXTH1_AcI
Message-ID: <CAAi5AcpJ6E4cRxQna73VNbJLt9UK58uV5c_EGOZ0a6x3VtLZ0Q@mail.gmail.com>
Subject: =?UTF-8?Q?=5BBUG=5D_i2c=5Fhid=5Facpi=3A_Synaptics_touchpad_stalls_after_?=
	=?UTF-8?Q?=7E6_min_idle_=E2=80=94_firmware_sleep_notification_unhandled_=28Dell_?=
	=?UTF-8?Q?Latitude_7420=29?=
To: linux-input@vger.kernel.org
Cc: linux-i2c@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I'd like to report a reproducible touchpad stall on a Dell Latitude
7420 that I've traced
to what appears to be an unhandled firmware sleep notification in the
i2c_hid_acpi / hid-multitouch
stack.

=3D=3D Hardware =3D=3D

  Machine:  Dell Latitude 7420
  Touchpad: DELL0A36:00 06CB:CE65 (Synaptics)
  Bus:      i2c-1 (i2c_designware.1, PCI 00:15.1 =E2=80=94 Intel Tiger Lake=
 I2C #1)
  Driver:   i2c_hid_acpi + hid-multitouch
  Kernel:   6.17.0-19-generic (Ubuntu 24.04, Wayland/GNOME)

=3D=3D Symptom =3D=3D

After approximately 6 minutes of complete idle (no touch or keyboard
input), the touchpad
stops responding entirely. The driver remains bound, all three power
layers stay active/on,
and no kernel errors are logged. IRQ 162 (intel-gpio 327, DELL0A36:00)
stops firing.
Rebinding i2c_hid_acpi recovers the device immediately.

=3D=3D Reproduction =3D=3D

  1. Use the touchpad normally.
  2. Leave the system completely idle (no keyboard, no touch) for ~6=E2=80=
=938 minutes.
  3. Touchpad is unresponsive. IRQ 162 count frozen.
  4. Recovery: echo i2c-DELL0A36:00 >
/sys/bus/i2c/drivers/i2c_hid_acpi/unbind && \
                echo i2c-DELL0A36:00 > /sys/bus/i2c/drivers/i2c_hid_acpi/bi=
nd

=3D=3D Trace evidence =3D=3D

I captured ftrace i2c events (filtered to adapter 1) across multiple
stall events.
The pattern is consistent across all captures:

  1. Normal multitouch packets at ~140 Hz while in use:
       i2c_reply: i2c-1 a=3D02c l=3D64 [20-00-03-03-<X_lo>-<X_hi>-<Y_lo>-<Y=
_hi>-...]

  2. After finger lifted, ~30 seconds of silence, then two unusual
packets fire in
     quick succession:
       i2c_reply: i2c-1 a=3D02c l=3D64 [40-00-0c-06-00-00-00-00-00-00-...]
       i2c_reply: i2c-1 a=3D02c l=3D64 [0f-00-00-00-00-00-00-00-00-00-...]

     The first is a 64-byte report (length field 0x0040) with what appears =
to be
     report ID 0x0c and sub-type 0x06. The second is a null/empty packet
     (length field 0x000f, all-zero payload), consistent with an
end-of-transfer signal.

  3. No i2c_write from the driver follows these packets.

  4. ~140=E2=80=93380 seconds later, the same two-packet sequence fires aga=
in.

  5. The IRQ then goes permanently silent =E2=80=94 touchpad stalled.

A representative excerpt from a stall trace (timestamps are kernel
seconds since boot):

  2565.349  i2c_reply [20-00-03-01-64-02-d1-01-...]  =E2=86=90 last touch
packet (finger lift)
                                                      =E2=86=90 30s gap
  2595.511  i2c_reply [40-00-0c-06-00-00-00-00-...]  =E2=86=90 unknown repo=
rt
(sleep notify?)
  2595.522  i2c_reply [0f-00-00-00-00-00-00-00-...]  =E2=86=90 null packet
                                                      =E2=86=90 378s gap
  2973.423  i2c_reply [40-00-0c-06-00-00-00-00-...]  =E2=86=90 same again
  2973.435  i2c_reply [0f-00-00-00-00-00-00-00-...]
                                                      =E2=86=90 stall; IRQ =
162 frozen

The same 0x0c report appears ~6 minutes after each rebind in
subsequent captures,
with the stall following within 1=E2=80=933 minutes thereafter.

=3D=3D Hypothesis =3D=3D

The Synaptics firmware appears to send a proprietary power/sleep-state
notification
(report ID 0x0c) after a period of inactivity. The i2c_hid_acpi driver
does not respond
to this report =E2=80=94 no i2c_write is observed following it. The firmwar=
e
may be waiting for
an acknowledgement or handshake that never arrives, and locks up as a resul=
t.

This is consistent with:
  - The stall being time-based (not load or temperature dependent)
  - Rebinding fully recovering the device (firmware reset via HID RESET com=
mand)
  - The IRQ going silent with no kernel errors (driver still considers
device healthy)
  - libinput occasionally logging "Touch jump detected" immediately
prior to a stall
    (possibly the firmware sending corrupt data as it enters the sleep stat=
e)

=3D=3D Power management note =3D=3D

The device hierarchy (PCI 00:15.1 =E2=86=92 i2c_designware.1 =E2=86=92
i2c-DELL0A36:00) must all be
pinned to runtime_status=3Dactive to avoid a separate (unrelated) class
of failure where
the I2C bus autosuspends. That issue is already worked around via udev
rules. The stall
described here occurs independently, with all three layers confirmed
active throughout.

=3D=3D Workaround =3D=3D

Rebind the driver after ~2 minutes of idle via a watchdog script
monitoring IRQ 162.
This preempts the firmware before it sends the 0x0c report.

=3D=3D Question for maintainers =3D=3D

Is report ID 0x0c a known Synaptics vendor report that the driver
should be handling?
Should i2c_hid be sending a SET_POWER or RESET in response to an
unsolicited report of
this type? Any guidance on what the correct driver-side response
should be would be
appreciated =E2=80=94 I'm happy to test patches.

Full ftrace dumps available on request.

Thanks,

Chris
