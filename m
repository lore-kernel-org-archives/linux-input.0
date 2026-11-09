Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794260630;
	b=cV8qeYJlXR18g5Wad5/J2lYPRX74l3cDHegPKSF8/a0O79MNeCA349Yilv9CyHtSlqeq
	 5Ink+nx4FQT8P40AEA852aNOQMPZK2CNSx/ozD+ThdGY2Ni8EtcGga3vc7PAgjk31Yejj
	 TE8zAamahFuu3UDHtP7XPLmvhWslwibJlv9YyDWHTfJmIROxMeShZ2ZtPcLaCXrrKcmAQ
	 NaLAW9p120stQciS/+66Rb4bihf3ofuFpAnc86Dr/aCuP/YEV4L5Z1caHzhsmYaxDkViO
	 /4Oyo0E7aNw4BqarhI5++S8+RexCLErC5lUV8+I5q7VZr2j7vKOGbqrCcl8rqUbkvmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=G2vwAcJqTKKEqvGFYxAWQxtL9vT8JY6vkPmKAMLbJO4=;
	b=A9tmR6JovRdbz+taQLEyHmwlzUsB9R7R8hDDWfghDRZAbl7haHKe6GHCu1wf/IIQS99u
	 gulfxpoxAWv32qEakbOBkrpLK7WMBIDi8AiVdeQV4SMSQJuIBax/hx7BXG4ILeH94ixqN
	 2nF1cr49vNAij/vgXa8sdL3jIH7GIzTP5r2rrXhtZqCiDIcVGD7VBeZG7XSBcjmkf2HPV
	 Y5737lnpHBXWaCEu5mMaN0iW1iCeH6dUNlU9CQrKXh37A8J93gLvWQp8+x0Sl2EmINSSC
	 sSTQ2aRKi9QJ8QX2Ae6vx5y9tqSSc3XN6jDJJprm1CWr5I+LZM7WagTu16df+fjPWxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJcQpiJO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720BD606A31C
	for <linux-input@vger.kernel.org>; Mon,  9 Nov 2026 21:43:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 720BD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WJcQpiJO
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b31261e8a9so10292497b3.0
        for <linux-input@vger.kernel.org>; Mon, 09 Nov 2026 13:43:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794260629; cv=none;
        d=google.com; s=arc-20260327;
        b=eljXaXuOnGxwqOLMowI5l1IZMM24JGpnmmJiaVszMyMmazPBY0EA83k7OgMwHIstX0
         hgdzTO4d/vbCDs9hu75NVRNQc9C/5DwDdjtf/f3CBT56IsS4X0tBvZWAe87mCBM+DZQ0
         wfiT8yYgBDWHGs7txzGyeBkxrq6NCVLs2Ofq+f5fGqBPsHV4BrDbA7Mue25bEKQuni05
         LygIeoQD5JEOEfF8CZR05Ng8U8coOws2SdWH7MVzjT+a8G5MTs1LUo219DTZGO9tjoxs
         QAqvPmtwJ7K1PH18hyntPAOHyB0vgqVxg3PuhViyxUO8GVyJop2+dscp436xrKlpZix8
         2dIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=G2vwAcJqTKKEqvGFYxAWQxtL9vT8JY6vkPmKAMLbJO4=;
        fh=Tw7104F0XqA4Uymg4C6mfrNwLpSxgdjfcG8ZGgfKRaU=;
        b=ZjhWwXmNc411bUtDBuLop1rQfS8RuJVUo0JFR3sbT6rrMFf6YDv1jbURcdocVvCsp3
         8Zjw8eOMKud5c5hXu2USrIBp8avv/9/3nVG2NKkZoUGzt40xVDwq85tj1Mkx/JBNc1vu
         D/pKmf0i01iHbdEy0+6yNreFZ2+iUv+Ov7lr999evCIQBfVpjDOh9GKOPuVs6klirRFs
         h2ZCl+eMiRghVtyqKk0cLl3JKc/3Qe6fxrzYUT2wumiNqhx9yb2L/X/kjfeYP/U+USMI
         M9ItTnhTQQwnbQQfRS/p0QEsYj9Z6NhW/5M/CrF5zZnSvlAjB09Q4JQnVY9LTeIoFGTw
         z4wA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794260629; x=1794865429; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G2vwAcJqTKKEqvGFYxAWQxtL9vT8JY6vkPmKAMLbJO4=;
        b=WJcQpiJO7KzYY/ht6wdkhsftwn5dnvgdrYd0UrlybNCFKmFBiGwV83HSSer32xanMA
         7Tt/IYjirbJZpe44bSPbKQEym90QjnW4VEVTZY89KABgS+HWaB5rW2vyxFSsYKtRa0R8
         6X5cSCEQcrydY6c4uOlb7MUJnekMbeV8Rukj3XJ0JCeSoavCCcYJXbtU04Zx6Aw9O2ch
         jfiaOtbHbp0A2y5RV1tf4ZZZ7KaYNomMYTtotVRYqKo2/kLjESLMfJyP5WHIkoB8pYuC
         fiR4FJWCbvOQ1l2yWrFUyPvO8XIiLXi+24zy3UWZ28AkTd5vB4V/VBFpzWERfGW+HlEr
         QpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260629; x=1794865429;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=G2vwAcJqTKKEqvGFYxAWQxtL9vT8JY6vkPmKAMLbJO4=;
        b=C3GdG/4pKUwrNkIq2O1ro9QEGv3fZNhzoRBd38PtBf5aODL00XL/rpzvwEoNIhmJ/a
         sYSqa6F59QnpaapYtlV4f2r5iG5nZUrkM0VcVXG+y72FtNrlOTVe8z0kd4EDtcoCInp+
         lPsWAkBajQ2jzwsTxSnvluxTcwPVzbXRWEOGX3+SwHzMHJ+fSPSz8fSsWGCcI67j+mtC
         3d5VB7/Cze2uYBMFw16PnxChO/9QITdcsG9vQIrKtyVvE2mYI3fuIesS3pb2eX/X0Y5f
         LyIXw7VTMRNexYBjM2Kup+Gj29NN1QokBaawjUP9tMgA3EHrc/5yULENDg1Dceo+gpjp
         /1FA==
X-Forwarded-Encrypted: i=1; AL+hErFFDeL93nYCC9jDASEoQoCG09xV+scY73g4PC944xE6CIjetuCZcQ6vMQcMYQ0InmmQrhFLwVv6PaJE3w==@vger.kernel.org
X-Gm-Message-State: APuU4Z+0u6NDrRYc5hHfEOer4SbdPEsCd+lu1idG14Y3oISWnHIyHGc5
	oPCuF0h3yYa3iuyKL5M/sp7ipz0CTxsfiVeOWDDrU6fpKEi3HmBqHhZgLHZ22zrsJtnw3EYnewY
	fqeEOjs79uNlplJ0UFo+FIPZrSVMrI1Q=
X-Gm-Gg: AYBFou2VNYL6H4w6xJ2DgBhpV+5Rv07ifx4Mb56MRqarCf3SI1aT503wwbJauPsi404
	IKDRBc4LCJ9AgPj5xMCA3rDRtTblbZv55GmcBU6EgFua2jrYjmrfnatLZpVh+/duUPdQGWJlK7B
	Ccxj9MmQgxYWiksoollZoK0H9D6qkrvwjz3Wl9fDmpmwomN1KMRfwUCXLAbC2PEyVRjLUAkE7rp
	AYcm3LlSnIc4eqT0YfbGbK/T3im113Ahcv6THjQlUpD0Hdo3tKQc3+/bzIR8ierxuODK6giSMIu
	gQeYh/UGuZfejuWW3Zx4ifuTFGKEoqmnGHojU2yqe7ChY+yjHz58e+RV5CJR9PBZyWCwhXff4EU
	rUnC0f0h2lOKgsxklQ51xSgnRem8E5ZVR8ZeoT14oTHviTItWuhOIyB40z35SK0wMOT7bgQ==
X-Received: by 2002:a05:690e:4388:b0:679:ab13:5528 with SMTP id
 956f58d0204a3-67c567510e7mr448932d50.22.1794260629432; Mon, 09 Nov 2026
 13:43:49 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
From: Gideon Heinz <gideonheinz02@gmail.com>
Date: Mon, 9 Nov 2026 22:43:38 +0100
X-Gm-Features: AclHuK-EpGApq8Fk1oG1-gcE3eKmJaG4COIpgR8xEwO4spWMBWuAFHHjNAuhoJw
Message-ID: <CAPb1+K1w=FDwXoGsvXQn4StJNFYHQK8gq+HUsv=Uu7VWwwPqiw@mail.gmail.com>
Subject: Re: [PATCH 00/18] HID: logitech-hidpp: G920 force-feedback fixes,
 rework, and cleanups
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	=?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
	Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, Edwin Velds <e.velds@gmail.com>, 
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dmitry,

I tested the full 18-patch series on my G920 (046d:c262) as you asked.
Everything on your list works for me, details below.

Setup: Linux 7.3.1-1-cachyos (clang build). The series applies cleanly
to v7.3's hid-logitech-hidpp.c (the pre-image blob of patch 1 matches),
so I built only that file as an out-of-tree module with all 18 patches
applied, against the 7.3.1 headers, and loaded it with insmod. No full
kernel build.

Results:

 - Initialization: "Force feedback support loaded (firmware release
   4)" on every plug-in (7 in total), followed by the input node and
   "HID++ 4.2 device connected". No -110.

 - fftest: all effect types are listed, uploads are OK, and the
   constant effect plays and produces force. After exiting with -1 the
   log stays clean for 2+ minutes. With only your earlier two-line init
   fix, the same exit produced "Failed to send command to device!"
   about 15 s later, so the drain-before-close change fixes that for me.

 - range sysfs: with evtest holding the device open, writing 540 and
   then 900 reads back 540 and 900 and returns instantly. With nothing
   holding the device open, writes stall as you described: I got two
   "Failed to send command to device!" lines 15.36 s apart (22:06:16
   and 22:06:32). I believe they come from two range writes I did with
   the device closed, but I ran those before starting that log, so I
   can't tie them to a timestamp.

 - Input: evtest shows the wheel axis, hat, buttons and the full FF
   capability list, and everything responds. I use other pedals, so the
   G920 pedals are untested.

 - Replug x4: "Unloading HID++ force feedback" then a normal reload
   each time, nothing else in dmesg.

 - Unplug while evtest had the device open: "Unloading HID++ force
   feedback" about 17 ms after "USB disconnect", nothing else in dmesg.

 - Unplug while fftest had the device open (6 effects loaded): 12
   "Failed to send command to device!" lines within 25 us of each
   other, about 0.3 ms after "USB disconnect", i.e. they fail
   immediately without the 3 x 5 s retries. "Unloading HID++ force
   feedback" follows 17 ms later. No warnings, oops, call traces or
   hangs in the full kernel log. After I plugged the wheel back in, FF
   loaded normally.

Not tested: in-game FFB with the series, driver unbind or module
unload with effects loaded (the case you said is still open), and the
G920 pedals.

Happy to test follow-ups, and I can send the full logs if useful.

Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
