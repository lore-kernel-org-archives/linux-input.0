Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7C43009F6
	for <linux-input@vger.kernel.org>; Sun,  4 Oct 2026 11:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791112531; cv=none; b=dA24YdvF6j4kcSEyIXoep6JgrH4GzxcTQNKdMethLGZT26wl6nD10AyuPdOCxzeAZWREgAVeQ0elo4Js/Lh3fgHlD/gyK6e9usF69k2IbhcMc1plwFxY3Y1iXTGNvVCYJjB4vy4BhTIPyBI/HwcB+qJae2VNKUApXXBw+csJuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791112531; c=relaxed/simple;
	bh=yuAe7Cq/oPStaIUgkXR021KjDrz+4BwrSi8Rf1ZVcVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEhI4ApKlCAIk8f2wbeBp1wBMWwga7iwdC2If34TAANhQ/UKKYWpN865wXRdb1DipCbl3JvNfx3dfeKWDRAa0FS9zgSyeHk/qqfN8F3FKu9X7SHaKGc7LCiBmYEqVZuuy06Wp+RhkVNTADZO/sxSVvYZphVd9Pi2E+SpZCx6CRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ge/rVNAI; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ge/rVNAI"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso392476a91.0
        for <linux-input@vger.kernel.org>; Sun, 04 Oct 2026 04:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791112528; x=1791717328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h3A2hXOPkh2lM3bdc7NxUKnnvRhD1xa1RuiKPnko66A=;
        b=Ge/rVNAI9NlyIpHurF9T2meRSeq0WE7Z5+n3s1UBMkeElG/Y6Qlg4PRGyHIMd6v+xH
         GWP1x/I75T7BY+4SFPtKfXbXOJeQSj5fOUbcvsUqFJ6Vt4Cfcgmsqo9ZjkjQNfpGNkTk
         KM5as/sOCmLCiAbBH4dOJHBrBqeBVgq461ppG1JIuU8NtEZBJV3lmM4tj7nrdmWAAUJp
         1tpw2A5l0QaRQrxErNydanqct/ErkoTnl/HDUaCGDURdbLQ9WFXiwjV6nvkXeS7umvTd
         PDu6J72YT+avSxEGw2LFBIYvZwd4FpvZNpDRiTt5oIrmVz76eFpoprsrqPihJ39Dj4z1
         7jKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791112528; x=1791717328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3A2hXOPkh2lM3bdc7NxUKnnvRhD1xa1RuiKPnko66A=;
        b=mq54ZLr/MwtkL10a7T0DZeVlXBSL+5tWzdTJQFqe7PyBceLe3lfB3Qy/aPA7sdn2cY
         F00ttms9rKvh3lu4yFxVG+dgiPbhB/o1oBrg4pT5EFLZYYwXrDhHvHGESmYEfnlf9Hh6
         B8EpyQv+Q7SS3pslBxEsoOkQv0MM02u579N7Jv6dI8/5hhpIXCBa3KBNQnlPbW0v3JKr
         r8gs4DwJT+aX5cfPj7a2ZQ0THTEmAISQgChMS9Xl5EEc8WQm5N/jZ9ZJAr7T5Z2NzzFV
         WgMlPiT2xJiREUMTKeitX1iyszhlSupCe9p/lgjfmH7YvCDP7KenxKR98jKOugC9KWsx
         yWvw==
X-Gm-Message-State: AFq9FYJjWjzbyUEgxAl/A1fak0l873+EnwTRzUvJtqXgl6S27RE+PeLn
	xnnoTTEUmGaRJeKUE4DzKKxuKF7PhPmoRpYwY6CT9VX1VxHPQrknUuE5
X-Gm-Gg: AYBFou30KXhVNhDbdXe/3jnDh9xW5ca06WtXz16yDTvHkGEpL8tPSuXA0sSzPE/4gLM
	5u9FR09cvAAh9v+pAF2grl7A0kQ9urlRTH8KeQFIrUFJGubJNyyMwkXzcHIML/I69uvTgQj5Siv
	qOXFEVbpmdgNEDCOhv68hDgNDlyfGNzZzQxJCfy3DT9OOWl9th1jZmNQkD12ufB/AhbMp8J21MA
	fbnKVIRzyAN5XQ3BeDDaltJaVwOEK39lGkHdM4n4Qe5en2G4mj/Q2Rf9ckzaYprPT2fmrJkigwh
	Geu8Qao1tz2Gp5ehaMCI3l290Z+zATH+Mx1569/lO7qfdfM255WJgc3leMnRMExVoawCbDgKnCq
	BSOlvunlKouMMh34CQXAOQGqu7CQZ7BGY2M4mdOIJlCwE1kNu5gwu3lFDh67qXDb/NvY5OcQSGJ
	7UPi6UolhNGFluoY+/otUd+Ci+PmFH4PQFNrfdAI+WSyRHqKq0+jZpAtaUSwr5gQpaOXNkdUWvB
	+I00gs2qjgigM9S05o6DHs=
X-Received: by 2002:a17:90b:498e:b0:3a7:9ad9:68e1 with SMTP id 98e67ed59e1d1-3a79ad96bd7mr2915110a91.13.1791112527449;
        Sun, 04 Oct 2026 04:15:27 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f73556efsm2776007a12.9.2026.10.04.04.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 04:15:25 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH 0/1] HID: wacom: fix sibling use-after-free in mode change
Date: Sun,  4 Oct 2026 20:13:25 +0900
Message-ID: <20261004111353.118025-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I found the following use-after-free in the wacom HID driver while fuzzing
with syzkaller, and reproduced it deterministically on hid.git master
(fe2ec83746e5, v7.3-rc4 based) with a uhid reproducer -- 10 KASAN reports
out of 10 boots:

  BUG: KASAN: slab-use-after-free in wacom_parse_and_register+0x4fa8/0x58e0
  Read of size 8 at addr ffff88800be431f8 by task kworker/0:2/75

  CPU: 0 UID: 0 PID: 75 Comm: kworker/0:2 Not tainted 7.3.0-rc4-gfe2ec83746e5-dirty #2 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  Workqueue: events wacom_mode_change_work
  Call Trace:
   <TASK>
   dump_stack_lvl+0xba/0x110
   print_report+0x153/0x4c6
   ? wacom_parse_and_register+0x4fa8/0x58e0
   ? __virt_addr_valid+0x221/0x4e0
   ? wacom_parse_and_register+0x4fa8/0x58e0
   kasan_report+0xe4/0x1a0
   ? wacom_parse_and_register+0x4fa8/0x58e0
   wacom_parse_and_register+0x4fa8/0x58e0
   ? do_raw_spin_lock+0x123/0x260
   ? __pfx_wacom_parse_and_register+0x10/0x10
   ? lockdep_hardirqs_on_prepare+0xdc/0x190
   ? _raw_spin_unlock_irqrestore+0x40/0x50
   ? trace_hardirqs_on+0x19/0x190
   ? _raw_spin_unlock_irqrestore+0x40/0x50
   wacom_mode_change_work+0x333/0x7e0
   process_one_work+0xa3b/0x19b0
   ? __pfx_process_one_work+0x10/0x10
   ? lock_acquire+0x18c/0x300
   ? lock_is_held_type+0x87/0xf0
   ? __pfx_wacom_mode_change_work+0x10/0x10
   worker_thread+0x5eb/0xe50
   ? __pfx_worker_thread+0x10/0x10
   ? kthread+0x13a/0x450
   ? __pfx_worker_thread+0x10/0x10
   kthread+0x368/0x450
   ? __pfx_kthread+0x10/0x10
   ret_from_fork+0x617/0x9e0
   ? __pfx_ret_from_fork+0x10/0x10
   ? __switch_to+0x7ec/0x10f0
   ? pirq_enable_irq.cold+0xb7/0x199
   ? __pfx_kthread+0x10/0x10
   ret_from_fork_asm+0x1a/0x30
   </TASK>

  Allocated by task 11:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   __kasan_kmalloc+0x7f/0x90
   __kmalloc_node_track_caller_noprof+0x26b/0x6e0
   devm_kmalloc+0xa2/0x290
   wacom_probe+0xb2/0xdb0
   hid_device_probe+0x4fb/0x850
   really_probe+0x235/0x760
   __driver_probe_device+0x291/0x3c0
   driver_probe_device+0x4a/0x140
   __device_attach_driver+0x1d2/0x270
   bus_for_each_drv+0x152/0x1d0
   __device_attach+0x1e1/0x470
   device_initial_probe+0xaf/0xd0
   bus_probe_device+0x62/0x160
   device_add+0x111a/0x1930
   hid_add_device+0x2c2/0x460
   uhid_device_add_worker+0x37/0x70
   process_one_work+0xa3b/0x19b0
   worker_thread+0x5eb/0xe50
   kthread+0x368/0x450
   ret_from_fork+0x617/0x9e0
   ret_from_fork_asm+0x1a/0x30

  Freed by task 82:
   kasan_save_stack+0x30/0x50
   kasan_save_track+0x14/0x30
   kasan_save_free_info+0x3b/0x70
   __kasan_slab_free+0x47/0x70
   kfree+0x1b3/0x550
   release_nodes+0xcc/0x130
   devres_release_group+0x1c2/0x2d0
   hid_device_remove+0x107/0x200
   device_remove+0xc8/0x180
   device_release_driver_internal+0x448/0x610
   bus_remove_device+0x2b6/0x460
   device_del+0x378/0xd10
   hid_destroy_device+0x1a6/0x250
   uhid_char_release+0xeb/0x1f0
   __fput+0x3fd/0xb50
   fput_close_sync+0x113/0x240
   __x64_sys_close+0x8b/0x120
   do_syscall_64+0x106/0x5f0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  The buggy address belongs to the object at ffff88800be43000
   which belongs to the cache kmalloc-2k of size 2048
  The buggy address is located 504 bytes inside of
   freed 2048-byte region [ffff88800be43000, ffff88800be43800)

  The buggy address belongs to the physical page:
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xbe40
  head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
  flags: 0x100000000000040(head|node=0|zone=1)
  page_type: f5(slab)
  raw: 0100000000000040 ffff888008c42000 dead000000000100 dead000000000122
  raw: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
  head: 0100000000000040 ffff888008c42000 dead000000000100 dead000000000122
  head: 0000000000000000 0000000000080008 00000000f5000000 0000000000000000
  head: 0100000000000003 fffffffffffffe01 00000000ffffffff 00000000ffffffff
  head: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
  page dumped because: kasan: bad access detected

  Memory state around the buggy address:
   ffff88800be43080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
   ffff88800be43100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  >ffff88800be43180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                                                                  ^
   ffff88800be43200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
   ffff88800be43280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ==================================================================

wacom_mode_change_work() obtains both siblings' struct wacom from
wacom_shared and tears down and rebuilds them, holding no reference to
either. wacom_remove() cancels only the work owned by the device being
removed, so a worker owned by the other sibling keeps using this device
after its remove callback returns; hid_device_remove() then releases the
driver's devres group and frees struct wacom. Closing one sibling's
/dev/uhid descriptor is all it takes, with no privilege.

The report above is the read. On the syzkaller instance where I first hit
this -- a KASAN linux-next build, not the hid.git master tree I used for
the 10-boot runs -- the same worker also produced slab-use-after-free
*writes*, at features->touch_max in wacom_feature_mapping(), four bytes
at a fixed offset into the freed object with the value taken from a
feature report; and NULL dereferences in wacom_set_shared_values(), where
the sibling's wacom_release_resources() had cleared wacom_wac->shared
while this worker slept in wacom_parse_and_register().

The defect dates to 4082da80f46a ("HID: wacom: generic: add mode change
touch key") in v4.12, which introduced the worker, the reference-free
sibling lookup and the incomplete cancellation in one go. The lifetime it
depends on was already in place in that commit's parent.

This is also the issue 3a523ecf9ac3 ("HID: wacom: Fix Use-After-Free in
wacom_bamboo_pad") refers to when it notes that "lockless access in the
latter [wacom_mode_change_work] remains a pre-existing issue". That
series fixed the lifetime of the shared pointers; this patch fixes the
lifetime of the struct wacom objects the worker caches across
hid_hw_stop() and wacom_parse_and_register().

Fix and testing
===============
The patch serializes mode-change workers with wacom_remove() using a
driver-wide mutex. Removal cancels its own work before taking the mutex,
so a worker blocked on it cannot deadlock removal. Because
wacom_add_shared_data() registers its devres action inside the group
wacom_parse_and_register() opens, the wacom_release_resources() call in
wacom_remove() clears this device's shared pen or touch pointer while the
mutex is held, and a worker that starts later cannot select it.

x86_64, CONFIG_KASAN_GENERIC=y, CONFIG_PROVE_LOCKING=y,
CONFIG_DEBUG_ATOMIC_SLEEP=y, CONFIG_DETECT_HUNG_TASK=y, one fresh
headless QEMU guest per round:

                                  unpatched   patched
    rounds                               10        10
    KASAN use-after-free                 10         0
    lockdep reports                       0         0
    hung task / RCU stall                 0         0
    WARNING / BUG / oops                  0         0
    completed the full workload           0        10
    wacom interfaces bound               40        60
    input devices registered             60       150

The unpatched kernel faults about 4.6 s into every round, which is why it
binds and registers less. On the patched kernel the 150 input registrations
against 60 bound interfaces are re-registrations, and in this workload only
wacom_mode_change_work() re-registers, so the serialized path ran about
ninety times under lockdep without a report. Three further boots of the
functional path, two siblings bound and unbound with no mode-change report,
registered both devices every time with no KASAN report, warning or oops.

To make the existing window deterministic I added a one-second delay to
wacom_set_shared_values() under has_mode_change. That is test-only
instrumentation and is not part of the patch; with it the patched kernel
holds the new mutex across the full teardown and rebuild, which is the
state a lock-order problem would show up in.

Cost of this lock, and what is not fixed
========================================
The worker holds the new driver-wide mutex across hid_hw_stop() and
wacom_parse_and_register(), and that path issues synchronous feature
reports: wacom_retrieve_hid_descriptor() -> wacom_parse_hid() ->
wacom_feature_mapping() calls wacom_get_report() for HID_DG_CONTACTMAX
and, unguarded, for each of WACOM_HID_WD_OFFSET{LEFT,TOP,RIGHT,BOTTOM}.
On a uhid device every one of those waits up to 5 seconds in
__uhid_report_queue_and_wait() if the client does not answer, so a uhid
client that declares those usages and stays silent can hold the mutex for
tens of seconds and block the unbind of unrelated wacom devices. Without
the patch that path takes no lock, so this cross-device blocking is new.

I kept the global mutex because this is the minimal shape I could verify
for a fix going to stable, and because a lock inside wacom_shared cannot
work here: the worker's own devres release can drop the last reference to
that object, which is one of the windows being closed. A per sibling
group lock with a lifetime independent of the shared data is the obvious
narrower fix, and I am happy to follow up with it if you would rather
have that than the global mutex.

wacom_wireless_work() has the same shape as the worker fixed here: it
takes sibling struct wacom pointers from usb_get_intfdata() with no
reference and calls wacom_release_resources() and
wacom_parse_and_register() on them. It is USB-only and my reproducer does
not reach it, so I left it alone rather than extend a fix I cannot test.

The patch applies to hid.git master. It does not apply to for-next:
480c9cb14ae8 ("HID: wacom: Redesign shared sibling data lifecycle")
rewrote the same hunks and made shared->pen and shared->touch __rcu. The
same design works there with rcu_access_pointer() for the snapshot, and I
can send that variant if you prefer it.

Happy to send the reproducer and the serial logs off-list.

Thanks,
Jinmo

Jinmo Yang (1):
  HID: wacom: serialize mode changes with device removal

 drivers/hid/wacom_sys.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)


base-commit: fe2ec83746e501645709761605c2464a44fd2929
--
2.53.0

