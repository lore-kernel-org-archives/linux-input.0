Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E760619DF6A
	for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 15:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781450167; cv=none; b=LMmKaBOuEmF/vyeTE3ByYTCm5xNkB3M1li0iMehTa5+DAK3PUEeQA3LZnlj08AdMx+5id/fdYabR+koLlyzLNH/zeCbv/fTJvZbFPXAtDyNyPYoN9sgSES3ynzwxAYc1BaRNfz3xCo2Xu3RnLdrGcuB0iz9cKdJ9C4YDPxP1uOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781450167; c=relaxed/simple;
	bh=KsiBdM29Z31IWGwReRDV0UiELmpoei4WY4j3z0REASQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t2/DUpB+M8JPCwIV/h8tx5p9mwp4LSIj3lcvjstvJyEtprkq9GiSyZ7ZJENPiYegobTiDFFdRlOQ+6tHEG9bSIBufZmDbdp8xVU+SYtOsjn5TlG8lMw0qco4UGY6SaTnBd5YjY+e12pCpGoRupRUckE7y4ywItAAUESPZbjXvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhemttDI; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhemttDI"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8ccf887de87so28634456d6.0
        for <linux-input@vger.kernel.org>; Sun, 14 Jun 2026 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781450165; x=1782054965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=96qLnGS8PkozSC6agDrDXQYTECdna8L3lhENtXMw/Vw=;
        b=DhemttDIzu7GJ+EU0eW+KzZwZYRvv2Eu3yiGXoCkVqauNeM9hjcpD3HNzAO6hnYl1D
         A3xaobdlokzcvtRepDQvr8UdE/fWIpWWNbKcQZZBsFIFBljOCHXAGA1UOu4GuvFtG9UB
         hncJHJfH/E2zXaHtM8FJ/nQnLyPl1wWKUpDonbbXw8a7bhWzhe1CBk5ultEHvz0Kqo1Q
         hG3Qs8RDa8HduHO+3Br6NqBDOQOwjnvVCmn3mltMI7cBS/RH2akKdDXu3z49RAW01QeL
         VWne4E0qRr0GI8BOq5DSd8Cd7SR5FjJU9j0aqTk5+Kb9EcraXHEIrvZ7+D8Q2jjmUsu8
         SmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781450165; x=1782054965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96qLnGS8PkozSC6agDrDXQYTECdna8L3lhENtXMw/Vw=;
        b=GfmYDBLpIubKYRHt+WHPOm91XwyEOD74ZUAZgwrHs8OYR7Kn0rOZzYrNaXlvSXQEVH
         G9cRKfc61Es6IwFgFWjAdb4ANu1fQaf1c+8hxLAObI3sDfQfqBiQzYqFA+nDXbIXIzAt
         3j1+Rj7U6I62SEOTYAM2P88xoH4/nkYsRYgHrnJGcULmg4oooGLC5jDCChA22YhvRF6O
         e6WKALdavvs6UR9hCc+Z6o0/6dmw/L3uQw4FuTWnnm04IGTaKrc0Ra9sOAHP+Ge5R3rf
         C4oN+XyZAjtICVsxQ99NFfIV4O5YABQBFpBFRnJXL9VtmmWRuM6oKMqntZ7NHMPXCkus
         Z/0g==
X-Forwarded-Encrypted: i=1; AFNElJ8tJVB30kRHEfY48aRCNeUIXcf90czDCxswPHhO4wWAtVQVYFkBIDzg5WAaclqEIN2GIUQAOxAiREBV7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2wpmyOY5N/BvmYmgftnTd1dSYR5tf5r14GrmW0ofU44jMRgg
	hqsj5MGA7V/N3hnwRaAnvHEw1BwLR8mLemDZnrNpx4TYFQvl0nyGrpVg
X-Gm-Gg: Acq92OHpWCdl5yM1Wdl1uU3dh235P2qW3TTBs4O6RoEy0fmY6U3GZ/9dfi/BL/ni/Bo
	xh5vv+b/oj0oYyr/z6nBjs9AqcWqLQ+LlJ73SaPLEBYc1r29G473k677cIs/rJgcLqae7+46qy1
	ls4IV3NLtvSqnDQk4kEHU0rN2v0JPMAj7Q8APxVsbIeBK15JUKEs1+nHzkI13UmrXJqInT/4eXg
	qT5QN3VPYC2mm7chpWcmgBi10SULbrDLvgsf2rwzcYDCp7YW9UO79LTQPIROn85YnB31+biHN94
	oSsl7tSu368ypyKxIr+XfXinguwbKxLzsxcLM7wdwbc5FvaXqij+IXT95XUquM4BglwVrGJYpVM
	UWVkwCgOczcGQDM6FAyojHe07A812KCR3lWkZiK0fFMXqaGKTfDA8R3M+ACq5XCEXJk/Mj3KNnk
	gp0Ns8ePBmfT3mTfMpo9SYTE9C24lK89TMGQaVZJKGgcd/Frykuo5boNpFff0=
X-Received: by 2002:a05:6214:19ec:b0:8ac:a6bd:503b with SMTP id 6a1803df08f44-8d32c4e9ccemr192927216d6.15.1781450164642;
        Sun, 14 Jun 2026 08:16:04 -0700 (PDT)
Received: from localhost.localdomain ([168.92.225.3])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d301060e22sm81871886d6.7.2026.06.14.08.16.03
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 08:16:04 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [BUG] KASAN: slab-out-of-bounds in rmi_create_function
Date: Sun, 14 Jun 2026 11:16:02 -0400
Message-ID: <178144969600.60470.6869216573402531557@gmail.com>
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

KASAN: slab-out-of-bounds in rmi_create_function

on commit: e8c2f9fdadee7cbc75134dc463c1e0d856d6e5c7 (May 25 2026)

To help trigger the bug more reliably, we applied a minimal diagnostic patch
that only adds delays and print statements.

The reproducer and .config files are here.
https://gist.github.com/shuangpengbai/6f392317d13655f16a8983fe1587dbcc

I'm happy to test debug patches or provide additional information.

Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>

[  128.210187][   T10] BUG: KASAN: slab-out-of-bounds in rmi_create_function (include/linux/instrumented.h:97 include/asm-generic/bitops/instrumented-atomic.h:28 drivers/input/rmi4/rmi_driver.c:861)
[  128.210768][   T10] Write of size 8 at addr ffff888178e09b50 by task kworker/0:1/10
[  128.211308][   T10]
[  128.211489][   T10] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  128.211492][   T10] Workqueue: events acpi_table_events_fn
[  128.211499][   T10] Call Trace:
[  128.211501][   T10]  <TASK>
[  128.211503][   T10]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[  128.211508][   T10]  print_report (mm/kasan/report.c:378 mm/kasan/report.c:482)
[  128.211520][   T10]  kasan_report (mm/kasan/report.c:595)
[  128.211526][   T10]  kasan_check_range (mm/kasan/generic.c:? mm/kasan/generic.c:200)
[  128.211530][   T10]  rmi_create_function (include/linux/instrumented.h:97 include/asm-generic/bitops/instrumented-atomic.h:28 drivers/input/rmi4/rmi_driver.c:861)
[  128.211533][   T10]  rmi_scan_pdt (drivers/input/rmi4/rmi_driver.c:525 drivers/input/rmi4/rmi_driver.c:552)
[  128.211549][   T10]  rmi_init_functions (drivers/input/rmi4/rmi_driver.c:1074)
[  128.211565][   T10]  rmi_driver_probe (drivers/input/rmi4/rmi_driver.c:1207)
[  128.211569][   T10]  really_probe (drivers/base/dd.c:? drivers/base/dd.c:709)
[  128.211571][   T10]  __driver_probe_device (drivers/base/dd.c:871)
[  128.211579][   T10]  driver_probe_device (drivers/base/dd.c:901)
[  128.211581][   T10]  __device_attach_driver (drivers/base/dd.c:1029)
[  128.211587][   T10]  bus_for_each_drv (drivers/base/bus.c:500)
[  128.211600][   T10]  __device_attach (drivers/base/dd.c:1101)
[  128.211613][   T10]  device_initial_probe (drivers/base/dd.c:1156)
[  128.211616][   T10]  bus_probe_device (drivers/base/bus.c:613)
[  128.211619][   T10]  device_add (drivers/base/core.c:3706)
[  128.211623][   T10]  rmi_register_transport_device (drivers/input/rmi4/rmi_bus.c:98)
[  128.211626][   T10]  rmi_spi_probe (drivers/input/rmi4/rmi_spi.c:435)
[  128.211629][   T10]  really_probe (drivers/base/dd.c:? drivers/base/dd.c:709)
[  128.211631][   T10]  __driver_probe_device (drivers/base/dd.c:871)
[  128.211634][   T10]  driver_probe_device (drivers/base/dd.c:901)
[  128.211636][   T10]  __device_attach_driver (drivers/base/dd.c:1029)
[  128.211641][   T10]  bus_for_each_drv (drivers/base/bus.c:500)
[  128.211653][   T10]  __device_attach (drivers/base/dd.c:1101)
[  128.211671][   T10]  device_initial_probe (drivers/base/dd.c:1156)
[  128.211674][   T10]  bus_probe_device (drivers/base/bus.c:613)
[  128.211676][   T10]  device_add (drivers/base/core.c:3706)
[  128.211679][   T10]  __spi_add_device (drivers/spi/spi.c:756)
[  128.211689][   T10]  acpi_register_spi_device (drivers/spi/spi.c:786 drivers/spi/spi.c:3055)
[  128.211697][   T10]  acpi_spi_notify (drivers/spi/spi.c:5093)
[  128.211699][   T10]  notifier_call_chain (kernel/notifier.c:85)
[  128.211702][   T10]  blocking_notifier_call_chain (kernel/notifier.c:380)
[  128.211705][   T10]  acpi_generic_device_attach (drivers/acpi/scan.c:2297)
[  128.211710][   T10]  acpi_bus_attach (drivers/acpi/scan.c:2323 drivers/acpi/scan.c:2372)
[  128.211740][   T10]  device_for_each_child (drivers/base/core.c:4035)
[  128.211751][   T10]  acpi_dev_for_each_child (drivers/acpi/bus.c:1208)
[  128.211761][   T10]  acpi_bus_attach (drivers/acpi/scan.c:2393)
[  128.211776][   T10]  device_for_each_child (drivers/base/core.c:4035)
[  128.211787][   T10]  acpi_dev_for_each_child (drivers/acpi/bus.c:1208)
[  128.211797][   T10]  acpi_bus_attach (drivers/acpi/scan.c:2393)
[  128.211816][   T10]  device_for_each_child (drivers/base/core.c:4035)
[  128.211827][   T10]  acpi_dev_for_each_child (drivers/acpi/bus.c:1208)
[  128.211839][   T10]  acpi_bus_attach (drivers/acpi/scan.c:2393)
[  128.211859][   T10]  acpi_bus_scan (drivers/acpi/scan.c:2743)
[  128.211871][   T10]  acpi_table_events_fn (drivers/acpi/scan.c:2933)
[  128.211874][   T10]  process_scheduled_works (kernel/workqueue.c:3314 kernel/workqueue.c:3397)
[  128.211879][   T10]  worker_thread (kernel/workqueue.c:3478)
[  128.211884][   T10]  kthread (kernel/kthread.c:436)
[  128.211891][   T10]  ret_from_fork (kernel/process.c:158)
[  128.211902][   T10]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)


Best,
Shuangpeng
