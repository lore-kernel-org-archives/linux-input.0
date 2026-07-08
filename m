Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E858D369D72
	for <linux-input@vger.kernel.org>; Wed,  8 Jul 2026 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783517433; cv=none; b=EzDeq1Cbi/8SQ2r6L3PDZuxmxA9FpqawHiB2+CaKwtDI2XjUpTjnupjTiKnvVRzhX7B/RkfC9MDUMROZjUFVUw7PPg4txl3BCRYtmykrajV9ooysP+6xrlVcpXIzWySc5n2HgJkMmqFA7D4uQNh/RN5okpHmYaRAiofLTTusV3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783517433; c=relaxed/simple;
	bh=lRSxxUfUOsOthWc/W0/61ndF+KiOfs3wdc2i157SyDY=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=F+J/sZxt//tmEj2Z0cq4hapay4LlyxFK0Z2QrN2CpSri7T23XqueQ4HOJtRA7pkGExntsEdY4IZ3YgQEFKnubG8RurvaqEBLu/enrpSPNlpk0AeBXtif6PGmg7KaHoI3x5On+Z5MFd6Yv0RywAP9aVyzZNw7mjZ7vAw41ohFjhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvnUqVCJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvnUqVCJ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6989c0ec3c5so1222995a12.2
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2026 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783517428; x=1784122228; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lRSxxUfUOsOthWc/W0/61ndF+KiOfs3wdc2i157SyDY=;
        b=bvnUqVCJevR7J2y0qftfb/GO6ocLNg+fWmXyE4ht0daiuCz7aUunyUedPTEjBCKHRr
         eXrn7/YcbhxZgK2Y+57C2/gLoz7UUJLLgj9pgNaWEPFYFtTtwN7dh3j5ViXDsqa/GJSc
         CXaEElC9vxlh5ggAUgjZMGdIqoy/NMY7iR62RiGKZxxRbR2ULmTmXKBfsEYOZvR4SqfI
         kiow0x93c/tN0Pfz8JqZdU+rEuhVNRmMdExpcmsMKPKgacr+IkyKtuA++vDBNLce7mv6
         fw4fRFyrf7gQRzpmeoGjk68ywnLwUmc0tTg4FAygwS4tze7JQpUeXQjyIPZgtZwM+jXB
         qYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783517428; x=1784122228;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lRSxxUfUOsOthWc/W0/61ndF+KiOfs3wdc2i157SyDY=;
        b=j1Ld4Y5xc+8Yt84DmDLdi1rnN5HeZg6kGJhL9d2LDo67kfkbwOA2+YkX5DdS1RJ5gA
         0JJuhvu+0XEAybql4d1fhwkImjt7l6BDUW8xyUqJvNzBN6K7x0+/8Npr6rFblO22gkuL
         1t4R1RQh0RJBxWkrk986OPsOD3BnsUPO8DLmXfv+b65PumtmfERi6ihFsxDYnbZuyhzn
         PUo/jO82vHdHInKsPcNGrdlgHVWq+7T6ihj2yC7fIcqcn92ugEQa0xvu9PQaGv6C4R+8
         5Caz6IDiWPfG7FdYV6SHEvM74+kKkET6AX5tFqbhBkZBp+QDXL7Q2mxG7IsEHjqq6I7Q
         ggOQ==
X-Gm-Message-State: AOJu0Ywu00EWAyWxdgUIOHvBqr5pZFYaEfhwgh8RyMMql740B+rebHFo
	AMkNBFk4zA+cmumW1+vI38L7+YiHNRn6QSg+zD9m6a5hZQWBfRW2lQPQPRKptris
X-Gm-Gg: AfdE7cm8MOMx2VFca2yhuxNwxFL8pgTk3b0fBme+wxgjCJ4MWBImgzL53oZ77VoTmBN
	YaARc1bBUgb28l6OAKcTTmRSlU/k+AQ1S2Jpap52f4LX9vtAt8tcvqVmCxMJ8NJ+TcI+ZYq3Dnc
	Ru47kk9F6kT4lIxH2JS1YhmByFoz+pC3r9qTqaz78OXP/wrIzOaX1+OU7HpG5DGU8Igzz/nfKRY
	FDt5I/CFXh6JEpkGMNULyh22NUImbn/4hAMlOLyC34kw5J+yuJvY0mj5Z/oR+CnaCUKlGSrENUH
	2DAnVorkOmzUBz0F6UK4ClMwQqsc3wUSfrIRVhqmfEdl4UPICpD0on4hLQ+846Ttw7HKNsEOfMU
	TEMmhQMuYVeN981okOUzmxqewFhl+KDFoqGHQLP23GE54T4ZU4DhOc4LBa2y/PFlkYQshE3uoxr
	UNfP/NuGz++0y6Mxdqrg==
X-Received: by 2002:a05:6402:3788:b0:698:52b4:c2c8 with SMTP id 4fb4d7f45d1cf-69ab44b405cmr1078289a12.34.1783517427392;
        Wed, 08 Jul 2026 06:30:27 -0700 (PDT)
Received: from smtpclient.apple ([62.171.228.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69acd3e06d6sm218180a12.26.2026.07.08.06.30.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Jul 2026 06:30:26 -0700 (PDT)
From: Alexander Kochetkov <al.kochet@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: [RFC] Input: matrix_keypad: fix interrupt regression introduced by
 commit 01c84b03d80a
Message-Id: <4130C026-2A83-408B-836A-ECA044491C47@gmail.com>
Date: Wed, 8 Jul 2026 16:30:14 +0300
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-kernel@vger.kernel.org,
 Siarhei Volkau <lis8215@gmail.com>
To: linux-input@vger.kernel.org
X-Mailer: Apple Mail (2.3864.600.51.1.1)

Hi everyone,

I found a commit [1] that breaks the matrix_keypad behavior on the =
Allwinner A64.

I have a PINE A64-LTS board with a connected keypad polled by =
matrix_keypad.
This commit caused interrupts to stop arriving at the matrix_keypad =
driver entirely.

An explicit call to gpiod_direction_input() disables interrupt reception =
on all chips
where the GPIO input mode and GPIO interrupt input mode are configured =
via
the pinmux register. Interrupt reception is guaranteed to break on =
Allwinner
(A64, H3, H6, etc.), Broadcom (BCM2835/2711), and some Rockchip SoCs. It
does not break on NXP i.MX (i.MX6, i.MX8), STMicroelectronics =
(STM32MP1),
TI Sitara (AM335x), or Intel/AMD.

Furthermore, the assumption that enable_row_irqs() restores the =
interrupt mode is
also specific to the Ingenic pinctrl. In the vast majority of drivers, =
enable_row_irqs() is
supposed to simply set the interrupt enable mask without changing the =
pinmux.

Commit [1] was introduced to work around a hardware limitation in =
Ingenic's JZ4755.
This specific behavior is unique to Ingenic and a small number of =
specialized chips.
The majority of SoCs (around 90%) allow reading a GPIO input that is =
currently configured
as an interrupt source.

In my opinion, the correct approach would be to revert this commit and =
fix the behavior of
ingenic_gpio_get_value() inside pinctrl-ingenic.c instead. However, I do =
not own an Ingenic
board, so I won't be able to test such a patch.

Alternatively, I could introduce a DTS property like read-gpio-quirk in =
matrix_keypad to restore
the original driver behavior by default, and add this property to =
qi_lb60.dts so as not to break
the Ingenic platform.

What do you think? What is the best way to proceed here?

Best regards,
Alexander Kochetkov

[1] commit 01c84b03d80aab9f04c4e3e1f9085f4202ff7c29 ("Input: =
matrix_keypad - force switch rows to input mode")=
