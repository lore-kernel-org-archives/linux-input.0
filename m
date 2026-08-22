Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86B635F191
	for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 21:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434809; cv=none; b=naVmhBvkrCS+sEu1QXJSD/Jm6sJlcxj1+YBSF8IbfU6iBBs6KjGDJfqKKQ5dWNGLwMu0iQAfU/CHZnnb1v8OO3EebPV/GD313DNwZF1qSLDv6xHQEcxKdrmCXymzdj7wS1KiSty5/tdCrwoWGEOsr293WbdeIoWXLCQXYOyU9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434809; c=relaxed/simple;
	bh=KVdVCQFws2YHcTf23OIbqpRHGvWtL05gPa/MIQhexKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMUlD2IDwolDYynT2VDhFoWguDDmUG3Q/TAnOUuEd+fNH/FuYoF0jezmG9PvFJMvmzq+DPUc3DL6ouylOMHFNPHUapYkJKln/OTva3NuM6cwyULFl9yfH2EWJb1I9PXovVOAyCnEaBsr8NdOVCxBU4rrFPgaZ29RSXMOtu2WdTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCZ626GC; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCZ626GC"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c2020421077so372231766b.3
        for <linux-input@vger.kernel.org>; Sat, 22 Aug 2026 14:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787434804; x=1788039604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rgMbZ8S6nkK5E2O40RbnDFU7z8jdbPLfNie0mYT0a4w=;
        b=fCZ626GCLhBsDRzFUNLU/YDlvTHSp3ZLtaj/x8sIhfDruvwrr/H0AKWZkCSolUukZF
         WQojYuU4cwqBEAfa5fBXHJrNUhUUbex28qO4zNaEMXlJW3pmjzlJiBX5Ixit2mVMWiBW
         qGBfuaowEhbb1BAAU3huh+a/+GkL0PzLP3tNMrr41/lVgXKqV+PdIGAjv5vIdkKd2YV9
         vM3sA4siiq1uxAEkNYnFBJRN2w1uxc0isKVRnuX6Gfgxenw4WVYrR9iK3EJfXrKt91ZV
         MSD4HSHdPs3yfPSPHEWcv97lEEFe5IgCo8NW2c0c2xZ7v2vBSE0Z+bOzokZV4OxOIR1b
         jN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787434804; x=1788039604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rgMbZ8S6nkK5E2O40RbnDFU7z8jdbPLfNie0mYT0a4w=;
        b=Q/VHVGf0B66I4UR0N2TFbCXX0Rj4V3VFN8xHvGS/5JjwXR/SBUuEn1ZTLH4qQUnUNI
         rRAZNNP4BwwLv8TdCjyhH01cxls9BShi0+x1YRccK8Ns8I+cGjrNQjRHX2ZHJT3SzXI9
         4jqIRZ9jm7wS5/yR6MX+wuE5H4L4YIYQF5uOOVG+DAhIZIGhRjPS05OKJxQ98xgWWywZ
         LE4pjaaoQ9Ho5eVPGZ5te3j8Bk4DliMYIpLPTWLMF3aEhYuhEZbNCWP8VSj4C7CdsZ72
         pKMO5tndeuPb204JSKZ2gl+Yd4+7Ey2o2JY+NUDt6ysVffaTfDcUTzSO4LTNKHWEhEEc
         oTnA==
X-Forwarded-Encrypted: i=1; AHgh+Rp0LFNRw2XjGyU5F4P1wVq2LWjrYl8FtGBpAr68ZQ1gyXKXsDLgZHPTosANzg38hIO/UWbfKcPemcXCnQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mSFkPKdQlw8CoNb5m3YTqvfmEO0f2SbZgDx9zsvn9nOH7d86Hw
	3Js2iaIeaXlU3JWV5/+/2XOQPRDI2o7nlzMSvVM6f1U2tx2Sdhn62B6g
X-Gm-Gg: AR+sD13MWo9cZpsfcENtoEC1DbcKJ94BNmDKRbl6zyfEsO8dRO2QVG5Mt+qKrGlnjMK
	6Pj3PQHj20c9qknAS5uBgfB62DNpdHerc95vQDRD3QWR+MAIkJ4AOOW/XoYoXTivrHusMSu0qkC
	ddj1CJVdHLTRpcTB6dgKR7f7cPLn9YuUA2RcUFflWvpDZ7wsbuRguN2BuNV8ZuDhxpsnCoG1zIs
	d5qlDTilWQ6GQYljLEr3NUyFOhx+Y4nyvc7jHFLkEGMtW9tcEQD4t5H4tnrYLLNU4ffdl1Po+N+
	3797MmOVqvxVqyVXzqkU88rUrWXB5qcaIhCh/MAldPzK1EdfM6m8e+1FWplaCvJyWIxSCKxui/R
	OBO6Fv7xsLx543I/hnD0vQ3Auxtj8FL3v/EFeMKrx6bkMtBrs6h4EVJfve4NCXkExWDlGUWjddw
	kAvRpSMGrm6kW/ryQYRUuJG8eDx4Nkx1wuBBkqlTx5fCbWmW+UCMdvTfWJpMCASvPwb9zvjw==
X-Received: by 2002:a17:906:7316:b0:c19:45e3:2f57 with SMTP id a640c23a62f3a-c2491cbca79mr901591266b.9.1787434804173;
        Sat, 22 Aug 2026 14:40:04 -0700 (PDT)
Received: from m2.. ([37.142.151.124])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c24966f99basm466778466b.37.2026.08.22.14.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:40:03 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Rio Liu <rio@r26.me>,
	Bruno Giacomazzi <brunoceg1@gmail.com>,
	Christina Quast <contact@christina-quast.de>,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Zaidman <michael.zaidman@gmail.com>
Subject: [PATCH 00/13] HID: ft260: add UART and GPIO support, plus I2C fixes
Date: Sun, 23 Aug 2026 00:39:28 +0300
Message-ID: <20260822213941.98882-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mainline supports only the FT260's I2C bridge. This series adds the
UART/TTY interface and GPIO on top of it, and carries the I2C fixes made
alongside them - two years of out-of-tree work [1], now replayed upstream.

It picks up work that stalled twice: Christina Quast's serial driver,
posted as v4 and v5 and never applied, and my own pre-UART GPIO series
from 2023. Patches 1 and 3 link both threads. This is a new series rather
than a v6, being much more than the serial driver now.

The patches keep the order and the granularity in which the work was
developed, so that authorship stays visible: squashing would fold several
people's changes under one name. The UART and I2C changes also interleave
in the code, so regrouping them by interface would mean a rewrite and a
full retest. Only adjacent commits were squashed. Patch 1 is Christina's,
patch 10 is Rio Liu's.

Tested on a UMFT260EV1A with a 24LC512 EEPROM. I2C - reads and writes
that cross the 60-byte write chunk and the 60/180-byte read chunk caps,
SMBus byte-data and block reads, and the shortened read timeout with the
abort path of patch 13. UART - a 2.8 MB pattern in both directions at
115200 and 1.5 Mbaud against an FT2232 peer, without flow control and
with XON/XOFF and RTS/CTS, plus DTR/RTS toggling over TIOCM*. GPIO -
through libgpiod and legacy sysfs. Every commit builds with W=1, and
checkpatch --strict reports no errors and no warnings across the series.

[1] https://github.com/MichaelZaidman/hid-ft260

Christina Quast (1):
  HID: ft260: add serial driver

Michael Zaidman (11):
  HID: ft260: uart: bring-up fixes
  HID: ft260: add GPIO support on top of UART
  HID: ft260: i2c: reduce driver module loading time
  HID: ft260: i2c: silence sysfs store big-numbers
  HID: ft260: i2c: reduce bus-error message severity
  HID: ft260: uart: enable flow control
  HID: ft260: uart: add modem pins control via ioctl
  HID: ft260: gpio: group sysfs attrs per HID interface
  HID: ft260: i2c: fix large write transaction failure
  HID: ft260: workaround for TN_189 errata endpoint STALL after
    enumeration
  HID: ft260: i2c: abort in-flight transfers with STOP before reset

Rio Liu (1):
  HID: ft260: uart: fix active-low RTS/CTS/DTR/DSR polarity

 drivers/hid/Kconfig     |   10 +-
 drivers/hid/hid-ft260.c | 1967 ++++++++++++++++++++++++++++++++++++---
 2 files changed, 1830 insertions(+), 147 deletions(-)

-- 
2.43.0

