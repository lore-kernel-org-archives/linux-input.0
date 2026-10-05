Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81124274641
	for <linux-input@vger.kernel.org>; Mon,  5 Oct 2026 03:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791172760; cv=none; b=EwUNMP6pcKzvh6gURWAQP/kAghLhs90QwDynGQzlkdPdsbz4th3CJtcR58jj3MdDuRIRGlvI88kc9KDrB2KekoYdZyFEeTIEynXZHP8f8ckyD6j/GbXnucqdzrcXvbfgED5yYd6PBf18GZotQfhK3e2GTuMkOOTJYynd+mcy/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791172760; c=relaxed/simple;
	bh=/YL/NDw4Vut9GC0llIGjtY5kgFOw0zHyjbzHjLKiEeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cQgqBLrRqjT66EDTshdqk8ny2Q+wkjffJYTSnDgkD7cUu4HvQjXW3D+0J9z59+GKcypLU8jF9HnXeMom3Eaclsot/UTDWhhpyF59HMSqH5XFCNYlcNgwjTdx0sNn4y+6En/C9o23REtQXFYMa4PpffehYYO5cb3Iu1TCbKDZfGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVDLRo6V; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVDLRo6V"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-888b8fe095aso337391b3a.2
        for <linux-input@vger.kernel.org>; Sun, 04 Oct 2026 20:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791172759; x=1791777559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hqPHoZukMon/XfTDSqXj38S4m3E3GhiGtLb2lk8wRjE=;
        b=dVDLRo6VDTrY6K5YWpPtEOquxb0BhZTnchMH9baziq6IOi9jRpAeTfJqUVpigTMWON
         +qjXKWemfNh8AyIETD9G/J6gawZI9o+Gw57Bfi4tlXgQ5rfjTWC6lVSUhQKuvoU1Mnax
         05Qm9KGnz5Qq7R1nuZh3D4W7Pac+qm6BaRInv8Wxrbe2SBB/o9cW9j9+ZXq9hFbhql9b
         Gfop0FlRn+WPcmij1l7LHqNvW6n6sR57S5PIzNDNfOlRMJrwhitRphEgihLLEviq6GmI
         LIU3jxDrI4kibZf4q6PtlZVwaL7njQ9IXdjghetAdLL9P0tF2NFr9hpTMWnkE2C+VxhK
         KLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791172759; x=1791777559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hqPHoZukMon/XfTDSqXj38S4m3E3GhiGtLb2lk8wRjE=;
        b=hLqMNCx463KLby/6kHhgcjbcAXg1lFYxWVnxJrQtjiB+sAfnspGijyH7Obq8282A95
         GL0qIEZA6fbxSadIxqz0aLrSv52ooim1s3ZJhxlRMoAZiNBztqTp0Px5xexhvyDeqY+2
         QYMae6IzaloPH4RlOt/5GCL9gLkv9BrFXOG2i71OrrMv6FEGRspmYDbv2uD3tjnnPetx
         Zxl1chNn+LF5wpcdB6vNBi46NxaO7Xygh13TRCwyyik8dzvFwGcQ6rSzh36XFxQ4ocnC
         IMFvH6xej/N2xx37Kh7QsZFPXZBxWhPOl9uJrkunGdJfYVFYH+xYVzFJgTrCpV9HKKQD
         dCpQ==
X-Forwarded-Encrypted: i=1; AKwUvBxdHKue1sbpsrv+Lvh+qIRw+WDkmTEf43ftW+GbcPRzYrCk41zST1m+ea4Tff/LK6k8Nec19y5CXvg9jQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lOcrblbV+0qcXNJQFyzpV2CUEFySe+pRFOO0yu1x9WPIu+apBa
	m8piVwvKMryqi2WvPLuerKKh4FWirokoc1J51rkXWB4zwc72odoSYl/4
X-Gm-Gg: AYBFou36NAfD01P1GnV7VcKQsMXYSKyDM/zTT9mpKJkDEu8jMR71ZjUcXZuUAbDC5Iy
	KbG2+wd+u8wyoitCZG7BK5SSY+RkBRHkUNSMhUhPit1Nm8mc+Ve/LVi7ogwPRyNgk8/V74UhZy3
	ZEQTJvdAUpM2G9dYgCM2WN9Bed8wt/O6iSt842GK6xg93Unea9JMt58LFHBeUfYJIeXSp2UmqSg
	+DcRTYQRZTui1/DcXc1FGVmAnU5VAcfn63w6zgCERducFkTDmTtP16zS9SCpnihdKAKeltS00uM
	EDE9Vx8JxDCHs+yERZHLlGyDNqGK6aJ82ZzwnMSjvHLYTsx7MnaJD4/P4o+g1axI6GZGze9Z3NU
	E1HsbijadKvZUQEbNTKO3S1Ahb84W/Yy4sKlHXEgVK/ssF66h7qqP/Q4GcpVujxs7ftX5NEDSzy
	6P+9WMU7z71piJvcco/bAQek6BeCgySd+fVAG2Mchcg26a3Rzu3yKYXD09EKTHJuUd4Ye0inDEH
	YpOHqbXJpbBNgNyYxKoGYQ=
X-Received: by 2002:a05:6a00:2986:b0:886:5938:cdd4 with SMTP id d2e1a72fcca58-88c631c679bmr5326680b3a.19.1791172758715;
        Sun, 04 Oct 2026 20:59:18 -0700 (PDT)
Received: from jmoon ([118.220.156.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0c79273dsm2879126b3a.40.2026.10.04.20.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 20:59:18 -0700 (PDT)
From: Jinmo Yang <jinmo44.yang@gmail.com>
To: ping.cheng@wacom.com,
	jason.gerecke@wacom.com,
	jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jinmo Yang <jinmo44.yang@gmail.com>
Subject: [PATCH v2 0/1] HID: wacom: fix sibling use-after-free in mode change
Date: Mon,  5 Oct 2026 12:59:08 +0900
Message-ID: <20261005035912.910925-1-jinmo44.yang@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004111353.118025-1-jinmo44.yang@gmail.com>
References: <20261004111353.118025-1-jinmo44.yang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please drop v1 and take this instead. v1 carries a Fixes tag and Cc: stable
but does not fix what it claims to, and it adds a second problem.

The Sashiko AI review of v1 is right: wacom_remove() stops the hardware and
cancels the delayed work before it takes the new mutex, so a sibling worker
holding that mutex can bring the device back up afterwards through
wacom_parse_and_register(), and removal never repeats those steps. Two
things escape:

 - hidraw stays registered on an unbound device. hidraw_disconnect() is
   reached only from hid_disconnect(), which is reached only from
   hid_hw_stop(); neither hid_destroy_device() nor hid_remove_device()
   touches it. That one is from reading the code.

 - init_work is re-armed on memory devres is about to free, because
   wacom_parse_and_register() calls wacom_query_tablet_data() ->
   schedule_delayed_work(&wacom->init_work, 1s). That one KASAN catches.

Moving my test-only delay to just after the worker's hid_hw_stop(), so that
a concurrent wacom_remove() runs its own hid_hw_stop() inside it, gives this
on v1 five boots out of five:

  BUG: KASAN: slab-use-after-free in __run_timer_base.part.0
  Write of size 8 at addr ffff88800bc1b460 by task swapper/0/0
   run_timer_softirq / handle_softirqs / sysvec_apic_timer_interrupt
  Allocated by task 11:  devm_kmalloc <- wacom_probe
  Freed by task 79:      devres_release_group <- hid_device_remove,
                         under uhid_char_release <- __x64_sys_close

1120 bytes into the freed object is inside wacom->init_work.timer
(offsetof(struct wacom, init_work) is 984 and its timer sits at +72 here,
from vmlinux DWARF).

My v1 testing missed all of this because the delay sat in
wacom_set_shared_values(), after the worker's hid_hw_start(), so the window
never opened. The clean v1 result was real but it was not testing this.

Changes in v2, all in wacom_remove(); the worker is unchanged:

 - Take the mutex before hid_hw_close()/hid_hw_stop() rather than after,
   and move the remaining cancel_*_work_sync() calls and
   timer_delete_sync(&wacom->idleprox_timer) inside it, so the whole
   teardown is covered.
 - Keep cancel_work_sync(&wacom->mode_change_work) before the mutex, where
   it has to be: a worker blocked on the mutex would deadlock it.
 - Add a second cancel_work_sync(&wacom->mode_change_work) after the
   unlock, because moving hid_hw_stop() inside the mutex lets a report
   queue our own work again after the first cancel. That work can only find
   a NULL wacom_wac.shared and return, and the mutex is free by then so it
   cannot deadlock.

Same kernel and reproducer as v1 (x86_64, hid.git master, KASAN,
PROVE_LOCKING, one fresh QEMU guest per round). v2 is clean 10/10 with the
original delay placement and 5/5 with the one above, no lockdep report and
no leftover /sys/class/hidraw node; unpatched is 10/10 KASAN. The cost of
the global mutex and the untouched wacom_wireless_work() are as described
in v1 -- v2 only widens the hold to cover removal's own hid_hw_stop().

v1: https://lore.kernel.org/linux-input/20261004111353.118025-1-jinmo44.yang@gmail.com/
Sashiko: https://lore.kernel.org/linux-input/20261004112812.460B21F000FF@smtp.kernel.org/

Thanks,
Jinmo

Jinmo Yang (1):
  HID: wacom: serialize mode changes with device removal

 drivers/hid/wacom_sys.c | 60 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 10 deletions(-)


base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.53.0

