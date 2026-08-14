Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2533EC804
	for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786703942; cv=pass; b=ioFt/2JEo69TFxigAZln1n88OtTrjOwJwz8UzYDut+vNRjoa6IpsDPzl67s4J3j/Pt7i/D/Dpv/64d1k7aDu39Ge2LGsgzLlSVyOZk5DrtcQq5jYmU+5y+xzGtFLhfSPx8I8BsUgx/RkRWXzi7gyA6R0PaZOB61SgoFuKgdqXR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786703942; c=relaxed/simple;
	bh=AlcUIUfyQ0jCXJRDKuRy9MgQqZZUa3Sn7Qq5SHS3iyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pvfXdRsHaVJHri796yvbgXcBDX8deUhn1xJToDoH18g7MohR4OyCMsWF7AXH4WOZPBCbXyhQLf9z4q6HkAF0/BgMM60778Igx1ev9UxIUl7RknzEdOwI9FV6ENrHvmO+3TEqF0yzhW311ZIth46THzqojaqc3mFcw8jO3Fll5/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyqU4kXy; arc=pass smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyqU4kXy"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-936cda0e3fbso70964085a.3
        for <linux-input@vger.kernel.org>; Fri, 14 Aug 2026 03:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786703933; cv=none;
        d=google.com; s=arc-20260327;
        b=Rw85VbdElxhTiPuIuNALSZrAR0BKVypf51wcLmK+P5V7uwH2cSNtZA321xfgDtrhJ5
         p6eOfPg/RKTROyaYLV2A0gntdAL215rpTig2uEjTIgmEhm43YewLELc476IUVTfa3ofh
         Kai0eZMVCaA2Lc2Zoa+W18Y3oX7kHOTfrjR3JlbPN//SheqbcIcNNX//Toy046RwSU6j
         9nn6uzIue6wvfxY3CC08w0cIErXZ8fWnHV0yrZ9n8/yajMI9Z7huZxAUG0IEKt6gko8e
         ip7iYNMwB48b4I20e3PS33N93enO9XGHuibcXc4jjTd1/+ygyJsaPMW8n5vvbOGlyWgE
         y9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=K891zjbJe2c3FxZOLYlVrngFZYWDi3Z9LNw6jnZV8UE=;
        fh=BuXfmXABUeR2qLTg/VXPcR3U5Opt18p/PyP0qKwXam4=;
        b=cktRjNUnltgBu+cJVkMdQAKIsMPheTCrDYqWl6DW9ebG5hdv/EuLOu6OWw9vJsG9Pt
         U+SsBz5Tcn13DYKwgwPWvoVljtiWRPDbuFhCbZwApk1QLw64j7EGFunev6Kk2cPtE6PR
         cN0BXZTDsfcFN8Fc1iJPDYcXG+PuJ7Ojv2db/d8sw0aOm7pf87F9rzJ4WFKGEz9cqbmz
         IIIh30zQv6WmOtVOw9XeTZBYmf5rfHeH6pOXFZT/YisTrJcKcV+R8GWFLH5nCwgPczyC
         5UGy6cIsp1Amjmx4SB8DKWTOG+NXwCk3jwyuZcPOZk+CXEI+3vvVSiMykdGbcX9ZWU+A
         2Ccg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786703933; x=1787308733; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K891zjbJe2c3FxZOLYlVrngFZYWDi3Z9LNw6jnZV8UE=;
        b=NyqU4kXyGX+XCPFDBOY8uYvf6xonnazsw/8oAasKLBYMzCI/K/UtJdsIjPLRxJxMp5
         U0KkqTp5hIJPa64PcYUsVxyaemFpIe0HYq61JOXUiqBtASY5ER5xifs+qGVIkteLRC2F
         wXMckPA7A//gKTKzbAuQbkk0Eav27GcZulfWvoLq8rgdnuW/tJIl1KLCmCjzLPMFu3MG
         /ROs7X9qBQ0JICrUXZRKiaPae9hN+zzQfoyYZn72FoSCmWWiImxRWmVRMgP8YM4jdsDD
         uqORpaik5B9/9jx67UT5kLlst8aykFTb2+CZv6sjfMO7DbbyYzHqcJH1jud0Zi7+Pxeb
         BOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786703933; x=1787308733;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K891zjbJe2c3FxZOLYlVrngFZYWDi3Z9LNw6jnZV8UE=;
        b=CN3qqF+A/DU14RVoCFznoIAEKMlHBwt8aRRTLR6uzPeRtoT/QNw/3Rb2gsUh05OW2S
         vu7Tug33aJgL54tD+bLb0ZsXfwxq9gKBZkjurqkB9f+E23gYBOL7m3R/Y3XiX1j7yQ9o
         TNEricWDI7Afeb4inFePuNeZBpLCYDT3gtmtSK2261Ozn0wrZWDNG6eQHt2Fv262IDtG
         b6p0KOyu+o7D0dZYOufU2Uef24KnSPmgzedIa3aupiVPr8WFYXWGMcww9Q+aK0helG+u
         AAQa96FnYL4xUrAnHNRpHI1sL50dcNA44K0dNm9Fg66F7mc+N8Gh9FSG1JA/lVyrZJke
         y8Qw==
X-Forwarded-Encrypted: i=1; AHgh+RqIgdxvP0H4ekInCXO6KvXsiCwiJa09xdEKG3aYWtpWi9CSfTvck9HYsq5HXS0jiLUv2gHQsnrtsUQWpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxehOjIJuJ2gaYLn3KBc/5lKojUHtqU4i119r6OWvWcUJrGCGy
	C72xx8dHoCNuIq3t8ixOhIXpqBSSJq9z8ahqNKkztQIYkjzH6vLxLL4kjGNoRka21X3YrYxzUep
	4Icq9ipMFVCAGSulcn9daizUVYyznuB4=
X-Gm-Gg: AR+sD11cjV9f1A+/s8NDnupNrD3hfH38L+wfJM3P8AYi+Xqr/ROpH0jSAmQnvfMWUek
	941eLUYlMbS80a7x40R4NBJ3CdDtS8l9LSOReQnD95NMmgbnaOmrcu+CN1BtzhpcVkXQycZT1JV
	7VKnYb5Rz+djaYKCHgVHKlI60muCIfiYouDTAy8A6G895RgFptGB5e39vJnGAKbr/5GzHq3AbX6
	uduPYA5gOQuo7C+LApM2n2lQ0Wlkh9WydGBz7Hc35nX4b9yI3g5f3l54SSFNCxTQA7gkQH70wqG
	MBAbxboLp6KW3Gbgv5RrwOtA8+UZ5ZOVFVK7lUb8x4bnT/i+6gKcJWtiY23q5lU=
X-Received: by 2002:a05:620a:3c12:b0:931:328:fecf with SMTP id
 af79cd13be357-936d22c6effmr316550585a.26.1786703933336; Fri, 14 Aug 2026
 03:38:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEru=6LrMqg93AKrmbTJtvRNPx=arYuhSf4zMw4bK1SjWQQvrw@mail.gmail.com>
In-Reply-To: <CAEru=6LrMqg93AKrmbTJtvRNPx=arYuhSf4zMw4bK1SjWQQvrw@mail.gmail.com>
From: Adam <testyiprywatnosc@gmail.com>
Date: Fri, 14 Aug 2026 12:38:41 +0200
X-Gm-Features: AUfX_mwB0B3yX9FNNUqGgf6oIG5lKsgL5J3HVxQU9J21svQLDYu1i5hJUFngM7M
Message-ID: <CAEru=6L4MuQ-XFsM1+v5fyy0BB=2dAJWNCekDmdpdMRFuFZ5Hg@mail.gmail.com>
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
To: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004409450658ff6d97"

--0000000000004409450658ff6d97
Content-Type: multipart/alternative; boundary="0000000000004409440658ff6d95"

--0000000000004409440658ff6d95
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Quick correction to my previous message - I found a logic bug in the patch
I attached.

The second hunk (delay before the very first HID descriptor fetch in
probe()) checked `ihid->quirks & I2C_HID_QUIRK_BOGUS_IRQ`, but at that
point in probe() the USB vendor/product ID hasn't been read yet - it's
only populated a few lines later, from the very descriptor fetch the
delay was supposed to precede. So the quirk lookup hadn't happened yet,
the condition was always false, and that delay never actually ran. That
explains why the timing in dmesg was unchanged with the patch applied.

I've fixed this by keying off the ACPI/i2c device name instead
(`dev_name(&client->dev)`, e.g. "i2c-ELAN0718:00"), which is available
from the very start for ACPI-enumerated devices. Updated patch attached
(v2). I haven't been able to fully verify this version end-to-end yet
(ran into some build/test issues on my end), so please treat it as a
starting point rather than a confirmed fix - happy to test further if
useful.

Thanks,
Adam

On Mon, Aug 10, 2026 at 7:31=E2=80=AFPM Adam <testyiprywatnosc@gmail.com> w=
rote:

> Hello,
>
> I'm reporting a reproducible probe failure for an ELAN i2c-hid touchpad
> (ACPI ELAN0718:00, VID:PID 04F3:30FD) on an HP Pavilion Gaming 15-ec1033n=
w
> (AMD platform, i2c bus under AMDI0010:03). The touchpad fails to
> initialize on nearly every boot on Linux, while the same hardware works
> reliably every time under Windows 11 on the same machine (dual context,
> same BIOS F.35 rev.A).
>
> Kernel: 7.1.6-arch1-1 (Arch Linux)
> Also reported by other users with the same touchpad ID on different
> kernels/distros (Arch, Ubuntu, Linux Mint) going back to at least 2022:
> - https://bbs.archlinux.org/viewtopic.php?id=3D277393
> - https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2031061
> - https://forums.linuxmint.com/viewtopic.php?t=3D329212
>
> Symptom (default logging):
>
>   i2c_hid_acpi i2c-ELAN0718:00: failed to fetch HID descriptor: -121
>   i2c_hid_acpi i2c-ELAN0718:00: Failed to fetch the HID Descriptor
>   i2c_hid_acpi i2c-ELAN0718:00: probe with driver i2c_hid_acpi failed wit=
h
> error -121
>
> With dynamic_debug enabled for i2c_hid and i2c_hid_acpi:
>
>   i2c_hid_start_hwreset
>   i2c_hid_set_power: cmd=3D05 00 00 08
>   i2c_hid_xfer: cmd=3D05 00 00 01
>   i2c_hid_finish_hwreset: waiting...
>   i2c_hid_finish_hwreset: finished.
>   asking HID report descriptor
>   i2c_hid_xfer: cmd=3D02 00
>   reading report descriptor failed
>   can't add hid device: -121
>   probe with driver i2c_hid_acpi failed with error -121
>
> Note the device is already tagged with I2C_HID_QUIRK_BOGUS_IRQ and
> I2C_HID_QUIRK_NO_WAKEUP_AFTER_RESET via the USB_VENDOR_ID_ELAN,
> HID_ANY_ID entry in i2c_hid_quirks[], but this specific chip still
> appears to need additional settle time between the reset-complete IRQ
> and the immediately following descriptor read - the two happen back to
> back (sub-millisecond apart in the trace) with zero delay.
>
> The i2c bus and controller are not at fault: an ACPI-level PCI
> remove/rescan of the SMBus controller (0000:00:14.0, piix4_smbus)
> successfully re-enumerates the bus, and once probe *does* succeed
> (intermittently - roughly 1 in 10-15 boots in my testing), the touchpad
> works completely normally for the rest of the session. This points to a
> narrow timing race rather than a persistent hardware/firmware fault.
> Windows never exhibits this behavior on the same machine.
>
> I tested a draft workaround patch (attached) attempting to add msleep()
> delays after i2c_hid_finish_hwreset() and before descriptor fetch for
> devices with I2C_HID_QUIRK_BOGUS_IRQ, but the issue still persists on my
> machine. I am attaching the patch and debug logs in hopes that maintainer=
s
> can pinpoint the exact timing, sequence, or quirk needed for this ELAN
> revision.
>
> Happy to test alternate patches, adjust delay values, or gather any
> additional traces (i2cdump, further dynamic_debug, ACPI tables via
> acpidump) if useful.
>
> Hardware:
> - HP Pavilion Gaming 15-ec1033nw
> - AMD Ryzen 5 4600H
> - BIOS F.35 rev.A (latest per HP support site)
> - Touchpad: ACPI ELAN0718:00, USB VID:PID 04F3:30FD, on i2c-3 /
>   AMDI0010:03
>
> Let me know if you'd like the full dmesg, acpidump, or anything else.
>
> Thanks,
> Adam
>

--0000000000004409440658ff6d95
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Quick correction to my previous message - I found a logic =
bug in the patch<br>I attached.<br><br>The second hunk (delay before the ve=
ry first HID descriptor fetch in<br>probe()) checked `ihid-&gt;quirks &amp;=
 I2C_HID_QUIRK_BOGUS_IRQ`, but at that<br>point in probe() the USB vendor/p=
roduct ID hasn&#39;t been read yet - it&#39;s<br>only populated a few lines=
 later, from the very descriptor fetch the<br>delay was supposed to precede=
. So the quirk lookup hadn&#39;t happened yet,<br>the condition was always =
false, and that delay never actually ran. That<br>explains why the timing i=
n dmesg was unchanged with the patch applied.<br><br>I&#39;ve fixed this by=
 keying off the ACPI/i2c device name instead<br>(`dev_name(&amp;client-&gt;=
dev)`, e.g. &quot;i2c-ELAN0718:00&quot;), which is available<br>from the ve=
ry start for ACPI-enumerated devices. Updated patch attached<br>(v2). I hav=
en&#39;t been able to fully verify this version end-to-end yet<br>(ran into=
 some build/test issues on my end), so please treat it as a<br>starting poi=
nt rather than a confirmed fix - happy to test further if<br>useful.<br><br=
>Thanks,<br>Adam</div><br><div class=3D"gmail_quote gmail_quote_container">=
<div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 10, 2026 at 7:31=E2=80=AF=
PM Adam &lt;<a href=3D"mailto:testyiprywatnosc@gmail.com">testyiprywatnosc@=
gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr">Hello,<br><br>I&#39;m reporting a reproducible =
probe failure for an ELAN i2c-hid touchpad<br>(ACPI ELAN0718:00, VID:PID 04=
F3:30FD) on an HP Pavilion Gaming 15-ec1033nw<br>(AMD platform, i2c bus und=
er AMDI0010:03). The touchpad fails to<br>initialize on nearly every boot o=
n Linux, while the same hardware works<br>reliably every time under Windows=
 11 on the same machine (dual context,<br>same BIOS F.35 rev.A).<br><br>Ker=
nel: 7.1.6-arch1-1 (Arch Linux)<br>Also reported by other users with the sa=
me touchpad ID on different<br>kernels/distros (Arch, Ubuntu, Linux Mint) g=
oing back to at least 2022:<br>- <a href=3D"https://bbs.archlinux.org/viewt=
opic.php?id=3D277393" target=3D"_blank">https://bbs.archlinux.org/viewtopic=
.php?id=3D277393</a><br>- <a href=3D"https://bugs.launchpad.net/ubuntu/+sou=
rce/linux/+bug/2031061" target=3D"_blank">https://bugs.launchpad.net/ubuntu=
/+source/linux/+bug/2031061</a><br>- <a href=3D"https://forums.linuxmint.co=
m/viewtopic.php?t=3D329212" target=3D"_blank">https://forums.linuxmint.com/=
viewtopic.php?t=3D329212</a><br><br>Symptom (default logging):<br><br>=C2=
=A0 i2c_hid_acpi i2c-ELAN0718:00: failed to fetch HID descriptor: -121<br>=
=C2=A0 i2c_hid_acpi i2c-ELAN0718:00: Failed to fetch the HID Descriptor<br>=
=C2=A0 i2c_hid_acpi i2c-ELAN0718:00: probe with driver i2c_hid_acpi failed =
with error -121<br><br>With dynamic_debug enabled for i2c_hid and i2c_hid_a=
cpi:<br><br>=C2=A0 i2c_hid_start_hwreset<br>=C2=A0 i2c_hid_set_power: cmd=
=3D05 00 00 08<br>=C2=A0 i2c_hid_xfer: cmd=3D05 00 00 01<br>=C2=A0 i2c_hid_=
finish_hwreset: waiting...<br>=C2=A0 i2c_hid_finish_hwreset: finished.<br>=
=C2=A0 asking HID report descriptor<br>=C2=A0 i2c_hid_xfer: cmd=3D02 00<br>=
=C2=A0 reading report descriptor failed<br>=C2=A0 can&#39;t add hid device:=
 -121<br>=C2=A0 probe with driver i2c_hid_acpi failed with error -121<br><b=
r>Note the device is already tagged with I2C_HID_QUIRK_BOGUS_IRQ and<br>I2C=
_HID_QUIRK_NO_WAKEUP_AFTER_RESET via the USB_VENDOR_ID_ELAN,<br>HID_ANY_ID =
entry in i2c_hid_quirks[], but this specific chip still<br>appears to need =
additional settle time between the reset-complete IRQ<br>and the immediatel=
y following descriptor read - the two happen back to<br>back (sub-milliseco=
nd apart in the trace) with zero delay.<br><br>The i2c bus and controller a=
re not at fault: an ACPI-level PCI<br>remove/rescan of the SMBus controller=
 (0000:00:14.0, piix4_smbus)<br>successfully re-enumerates the bus, and onc=
e probe *does* succeed<br>(intermittently - roughly 1 in 10-15 boots in my =
testing), the touchpad<br>works completely normally for the rest of the ses=
sion. This points to a<br>narrow timing race rather than a persistent hardw=
are/firmware fault.<br>Windows never exhibits this behavior on the same mac=
hine.<br><br>I tested a draft workaround patch (attached) attempting to add=
 msleep()<br>delays after i2c_hid_finish_hwreset() and before descriptor fe=
tch for<br>devices with I2C_HID_QUIRK_BOGUS_IRQ, but the issue still persis=
ts on my<br>machine. I am attaching the patch and debug logs in hopes that =
maintainers<br>can pinpoint the exact timing, sequence, or quirk needed for=
 this ELAN<br>revision.<br><br>Happy to test alternate patches, adjust dela=
y values, or gather any<br>additional traces (i2cdump, further dynamic_debu=
g, ACPI tables via<br>acpidump) if useful.<br><br>Hardware:<br>- HP Pavilio=
n Gaming 15-ec1033nw<br>- AMD Ryzen 5 4600H<br>- BIOS F.35 rev.A (latest pe=
r HP support site)<br>- Touchpad: ACPI ELAN0718:00, USB VID:PID 04F3:30FD, =
on i2c-3 /<br>=C2=A0 AMDI0010:03<br><br>Let me know if you&#39;d like the f=
ull dmesg, acpidump, or anything else.<br><br>Thanks,<br>Adam</div>
</blockquote></div>

--0000000000004409440658ff6d95--
--0000000000004409450658ff6d97
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="elan-touchpad-bogus-irq-reset-delay-v2.patch"
Content-Disposition: attachment; 
	filename="elan-touchpad-bogus-irq-reset-delay-v2.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_msstdnz10>
X-Attachment-Id: f_msstdnz10

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
IAlyZXR1cm4gcmV0OwogfQogCkBAIC0xMDUyLDYgKzEwNjQsMjEgQEAKIAkJcmV0dXJuIC1FTlhJ
TzsKIAl9CiAKKwkvKgorCSAqIFNvbWUgRUxBTiBpMmMtaGlkIHRvdWNocGFkcyAoZS5nLiAwNEYz
OjMwRkQsIHNlZW4gb24gSFAgUGF2aWxpb24KKwkgKiBHYW1pbmcgMTUtZWMxeHh4KSBhcmUgbm90
IHlldCByZWFkeSB0byBhbnN3ZXIgdGhlIHZlcnkgZmlyc3QgSElECisJICogZGVzY3JpcHRvciBy
ZWFkIG9uIGNvbGQgYm9vdCAvIHBvd2VyLW9uLCBiZWZvcmUgYW55IHJlc2V0IGhhcworCSAqIGV2
ZW4gYmVlbiBpc3N1ZWQsIGNhdXNpbmcgYW4gaW50ZXJtaXR0ZW50IC1FUkVNT1RFSU8gKC0xMjEp
IGhlcmUuCisJICogQXQgdGhpcyBwb2ludCBpbiBwcm9iZSgpIHRoZSBVU0IgdmVuZG9yL3Byb2R1
Y3QgSUQgKGFuZCB0aHVzCisJICogaWhpZC0+cXVpcmtzLCBsb29rZWQgdXAgZnJvbSBpdCkgaXMg
bm90IGtub3duIHlldCAtIGl0IGlzIG9ubHkKKwkgKiBwb3B1bGF0ZWQgYSBmZXcgbGluZXMgYmVs
b3csIGZyb20gdGhlIGRlc2NyaXB0b3Igd2UgYXJlIGFib3V0IHRvCisJICogZmV0Y2guIFNvIGtl
eSBvZmYgdGhlIEFDUEkvaTJjIGRldmljZSBuYW1lIGluc3RlYWQsIHdoaWNoIGlzCisJICogYXZh
aWxhYmxlIGZyb20gdGhlIHN0YXJ0IGZvciBBQ1BJLWVudW1lcmF0ZWQgZGV2aWNlcyBzdWNoIGFz
CisJICogdGhpcyBvbmUgKEVMQU4wNzE4OjAwKS4KKwkgKi8KKwlpZiAoc3Ryc3RhcnRzKGRldl9u
YW1lKCZjbGllbnQtPmRldiksICJpMmMtRUxBTiIpKQorCQltc2xlZXAoMjAwKTsKKwogCXJldCA9
IGkyY19oaWRfZmV0Y2hfaGlkX2Rlc2NyaXB0b3IoaWhpZCk7CiAJaWYgKHJldCA8IDApIHsKIAkJ
ZGV2X2VycigmY2xpZW50LT5kZXYsCg==
--0000000000004409450658ff6d97--
