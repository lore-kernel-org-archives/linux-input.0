Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6323BFE2D
	for <linux-input@vger.kernel.org>; Thu,  8 Oct 2026 07:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791445545; cv=pass; b=ZXe69gIdaXPR0Sv72nm+0P4dKAbgGiRo3tMJg+XBnWwSnZ3DyWRUdIIBElTTiCGltpwn+ilelgg9U+euurRVfaD7D48IWDXmoIfbZali8MVBVdBR86HPqhrHwjPRJ7DiIIkWmMc+RaxxaTcmRPXaYWcU9CkXBt5ZFKbZze3QfjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791445545; c=relaxed/simple;
	bh=5W9MU2ubquZd47q7s5eZMw9anlgx2vW7wLgtcc/INV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikwT1JeII1CAn1JE8ZXZ+qllrQttyTIigmgfyMi+v/o+y4EwBAJzfMHVbxhUF5Koyq/ojNuG003Rh4Y2MB+yyzrPTjTzEfkYtPPGru9Z9HPtQbFICbiWnUJLeZpPjnJXkRg2v9aGDduAc+ODkw9SvKVFy1bKslORREef9jgJ900=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5TDrUby; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5TDrUby"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5e78346891fso982834e0c.1
        for <linux-input@vger.kernel.org>; Thu, 08 Oct 2026 00:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791445542; cv=none;
        d=google.com; s=arc-20260327;
        b=XoMYZFCq1sxtPnLFM4exa53ih8RDbqm3lhva0RSnqO40tC3LNEuSCKXMNT/FBm9wse
         w/T+ibOKUWcy+/FiZDQThmIl6/htKZXNTCWL/qVpXpAqpecfMpqaWeT0139qn4DQydUX
         oWthoLrmmJxG6S6fXjstdRwmwBTo92Y0C2l+gtopjqLLT1nbL7j27wUGMBjGKqsuCqhQ
         kSLBapZ7+TpV6MyozZCoJtM1B7ZLPVHr7CXkdiwAD/bnXbnjdusIKrhU9sApnjCB1qhw
         37v9YGK1rxAlkXQRieFIoKj1EK/BwhhpYkRRoDjU5yxHNUDakKHXYT+8JM0A4AvDwolT
         B9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=5W9MU2ubquZd47q7s5eZMw9anlgx2vW7wLgtcc/INV4=;
        fh=fFRAZMIP8faJ5TuJk/AizzjSxdOENbm1e2FGzBOF+rA=;
        b=IxV8T1QPLIFviMWNMepykUJjv9fHjBQBF+aUweon2eNcsNKTFRFkbQ/W/1j7TdzzlS
         pF5YPhDXhWfYbDkIVGW1JlATBCEH6/ZTSLGi2tZGMLNXtumc30MbziXLuU5E8DDLHyIM
         fmgEAY8GiZjVZDqblRhs/GuxtqFzDNWpArG1AUR/rpYfd/LxFYIqN+quZEWy8RraTzad
         VoXfkMNLmBy1PGghvUvnHOwYrpos2ZRd9LzRBpSfZpCGbRWeP1yY8OkgbrY+2fr9A3O4
         IXHJkp47P+9QCBZ7oeY2IXZxSbGLIwDiY48i446ps8Qfkq1A84MVNfgSIGQDF/wHd31c
         4TUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791445542; x=1792050342; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5W9MU2ubquZd47q7s5eZMw9anlgx2vW7wLgtcc/INV4=;
        b=U5TDrUby9a2QAE+EfXvpR/klql70x2s2Jo23myTGP+sWk9fJvhLYzDY0uWMPvbQVaS
         SQPVogWYXwg5977bKv4sg8HTu7SEHGORr2DUNpnRNktGguxMyilZS1IgVw03j0QeIvb0
         LGZZ6VjeYQcGj5WbSJs+Re4XMFzWnETgI1FOD2hsJv0Yq/ip/PM2cZ74QsIbC1q20O5I
         651cEzjsZoYrbXin1O6h2oaBhaeKeRNVlbFmKEtb20Fs54IW3hMavc7zJiihscRSu4W6
         F7ZfcQykuk2Qg3AZUIrXSVEs8pauFmcJkTtjxelReyYqyaw3KJFP5LN7L9dNqTP1GAn6
         tV0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791445542; x=1792050342;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5W9MU2ubquZd47q7s5eZMw9anlgx2vW7wLgtcc/INV4=;
        b=qupS8/ENfmnGcrb5wWBXDRm8Qi5RP55evtEDc1IzXjnctXr/yVZV/T4uKIxwbR91RJ
         U6KVl32Kxss+y0mCWCP8nloG+Z7p+9FzAACD/wVyM+4hkkCqPEN8zsbRttmu8KCg5bCg
         jw+fklX5Hnb4cH8PHQLzYN5fMf4gt03i9rOU0UKKexNHAXmupASNS4kS/bQHuEt/euEr
         pY3nWJE68vdHCPdyYT5ATpr1kX23WFzkXDH1bEgrWOwViT+tcg0QLo+hsnWqhMaE5G3C
         GInZc5bA5Nz/XntBJQM2h/IPN3CHgyERM0VdY1sccEJoIlDYkO3dvLCHtgTJ+glyD3rP
         NjCw==
X-Forwarded-Encrypted: i=1; AKwUvBwOTcN5IZJJA/MuATrlCooK00oSgvgKeVDSUtSon4/d1G5pkSM4tNfSX1UDVPokCnB0bAPp/X313yumYQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKbUGLw/h/KuhR6jENWFvJCF+z6D6/h9qlIrrvOwF/m/WsNi9k/
	IcmWUwn49qmvycU9UoSYxEy/DjUODiNMdCNbGP/AOwTKkcpcJ9iOCudWsl0b7ZVPqRVhFmZV5Cc
	w2ZFqQ2kLABHxwP2AmF0X2ar/bjOOhM8p5uFDSlSVsg==
X-Gm-Gg: AYBFou3FGUmKzY4HKDfZ7YwFJvMqsgYLw9GAR6axQWI+u1b5riR/3BX4a5RoRGFf4ZG
	4LYc2haXMNbVp8TVvmHh29Y5p0cl3lgwMXYZ9GfzImt0TtNMiziEWFhP+UUMKg1bHCJfEePoVew
	rCHK1Ja4+AxSwEX7yi6/WwtSZDg5GegiME7D5xYRt34TrU5znxf7lESO74X2QaaJ42hlOHwNkPL
	4UgYW1QFxJ4tXlEY9vezrJkUDQF2yQQ+WbgDk5ChP/79apu4/aPomovsLTQKYduVOdR8nQ//NtL
	Rcuh2XDqeChS4Hfs3P1Y+218PUMWnr0qAe9lJfFFBwypCwA36HJKiKQppflfPrz1rxC/kiwXpE7
	b8Z+t4O/SPJjc1Xu5pSfrGNB0Da70aAI1vUZpz8vCHJUevR7Crs9+gnEM7DK6k3Va/0+v5q08wA
	qSf81IwT4BoDqhE3ejYKLNGPwVWG1EmDgdUhQsi8Dj9QmLaOOT6gGg2jU=
X-Received: by 2002:a05:6122:4b81:b0:5e2:ef90:d438 with SMTP id
 71dfb90a1353d-5e6d2c26fa1mr1670535e0c.13.1791445541148; Thu, 08 Oct 2026
 00:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008-b4-elan2514-irq-route-v2-1-432d95eb7348@gmail.com> <sashiko-outbox-163750@kernel.org>
In-Reply-To: <sashiko-outbox-163750@kernel.org>
From: Waqar Gulzar <iamwaqargulzar@gmail.com>
Date: Thu, 8 Oct 2026 12:45:29 +0500
X-Gm-Features: AclHuK8q4VPUC_WMWTIOyFQ3S2zIGEHB1qbr-nZwIRCXR2cKAYAVR4iHOlSzFiQ
Message-ID: <CADeB2YrOd10OX-BzjJ30p4ukC0OsCv3-gooOf0WxXfiZx7ChMg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid-acpi: restore touchscreen IRQ routing on
 HP OmniBook Flip laptops
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On the wakeup question (same as raised on v1): the ELAN2514 is not
wake-capable on these boards. TPL1 has no _PRW, and its _CRS interrupt
is not marked wake-capable, so i2c_acpi_get_irq() reports wake_capable
= false, I2C_CLIENT_WAKE is never set, and the device has no
power/wakeup attribute in sysfs (checked on 8DA1, BIOS F.20).
device_may_wakeup() is therefore always false, and power_up runs on
every resume.

If a future firmware marked the interrupt wake-capable,
i2c_hid_core_suspend() would also skip power_down under the same
condition, so the driver would not take the device through the
D3cold/_ON cycle that clears the routing in the first place.

Waqar
