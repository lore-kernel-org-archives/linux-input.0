Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645083;
	b=ISu9ihT8Z7KuPxrwc1Vvu3cDx5pnrsoCMTiJVOLDFgYQYfPGQp65WPHG6xpClsyEiPZ9
	 RZxmWXZOg6rBCPiA44utI8nyGmgmJ/Ckzc39TsRFr7jzHc/1CNfVkl9Z4E/tcEzc7+4YO
	 VY/gS2l86YIlgQSvOpnzf+3C4PB1rbYCHjyQHs+/XmKRz03/a1NVT7N0zFDo11ZhA83ID
	 F7VaJBT+UaKmUvTc+5DHOQtBG47BkhebA1bONAXio4g/utD8heYRKDHRfkoLK6F5+4eht
	 pJ6Y6/7aiojUKJjuqhY7excCQJP+m8JoSIyWVK0Lid2hA5V6omESN8xLuTkt9mp3Tnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645083;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BnNnCP79mIT11o498QX7t0hvFj8f/s/nQ+8DjF/+0o0=;
	b=1tEsfhHeMA5Wk47gpBttJamVqk43kxbxmGjggEVdE16A91O7vvbUGmGzv+sHKytXUdWV
	 cUwE7jAoOS5h4sM3GtPWyW0lxnRn3Drgi1T8XiBCmyaKJyvOof3xf2HVB67Ro3V9ROCNG
	 QQcgcL5IHCGpzqBRAThNLArRYjS/fAF1q3IGQw2TfMbvn/FiG0aTF4+WYF84LmelvXFuy
	 iF1ttG7tPnOIkHmIdKA0QBfMmZZg0vNLV6hNJfDyYbBR8Zlj0hUNjTlBHCZVc7FovFFpq
	 ImpZ71mn0bsnG6lkTJV8Gs+ehVcbAGleRS0Ug83LKCoJ4RJ1UjmmnelVnNGVm2XieXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fZxGGnum;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782AF606A321
	for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 22:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 782AF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fZxGGnum
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1a3c08d6928so9371153c88.0
        for <linux-input@vger.kernel.org>; Wed, 25 Nov 2026 14:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795645082; x=1796249882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BnNnCP79mIT11o498QX7t0hvFj8f/s/nQ+8DjF/+0o0=;
        b=fZxGGnumQ471hrV6MSOZ544ePTSYpR3Lpx1xjQjLGbLFi+CyEjoihhTrNFOnsUregf
         PC9dfmFaXIseGu4FIHQknJd41iX+Pfjh+pVEa9givyLuAaa/QLXg6hZjapJd29+5FKQd
         SeINeDM6vBzGE5p3mXaJRacxB7gjH+HgroTijO5ZiWPRCJUlOnihF9TN/DA2gQWygDHo
         Dhm817XIYFjIozAp7hurJ/G7vqVyV55MLsjBP0W7ANa0kSpDD+CCgM3lZTXbkR41rR10
         SGVpyeLQ678n98ApzY4dBaVcEPR4K6Ndqn6Qo6ZXJXg/iFEXXgD7UhMPSDkDWcAGwMTd
         bJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645082; x=1796249882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BnNnCP79mIT11o498QX7t0hvFj8f/s/nQ+8DjF/+0o0=;
        b=u8LgOY/xqgXVZmkgGFBQWIBoZg/vJGvCAynVRXs/jTh+litV3Hq+AJskwEhn9sinGd
         hZZgr90Rl8837PGCnkSv/IuNpZl7Og/WjkYpb4Ya4+x0pQ9M84rJCaktCopIybA/WNJO
         rEU1CyI2os9Ri01lOEvnNA+/TBYNJg3wEeLBuFLjJQmMvFEpzab/ySfq1zJ0S/rXej//
         +82SGsjrxXJIAIOjVwqrq/yncZ7XWYriCrFmJj/kGuH9VIugPRg1hMHh33UQbtR4bQNf
         DUhvTDXfNAWs4ZOwdIs8gEkwJOoHVckwQcQKVaiVjXgdWqHq3NXT7lR6ZLceld+h9hvg
         zF8Q==
X-Forwarded-Encrypted: i=1; AL+hErFdj5Xh46MgB2rzVfAWJ2apiD+tsFDyHkbxz5VLUSoPNaMRiChNRKwk1fiVaoWgsnVWPGJvCmHaa6XEWw==@vger.kernel.org
X-Gm-Message-State: APuU4Z83URsCp3/d4PLO/I4HeRZPGHQwl3TnvJHTUReAunqqj6ZXId9V
	PcHe1xIkcEEGwaP9GmNSkP7R9hVSqLDWYitFILjVEfiqIiZN4m8jj89q
X-Gm-Gg: AZFdTZfVBeOaoZYlWuik4Qg/yWERmacfLWbjQSEoN7h27gzUe32OMjul5KxzPKVW25l
	QRAVB8/9/DD6y39kz+fIiJc216YIfXXVI3MRXKG6wpgBl0yWoa+8GzzC7NX04D5KeMklrzukiKl
	dfIissHvBTszqHEcSMkebW4B/iV/sTDCEfBxpyWL21f9lHPDtzKo7Yv2iTrH29zuIu2zKTGZKgY
	ZTkH02BGpkn7pnEnncC/Vbmm5XtEq8FSCpvalDA1P6P3EY/+5MuSwVNEYgMs8S3KDUTzLlUI5cy
	pmGJzznMFtAoCB8thMC3q16ocB7/CX1sFGfvBNfOTIqW/sHtHiUDdmN5/yDgdde6FUUV661RVc/
	VIEw0eIIhfdU5wl0iiYfpDIrNHLs/+gOT+3BHb0KpP2urvLQS9Urnv8F/uYwpGqJ9ikN5/zgq/7
	cbLtwDuD/5UZzD1NYyEELyMiPKEC2kE7uUuUOmXLYWp/ZeL8GiIy8ATRDDqodyc9RuvJkA1unAF
	pdrNdPV4sJhzNiFFtOJ6owMyU9LkXjNOqAjHHcOdZFD8tpAUbqUQp5l+k5KDsTiuGuRqLcUFrQy
	JdpDNGe3YDiPQSSxl0pC
X-Received: by 2002:a05:693c:87d8:b0:386:b896:319c with SMTP id 5a478bee46e88-386b8963d3amr8931010eec.35.1795645082138;
        Wed, 25 Nov 2026 14:18:02 -0800 (PST)
Received: from a1-free ([2603:c021:8021:f000:0:1865:8c38:18fc])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm69581357eec.5.2026.11.25.14.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 14:18:01 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Cc: Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	TAKANO Mitsuhiro <takano32@gmail.com>
Subject: [PATCH v2 0/3] docs: ABI: report a symbol that one file describes twice
Date: Wed, 25 Nov 2026 22:17:55 +0000
Message-ID: <20261125221758.2535044-1-takano32@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

check_issues() compares a symbol across files, but it skips the case
where one file describes the same symbol twice: the loop returns as
soon as the symbol has one file.  The ABI parser keys every entry on
its own, so a repeated symbol on one file is visible as two entries
that point at the same file.  Compare at that level.

Doing so surfaces two entries that claim the same ABI:

  - shutdown_unlock in sysfs-driver-mlxreg-io, described once in the
    October 2021 block and again in May 2025 with a different default;
  - the internal MCU protocol_version in sysfs-driver-hid-lenovo-go,
    whose entry carries right_handle/, the group the removable
    controller lives in.

The two documentation fixes come first, so the tree does not gain
warnings in the middle of the series, and the checker is added last.

Four symbols are described by two files each.  That is legitimate when
two drivers expose an attribute with the same name for different
devices, as hid-lenovo-go and hid-lenovo-go-s do, so the cross-file
case keeps being reported, but as information rather than as a
warning.

The first version was posted on 2026-11-25:

https://lore.kernel.org/all/20261125190742.2420486-1-takano32@gmail.com/

This version points the internal MCU entry at the top-level attribute,
which is where sysfs_create_groups() puts it since mcu_attr_group has
no name, and the checker keeps its warning for an entry that ends up
without a file, counts lines rather than occurrences, and drops an
unused loop key.

An AI coding assistant found the two duplicate entries and drafted the
checker.  The counts above come from running get_abi.py validate
before and after; the paths and the group were read from the driver,
not from the document being fixed.

TAKANO Mitsuhiro (3):
  docs: ABI: mlxreg-io: Drop the second shutdown_unlock entry
  docs: ABI: hid-lenovo-go: Point one entry at the top-level attribute
  docs: python: abi_parser: Detect a symbol repeated on one file

 .../ABI/stable/sysfs-driver-mlxreg-io         | 12 -----
 .../ABI/testing/sysfs-driver-hid-lenovo-go    |  2 +-
 tools/lib/python/abi/abi_parser.py            | 48 ++++++++++++-------
 3 files changed, 33 insertions(+), 29 deletions(-)


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.53.0

