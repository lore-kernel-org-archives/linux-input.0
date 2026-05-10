Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54B4A32
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 03:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778384854; cv=none; b=fiEGTdGfWUq+Y7q2ErJIQsTGxw9mzdZIcz7u3uIqcYe9RUvHeZyIN2lQlwL2oPaTpybh3rsGSyrSPmW1RgXhp11lSD5cMpraowduVBpEPrZEJF/u1nh6F1FOza/Q++GgM2LeJIetLoGNOw+RemLHCcieIC/wY0l4rFNJkd7un+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778384854; c=relaxed/simple;
	bh=NAeBQlp71txohAsdixn1n5ccPw1C8ZGUtMXPDF5y/1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T0T9+8DEa4y3Po7SSX/ThmpgeiG5mvNpFO0aZic71eb2qJ1CzVbD9jqC/GRRoJmog/SrkMSFODa22GedbuX+0eVFiQQYF07RbpheDCEdzeH3cPnuOqWW3O9CwFyKh/aWU/dvwARXgmVTxBHX9K07ktQ9MLbDNpNz6tuxUzpzMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZbHrkIpC; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZbHrkIpC"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2ee990e8597so5724134eec.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 20:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778384852; x=1778989652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k6rTrBmT6FLZY33HULT543YLCfwvj9/dpCgMERdcga8=;
        b=ZbHrkIpC77RhkMIknmvmPXBS2k6YcyQpYQuBrTAZ2/1oPakUA5ZgdBwdU0v5Ii9P1x
         Wr8oAZ304mPWPonvNLOoOalSHhthl+eJgyFBAVogwOK7TeFn48yzhaGCC/eHaAa4V3vv
         a6JVUZHoAqv4+LgFdGsQ529gCrQO1nIB0q4KpKCrW6nChWmV8NiwCwUJTo7fWcl0Qsyh
         Mw5aWZEOVxgW+bIrY8WXSxh9rbZ7CHrqji/4NPPhOb6LpAO2gD1PP+rjrtNjnRASb6v/
         gfydpUXF+08NgzQOe97y3B1yqUQng5/QIWmnsbV9yIY312Nf4w9gE0eCGD8hfGGfLYgo
         yKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778384852; x=1778989652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k6rTrBmT6FLZY33HULT543YLCfwvj9/dpCgMERdcga8=;
        b=JfDP14oF/VlEMZXmmG8Cw5qmPyXFC9BGFzY4o5I+Yyd4e7di+cK1sCePXAiwzPlASW
         3Gh9wcplEQMFjsknpxjI4OZNVRhHRVxYHsInR2/MRKVepTjuIsD120XEcY3sDjIY8xhR
         6w0yqpp0MJleGraybSdVEC3m+nvVDo5o5sju/VZ9U1FMqSvEXfNzE2FTyokHu0qIemjE
         yF/oPq/51yJaDqMmLIyEbR9B6y7iV3iKFPjZkOzFvOV+SmSZFabX7CNiBH3y0KeFTFwe
         8TX4Oy9LYErfyYi6GWrCPi1WmgSva6O/xqP/TnEUre/R1MI2WBk+UIQyTqlftLB+I7ZP
         5xYw==
X-Forwarded-Encrypted: i=1; AFNElJ9rbHoWVdbb3Ht+g7Ks57WnkVh2MS+FOFW9I1u3vZtz2vmF1qe5OW8mkvhzVFLCmZL0jzmqLa57CK3LNw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzQmkAVO0JHvU7xgy1zlP4OcACOdRhEK+s1wyQXfG4qtn2+jYiq
	mYY0oF5milF5rSbXAwHsP0phbBUYduOToHBG+jkWH+yY1zjlu+VhsNNX
X-Gm-Gg: Acq92OFLHsrEGSzHmby4t7q0K68qRiWHwLxbveMx/bBzsa1dUrjbOG4CAl9hfgG2Dhs
	37tcqNKQ1oGVp21CU2gCr1rmh55lYL9hmo9rj/+RiId5gusnY8uvX+rVXE8PCvO+RNBIZwK4ffM
	u+5GxfT2uUyo10HeDSGWnocGcY7pUTpHTzjgdjVsEfwabny9IiuQaOr+ZbBgdmDfQbix4s0Cy7X
	yduzj7ADK9iOfnxi+B5acM30MjqleX1INhNSVZJknqIMV6d889ETE8XIx7b0AJSkgIdm6dg9CKA
	ybmaIcjTiazO4DKQom7IT6mT2StfmClCojXvzRWtJUBGTtJfaKt2TPgzkR9hkdx6sZOfjrzGHHr
	81H5pEFSAJbikwBo+m96F6uzdi9EtH4u5EJaTIShDVH+/8bRQnTD1lGdNg37Wqhd0oBznBeYQOw
	V8GOWFATXviR6HNhTKtH2I+mAhq7HfjUxLVNM5fnxw4P9vRt5qoCs07NjxVYiqmkAi0S+zEW//R
	tfahmWkHcfwJYpjXkCD56CVMceQ5GEg8xRhnm6XY0BAnLMZPwksIgQ68sfkEHvGdCfQ2Rxj2xqc
	xUayAbnDSafYhWjmwuU5r3bNkCS1
X-Received: by 2002:a05:7300:818d:b0:2e5:8ec2:82c9 with SMTP id 5a478bee46e88-2f54b57e91amr9832824eec.26.1778384851712;
        Sat, 09 May 2026 20:47:31 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8884750ffsm8368768eec.19.2026.05.09.20.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 20:47:31 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Linus Walleij <linusw@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] ARM: riscpc: convert to sparse IRQs
Date: Sat,  9 May 2026 20:46:38 -0700
Message-ID: <20260510034652.349166-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To improve future maintainability, change the interrupt handling for
mach-rpc to use sparse IRQs.

Since the number of possible interrupts is already fixed and relatively
small, just make it use all legacy interrupts preallocated using the
.nr_irqs field in the machine descriptor, rather than actually
allocating domains on the fly.

Several files had to be adjusted to include <mach/irqs.h>
explicitly because it is no longer implicitly included with sparse
IRQs.

Description adapted from commit c78a41fc04f0 ("ARM: s3c24xx: convert
to sparse-irq").

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
This commit depends on my previous submission "ARM: <asm/floppy.h>: fix
build with sparse IRQs".

 arch/arm/Kconfig                      | 2 +-
 arch/arm/mach-rpc/dma.c               | 1 +
 arch/arm/mach-rpc/ecard.c             | 2 +-
 arch/arm/mach-rpc/include/mach/irqs.h | 2 +-
 arch/arm/mach-rpc/irq.c               | 3 ++-
 arch/arm/mach-rpc/riscpc.c            | 2 ++
 arch/arm/mach-rpc/time.c              | 1 +
 drivers/input/mouse/rpcmouse.c        | 2 +-
 drivers/input/serio/rpckbd.c          | 1 +
 9 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 71fc5dd4123f..09b2767fee0f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -153,7 +153,7 @@ config ARM
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC
 	select RTC_LIB
-	select SPARSE_IRQ if !(ARCH_FOOTBRIDGE || ARCH_RPC)
+	select SPARSE_IRQ if !ARCH_FOOTBRIDGE
 	select SYS_SUPPORTS_APM_EMULATION
 	select THREAD_INFO_IN_TASK
 	select TIMER_OF if OF
diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
index 717a81475670..238aa59612a8 100644
--- a/arch/arm/mach-rpc/dma.c
+++ b/arch/arm/mach-rpc/dma.c
@@ -17,6 +17,7 @@
 #include <asm/fiq.h>
 #include <asm/irq.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <linux/uaccess.h>
 
 #include <asm/mach/dma.h>
diff --git a/arch/arm/mach-rpc/ecard.c b/arch/arm/mach-rpc/ecard.c
index 972465840548..27af35bd6a79 100644
--- a/arch/arm/mach-rpc/ecard.c
+++ b/arch/arm/mach-rpc/ecard.c
@@ -46,9 +46,9 @@
 #include <asm/dma.h>
 #include <asm/ecard.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/irq.h>
 #include <asm/mmu_context.h>
-#include <asm/mach/irq.h>
 #include <asm/tlbflush.h>
 
 #include "ecard.h"
diff --git a/arch/arm/mach-rpc/include/mach/irqs.h b/arch/arm/mach-rpc/include/mach/irqs.h
index 0c3428fd9729..738a9457c473 100644
--- a/arch/arm/mach-rpc/include/mach/irqs.h
+++ b/arch/arm/mach-rpc/include/mach/irqs.h
@@ -39,4 +39,4 @@
  */
 #define FIQ_START		64
 
-#define NR_IRQS			128
+#define RPC_NR_IRQS		128
diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
index 649d81874c86..5e3414fc3657 100644
--- a/arch/arm/mach-rpc/irq.c
+++ b/arch/arm/mach-rpc/irq.c
@@ -5,6 +5,7 @@
 
 #include <asm/mach/irq.h>
 #include <mach/iomd.h>
+#include <mach/irqs.h>
 #include <asm/irq.h>
 #include <asm/fiq.h>
 
@@ -177,7 +178,7 @@ void __init rpc_init_irq(void)
 
 	set_handle_irq(iomd_handle_irq);
 
-	for (irq = 0; irq < NR_IRQS; irq++) {
+	for (irq = 0; irq < RPC_NR_IRQS; irq++) {
 		clr = IRQ_NOREQUEST;
 		set = 0;
 
diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index d068f5e4873d..bdad13226c6d 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -23,6 +23,7 @@
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
 #include <mach/iomd.h>
+#include <mach/irqs.h>
 #include <asm/page.h>
 #include <asm/domain.h>
 #include <asm/setup.h>
@@ -219,6 +220,7 @@ MACHINE_START(RISCPC, "Acorn-RiscPC")
 	.reserve_lp0	= 1,
 	.reserve_lp1	= 1,
 	.map_io		= rpc_map_io,
+	.nr_irqs	= RPC_NR_IRQS,
 	.init_irq	= rpc_init_irq,
 	.init_time	= ioc_timer_init,
 	.restart	= rpc_restart,
diff --git a/arch/arm/mach-rpc/time.c b/arch/arm/mach-rpc/time.c
index 566113f9774f..02f0fd58c7da 100644
--- a/arch/arm/mach-rpc/time.c
+++ b/arch/arm/mach-rpc/time.c
@@ -18,6 +18,7 @@
 
 #include <mach/hardware.h>
 #include <mach/iomd.h>
+#include <mach/irqs.h>
 
 #include <asm/mach/time.h>
 
diff --git a/drivers/input/mouse/rpcmouse.c b/drivers/input/mouse/rpcmouse.c
index 475c3ca22fd4..cead12069319 100644
--- a/drivers/input/mouse/rpcmouse.c
+++ b/drivers/input/mouse/rpcmouse.c
@@ -22,8 +22,8 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/irq.h>
 #include <mach/iomd.h>
+#include <mach/irqs.h>
 
 MODULE_AUTHOR("Vojtech Pavlik, Russell King");
 MODULE_DESCRIPTION("Acorn RiscPC mouse driver");
diff --git a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
index e452ad07e2fa..7bcaed28c7a4 100644
--- a/drivers/input/serio/rpckbd.c
+++ b/drivers/input/serio/rpckbd.c
@@ -18,6 +18,7 @@
 
 #include <mach/hardware.h>
 #include <mach/iomd.h>
+#include <mach/irqs.h>
 
 MODULE_AUTHOR("Vojtech Pavlik, Russell King");
 MODULE_DESCRIPTION("Acorn RiscPC PS/2 keyboard controller driver");
-- 
2.43.0

