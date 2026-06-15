Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD6C23535E
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 02:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781489178; cv=none; b=bKhnV4fPKIV1ehraGv4tpccAJ3dX5xY1LGYPq8fVEVHZQ8XN9gH3c6f73WhQrjoAtQHSaQg/SFfmfwWZBXKrunG/rfPnTkFNWeOCcrzGPUv5DKlMZwvwM4prprmQXC2Q8moPQbcJxY0wbSueo/7Ks+jrW0YPAUzV0xBOyd7ALP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781489178; c=relaxed/simple;
	bh=Nr3+Eog+HOtA8+4TaO18r4FP6TRleABitCVf50W6upU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e5zEE3GhvAK+4lDLMbRKPJ894KTnqjcXKKd/gwnz6yyClu1wZHitKSXn0RArfQK4ipBhMzPJ9rvxKfR4LBWP0PAXf0i3+kNor7SzKq+G/qFSKGyxQCy5Bf2iTT8IuJ8LDM28Uxaqv4iBcSWWUIWNj3Ne3wiAunJ187JIbG7/gdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UalHMVzF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UalHMVzF"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8d18de80b29so39709316d6.1
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 19:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781489176; x=1782093976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WFs5nbccNjAJMlGd3A3uFh3gr9sEFHghkIjgIcOwGHQ=;
        b=UalHMVzFbTpcXpAKqEVlXZjQpFiXkZibePsCnqS6KI4BnBS3Mws3ApciN3WwJY1aKL
         6RSBQaRD0E8LWNE3tgLrxOMQn4ExM0ogPDZJq95942GCs2ig3EE5he8fkgmpwTlRNkeZ
         HOlnD7z4jZidBa1UlntHf8UlzKz+S4GeHbWirL/0TRXzRHYT6CTFqU8hWgK2XYYsrK2V
         QXVbnvSzib+necev+tpGUqc9WE945MY+ddkGKx8VzjeALYDhAY2GAgcV1FimyUFfJQix
         gGotF+7r+ahSjzV/UoDFPy6HFEiSGkvoukv5kvPxWc5R9QTf4TRPdbewPffFTTovzaoq
         K2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781489176; x=1782093976;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFs5nbccNjAJMlGd3A3uFh3gr9sEFHghkIjgIcOwGHQ=;
        b=bx1CuZ7XTRl/awDZm3u2Xd6Oax0Mu+iyuN7JIm0pc97Dkvm7HbVfcMS3H9XxUiIbGe
         WMKmb4TMM/mpukFwQ+BtRtH0Frn7eCNZ1Kcyn1cdsye/cHIAzpmktKnflYWRaZJJNfHn
         GcnzkF0m1XkTT29tsRWMAl9BuyDhH8U5QhSMh9ALd2xN52IR60qNK39gpL0RTYlKpNdR
         ZWo7BLoBSCsh12DLbNdl+lDRZ+BzLKFQ5josR0s121RY48SgnmQOs4PQ0623H8dglS5Z
         DgsVWO9oJag2EU23UJkfvVp/bPVBKvpFPchIS9j+N01KZAqZV3+YG59bkMwVlvQlERAc
         hMtw==
X-Forwarded-Encrypted: i=1; AFNElJ9CjMo0gVgELGZdoqTsnHWDdyYDBsfAQZDIfDgD1HFaxgdrpZurDN00oV0jcbLVeFUnwVdVZaUlBx58hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycYqAazso/d8oCdfsp8pdLHy1vse1nnh+cjkyzzJC5/uYMcD0X
	wHWhs3ZFfPGYmbgKdHrGGVFdonhd5El90oKew8LPtVa1XIpqz0CNZoQRoNoYNjaxP04Few==
X-Gm-Gg: Acq92OGBqAGw8Ufkk3MYo+/iHFdQ8KJPSxAGAI8ODzrjkziwxjf/fpEdNACFAUgbpPj
	i+eTPemFOxgjVErUEK8TR/iowUlW7w9w7lrSXFgen2ZJa0oCwpspOTqXTC5NmB/eQHK7yiG44mx
	E2k9EJZrMLoAMmMt2fvczo99cKE8cxJiXuFxJBQKFSyPNBtgu1h2YcrGEf4q7/Sm13kO3EFX4E+
	wz8i63wAtee6zTt/FIyOh0lZdJdpVtqDDZGTf36Np6D/yoPP7/cjrIHSv0o1Cj7kHexVJKt7eFm
	gClqrivHMdi6qjiAj2HpxAhLKN4TGWcT++CJ8CesP97n7S5YZVJGw15U+7il6HyJIRkmRWvN7e+
	lxm8HMDZHktY/0mOs+v+CdNI0OtenKi7QFWK3SCT3XpqzLFOfhZH4lcH0IpMh/zTX5KtWHycNrQ
	cAkm6jV9mSs08YnQG8g9DpaBlDI34Ai8P9Gz8qFoKSI9J/1So2DJr+b60JHFdWRkaIle00Og==
X-Received: by 2002:a0c:f00a:0:b0:8ce:ab75:9d69 with SMTP id 6a1803df08f44-8d3166ca688mr153860276d6.21.1781489175784;
        Sun, 14 Jun 2026 19:06:15 -0700 (PDT)
Received: from localhost.localdomain ([2601:985:4601:5df0:2106:6ce9:6b1:8f70])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301f19b20sm96789996d6.19.2026.06.14.19.06.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 19:06:15 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] Input: sur40: KASAN slab-use-after-free in v4l2_release
Date: Sun, 14 Jun 2026 22:06:14 -0400
Message-ID: <178144969601.60470.9256616923389083658@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

I hit the following KASAN report while testing current upstream kernel.

The issue was reproduced with the sur40 driver. The report shows the object
being freed from sur40_disconnect(), then v4l2_release() accesses it when the
held V4L2 fd is closed. I have not confirmed whether this is specific to sur40
or a more generic V4L2 lifetime issue.

This looks similar to the rmi4_f54 V4L2 fd lifetime report I sent earlier:
https://lore.kernel.org/all/178144969601.60470.13645789994911690209@gmail.com/
That report involved rmi4_f54; in this report the freeing path is
sur40_disconnect().

KASAN: slab-use-after-free in v4l2_release (sur40)

I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/40c7b5bde2a7b2ddf95981beaebc0eed

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  323.412431][ T8724] BUG: KASAN: slab-use-after-free in v4l2_release (drivers/media/v4l2-core/v4l2-dev.c:466)
[  323.414158][ T8724] Read of size 8 at addr ffff888120d94458 by task repro_sur40_v4l/8724
[  323.415722][ T8724]
[  323.416236][ T8724] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  323.416240][ T8724] Call Trace:
[  323.416251][ T8724]  <TASK>
[  323.416256][ T8724]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  323.416279][ T8724]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  323.416357][ T8724]  kasan_report (mm/kasan/report.c:595)
[  323.416370][ T8724]  v4l2_release (drivers/media/v4l2-core/v4l2-dev.c:466)
[  323.416375][ T8724]  __fput (fs/file_table.c:510)
[  323.416398][ T8724]  fput_close_sync (fs/file_table.c:615)
[  323.416447][ T8724]  __x64_sys_close (fs/open.c:1507 fs/open.c:1492 fs/open.c:1492)
[  323.416469][ T8724]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[  323.416491][ T8724]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  323.416497][ T8724] RIP: 0033:0x7fe066183c03
[  323.416504][ T8724] Code: e9 37 ff ff ff e8 2d f9 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
[  323.416509][ T8724] RSP: 002b:00007ffdf8e8ecf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  323.416524][ T8724] RAX: ffffffffffffffda RBX: 0000000000000009 RCX: 00007fe066183c03
[  323.416528][ T8724] RDX: 01dd73bc7995e62a RSI: 0000000000000000 RDI: 000000000000000b
[  323.416531][ T8724] RBP: 0000000000000001 R08: 0000000000000009 R09: 0000000000000000
[  323.416534][ T8724] R10: 00007fe066129dd0 R11: 0000000000000246 R12: 0000000000000001
[  323.416537][ T8724] R13: 0000557a10ca7090 R14: 00007ffdf8e8eda0 R15: 0000000000000000
[  323.416544][ T8724]  </TASK>
[  323.416546][ T8724]
[  323.430976][ T8724] Freed by task 31 on cpu 1 at 322.408638s:
[  323.431417][ T8724]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[  323.431795][ T8724]  kasan_save_free_info (mm/kasan/generic.c:584)
[  323.432193][ T8724]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[  323.432615][ T8724]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[  323.433289][ T8724]  sur40_disconnect (drivers/input/touchscreen/sur40.c:832)
[  323.433680][ T8724]  usb_unbind_interface (drivers/usb/core/driver.c:458)
[  323.434121][ T8724]  device_release_driver_internal (drivers/base/dd.c:621 drivers/base/dd.c:1352 drivers/base/dd.c:1375)
[  323.434605][ T8724]  bus_remove_device (drivers/base/bus.c:657)
[  323.435042][ T8724]  device_del (drivers/base/core.c:3895)
[  323.435481][ T8724]  usb_disable_device (drivers/usb/core/message.c:1478)
[  323.436006][ T8724]  usb_disconnect (drivers/usb/core/hub.c:2315)
[  323.436489][ T8724]  hub_event (drivers/usb/core/hub.c:5407 drivers/usb/core/hub.c:5707 drivers/usb/core/hub.c:5871 drivers/usb/core/hub.c:5953)
[  323.436825][ T8724]  process_scheduled_works (kernel/workqueue.c:3314 kernel/workqueue.c:3397)
[  323.437403][ T8724]  worker_thread (kernel/workqueue.c:3478)
[  323.437873][ T8724]  kthread (kernel/kthread.c:436)
[  323.438298][ T8724]  ret_from_fork (kernel/process.c:158)
[  323.438778][ T8724]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[  323.439277][ T8724]
[  323.439513][ T8724] The buggy address belongs to the object at ffff888120d94000
[  323.439513][ T8724]  which belongs to the cache kmalloc-4k of size 4096
[  323.440921][ T8724] The buggy address is located 1112 bytes inside of
[  323.440921][ T8724]  freed 4096-byte region [ffff888120d94000, ffff888120d95000)
[  323.442314][ T8724]


Best,
Shuangpeng
