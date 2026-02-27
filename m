Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F262309B2
	for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236248; cv=none; b=TCwDAh/SdoVF2I8FEffdEcllZ1beWkKMkcitoyaEVEqjXyTwiwnOYCoY4l+ph5waAI4IukIrYMp+NJXOpucRMdjFvJyNStTSY+m1GfqHlPcZWjt244ahpNdC2vTvXyGrdC+Moc1XLF7K2F2NhzJoE7r+LVkkBgHBX9OviAkq47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236248; c=relaxed/simple;
	bh=tvsaE8oDJMP3Us3bUGSY+dDHixtNwgMGFahQ1PQs/xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uVOSWRHfPY9PjTfAO2nlwP8xCNU8ybKzoMLXNhlAvf7fxRLSML/Rf7UXZ7yD0nB0xGYpLUTz5+LJSMEQa6nnKeIB8TjB5eKo76+3AtLr9mTP2qg6S+k/RsbIWWzxsUk3nOnGlbUuuW/b7Sl4sNcN797sNezCxjPfAWVYRZkA+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kn2snoaq; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kn2snoaq"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-899b95707afso35271386d6.3
        for <linux-input@vger.kernel.org>; Fri, 27 Feb 2026 15:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772236246; x=1772841046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qnyMqmi7XMPdB/O3WgWO/nTTp6gIAsqN0U2NoURxkQM=;
        b=kn2snoaqSsyREE4F7/90yl80z9m6vdfSCPSnsoefHL1866uB5ld5QKXFx+Wq40pZcI
         O5btlxY6nlwYvJqePnnZqToFUxB6y57+pwidqk0d8P0hZFnymm3HHdwmERlwFrK8s/Il
         2wQk4u3ptJ1KDKzpAXd6tBfsAjJ3M7T3qjhY91RaqAjpKb4HYlhkjxIwS9xylvTGbdYI
         eP5jz+VW4A8USybRRf+tHM92Sxo9dTbFyj1ec+ej/ZasJA0rR0JXaUedQAaoyRIhdDa1
         UkhxHFJiCNiXmt5NipVlr9/2mdko73RzX9Dz+tQGyzQACCGjUTrkw0k77kGgR8wiHEG3
         5x1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236246; x=1772841046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnyMqmi7XMPdB/O3WgWO/nTTp6gIAsqN0U2NoURxkQM=;
        b=RSHOpwYmRR3mRV086sk1/CMDAleWoOptfs+Q66gqnO94qcozKttNQKcS7Cssp1H8BD
         pHrxRcdbU8NoK8H8meK6diPcd2o15Yxxl0CcIz8Bvah9I2sxldizdb2mnmpT2HTNL5fj
         CE7k2JsHJESHZMNwE2roGmerk+a9Ku5/Z8LYThIKwukPtksyrocJYpFzwbGIPuDlR3f7
         xnMXH7SFMeMLqDzoh0Xp7jKV6xo2gguUhMhkzC825lYLgfCZd7AV609tdR8+Vy/QQcTd
         29r0o7RhMRhnOJinv6VxKbn0X6g1Zxh+fEb3wVZ6iR6kYvTJbyUKJuFz5Q1D2823+dRB
         dhiQ==
X-Gm-Message-State: AOJu0YwHhFX3gNcsNMaVw8lhgFl+RAEsGaV8o0AkMkQKW6zkx9m2aq7g
	MZR7pipD1gjiV54FWTl/ki7JWbyaqaXeFTPa9oLaQ3IM9VuwX8mdmOnH
X-Gm-Gg: ATEYQzwzj4jLgrFVsFl1R2z5A79zhep3UqZBJlyhj1FMvrK5Rr2q1k/Ex2OTthWCE41
	BiZOpOtmtcVvAJt29tNPhtntsKHoacbbNgVyhsVZ0dA3mDbEA28n0Dej4eaE2ZKMD+Iv1DNq0hP
	cWS/V2GNQw5fbb9w2hNeoOMwtD8qyGUqzoUYNGyM+ksAkNEicwGUtQmbjEOHEbPnFKbs+h99bYL
	PkdBaukOp0BT/N/1SwPiAIQxErWamRp8Kx0WKZQ/1iKc+QQygf1lcwgh8l8xud4k9RasnobmJ0i
	eWI0BtRwQFOB1kuF6YroEWNLe3dAsuWVp8pDYv53+EL5mvFg/mIVeMXJut4+s9mwz1l3lbKGh7N
	8dyH5dmuVpk+QZpc5lYZGCo4sKkkP87uWBCCKddS4faQqA4qNzWzzrYfgKegjGQUjTnrb5qEJMz
	ric8ejq/7tVgiklnSX/EcA/BdKVXXD2BGVbBNKvGzIfzrN78v2sA==
X-Received: by 2002:a05:6214:4117:b0:899:af01:c2f7 with SMTP id 6a1803df08f44-899d1de4313mr69646396d6.9.1772236245872;
        Fri, 27 Feb 2026 15:50:45 -0800 (PST)
Received: from achantapc.tail227c81.ts.net ([128.172.224.28])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c715a87esm52397446d6.4.2026.02.27.15.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 15:50:45 -0800 (PST)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v3 00/18] HID: steelseries: Add support for Arctis headset lineup
Date: Fri, 27 Feb 2026 18:50:24 -0500
Message-ID: <20260227235042.410062-1-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds comprehensive support for the SteelSeries Arctis
wireless gaming headset lineup to the hid-steelseries driver.

The current driver provides only basic battery monitoring for Arctis 1
and Arctis 9. This series extends support to 25+ Arctis models with
full feature control including sidetone, auto-sleep, microphone
controls, volume limiting, and Bluetooth settings.

The driver restructure uses a capability-based device info system to
cleanly handle the varying feature sets across different Arctis
generations while maintaining support for the legacy SRW-S1 racing
wheel.

The driver also sets up future support for async device control which
is currently implemented for the Arctis Nova 7 Gen 2 and Post-January update
Gen 1 devices as implemented.

Tested on Arctis Nova 7 (0x2202) and Arctis Nova 7 (0x22a1). All other
implementation details are based on the reverse engineering done in the
HeadsetControl library (902e9bc).

Changes since v2:
* Expose audio related controls via ALSA mixers
* Implement async inputs from supported devices with known protocols
* Overall code cleanup and improvements to initalization logic
* Fixed several logical and protocol issues for Arctis 7 and 9

Sriman Achanta (18):
  HID: steelseries: Fix ARCTIS_1_X device mislabeling
  HID: hid-ids: Add SteelSeries Arctis headset device IDs
  HID: quirks: Add additional Arctis headset device IDs
  HID: steelseries: Add async support and unify device definitions
  HID: steelseries: Update Kconfig help text for expanded headset
    support
  HID: steelseries: Add ALSA sound card infrastructure
  HID: steelseries: Add ChatMix ALSA mixer controls
  HID: steelseries: Add mic mute ALSA mixer control
  HID: steelseries: Add Bluetooth state sysfs attributes
  HID: steelseries: Add settings poll infrastructure
  HID: steelseries: Add sidetone ALSA mixer control
  HID: steelseries: Add mic volume ALSA mixer control
  HID: steelseries: Add volume limiter ALSA mixer control
  HID: steelseries: Add Bluetooth call audio ducking control
  HID: steelseries: Add inactive time sysfs attribute
  HID: steelseries: Add Bluetooth auto-enable sysfs attribute
  HID: steelseries: Add mic mute LED brightness control
  HID: steelseries: Document sysfs ABI

 .../ABI/testing/sysfs-driver-hid-steelseries  |   87 +
 drivers/hid/Kconfig                           |    5 +-
 drivers/hid/hid-ids.h                         |   35 +-
 drivers/hid/hid-quirks.c                      |   27 +
 drivers/hid/hid-steelseries.c                 | 2329 ++++++++++++++---
 5 files changed, 2184 insertions(+), 299 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-hid-steelseries

-- 
2.53.0

