Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B435B653
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 15:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097319; cv=none; b=d0aIHudb7ZKGwTtMp67TaLapC9/BqKbjztBX8w3QZMbD93Hh/yV4DAN6oByTu3Mqm7Tb0GGIjWkNwg0PV17hPxYM+XptoE3+fcddPUFkX/40u9V6YkliMesTPEjuZ3m+O/z4HkI2c1+c9WRy3opyWGZvSzGIu5vigDU1SR0vI6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097319; c=relaxed/simple;
	bh=1lJiiqWoJdn86LEsDUwKr3hpmoTFDu27DtAns1UCABk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaSvAs2OIlbOqe62BmpD9nmb4saJq4sBNxMHjLH6dmkJpiVbB5NuYYCjqhy5eYd8F1qmrqgX1ayLn/bif4+Ioob73jj0pWFNWT82yviQh3aoDFSIFPEOCMdEhkarQX19YQNCRZ+JtpE1ob6zi6Wp5CITUjGuD4E9llwJ8+6Vl/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih16WRW0; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih16WRW0"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12331482b8fso458344c88.1
        for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 07:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097309; x=1769702109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iTnCx05EWycA27LR6+sAdSVg/yTmd3i6OMWgoqxWzqk=;
        b=ih16WRW0cv9YjOZIbz2XI24d30Af2NGcOuJap7sybeUGYVwdjQVF7GNFrK55T6mVJX
         qdQG+xmG8TfMmYgt/zAn7CHi8rREmmzW32dHazaoJdMxBHtsLG4e/zJW0wGFMhW25kFL
         qYRVSvebKiOrTz7pxfVafJRS5Nv+bVkM0T1/FSEFw442aiXO6HqUywGrrGaKpZdNOpn/
         MWLzEF9AImYKLjh+l9kFR8IAi0jtxUbfEbtrlVQ7gJ6Y1Bip9R2bZ0HiDoUNuZSpbAcf
         UWU3AywwQcM3ParyEgMp1E0CpfL0Q16ZJk3u+bCGPnx1RjRgYAG2sBnUDDeGwQSCMwTe
         M50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097309; x=1769702109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTnCx05EWycA27LR6+sAdSVg/yTmd3i6OMWgoqxWzqk=;
        b=ptJF9Ezt6cBbk+xiuY4sYKSTOQxB1LIurbCe6Orv7xeDMV8RMiyV2o7tR9d6Fwzth5
         zKDEn1q509f5yIOKWvym/Tmn2VoDGHyAQZ3QTpdjdC/6dTiSdx1qQRcRfx4I2VXDPwfD
         +YtTkxH/3sNmKfNuG2kvLWzUOLefUmTPwUR7Q1w9Em9pffNUgccjKaDnQBZr7GKatvlm
         EAA8njsFPT77ed/tssOxw1tZgiabgdh51cE+MCyoQAdbjnqEfAdtQ3vmatBw75KLWdYZ
         9nqFTpgm+aR0mdOENWs0nPQY92B8lB87mKY2DZzQEM27JkcnSaENPzXfk/U55nXH0wmO
         7ThA==
X-Forwarded-Encrypted: i=1; AJvYcCWnsfi9tDQSXA1rJzuvxGhMq4DH6Bv5xtZQehI4OAtvN1bKQfFh/woZwt8NjBOcFeQskGUHXZGTgOVvQA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4amJhuUACg93m6x+YXDPeNQ0oXAMGde5WXhNBB3sB4AEwC/PU
	FpFNogpXPDPwY1ULJs7Pjh32t3QJ7Vs0kO08MD2DYowOjrCPm1LxNSjn
X-Gm-Gg: AZuq6aL46/LDJcG8g/ZXTuDGYUA7gPe5ecTpNUmmQXQusRi1kJTcJ5fdpLSwdaMJ/lm
	wbS1Di0wLwxSFoh+qtJAd8hlpN+QYfQ4iSBkHUugNjwXjIJFq8lL9yjklM5P7M775y6jAg85TK4
	7SR6A48Wv8RUW7GNy6UOymvdGtDKYB29AjWuP/E625fRKzR6mvPbP6fgBke9McsTWyWpWI0ddKK
	0zVUGhqrYCFjCKTAzvxta4pt2Nbr4kYEeUyCA1L5XMcu1xqFzm53nRYTRYI/xWwzyeumal/759w
	5FX9t9OaEi9VOcG3/JwYK4coGU48yy1odve706qyq45dc7DvyTmway//OWOvDwygl/9FuHMScfL
	ZKgFcCqK0YleI5yMVUuKDF88BY03pIV8gVJ4AlSUtfmLBQyAKPZlmUMEA0JqFwU1X8Kqz+M/IrH
	ffRd/mA2l0g6MbMYGK4m7hK/Rnbzxx3awwY5b9PhaefR5JKgYJN5l4
X-Received: by 2002:a05:7300:e8a2:b0:2ae:5d5b:4ed0 with SMTP id 5a478bee46e88-2b6b40d9dadmr16548799eec.21.1769097309215;
        Thu, 22 Jan 2026 07:55:09 -0800 (PST)
Received: from gongqi-WUJIE-Series.. ([38.90.16.207])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b367cbc9sm28935599eec.32.2026.01.22.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:55:08 -0800 (PST)
From: gongqi <550230171hxy@gmail.com>
To: rafael@kernel.org,
	dmitry.torokhov@gmail.com,
	Shyam-sundar.S-k@amd.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-acpi@vger.kernel.org,
	linux-input@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	550230171hxy@gmail.com
Subject: [PATCH v2 0/4] Add quirks for MECHREVO Wujie 15X Pro laptop
Date: Thu, 22 Jan 2026 23:54:57 +0800
Message-ID: <20260122155501.376199-1-550230171hxy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds several quirks for the MECHREVO Wujie 15X Pro
(AMD Ryzen AI 9 H 365) laptop to fix issues with the keyboard,
touchpad, power management, and headset microphone.

The laptop requires:
- ACPI IRQ override for the keyboard.
- i8042 quirks for keyboard/touchpad stability.
- AMD PMC quirk to fix spurious IRQs during suspend.
- Conexant codec quirk for the headset microphone.

Changes in v2:
- Added Missing Signed-off-by to all patches.
- Wrapped commit messages at 72 columns.
- Unified author and committer email to 550230171hxy@gmail.com.
- Properly formatted cover letter to improve threading.

gongqi (4):
  ACPI: resource: Add IRQ override quirk for MECHREVO Wujie 15X Pro
  Input: i8042: Add quirks for MECHREVO Wujie 15X Pro
  platform/x86/amd/pmc: Add quirk for MECHREVO Wujie 15X Pro
  ALSA: hda/conexant: Add headset mic fix for MECHREVO Wujie 15X Pro

 drivers/acpi/resource.c                   | 6 ++++++
 drivers/input/serio/i8042-acpipnpio.h     | 7 +++++++
 drivers/platform/x86/amd/pmc/pmc-quirks.c | 7 +++++++
 sound/pci/hda/patch_conexant.c            | 1 +
 4 files changed, 21 insertions(+)

-- 
2.43.0
