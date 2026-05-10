Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E3E2690EC
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 04:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778387718; cv=none; b=AytW2nYypsTWYnunwCfR7ZaBWj59jWdz2ztBqrCELA2SCS2I3mDx02HfZCBvF+XE157xg7zgYz8G7Xc6ID54SyGGhVv2pAsjqF+0+IHjvtNnZOiAqbx2HGG6Thu7n0AASfIgdhFPOwcblAytrRTQktNOlXl8u9TkgcSABPek7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778387718; c=relaxed/simple;
	bh=78Nf458slPacJvpnRvOG1Bl9fYQHdqC4ktR3gfPaiD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FhOqP8Ib6s5wRieb2xKuSttbhRdyNqyww3S2SPxHqcOWhM/F0cV7qe8SlluUgwFGDbtA7ECa4RC1zY7Bio6OyUAYrWfz/Pma1mUch7uTEhfZ9JCazlqL7+pCpw1dkgr2kEQ/izAPrYHLobaZGUg9I2cQVCnwP+TmG2VjBFOK8U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khEv1kRF; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khEv1kRF"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2f0ad52830cso4863280eec.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 21:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778387716; x=1778992516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OlEoy4DZ4SH4fgpH5599ViWFjoBhWI0C/WiEDfJBN0A=;
        b=khEv1kRF149B5Ck/39XN2llLsIPz+lT2bwyWaQxtnsISQrm8bABQAsDJD3y6jYlB0J
         lJe6mlHK2Rw2PZFlAIqnZ7VSTjkhfnz8yr5qoRHkjVqYICQyg84la6nQo86CJw860qz3
         7ppjfOqCtQj2SsPe7CZzfZg3ANifsNk6AN4O6vcn+7inH/8RSWUzp3n/V73KQg1xvMXc
         MWDgjTkijb9Yltjp/sWi7hQI1+scA6Q/aSIilGJTMHmFoAF0eRc2ZiU3kRa3fvS6X8Vb
         1z6FQy5Y+hql/vuO53F0T1umdmuFe89c/wVXdv9y4vz4C/Hx08Y5th/jTVCOKbzRmjSV
         bF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778387716; x=1778992516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlEoy4DZ4SH4fgpH5599ViWFjoBhWI0C/WiEDfJBN0A=;
        b=CYhtzgjscMOYP9pw4tiol600Dym9E1sFq8x+WMl1gJRikiIDzlthXA95/ryFkUTwmg
         wkGuEuYb8iZKEnn+s101+ctuLhLDjlrFz3OohjIBh+DEMMDOOWA4X6fxJ8WH7QZ850eB
         h80wF7YbBtZ1PdNJBbVIbxET8LcW+BIjCdJfl/RED7hTBIoGlsNFzHpRmfHzS42Nx1s+
         Rl2OIm/IZAbuQRvMMbA8S2SCRlPE8rfSrQNZTZ897O2AEZs6rnX1JNINbRETloS7vFyY
         vm/XbXpe8zfpyoCi+3rvJEzTGK5huq7vXk2OdVlyIIcJKOgqbCt9Oxs8CUjom6eKw8Rq
         iGMA==
X-Forwarded-Encrypted: i=1; AFNElJ9mOPmQncz8TpNCkkJAR7gwSwk9m3w7GauIzDEh2DL601mf7+3J/W0jF9nyHbLO0PrGtt0wIerFn/e3JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz51INDJVZsSdoi4yyAL3/09+KCEBrrq7ZE3wVxLR/9KEAwbG8i
	BJLo1/w3qv547bLgFan7k4m3wgXSvj4iInq2RyG2uT4wTKLeBMwd66jg
X-Gm-Gg: Acq92OGGxsjfipcMsPWYGZ018fAY8omt3D8HfRZdobq0j/vfjnIHyF0D8dy42bG9y0n
	I0ZaOerka0FyYE8tZM2R7lmQqahF6KFtC51hUAeiTRCcxULcZhL6JNdDjHBeQwJzXwB9p9GoHW0
	sz8ZX1Mwz/prpALMqRQxTEc50+BV2Cgw/yTs51geSZszg5FSiHyvuvjf+3YYONc0FA9GLVO+TIM
	jR0P+niE1Mc9xrrDgYgIpxfa509V8a3xf4JZ3tL23RtxMkiHF3ZSeLbyQdTEC3Mg8NIa/uuJS/O
	dScmMSFExgDI3+HHBlyvDS4BNKLOaDantd0aZyI8Al4eBn8/UD8vCzCAF2yPt94knAgFKPUABZ6
	4bgZBvFlIRANDnuTgZYdjaA2B2lxJAGz8A5zULXRE2WAqnB3r2uX6yz43KxT8P8iDPFfIsMxwIo
	daS2+XpuDI9dFC+u9kn7cIvhbugzm50JhN/E8O/jtlcWKvNUt9Q2+jXkfrqjVwisETFuhBgzCmL
	mUgqZdS2PNEp/8=
X-Received: by 2002:a05:7301:1010:b0:2ed:27a3:eae3 with SMTP id 5a478bee46e88-2fb4e04199fmr1601148eec.26.1778387715632;
        Sat, 09 May 2026 21:35:15 -0700 (PDT)
Received: from lappy (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f88885be8esm8667953eec.22.2026.05.09.21.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 21:35:15 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	Denis Benato <denis.benato@linux.dev>,
	Zhouwang Huang <honjow311@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Add MSI Claw HID Configuration Driver
Date: Sun, 10 May 2026 04:35:06 +0000
Message-ID: <20260510043510.442807-1-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds and HID Configuration driver for the MSI Claw line of
Handheld Gaming PC's. The MSI Claw HID interface provides multiple
features, such as the ability to switch between xinput, dinput, and a
desktop mode, RGB control, rumble intensity, and mapping of the rear "M"
keys. There are additional gamepad modes that are not included in this
driver as they appear to be used in assembly line testing or are
incomplete in the firmware. During my testing I found them to be unstable.

The initial version of this driver was written by Denis Benato, which
contained the initial reverse-engineering and implementation for the
gamepad mode switching. This work was later expanded by Zhouwang Huang
to include more gamepad modes and additional features. Finally, I
refactored the entire driver, fixed multiple bugs, and refined the overall
format to conform to kernel driver best practices and style guide.

Claude was used initially by Zhouwang Huang to quickly parse HID captures
during the reverse-engineering of some of the features. Since Claude had
already been used, as a test of its capabilities I had it implement the
rumble intensity attribute after I had already rewritten most of the
driver, which I then manually edited to fix some mistakes. I also used
Claude to review the driver and these patches for any mistakes and bugs.

Assisted-by: Claude:claude-sonnet-4-6
Co-developed-by: Denis Benato <denis.benato@linux.dev>
Signed-off-by: Denis Benato <denis.benato@linux.dev>
Co-developed-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Zhouwang Huang <honjow311@gmail.com>
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>

Derek J. Clark (4):
  HID: hid-msi-claw: Add MSI Claw configuration driver
  HID: hid-msi-claw: Add M-key mapping attributes
  HID: hid-msi-claw: Add RGB control interface
  HID: hid-msi-claw: Add Rumble Intensity Attributes

 MAINTAINERS                |    6 +
 drivers/hid/Kconfig        |   12 +
 drivers/hid/Makefile       |    1 +
 drivers/hid/hid-ids.h      |    6 +
 drivers/hid/hid-msi-claw.c | 1577 ++++++++++++++++++++++++++++++++++++
 5 files changed, 1602 insertions(+)
 create mode 100644 drivers/hid/hid-msi-claw.c

-- 
2.53.0

