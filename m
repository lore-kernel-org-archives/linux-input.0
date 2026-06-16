Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8182744CF39;
	Tue, 16 Jun 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624408; cv=pass; b=tsW3YBz870gx4jv2TOYb9CLc3qyM/v/c/LVhpJ5X+8zIbobjL2FyZLtEY3WqEVsN1tKiK2mVhG7ZtXzjF5OdoE+yYTCgfzvYkd9BmvdmpKjRfJkKGKwY2D265j4VPm5DIpZLrvZDhjWf2uxbhEsFLcqHIMfQviq+QVs0AfXdWyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624408; c=relaxed/simple;
	bh=Tgum7D2SgTK/dyNjo5fby3W8vJDheKAs5yIdrUgz+vk=;
	h=Message-ID:Subject:From:To:Cc:Content-Type:Date:MIME-Version; b=JQcCHRpWTwE1Y5dcyrfFmbJRvKXh+HUFzRmxDyCIlYSSZPsEUPQLP3XdM+bH1brhcvQ3kISGFSdR39EefeYqmOdoc9Mw86DxBnXF5LEGbFH3bOrYH/P3g++mt2sRJS38UvNZcChV48l5IiORE88dXShs26iTGOxViKhN/SIbmqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=cKsMZEfr; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="cKsMZEfr"
ARC-Seal: i=1; a=rsa-sha256; t=1781624395; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=i6qFH0Ug5MpDrekIhEvOteCgNGSQy4opFCXnPIFp7qr9BuLRNCgJ1y8pPNA2I9EzlnwL/AygMzObUq7Os2dS2xLTRL4UoIK8jU9nrMJib7ZniCncnUSTWEhKI34Aymgdy2omxfVYVPuWZmWd1BmoLzWE7DcXNMo/TqW+VpTyq9I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1781624395; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=viKGWUemT40CkSpjI5s9hiYMe6Y++YEeBaR8EuNThAw=; 
	b=e17Od47pjZkmxE0HpV6hJewy2tnbMye/u3VQK34a10MQ3nM61egGhoTxB8uSRW0IjzGNmgnhEYDEMrHVQ028V0Gwk6ZRwoarM+rO72/sIUGb91+xw3RTSVeGzlSe1qwHlMmfvk/tp0izRryFH6RPkU2M2yNAL8N6W0kf/jMQSLA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781624395;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=viKGWUemT40CkSpjI5s9hiYMe6Y++YEeBaR8EuNThAw=;
	b=cKsMZEfrSselSNfFKh3/W3NWQf1B1YH/gout0hgAUd49mpJnfLQZASbCahYXd//2
	7PHEW//SLqF74RvGe9wgd7GDRywIUwi3MVoSBmK9rVtzQnNrK5roZ9CtwBOJL3IoLKV
	pd1iH1f24ZoqQhOGYXGYUonmF9bSg10dPeWnR/LEAkQJW7b1mSHA99MBvLw+zKNcfM+
	CEr/Qlv9WjB5QAfYcBZTeCcyV0QzQ00Oxhcr4tuJLON6IQp75wiAG5wEBbUmEECTqBG
	d4jgVot+52ONoiZ6n0iYOE75TBFZLemDe3RStdeq54FIVCOt1CbV1PVQxcGGD+OeEs4
	IPZEwPRZWQ==
Received: by mx.zohomail.com with SMTPS id 178162439408996.89684704661761;
	Tue, 16 Jun 2026 08:39:54 -0700 (PDT)
Message-ID: <bbee6e61a243a0ae4db6ea155909607326a80dac.camel@rong.moe>
Subject: [RFC] Adding device-initiated haptic feedback knobs for
 pressurepads
From: Rong Zhang <i@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <bentiss@kernel.org>,  Peter Hutterer <peter.hutterer@who-t.net>, Dmitry
 Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, LKML
	 <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 23:34:45 +0800
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-9 
X-ZohoMailClient: External

Hi all,

A pressurepad is a MT touchpad that simulates haptic feedback. The
haptic feedback may be either device-initiated or host-initiated. While
drivers/hid/hid-haptic.c [1] provides comprehensive support for host-
initiated ones, device-initiated ones are currently not configurable at
all.

According to Microsoft's Input Device Haptics Implementation Guide [2],
pressurepads with device-initiated haptic feedback can support
SET_FEATURE reports to allow users to customize the intensity of the
haptic feedback (usage page 0x0e Haptics, usage 0x23 Intensity) and/or
the force required to trigger a button press (usage page 0x0d
Digitizers, usage 0xb0 Button Press Threshold). Each knob should occupy
a dedicated report ID.

The first knob maps to "ClickForceSensitivity" in Windows registry and
"Touchpad feedback" =3D> "Intensity" in Windows Settings [3]. The second
knob maps to "ClickForceSensitivity" in Windows registry.=20

The pressurepad on my laptop supports the first knob:

   # 0x05, 0x0e,                    //  Usage Page (Haptic)                =
595
   # 0x09, 0x01,                    //  Usage (Simple Haptic Controller)   =
597
   # 0xa1, 0x02,                    //  Collection (Logical)               =
599
   # 0x09, 0x23,                    //   Usage (Intensity)                 =
601
   # 0x85, 0x09,                    //   Report ID (9)                     =
603
   # 0x15, 0x00,                    //   Logical Minimum (0)               =
605
   # 0x25, 0x64,                    //   Logical Maximum (100)             =
607
   # 0x75, 0x08,                    //   Report Size (8)                   =
609
   # 0x95, 0x01,                    //   Report Count (1)                  =
611
   # 0xb1, 0x02,                    //   Feature (Data,Var,Abs)            =
613
   # 0xc0,                          //  End Collection                     =
615

I hardly use Windows but the last time I booted it I did see "Touchpad
feedback" =3D> "Intensity" in Windows Settings.

On Linux, I can tune the knob by setting the corresponding feature
report via HIDRAW. The pressurepad remembers=C2=A0the knob value until it
loses power. However, getting the feature report returns garbage data
(probably from the last input report in the buffer), which makes some
sense as the implementation guide only requires SET_FEATURE support.

I'd like to add device-initiated haptic feedback configurations for
Linux. For now, I only focus on the first knob, i.e., Haptics Intensity,
since it's supported on my device. If I somehow get a device with the
second knob I may work on it too.

Therefore, I am here to ask about the preferred way to expose the knob
to userspace.

The first thing I thought of was sysfs. It's easy to implement, but may
be too obscure for userspace considering the layered structure (evdev,
input, hid, ...) of the input stack.

The second thing I thought of was EV_FF FF_GAIN, but I am not sure if it
matches the semantics of EV_FF. IIUC, since there's no way to initiate a
force feedback from the host, the device is not a true FF device and may
cause confusion.

The third thing I though of was a new EV_MSC event. I've seen some
drivers using EV_MSC events to tune the device as per userspace events.

Or... Perhaps there are some other reasonable ways? Looking forward to
your feedback! :-)

[1]: https://lore.kernel.org/all/20250818-support-forcepads-v3-0-e4f9ab0add=
84@google.com/
[2]: https://learn.microsoft.com/en-us/windows-hardware/design/component-gu=
idelines/input-haptics-implementation-guide
[3]: https://learn.microsoft.com/en-us/windows-hardware/design/component-gu=
idelines/touchpad-tuning-guidelines
  =20
Thanks,
Rong
