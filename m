Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0759A313E00
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 05:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778390501; cv=none; b=UN1XCJm3DsQ5vPDJrsv4p3guuOmGYlhBqdBEJQVEFe5UgWbZOc1HPBPfs0nUNcx8Soyh35YZmvZrJeGTvmP2lg4nVtXO78ctwjGgs/sVEoEQ9mncW8fhbBkgaDn1ju3eJSfEE/U8CdgWy6H7Mc43na6MqOY2yaI24/8zcS5z2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778390501; c=relaxed/simple;
	bh=iyfgSATq+jlurSkwX0XjsG0MidymjoDXh1Dg0XL0i60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGwkXz1buJan7+WfUB8+vy8hXLJAWta440G4y7srjWFAOoz/1gvaw70umrX7cRNoyPYRWSh/TX4H1X/F0m2wBzYUWqlybHlnVyovplR1vFbacR9s77LKZGmWMbp+0yhBwwCh3p2wc9aAnCvNI14AISl4GTHnfOlqbj8y9j53tjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G5ByJJtU; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G5ByJJtU"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so8768759eec.1
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 22:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778390499; x=1778995299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ByD/C9lLdqNb5sEC4Ll4SpfSx43c4fiEK3gBugZ/0MQ=;
        b=G5ByJJtU6fzeIpeX1Y3ul3tMQ7eM5e9YXANyFZy1bC91eqckFJD4ECzkulv9uz70/u
         /YieCODTTVFzDIyi6QRlrOHw1SYAnETGMBlWEcHy4DVOwoX0sQ3OqDPCjoEIliUHRQc/
         LwKa2uI8KE+0TFnccN7x9nWPajI/yQUGtS8UKFbYGWq5PAD6NbjC658cwhkUsEZlIv3b
         3EQQq+5PMQ3fiAci39RIjrSie+45kkpP9GAes0IdgNKShfmEitN1BmNtueptSJqzHLUi
         xRLMKMNaZnqn+eexOJq/vWKRwlwgv08xFUFaImRipI7vQyOnb4AZjcm6ztpaITpYOU69
         JOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778390499; x=1778995299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ByD/C9lLdqNb5sEC4Ll4SpfSx43c4fiEK3gBugZ/0MQ=;
        b=VEoGGdFWZIKNQCNfhGpDvlJxh2Y/wOTbHf27yZs3vxlXkuSu/W3rg9oYsgK1UwTEFI
         G1/HjRYdqeihFco+0rrGpekB7DS2lU7bj3ETKI066hRYNMM03WLyKpFffGlfKV6wkV0n
         QLTwD53BWacY8v1ytReZZm8wEH9xiQ98u3UKmBMdKqtbCOaMPTlCBXSu6s0gzyLEV2sF
         gY2TQ4KXw7YJ0FeDefyspZxhfSRh4cdyjBI9v4JDt9j3DzdQf72lPIpQCscgFzdVM/9b
         ptJnlb7gIozpQDgaWnUGZMbUh1Af7fs0H/U95e39Id609zxeFPd4mqWlB7hHfasTYw7o
         PttA==
X-Forwarded-Encrypted: i=1; AFNElJ98KersCNymRxhj4JjmJ3zJ7HrW70QdB5HPfoYIPu90+QtFzETd1+L6PKacn+FxABB8wAtUsHZlZ/YLHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5HKLfUDyjhYS5icncih6puD7SL4ZQyZg2p4SbPtCE1yFZIqoC
	qGyrvNHEmIygOrr7lNTPHreE0MG/V2JmKhma6GG0sH358d9WvpwS01c+
X-Gm-Gg: Acq92OFmg9TCaB45VajN6DQGHHS1S7zNhBUxJAFVrW9BfU0ehSk/OO20ZN73h4bmNEy
	Wonyzk00k1UE+kry7af/vW+zRhexasMSEoyLEFZb0L4dARo+HKeZMeBtZLfTnCk/A/qQWpjg9pn
	lRNACOuq4TCXBCMMjKO18SYb1eJkEYrg3H9IrfvYXlaVEmU4unyKCyOO6/sXavfgv/rky7EO5/O
	jVvLoZyWmqrcK588S9XivXaTE8ltQwZbguLEiu9Q3kV/sbssbEXU5unUB2+alS1GMTb99I8+et2
	p1uVtqpoTcl2OOLaDDU7BzBuUtvGOtq9pQmqi1QoSFakOjQoogrVEEBOT40Deu0a+6hRq8ELGY9
	ru1zfWcBukBp4rnRytt0UBCFY7ATuUk/Y/fg9mk0LzHBv+OJCEEjL9ub6nOe6YX/M2YYFvuxTcd
	fBD9Mt0ra5GML6/cyUYAd0H0TKD63hq3q6qjDeLOCE7VuvoJdg799TxALSsdIeu+LXhFIXLfQ0T
	qKu/YGhcWRFlHlUTsJnLUSdf1JAfwc9x7dOMiEU0GPbcCgaNLsrPpVuAJCrQ9arjWb5WaF2EjKV
	h/h/V5Us7pkh5NvJMQ==
X-Received: by 2002:a05:7301:7c12:b0:2d8:df01:d9f7 with SMTP id 5a478bee46e88-2f54b891fd0mr10659278eec.15.1778390498897;
        Sat, 09 May 2026 22:21:38 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c469b6sm8749587eec.24.2026.05.09.22.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 22:21:38 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Linus Walleij <linusw@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] ARM: footbridge: convert to sparse IRQs
Date: Sat,  9 May 2026 22:20:49 -0700
Message-ID: <20260510052107.555825-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To improve future maintainability, change the interrupt handling for
mach-footbridge to use sparse IRQs.

Since the number of possible interrupts is already fixed and relatively
small, just make it use all legacy interrupts preallocated using the
.nr_irqs field in the machine descriptor, rather than actually
allocating domains on the fly.

Many files had to be adjusted to include <mach/irqs.h>
explicitly because it is no longer implicitly included with sparse
IRQs.

Description adapted from commit c78a41fc04f0 ("ARM: s3c24xx: convert
to sparse-irq").

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
This commit depends on my previous submission "ARM: <asm/floppy.h>: fix
build with sparse IRQs".

 arch/arm/Kconfig                             | 2 +-
 arch/arm/include/asm/irq.h                   | 4 +++-
 arch/arm/mach-footbridge/dc21285-timer.c     | 2 +-
 arch/arm/mach-footbridge/dc21285.c           | 2 +-
 arch/arm/mach-footbridge/ebsa285-pci.c       | 2 +-
 arch/arm/mach-footbridge/ebsa285.c           | 2 ++
 arch/arm/mach-footbridge/include/mach/irqs.h | 4 +---
 arch/arm/mach-footbridge/isa-irq.c           | 2 +-
 arch/arm/mach-footbridge/isa-timer.c         | 2 +-
 arch/arm/mach-footbridge/isa.c               | 2 +-
 arch/arm/mach-footbridge/netwinder-hw.c      | 2 ++
 arch/arm/mach-footbridge/netwinder-pci.c     | 2 +-
 drivers/char/nwbutton.c                      | 2 +-
 drivers/input/serio/i8042-io.h               | 6 +++---
 drivers/tty/serial/21285.c                   | 2 +-
 15 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 09b2767fee0f..1155c78bb6aa 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -153,7 +153,7 @@ config ARM
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC
 	select RTC_LIB
-	select SPARSE_IRQ if !ARCH_FOOTBRIDGE
+	select SPARSE_IRQ
 	select SYS_SUPPORTS_APM_EMULATION
 	select THREAD_INFO_IN_TASK
 	select TIMER_OF if OF
diff --git a/arch/arm/include/asm/irq.h b/arch/arm/include/asm/irq.h
index 26c1d2ced4ce..08589b88c3b9 100644
--- a/arch/arm/include/asm/irq.h
+++ b/arch/arm/include/asm/irq.h
@@ -10,7 +10,9 @@
 #define NR_IRQS NR_IRQS_LEGACY
 #endif
 
-#ifndef irq_canonicalize
+#ifdef CONFIG_ARCH_FOOTBRIDGE
+#define irq_canonicalize(i)	(((i) == 2) ? 9 : i)
+#else
 #define irq_canonicalize(i)	(i)
 #endif
 
diff --git a/arch/arm/mach-footbridge/dc21285-timer.c b/arch/arm/mach-footbridge/dc21285-timer.c
index 2908c9ef3c9b..7d7ad1c1ef3f 100644
--- a/arch/arm/mach-footbridge/dc21285-timer.c
+++ b/arch/arm/mach-footbridge/dc21285-timer.c
@@ -12,7 +12,7 @@
 #include <linux/irq.h>
 #include <linux/sched_clock.h>
 
-#include <asm/irq.h>
+#include <mach/irqs.h>
 
 #include <asm/hardware/dec21285.h>
 #include <asm/mach/time.h>
diff --git a/arch/arm/mach-footbridge/dc21285.c b/arch/arm/mach-footbridge/dc21285.c
index e1b336624883..ffdecfadc9e2 100644
--- a/arch/arm/mach-footbridge/dc21285.c
+++ b/arch/arm/mach-footbridge/dc21285.c
@@ -17,7 +17,7 @@
 #include <linux/io.h>
 #include <linux/spinlock.h>
 
-#include <asm/irq.h>
+#include <mach/irqs.h>
 #include <asm/mach/pci.h>
 #include <asm/hardware/dec21285.h>
 
diff --git a/arch/arm/mach-footbridge/ebsa285-pci.c b/arch/arm/mach-footbridge/ebsa285-pci.c
index c3f280d08fa7..d2168660dd01 100644
--- a/arch/arm/mach-footbridge/ebsa285-pci.c
+++ b/arch/arm/mach-footbridge/ebsa285-pci.c
@@ -10,7 +10,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 
-#include <asm/irq.h>
+#include <mach/irqs.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
diff --git a/arch/arm/mach-footbridge/ebsa285.c b/arch/arm/mach-footbridge/ebsa285.c
index 1cb7d674bc81..a820f7467468 100644
--- a/arch/arm/mach-footbridge/ebsa285.c
+++ b/arch/arm/mach-footbridge/ebsa285.c
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/leds.h>
 
+#include <mach/irqs.h>
 #include <asm/hardware/dec21285.h>
 #include <asm/mach-types.h>
 
@@ -117,6 +118,7 @@ MACHINE_START(EBSA285, "EBSA285")
 	.video_end	= 0x000bffff,
 	.map_io		= footbridge_map_io,
 	.init_early	= footbridge_sched_clock,
+	.nr_irqs	= FOOTBRIDGE_NR_IRQS,
 	.init_irq	= footbridge_init_irq,
 	.init_time	= footbridge_timer_init,
 	.restart	= footbridge_restart,
diff --git a/arch/arm/mach-footbridge/include/mach/irqs.h b/arch/arm/mach-footbridge/include/mach/irqs.h
index a5f41846ab9c..10f1fbc24012 100644
--- a/arch/arm/mach-footbridge/include/mach/irqs.h
+++ b/arch/arm/mach-footbridge/include/mach/irqs.h
@@ -11,7 +11,7 @@
  */
 #include <asm/mach-types.h>
 
-#define NR_IRQS			36
+#define FOOTBRIDGE_NR_IRQS	36
 #define NR_DC21285_IRQS		16
 
 #define _ISA_IRQ(x)		(0 + (x))
@@ -93,5 +93,3 @@
 #define I8042_KBD_IRQ	IRQ_ISA_KEYBOARD
 #define I8042_AUX_IRQ	(machine_is_netwinder() ? IRQ_NETWINDER_PS2MOUSE : IRQ_ISA_PS2MOUSE)
 #define IRQ_FLOPPYDISK	IRQ_ISA_FLOPPY
-
-#define irq_canonicalize(_i)	(((_i) == IRQ_ISA_CASCADE) ? IRQ_ISA_2 : _i)
diff --git a/arch/arm/mach-footbridge/isa-irq.c b/arch/arm/mach-footbridge/isa-irq.c
index 842ddb4121ef..e4e71bdf1dc7 100644
--- a/arch/arm/mach-footbridge/isa-irq.c
+++ b/arch/arm/mach-footbridge/isa-irq.c
@@ -21,8 +21,8 @@
 #include <asm/mach/irq.h>
 
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 #include <asm/hardware/dec21285.h>
-#include <asm/irq.h>
 #include <asm/mach-types.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-footbridge/isa-timer.c b/arch/arm/mach-footbridge/isa-timer.c
index 723e3eae995d..07dee61b0b03 100644
--- a/arch/arm/mach-footbridge/isa-timer.c
+++ b/arch/arm/mach-footbridge/isa-timer.c
@@ -13,7 +13,7 @@
 #include <linux/spinlock.h>
 #include <linux/timex.h>
 
-#include <asm/irq.h>
+#include <mach/irqs.h>
 #include <asm/mach/time.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-footbridge/isa.c b/arch/arm/mach-footbridge/isa.c
index 84caccddce44..1e7b0f5fb111 100644
--- a/arch/arm/mach-footbridge/isa.c
+++ b/arch/arm/mach-footbridge/isa.c
@@ -7,7 +7,7 @@
 #include <linux/init.h>
 #include <linux/serial_8250.h>
 
-#include <asm/irq.h>
+#include <mach/irqs.h>
 #include <asm/hardware/dec21285.h>
 
 #include "common.h"
diff --git a/arch/arm/mach-footbridge/netwinder-hw.c b/arch/arm/mach-footbridge/netwinder-hw.c
index c024eefd4978..ab17ba916d47 100644
--- a/arch/arm/mach-footbridge/netwinder-hw.c
+++ b/arch/arm/mach-footbridge/netwinder-hw.c
@@ -16,6 +16,7 @@
 #include <linux/slab.h>
 #include <linux/leds.h>
 
+#include <mach/irqs.h>
 #include <asm/hardware/dec21285.h>
 #include <asm/mach-types.h>
 #include <asm/setup.h>
@@ -766,6 +767,7 @@ MACHINE_START(NETWINDER, "Rebel-NetWinder")
 	.reserve_lp2	= 1,
 	.fixup		= fixup_netwinder,
 	.map_io		= footbridge_map_io,
+	.nr_irqs	= FOOTBRIDGE_NR_IRQS,
 	.init_irq	= footbridge_init_irq,
 	.init_time	= isa_timer_init,
 	.restart	= netwinder_restart,
diff --git a/arch/arm/mach-footbridge/netwinder-pci.c b/arch/arm/mach-footbridge/netwinder-pci.c
index e8304392074b..bfd5c0606c71 100644
--- a/arch/arm/mach-footbridge/netwinder-pci.c
+++ b/arch/arm/mach-footbridge/netwinder-pci.c
@@ -10,7 +10,7 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 
-#include <asm/irq.h>
+#include <mach/irqs.h>
 #include <asm/mach/pci.h>
 #include <asm/mach-types.h>
 
diff --git a/drivers/char/nwbutton.c b/drivers/char/nwbutton.c
index 92cee5717237..99819b184aac 100644
--- a/drivers/char/nwbutton.c
+++ b/drivers/char/nwbutton.c
@@ -18,7 +18,7 @@
 #include <linux/init.h>
 
 #include <linux/uaccess.h>
-#include <asm/irq.h>
+#include <mach/irqs.h>
 #include <asm/mach-types.h>
 
 #define __NWBUTTON_C		/* Tell the header file who we are */
diff --git a/drivers/input/serio/i8042-io.h b/drivers/input/serio/i8042-io.h
index a8f4b2d70e59..cea72bd888af 100644
--- a/drivers/input/serio/i8042-io.h
+++ b/drivers/input/serio/i8042-io.h
@@ -15,9 +15,9 @@
  * IRQs.
  */
 
-#if defined(__arm__)
-/* defined in include/asm-arm/arch-xxx/irqs.h */
-#include <asm/irq.h>
+#ifdef CONFIG_ARCH_FOOTBRIDGE
+/* defined in arch/arm/mach-footbridge/include/mach/irqs.h */
+#include <mach/irqs.h>
 #elif defined(CONFIG_PPC)
 extern int of_i8042_kbd_irq;
 extern int of_i8042_aux_irq;
diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index 4de0c975ebdc..f0c63875912e 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -15,11 +15,11 @@
 #include <linux/serial.h>
 #include <linux/io.h>
 
-#include <asm/irq.h>
 #include <asm/mach-types.h>
 #include <asm/system_info.h>
 #include <asm/hardware/dec21285.h>
 #include <mach/hardware.h>
+#include <mach/irqs.h>
 
 #define BAUD_BASE		(mem_fclk_21285/64)
 
-- 
2.43.0

