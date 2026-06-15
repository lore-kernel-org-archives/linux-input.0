Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E348213A3ED
	for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781487923; cv=none; b=sJVouOFbkXUGG7KOgy7SEg0pirlXQKiu+wHPCKOIpfAyLyBkCuZPIEB1yMqP3NKo9Juk1unHLpdKVeUYCQjk5+Qd9SQX2D1IXz0to1efvONnxs8/ED5J0l4t+ZufrY6MHyRMwD4vKQbc258i88D7p7QEec84bCctO3T9XBDNeJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781487923; c=relaxed/simple;
	bh=Q8IuwbarkNZPzJu5L/vZbu7+SdBMOVjz6huUaACKZbc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DKng3hLp60SppOXP2V3b8hzvH3iYW2pNPQRiIWZtOn3lw4SjgIeOXpq0CDlPe5mLconWCcbVf3HBgJJ8IH0HIzKhIT1EpZT4ftkrcnpTKCjbGMHytvZKUmC+8XckrD8shY+vdk0MT5vh3kbowgbRt+2e+r3MBqgWoSfoREK+4JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xoqatfsn; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xoqatfsn"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8cd45d4b7e2so35379946d6.2
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 18:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781487921; x=1782092721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8CHSv4ANqmSvhsROrXqRELTXQAD4dU70egcKmdBq7BQ=;
        b=Xoqatfsnt+doTt3nCVrUVh9Wbx9tCCDrlW7JlccU2tEIb5+8owjGS5c/C9dbVTzJdZ
         kwqzeHJDFO0a41YGawVNL2GN5ilx1oNo3QNEf2WwgoPZcts9Clv+cAvnMTEv/+cGRl3M
         yWFRSyLY3ZjTUC/J4ieDh5ijVKbc/j12ZzD4x7Gbf5gS6UK2gANrHNr8Uyf8EkPVvnSL
         eKtA7GjTV257br2lgffxydHmWYAAt3HR/Fpgm7PJDfk/Xwb6FxZRNjdcYlJXjd386obv
         P6gP5b5/H5Tb1m4AamlyeZXb9XBWNi0G2FWdbclOoPpctwc6orR+dulJbxfA+Pg7xQwM
         ZZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781487921; x=1782092721;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CHSv4ANqmSvhsROrXqRELTXQAD4dU70egcKmdBq7BQ=;
        b=oOK8Ud/Zr2EaSeZcmllGhRBpMGbatDi43BelETj9PKzmzcQdVm6KADQ6CQZX/dn0Os
         ht+xHVcgToaHBMnV2xZppWTy3KJ7ldStCeK3yn7IP6nvj8C+QlAuOSsFuUAm+5IR9xHb
         xiXy2QuBN/VPLqVj2nGycntHvNkuDhCeEDUY/9I2R+h59OEH11Q5MKtM2zk/CCepHQSg
         8hGmG8Zuo7vss9mI3P2ziU9cki4m8Go6YIazVjo3JeEL0LzEkuLpFxP5M18RZeo+KErK
         RJRMSzb5ZYwL8y+dvFkqeiTSIe86AYKUJE3A1IYlAGRWBzqPStt6FxkAcaYGH3du1PTl
         f9VQ==
X-Forwarded-Encrypted: i=1; AFNElJ+MY1GQst8idU2BkseJOW9Ex8b7uftDxmTDWX5VQsHNhQXT3nwcWRKF+LjuiX7v/dcgbNZzXwuX6lFvCg==@vger.kernel.org
X-Gm-Message-State: AOJu0YznGjEkOpMMGRsFXU3uVqwxVhb/Rlg5iAugDTUs2sp3M7bzal45
	h0zGXHNyiPEaybpa2x9AR1dEq+AvB8uw6L/sMbD3P88Sp+FY+3TXMKlo
X-Gm-Gg: Acq92OG9iNVb2SpSIgbFQuxSwt3QaEQ/kglR4TtV2zFr5ZYNGsz1Cy+wwnuLLszqST+
	Xzsp15qRAs4gmI/8CsIGEwvV0QIczmvBh4RZvZGxef/k3oROckLRYqxKaD0AI+0dclTV2Cs9snA
	HcMgGfY2gOvTTA8VpCLlMMnk5P+MnVNwqsMqEYdwijoOkLKD4Qf/nTbgKTSxxNOWoRhe7SJyaDP
	9PP2Rcc7/Jq8NKjznLPZXzn7DLzGTWPM0txShX/4iPTpVedX/I6/0Imlotz1BhjKe36TsG19pWc
	G4P8JOm9efxZ+uw8MFUxikbg1WoTbyE6XjFqi4vpLfazBcCQcR7WC9PVmUox42+VdQRy7TCiKUM
	pUEAxcyttXrs7V7k6k+QQbA8Qe57y7wMKJHlnzwm5CKozK8GLNjBL0HbM3ocC+inIH8JJ/++g8J
	cmGPnQgbspjMymCFOf8h4lPfgUIjTMy0ECa9Sf8BF394shFuG+QEFUjdiGBj27ZqAbiJPWR0bNO
	Nhb019/
X-Received: by 2002:ac8:7f85:0:b0:517:6ef7:f6e0 with SMTP id d75a77b69052e-517fe54f480mr184457611cf.46.1781487920807;
        Sun, 14 Jun 2026 18:45:20 -0700 (PDT)
Received: from localhost.localdomain ([2601:985:4601:5df0:2106:6ce9:6b1:8f70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51975955956sm11729771cf.17.2026.06.14.18.45.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 18:45:20 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: dmitry.torokhov@gmail.com,
	mchehab@kernel.org,
	linux-input@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] Input: rmi4: KASAN slab-use-after-free in v4l2_release
Date: Sun, 14 Jun 2026 21:45:18 -0400
Message-ID: <178144969601.60470.13645789994911690209@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi input and media maintainers,

I hit the following report while testing current upstream kernel:

Input: rmi4: KASAN slab-use-after-free in v4l2_release

The issue was reproduced by holding an rmi4_f54 /dev/v4l-touch node open,
unbinding the rmi4_f54 function, and then closing the held fd.

I am not sure whether this is specific to rmi_f54 or a more generic V4L2
lifetime issue.

I reproduced this on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/351f125869016d5ce915cbc113abb547

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[   87.788267][ T8430] BUG: KASAN: slab-use-after-free in v4l2_release (drivers/media/v4l2-core/v4l2-dev.c:466)
[   87.790392][ T8430] Read of size 8 at addr ffff8881748dc588 by task rmi_f54_hold_cl/8430
[   87.790944][ T8430]
[   87.791114][ T8430] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   87.791116][ T8430] Call Trace:
[   87.791119][ T8430]  <TASK>
[   87.791121][ T8430]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   87.791125][ T8430]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[   87.791137][ T8430]  kasan_report (mm/kasan/report.c:595)
[   87.791143][ T8430]  v4l2_release (drivers/media/v4l2-core/v4l2-dev.c:466)
[   87.791146][ T8430]  __fput (fs/file_table.c:510)
[   87.791150][ T8430]  fput_close_sync (fs/file_table.c:615)
[   87.791695][ T8430]  __x64_sys_close (fs/open.c:1507 fs/open.c:1492 fs/open.c:1492)
[   87.791698][ T8430]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   87.791701][ T8430]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   87.791704][ T8430] RIP: 0033:0x7fe62d972c03
[   87.791708][ T8430] Code: e9 37 ff ff ff e8 2d f9 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 45 c3 0f 1f 40 00 48 83 ec 18 89 7c 24 0c e8
[   87.791710][ T8430] RSP: 002b:00007ffdc1dc6588 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[   87.791715][ T8430] RAX: ffffffffffffffda RBX: 000000000000000c RCX: 00007fe62d972c03
[   87.791717][ T8430] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
[   87.791718][ T8430] RBP: 0000000000000003 R08: 0000000000000000 R09: 00007fe62da160c0
[   87.791720][ T8430] R10: fffffffffffffc0d R11: 0000000000000246 R12: 0000000000000004
[   87.791722][ T8430] R13: 00007ffdc1dc66d0 R14: 00007ffdc1dc65d0 R15: 0000000000000000
[   87.791725][ T8430]  </TASK>
[   87.791727][ T8430]
[   87.803468][ T8430] Freed by task 8430 on cpu 1 at 87.787459s:
[   87.803881][ T8430]  kasan_save_track (mm/kasan/common.c:57 mm/kasan/common.c:78)
[   87.804205][ T8430]  kasan_save_free_info (mm/kasan/generic.c:584)
[   87.804556][ T8430]  __kasan_slab_free (mm/kasan/common.c:253 mm/kasan/common.c:285)
[   87.804885][ T8430]  kfree (include/linux/kasan.h:235 mm/slub.c:2689 mm/slub.c:6251 mm/slub.c:6566)
[   87.805157][ T8430]  devres_release_all (drivers/base/devres.c:50 drivers/base/devres.c:547 drivers/base/devres.c:576)
[   87.805504][ T8430]  device_release_driver_internal (drivers/base/dd.c:598 drivers/base/dd.c:1357 drivers/base/dd.c:1375)
[   87.805929][ T8430]  unbind_store (drivers/base/bus.c:244)
[   87.806246][ T8430]  kernfs_fop_write_iter (fs/kernfs/file.c:352)
[   87.806616][ T8430]  vfs_write (fs/read_write.c:595 fs/read_write.c:688)
[   87.806914][ T8430]  ksys_write (fs/read_write.c:740)
[   87.807214][ T8430]  do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
[   87.807542][ T8430]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[   87.807955][ T8430]
[   87.808124][ T8430] The buggy address belongs to the object at ffff8881748dc000
[   87.808124][ T8430]  which belongs to the cache kmalloc-4k of size 4096
[   87.809083][ T8430] The buggy address is located 1416 bytes inside of
[   87.809083][ T8430]  freed 4096-byte region [ffff8881748dc000, ffff8881748dd000)
[   87.810030][ T8430]


Best,
Shuangpeng
