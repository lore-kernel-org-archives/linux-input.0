Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2744D339380
	for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 17:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786383106; cv=pass; b=IV+b1Yx/X+Fj6J4ttIpolLzYlSJ1ZzIerEzgPo8HTkypDx1AewbSqUoHL3lxNfvwU/w98dJtapdCj67tlnrAgJ/iZn6OGOypqXkvj2QdnpvYRq6CAOHSlzWtmmTLDwzWs/ZyMU7bWrRGmhsw0ubZggXuR0datGc4Hd1gJnQNAng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786383106; c=relaxed/simple;
	bh=UVHzY04sHJkrOHQy/UZmvYaiuJVf76u2aroV37mlIgQ=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=PDvudCM/Sa3uusUG1aR76A+YR6wQheNuaArqvYOAdUUenT3dp95774HpF43UdbyNVqwNteNw0jHhY3Wj3acH/oju4d4SMc90Yu7L8Y4dadfnD6ZBc6wshVfwN52wi7hZDds5DfcbUF7iXjTRi1W0B0rQOlndWgEMgjIVsegaPjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=joK9zl+K; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="joK9zl+K"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c167c58f2so16298091cf.0
        for <linux-input@vger.kernel.org>; Mon, 10 Aug 2026 10:31:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786383104; cv=none;
        d=google.com; s=arc-20260327;
        b=JsiE3Oh3btMx8oUg0/Vx9XcXVERtWrSzM+N8nd9p1wkbCP6L3RpOhrV/a9Zs6j5irJ
         KYkVt6ptjUFBouZG6afluNhrG/6lrXHr04DndxCQ3DOs3X0J43k138ocLe8ZmK/qLWr7
         ODdmyaEk1/ENFYuHMmq9q/w0uttNOnfNJX8FhE4tjHpkb+/uadZcWhZWLn1DUOiGtijY
         o/2I+tVEUhgHRuuXH+F+YTqgfopS3kUb0Gep0In2ACG7K8mfM9BeFRDwU8wry1wvmMu7
         HFmTHTWIXEnvnI9BmeUiuxq3xMWQPV3/CUBJBS6bpoNR3D9brJqp1M0/5xe3Rj8siCxt
         Xt/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=LDeAGv5r7TnmilHEbMFvG6oLvNTEVzMFgYbDI1xJo7E=;
        fh=agcOj+9rtkxsVGt42iDIEHCmZj+b2UisQwNXlSH2SLg=;
        b=Gbaj4VUC2cHMv3ofqF7z3aUsgimW5gQwvx1hMfoMxC3q6zrwF7ZXs1DI4XCp0iCdg7
         mmAX+w1wZ4zftFewiRCBGqZsib8NcM6QT5FbagPIyl5cKcFD8vA+l8qpaxHtYTzsWw0q
         vywdfnhzhkvPR4JZMdRFdY+USCb34/XnAcfTd/SMvMe4F2n2/eRsn18blPU33iUVi9O6
         8KOZomyxUpTqMU5IEqi/fkC4D2MkdwOvb6jakxmtjZUvHh4tWBCdYbmotNix0dMyIMDt
         dyRLmk+CqG+PkEmS5nxtXu6/D4FmAj8KrPxApUI4y7Qi5+16LDI6bQlJ7sYjSgTZj9BS
         B/Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786383104; x=1786987904; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=LDeAGv5r7TnmilHEbMFvG6oLvNTEVzMFgYbDI1xJo7E=;
        b=joK9zl+KmCwe9Sum0jskXza9voBsXrJrPWO+IoWxpuUkxZppWSYOd6ASCCHwkKl5kI
         49PRa13gvo+OK2iqI0IFieb7DnaHfNg6OLLw0cj+LdT16UbajcEtrGhwbujabIBzDaNz
         ZDmMC6EttVvRLPYubeKJ2ARV/qrXlD9wIQuqrPvrLJzahI43p2aZbzhOHK30GSkvPL8w
         OiI/1vzH48ZrSjPbolOxUaX9TtLMQ1piGPBl5OwCUJ7SRlduOZm5LfmTIHbK0qQuBkMJ
         sLNBmIr4rvlGSF3htbplq56SFQQ0l9LR57OuUf0jUeDE6OZ64rP7M/j3pZ+nmEf0P4Vu
         RpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786383104; x=1786987904;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDeAGv5r7TnmilHEbMFvG6oLvNTEVzMFgYbDI1xJo7E=;
        b=Lv9GT74nYe4LEetM2KXWt/1rMdss2HczxZ614zOq+MmHg3Wzw5asLsO2TqFmAOA0JE
         JS5VCJQ4NRa4KPi6ZdmMzNMCUKCXg+MaI/AE36KzyjAjlnXKmgkCmngfFH+LQaHr1obf
         4lV3zP8Dg+z47BMI58Cp9HyN1TIzIHYJafqonrDefjvBxcVuJaLUw5PzmfradnnZLrUk
         TGUTAeTAw6amYzbT1EeW6drgscgIGh15G0Q4t8klEs13VsJ9gvYJweJxllBqC0eIEG85
         ge5gF+tk9gyMnbfgLVCQTclZCDdz3Hc5fgP+BwJRqxh5Yi/UiIiRFYfYNuTSDAcKOu0t
         I74w==
X-Forwarded-Encrypted: i=1; AHgh+RqiTzn6FDSJR4zPZbine+Lzm6QUF7C6/3nRqFaifD8sOnxeZcUMXtlinoMpyZsNoV25DLAY2DKoObol0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVKlZb8DbPuTB2BkR+Q3dTAiKohOksEwEn6QZUHR3Y0sPjb/2N
	K54nrwka4A/I8MA9JE0O5k7rkAWVV2owEpRmIgHLI/aY16C4cMlnnOlF9+j0ntzTwtFzn00wOCx
	9Dnt3bfqNmq+BuN0QnqNUf1JApdQRaq9MSAke
X-Gm-Gg: AR+sD117tOZx+N0g6p94NIkeVAHjZ2bZJNJEsyaeV43GLmRcoFbaKjGKahfSqXrPAa/
	3k7LMyr7apqreWQlbZy5DCsBBKo4CTQLhLVUrpPAir0e6GMlS8CjiD+3ATYm6P8eUQX0Go6HSGd
	zmlHKwk6BgEC7tn234NAi5R7/X5lFps0CRSW8blWfyps1zcTL6bbB2LV2ZybFLtzAGdEBOScrZo
	LBVPk3gm8q1W9QDmWXmXB2siNCM7MPtwvgQvA+FCqtYG/TDPNxXayY+pCXWhtFE2RcDeSyQYAHg
	P0ifQ8NDCniHpv2k5/q+tZ0hjHwWHSctguXUh+hc9jHcSg==
X-Received: by 2002:a05:620a:90d0:10b0:91d:6ac3:565a with SMTP id
 af79cd13be357-9364915b02cmr3528146085a.12.1786383103838; Mon, 10 Aug 2026
 10:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adam <testyiprywatnosc@gmail.com>
Date: Mon, 10 Aug 2026 19:31:32 +0200
X-Gm-Features: AUfX_mxBJmwsTXBz0AVGzrGhz8k5RlXccpUjDp4xJ3BTqot-cby2PHPf1sU3VYM
Message-ID: <CAEru=6LrMqg93AKrmbTJtvRNPx=arYuhSf4zMw4bK1SjWQQvrw@mail.gmail.com>
Subject: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
To: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005666540658b4ba8d"

--0000000000005666540658b4ba8d
Content-Type: multipart/alternative; boundary="0000000000005666530658b4ba8b"

--0000000000005666530658b4ba8b
Content-Type: text/plain; charset="UTF-8"

Hello,

I'm reporting a reproducible probe failure for an ELAN i2c-hid touchpad
(ACPI ELAN0718:00, VID:PID 04F3:30FD) on an HP Pavilion Gaming 15-ec1033nw
(AMD platform, i2c bus under AMDI0010:03). The touchpad fails to
initialize on nearly every boot on Linux, while the same hardware works
reliably every time under Windows 11 on the same machine (dual context,
same BIOS F.35 rev.A).

Kernel: 7.1.6-arch1-1 (Arch Linux)
Also reported by other users with the same touchpad ID on different
kernels/distros (Arch, Ubuntu, Linux Mint) going back to at least 2022:
- https://bbs.archlinux.org/viewtopic.php?id=277393
- https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2031061
- https://forums.linuxmint.com/viewtopic.php?t=329212

Symptom (default logging):

  i2c_hid_acpi i2c-ELAN0718:00: failed to fetch HID descriptor: -121
  i2c_hid_acpi i2c-ELAN0718:00: Failed to fetch the HID Descriptor
  i2c_hid_acpi i2c-ELAN0718:00: probe with driver i2c_hid_acpi failed with
error -121

With dynamic_debug enabled for i2c_hid and i2c_hid_acpi:

  i2c_hid_start_hwreset
  i2c_hid_set_power: cmd=05 00 00 08
  i2c_hid_xfer: cmd=05 00 00 01
  i2c_hid_finish_hwreset: waiting...
  i2c_hid_finish_hwreset: finished.
  asking HID report descriptor
  i2c_hid_xfer: cmd=02 00
  reading report descriptor failed
  can't add hid device: -121
  probe with driver i2c_hid_acpi failed with error -121

Note the device is already tagged with I2C_HID_QUIRK_BOGUS_IRQ and
I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET via the USB_VENDOR_ID_ELAN,
HID_ANY_ID entry in i2c_hid_quirks[], but this specific chip still
appears to need additional settle time between the reset-complete IRQ
and the immediately following descriptor read - the two happen back to
back (sub-millisecond apart in the trace) with zero delay.

The i2c bus and controller are not at fault: an ACPI-level PCI
remove/rescan of the SMBus controller (0000:00:14.0, piix4_smbus)
successfully re-enumerates the bus, and once probe *does* succeed
(intermittently - roughly 1 in 10-15 boots in my testing), the touchpad
works completely normally for the rest of the session. This points to a
narrow timing race rather than a persistent hardware/firmware fault.
Windows never exhibits this behavior on the same machine.

I tested a draft workaround patch (attached) attempting to add msleep()
delays after i2c_hid_finish_hwreset() and before descriptor fetch for
devices with I2C_HID_QUIRK_BOGUS_IRQ, but the issue still persists on my
machine. I am attaching the patch and debug logs in hopes that maintainers
can pinpoint the exact timing, sequence, or quirk needed for this ELAN
revision.

Happy to test alternate patches, adjust delay values, or gather any
additional traces (i2cdump, further dynamic_debug, ACPI tables via
acpidump) if useful.

Hardware:
- HP Pavilion Gaming 15-ec1033nw
- AMD Ryzen 5 4600H
- BIOS F.35 rev.A (latest per HP support site)
- Touchpad: ACPI ELAN0718:00, USB VID:PID 04F3:30FD, on i2c-3 /
  AMDI0010:03

Let me know if you'd like the full dmesg, acpidump, or anything else.

Thanks,
Adam

--0000000000005666530658b4ba8b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<br><br>I&#39;m reporting a reproducible probe failu=
re for an ELAN i2c-hid touchpad<br>(ACPI ELAN0718:00, VID:PID 04F3:30FD) on=
 an HP Pavilion Gaming 15-ec1033nw<br>(AMD platform, i2c bus under AMDI0010=
:03). The touchpad fails to<br>initialize on nearly every boot on Linux, wh=
ile the same hardware works<br>reliably every time under Windows 11 on the =
same machine (dual context,<br>same BIOS F.35 rev.A).<br><br>Kernel: 7.1.6-=
arch1-1 (Arch Linux)<br>Also reported by other users with the same touchpad=
 ID on different<br>kernels/distros (Arch, Ubuntu, Linux Mint) going back t=
o at least 2022:<br>- <a href=3D"https://bbs.archlinux.org/viewtopic.php?id=
=3D277393">https://bbs.archlinux.org/viewtopic.php?id=3D277393</a><br>- <a =
href=3D"https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2031061">https=
://bugs.launchpad.net/ubuntu/+source/linux/+bug/2031061</a><br>- <a href=3D=
"https://forums.linuxmint.com/viewtopic.php?t=3D329212">https://forums.linu=
xmint.com/viewtopic.php?t=3D329212</a><br><br>Symptom (default logging):<br=
><br>=C2=A0 i2c_hid_acpi i2c-ELAN0718:00: failed to fetch HID descriptor: -=
121<br>=C2=A0 i2c_hid_acpi i2c-ELAN0718:00: Failed to fetch the HID Descrip=
tor<br>=C2=A0 i2c_hid_acpi i2c-ELAN0718:00: probe with driver i2c_hid_acpi =
failed with error -121<br><br>With dynamic_debug enabled for i2c_hid and i2=
c_hid_acpi:<br><br>=C2=A0 i2c_hid_start_hwreset<br>=C2=A0 i2c_hid_set_power=
: cmd=3D05 00 00 08<br>=C2=A0 i2c_hid_xfer: cmd=3D05 00 00 01<br>=C2=A0 i2c=
_hid_finish_hwreset: waiting...<br>=C2=A0 i2c_hid_finish_hwreset: finished.=
<br>=C2=A0 asking HID report descriptor<br>=C2=A0 i2c_hid_xfer: cmd=3D02 00=
<br>=C2=A0 reading report descriptor failed<br>=C2=A0 can&#39;t add hid dev=
ice: -121<br>=C2=A0 probe with driver i2c_hid_acpi failed with error -121<b=
r><br>Note the device is already tagged with I2C_HID_QUIRK_BOGUS_IRQ and<br=
>I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET via the USB_VENDOR_ID_ELAN,<br>HID_ANY=
_ID entry in i2c_hid_quirks[], but this specific chip still<br>appears to n=
eed additional settle time between the reset-complete IRQ<br>and the immedi=
ately following descriptor read - the two happen back to<br>back (sub-milli=
second apart in the trace) with zero delay.<br><br>The i2c bus and controll=
er are not at fault: an ACPI-level PCI<br>remove/rescan of the SMBus contro=
ller (0000:00:14.0, piix4_smbus)<br>successfully re-enumerates the bus, and=
 once probe *does* succeed<br>(intermittently - roughly 1 in 10-15 boots in=
 my testing), the touchpad<br>works completely normally for the rest of the=
 session. This points to a<br>narrow timing race rather than a persistent h=
ardware/firmware fault.<br>Windows never exhibits this behavior on the same=
 machine.<br><br>I tested a draft workaround patch (attached) attempting to=
 add msleep()<br>delays after i2c_hid_finish_hwreset() and before descripto=
r fetch for<br>devices with I2C_HID_QUIRK_BOGUS_IRQ, but the issue still pe=
rsists on my<br>machine. I am attaching the patch and debug logs in hopes t=
hat maintainers<br>can pinpoint the exact timing, sequence, or quirk needed=
 for this ELAN<br>revision.<br><br>Happy to test alternate patches, adjust =
delay values, or gather any<br>additional traces (i2cdump, further dynamic_=
debug, ACPI tables via<br>acpidump) if useful.<br><br>Hardware:<br>- HP Pav=
ilion Gaming 15-ec1033nw<br>- AMD Ryzen 5 4600H<br>- BIOS F.35 rev.A (lates=
t per HP support site)<br>- Touchpad: ACPI ELAN0718:00, USB VID:PID 04F3:30=
FD, on i2c-3 /<br>=C2=A0 AMDI0010:03<br><br>Let me know if you&#39;d like t=
he full dmesg, acpidump, or anything else.<br><br>Thanks,<br>Adam</div>

--0000000000005666530658b4ba8b--
--0000000000005666540658b4ba8d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="elan-touchpad-bogus-irq-reset-delay.patch"
Content-Disposition: attachment; 
	filename="elan-touchpad-bogus-irq-reset-delay.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msnib4830>
X-Attachment-Id: f_msnib4830

LS0tIGEvZHJpdmVycy9oaWQvaTJjLWhpZC9pMmMtaGlkLWNvcmUuYworKysgYi9kcml2ZXJzL2hp
ZC9pMmMtaGlkL2kyYy1oaWQtY29yZS5jCkBAIC01MjAsNiArNTIwLDE4IEBACiAJaWYgKCEoaWhp
ZC0+cXVpcmtzICYgSTJDX0hJRF9RVUlSS19OT19XQUtFVVBfQUZURVJfUkVTRVQpKQogCQlyZXQg
PSBpMmNfaGlkX3NldF9wb3dlcihpaGlkLCBJMkNfSElEX1BXUl9PTik7CiAKKwkvKgorCSAqIFNv
bWUgRUxBTiBpMmMtaGlkIHRvdWNocGFkcyAoZS5nLiAwNEYzOjMwRkQsIHNlZW4gb24gSFAgUGF2
aWxpb24KKwkgKiBHYW1pbmcgMTUtZWMxeHh4KSBzaWduYWwgcmVzZXQtY29tcGxldGUgdmlhIElS
USBiZWZvcmUgdGhleSBhcmUKKwkgKiBhY3R1YWxseSByZWFkeSB0byBhbnN3ZXIgdGhlIGltbWVk
aWF0ZWx5IGZvbGxvd2luZyBISUQvcmVwb3J0CisJICogZGVzY3JpcHRvciByZWFkLCBjYXVzaW5n
IGEgc3B1cmlvdXMgLUVSRU1PVEVJTyAoLTEyMSkuIFRoZQorCSAqIFdpbmRvd3MgZHJpdmVyIGlz
IGtub3duIHRvIGluc2VydCBhIGRlbGF5IGFmdGVyIFBXUl9PTi9SRVNFVAorCSAqIChzZWUgY29t
bWVudCBpbiBpMmNfaGlkX3NldF9wb3dlciBhYm92ZSk7IGdpdmUgdGhpcyBxdWlya3kgY2xhc3MK
KwkgKiBvZiBFTEFOIGRldmljZXMgdGhlIHNhbWUgZ3JhY2UgcGVyaW9kLgorCSAqLworCWlmIChp
aGlkLT5xdWlya3MgJiBJMkNfSElEX1FVSVJLX0JPR1VTX0lSUSkKKwkJbXNsZWVwKDEwMCk7CisK
IAlyZXR1cm4gcmV0OwogfQogCkBAIC0xMDUyLDYgKzEwNjQsMTggQEAKIAkJcmV0dXJuIC1FTlhJ
TzsKIAl9CiAKKwkvKgorCSAqIFNvbWUgRUxBTiBpMmMtaGlkIHRvdWNocGFkcyAoZS5nLiAwNEYz
OjMwRkQsIHNlZW4gb24gSFAgUGF2aWxpb24KKwkgKiBHYW1pbmcgMTUtZWMxeHh4KSBhcmUgbm90
IHlldCByZWFkeSB0byBhbnN3ZXIgdGhlIHZlcnkgZmlyc3QgSElECisJICogZGVzY3JpcHRvciBy
ZWFkIG9uIGNvbGQgYm9vdCAvIHBvd2VyLW9uLCBiZWZvcmUgYW55IHJlc2V0IGhhcworCSAqIGV2
ZW4gYmVlbiBpc3N1ZWQsIGNhdXNpbmcgYW4gaW50ZXJtaXR0ZW50IC1FUkVNT1RFSU8gKC0xMjEp
IGhlcmUuCisJICogR2l2ZSB0aGlzIHF1aXJreSBjbGFzcyBvZiBFTEFOIGRldmljZXMgYSBzaG9y
dCBncmFjZSBwZXJpb2QsCisJICogbWlycm9yaW5nIHRoZSBkZWxheSBhbHJlYWR5IGFwcGxpZWQg
YWZ0ZXIgaHdyZXNldCBmb3IgdGhlIHNhbWUKKwkgKiBxdWlyayBmdXJ0aGVyIGRvd24gaW4gdGhp
cyBmaWxlLgorCSAqLworCWlmIChpaGlkLT5xdWlya3MgJiBJMkNfSElEX1FVSVJLX0JPR1VTX0lS
USkKKwkJbXNsZWVwKDIwMCk7CisKIAlyZXQgPSBpMmNfaGlkX2ZldGNoX2hpZF9kZXNjcmlwdG9y
KGloaWQpOwogCWlmIChyZXQgPCAwKSB7CiAJCWRldl9lcnIoJmNsaWVudC0+ZGV2LAo=
--0000000000005666540658b4ba8d--
