Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B75EEA8
	for <linux-input@vger.kernel.org>; Thu, 28 May 2026 17:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779991190; cv=none; b=BPVH910IPjpcz9BXR/HVgcOnu1a5PlbesA/cy0tese4GLopTLP5RpuA7+Jj4V6GZONjYdu9s7Lf0CBNyLDNl6mtJ35Ytm9l+roVo8igaqBpht71MObgZjwl+sv7ZZd3fvy7ZqckJYdryhqJyLtgIZebdxRyMWoCGOPl3naKUHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779991190; c=relaxed/simple;
	bh=E+sRLd242DfXEDi3/pzBi9WJhlW9gBpf472M530JMo8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDZMCN5W0cbUtWfDDGE0RAqi13wUmbw/JRQPhr0jm7l5tpW9iZhVNvQ3bW7PrpQKc3QR5ASIPMdCLTXP99aE5i4Y0Ej8kjcdsJ0ILzG/bCCUiiKn4oHFBhjxPl9sC3mY/er1487n17VtcVgVX2VgBdCX5QA6d11Kq7A0yvIaHMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S26t1rmC; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S26t1rmC"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8354461da74so6154546b3a.1
        for <linux-input@vger.kernel.org>; Thu, 28 May 2026 10:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779991189; x=1780595989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u3y0id5zqfx0L7OPAbGhsWl9L4QCfBZVh0Z4XwrQwPI=;
        b=S26t1rmCaVm3xEGkv5pz1p5pw6gJvyMB2nVLfjWh5lt1wZo5NXg7ydvi7fJp+crxmF
         wGuuS+e1X6zrqln0L5z+3RMxEnfhFCJiSoE56702pw5KopmBRmGAtOfQO+D4Ox3grOVh
         R8VpT+FLEqMZwjjPvbvsuHZqk1p0wI0qs/ljJ2ZRWxlj2mgjk3/nmtAw/nOu6n3XSFJM
         T34fql0AoFMMbDnx1dUnePkQozb4k0pnDh5TmYaH/FyH+5Ye5Gh5R1N+r2/AY+75bsEI
         43seTGA6iHp9iQvnelxS6dQsmqs8q2gL8NmCn+elpDMC5KCs6ts9bucFidoFnuYD21IH
         vdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779991189; x=1780595989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u3y0id5zqfx0L7OPAbGhsWl9L4QCfBZVh0Z4XwrQwPI=;
        b=Xs3gBOnfI3PtKxHTNKGlTQGmasXfbfiwXylg/n4opLMKIyblA3XtKlTqR4s5I5yrA3
         Oazj2dxECQ3+WghbtcFXdyeAZTYTTmrUmtOeBUxCkQZ3eAM7wQf7NH1nu3wg3H2c7yrf
         PWYRLlV9ugZjtE97ugMGrefiVyhP+xQDx9z1JfcF2pvcfVKEbRS/nwsdKj7wi9PFN9p6
         xHUfSTH0oXDLKpttATc01XbqpV+eoEbM1icqHXtDz8DGw81CjNWQTXo7jC3/tVwIki2+
         J4tYcAgr8XLhD/PZCxRX6u8kWBBxbv11pYB5vPIqqH4DSG1nvOlOzLFhCm7c9TzMlq8B
         yP5g==
X-Gm-Message-State: AOJu0Yw34DALAXNyuzhVMa1tHWzWrfrZ6o7mPfyyNvoAulaSPdQUUGIo
	h5JQ+1wwScGXtL343bCu0Rk9M9bK8erk9tSrL7UNJgvaLaP3fAbxKXBgypJy/2mLVAoC/w==
X-Gm-Gg: Acq92OGK5xHFD+jk7472pyfXKpE5uOHLNpiQbVmHGwYehm4QxDZU2/SE55D5YuKYQ0j
	QA85/tp11qonoASdnCHOMU2htujOGjpxrXDKzIJ9COQveTtHH6SFwm2Cmabudw5yeJb8aq9bHRb
	lIe4oOW13WPJtO81aHS+LAl2yx3Kz49FuMZLjFZpqOlu86wCsPkBucC99TXuddRR12PE0s6QD+M
	YXIXlf+UjlAZ6qn/SDuOlCnEjxzdwcBHKlU+FCVf2f9SDFE5wgWEWJASobHE+9zDg+B4/AMg+Zq
	qYZg5Wch98vrbg1ei0SuiEKEPOzCe51qLbfXp2vF2cqB2xAw44+E+yNzHuLUQS3T0NVRLi2Bvaj
	rfn2jJVn2De1ibJIihLvur+MevmVZDoJH+wud/WaMZmqF7E6J6wjZGHOpMbk4KdsiS2w0k0yRwC
	M4dZAAgzmIOIyCkLmFqlnrEdEJcjkXDlsh2+Rn4eqW12FSaUZ8vTiAPor8HJw=
X-Received: by 2002:a05:6a00:1812:b0:839:e27c:6cce with SMTP id d2e1a72fcca58-8420c1f58d8mr58757b3a.37.1779991189085;
        Thu, 28 May 2026 10:59:49 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d6eac68esm5749843b3a.15.2026.05.28.10.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 10:59:48 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Cc: jikos@kernel.org,
	benjamin.tissoires@redhat.com,
	stable@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v2] HID: wacom: fix slab-out-of-bounds write in wacom_wac_queue_insert
Date: Fri, 29 May 2026 02:59:45 +0900
Message-ID: <20260528175945.2987781-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
References: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_wac_queue_insert() calls kfifo_skip() in a loop when the kfifo
doesn't have enough space for the incoming report. If the kfifo is
empty, kfifo_skip() reads stale data left in the kmalloc'd buffer
via __kfifo_peek_n() and interprets it as a record length, advancing
fifo->out by that garbage value. This corrupts the internal kfifo
state, causing kfifo_unused() to return a value much larger than the
actual buffer size, which bypasses __kfifo_in_r()'s guard:

  if (len + recsize > kfifo_unused(fifo))
      return 0;

kfifo_copy_in() then performs an out-of-bounds memcpy, writing up to
3842 bytes past the 256-byte buffer.

Add a !kfifo_is_empty() condition to the while loop so kfifo_skip()
is never called on an empty fifo, and check the return value of
kfifo_in() to reject reports that are too large for the fifo.

Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Fixes: 5e013ad20689 ("HID: wacom: Remove static WACOM_PKGLEN_MAX limit")
Cc: stable@vger.kernel.org
Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>
---
Changes in v2:
- Instead of a size check at the top, add !kfifo_is_empty() to the
  while loop condition to prevent kfifo_skip() on an empty fifo
  (Suggested by Dmitry Torokhov)
- Check kfifo_in() return value to reject oversized reports instead
  of a separate guard

 drivers/hid/wacom_sys.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b35..489ca68f1 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -54,7 +54,7 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
 {
 	bool warned = false;
 
-	while (kfifo_avail(fifo) < size) {
+	while (kfifo_avail(fifo) < size && !kfifo_is_empty(fifo)) {
 		if (!warned)
 			hid_warn(hdev, "%s: kfifo has filled, starting to drop events\n", __func__);
 		warned = true;
@@ -62,7 +62,9 @@ static void wacom_wac_queue_insert(struct hid_device *hdev,
 		kfifo_skip(fifo);
 	}
 
-	kfifo_in(fifo, raw_data, size);
+	if (!kfifo_in(fifo, raw_data, size))
+		hid_warn_ratelimited(hdev, "%s: report is too large (%d)\n",
+				     __func__, size);
 }
 
 static void wacom_wac_queue_flush(struct hid_device *hdev,
-- 
2.53.0

