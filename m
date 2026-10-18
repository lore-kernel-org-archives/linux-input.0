Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062013B14A8
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 21:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359480; cv=none; b=V3tyzbJlsyLlYbFDqvytQFfftve0j5Vafxg2R8zsf6QTv7keTd6jgk821Rl1oz9yGd+0JSTmra+DkvS0TN14foRneiVww7MPTTqgSwX7tGGZhkSyfNhdAs1520iwtbJpk8zC+qumWkYMf3B+fYJY3TL30oLoxqydj0Rjb2CpJuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359480; c=relaxed/simple;
	bh=HL6sy/9BMxQ7NJK9XCGseGNtgUILeux6u1HaULOX+yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPQw9fAESHpMWsYY3pn2854ba6Uj+aM6Qed2y76ugNh77FGzhVI7729K/wOkAv74DG6mYsFslXts8kzxEFtDdI/dRiNpMGger0J150iADxJL4Y4YYTdljvgWWP2Uhxs7HrR9L2GYKsXWjlP6amKOt6iiphE42WRdcWOUT+NaiMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/wqiTCF; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/wqiTCF"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48df54150dfso1030082f8f.0
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 14:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792359477; x=1792964277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ikCv2w/Zs58X7MFrJqJ5mxFQIYl4HgRKx/LCbm2ro+M=;
        b=O/wqiTCFHAhwx4JAzShioKpzeJq7/ZLg78Ozz0UmFEwxZ4tHmLrMBNx9blklmTaTjL
         DXlCooijjtjlIWAs90wVfxxt/YP6zbQRkmKCDXGML0eqXWqoX4OVyiqTMnHLkP44FyM8
         MgtSdWbjYqMqiR79T/BmwtpZ2k3+p8DEXBVNgEKXDjmiwElLx41nSCYCSyVzpt2ZAI5u
         tWxEDY+v/cvCS/fS9FinK3OFkRFhz/QQ+0cQxtigcMy4qDyCa8R04Dk78VhiKWFbr6OW
         7Gbpb1IImeRjglgktpXTuCkSRd5ZnaHFsiW6mgwH+98NiA4qJR5bJDzkfXWTRxH0MIv8
         UICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359477; x=1792964277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ikCv2w/Zs58X7MFrJqJ5mxFQIYl4HgRKx/LCbm2ro+M=;
        b=rIndb6gQyuJXIJ8Rslbl21tx/Z8g6/vZvatv2/aYS164icLaihlt6lFxOTEtPl0fzD
         3M7jhtnwMgGAL8KmOhM3CiNLJ1XfxYNy3P3mxEb3wTFoUPYfatFElY0nT8H7lJIBfMrV
         /H72GW80RL0zLst43O9n2R1BUUoZIPE7v0sbKpW84ESUefQq4J6d2RnJa/1XSW1Oo21T
         MOSuTys4+VVrp6mTQHunyJmqjd7mU9K+B2vzRwR3j9ON/mP4kWgKHwRDWwSlEIL91wFV
         khqj6j0xoQnbzhTnrc/UK5TURDQ0spPKcrVgs0yJd+9G2YPI3ZxHUTcqnEyuQjrkhOZ/
         2gyQ==
X-Gm-Message-State: AFq9FYLuf3p4LDnWZjpG2hFXeri5ejKSJbvPs4jx56RMx4w5W4H+QdkS
	CIGDp1KQi/Y4Ch5A/nzr6WuGp+8fIcsheXh+I0Fha9+kj5EBCzDa43Q=
X-Gm-Gg: AYBFou1jCWn0/gcvcIxL17Eb47o7Zvbrt6hihp7KKwVWZl+f/XtsUJ07ttw6OmwlzyY
	CA+Z0BrdH5qYbBLhYeJ1azBbpMA9IIh2iWs5PUIKJvina/O7yLAaqAf7G6VXRqDW88Cz8WXUmIt
	SY7Ip+Y5T5A2pKxme/j+cCOgrrXbrOqT1Vj7Z7gbz+lALkkuHVZ9QAkYTJ+qy/Q9sCXaBSAjr/g
	Yfb7x5VvPZiMHGlM6iY/mlPs6drC96WDnXUDBw94vGOU1UBTDE9XTLSBjSxpK3WcGGElOhEeIWg
	GB8O3Hielg9fRimWY5vSJuJ9pRd0iFKBQv3jMCsGApCaDBB1vPaRa1aGiXqjvw49guYxMq6h4wO
	Wwej25Rky7dSfHU1Ct7YE1U2m+TrM5J8hmfOZgBHNX3WNxrnrbiBoO3E5aFHbCRFmV0SZOPCpOm
	iYrGsHewtiDXEhJ75qt7ruOfTluYAQgSSciN5A0yM=
X-Received: by 2002:a05:6000:2990:20b0:48b:11df:c496 with SMTP id ffacd0b85a97d-48e07bbffddmr7828916f8f.28.1792359476819;
        Sun, 18 Oct 2026 14:37:56 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd500e75sm18597841f8f.42.2026.10.18.14.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:37:54 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Masaki Ota <masaki.ota@jp.alps.com>,
	Rahul Rameshbabu <sergeantsagara@protonmail.com>,
	Johannes Roith <johannes@gnu-linux.rocks>,
	"Daniel M . Lambea" <dmlambea@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Zhouwang Huang <honjow311@gmail.com>,
	David Barksdale <dbarksdale@uplogix.com>,
	Don Prince <dhprince-devel@yahoo.co.uk>,
	Clemens Ladisch <clemens@ladisch.de>,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH 0/8] HID: validate report size in raw_event callbacks
Date: Sun, 18 Oct 2026 21:37:45 +0000
Message-ID: <20261018213754.1951187-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

Several HID drivers access report data at fixed offsets in their
raw_event callbacks without checking that the buffer is large enough.

Since hid-core invokes each driver's raw_event callback before it
validates the report length in hid_report_raw_event(), these drivers
must perform their own bounds checking to handle short reports safely.

This series adds size validation to eight drivers:
 - pxrc, cougar, zydacron, mcp2200, prodikeys: simple minimum size
 - alps: per-report-type validation (touchpad, stick, absolute)
 - oxp: per-report-type struct size validation
 - cp2112: size checks for transfer status and data read responses,
   plus capping the read copy length to the available buffer

Tristan Madani (8):
  HID: pxrc: validate report size in raw_event callback
  HID: alps: validate report size in raw_event callbacks
  HID: mcp2200: validate report size in raw_event callback
  HID: cougar: validate report size in raw_event callback
  HID: zydacron: validate report size in raw_event callback
  HID: oxp: validate report size in raw_event callbacks
  HID: cp2112: validate report size in raw_event callback
  HID: prodikeys: validate report size in raw_event callback

 drivers/hid/hid-alps.c      | 12 ++++++++++++
 drivers/hid/hid-cougar.c    |  3 +++
 drivers/hid/hid-cp2112.c    | 10 ++++++++++
 drivers/hid/hid-mcp2200.c   |  3 +++
 drivers/hid/hid-oxp.c       |  6 ++++++
 drivers/hid/hid-prodikeys.c |  3 +++
 drivers/hid/hid-pxrc.c      |  3 +++
 drivers/hid/hid-zydacron.c  |  3 +++
 8 files changed, 43 insertions(+)

-- 
2.47.3

