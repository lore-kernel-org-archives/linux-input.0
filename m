Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2BE23EAAF
	for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 08:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341530; cv=pass; b=GOfXogIUjxMa4XzMPhchujCUlvE0VpbRAc1hjXQO+XqJtwvyCqeEFpR4khSufDw4yvpX+pECk9eKH15MClz0oqG1kbPz2RMmjREkC06i/tV5zVzxavU7WT5WXi+iQDPmogldhcBYtP4QSDsb0/GILX2UV6LCNkSFctawgd4auSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341530; c=relaxed/simple;
	bh=HmN2KKgqFRpjq5BoXcFy23mPGIm3MKUxOnkjqUDmDAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SAwzZZLckALVv5oT85IN+dXuDYcHGQma3FnQvPlw80lpjayk5sQo8eAuMz8V9M7IHLttrFPV6Jkn8/uKx92ZJAxyPTWnDORJnB2bPgbrtusmO/PP3hfUxdDJws9FTcQVRrdDqZNncW0GFjMKqaCPpEJMfoLLCDIBU/bQlqiOlZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tM+K7GaL; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tM+K7GaL"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9382e59c0eso582040966b.0
        for <linux-input@vger.kernel.org>; Tue, 24 Mar 2026 01:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774341519; cv=none;
        d=google.com; s=arc-20240605;
        b=dzVWHRzjilKRqsIall6kiZN9H7ejemKEaKfMtj0qWtxmt0MGlB3uPVQ1yn+hDeiEX4
         WwKucoQ26XKuK9Q10cUGm9AOg/b7Sut3KIShgPb76Rqj4t/sYNNAfc/DobtM+IchIgM7
         Qjoj5g83Xz461BOy6H/XJhLCsJgUjMLp9RWxxWeIgFALE8qDr6egfWLSgZDwExqskcMh
         1dqkd749WywwrcKDJk8p/dg0ET+q1m4ceOUD7gwrebHOgNgs3vLhIjhfGp7zn3Ycv9Xi
         LQmQvqnMXrmz9p3qkv/ZInf9vh359veSq4LirkKk29QDw7hSH03VIM4Uh4UyMeh505q4
         Tnfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=DipTrzYVTNf50sGC2Q0RonRBk4V+v3+pNufvbwtoQ7E=;
        fh=xKIKs9OnmYLQJMOGNxHmXPJSEu/R918FvcYkPL3Q8wY=;
        b=cltA9JjbJn092a8hHlGesZ+5U73CyD3cUBVt0iiulWS3JB5r3ME9nKHgG3P4SI2gKb
         LSAHDC9plKm4II7v9akUrEp6GldYEip7oJAOSzWfEvpycJclhxEtakbDOeGBORBuYd6P
         WAkS1/J8VLUt2QvO1ZDwFQVO733UobvWofWbI++Z2DJ4lRN1vfBexeIvRgIxSTey+f9f
         MidP+1YgUfEZdVFxRYhfAdAmcuFBOlcXHOEqRumPls3N4DcJizv6SBGwjovlVtDMIWYB
         zI+mm3bpLC2DW457IjjxPUCdyptm/i2O9Py8FBKv5UhDwukc76iD4LGU46RBnkRggMEx
         hQxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774341519; x=1774946319; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DipTrzYVTNf50sGC2Q0RonRBk4V+v3+pNufvbwtoQ7E=;
        b=tM+K7GaLwsKK2g4Fpbua4gP7goy0rCSAu93yz83JNXVUqg7AcBE0MMNw5//P7AZrLp
         Jdeoh1u5UZDVRC2gYT73ZUPyuJYYDIDXD57A6lTJpsBE9AezQXsjIeVxgN74Utj8GEOV
         R4co8NpqCSHCOoRbuEa7FP8zvVKkArp/h6QjTmr0fhAcTmz2AtO72cWiFhA/To+/+tWJ
         ZybrbZkG/C01k2OY4Pkk4QZ9+64WDE1PbGBxU6wcMYBIMaTB1MgEc96N6ul8xXUESzZL
         +GKbpyQ17/hx8OLm0docQz2qZK+K4iPN5ysap+k4hVJO64VlNZDHcFViLd1B6ayCWzKP
         gf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774341519; x=1774946319;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DipTrzYVTNf50sGC2Q0RonRBk4V+v3+pNufvbwtoQ7E=;
        b=nPOe3edYXHEJtVxJriM5f/WHAkcGyedo2/PDwTQqXrnXCY9jkTk4/phWSug/OPSW7x
         cya1E9XRzCZXPzzXNn0ug0RG5MIFE7jhMMQOy6YDuQQkB/x3KQJgC00V8E+OnhQK8pI3
         dcteSUGenZg9MJkEpa1EvbwaVKrdyFLhFCR5/BrAEkJ/Mg8RrxkiTMdpgQM9cDcXvFm8
         p3TDAeHw31xhzD9fYqmcwSBh/bmnG38Rqj5zSqlBUn+TPY1YflvBvnMZHr78CbrFoqkO
         51P0b/PjesaceVc5DitXK0l+O+YCxzLaiRSIhiC12jQWIhWmjUTBb+5n5YZtedLYqufj
         1WUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuy6nVDMA6peRF/ABSwEQdzpqJ5UNViRzVQYACKcrbGE4lt5M21q5RUTl6OE1Btq2PFKfTtQqTmDNdsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9N1ZglcR7vAk0fbwdwMSTU3ZJ9svBi3wslxWWrdRuO3zKmFnf
	XWKov+bscgjWoZrCtyuQ+Q3JXeNoPTHcibwqslNcU21xiIziAlf8wRomLt88NRHapgR3bzXxHmC
	8xZt2PsP0ETvd2ib53W6O9F1Im8aK198=
X-Gm-Gg: ATEYQzy1ayN7Wp5giNWYDUGoE53sYV6EuwP6UKI+hOqWZt/bUX4HgK/y756zZEzvjGV
	KCTRxc+tjWHGZhzU3KnArHzLlq3uY6n1I6V91upfNnSKN58kqjRs2tIf/g9lKSj0Cn1D+h61Xqz
	iECK+RNEMV0sCdcaIp2JIUkXcJW8b3IYy5xgbTTfjQwKXOKSp91ABrfgOedARCes6nk0vq5AHgn
	aO3q+zMdgPHoVT3U62el50q51wiZUanF8xEfq7Bm/S4IgZeD46wVr1P2AJHcKDyKMixdlyETdBx
	KGUczXo=
X-Received: by 2002:a17:907:d842:b0:b97:cdcb:a296 with SMTP id
 a640c23a62f3a-b982f2454camr964253066b.19.1774341518655; Tue, 24 Mar 2026
 01:38:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJ0oKyQTEJit294y=fs2s2nzhzUs_GQzsgMswDNs==zkdiqz0g@mail.gmail.com>
 <CAJ0oKySkr2x3qgy4nj0S9bEAXsT08uWKeuy_cM4zp-9CmBkkrA@mail.gmail.com>
In-Reply-To: <CAJ0oKySkr2x3qgy4nj0S9bEAXsT08uWKeuy_cM4zp-9CmBkkrA@mail.gmail.com>
From: Ian Jensen <ianmoellerjensen@gmail.com>
Date: Tue, 24 Mar 2026 09:38:28 +0100
X-Gm-Features: AaiRm53sqDso4fTQ8LUlZDps2qxpoP-F0RLrdpM-butb4q7zli2wW8Gz3c4uIac
Message-ID: <CAJ0oKyR1qByqUD7pWBZY1xUom85FvCtN2OpnhKAM8_7EMx_7qg@mail.gmail.com>
Subject: Fwd: Internal keyboard non-functional on linux on Medion Laptop -
 NTC816 (Intel IPF) has no driver, PS/2 fallback produces corrupted scancodes
To: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000ee5e27064dc11312"

--000000000000ee5e27064dc11312
Content-Type: multipart/alternative; boundary="000000000000ee5e25064dc11310"

--000000000000ee5e25064dc11310
Content-Type: text/plain; charset="UTF-8"

Hello, I have been advised to send you an email regarding an issue about a
missing driver that causes the internal keyboard on my laptop to be totally
useless.

Hardware: Medion Signium S1 OLED (MSN 30040793)
Kernel: 6.19.6-200.fc43.x86_64
Distro: Fedora Workstation 43

The internal keyboard does not work at all in Linux, not even the
capslock button works. The keyboard works in Windows and in GRUB and
the touchpad works fine. An external keyboard also works fine.

On Windows, the keyboard is exposed through this device chain:

  INTC816 (Intel Innovation Platform Framework)
  -> ButtonConverter\ConvertedDevice
  -> HID keyboard (kbdhid driver)
  DEVPKEY_Device_Service: kbdhid
  DEVPKEY_Device_Stack: \Driver\kbdclass, \Driver\kbdhid, \Driver\mshidkmdf

On Linux INTC816 does not appear to have a driver. It does not appear
in /sys/bus/acpi/devices/ or /sys/bus/ishtp/devices/. The Intel ISH
modules are loaded (intel_ishtp_hid, intel_ish_ipc, intel_ishtp), but
only a sensor hub (8087:0AC2) is present on the ISHTP bus. The
keyboard is not enumerated there.

ACPI devices with INTC prefix: INTC1001, INTC1046, INTC1048, INTC1055,
INTC1078, INTC1092, INTC109C, INTC10A0-A5. No INTC816.


The BIOS presents a PS/2 emulator via i8042, but it produces corrupted
scancodes. Examples:
  - H  shows 0x20 (Set 1: D)
  - A shows 0x03 (undefined in Set 1)

The corruption is not a simple offset and does not match any known
scancode set. This appears to be a firmware bug in the scancode
translation.

IRQ 1 is not showing an interrupt storm (~10 interrupts per keypress),
so this is not a stuck interrupt.

Boot parameters tested:
  i8042.nopnp=1 i8042.direct=1                         -> corrupted input
  i8042.nopnp=1 i8042.direct=1 atkbd.set=1             -> corrupted input
  i8042.nopnp=1 i8042.direct=1 atkbd.set=2             -> corrupted input
  i8042.nopnp=1 i8042.nomux=1 i8042.reset=1 i8042.notimeout=1  -> no input
  acpi_osi=! acpi_osi="Windows 2013"                   -> no input

dmesg:

  i8042: PNP detection disabled
  i8042: Warning: Keylock active
  serio: i8042 KBD port at 0x60,0x64 irq 1
  input: AT Translated Set 2 keyboard as
/devices/platform/i8042/serio0/input/input3
  intel-hid INTC1078:00: failed to enable HID power button
  ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}: enum_devices_done
OK, num_hid_devices=1


The closest existing driver in-tree is
drivers/platform/x86/intel/hid.c (handles INTC1078 and similar).
INTC816 would presumably need a similar ACPI driver that enumerates
the child HID device and routes it through the input subsystem

I have attached my systems info

--000000000000ee5e25064dc11310
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr">Hello, I have been adv=
ised to send you an email regarding an issue about a missing driver that ca=
uses the internal keyboard on my laptop to be totally useless.<div><br></di=
v><div><pre id=3D"m_8821147756368769729m_6379330212724783127gmail-comment_t=
ext_0" style=3D"font-size:medium;width:50em;color:rgb(0,0,0)">Hardware: Med=
ion Signium S1 OLED (MSN 30040793)
Kernel: 6.19.6-200.fc43.x86_64
Distro: Fedora Workstation 43

The internal keyboard does not work at all in Linux, not even the capslock =
button works. The keyboard works in Windows and in GRUB and the touchpad wo=
rks fine. An external keyboard also works fine.

On Windows, the keyboard is exposed through this device chain:

  INTC816 (Intel Innovation Platform Framework)
  -&gt; ButtonConverter\ConvertedDevice
  -&gt; HID keyboard (kbdhid driver)
  DEVPKEY_Device_Service: kbdhid
  DEVPKEY_Device_Stack: \Driver\kbdclass, \Driver\kbdhid, \Driver\mshidkmdf

On Linux INTC816 does not appear to have a driver. It does not appear in /s=
ys/bus/acpi/devices/ or /sys/bus/ishtp/devices/. The Intel ISH modules are =
loaded (intel_ishtp_hid, intel_ish_ipc, intel_ishtp), but only a sensor hub=
 (8087:0AC2) is present on the ISHTP bus. The keyboard is not enumerated th=
ere.

ACPI devices with INTC prefix: INTC1001, INTC1046, INTC1048, INTC1055, INTC=
1078, INTC1092, INTC109C, INTC10A0-A5. No INTC816.


The BIOS presents a PS/2 emulator via i8042, but it produces corrupted scan=
codes. Examples:
  - H  shows 0x20 (Set 1: D)
  - A shows 0x03 (undefined in Set 1)

The corruption is not a simple offset and does not match any known scancode=
 set. This appears to be a firmware bug in the scancode translation.

IRQ 1 is not showing an interrupt storm (~10 interrupts per keypress), so t=
his is not a stuck interrupt.

Boot parameters tested:
  i8042.nopnp=3D1 i8042.direct=3D1                         -&gt; corrupted =
input
  i8042.nopnp=3D1 i8042.direct=3D1 atkbd.set=3D1             -&gt; corrupte=
d input
  i8042.nopnp=3D1 i8042.direct=3D1 atkbd.set=3D2             -&gt; corrupte=
d input
  i8042.nopnp=3D1 i8042.nomux=3D1 i8042.reset=3D1 i8042.notimeout=3D1  -&gt=
; no input
  acpi_osi=3D! acpi_osi=3D&quot;Windows 2013&quot;                   -&gt; =
no input

dmesg:

  i8042: PNP detection disabled
  i8042: Warning: Keylock active
  serio: i8042 KBD port at 0x60,0x64 irq 1
  input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/inp=
ut/input3
  intel-hid INTC1078:00: failed to enable HID power button
  ish-hid {33AECD58-B679-4E54-9BD9-A04D34F0C226}: enum_devices_done OK, num=
_hid_devices=3D1


The closest existing driver in-tree is drivers/platform/x86/intel/hid.c (ha=
ndles INTC1078 and similar). INTC816 would presumably need a similar ACPI d=
river that enumerates the child HID device and routes it through the input =
subsystem<br><br>I have attached my systems info <br><br><br></pre></div></=
div>
</div></div>
</div></div>

--000000000000ee5e25064dc11310--
--000000000000ee5e27064dc11312
Content-Type: text/plain; charset="US-ASCII"; name="System Kernel 6 19 7 200 (1).txt"
Content-Disposition: attachment; filename="System Kernel 6 19 7 200 (1).txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mn4d14ur0>
X-Attachment-Id: f_mn4d14ur0

U3lzdGVtOgogIEtlcm5lbDogNi4xOS43LTIwMC5mYzQzLng4Nl82NCBhcmNoOiB4ODZfNjQgYml0
czogNjQgY29tcGlsZXI6IGdjYyB2OiAxNS4yLjEKICAgIGNsb2Nrc291cmNlOiB0c2MgYXZhaWw6
IGFjcGlfcG0KICAgIHBhcmFtZXRlcnM6IEJPT1RfSU1BR0U9KGhkMCxncHQ2KS92bWxpbnV6LTYu
MTkuNy0yMDAuZmM0My54ODZfNjQKICAgIHJvb3Q9VVVJRD04ZjkzMjE3Zi0wMDM1LTQzN2UtOTdm
YS01MWUxZGEyODliZWMgcm8gcm9vdGZsYWdzPXN1YnZvbD1yb290CiAgICByaGdiIHF1aWV0CiAg
RGVza3RvcDogR05PTUUgdjogNDkuNCB0azogR1RLIHY6IDMuMjQuNTEgd206IGdub21lLXNoZWxs
CiAgICB0b29sczogZ3NkLXNjcmVlbnNhdmVyLXByb3h5IGRtOiBHRE0gdjogNDkuMiBEaXN0cm86
IEZlZG9yYSBMaW51eCA0MwogICAgKFdvcmtzdGF0aW9uIEVkaXRpb24pCk1hY2hpbmU6CiAgVHlw
ZTogTGFwdG9wIFN5c3RlbTogTUVESU9OIHByb2R1Y3Q6IDE0IFMxIE9MRUQgdjogTi9BCiAgICBz
ZXJpYWw6IDxzdXBlcnVzZXIgcmVxdWlyZWQ+IENoYXNzaXM6IHR5cGU6IDEwIHNlcmlhbDogPHN1
cGVydXNlciByZXF1aXJlZD4KICBNb2JvOiBNRURJT04gbW9kZWw6IE5NMTRSUEwgdjogMS4wIHNl
cmlhbDogPHN1cGVydXNlciByZXF1aXJlZD4KICAgIHBhcnQtbnU6IE1MLTIzMDAwNyA0MDA5MTc3
MiB1dWlkOiA8c3VwZXJ1c2VyIHJlcXVpcmVkPiBGaXJtd2FyZTogVUVGSQogICAgdmVuZG9yOiBB
bWVyaWNhbiBNZWdhdHJlbmRzIExMQy4gdjogUlBMMzM2X1NfVjAuMTMgZGF0ZTogMDQvMTUvMjAy
NQpCYXR0ZXJ5OgogIElELTE6IEJBVDAgY2hhcmdlOiA0Mi45IFdoICg3OCUpIGNvbmRpdGlvbjog
NTUvNTUgV2ggKDEwMCUpIHBvd2VyOiAxNC44IFcKICAgIHZvbHRzOiAxMS41NSBtaW46IE4vQSBt
b2RlbDogTWVkaW9uIFNSIFJlYWwgQmF0dGVyeSB0eXBlOiBVbmtub3duCiAgICBzZXJpYWw6IDxm
aWx0ZXI+IGNoYXJnaW5nOiBzdGF0dXM6IGRpc2NoYXJnaW5nIGN5Y2xlczogTi9BCkNQVToKICBJ
bmZvOiBtb2RlbDogSW50ZWwgQ29yZSA1IDEyMFUgYml0czogNjQgdHlwZTogTVNUIEFNQ1AgYXJj
aDogUmFwdG9yIExha2UKICAgIGxldmVsOiB2MyBub3RlOiBjaGVjayBidWlsdDogMjAyMisgcHJv
Y2VzczogSW50ZWwgNyAoMTBubSkgZmFtaWx5OiA2CiAgICBtb2RlbC1pZDogMHhCQSAoMTg2KSBz
dGVwcGluZzogMyBtaWNyb2NvZGU6IDB4NjEzNAogIFRvcG9sb2d5OiBjcHVzOiAxeCBkaWVzOiAx
IGNsdXN0ZXJzOiA0IGNvcmVzOiAxMCB0aHJlYWRzOiAxMiBtdDogMiB0cGM6IDIKICAgIHN0OiA4
IHNtdDogZW5hYmxlZCBjYWNoZTogTDE6IDkyOCBLaUIgZGVzYzogZC04eDMyIEtpQiwgMng0OCBL
aUI7IGktMngzMgogICAgS2lCLCA4eDY0IEtpQiBMMjogNi41IE1pQiBkZXNjOiAyeDEuMiBNaUIs
IDJ4MiBNaUIgTDM6IDEyIE1pQgogICAgZGVzYzogMXgxMiBNaUIKICBTcGVlZCAoTUh6KTogYXZn
OiAyMjAwIG1pbi9tYXg6IDQwMC81MDAwOjM4MDAgc2NhbGluZzoKICAgIGRyaXZlcjogaW50ZWxf
cHN0YXRlIGdvdmVybm9yOiBwb3dlcnNhdmUgY29yZXM6IDE6IDIyMDAgMjogMjIwMCAzOiAyMjAw
CiAgICA0OiAyMjAwIDU6IDIyMDAgNjogMjIwMCA3OiAyMjAwIDg6IDIyMDAgOTogMjIwMCAxMDog
MjIwMCAxMTogMjIwMCAxMjogMjIwMAogICAgYm9nb21pcHM6IDU5OTA0CiAgRmxhZ3MtYmFzaWM6
IGF2eCBhdngyIGh0IGxtIG54IHBhZSBzc2Ugc3NlMiBzc2UzIHNzZTRfMSBzc2U0XzIgc3NzZTMg
dm14CiAgVnVsbmVyYWJpbGl0aWVzOgogIFR5cGU6IGdhdGhlcl9kYXRhX3NhbXBsaW5nIHN0YXR1
czogTm90IGFmZmVjdGVkCiAgVHlwZTogZ2hvc3R3cml0ZSBzdGF0dXM6IE5vdCBhZmZlY3RlZAog
IFR5cGU6IGluZGlyZWN0X3RhcmdldF9zZWxlY3Rpb24gc3RhdHVzOiBOb3QgYWZmZWN0ZWQKICBU
eXBlOiBpdGxiX211bHRpaGl0IHN0YXR1czogTm90IGFmZmVjdGVkCiAgVHlwZTogbDF0ZiBzdGF0
dXM6IE5vdCBhZmZlY3RlZAogIFR5cGU6IG1kcyBzdGF0dXM6IE5vdCBhZmZlY3RlZAogIFR5cGU6
IG1lbHRkb3duIHN0YXR1czogTm90IGFmZmVjdGVkCiAgVHlwZTogbW1pb19zdGFsZV9kYXRhIHN0
YXR1czogTm90IGFmZmVjdGVkCiAgVHlwZTogb2xkX21pY3JvY29kZSBzdGF0dXM6IE5vdCBhZmZl
Y3RlZAogIFR5cGU6IHJlZ19maWxlX2RhdGFfc2FtcGxpbmcgbWl0aWdhdGlvbjogQ2xlYXIgUmVn
aXN0ZXIgRmlsZQogIFR5cGU6IHJldGJsZWVkIHN0YXR1czogTm90IGFmZmVjdGVkCiAgVHlwZTog
c3BlY19yc3RhY2tfb3ZlcmZsb3cgc3RhdHVzOiBOb3QgYWZmZWN0ZWQKICBUeXBlOiBzcGVjX3N0
b3JlX2J5cGFzcyBtaXRpZ2F0aW9uOiBTcGVjdWxhdGl2ZSBTdG9yZSBCeXBhc3MgZGlzYWJsZWQg
dmlhCiAgICBwcmN0bAogIFR5cGU6IHNwZWN0cmVfdjEgbWl0aWdhdGlvbjogdXNlcmNvcHkvc3dh
cGdzIGJhcnJpZXJzIGFuZCBfX3VzZXIgcG9pbnRlcgogICAgc2FuaXRpemF0aW9uCiAgVHlwZTog
c3BlY3RyZV92MiBtaXRpZ2F0aW9uOiBFbmhhbmNlZCAvIEF1dG9tYXRpYyBJQlJTOyBJQlBCOgog
ICAgY29uZGl0aW9uYWw7IFBCUlNCLWVJQlJTOiBTVyBzZXF1ZW5jZTsgQkhJOiBCSElfRElTX1MK
ICBUeXBlOiBzcmJkcyBzdGF0dXM6IE5vdCBhZmZlY3RlZAogIFR5cGU6IHRzYSBzdGF0dXM6IE5v
dCBhZmZlY3RlZAogIFR5cGU6IHRzeF9hc3luY19hYm9ydCBzdGF0dXM6IE5vdCBhZmZlY3RlZAog
IFR5cGU6IHZtc2NhcGUgbWl0aWdhdGlvbjogSUJQQiBiZWZvcmUgZXhpdCB0byB1c2Vyc3BhY2UK
R3JhcGhpY3M6CiAgRGV2aWNlLTE6IEludGVsIFJhcHRvciBMYWtlLVUgW0ludGVsIEdyYXBoaWNz
XSB2ZW5kb3I6IEVtZG9vciBEaWdpdGFsCiAgICBkcml2ZXI6IGk5MTUgdjoga2VybmVsIGFsdGVy
bmF0ZTogeGUgYXJjaDogWGUgcHJvY2VzczogSW50ZWwgNyAoMTBubSkKICAgIGJ1aWx0OiAyMDIy
KyBwb3J0czogYWN0aXZlOiBlRFAtMSBlbXB0eTogRFAtMSxEUC0yLEhETUktQS0xCiAgICBidXMt
SUQ6IDAwOjAyLjAgY2hpcC1JRDogODA4NjphN2FjIGNsYXNzLUlEOiAwMzAwCiAgRGV2aWNlLTI6
IFNvbml4IFVTQjIuMCBGSEQgVVZDIFdlYkNhbSBkcml2ZXI6IHV2Y3ZpZGVvIHR5cGU6IFVTQiBy
ZXY6IDIuMAogICAgc3BlZWQ6IDQ4MCBNYi9zIGxhbmVzOiAxIG1vZGU6IDIuMCBidXMtSUQ6IDMt
NToyIGNoaXAtSUQ6IDMyNzc6MDBiZQogICAgY2xhc3MtSUQ6IGZlMDEgc2VyaWFsOiA8ZmlsdGVy
PgogIERpc3BsYXk6IHdheWxhbmQgc2VydmVyOiBYLk9yZyB2OiAyNC4xLjkgd2l0aDogWHdheWxh
bmQgdjogMjQuMS45CiAgICBjb21wb3NpdG9yOiBnbm9tZS1zaGVsbCBkcml2ZXI6IGRyaTogaXJp
cyBncHU6IGk5MTUgZGlzcGxheS1JRDogOjAKICAgIHNjcmVlbnM6IDEKICBTY3JlZW4tMTogMCBz
LXJlczogMzQ1NngyMTYwIHMtZHBpOiA5NiBzLXNpemU6IDkxNHg1NzFtbSAoMzUuOTh4MjIuNDgi
KQogICAgcy1kaWFnOiAxMDc4bW0gKDQyLjQzIikKICBNb25pdG9yLTE6IGVEUC0xIG1vZGVsLWlk
OiBFRE8gMHgxNDI4IGJ1aWx0OiAyMDI0IHJlczogbW9kZTogMzQ1NngyMTYwCiAgICBoejogMTIw
IHNjYWxlOiAxMDAlICgxKSBkcGk6IDI5MyBnYW1tYTogMS4yIHNpemU6IDMwMHgxOTBtbSAoMTEu
ODF4Ny40OCIpCiAgICBkaWFnOiAzNTVtbSAoMTQiKSBtb2RlczogMjg4MHgxODAwCiAgQVBJOiBP
cGVuR0wgdjogNC42IHZlbmRvcjogaW50ZWwgbWVzYSB2OiAyNS4zLjYgZ2x4LXY6IDEuNCBlcy12
OiAzLjIKICAgIGRpcmVjdC1yZW5kZXI6IHllcyByZW5kZXJlcjogTWVzYSBJbnRlbCBHcmFwaGlj
cyAoUlBMLVUpCiAgICBkZXZpY2UtSUQ6IDgwODY6YTdhYyBtZW1vcnk6IDE0Ljk5IEdpQiB1bmlm
aWVkOiB5ZXMKICBBUEk6IEVHTCBNZXNzYWdlOiBFR0wgZGF0YSByZXF1aXJlcyBlZ2xpbmZvLiBD
aGVjayAtLXJlY29tbWVuZHMuCiAgSW5mbzogVG9vbHM6IGFwaTogZ2x4aW5mbyB4MTE6IHhkcmlp
bmZvLCB4ZHB5aW5mbywgeHByb3AsIHhyYW5kcgpBdWRpbzoKICBEZXZpY2UtMTogSW50ZWwgUmFw
dG9yIExha2UtUC9VL0ggY0FWUyB2ZW5kb3I6IEVtZG9vciBEaWdpdGFsCiAgICBkcml2ZXI6IHNu
ZF9oZGFfaW50ZWwgdjoga2VybmVsIGFsdGVybmF0ZTogc25kX3NvY19hdnMsc25kX3NvZl9wY2lf
aW50ZWxfdGdsCiAgICBidXMtSUQ6IDAwOjFmLjMgY2hpcC1JRDogODA4Njo1MWNhIGNsYXNzLUlE
OiAwNDAzCiAgQVBJOiBBTFNBIHY6IGs2LjE5LjctMjAwLmZjNDMueDg2XzY0IHN0YXR1czoga2Vy
bmVsLWFwaQogICAgdG9vbHM6IGFsc2FjdGwsYWxzYW1peGVyLGFtaXhlcgogIFNlcnZlci0xOiBQ
aXBlV2lyZSB2OiAxLjQuMTAgc3RhdHVzOiBhY3RpdmUgd2l0aDogMTogcGlwZXdpcmUtcHVsc2UK
ICAgIHN0YXR1czogYWN0aXZlIDI6IHdpcmVwbHVtYmVyIHN0YXR1czogYWN0aXZlIDM6IHBpcGV3
aXJlLWFsc2EgdHlwZTogcGx1Z2luCiAgICA0OiBwdy1qYWNrIHR5cGU6IHBsdWdpbiB0b29sczog
cGFjdGwscHctY2F0LHB3LWNsaSx3cGN0bApOZXR3b3JrOgogIERldmljZS0xOiBJbnRlbCBSYXB0
b3IgTGFrZSBQQ0ggQ05WaSBXaUZpIGRyaXZlcjogaXdsd2lmaSB2OiBrZXJuZWwKICAgIGJ1cy1J
RDogMDA6MTQuMyBjaGlwLUlEOiA4MDg2OjUxZjEgY2xhc3MtSUQ6IDAyODAKICBJRjogd2xvMSBz
dGF0ZTogdXAgbWFjOiA8ZmlsdGVyPgogIEluZm86IHNlcnZpY2VzOiBOZXR3b3JrTWFuYWdlcix3
cGFfc3VwcGxpY2FudApCbHVldG9vdGg6CiAgRGV2aWNlLTE6IEludGVsIEFYMjAxIEJsdWV0b290
aCBkcml2ZXI6IGJ0dXNiIHY6IDAuOCB0eXBlOiBVU0IgcmV2OiAyLjAKICAgIHNwZWVkOiAxMiBN
Yi9zIGxhbmVzOiAxIG1vZGU6IDEuMSBidXMtSUQ6IDMtMTA6MyBjaGlwLUlEOiA4MDg3OjAwMjYK
ICAgIGNsYXNzLUlEOiBlMDAxCiAgUmVwb3J0OiBidG1nbXQgSUQ6IGhjaTAgcmZrLWlkOiAwIHN0
YXRlOiB1cCBhZGRyZXNzOiA8ZmlsdGVyPiBidC12OiA1LjIKICAgIGxtcC12OiAxMSBzdGF0dXM6
IGRpc2NvdmVyYWJsZTogbm8gcGFpcmluZzogbm8gY2xhc3MtSUQ6IDdjMDEwYwpEcml2ZXM6CiAg
TG9jYWwgU3RvcmFnZTogdG90YWw6IDQ3Ni45NCBHaUIgdXNlZDogNS41MyBHaUIgKDEuMiUpCiAg
U01BUlQgTWVzc2FnZTogVW5hYmxlIHRvIHJ1biBzbWFydGN0bC4gUm9vdCBwcml2aWxlZ2VzIHJl
cXVpcmVkLgogIElELTE6IC9kZXYvbnZtZTBuMSBtYWotbWluOiAyNTk6MCBtb2RlbDogUlM1MTJH
U1NENzEwIHNpemU6IDQ3Ni45NCBHaUIKICAgIGJsb2NrLXNpemU6IHBoeXNpY2FsOiA1MTIgQiBs
b2dpY2FsOiA1MTIgQiBzcGVlZDogNjMuMiBHYi9zIGxhbmVzOiA0CiAgICB0ZWNoOiBTU0Qgc2Vy
aWFsOiA8ZmlsdGVyPiBmdy1yZXY6IFBNMDIwNzdCIHRlbXA6IDM2LjkgQyBzY2hlbWU6IEdQVApQ
YXJ0aXRpb246CiAgSUQtMTogLyByYXctc2l6ZTogMTY4LjkgR2lCIHNpemU6IDE2OC45IEdpQiAo
MTAwLjAwJSkgdXNlZDogNC45OCBHaUIgKDMuMCUpCiAgICBmczogYnRyZnMgZGV2OiAvZGV2L252
bWUwbjFwNyBtYWotbWluOiAyNTk6NwogIElELTI6IC9ib290IHJhdy1zaXplOiAyIEdpQiBzaXpl
OiAxLjkgR2lCICg5NS4wMSUpIHVzZWQ6IDUwNS43IE1pQiAoMjYuMCUpCiAgICBmczogZXh0NCBk
ZXY6IC9kZXYvbnZtZTBuMXA2IG1hai1taW46IDI1OTo2CiAgSUQtMzogL2Jvb3QvZWZpIHJhdy1z
aXplOiAxMDAgTWlCIHNpemU6IDk2IE1pQiAoOTYuMDAlKQogICAgdXNlZDogNTAuNyBNaUIgKDUy
LjglKSBmczogdmZhdCBkZXY6IC9kZXYvbnZtZTBuMXAxIG1hai1taW46IDI1OToxCiAgSUQtNDog
L2hvbWUgcmF3LXNpemU6IDE2OC45IEdpQiBzaXplOiAxNjguOSBHaUIgKDEwMC4wMCUpCiAgICB1
c2VkOiA0Ljk4IEdpQiAoMy4wJSkgZnM6IGJ0cmZzIGRldjogL2Rldi9udm1lMG4xcDcgbWFqLW1p
bjogMjU5OjcKU3dhcDoKICBLZXJuZWw6IHN3YXBwaW5lc3M6IDYwIChkZWZhdWx0KSBjYWNoZS1w
cmVzc3VyZTogMTAwIChkZWZhdWx0KSB6c3dhcDogbm8KICBJRC0xOiBzd2FwLTEgdHlwZTogenJh
bSBzaXplOiA4IEdpQiB1c2VkOiAwIEtpQiAoMC4wJSkgcHJpb3JpdHk6IDEwMAogICAgY29tcDog
bHpvLXJsZSBhdmFpbDogbHpvLGx6NCxsejRoYyx6c3RkLGRlZmxhdGUsODQyIGRldjogL2Rldi96
cmFtMApTZW5zb3JzOgogIFN5c3RlbSBUZW1wZXJhdHVyZXM6IGNwdTogNTMuMCBDIG1vYm86IE4v
QQogIEZhbiBTcGVlZHMgKHJwbSk6IE4vQQpJbmZvOgogIE1lbW9yeTogdG90YWw6IDE2IEdpQiBu
b3RlOiBlc3QuIGF2YWlsYWJsZTogMTUuMzUgR2lCIHVzZWQ6IDIuMzYgR2lCICgxNS4zJSkKICBQ
cm9jZXNzZXM6IDM3NiBQb3dlcjogdXB0aW1lOiAxbSBzdGF0ZXM6IGZyZWV6ZSxtZW0sZGlzayBz
dXNwZW5kOiBzMmlkbGUKICAgIGF2YWlsOiBkZWVwIHdha2V1cHM6IDAgaGliZXJuYXRlOiBwbGF0
Zm9ybSBhdmFpbDogc2h1dGRvd24sIHJlYm9vdCwKICAgIHN1c3BlbmQsIHRlc3RfcmVzdW1lIGlt
YWdlOiA2LjA4IEdpQiBzZXJ2aWNlczogZ3NkLXBvd2VyLHRoZXJtYWxkLHVwb3dlcmQKICAgIElu
aXQ6IHN5c3RlbWQgdjogMjU4IGRlZmF1bHQ6IGdyYXBoaWNhbCB0b29sOiBzeXN0ZW1jdGwKICBQ
YWNrYWdlczogcG06IHJwbSBwa2dzOiBOL0Egbm90ZTogc2VlIC0tcnBtIHRvb2xzOiBkbmYsZ25v
bWUtc29mdHdhcmUseXVtCiAgICBwbTogZmxhdHBhayBwa2dzOiAwIENvbXBpbGVyczogTi9BIFNo
ZWxsOiBCYXNoIHY6IDUuMy4wCiAgICBydW5uaW5nLWluOiBwdHl4aXMtYWdlbnQgaW54aTogMy4z
LjQwCgo=
--000000000000ee5e27064dc11312--
