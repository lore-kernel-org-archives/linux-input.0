Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A0337F73D
	for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 15:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238815; cv=none; b=mAmMRC0LvZCWXLVcSbGvce3/3Pb+HG7No5Y48NwWlPiyipGorkz57irvGIFDGY9wZ2t0qRUopGTpp6S1TArkwWVEuUgy1GDFu7UvKn135SNMYnAFSDpzwWguy9tsaRo+FgHFasW/FCf7k49IlTQ39QVaeilMXuACvd9xKYPZHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238815; c=relaxed/simple;
	bh=6Ald7vZ6kBCoO8E+et7GzfHLmpauYeQ1CHl+O3YPb24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N20TxyudQly4j2vgR+zn7AG568GXmzziBe7OcalHEY440TvuzA78n7IY0Sf2Yt8gok4JonXvJlraMTVXV6nJ33y+8vI7zt77b/lTNfTCNeBBf3KtAOyE1UH0Q6wi9IlYnfMaj7r/6ho/yxLjpyzqeyr1jNdyziwbdOHZtoxgDhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SqUM6lBs; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SqUM6lBs"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b15c6fb864so2239723e87.1
        for <linux-input@vger.kernel.org>; Thu, 20 Aug 2026 08:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787238812; x=1787843612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WoAaczqx9vz90sCyu2Uto6aX0IpeQLuBL6PDZDK9ORg=;
        b=SqUM6lBsVARRhIMl9HvKLC+pWkotnDq1TB37tcsKHU59kSxZpwr14pBqgHhnY5RNW+
         +WDbAG1F2v6jw8cBauxgdXLWqbWROKQe0nkWQbfsdcR8kwXCT9FdLzE0KkVN098dyo9M
         tqWkFbii4MvvSdwhqR3fcmSxPbd8QXv1leeTLez/2WMgr73aK/1ZS8BToMisl71L8T64
         jLgO3w29W/JQ981n8WspPVrqfDalD12lIGQxgTUG6nV3hdQWdJx3BduIoLS3uB4aBLFt
         P5FVTx8lY/r5KzfY624g41Qvf4fmFPUvSQJtsAdbx+3MYLuXtxQ7nudYc1tTPE371dTR
         B/Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787238812; x=1787843612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WoAaczqx9vz90sCyu2Uto6aX0IpeQLuBL6PDZDK9ORg=;
        b=NhGT3292NaFDG7qhVTnJ0HM5tabu/4yiK0/V6m7YjB15IDlokdAPMMpQEHtxbpkkF4
         HtpL9ADcLGRJzwFLqcx2M0gn1ef64k7CaQfM2VYHQDQYhIdjwyTyarYxZzUSN6R1eeu8
         QXwz8R/iGTbFpo3yzEBcvk+hrIrfKgoPZMUNn5D6NCg6B/O/zmpTQ9ylFrCHRIGJkddY
         wPqX0ilcULoZcq4atx0WuoeYhwEbOxLjAYdkkuGuadXgPxmEBpm05XIVAjSDgH9TwoAR
         yjH/5s14sUEzOmxPbZ2s5b+fKKJI6zY8mAr8pJH42r/tKr8f9UeNRy7wAMk1cH1xujj2
         TpfQ==
X-Forwarded-Encrypted: i=1; AHgh+RqttUVSW+jDVTmRlsVOXyDHHfT1wq93Qbv2SXd243Lr83Dg997ULcoHvhKHw+eJ9HZZfyoEWrquS1Vgxg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxUkHnHSAdZlVqxNrtHGyebmZtEznR3rP3mqNPrY/ciE7MS7vBG
	6SJl/++plp6+1oMcBmlyhPBO4rI6N/KLRoCXkwIk+Kn5acJG/8AryNYR
X-Gm-Gg: AR+sD13JUX+ZpTBUUIOkVLqlLTfFHePMal/JF4KSB53u4timFKiXUFgrhkiUgVHe6lo
	dsBnaUtgTJhNFobBMcD+X/OAgD4DE8ZMf5wiRts7dKifXY6uPemGzS9B4PMN3mSCGhA/D5x2pIG
	r6xlfpVu0pY4oEuAzZtj8gAK40eiitjBFyxcZOYu2g+vuJKFpvRZ67LL2dcFx9Sq0ouekyXwhtU
	/TkMzYNS1UgTFwFaSyRVCA4Q+JYME3pLWFLm/O82cocXRXXjUzBU4QlaZUD8J+AnrRyJPqZonCn
	KMLe82SupQCYhAm7S8ppAjwQXy3GdB4Lbot2Uon+wjmGcmZaX9pkmuTTGfwYkOIhF57lMDwpYb4
	n+oUtQOxoSL161sBJOQBhJNMTgsygtalrnXj18Lvumyda36q4d0igbMrku5nWwTrxBdkvKqQmf8
	Egz65QqYKEg7p8LF5F9Sl65AyG/m3Lmu1zJOHztOJiJrO6/7/VQ/lm9duY1PvsmYBEPnMMM40oP
	TyN51fdy0WoV74Jc7eSqbXyeT/2EHb/d3gK76Yl8FaWAGrMtEEG3SCAoohZ
X-Received: by 2002:a05:6512:131f:b0:5b1:5a90:25b4 with SMTP id 2adb3069b0e04-5b478bcb7c5mr3792837e87.19.1787238811565;
        Thu, 20 Aug 2026 08:13:31 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b4788f5a60sm1333617e87.77.2026.08.20.08.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:13:30 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: tiwai@suse.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 0/2] Two ways to reach the Topping M62's analogue gains
Date: Thu, 20 Aug 2026 20:13:27 +0500
Message-ID: <20260820151329.18332-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <87y0eaxz39.wl-tiwai@suse.de>
References: <87y0eaxz39.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

You asked for PoCs of both roads and a comparison of the actual code
rather than of arguments. Here are both. They are alternatives, not a
series: each is written against mainline 98f21c54f995 on its own, and
either can be applied alone.

  1/2  ALSA: usb-audio: a mixer quirk that claims the HID interface
  2/2  HID: topping: a HID driver that registers a card of its own

Both build clean (checkpatch --strict: 0 errors, 0 warnings; the two
CamelCase CHECKs in 1/2 are bNumEndpoints and bInterval) and both have
been exercised on the device -- 152a:875c, bcdDevice 3.27 -- for
reading, for unsolicited notification from the front panel, and for
writing.

What the device is
==================

The M62 keeps its two microphone preamp gains, its AUX and Bluetooth
input volumes and its headphone and OTG output volumes behind a vendor
protocol on a HID-class interface, and exposes none of them through
UAC. What UAC does expose on the capture side is a digital trim after
the converter, which cannot buy signal-to-noise: a noise-floor ladder
against the card shows the converter's own floor rising with the
signal. So on Linux today the one knob worth setting is the one that
cannot be reached, and a measurement application has to begin by asking
a human to touch the front panel.

The protocol is fifteen-byte frames -- start magic, a constant, a
target, a property, a signed 32-bit big-endian value, CRC-16/MODBUS
over the middle stored big-endian, end magic. Rebuilding all 2619
captured frames from that description reproduces them byte for byte.
The device says nothing until it is subscribed; one write starts the
stream and a second makes it announce its whole state, after which
every change arrives unasked, including a front panel press.

The control pipe is not an option: GET_REPORT and SET_REPORT stall with
EPIPE for every report type, so the interrupt endpoints on the HID
interface are the only route.

What is identical in both
=========================

The frame builder, the parser, the CRC (the kernel's crc16(0xffff, ...)
is CRC-16/MODBUS, so no private table), and the control table. A knob
is a row of

	{ name, target, paired target, property, min, max, TLV }

so adding one is adding a row. Six rows today. The outputs come in
pairs because the device answers on only one target of each pair and
the other would drift away unheard.

Where they differ
=================

1/2 claims the HID interface for snd-usb-audio and puts the elements on
the card the device already has. The cost is two-sided: an entry in
hid_ignore_list to keep usbhid off the interface, and one new helper in
sound/usb/card.c, because usb_audio_driver is static there and a quirk
cannot claim an interface without it. That helper is the only change in
1/2 outside the new file and its dispatch. Nothing is lost by taking
the interface: the report descriptor is a Generic Desktop application
collection with eight unnamed usages, sixteen bytes in and out and no
report ID, so hid-generic can only build an input device for a mouse
that does not exist -- which is what it does today.

2/2 binds as a HID driver, and the protocol half is if anything smaller
there: usbhid owns the endpoints, so hid_hw_output_report replaces a
hand-built interrupt URB out, raw_event replaces the one in, and no
interface has to be claimed. It needs nothing in sound/usb.

But these are mixer controls for an audio device, and the audio
device's card belongs to snd-usb-audio. A HID driver cannot put an
element there. There is no interface for it, and inventing one means
exporting from sound/usb both a lookup from struct usb_device to the
card and an add-element call, and then answering, for a single device,
what happens when the two drivers probe in either order and when either
disconnects first, given that the element would live in one module and
its private data in another.

So 2/2 does what a HID driver can do alone: it registers a card of its
own. That works, and the cost is visible from userspace rather than
theoretical:

	$ cat /proc/asound/cards
	 0 [ToppingCtl     ]: Topping - Topping M62 control
	 ...
	 4 [M62            ]: USB-Audio - M62

	$ amixer -c M62 cset name='Mic-1 Analog Capture Volume' 33
	amixer: Cannot find the given element from control sysdefault:4

One device, two cards; the gains on a card with no PCM beside them; and
anything that looks for a device's mixer next to its streams --
alsamixer -c, UCM profiles, PipeWire's device model -- does not find
them there.

Against my own preference, two honest notes. The phantom input device
2/2 leaves at boot (hid-generic binds first, the specific driver being
a module outside the initramfs) is a packaging artefact, not a property
of that road. And 1/2's claim helper is new API surface in sound/usb,
small as it is.

Field results
=============

With 1/2: the interface belongs to snd-usb-audio while a neighbouring
device's HID interface still belongs to usbhid, so the ignore entry is
precise. Values arrive by themselves -- the headphone volume came up at
51 while the zero-initialised cache would have said 0. One front panel
press produces exactly one control event. A write reaches the hardware:
the device reports the written value back, and its meters answer.

With 2/2: the same, on its own card.

One device fact worth recording: a written gain takes effect at once,
but when the device commits it to non-volatile memory is the firmware's
business, and a value written and then torn off the bus can come back
as the older one. Nothing in either driver depends on that -- neither
treats itself as the source of truth, both ask the device -- but it is
easy to mistake for a driver bug while testing.

Where I come out
================

The knobs belong on the card the device already has, and 2/2 cannot put
them there without a new cross-subsystem interface built for one
device. 1/2's cost is one static-variable problem solved by one helper
in the file that owns it. So I would take 1/2, which is also your gut
feeling -- but the comparison is what you asked for, and either patch
stands alone if you read it the other way.

Not covered by either: the OTG input's gain. It has no front panel
control and therefore never announced itself in any capture, so its
property is unknown. It is one row when it is known.

Mikhail
