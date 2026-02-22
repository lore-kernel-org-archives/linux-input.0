Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08DF3590B9
	for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 18:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771785472; cv=pass; b=of4mD9sfsz8d2mA8g2OEG4dm2qeg0qXJ5sWXOj5LPcGlruH0bhljW+Kh/OddEZnIlMvtxcYnD4mmu1VBiY8k+vAR5MGzm9uTrYr/FeEx2Cmru1j6PXpmWl5jW3+LELTiiZ/nvrLmWWzbbKDKhbPOBzeRLBpdm+i2c54Klq8xTcc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771785472; c=relaxed/simple;
	bh=QOCYXua1nPlHK6QNu/Q+POk7hvoG+bSF7Hied4Uk9Qo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=CTJ1/UMdY5/vzO8M5UiUvUZenSrtZr+0tIE3RVcbRA4EP6bGRBd7Wch41Qekch5s8y7tQ8qrJvtoFmEdsQp3Lr2rZ6PdNEaR2jl5ArGDbcxSGeIKAu0uoE+NkBAwn17wA/2X6WN5ub+LiiHOcn5lgk9O0VSICDcKEElcKA/KxuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VCQ5jXBd; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VCQ5jXBd"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d18d02af68so2531127a34.2
        for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 10:37:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771785470; cv=none;
        d=google.com; s=arc-20240605;
        b=SgSwfA/YceMowj/VP8WRo/dwqMTGZ74B603Q+SSCbIKSmjHKsP0NczKP9hJHWMveyq
         HNcUXrdQu1jiMML1KGJGJGGH39TJCCIJpdy3ODwXpuwIwwVvqf22gvGt7vTYtaXBZK3H
         O7tGVeUPazLTX+kdhyt9+kyGk4Xp1Iy5GO5qTuTKVH6E9wwjrZq3vqIpfDjOFpcGxRS8
         qPoWFXuTQIDkOfqDEOASrDybCzbZAtJJKd1MUhcUpHU/XnWBUbVtZaa+FczFQEg1eDW+
         xdLZljEhKQYgkY7hQiGDbmb9xjjA6S0nEFYq2x5zgmduypWCmRBM2OetrqfKFtO7Jc3s
         mFIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=e2lITlF8DNc9m29jdiE5pZhbMo3MB4o4FwwAFLIq8QY=;
        fh=QBRj4p4k3geAuvF2WSiVLGKXZmHqCuQAf/1wieg5t1c=;
        b=Px7JiiH4E8eFIXb0wYq/Fu7j07ectLK8u1xpIDGFXbJmU6GFhfq0sJS2fyIZKFqWAL
         EFQtY+wJPdo0DVuk1nU0L40A6reCK9H9Kv6jlIbmH5xLYG7J/z7kMzrqbmz8HArleO+w
         2+UF82jlGdeRpDWa7xe73IHFpspExpl1k0gLdiShblJFT3G/UYTxDIGoqe48a+7KZ6tp
         aUXthM4R2XvBTTwNQm1uR/Yfvmkxb2pHaLEiQaQcoPjtPCKcTnWPORaZ622aDl93ejS7
         MkqhlJTZXMhdo5SjF/GxyP7lGQR08KBaJwA5Z5LavD3ZS2d9N457G/36eEwsOy0usCoQ
         nlDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771785470; x=1772390270; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e2lITlF8DNc9m29jdiE5pZhbMo3MB4o4FwwAFLIq8QY=;
        b=VCQ5jXBd8NaeSj0YcMUU5kJxkzdbJdCJ0/VUXL+kEsMG0N/mFo1zXJEEufjS4ebPem
         r80317J/QzX9jEdT0ilaN0wtEdU6sz8Ce0Z8hEX9lpgUSXHJ/XMBsH6qZQsPq+IdUbw7
         lqcJMknSZ2P0xjgLyatdkwqXkd160aBOWnSDbu6DN20gs7pd816gHD84szaJ2UhdCoLF
         ANnrVvyY/DvbibRqBgOstLKIdwQpI3xEekUC1MR43pQYkYHYdOT0eqyuOYRclfVyiqri
         GmW5j1t/Os4durhQjUJaTFUmZHF6FvILVqhlNdcBNC+JP0O/+X3tMH0lPUFdj0tOdaL9
         tE0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771785470; x=1772390270;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e2lITlF8DNc9m29jdiE5pZhbMo3MB4o4FwwAFLIq8QY=;
        b=s1atPolcynzra+w5+b6b40ABgv3EGEU3JYA72iYmd1W/cB5VWjFtBlrJ3lL0EmcUpN
         OaOWHB/H/kYaKgVPVH+CNgyI74dylbg8qpSKDWA5cWcAty7CFYZwbhBhnSisz5qsefTj
         n5n8dU4esG9sjTRgH5CpMq1dvcZVxqHavvwh0/BxM5JJ1QRvxEWHDAj4GCCPuDFgWJ0C
         OvYiFxu3/GLwa3v/ZiQNMLn4r4KxEdkEyxWXinerEwFKZZNGEym4aAH8Mnac4IyWMT9R
         N457av/NMkxGrLy9iT71DOLJqYtD352jzysVHG4GDAd9DH4/+RVGGg869m1mlFBuwf1h
         u5Fg==
X-Gm-Message-State: AOJu0YyXpqC0WKeV0A1FRH2X4H9vc7yAHJLQ65b6ZtCS+8LtpZKCaP2R
	/c3xfTDOpueIYkJEjeHLLsR83bVC8hHQDcwZN2mKA0Vr1LIKxhWjvamA2lj24zV5ecfujG+fp3C
	Sx5PlObGM0nELTmkUvgHqQczMTJu1QYjakG9L
X-Gm-Gg: AZuq6aLYUVslXRk/90p07FaZ7Myd1XQ3DDICInrsoKviAsLjL/qLcM1Y8GFqjmU796g
	Xl5bo5LnwAmwBlAlP0L8yVw7ki394JtFswkZ5WTlK3FOTd6ippuP+2RHuCzCdqRWGayzzbHJMpl
	2nU0QF6j4IaX9/zWKfaIaXTuSYHyTx43HxkqSxoSdwwJxfvjUgO1nKH7Zn4L8dMwx5Gq67s0wAo
	t/5a/a8Apq1aIElMWdFD0PeIBG+cGp2jI6Ol/hiOfYR/Aq9v/h52NDqGhdnZER9P6s9Cli4DLTP
	Xm87VqY9Z4Kfm8KkZqEvuQ==
X-Received: by 2002:a05:6808:2f0d:b0:45e:e4c9:cdc7 with SMTP id
 5614622812f47-464461dde24mr3341520b6e.27.1771785469676; Sun, 22 Feb 2026
 10:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?UsOhY3ogTcOhdMOp?= <raczm0812@gmail.com>
Date: Sun, 22 Feb 2026 19:37:38 +0100
X-Gm-Features: AaiRm52wa7Uhzeqgvw_MRIgOOkZAli3AjKWVRi_ywrnz7sIee_RpCkIhfno9Y14
Message-ID: <CANkKV92bTD11PCXYzz60WSxcP-0UCM8xtnY4_WraEwQx6TMjaw@mail.gmail.com>
Subject: [6.18.] ThinkPad T14 Gen 2 AMD (LEN2073) - Synaptics touchpad remains
 PS/2, intertouch=1 ineffective, lost sync events
To: linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am reporting a possible missing DMI quirk or ACPI limitation on:
Lenovo ThinkPad T14 Gen 2 (AMD) Ryzen 5 Pro 5650U
Touchpad PNP ID: LEN2073 (PNP0f13)

Kernel:
6.18.12-200.fc43.x86_64

Distribution:
Fedora 43 (stock kernel)

BIOS version:
R1MET62W (1.32 )

During boot I receive the following message:

  psmouse serio1: synaptics: Your touchpad (PNP: LEN2073 PNP0f13)
  says it can support a different bus. If i2c-hid and hid-rmi are not
  used, you might want to try setting psmouse.synaptics_intertouch=1
  and report this to linux-input@vger.kernel.org.

I tested with:

  psmouse.synaptics_intertouch=1

However, the device remains in PS/2 mode:

  SynPS/2 Synaptics TouchPad
  TPPS/2 Elan TrackPoint

No i2c-hid or hid-rmi device is created.
The system has functional I2C controllers, but the touchpad does not
enumerate as an I2C HID device.

Additionally, I am observing repeated:

  psmouse serio1: TouchPad ... lost sync at byte 1

events, which temporarily freeze the touchpad.

I have observed the same behavior on 6.18.9 and 6.18.10 as well.
The machine is relatively new to me, so I cannot confirm behavior on
older major kernel versions.

ACPI tables do not appear to expose LEN2073 as an I2C device.

Is this a missing DMI quirk, or is the platform firmware not exposing
the device via I2C on this model?

I can provide full dmesg and acpidump output if required.

Best regards,
Mate Racz
