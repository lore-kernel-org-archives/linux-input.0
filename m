Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF7224AF9
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 13:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779630729; cv=none; b=hUcwcR7ZuE9cIb22AUAHhpC5m3d0e9fmNOJGkBYSDcMb7dtwSE9gVzaE67jrRbDz/2Qj5ZZ5HYwe+rCTncKnhPj+dCaISCLsOfCvKaxIDxhcV60qjbjoeGl0KLHE77Z7d2iCocLmL2zPC2oasm0beRGpr0UVrNuY16IacPEkex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779630729; c=relaxed/simple;
	bh=fvQwEMYX6BDOUBNVbw3xkM0WWl+t9x/Se3AcK+dqC4c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AuBwcp9RveqMG/gMZQNFU5W2ejTX4aY0FTYtWAVt0tmgT7P9jGqyBJ5n7MOIjMuseZ5Mbz1naIoZjM4LzcryruitfUKBXr3+uJv8dkXsOy9UVki7kiyWPbiWmUTRRqBWPM4xrJu/SvyHaiMMUXpwvNu6sj5NGIePdY/yOX7rD/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IexDHLM6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IexDHLM6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-36608b2f2dcso5765126a91.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779630728; x=1780235528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LzPGquotkKW/US/d7GbfP4YoBT5ndTm9l3GA2srn+2A=;
        b=IexDHLM6uitCis3KLrz00Eap4Vj5kLtNYuc4kqbZ7JVNq+6Ptahg2Zvkb4fNOGpkzp
         ZU+M2rcBEpXyESXIprGHCNxVq668JJgDpL1/aJ7ce/v0bRc1VowsU5nAuIoxuRDRx8wV
         GTKNQrF+NTWyl0i+iHd/1PLjFw9M24Ru/byYtEvcP9gS5cHiImSHL1nUx4aSnzK07Aq/
         9Yz5egu6hmLQ81FnZphmL9l/iH/+wX3AMAfhzfn7R9X8vqF4aTI9RxXo66RDz9wFE24i
         UFqJmxWkNopxjMMCL21DbIqJtVwYlM5oW+rrM0u6whF0T5HB9QA5ir9Y1kW8dTxQUFUp
         3qHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779630728; x=1780235528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzPGquotkKW/US/d7GbfP4YoBT5ndTm9l3GA2srn+2A=;
        b=pDRutL6NzEpvYv7dar3HPRf2nGjykPDlVhUWK7Ww4Rf0FlY/+ShnYgm+MoSFcN1/qZ
         0yyxpW2bfyl9HXkQyBol7l9axBjW+JAQM1P15pXrs5kA1B1oArW/Sn+IoyFMUawTCka8
         UQh+lTm0uROui6kYDkmv2/v+Ozw9b4yb6yZrsDyWE6YQ6g61W2rXx+3ybRVu2lGp8hlM
         F3GAkSUOYJhEd0Q49gWPv2+WXn+8y3TEu4x8mKHhv8E1Xx/0jJKRR577GuANB2/3i4oM
         ta7E18wL2T/oZ8mqPUwq4A+aI0DhCpzBSfieO71aWnYFrWD1y7fpoC4cFR6BNgpR8eWb
         seDg==
X-Forwarded-Encrypted: i=1; AFNElJ8iCObc8FkeGM3Ko52k4U+25ooDgVN5/lXN2DRc8A+W05E5uWg/Em09V3Z9WtcBGibjpq0Or6f16Ev1Lg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyF8xgqnNMEvuX2e+IY0heql1MZOqLSmzidkqkktPhuSh0uRp3+
	NEZ+MJDyinbIG7amEsQbxLP0pDeEuGV68/92ygyYwtmIkZsiIJr5i7aM
X-Gm-Gg: Acq92OF1ANIMkr4a/IBU4ETOKvZzoVjj6YtBQeO/r0CJ2EPrj/H6djz1RR6N8AUx4Iq
	//1OTbfgAku/IQP3BbM8m4OHwJVLaGr47sDgJBIczgUfDcl4snmqyJST7ejlXrjl9nlc61/UlVU
	nqh0msDhHRYfKDF/kZ51cMZyGykOBty/K/rfOO2km0bVgUUd5KMhX2LEa2Ge323GL6mvxqilzRv
	iFOf5XLWOAki2nQZxHvRdXpXlYrpgG4kraU2xo+uSeuxavt7vmo/yA+IHxqIAqDCGpRWl2NtRzo
	O1bhRNcZBwTnGlAYo1XHnSQSVirwSKKxra1fqsueQKojjPFRAx4/IqNYEqeegfYYWgr3TIBs2s4
	hLCwjiIUXhYg2ncaY+KbdHWG/2/7yV2x6OwW1Cm/pgs1d4+rzASxp8He2NSR0H4mVxwqBMEMVNv
	MZH4mYJmfwisf5oHlukpAcnWuDGJvJjZNJrBofLEORNRQ9dasUwCUG8C4D3GVFvIm2shB4xg==
X-Received: by 2002:a17:90a:d885:b0:369:e4d4:79c6 with SMTP id 98e67ed59e1d1-36a6782a785mr9844596a91.20.1779630727617;
        Sun, 24 May 2026 06:52:07 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a72c4ca35sm7073833a91.9.2026.05.24.06.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 06:52:07 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: Jason Gerecke <jason.gerecke@wacom.com>,
	Ping Cheng <ping.cheng@wacom.com>
Cc: Jinmo Yang <jinmo44.yang@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/1] HID: wacom: fix slab-out-of-bounds write in kfifo_copy_in
Date: Sun, 24 May 2026 22:52:02 +0900
Message-ID: <20260524135203.1996265-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I found the following slab-out-of-bounds write in the wacom HID driver
while fuzzing with syzkaller on v7.1.0-rc4-next-20260522:

  BUG: KASAN: slab-out-of-bounds in kfifo_copy_in+0xf3/0x130 lib/kfifo.c:106
  Write of size 3842 at addr ffff888009179000 by task syz.3.9362/61135

  CPU: 1 UID: 0 PID: 61135 Comm: syz.3.9362 Not tainted 7.1.0-rc4-next-20260522-dirty #3 PREEMPT(lazy)
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
  Call Trace:
   <TASK>
   __dump_stack lib/dump_stack.c:94 [inline]
   dump_stack_lvl+0x97/0xe0 lib/dump_stack.c:120
   print_address_description mm/kasan/report.c:378 [inline]
   print_report+0x157/0x4c9 mm/kasan/report.c:482
   kasan_report+0xce/0x100 mm/kasan/report.c:595
   check_region_inline mm/kasan/generic.c:186 [inline]
   kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
   __asan_memcpy+0x3c/0x60 mm/kasan/shadow.c:106
   kfifo_copy_in+0xf3/0x130 lib/kfifo.c:106
   __kfifo_in_r lib/kfifo.c:442 [inline]
   __kfifo_in_r+0x1b2/0x230 lib/kfifo.c:434
   wacom_wac_queue_insert drivers/hid/wacom_sys.c:65 [inline]
   wacom_wac_pen_serial_enforce drivers/hid/wacom_sys.c:165 [inline]
   wacom_raw_event+0x900/0xa90 drivers/hid/wacom_sys.c:179
   __hid_input_report.constprop.0+0x39a/0x4d0 drivers/hid/hid-core.c:2161
   uhid_dev_input2 drivers/hid/uhid.c:618 [inline]
   uhid_char_write+0xa8a/0xfa0 drivers/hid/uhid.c:776
   vfs_write+0x2c0/0xe40 fs/read_write.c:686
   ksys_write+0x1f8/0x250 fs/read_write.c:740
   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xee/0x590 arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

  Allocated by task 4174:
   kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
   kasan_save_track+0x14/0x30 mm/kasan/common.c:78
   poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
   __kasan_kmalloc+0x8f/0xa0 mm/kasan/common.c:415
   kasan_kmalloc include/linux/kasan.h:263 [inline]
   __do_kmalloc_node mm/slub.c:5309 [inline]
   __kmalloc_node_noprof+0x19a/0x4e0 mm/slub.c:5315
   _kmalloc_array_node_noprof include/linux/slab.h:1269 [inline]
   __kfifo_alloc_node+0x11e/0x260 lib/kfifo.c:44
   __kfifo_alloc include/linux/kfifo.h:932 [inline]
   wacom_devm_kfifo_alloc drivers/hid/wacom_sys.c:1315 [inline]
   wacom_parse_and_register+0x2b4/0x5640 drivers/hid/wacom_sys.c:2381
   wacom_probe+0x8d5/0xc40 drivers/hid/wacom_sys.c:2880

  The buggy address belongs to the object at ffff888009179000
   which belongs to the cache kmalloc-256 of size 256
  The buggy address is located 0 bytes inside of
   allocated 256-byte region [ffff888009179000, ffff888009179100)

  Memory state around the buggy address:
   ffff888009179000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
   ffff888009179080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  >ffff888009179100: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                     ^
   ffff888009179180: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
   ffff888009179200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

This is a regression from commit 5e013ad20689 ("HID: wacom: Remove
static WACOM_PKGLEN_MAX limit"), first present in v6.15-rc1. Before
that commit, wacom_raw_event() rejected reports exceeding
WACOM_PKGLEN_MAX (361 bytes) and the kfifo was sized at 512 bytes
(361 rounded up). After the commit, the size cap was removed and the
kfifo is dynamically sized as min(PAGE_SIZE, 10 * pktlen), which can
be as small as 256 bytes.

wacom_wac_queue_insert() passes the report size directly to kfifo_in()
without validating that it fits. When a UHID_INPUT2 event delivers a
report up to 4096 bytes (UHID_DATA_MAX), kfifo_copy_in() writes up to
3840 bytes past the end of the kmalloc-256 slab object.

The fix adds a bounds check in wacom_wac_queue_insert() to reject
reports that exceed the kfifo capacity.

Thanks,
Jinmo

Jinmo Yang (1):
  HID: wacom: validate report size before kfifo insert

 drivers/hid/wacom_sys.c | 6 ++++++
 1 file changed, 6 insertions(+)

-- 
2.53.0

