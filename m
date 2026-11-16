Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794833713;
	b=uHJXxsEeOMpGFey9IlZQ7AvTJ/fT0Ej3mmDgcfJLcSwv/7OS0J5W+2xaEsc88/KfYZSD
	 m/+50y+t6zYAS4zhBDriilem+fw069W3hv8m2CH5kL4T8wsfuLuezvz/4WJv2wtWxC5t4
	 SDTTXZM/gFZhPhmG7l0mTtsQvXSYIR0LCV1oGMMFvNT1/g9tBIZpWb1AKfwPveNH4CewG
	 5WTLqcDRCbfzAof7F6nu0LWXmnrip1CYRQkldu1NtrYSg/8SA1AhulI3bpajDZ9KaPNh1
	 egvr5GS8RrZ4nuuwg8PA343z5kpKVQhOcFBVkdf0VDr8YTcNdDAnqn9/TMhAQYOiSDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794833713;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=gd9XtUgGdbpQCXe75iKwK693Tr2E/Bj4YogDW8Ivi8w=;
	b=MH+hUy96O99e0dxd9MZqe8s8kdgj6q1JEJqCFBzyDpYKZJbPvqjhbDhCRW42yseoNzl+
	 R9AX2klsNuXlpqndGD3bIl26X03yyUQECBe5jdUqKbxZzOLhHNlZxytvdZw+2ERTroEaN
	 cveLF0SNbRGKQB77WSq4BTOFVMXXvtMmjO4O6V4pAbDDetVjT3ewihzCryDA6GpqFa3Cg
	 x68t+usnXacGq23fbLoXJb3ybV13J1/5ZjT+E4QaSycA6rar2YtYQV5atNBdxPxKA9LcW
	 PqDpWclIieOLUSnW2DZfR4vdY+MAMz/XXa+LpnE7tlaNmLi7Vn0oxyQZPBRMhPvkx+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rDUdkIEF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.174
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A3E606A323
	for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 12:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36A3E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rDUdkIEF
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3acff56a300so29783501fa.2
        for <linux-input@vger.kernel.org>; Mon, 16 Nov 2026 04:55:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794833711; cv=none;
        d=google.com; s=arc-20260327;
        b=RGwd5kSL/XkPzAZFUfK5J+AUUZV8hpIjGgKLc66ZPIB4e55IAXVFTE04LwKiqCpYaH
         cTuF0ydu4gvEtHAXNjjFI7en0EbRHQp6G88y25fO2ic2uRQ+1KuVFPWyCyZ8Je0zOykE
         pqx/v14Zc0D0GHIqpl9+zEoQygQyo20JMPsT3/QKL0NEaszQCD1/lSAXbAXB6+zqbjVb
         q3tbsi/adNp5/q9d7BFCNqq6vGDH+jNl7n4lMGr8yk87WU6qhZgxZ+VEDFqoRw2XbcVg
         ukucoQrNhpgYRWkyozi/kH6dXVW1GIBPLezyi+VA3hpiMc0dHHM6VYSOJXsTg7LLXzzy
         PbdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gd9XtUgGdbpQCXe75iKwK693Tr2E/Bj4YogDW8Ivi8w=;
        fh=SKE3rWmjCtMpCeL+gcXuSr8uBU2Fu5M0J6VuaWhed4o=;
        b=MYMVv6lWZG46UYkVeqDdJkRpJ436tx2kkgaBSJwhoE4vWvowE58Wce0y8Q+Zo7aqdz
         66LRV9KXtpJ7gEUsjJZ7HMZxvI2g6eVREs5Ie0ppAAbiwRxsKlkTewmy3qoXu63QvhMK
         bNDgil5ULMZByQzO4RFUoZPRN7L6eObNi1nPe7jFVk4PpxtFEStrCcAoMi5RJttv3V7S
         G5LelDpUuUdT1Dx3msZRep5zmk5++f2PRIOWBHvUtjB3mKLulBdgC14cvN1msIYy87+O
         o8Ik+GRQymChUd8hvDLubRelrx+Pp8MkP9qbYcxeXcZSi0+MJJPfNFvwUr7ogg5KL61B
         dqaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794833711; x=1795438511; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gd9XtUgGdbpQCXe75iKwK693Tr2E/Bj4YogDW8Ivi8w=;
        b=rDUdkIEFHrVKOz8Yvn2/z37kQHYyt/RDgEnYYDsxPf9B3RCtONXGSL5Hx8JluI2Y0N
         BURT4yQEt1oJMuQWNuXyF1iDH5LeQX7hyGplVkJ47E35SMjNM6B2+7LsFZM6bhI6VZsE
         pfrnsYnz69WuHbP4ykHal2SGhvXiGjMN3qzopwCsZITjeoE8p10L9OgThc575Wmy/iBe
         hgFZXxHyN85hNo6AstzNv7QuQNwcVveoOFP1qqUH2yB7rAqFGoQpOauS9Ht7+hYcnBVF
         iYlXG4Yi/iih2ptmiLjZWQ8t9hI9qtTjEDjHLvfLTtD/wCTC+bTOcRbXqyTA3FCliXGK
         Alvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794833711; x=1795438511;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gd9XtUgGdbpQCXe75iKwK693Tr2E/Bj4YogDW8Ivi8w=;
        b=W76IjWPGVwqYHKRueTQM9Cq/D7ccbggHIUlVNKVc0N3huzXymywElhSk+rF8xQNoUK
         dwaEB6omVRo77n64rNXTTu8Bp6M4EwR0IKMs6cWSpzz5QOu6J/lE+iz8zIDmItofumWS
         UpatnKTApQJocpWprQ5jtfQAxgNrHaDsfzxbbIw/j8ShX/mS04uaF1v06jaTbZ2V8/i/
         Fu50djNlcgterMFLagJiWwhIrB+8KEH1YNjtVQ85nSScDSgA8T/fhtQNbx0WmWbCe8gY
         ym3TfRQibEDrWLYHL6l8aNgYIVi3zdxvjVOIZ008NsFAOYG+GCVrH9OdZa6MV5kv02eF
         SThQ==
X-Forwarded-Encrypted: i=1; AL+hErGRqq7laYyvg2ZSq1S9/JuPPN6BFP/CqGnHi5mHPGI3Ws2HNBFB5YV8QSWgCp+Naxk4zIkOEyES9HLUwg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8HPCNlbJxgfSdU0HtZrLlqjCIdJpYFqFfHubJ9sGnVrXfUAxxj
	nGJkWL0izX3OoW9swH8k2vXhjUq1yL1wRCROEVZrVbqflG4+TvOv1NchAotICbmeGLtaBlXe416
	JSv6N8ZNMMPllIaJSLx4VC1AIU9tXU4M=
X-Gm-Gg: AYBFou1UiBFAbg01nIoOV11lO6KHSGg5uB0DWedTFZHvJPjcMGcZyEi5MB1ouLdxxy5
	KIsgOVjLmOLPKVkt66dTagv7FvqrgKgNestCshHlDgLkIh/w+aCvQTh6HoXAaBnXdw0jRqDygPQ
	BSCWg1DrxggMmyqfOga36wnx2ySoV8AHPdjIDyUpJg2vbiIMZcTIDAHgdh6JR9kLPqpGKavH3BM
	o/yrdCKgCyiK1U0oRB2Sjhb3x7NxROkF+9Qy2oxy1KM8/NHZItfDF1wulsTaAW+vkeIE5Y9BNsK
	1px/xJIKUJfyKjHgGpPMF7UdQPmgWBFqH6NdCcW6euDCvfdhXhsbVHfb0s28/d3JLNxStnOnQdY
	Fu031DJ7u38Lh4dNxKWrfVXQtrecki5ydyFCRP5sCskuGpeFmWsnRMRvzou8joW8/+izxsYpxeM
	3BmsHtR++ABRvbm0ITvE4=
X-Received: by 2002:a2e:ab07:0:b0:3ae:25c8:dc84 with SMTP id
 38308e7fff4ca-3ae2b53a651mr28470961fa.15.1794833710970; Mon, 16 Nov 2026
 04:55:10 -0800 (PST)
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: A Kishki <alaa6394@gmail.com>
Date: Mon, 16 Nov 2026 13:54:34 +0100
X-Gm-Features: AclHuK_wKENosxNMnjaz2CMZgmvlOpLLh8FDu5SjExkjedGch4987GIiOjTGO0s
Message-ID: <CAO6oLZEsN5gkaDvS97i_7bgPFOE-5eX8WjmGcWCcYHvTMQm9Kw@mail.gmail.com>
Subject: Re: [BUG] HID: i2c-hid: ELAN 04F3:30FD touchpad reset race causes
 -EREMOTEIO on HP Pavilion Gaming 15-ec1xxx
To: testyiprywatnosc@gmail.com
Cc: benjamin.tissoires@redhat.com, jikos@kernel.org, 
	linux-input@vger.kernel.org, lovekeshsolanki00@gmail.com, 
	linux-i2c@vger.kernel.org, mika.westerberg@linux.intel.com, 
	andriy.shevchenko@linux.intel.com
Content-Type: text/plain; charset="UTF-8"

Hi,

I found the cause on the same laptop. It is the SDA hold time of the
touchpad's I2C controller, not a reset race in i2c-hid.

Machine: HP Pavilion Gaming Laptop 15-ec1xxx, board 87B1, BIOS F.25
(08/18/2021), Ubuntu kernel 7.0.0-43-generic.

IC_SDA_HOLD of AMDI0010:03 (0xfedc5000 + 0x7c):

  normal boot, touchpad dead:         0x00010001
  boot via HP startup menu, works:    0x00010048

The ACPI tables give no hold time for this controller, so
i2c_dw_set_sda_hold() keeps the value it finds ("Keep previous hold
time setting if no one set it"). After a normal boot that is the reset
value, a TX hold of one clock, so the touchpad NACKs its address. The
startup-menu path leaves 0x48, which is why the F9 and UEFI-setup
workarounds help, and probably why the live ISOs worked, if they were
booted from the F9 menu.

To confirm, in a failed boot I unbound AMDI0010:03 from i2c_designware,
wrote 0x00010048 to the register through /dev/mem and bound it again.
The touchpad probed at once and works with hid-multitouch. A rebind
without the write changes nothing, because the driver reads the same
value back.

I run this as a boot-time workaround:
https://github.com/AhmedKishki/hp-pavilion-15-ec1-touchpad-fix

A real fix probably belongs in i2c-designware, for example a DMI quirk
that sets the hold time for this model. I'm happy to test patches.

Thanks,
Ahmed Alkishki
