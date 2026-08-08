Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DAC255F28
	for <linux-input@vger.kernel.org>; Sat,  8 Aug 2026 22:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786228254; cv=pass; b=BY3kr1P+4yI8DM/rROmmBvObPISPSBC2yIBGct+3a55Fql/N+BIK3xlkBmL7LVUauQOOWr4J6GhQGwB+CDH7ewqCYi2IyTWtziLOZS1ROsuxXlIdR1DYBUZCEaKZzFtlp8cI3GX0Y+A4+t5AH4717A26LoXtWyXaQvWFvzQ9T5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786228254; c=relaxed/simple;
	bh=u/aR+YgPWxL3SaP0F+G6mRY9b3B2c1OpPs6Kao85gCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KtgBsqkPtES97+UYma8pZbBI/t0SVa0jSTJIcPO+JSq5NK8zww8WYUGt6OZdzEF5L+TSY48lbLCj9Tjj4t57HIA01WdzQFLAd2PoTp/kJKZ9Hx7i3or2LuktMZymD/hifItU+a3fWFz6IjJl+vOoCcvWuEymFgXvyA8hLyHGp9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHH3TmgS; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHH3TmgS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc61541f8cso35160685ad.0
        for <linux-input@vger.kernel.org>; Sat, 08 Aug 2026 15:30:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786228253; cv=none;
        d=google.com; s=arc-20260327;
        b=UBvfYjvP5kAHcrBDqcKid6x4vMLxNlpwc4mvMgy34MpOUzCajVdG7BTqroVhvp+58L
         5MfXpFc04rxTIpMZnMTHY+VwztDbWaV1mYG4HTWifFiqwrJcAkGEc7AbCrqpKO0dvX3O
         t9BUsQOXJjBCVZFSpXKfgsqyumdPd9OaguUKfuRL9sFWYOmSMgVofDbOEgDH4CjH03s1
         Oed90GJyOBPO/6MRXmd3EsBXQo8D2fJKldadUi2laSXz8X4RQtHSI15Byw28bANO9LE/
         IYNIvgy0COuz7pdPKj+GPRVk3wZACI5C+ZZ/x/NoQu0up+O2B/RtDS54bumSFL9WvXLr
         Xhqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aBDL96EwzGigIPn5AWnNwvGjhTglYCk7YLygBX7ROMU=;
        fh=sgsK+TCG4yktQoOIRpRNpw3hUg9ZDDZ9uSVNXPGGC10=;
        b=FQJS+jGq4rhLKH8lAhDurhwVy7XEHa5kzTHR9ZO0EC6/NFdFOTHWy/H1QC7JsJPLpG
         tHPZ+k+0g0bd1WC3c78NIb1Osq+m58wzFQ7ozSYZasrRZ7oTX5Q/yf8cVuaUxXb8HJUd
         Ki59fwEr2r4iLh/1fy/wrqgGhltp54hpx9wGbHtIxRFix9MSiPK/IGJS11CJZQzqgQmg
         Q3+/EWKGsqUgtWk8fyMekzTSr/RAvVHa3lr+PW89GjnCWG7iG6xe6dz4nqCfUmnP/tBe
         EPBGyFzEzNLvnrSjmFxTAUOg5K/tNho+dGzHnDwg7y0FdIkCU+NvR/mdUJgzjofEdXjv
         4z4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786228253; x=1786833053; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBDL96EwzGigIPn5AWnNwvGjhTglYCk7YLygBX7ROMU=;
        b=QHH3TmgSaU3iyDjVmXSNyGyp6V40a8IpmbpPaw7GGJxtopHYIY/kBiko7/1FwGG8W0
         e85Er/SNMufvbN+iQL6rolUXqAkpW4pZI4YxQtfkd44duQr6vi1qtZXSE4SA8d+x3Icc
         TjAW5I87oc1hcd0GEfaftGces+l+aRNzjQe3+Jf5EiqAhxmQbyWyHCrnKze3YvMq1Vfb
         N8cW17j/KxKn5FnUku4lT2RDgcVw+3/Ffxl9A1X4FB4maSscsAk9iVAHm5doVcYWoryA
         jvey13lYh6Bb1eAzem16psodAN/RLdp0+mlZijFmMFUxDJGoQz0jhglMDXsr7ITTnPUD
         5SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786228253; x=1786833053;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aBDL96EwzGigIPn5AWnNwvGjhTglYCk7YLygBX7ROMU=;
        b=B9XeffDavQXn9Y0pC1XIxOcRUWSmTl2+BqnNyQMAMxG0+B2qbQhlnrgL+GSRVY93mN
         lanXWNpjdpWPiQhmqQpaqGMm/HTzxIvdPGjRX+OCqXmNOl9ZsZn+0wuyn8q1WGuRNK95
         P5xDiREgX6YIxnQwyANZmfE9lhbN2djz3ApEV0xJ/u47zhBuJWUUfMBwoHDnxxtKG28V
         nJsVzh5f27DDgOaC/UxIsJyFemvq2I/r1SFtcFzNQI9xPL13JeV3EVlxk9hfJ2rRMBhr
         RtMsPEEdTYzEn0mXK7iQEiPyyLw6YkBbZegLKJHGL185Ei3XafxFjgfUAYUHfxuDYnao
         kdzg==
X-Forwarded-Encrypted: i=1; AHgh+Rp2wJWsQ6uUF+JzXWmmQvYCkn3At1SE0GhvYvub/YHQvvtV00i7fvsDJvmsP6rpCtzLGq0/6omcBU1xsQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOwNvA826mmULSoicUN+wUu6P8dUyTiQINf9gj2HZdf3B1F52M
	xpds2VdH5jJRuMGfxmcVdE5Yv7OYxwxu4fMOBDbn6Wwdku7NxruBhzDmxDyXUrAzE5KY60eaVt2
	q/DyqERikVYo9JX5UttWp8B2HvhZXIpk=
X-Gm-Gg: AR+sD13GQZFA7fRVj18xCDYy7Dg9Y24p4lfIUbsn27s/v7Xi6nW77Jx10vJJh3j8xv1
	ggKv9xtIhELPdVLKm8wx2FMESL0XcOOxhNUNWO527yX869weIaFsKlWIjfRWY7p3j0mq11knMQb
	uAdGlgE5zq7pScBd55bfH+HYgVMDiiPhLZmmTxn0s8k5iIr/3sVD1WukZ9C+StXuuUrFLygtMmf
	+o0QS4IgZq7YQc5y4MbaCTZ2ftGpL2Zx1Yt41MQUUhA9xBpHaYuNfvibDKlq8TzxIrNVf/BR3is
	RLd+9P+nlAaYiPXb6HmJARolEQ+O91zBzIjaX2ECSL7KjcZ29Goh/VHgEhMIRHy6BGQN2XJ0jNs
	SVsKrjg/hzjGzFhm3hVVgGvn3f/44klOqe2Y8RpaaJgUZ8hKCkb6+3aeh4Rs=
X-Received: by 2002:a17:902:ccc9:b0:2cc:db7a:251 with SMTP id
 d9443c01a7336-2d2b2d8ec9emr100184405ad.2.1786228252650; Sat, 08 Aug 2026
 15:30:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABWMpWQiSEKMkROgKZJ6nV8GXYgr7E=-SmsatQie4eK8b3F9Xw@mail.gmail.com>
 <CABWMpWR7Law_vHdeAMsOcY28VBcvX2jYSqq2SpksJSiLFcXhuw@mail.gmail.com>
 <anIhyHL4Kl-DX2G_@eggarch> <CABWMpWQEfycicrctrW3RD1yNf0rv1ZrioY9FcjoZZGEz4GAm_Q@mail.gmail.com>
 <CABWMpWTn3H7UKqYzr7JP9tkQCEJHsXX-F103nyyey_srn7mvHA@mail.gmail.com>
 <CABWMpWSkJgmoZACA4LYEbmsbEGJMYLyixwv2V3tZbneeKBxpWg@mail.gmail.com> <be3775ba-3e7f-4548-aa1b-4710711f8aed@rowland.harvard.edu>
In-Reply-To: <be3775ba-3e7f-4548-aa1b-4710711f8aed@rowland.harvard.edu>
From: Jamie Stephens <jamie.stephens@gmail.com>
Date: Sat, 8 Aug 2026 18:30:40 -0400
X-Gm-Features: AUfX_mxXklcd22HO6HDonbWutYlV7pvODMMT9yPLiMD5KmmDZ5Por3aKpq8ARgE
Message-ID: <CABWMpWSSYWusBTvxC8ciHR4FAY4zo=sON5fBWr-B=uefyqAw2A@mail.gmail.com>
Subject: Re: [REGRESSION] CyberPower LE1000DG (0764:0501) USB HID regression
 on x86
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Lovekesh Solanki <lovekeshsolanki00@gmail.com>, jikos@kernel.org, bentiss@kernel.org, 
	regressions@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Subject: Re: CyberPower LE1000DG (0764:0501) - Further testing results

Thanks again for all of the help and for the patches you provided.

Unfortunately, I did not get a usbmon/Wireshark capture from the
LE1000DG before returning it. I wanted to send an update before going
any farther with the kernel git bisect, because some additional
testing changed my thinking about where the problem may be.

As discussed previously, I tested the LE1000DG across a number of
kernels, including:

- 6.0.x
- 6.18.40
- several 7.0 kernels
- 7.1.5
- 7.2 development builds

I also built and tested the patched kernels you provided, including
the USB/LPM and reset/resume changes.

None of those changes made the LE1000DG reliable enough for normal
use, so my next planned step had been to begin a Linux git bisect.

Before doing that, I installed a separate PCIe USB controller using an
ASMedia ASM1042 chipset so I could eliminate the Intel xHCI controller
as a variable.

The LE1000DG behaved poorly there as well.

It enumerated normally on the ASMedia controller:

    Bus 003 Device 003: ID 0764:0501 Cyber Power System, Inc. CP1500 AVR UPS

and the kernel identified it correctly as:

    Product: LE1000DG
    Manufacturer: CPS
    SerialNumber: QBKRP7001634

However, usbhid-ups was unable to reliably retrieve the HID report descriptor:

    Unable to get HID descriptor (Pipe error)
    Unable to get Report descriptor: Resource temporarily unavailable
    No matching HID UPS found

lsusb could still read the normal USB device and configuration
descriptors, but the HID report descriptor remained unavailable.

The more interesting test came afterward.

I temporarily connected an older CyberPower AVR1500/CP1500C UPS that I
already own to the same Proxmox host.

It uses the same VID:PID:

    0764:0501

but is an older USB 1.1 / low-speed device:

    Product: CP 1500C
    bcdUSB: 1.10
    Negotiated speed: Low Speed (1 Mbps)
    HID report descriptor length: 387 bytes

 this older CyberPower UPS worked normally with the same NUT 2.8.1
usbhid-ups driver.

It has been polling continuously with successful quick and full update
cycles. For example:

    RemainingCapacity = 100
    RunTimeToEmpty = 5407
    Input.Voltage = 121
    Output.Voltage = 121

The driver continues to receive HID input reports and complete full
updates without losing communication.

This seems significant because the working test uses:

- The same Proxmox host
- The same current kernel
- The same NUT 2.8.1 installation
- The same usbhid-ups driver
- The same CyberPower VID:PID 0764:0501
- The same Intel xHCI controller

and the older CP1500C works while the newer LE1000DG did not.

I also tested the LE1000DG on the separate ASMedia USB controller and
saw essentially the same communication problems there.

The LE1000DG reported:

    USB 2.00
    Full Speed (12 Mbps)
    HID 1.11
    504-byte report descriptor

while the older working CP1500C reports:

    USB 1.10
    Low Speed (1 Mbps)
    HID 1.10
    387-byte report descriptor

With the older CyberPower UPS remaining stable on the same host,
kernel, NUT installation, and Intel USB controller, I became much less
convinced that the primary issue was a Linux kernel regression or the
Intel xHCI controller.

At this point I suspect the problem may be related more specifically
to the USB/HID implementation in the newer LE1000DG, or an interaction
between that implementation and usbhid-ups/libusb.

Because I was still within the return window, I decided to return the
LE1000DG rather than continue troubleshooting a unit I could no longer
return later.

Given these results, I am also wondering whether there is still much
value in proceeding with the kernel git bisect. The fact that the
older CyberPower unit works reliably on the exact same system seems
like fairly strong evidence against a general kernel USB regression.

I do appreciate all of the time, patches, and troubleshooting help
everyone provided. This turned into a much deeper investigation than I
originally expected, but I learned quite a bit from it.

Thanks again for all of the help.

Jamie
