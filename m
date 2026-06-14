Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D862533D6
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 19:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781464766; cv=none; b=hA2Ex0QeRVkXy7fFFaXOHS5b6ysy38WkCu+gj3JYKvVZZViMBiPxZ+nLEw6Hhjq5PEWUKwicAPtEuZ3UI+xA5eSaE3+GX+eTXMiychB0bivt0Gt8HZ6sq5uUP8hnVNCOrpz5IBw1p61uJ1nLh6cJFG9jtq47xYFNpnR0NqtpAFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781464766; c=relaxed/simple;
	bh=kwRwajX0NpTQhq/ferE78iMulVMJWONC7haTFQi7XJg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/86acEsyA21M3LReea3PI5bd87xHPKEKS3XMSA+hcn5VkSU6wmTnCARHmJCHbNxOypvzT51byf2EyLpAEUaSdI6ZON6KJX/nz+YJM1jyuDSgJ6OaWfvoNbuaXnNRInW0FeHyP6N6s3RxplnpYP9NDNktJ9wbYtauZkftF/yI0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBrcdlxD; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBrcdlxD"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5177945a22eso18181391cf.1
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 12:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781464763; x=1782069563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yIMALptmH08hDIBGn9+50C8C0r6VnVr/CsdRlyfvq20=;
        b=EBrcdlxDcVDSGWsP9KANCJ41/mGJT09SxGnxSFr20cZs36sHdcDOddqC4i/UoOS2KA
         3LFvlumx7LWs718cQr1xAkS/S5BCPEDFpKc2dSLz+MwZDG6LvyMFqf4sZBA/V5TapsZS
         yj/u0JZuV8PuLlX3FdnDpm7Vux0iPMKSg++IIRIaFi73xgHpN9d8zRnl92Do6TkGAd/z
         2uFsBMOXPwC53+0YWjUBVsWGx6J9o23AeUVY+TzcoC6cHoPGvl9jukc/i7EkXyLAyEJn
         31E1kO6YaMzHlFA+ul2vY7+SooiHq1q+2L42HhEO/oOe9aLJS4uqdIDL+23InrQiunws
         FCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781464763; x=1782069563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yIMALptmH08hDIBGn9+50C8C0r6VnVr/CsdRlyfvq20=;
        b=TNrWMyXT9c3lu46OFuZetXNGo2Re3ak4aLbS0ByA8dmqzpn1/XZ+lIjqsMccf0qQSW
         EOjPCOIMBrCgEw7qKseb0Eplf9bn8pHRQIAXRS7Lr0bQwcZd7M18pnjo2I1hR01TRjb8
         /3m/d7ouGDC4bhV/PrjZ7vpoSHk4GPh2q2Gok4EwB4BQReNeb+eaFaOGnOGSwD9hzegj
         O2tE8mk0XtdLSe+0JwiB5fU9OpsmhJ74IhvYTBnz1LXBOyX35qSc8UQVf4uw4Uuv2Iy3
         zoLCyjzio2HIGAFDsyGaLUZnd6oA2reupsMWvlXk6wUC9U64q+TFrICJ/5g92/DA5avk
         l7Gg==
X-Forwarded-Encrypted: i=1; AFNElJ9G/3hvARbSYoQnAsG1ff80GzoSsB5h1SB82gKZEiavMm3Facg87M4wKmJPizyUdpgbF2Gvi2ejplOEig==@vger.kernel.org
X-Gm-Message-State: AOJu0Yynmget8D7yXwZZpMMZmaj2qviwv4BQF4H7btmgxNWO6riYFiNv
	1YOlTpMsS1fUMz9oZS2NRuESHRzcHlLrfg0xFggzQlPzoY+AW18f+hWf
X-Gm-Gg: Acq92OGMt8Cc8mauEVNLOzse1zlDUFjtkc2MrMb2bU33Vus1zdTgoUtcGU19Ne1Z0Hy
	+i0qtMQa+tiTDZf4zZOUflfgRhm3/LYiT5zUFDs233nI/P7yemhh+DK3HJkUk1AYms5EmWHiWyg
	CWnE14/tXiF9A6fKBBkvofNkC8WsCeCLONLi/kBrEaa5t5J79F2I+B4hZKNwv4KFa6Dqf8G6U4c
	IHi1Ec6T9HnQoptnGOOZPIvUFI3kT0aoJ0ausyxNxH6PhwkM7pFsgbHL6ZMFmaaQPAQijq+7Ksl
	IjYWf9ACGGzWYFk8UBjr/eXt2aEAsrUqElZxOl6idXMjY4QswKEWIeOZ0nh00Q29CPwIHHfAB63
	uMKHcMKcuji44asL8TxNYgDzq3AYJby31VYod3V3dO8Jdd5h1Zdlhqb0mqQvDSXByu9M/fnT7Rg
	qwT0G/YsMXQZV9mUN8F72f0Vdru8gqdOaxoPShNVzU+ONUPBZSYd1ijIfAelGxc7TXuUCb0QdCy
	dD3LvmKTXEO
X-Received: by 2002:a05:622a:8d12:b0:50e:6139:492b with SMTP id d75a77b69052e-517fe52f307mr156447131cf.23.1781464763075;
        Sun, 14 Jun 2026 12:19:23 -0700 (PDT)
Received: from localhost.localdomain ([2607:fb90:a8d1:8eec:5c3c:2f7e:d7e3:b1bd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb61fb15sm82414491cf.5.2026.06.14.12.19.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 12:19:22 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] KASAN: slab-use-after-free in _raw_spin_lock_irqsave from hid-sensor-custom
Date: Sun, 14 Jun 2026 15:19:21 -0400
Message-ID: <178144969601.60470.12928355382146160896@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Kernel Maintainers,

I hit the following report while testing current upstream kernel:

KASAN: slab-use-after-free in _raw_spin_lock_irqsave from hid-sensor-custom

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/d82ac0d19fda016e81d7fa1ab028d967

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[   73.157590][ T8356] BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:1300 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:166)
[   73.161235][ T8356] Write of size 4 at addr ffff88810eb72528 by task hid_sensor_cust/8356
[   73.163453][ T8356] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   73.163457][ T8356] Call Trace:
[   73.163461][ T8356]  <TASK>
[   73.163464][ T8356]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   73.163471][ T8356]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   73.163486][ T8356]  kasan_report (mm/kasan/report.c:595)
[   73.163495][ T8356]  kasan_check_range (mm/kasan/generic.c:? mm/kasan/generic.c:200)
[   73.163500][ T8356]  _raw_spin_lock_irqsave (include/linux/instrumented.h:112 include/linux/atomic/atomic-instrumented.h:1300 include/asm-generic/qspinlock.h:111 include/linux/spinlock.h:187 include/linux/spinlock_api_smp.h:133 kernel/locking/spinlock.c:166)
[   73.163539][ T8356]  add_wait_queue (kernel/sched/wait.c:23)
[   73.163547][ T8356]  hid_sensor_custom_poll (include/linux/poll.h:45 drivers/hid/hid-sensor-custom.c:706)
[   73.163556][ T8356]  do_sys_poll (include/linux/poll.h:82 fs/select.c:877 fs/select.c:920 fs/select.c:1015)
[   73.163692][ T8356]  __x64_sys_poll (fs/select.c:1072 fs/select.c:1060 fs/select.c:1060)
[   73.163708][ T8356]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   73.163714][ T8356]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   73.163755][ T8356]  </TASK>
[   73.214615][ T8356] Freed by task 781 on cpu 1 at 72.569353s:
[   73.215524][ T8356]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   73.216247][ T8356]  kasan_save_free_info (mm/kasan/generic.c:584)
[   73.217018][ T8356]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[   73.217739][ T8356]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[   73.218335][ T8356]  devres_release_all (drivers/base/devres.c:50 drivers/base/devres.c:547 drivers/base/devres.c:576)
[   73.219108][ T8356]  device_release_driver_internal (drivers/base/dd.c:598 drivers/base/dd.c:1357 drivers/base/dd.c:1375)
[   73.220034][ T8356]  bus_remove_device (drivers/base/bus.c:657)
[   73.220796][ T8356]  device_del (drivers/base/core.c:3895)
[   73.221458][ T8356]  platform_device_unregister (drivers/base/platform.c:797 drivers/base/platform.c:839)
[   73.222310][ T8356]  mfd_remove_devices_fn (drivers/mfd/mfd-core.c:385)
[   73.223121][ T8356]  device_for_each_child_reverse (drivers/base/core.c:4065)
[   73.224033][ T8356]  mfd_remove_devices (drivers/mfd/mfd-core.c:401)
[   73.224779][ T8356]  hid_device_remove (drivers/hid/hid-core.c:?)
[   73.225537][ T8356]  device_release_driver_internal (drivers/base/dd.c:619 drivers/base/dd.c:1352 drivers/base/dd.c:1375)
[   73.226449][ T8356]  bus_remove_device (drivers/base/bus.c:657)
[   73.227200][ T8356]  device_del (drivers/base/core.c:3895)
[   73.227857][ T8356]  hid_destroy_device (drivers/hid/hid-core.c:3064 drivers/hid/hid-core.c:3086)
[   73.228617][ T8356]  usbhid_disconnect (drivers/hid/usbhid/hid-core.c:1476)
[   73.238613][ T8356] The buggy address belongs to the object at ffff88810eb72400
[   73.238613][ T8356]  which belongs to the cache kmalloc-512 of size 512
[   73.240744][ T8356] The buggy address is located 296 bytes inside of
[   73.240744][ T8356]  freed 512-byte region [ffff88810eb72400, ffff88810eb72600)


Best,
Shuangpeng
