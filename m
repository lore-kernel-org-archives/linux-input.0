Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80971F30BB
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785784559; cv=none; b=mNxIeyrRFUn2hPEdmKPCV9dunEZuBmcuK0BcE4skG44tMmWHgc4bak2KYWGyWAaELzAB9fc4muiTRVvVCE7S1BCi0IQRwiYn7LebffSK489IzemxlgL6yol6lCa3TOhpEvmDZX8bmiK5RW6rBYRgSXCy3k5eEqASLrbDHryHaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785784559; c=relaxed/simple;
	bh=934UJESt4e3E/RFtZn5Nbjz4hY/GnRsvCkTLrK2/1d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CB41u3lvsF+YUFkuvS37pFXU0iXPMEAkajesXMTucdDbP1veVgBxu7e43MmxZCqyMHPcjfT52CkqxiNsBJhXyAoIOe+VEHOMeKa56wWBzAOZDBKcxuCNA6SPEsV+q3KSuP5lVQqjm8f9DFhsEclmWMS/7nof7+wLhYk23vOcEMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=khTt7NGS; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khTt7NGS"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c0006ea8eso24881751cf.1
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 12:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785784557; x=1786389357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dfkWyvd9IQQn4UBQnJJuAkB90tZ4A4dsGQWiFXSP6dk=;
        b=khTt7NGSryk0ZoHdPyRt0uSHJx9S2FdcLPKA6WomlsXddoa4IjNJnC2rhV4DYtugyq
         o5Ffngef/iwNZa8N8wmcwVYiRhYPkOybOx8Y9aWPk0lHT4TEXab8MPiKlkv7nKLvV4eo
         sABEapCshREZCLerkdH44C7w37+2jThAXL4YP7ZEh0OX6GkwvzWT6kgMIjiDJg3a31VT
         /JhLUQPnxtPaT7EFB1CJSpMbdiOGp2R0kqiGwggSUY7zK36SEeG+zws5qFK8avbAS8Ny
         LmTvNHP4iPmhHehU5zQziRviGGZuqtfBwBFR66BvwkveGfIVA+lMML97mEYoaLfnJEd5
         TtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785784557; x=1786389357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dfkWyvd9IQQn4UBQnJJuAkB90tZ4A4dsGQWiFXSP6dk=;
        b=ERpmz4DCsMDF4IvJTLSYU6yKWH5pZQ6VGabj1+iRNvqpMUTm/AXBd9sPlS++DByGz2
         Xk2Xj1602o1Wf2nFZO1kj4Ds051eMPpaAs3dzwSqpqm5gHeMldEdz7Qeizkk6oBkvA/O
         PJ4orGhxdTU8vRcy5E1+waETm88krN8vTxanWgWCppF+O60nXkYmKFTi1tEiMD1SnMA+
         /H6qmRwIHBm0ewqslw+u0Tscbe5Zkrh0iJ8IzG3uPFuRwSdqiTNzBMT9DpQ6xTDGeNYS
         XmsAFT7w9Ko58rLTjuZ0kWNTS2YEGuqSapJHfKGpInnQOuskXzxi1eycGeT5yYxicW+X
         zr3A==
X-Gm-Message-State: AOJu0YxzxdmAyUtC4UPamXapHYgv24c8bYtwRZQTuLTV60igvTKjoq1A
	U6U5kk40YbGJTgtJ3vVkFRAM1xvoZUgFDH7E+VK5AxlJx9n+Wkid0XLJ
X-Gm-Gg: AR+sD117EXU+69TP+6bBLOPZhplGFFYQB5pySPyTmSnKItf0iJy3lJLbBxVpJuaxUbw
	EFUDrMUXYv9PDpVq/PA2LV7LarwnJYfWGPW09vFI7Etp4tSIpcrKfhYYjURQk211WOAXRnGoh5F
	L1rey34pXIfwGRuG+6/KAFNXq/lvBs3UUebdnibCQZ/pOqR+AHsQSd7qP+qbCRCOKJvLCm9/Rga
	l/HSk4G9V5N2Rja5ArzyJ+OJk7XpvKNukV68wrjAUOYZcdOvEwYdh2NLctcm4zGHOdURlcYj4Bi
	rDJ3i3mOTb0H85KDpmNfnrzGWegJhuw1ikoy6vtxgSOEWso4No/zUAFwyrCbc4vKdtowAHtGKs0
	m0zsLKTeU+k6lcYggTWIeKTS+vsDrX5LZ6bNjyLUf/Wv5Ideot/2x+vmgUuj+QUP+n92Jtaevv0
	LSFScg+7ZvG1D95VFNe9IZeds1m5j0dB4APpdrq1wk3ywvuBMIDb72VmSDJL+a3Qknqb3ROU300
	ZwWrbY2jiZavsmtXfo=
X-Received: by 2002:a05:622a:2b44:b0:51c:849b:86b with SMTP id d75a77b69052e-52b567f814bmr198720081cf.43.1785784556495;
        Mon, 03 Aug 2026 12:15:56 -0700 (PDT)
Received: from achantapc.tail227c81.ts.net ([2600:4040:122e:7d00:f04d:e0df:fe04:e789])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm67803541cf.0.2026.08.03.12.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 12:15:56 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v7 0/8] HID: steelseries: split out Arctis driver and add Nova 5X/Nova 7 support
Date: Mon,  3 Aug 2026 15:15:45 -0400
Message-ID: <20260803191553.66368-1-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series moves the SteelSeries Arctis headset support out of
hid-steelseries.c into its own module, reworks it around a per-model
device_info table, hardens the battery power-supply lifetime, adds an
asynchronous status interface, and finally adds support for the Arctis
Nova 5X and Nova 7 families. After the split, hid-steelseries.c is left
handling the SRW-S1 racing wheel and the MSI RGB LED devices.

Changes since v6:
 - Rebased onto hid.git#for-7.3/steelseries.
   - The split now leaves the MSI RGB code in hid-steelseries.c
     alongside SRW-S1, and strips only the headset members from
     struct steelseries_device. The MSI RGB quirk bit is renumbered
     to BIT(1) since the two Arctis bits are gone.
   - The Arctis hardening that came with the MSI commit moves into
     hid-steelseries-arctis.c with the rest of the headset code: the
     hdev->rsize < 3 guard in steelseries_is_vendor_usage_page(), the
     battery_registered store/load-acquire pair, the !sd checks, and
     the hid_hw_stop() on the hid_hw_open() error path. The
     steelseries_is_headset() dispatch is dropped, as the new module
     only binds headsets. The battery_registered flag then goes away
     in patch 3, where the device_info rework guards every
     power_supply_changed() on sd->battery instead.
   - The v6 patch "HID: steelseries: Inline and simplify SRWS1 wheel
     driver" is dropped. Its premise was that hid-steelseries.c only
     handles the SRW-S1 after the split, which is no longer true.
 - No other changes. The resulting hid-steelseries-arctis.c is
   byte-identical to v6.

Each patch builds cleanly with CONFIG_HID_STEELSERIES=m, both with and
without CONFIG_LEDS_CLASS_MULTICOLOR.

The Nova 5X protocol was verified against hardware by
sp4m.an.joker@gmail.com, and the original Nova 7 protocol was verified
against hardware by colin@1101b.com. Thanks to both for testing. I
previously ommited other devices in the v4 patch series due to being
unable to verify.

Sriman Achanta (8):
  HID: steelseries: Fix ARCTIS_1_X device mislabeling
  HID: steelseries: Split Arctis headset driver into separate module
  HID: steelseries: Refactor Arctis driver to use device_info framework
  HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full
  HID: steelseries: Correct Arctis 9 battery calibration range
  HID: steelseries: Manage battery lifetime with refcounting
  HID: steelseries: Add async status interface support
  HID: steelseries: Add support for Arctis Nova 5X and Nova 7 families

 drivers/hid/Makefile                 |   2 +-
 drivers/hid/hid-ids.h                |  18 +-
 drivers/hid/hid-quirks.c             |  16 +-
 drivers/hid/hid-steelseries-arctis.c | 718 +++++++++++++++++++++++++++
 drivers/hid/hid-steelseries.c        | 366 +-------------
 5 files changed, 751 insertions(+), 369 deletions(-)
 create mode 100644 drivers/hid/hid-steelseries-arctis.c


base-commit: 2346d6997b70dae1f8302fd029aa422e28112eaa
-- 
2.55.0

