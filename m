Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794468485;
	b=gZ2sFmvbVjkgsgusyqBL1/ITiEaKB/rGu0fv+ePMnMLt+ajpjRvcutSZJo8wlCU3iRvI
	 y0LeIamtsLTjA1KIWjEuVh/Wy6R5L3Qb8TMtN378okOHSKHMZkG2y0tqi7oBngBw2SDNv
	 Sv7jBdaEhO07DUiTAbiwecUZg3iST6rPp+ETpH7kZOvSdkMf+PSubT12CHdWPdYyUPGGS
	 DGyhFxBIOcAtkrl1jcohScLda6r4NrH0W4D03yaYHgZbt1FScul+L1cxFshTrfJInTFCa
	 aOw0h0kfexM62klTZZ0exispHi32D+sJmh6+HJgIf/8mnOyQMMZpZMQCAaSub9h7vdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468485;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=RSqIoItjXabFeCd3yG0ONrGqXrTW//2M4yj0JC2D6LU=;
	b=ON5oWDjXl2YOKeNMfi5rXEPh4hR2EAE2afarxVgdYvyV3lyQT3XkUcxUSeTKbpOiLQC9
	 Rdc0jBDjHPagtwtFS1Cj4F4eS3GfCkl29zeeufnwfzkrCcqPK/knKxYyGyrs91KLQDEXk
	 yCTyD0e3M2wbfQQdMgLSSueZvy3Vt6PoJ8Kn7BxHGro7I/7LHCDqLmnmzw/NLDk4pWQz0
	 3l6GFAYvkqdhcQLhefzJPDCbZVdEgxXIusmJkMKGQm/w6GEXPHIkMdH8eo6agZvatLErq
	 ZD06YCPQOETZnSS6KY+skBk1+ifNoYMN/Irq9vShTTu9+o2U6207NfshYLXTWWWMxHQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e5Z7h234;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E839F606A327
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 07:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E839F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=e5Z7h234
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5bccb867d6fso640275e87.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 23:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794468483; cv=none;
        d=google.com; s=arc-20260327;
        b=Byh891Ax3GhQBtFHMV2S+08H8bRsxgWBj038EySvJlKeyMwP6UZgx+hnGEXEiwWBQm
         dPXCYsJDSoqFur+Ya8XTbEfInEXQdRC3LjMe/YeLCHt9kt4pVdvIc52eyB7rhqyOK8PW
         eUt1GP+Tk1XDoxh578aOjeDcUcOCSTM1+90FlZEJH4dNIZZeyQK15cXI7DiRsqjanJyT
         HEKqjE9xHG2gthbjKZ7PfnXsqMfan0yh37wUQlacMdmARso6xZT+7xyrieEVBlEOimRX
         E8GbtJWpS9j8uSA6tczhNhsuDrAkwdijz4Hp47ey31f/kvc1rsIA6VmTT9M0EhWCaajb
         SsMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=RSqIoItjXabFeCd3yG0ONrGqXrTW//2M4yj0JC2D6LU=;
        fh=H3E5uI53fs7Kdw2Alppr1LrrXQPXmYwyDwBGdZ0frQQ=;
        b=B2iXi4W87Eoe5ksHBT5F5++KDnipFykDCQdWkzJmTOEwkjHb1t5iPtSuuUemGLrm8H
         DScX7wYD5z6xHpGThYguo144xJJtxIfPTFuhZE+Fr6RZ3ils1f0Shko4F5NnS4ejyXpP
         KcC9xMHgsNLH4Utr3p/YB3efu8mtoBlgMabtbfu67KvZBMD8HzbzRd5renEbyKgnDyPw
         s39fMKA0OB8VA0ytbKGvhcpISdvvK6XJ3fh6WKTYDUJVRtQqC942epOhQgJRHVzOvP8N
         K62rcZF2cfW9xK19w2iVb401ixZkj1R+dmjHSdr2otFXMFTAQotmwXhxb8FPjQbzRX2c
         yp9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794468483; x=1795073283; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RSqIoItjXabFeCd3yG0ONrGqXrTW//2M4yj0JC2D6LU=;
        b=e5Z7h234zkCd/ciE/tXHKetWlewKGG5d7S9/f8/LJ+Oov71aPEbB2k62uvxj7j8kCj
         708eNcRQT7nQB/4wD7RFaCEMyLJfBJMl4M6R0bzlbBU+JqA+35e/Pfq9Y+jsIbiUiq/t
         dWTP02rb0oS3BbLlp5DOLx39/3kNPXYbfoBarMjL0qe58yCQ5k0Fg7x8U4GWTXy4aKEW
         0sC6QwSs8udtVphoxrfovcgp9suB8hbs0OkV3+l3x93DTNLBdJqMZHm654WV90qgt2KH
         7+xLjGR+7QZiiYOFbHIlom1tI8rExr3pmdpFH3gJT2mx5vPsLFudQeYNxaHkJTUGHqXJ
         ucRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794468483; x=1795073283;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RSqIoItjXabFeCd3yG0ONrGqXrTW//2M4yj0JC2D6LU=;
        b=x/bEQHGPCI6TP7W6hNjTxQ2H9p0lYXhXeLAOnfbhfjhlOtcfGAd3+/UD4o9PgPAIwq
         Jryb4FI8hToQrmmfCUbnlxjb3K4WykDo8JN5oUI1+EDaORs9sTnO5gHQlaEYZsGtGv0s
         TRMZwSwSXI6IP8Ew4SVk8/VB/CaAfWdmUuecswwI7lS2rDD24zzcJpY+DdjRA9YlMBi2
         M84A4RidllphjPwUB4E2p+s47Wr0fo3CAW7IQpqDqLyQ3lMETYcgbGXQDpoaWUuICCsU
         biK8EDy07GzH9/lyaYODzwl73DX/+DI7SbzrnYFGs4VXjz11/Rk21ikHUj0itIZiRb8u
         xTOQ==
X-Gm-Message-State: APuU4Z+BN093wVk/BVmd62kReM5RATLoL8fKUSvbgq3eKlJbY86BS1Bl
	IE6OOz9rgC5He/VgsWrN8+vE6ZckjG+K77mjzuwVYZsCQljtl5Hjb7kyKrQLtvu1i+ES0z8lZ8P
	uHTMmJ3NUbNnpcexKdk3Old5yVq9fq4cZQ5vgGsPPAvfF+dmRHxwOoAAeBAM=
X-Gm-Gg: AYBFou1v/lvJnuev/if5Zl5M4/zB7bpzpJc03WLtIyBLDbtxn+wHeqLhQIC/nqP9Tcn
	8lbTYWlelGAk3zFkQ8NdsUeea/sTr6VCK4TJNnDrkcKJOkFk6xJ8whyYhSuI9UIdNxwUSaCVTNH
	76I7+AU09bxVrtaEY/x126dvtxD/hmZ7o2G1OwAslswub9dsfOnOmAVirn+E7Z59JbFbCwidD+O
	KK1W60WVYrJrASBRWc4H9E9GeDfgxxZ0cwVIsR5tGA4Hra3vI7mAAo/JByO5n5ECOMq2cN27mRK
	X7eOR7nfWDYqcVjClKzSvR4nuKPoFKvpv9+D76J/JZ9NfWpZfxWQ87rFFyNmYaKzDrdZBKnN7z8
	ayg0p6baBOYDlINhhEAFaDJ2LPbHfc8ruQW8Rk8PV7NirGshToiNSmeUUZCUUlNIS3Lg=
X-Received: by 2002:a05:6512:15a8:b0:5bf:a209:f81f with SMTP id
 2adb3069b0e04-5c15d632df7mr1472008e87.37.1794468482663; Wed, 11 Nov 2026
 23:28:02 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027061258.3900768-1-apusaka@google.com> <CAJQfnxFCMtr6AyGqRqAYQe461U0m1WBgzZ_psuTnU+1kS8-5Ag@mail.gmail.com>
In-Reply-To: <CAJQfnxFCMtr6AyGqRqAYQe461U0m1WBgzZ_psuTnU+1kS8-5Ag@mail.gmail.com>
From: Archie Pusaka <apusaka@google.com>
Date: Thu, 12 Nov 2026 15:27:48 +0800
X-Gm-Features: AclHuK9mRuQss2pbvsXUEp6Mw8Dr2YJlgL_feJg_aMhHpW4cC6Tk8ImBSNrEEqQ
Message-ID: <CAJQfnxE8hyYT7o9TRH5MDT-SrND+mxfBe+dWEhKkZHUCMY1uRQ@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: connect Bluetooth devices before
 HID++ handshake
To: linux-input@vger.kernel.org, jikos@kernel.org, bentiss@kernel.org, 
	benjamin.tissoires@redhat.com
Cc: lains@riseup.net, hadess@hadess.net, linux-kernel@vger.kernel.org, 
	Olivier Gay <ogay@logitech.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Nov 2026 at 10:06, Archie Pusaka <apusaka@google.com> wrote:
>
> Hi Maintainers,
> [...]

Hi Benjamin,

Gentle ping on this patch.
https://lore.kernel.org/linux-input/20261027061258.3900768-1-apusaka@google.com/

It fixes the first keystrokes being lost when a Bluetooth HID++
keyboard reconnects on a key press (e.g. typing a password on resume),
which affects devices that recently moved from hid-generic to
hid-logitech-hidpp.

Also adding Olivier from Logitech, who suggested reaching out.

Thanks,
Archie
