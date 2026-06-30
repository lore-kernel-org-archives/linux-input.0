Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5DD158DCF
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840581; cv=none; b=eu20+iKc6vo9n0ayu/JpNyQ+l+Nxe+loCyCGQIq3NcYh+gbbe4dgMQa5uPiqT+awm2N3VRXELbXD8Ih84YaBM6SiwlKLtKKO7pt1n4+O5uKj2Dr0uPucqddNqs86qoX84BoYfCcdWOut45dt0Cj6WD7kz9G93KdiUafXM4886ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840581; c=relaxed/simple;
	bh=14JXHDUov15sI4LmCFpwfcUzJJoRGPOo2nja8t2Haug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qmRv598PisYnT6uv9OXbRfFrdlYx644PH4bNZzPp0iFCWMJptbjNZule+fg5fFhaUz57vaErDJiWtGQ3wzr8a1M8GyaO/eiim8aLqP8mlWq/dCLLjT0Oj6t9iyo2YI/R0JBrwmy53bGweKxl/U66RYggVJiktY/A4vyTFhukpko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aRVc7ssC; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aRVc7ssC"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8f032b47e3cso18578606d6.0
        for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782840579; x=1783445379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zjcp730a59IfEeXDluRv9CB0OdLpPfJWTJZjwALmu8=;
        b=aRVc7ssC9UNW84kYl4z992yDl4me4DrWZks3A5hrNXtzAsg3/adkVaUsJRur1PlSe/
         6nKE/vYkpzrGFXlBiAUV6gedxreF8Bsr7nAP8RRa6vI/MozNQE8PMSpG6K+6/MsJZNP6
         2keVi8fF7+pqg4Fe6CwaLLjorwKHKiy5FlkAuuyGbRNJwbhdGtcrqOtxyt1wQR1tEg+A
         ZRHXpTqRKKc9Molmgk4TbPk9jiW+CKFtUxh1FIDm6SMVy1/Ro7C84NBQPJHnJ971u87O
         pBpbjFGodSUBGnmJ+ApjIIT0e47+3zD4tkdsAciBbNGLRNqhHu/qO9bgjpP4etUunHeg
         UgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782840579; x=1783445379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Zjcp730a59IfEeXDluRv9CB0OdLpPfJWTJZjwALmu8=;
        b=pld7cHo5h4fS8gBNaTQSHw2iyCU7iQuwg6lvNMRVXLuy0nS//zLMNhyQ759tXaRIo2
         8TjMBnSL1WdnUwYY0ZzZbZtLEkeMUc+BDV7qh8Rix2tH+iD8J8CnSAfFo7IfoIwRcWIb
         QaNQWBTfC4x3ziQMSOCHm5vMNdslOgfG/nA+Mh9mRqSI4u8lgoaKyVHVekmA/ucRhYnV
         LauRYt7z4Z0rllOwwgLCBley6mLCIkBava6O7d6f1m27fRtYO8CDZ0awuMtcskuBWoXU
         zUSrYgTa1ylifcFl7H+CntyuamKJLogsQd4Bm4n1o9T/8P9/xGW79bAM83JupozmXQRI
         pFWw==
X-Gm-Message-State: AOJu0YzPIFYDelZ6IWMVYH4cevDV5jU1Ko58EI9sUZgB7viSG2GuemQ7
	TpKKPEsUNx2+3MsUaU+H6vLvczo0RD1yDyPd+J7jNbyyupPxdaU2gmf9
X-Gm-Gg: AfdE7ckKBKKTgxXoVYTbHzEwOCJ6UKWIs3NUanUBtZA35dTgRobyGnUZblCmixvfkTZ
	E0HU+Y1ikkVRhHfCpK8wVcSKixDSxzoIYaRzKc2CLEp0Rn1/an8jto79BfHRQVi64jkwxlm+1u5
	yy/ZZAicw1+VS3z+xNOKnIeXIGw55fWIAh+5ivuk5knn2/JvOijHXvnoEumEfKYnJB+7W4KYIX+
	/cJEjXyTg548Tdmth2Bppjwp3VtSa2o7rGsMAIuP2rGZANtOeabCZ+xZEYl4JX7B1jDpBwenTs/
	psVcvTQpdIaNTY9KUWwis4TC5HIQZBauqnkUCFMloM2yjkEtkhQN/BIA3ZZBHKq7+MTDdw2pY2b
	nf6/4BXoTrx3cR2qUp0fMlA5qYNHBy4Wxl6DsdGNZ3sB1ciwf118/bTC5LCFH8OaDki36GQgYQM
	/Nop7YVSciBXsc4DOElVOGN2WMskCmQL1D8ripqksAObNPQP2P
X-Received: by 2002:a05:6214:5901:b0:8e9:f62b:bee8 with SMTP id 6a1803df08f44-8f1bc867a9cmr76677786d6.56.1782840578671;
        Tue, 30 Jun 2026 10:29:38 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:122a:dd00:da6a:a6e4:2464:e6a1])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32cdsm29822906d6.31.2026.06.30.10.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 10:29:38 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v5 0/9] HID: steelseries: split out Arctis driver and add Nova 7 Gen2 support
Date: Tue, 30 Jun 2026 13:29:21 -0400
Message-ID: <cover.1782840133.git.srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
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
Nova 7 Gen2 family. After the split, hid-steelseries.c is left handling
only the SRW-S1 racing wheel.

Changes since v4:
 - Refactor: send the Arctis 1 and Arctis 9 status requests as output
   reports again. v4 regressed these to feature reports during the
   refactor, which can stall the endpoint and break battery polling.
   The now-unused feature-report helper is removed.
 - Refactor: the Arctis 1 parser validates the report length and the
   0x06 0x12 header before consuming a report as battery status,
   instead of parsing every incoming report.
 - Refactor: the Arctis 9 parser only reads capacity/charging from a
   0xaa 0x01 status frame and treats every other frame (including the
   0x55 "no status" and the 0x03 "stale" replies) as disconnected.
 - Refcounting: register the power supply into a local variable and
   publish sd->battery only on success, so a concurrent raw_event can
   never observe an error pointer.
 - Async: publish the sync interface's drvdata only once the device is
   fully initialised, so the async sibling never attaches to a
   half-initialised or failed instance; the probe error path is
   simplified accordingly.
 - Async: the sibling lookup verifies the sibling is bound to this
   driver and takes a reference before using its data, guarding against
   type confusion and use-after-free.
 - Dropped the standalone "Fix whitespace in srws1 report descriptor"
   patch from v4; it was unrelated churn and the descriptor is left
   untouched from upstream.
 - Rebased on the 7.2 merge window.

Sriman Achanta (9):
  HID: steelseries: Fix ARCTIS_1_X device mislabeling
  HID: steelseries: Split Arctis headset driver into separate module
  HID: steelseries: Inline and simplify SRWS1 wheel driver
  HID: steelseries: Refactor Arctis driver to use device_info framework
  HID: steelseries: Report POWER_SUPPLY_STATUS_FULL when full
  HID: steelseries: Correct Arctis 9 battery calibration range
  HID: steelseries: Manage battery lifetime with refcounting
  HID: steelseries: Add async status interface support
  HID: steelseries: Add support for Arctis Nova 7 Gen2 family

 drivers/hid/Makefile                 |   2 +-
 drivers/hid/hid-ids.h                |  12 +-
 drivers/hid/hid-quirks.c             |  10 +-
 drivers/hid/hid-steelseries-arctis.c | 643 +++++++++++++++++++++++++++
 drivers/hid/hid-steelseries.c        | 406 +----------------
 5 files changed, 672 insertions(+), 401 deletions(-)
 create mode 100644 drivers/hid/hid-steelseries-arctis.c


base-commit: 840ef6c78e6a2f694b578ecb9063241c992aaa9e
-- 
2.54.0

