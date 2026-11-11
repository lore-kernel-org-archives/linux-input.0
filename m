Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794417186;
	b=eRlkpr5EwpIpbvI4b2JV1rWdBxtc27kby7lAOG/XyWLOSJsgKS/eIR2BDA3yiARv9S4X
	 wdAqta+1hN5CCegcJswVGqW9EGusddD682jT4iYyvXq9VsL1qmHN1B6+5tgFFglOZamvx
	 6+8fe0eG72MQusqAQsaXPZ4rV+7SxP7nthz21JZmzaaEj5YCRjKlfsy9U9VXdSqtqYrBn
	 7rEdhjRHeuAb1erAhs2mPPVNvJYTHGHd3i/+so0MNhg3m9CQMRN8fsfV+P9XjshZHUbtV
	 CNEbPnLc9yKswGLeOdccrih+hK0lzI9PGZSG5x5S+JnaVNgczIIPHJzQ4UIBvtqFilQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=yQBRHBIhMCpK1GaG4ls2kPSsfswknz2sHPrFZyTAPUc=;
	b=l3rnv2TsJJYC3E7OPrIbM0fe2EvVTtXUrUmRJjJau4OAs061dkkiQ09LMIhWUXiboh32
	 Rr2b/NdTtf458EOtCNQgXBvZ+hipJePwWCBy73iwXuErv/oxqdl5RptP+RbtJ95hnN5ns
	 r0LX3ZOZRNAtD2JQrSqPtQE8QtGgTjtof52n/NKVAVd3GUdVZfvfLFPb9erRulc8eyMaV
	 qgWuYDc+9g+5WT4ZyjadRzA5hAHS1DMMIbcj9RlYOSXwYYidQJUSqUlhZSK4iMaeMlcPr
	 mv/rZcbdtwYni5QHn7n0aXv8X6t+9uUaeEk59uZPpUZFEqlM0n04T9vEB9z/3qBFUWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=awi2vbah;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC92606A324
	for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 17:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EBC92606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=awi2vbah
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a8cc11ac42so3367250c88.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 09:13:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794417185; cv=none;
        d=google.com; s=arc-20260327;
        b=iZZeijr5S7D2Y1OsyEBwBjUjeuHzTnee4tsngcmH9OwuTK5hdAg8wHDCRyyX51cvuS
         Favqi3iD10rXYjNmPlAqUoiLqOxgp+/NiRbkcbdq8zFdd9ybuquZi0fh8G+Uq41jyg3/
         +fANgaG8H3pXYb+plXV2+1ab3fi805DEJq97EQePkoxr5OnNdwdCtjFw9HNl+4l40gkW
         EmAuWLFz8lTpV/FfHGkS/GcHY7xiBUvjk3B0jYl3rEz+sT7k49V9xNvstco0arrhebO1
         /twc9rdUF0Kn2nXH1Env2lhhYNgl7pU65r9hc6/ZY6oMLtw/dsxq4TBjVQcE3RwcjLV+
         tJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yQBRHBIhMCpK1GaG4ls2kPSsfswknz2sHPrFZyTAPUc=;
        fh=zgqO1pfhG1xLYrHnEhW9Tqjf9auNeFDgI2lD3lZAeeg=;
        b=R/Szq8xpzKebHxcedPWDi6P+Ctzb0ZsfDg41XvC/FLNcTwEuEAr4rOO5YZLiG8nz+v
         AP9dl2FmhuKkVxlR/088wxIIFTBy5FgIMSFzzPEQTIo0I7shDq/Su8bs0LPd6HlUzL7h
         4iguFtHuuOTHblCDcAuRYrdfgjUqp9qmTCXmLbuvVa4aLjYj5ubZUQsD4yJmMV0P9VzI
         mIqFAtGGorabolgUpjg0jnbESNfsrvUYHDmae22rIufXyBC8my/J47qY4t8r6kJCp01i
         ToyAt1VgfPSsGl+UPQg6nCk59asUun145Kh/z9NFomPi8YvOi1dkmVBfbHfpE6roSVrN
         0RWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794417185; x=1795021985; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yQBRHBIhMCpK1GaG4ls2kPSsfswknz2sHPrFZyTAPUc=;
        b=awi2vbah/fEYbEew3ocu4Kr0L919KYfWpbxLouCV/e615bMYCzISXGeOWYz7B6gePb
         yQrWkaqFkHFbbuHi627ZaEqgYAFDuBHkx6et7OAGvQgJle0ZWS9wBgndAowm1XcpEduh
         EwfqcAQGmKXb7jGpzl5h4bazn3z5sTLo8xBGct7Q2R0uHNZZgYJ0zJ0EA718ymD6aNpz
         JqD2cmqADltIvyO1vM76YMDJ+SLDV8clFlKYzWvTfm/QbwHABYl23F5bifqc5Yf3bzdO
         AYJ6Ykaa7hj3WHDIukHU3xxBiWHtVWOYCk8qzrGt+iLjDVj8wl5+ca6iFdF7jmTkcGUE
         dC3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794417185; x=1795021985;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yQBRHBIhMCpK1GaG4ls2kPSsfswknz2sHPrFZyTAPUc=;
        b=WFWE8u+4alYcWj3J0GlTO98IQWbztwPBJ19bN41N2Tsr1FPzutZRHT654S71x1msvK
         mUCveOS4PmDRO9WOBI2TpX+29y1QCvgfhMFKIaUK8S0HKsXs9SIYLL67U0iwDRj1178D
         oRYIhg/4HRrEHElN3tUXk0JN3eecTQgU2WQau2wTTWIoCPxhK+KSHo9/7rO5948tAWUV
         VUY97X45iSpmxGg2IkBk+v7j9OK64pfeMapkfeKNu2c790d9BO/aOI6qzQn2LjVdRJ4C
         dBAgfEi+v0tsNU+m29yLeBLIv8rsxx5Nbpcv57K6C+UxQaoUoCpVLlaKZpvBSzL7fo4C
         yLbw==
X-Forwarded-Encrypted: i=1; AL+hErHR2LogmByzQ0beplCNfCL6W2hK8I8Xtm9VYu5uQW8ZBzKrQi4sBBjojdYdgwvWcOVeEgGkWKjO55ldbw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8JdLIdfDRCooKZe6AZ/6HaME70icwHKrDfe3r5vNTx9Y8h/qvA
	pQ/ZvNRQP/zaYLzflW+k3tPov/SdkVY3r8LjHtp/MkiZnAye1g8irGL29I2EsALxfifizohipwN
	qf59cJcoXo649XHwFHtouggWdJFAkUOEakAgb4iJ9weNr
X-Gm-Gg: AYBFou1xOhYUy2i+MlW3KUulztyXN/MFgy1Lyh3Wymvo3E/63Ww4hgKLc8QnQ6PGIBT
	vrK+wcjD/qAPHGDN6ZUlnPKTQavMXdtaxBjyl7Wz6YOg/Pqts02vtnfx5MCaoSLuoSR8uabL4g8
	+OtZITaid3UoitYv80V7s3pS5sb5jIyTmBWfGR3svqn+S8yCXY/KjIXDUcpw0tnZm32wxLG4TC+
	DYxTB1zgvMqo/3BnHPROdPhVzqlmKwDjM+66qLwl7ueZERZp4IhvFzsJ6FIDxN0tfTWGjiA9fG9
	5VP5c3ZM2mYPCjHO/cKlLk+WM9WTIj7okDPADLVa1K+q4D5m3NEeVFpZ3UA6Tom+dVO1xLy4ol5
	z27Ld6v3JkaVRMW7EpWiLuCWV7BKNp2ecdobd
X-Received: by 2002:a05:7022:3a86:b0:1b3:a22e:b74d with SMTP id
 a92af1059eb24-1b3c035d23cmr2829705c88.34.1794417184690; Wed, 11 Nov 2026
 09:13:04 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-legion-lighting-rfc-v2-0-845726afb71c@gmail.com>
 <20261110-legion-lighting-rfc-v2-2-845726afb71c@gmail.com> <9002537db845b7a0a900612fe3a4a3638f06cd37.camel@rong.moe>
In-Reply-To: <9002537db845b7a0a900612fe3a4a3638f06cd37.camel@rong.moe>
From: Ciro Pedrini <ciro.pedrini@gmail.com>
Date: Wed, 11 Nov 2026 14:12:53 -0300
X-Gm-Features: AclHuK_9AFdIKIxS-VE0HiqvOtlNnIyPwpjp_Fu-O7VtOD5InbSvkib5r35zrYc
Message-ID: <CAPKD0HfHuv4vKWeff_uhGxXosuU279qB+kkmXNPXJYL2kxFR2w@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: lenovo-legion: Add keyboard backlight driver
 for Legion Gen 10
To: Rong Zhang <i@rong.moe>
Cc: Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Ike Panhc <ikepanhc@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Werner Sembach <wse@tuxedocomputers.com>, Aaron Erhardt <aer@tuxedocomputers.com>, 
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Rong,

Thanks for the review. I'll fix the rest in v3, but before I go on with
it I would like to hear from you on these.

On Wed, 2026-11-11 at 20:09 +0800, Rong Zhang wrote:
> On Tue, 2026-11-10 at 20:29 +0000, Ciro Pedrini via B4 Relay wrote:
> > Its hardware brightness, 0..9, is stored in the controller and applies to
> > every LED of the machine (keys, front strip, rear vents, lid logo).
>
> I don't know if it's appropriate to represent so many things with the
> name "legion::kbd_backlight".

I gave splitting it some thought, and looked (with the help of an LLM)
at how other drivers handle this. We could register one LED per zone,
but that seems to be usually rejected, because they would not be
independent: the controller has a single brightness for all zones, so
writing any of them would change all of them.

Per-zone control is only possible through the LampArray (c193). It has
319 lamps, each with its own colour, and they are grouped by zone (keys,
front strip, rear vents, lid logo), so a LampArray driver could light
or dim each zone on its own. That needs c197 to hand the LEDs over
first, as discussed in the other thread.

Also, going with kbd_backlight seems like a good idea so that UPower
and the desktops pick it up automatically.

Thoughts? I'd like a confirmation from someone who knows how this is
usually handled in Linux, as I don't have much experience with it.

> Just curious, can the software select which effect to use, or listen to
> an event when Fn+Space is pressed?

Yes. 0xCA reads the current effect and 0xC8 sets it. On Fn+Space the
controller sends report 5 as 05 01 P (P = the new effect), then
05 02 B (B = the brightness).

> I wonder, what if we set the report with a short report size, say,
> struct_size(msg, params, len)? Could the device handle it properly in
> this case? If so, there is a chance that we don't need to sleep for 100ms
> later (I guess the device is processing too much data, causing the
> massive delay).

You were right. I tried it on the laptop: it takes the short request,
and it only ever answers 5 bytes anyway, even when asked for 960. The
answer is there right away, I read it with delays from 100 ms down to 0
and it was always correct. So a brightness read goes from ~115 ms to
~2 ms.

Setting the brightness with a short request works too, and reading it
right after returns the new value.

In v3 I'll send and read short reports and drop the msleep().

> Ditto, what if we get the report with struct_size(msg, params, 1)?

Same, that works.

Thanks,
Ciro
