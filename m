Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE113377EBC
	for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 11:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789904400; cv=none; b=DxMPZZJ+4YEpgsu1aA6WrgwO9Hq0/xqbYiyLbrrcGYQW0sqcctPnLOnd4PvxVPncBcjqT8Grb5C9q5eKlI2ncoMta5SFfaNopDdMZGvrZICoattoa79lkocmEfDfRL8bB2LZJxvmjDMMw3j0iIRUkTiwrGZdDAGgMlfd6W4Yx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789904400; c=relaxed/simple;
	bh=yz3jCQ+G9ritM+0QYRVsGG5LlnZv6QqLJOt/G6kBde0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X8EDoaHz89LZZmUmV/CKo7/zTt+kg+lHjGvILC+XU+LvpAcjYikMcgd1yEClqxyqjPmNbmhGtrdAiRgcqAuNcNE5lV2NXH0cU8jI0ybxWYRKpnJ3EIcB5hQf1PUCoippGmGC9BVEbIuVBYL9Sd8/JR0gnZc6wXlBw/tArLzFKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFhgy91O; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFhgy91O"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so1868496a91.3
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 04:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789904396; x=1790509196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hh2u1s7hlbDfnebkD4E7jjtOwra5qng6se9Ex4k64Kc=;
        b=nFhgy91OnP9/SJWHGI95BZZ6ednf3ejCWLLciwbtgHCXLLixk40RdR4fPicahDfz5J
         9ommOuc04liErkGdgWuYFo7csQc6UXvaJNEk7lFeubnYfaBe2Cc/fW+DKhdDj5QweVDp
         Pp1raelc6fNPPT2Hgwwg98mxnRkQO2jQ38DxUvLlE8vQRDG5JhQFjNHdyvTmyHrAU2FD
         UUgMzvTQPmj0r9vUS+ZnID+3PmblMxFgMQRah0LSLTJwqXhVMKkXaflBwvzN0aIFcklg
         siS9Q4fux8GNeeA+TiefeZkPiGJLx7GEo9p7ZUuvSDprwxYnXn/X3EFsU1wmwXaWT6j2
         zsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789904396; x=1790509196;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hh2u1s7hlbDfnebkD4E7jjtOwra5qng6se9Ex4k64Kc=;
        b=Aqx8GcX+7JC1kWlakIjUbfECxPLIZCYcikMMl1VYpv+e8G2GaDEf/csV/rFK7K4F8b
         o1Q5PnCkt6rjGe2mPETB3tETskBlVmZQQJt55Lb9adowOi9UT3UB28EjzAVo93ecnwXo
         mtf8zzF8L9h/NbPP6XxBgUxoX+kZtEhTrEJa82FVasmQfx1a/O1shdwCvpVQSqEXsOP+
         82DDVDH7LRrfmV0oqqbRJP3xT7VVWBy3emyAaMWCTGUPOkPpYAoyjUDJEFRhBHMylcKI
         8sWciuV/KRhF5EPRLMvzZjIwjgR0w/Jsr7voB/l+Z4eTxCrbLC36NXDAb2sYqiUTMPLK
         oGEg==
X-Forwarded-Encrypted: i=1; AKwUvBwHlFDBPTL1W43utT8/3l5kt/kdyxqVY4cKrEQyv208XE2kuQOiFQwpt/AnthVqncYTU/otjB0Ep9ujQA==@vger.kernel.org
X-Gm-Message-State: AFuF++kYKtfvQBfcUg4ekNy7BP0cSpTvTfHmg5rRANQJb51MR5SRyIi8
	IUMTYxjgx6NqXPVt9OYEyj4mWgVmHVY+UQBl+wMD0D5P7x0d6Ut7DEkP
X-Gm-Gg: AYBFou3vHmbCx2Gli01BRlsrIfM9JbRYDdl13DgEg95dKPKNl9Mhaj4uGxqoeY2Za8F
	g06XWWuMjkleJJsPh0WGssoQHCZQZ3hex3b1hH/kry5gBhMbI5rK4mwR9Z4BbY0oiUTsJPCeWVh
	x3kZdjR4Amyto10IT92ddI8TvY+fm5aLZlz+uiQLBn7d5lPD2J7Fk2XWmw6pglrXx+T2K9YlEQZ
	sNxiykKxOfb1PKhnTP74T9PBxEY+CBiw4bFfPlw2jUiIvJTL+UxziIE2dx5oApAdvg9oo+jJt/9
	Sr5Pmt/a4UAJNyK1seRgmQ7bRF5DQVeE6uOtgUCYlDSsmiBP/dPl9b0ItGFxZF1R0YqIak2a+9+
	mW0fRMvhrGxYkyKZ4t6kSj7IEwJ4Fid3NjiIIfv4sPafCo/KHu5XLFDsBwk9MreeXsY0Ht2LVGN
	yYz9WQyCsifT4RioeBCp3Uu40lmYOVhF0j+9y6KaQwkMoE+uUJXgx6jy71neYP9ceuuozP/BKM/
	kcJmytMsYTSzpVnfuslSkaRog==
X-Received: by 2002:a17:90b:390e:b0:39e:2e7c:d43c with SMTP id 98e67ed59e1d1-39e54b66b6cmr11973998a91.7.1789904396266;
        Sun, 20 Sep 2026 04:39:56 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:2022:c2a9:de8:d005])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm8490548a91.0.2026.09.20.04.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 04:39:55 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: floe@butterbrot.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH v1 0/2] Input: sur40 - fix UAF/hang on closing the video node after unplug
Date: Sun, 20 Sep 2026 18:39:47 +0700
Message-ID: <20260920113949.12726-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

syzbot reported a slab-use-after-free in vb2_core_queue_release() [1]:
closing /dev/v4l-touch* after the SUR40 was unplugged reads freed memory.

Cause: sur40_disconnect() kfree()s struct sur40_state, which embeds the
video_device, v4l2_device and vb2_queue, even though a video node can
still be open. v4l2_release() and vb2_fop_release() then dereference
freed memory. Patch 2 fixes this by giving the v4l2_device a release()
callback that frees the state, and dropping the disconnect path's
reference with v4l2_device_put(), so the last close does the freeing.
The probe error paths never expose the node and still free directly.

Patch 1 is needed first: once the state outlives disconnect, closing a
node that is still streaming hangs forever, because
sur40_stop_streaming() waits (vb2_wait_for_all_buffers) for buffers
that only the input poll callback completes, and that is gone after
unplug. Returning the queued buffers before the wait fixes it. This was
masked by the UAF above.

Testing: no hardware, so I emulated a SUR40 (045e:0775) with raw-gadget
on dummy_hcd in QEMU with KASAN. The reproducer enumerates the device,
starts a non-blocking read() on the video node (making the fd the queue
owner), disconnects the gadget, then close()s the fd.
  - before: KASAN: slab-use-after-free in v4l2_release(), allocated in
    sur40_probe(), freed in sur40_disconnect() (same alloc/free stacks
    as the syzbot report)
  - patch 1 only: no KASAN, but close() blocks in
    vb2_wait_for_all_buffers()  [only meaningful with patch 2 applied]
  - both patches: 5 consecutive enumerate/disconnect/close cycles, no
    KASAN, no hang.
(The dma_map_sg WARNING during read() in the log comes from dummy_hcd
having no DMA mask; it is unrelated.)

Nguyen Ngoc Thang (2):
  Input: sur40 - don't wait for buffers nothing will complete
  Input: sur40 - keep device state alive until the video node is
    released

 drivers/input/touchscreen/sur40.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

-- 
2.43.0

