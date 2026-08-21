Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63497472542
	for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 11:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787311417; cv=pass; b=EyBgyD9CFb5K8hOS8x+692X4GZHHG633Co8YKpb5P3HBXyF9ePWcpIx0TPOTLy3OcX55p6fwarPyZ7yuhSttb0Blngwvth3+K6CDVMgT0UnySIt5hprJPIslKMjFhl77DHq/CoC3guDGbDvkIais04RrmY4OSN5+TMiWzsNVmz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787311417; c=relaxed/simple;
	bh=LiExl+gOe3SeIzZXSuj4Zafu/2QOIkUK5hELicXazKo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HWxUi8hUYkJCKEJADjPZx0SZdVrwWYnnztaABKrUwk65wun8Ew1x/4adXCf8hyZtJpRqI1JxIj6kP0UWkEFOs21ERcZSJlGqgsuyPFDvc81oQppQfn4fM+6Jny4dO8AT+GgibW8jDoujp/+b5vQvo6qH3c86vwWVpI1XfmOOCR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QatBGwuz; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QatBGwuz"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7eb4d532e65so498822a34.0
        for <linux-input@vger.kernel.org>; Fri, 21 Aug 2026 04:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787311412; cv=none;
        d=google.com; s=arc-20260327;
        b=YiJEuPvH8tB9rlTMdlqjWqbdaF+Ng2ZJYoiPlvfuCOBbEy5dynMAuY4sAU2cFV0MRp
         JEna0Z4hq/pDZJyKx8grcMGBTyU33+qMrvrFFgfB4rhBtAGzbV4nN5l9b4owj6tQpZyY
         7ym30Usvms+jcGdFCOk9uitM1ZoV4zSxNtSgdIXqgHhAB05hVid+IsZY2fVSWkEBNPj5
         zF9iTfQijgcK/g5GY3Kn/W1XYlIhbWlynQMNgAyR+MP7DQNMB9uaEZsSL7ePKUV95G1U
         5nNQS1Fs3cT+qXBzfW810/AipVamQEE8wQMvItdqv2y5We7DX1qttaCUx18Nm4WnOaWT
         apdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XP0TXz3XgGZqxpegnUNB5sva+CKg8bV+74SS+MJugIo=;
        fh=8L8IpbQWGj3EQNd0Gzzu/yDeSzilxjycu1QnTvtU564=;
        b=NLvwvipLMWwBQwHMaReaf1UncQX48U7hrGJE2lrP1j0QIDZWjrC9I7ERROhudtFynB
         f2yJkY6DEhPy2bxwnjaSSg6pIsRl9cJ15ifYgSTnnXaEdRD1rQOQH+94UVPzhjAL237Y
         77NJx84bf4b7Z//ix9rdT71telAhho9bMqzJch541LGbeZKgyAvfVhNn83X0wbxp8rS4
         nMDyhyHQ74VWFfn/as/Ya+sSaMTVSQweeE+QZ2MhLosb6TF96pl059QYER/18SN+T3VV
         FfQTvvMeVBgAOG3RxqXcPP/qVCNMCi6xN8DP69c4RX+JB8tRMAyoEuVsW1For0NgRVgz
         LNZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787311412; x=1787916212; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XP0TXz3XgGZqxpegnUNB5sva+CKg8bV+74SS+MJugIo=;
        b=QatBGwuzib0/erTsEzv2jLI45++dS1cTy/BJrdOVJ+wSglKZiwxWPGx8FPVpJcdCau
         hLdc5+AHY+UUr0QFypFZM8YwMG/gGBz8MXYWpB814qn/4/OLtGauMWgwqc/D+UIrH7/m
         JPd9BemOiGMgYj75N+rD3EIYdmBcHoAfcUpi4SJV5Uv1bQ3K8W1hUlCvngvK7OrLscmB
         QpxCEw1medGVmy3IYvCL3zA2vv1pcssztHRWstsMY6rkLdRbQkdOw7CCMLCUKiAofujL
         W+T0Ff80FmGaunn7Rrk46LpD1VaMdtv+0gcHQwesULprp/5ZlKZG1B2t2ExDSywoxJzS
         BoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787311412; x=1787916212;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XP0TXz3XgGZqxpegnUNB5sva+CKg8bV+74SS+MJugIo=;
        b=agb+1zm9Blv/1Jt0e5n3L5YrIbhQ0dNQdW50MXbepL/bz4Cl1NB3K5Gd9MaeYGABm+
         L+rMEkVmM64vy6FFpQCeC54spifjojf4b6aaYA2EMRTeP8rCwq7HJiahoQ4n1cAeCzZA
         tpjk3e0gV9/pDWIshQdJJHjBRY/gXEAiQ3LGM3AbS1ayJOFSAIqYwyl8zKWdG3EoIlYC
         4paPwcxeqROXzrUOsu5atpRW839cqztbTfeely4FiXPYlJXEiaQwUkBVIYA89/CYPeZG
         LDzzrUiRoYlWr6olP5rM8S45xszN6qd5Eotw4fu386pMATm170UJ2iMYzgD8S0HwuZ5N
         Jc1g==
X-Forwarded-Encrypted: i=1; AHgh+RqK1a8BNtDsv+fOm0w06p1JbThplpN0CVEBkT1lfDR6vHsy+5up8dvIm93TtDY1Im0dn1PNP0eCjxzNsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm5+8VbCptNwgHFoaCNNPzIAD/a19kq3YPf6cMEADh3iTky9q9
	VsXjCkZUSKY6vYFPG3uLR0vyki1JcHy9thweqHIzCCtdW6zD2AeoDjoaa7Heug48CIq/vONAUir
	cE/0MIl9YJ5t/c2RI8LJO2sGR+lXz0oQ=
X-Gm-Gg: AR+sD10m+hpM3Pgw8eRd7AAVvIrpO4HejjALmyv8HaVGDNUKGX+r61KDAxM/40GfiO/
	pQ/DMdo6V8o74/Ufh5pHfjKcMOWs45klypOzqGyIT0+NbZJB187RrD6GrkFe3LrsEbgkxaFOogY
	WDEQjUdK7wAcs1r2AKXHEeG6+GVQz0SSI2SOsHTWtm1TTepy6MXxEy7evLRcqOzlL/cSkgvhisE
	amQKY65ZaYumZaPccFV+pDybm+aFdvsKZjbqLMGzuav4vY22g4BDra4V1khSrueazDnvdUwrXmF
	bQp8h2fPbYFpB2i9H6POCxLr4j4FjiC5HfYqjYQyisakE1Qh1eHXBXsuNyFZzuqwd4KPUx1u0A6
	Rznzv+G4+CGR733CX0Neol3QISeXnFeH4/gzxhvNRklFO
X-Received: by 2002:a05:6830:2b0f:b0:7e9:8867:cb23 with SMTP id
 46e09a7af769-7f46173cb90mr6196887a34.16.1787311411854; Fri, 21 Aug 2026
 04:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y0eaxz39.wl-tiwai@suse.de> <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
In-Reply-To: <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Fri, 21 Aug 2026 16:23:20 +0500
X-Gm-Features: AcwNN1WSC1RC40OlRsvrLRcT0ZtouTJ1WArekA-2DoyJ-r1DwXMS-VEfJgk_jP0
Message-ID: <CABXGCsMXRZaM9yKsyyffkfyXXDjHXhyixXZ-jz9BY=xJn0R7DA@mail.gmail.com>
Subject: Re: [RFC 0/2] Two ways to reach the Topping M62's analogue gains
To: tiwai@suse.com, jikos@kernel.org, bentiss@kernel.org
Cc: perex@perex.cz, linux-sound@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:13=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> You asked for PoCs of both roads and a comparison of the actual code
> rather than of arguments. Here are both. They are alternatives, not a
> series: each is written against mainline 98f21c54f995 on its own, and
> either can be applied alone.
>
>   1/2  ALSA: usb-audio: a mixer quirk that claims the HID interface
>   2/2  HID: topping: a HID driver that registers a card of its own
>
> Both build clean (checkpatch --strict: 0 errors, 0 warnings; the two
> CamelCase CHECKs in 1/2 are bNumEndpoints and bInterval) and both have
> been exercised on the device -- 152a:875c, bcdDevice 3.27 -- for
> reading, for unsolicited notification from the front panel, and for
> writing.
>
> What the device is
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The M62 keeps its two microphone preamp gains, its AUX and Bluetooth
> input volumes and its headphone and OTG output volumes behind a vendor
> protocol on a HID-class interface, and exposes none of them through
> UAC. What UAC does expose on the capture side is a digital trim after
> the converter, which cannot buy signal-to-noise: a noise-floor ladder
> against the card shows the converter's own floor rising with the
> signal. So on Linux today the one knob worth setting is the one that
> cannot be reached, and a measurement application has to begin by asking
> a human to touch the front panel.
>
> The protocol is fifteen-byte frames -- start magic, a constant, a
> target, a property, a signed 32-bit big-endian value, CRC-16/MODBUS
> over the middle stored big-endian, end magic. Rebuilding all 2619
> captured frames from that description reproduces them byte for byte.
> The device says nothing until it is subscribed; one write starts the
> stream and a second makes it announce its whole state, after which
> every change arrives unasked, including a front panel press.
>
> The control pipe is not an option: GET_REPORT and SET_REPORT stall with
> EPIPE for every report type, so the interrupt endpoints on the HID
> interface are the only route.
>
> What is identical in both
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> The frame builder, the parser, the CRC (the kernel's crc16(0xffff, ...)
> is CRC-16/MODBUS, so no private table), and the control table. A knob
> is a row of
>
>         { name, target, paired target, property, min, max, TLV }
>
> so adding one is adding a row. Six rows today. The outputs come in
> pairs because the device answers on only one target of each pair and
> the other would drift away unheard.
>
> Where they differ
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1/2 claims the HID interface for snd-usb-audio and puts the elements on
> the card the device already has. The cost is two-sided: an entry in
> hid_ignore_list to keep usbhid off the interface, and one new helper in
> sound/usb/card.c, because usb_audio_driver is static there and a quirk
> cannot claim an interface without it. That helper is the only change in
> 1/2 outside the new file and its dispatch. Nothing is lost by taking
> the interface: the report descriptor is a Generic Desktop application
> collection with eight unnamed usages, sixteen bytes in and out and no
> report ID, so hid-generic can only build an input device for a mouse
> that does not exist -- which is what it does today.
>
> 2/2 binds as a HID driver, and the protocol half is if anything smaller
> there: usbhid owns the endpoints, so hid_hw_output_report replaces a
> hand-built interrupt URB out, raw_event replaces the one in, and no
> interface has to be claimed. It needs nothing in sound/usb.
>
> But these are mixer controls for an audio device, and the audio
> device's card belongs to snd-usb-audio. A HID driver cannot put an
> element there. There is no interface for it, and inventing one means
> exporting from sound/usb both a lookup from struct usb_device to the
> card and an add-element call, and then answering, for a single device,
> what happens when the two drivers probe in either order and when either
> disconnects first, given that the element would live in one module and
> its private data in another.
>
> So 2/2 does what a HID driver can do alone: it registers a card of its
> own. That works, and the cost is visible from userspace rather than
> theoretical:
>
>         $ cat /proc/asound/cards
>          0 [ToppingCtl     ]: Topping - Topping M62 control
>          ...
>          4 [M62            ]: USB-Audio - M62
>
>         $ amixer -c M62 cset name=3D'Mic-1 Analog Capture Volume' 33
>         amixer: Cannot find the given element from control sysdefault:4
>
> One device, two cards; the gains on a card with no PCM beside them; and
> anything that looks for a device's mixer next to its streams --
> alsamixer -c, UCM profiles, PipeWire's device model -- does not find
> them there.
>
> Against my own preference, two honest notes. The phantom input device
> 2/2 leaves at boot (hid-generic binds first, the specific driver being
> a module outside the initramfs) is a packaging artefact, not a property
> of that road. And 1/2's claim helper is new API surface in sound/usb,
> small as it is.
>
> Field results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> With 1/2: the interface belongs to snd-usb-audio while a neighbouring
> device's HID interface still belongs to usbhid, so the ignore entry is
> precise. Values arrive by themselves -- the headphone volume came up at
> 51 while the zero-initialised cache would have said 0. One front panel
> press produces exactly one control event. A write reaches the hardware:
> the device reports the written value back, and its meters answer.
>
> With 2/2: the same, on its own card.
>
> One device fact worth recording: a written gain takes effect at once,
> but when the device commits it to non-volatile memory is the firmware's
> business, and a value written and then torn off the bus can come back
> as the older one. Nothing in either driver depends on that -- neither
> treats itself as the source of truth, both ask the device -- but it is
> easy to mistake for a driver bug while testing.
>
> Where I come out
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The knobs belong on the card the device already has, and 2/2 cannot put
> them there without a new cross-subsystem interface built for one
> device. 1/2's cost is one static-variable problem solved by one helper
> in the file that owns it. So I would take 1/2, which is also your gut
> feeling -- but the comparison is what you asked for, and either patch
> stands alone if you read it the other way.
>
> Not covered by either: the OTG input's gain. It has no front panel
> control and therefore never announced itself in any capture, so its
> property is unknown. It is one row when it is known.
>
> Mikhail

Three things I should have said in the cover letter, one of which
argues against the conclusion I drew there.

The quirk's hid_ignore_list entry means no hidraw node is created for
this device at all. Topping ship a control application for Windows and
macOS and not for Linux; there is none today, and the driver should not
block one if it appears. The HID road leaves that channel open and the
quirk road closes it. I weighed the two roads by where the mixer
controls can live and did not weigh this, and it belongs on the scale.

The one gap the cover letter named is closed. The OTG input's gain is
target 0x27, property 0x04, on the same taper family as Bluetooth --
read out of a capture of the vendor application moving it, with the
indices it dwelt on matching the decibels it displayed. Both patches
carry the row here; I have not resent them for one line, and it will be
in whichever version goes forward.

And the protocol turns out to need more than a write path, which bears
on the complexity you asked me to compare. The vendor application
repeats its subscribe every two seconds, so a driver has to keep that
up or the device stops reporting; the device has two memories, and a
separate command commits the live state to the one that survives a
power cycle; and the source selectors -- which mix or bus each output
listens to -- can be written but never read: the device does not
announce them, and the vendor application does not ask, because on
connect it pushes its whole workspace rather than reading anything.
None of that favours either road, since both pay it identically, but it
is a fair bit more than a table of gains, and I would rather you saw it
before deciding.

I have not resent the patches. Both roads work on the hardware; the
question is still which one you would rather carry.

--=20
Thanks,
Mikhail Gavrilov.
