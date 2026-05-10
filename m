Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C8B256C6C
	for <linux-input@vger.kernel.org>; Sun, 10 May 2026 03:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778382673; cv=none; b=uxbwutXtOXuETEhbBao5gjUJzOvOzIUatpuwwtN6H1PKeFU+ysFumToqPKgwa0SBLIz/Vpua6Zt4oa5Q+jGQ5pMg69rgmbfOWqQDqPOuofJYjAnWGgy6LUOXyAG5fgne79yCBsZupNo5qPwv2LOpJ9lKeBxqIiU881RnxQ4w6Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778382673; c=relaxed/simple;
	bh=gQA4Z0I4dAD3lpM3WcSiD7Z4kubZPjVnKPmZMkhI4ag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IWY/xZ3mXn7jubz5egOfYz8qGknwdPuTWljk8qI/nWPaqTZankK6aOmVk+1KAPvzXEUeZsJB6JCuefIimK++1hmdAV1Lo3rdgt85I1uJJveDjNJ1O1VeAqXNVPvcpaHP/Ihrx3FvVeTxH8A+QRYy0dwh5HnDb6TB85FVUbA3gr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1nf/1s/; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1nf/1s/"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2f7ca62a3c4so2868336eec.0
        for <linux-input@vger.kernel.org>; Sat, 09 May 2026 20:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778382671; x=1778987471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fk9eeAKn3FhBbqVLjcl9tAfYozaTPwOkZxBuF5GgNhQ=;
        b=n1nf/1s/mmOfVkB99s2fuIwoBaOBAhPFqdR1w8kElU8IlrnF7QZQxLf0HBuu4iC8Gi
         DGdtnEzOe1PcJBiz+ijnoOZzpxIOpgqh8KOq8UlRxQsSjnZGkEQuLYRdaQu9y+unlq/s
         ThopCnq2h1dDW5+fWQQrgCP2xD+x4Fmw+wMS7fJaofkgfeQNAw7KFDYscrhpAO4RRArR
         56XEGFXzjd6unfVJYv+mHx9gGNw0p5dMCaVQyZwztflXvK02e8uHbFsQRXDJfx9qAmts
         QqDq2Mdr0i159/CTYGooGsS558V23XUyxWezosfU9KaTW8xgDzktzFRVPrFu/0z/msC1
         X1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778382671; x=1778987471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fk9eeAKn3FhBbqVLjcl9tAfYozaTPwOkZxBuF5GgNhQ=;
        b=iaruYbvhNkMEOrQlIQoqz7vQ+hwuK+OofUO3KsZ7q2IHuKhlenJdQJ+PDQBMwdXLrE
         Yo3+xqvnC1Z13OWh7MhKf+AYHTp3Qg+6VBKgBg080n5WktPi6D1BzzSwFArawlkczVmS
         Sfu9+xaI3FuC2xrwLco8HQA49rFFxtZ8KO+jsPkAOplV95yFtRY6yE7tbpJgSUql7RZO
         mvQe/8AEfM0WVJ1851FhhJPQ2rw3D2IP9zl9mBDKfLlrFEic0N+WW8OodMwSbuifG17g
         DhLpWGTlOTzc9f66EYorst1hRtYPFP29RL7663EZxzdHN50T8ko0k8+jFlCHjcClsnQe
         M0vQ==
X-Forwarded-Encrypted: i=1; AFNElJ+9rD9T00WBhddFeZ2/UAgvNMJoFoMPPHH1lMh2dvOHLN9/h5wDml5+F4O4NMPXOmvwz7cQHirTCqDAmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy52+IAr6IBtNb1iLOE/C2P5XWkQFng9AkgxyGf7a4pm2aMR8RW
	kqDA8hAYjLUS+zzj7sG2gxygP347lxBMEXEUS/F9GlPmlcvGMnmOGArQ
X-Gm-Gg: Acq92OE5sd+F2ZFBjCB2UBJO5jnmCKijKWUy+duTNxsUIdsEEUmDWNaT8ra94UNMo5P
	V+iWfc4qSv+3H/3MsZ9ygF9T2YRWfxJneBd3MoKHjH9Dkw2TxJLnbbaDNdO80V6KxzCVBD+2E+0
	zdEL053GplxpAWGLSruAXzVWGGCJ0zXI7Ta3p5TPYiBiSSUJQh9NMpyQ9oLSsF5HJjVQvKICWnh
	2rMim4dX/Mo2QHCj0zGwh8v9CbNyT3ZeXG3EZCejut3FHBkUjnnZ1HFEtjmuMtUnCWUbx5ygVBR
	DaP39fiv0NW1nKFxDttatliQswVzn0U1wjrpvq9aTaTj+RQv4vJMIf6c1D82qn3YOkMj7fXKjUc
	d8fbOlBKA2Oh5durSlcwZWAmqgtXIBes8rAq1E37ZX+hUnqHz64Kmh88oBmxvIwG0apc2Wn8c1X
	3iezddNncyWEngzbR/Qrk5hYNmY9sE41aTvtx9ueAXcxZqLrjRdlT1MCiGj/U0oPZgi188/oE2s
	cG/0lAWfM23nbETA8ErG8DUw2iqBvEacsLBNHsRE7iclszV1r+5+lBdEGi4ksszLOU3D+bnLRTP
	zbDIzXrppJ3IwPDQOg==
X-Received: by 2002:a05:7300:a987:b0:2df:c5bb:3720 with SMTP id 5a478bee46e88-2f54c587faemr9231006eec.15.1778382670966;
        Sat, 09 May 2026 20:11:10 -0700 (PDT)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888c469b6sm8433793eec.24.2026.05.09.20.11.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 20:11:10 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Kees Cook <kees@kernel.org>
Subject: [PATCH] ARM: move Risc PC-specific <asm/hardware/iomd.h> header into mach-rpc
Date: Sat,  9 May 2026 20:10:36 -0700
Message-ID: <20260510031100.255248-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The <asm/hardware/iomd.h> header is specific to the IOMD chip used on
the Risc PC. Move it into mach-rpc to avoid polluting asm/hardware/
with machine-specific headers.

Also take the opportunity to remove a comment with the file path from
the header, which is bad style.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 MAINTAINERS                                                     | 1 -
 arch/arm/mach-rpc/dma.c                                         | 2 +-
 arch/arm/{include/asm/hardware => mach-rpc/include/mach}/iomd.h | 2 --
 arch/arm/mach-rpc/irq.c                                         | 2 +-
 arch/arm/mach-rpc/riscpc.c                                      | 2 +-
 arch/arm/mach-rpc/time.c                                        | 2 +-
 drivers/i2c/busses/i2c-acorn.c                                  | 2 +-
 drivers/input/mouse/rpcmouse.c                                  | 2 +-
 drivers/input/serio/rpckbd.c                                    | 2 +-
 drivers/video/fbdev/acornfb.h                                   | 2 +-
 10 files changed, 8 insertions(+), 11 deletions(-)
 rename arch/arm/{include/asm/hardware => mach-rpc/include/mach}/iomd.h (98%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 211cc683e25b..6a1da8903c04 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3398,7 +3398,6 @@ M:	Russell King <linux@armlinux.org.uk>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 W:	http://www.armlinux.org.uk/
-F:	arch/arm/include/asm/hardware/iomd.h
 F:	arch/arm/mach-rpc/
 F:	drivers/net/ethernet/8390/etherh.c
 F:	drivers/net/ethernet/i825xx/ether1*
diff --git a/arch/arm/mach-rpc/dma.c b/arch/arm/mach-rpc/dma.c
index 50e0f97afd75..717a81475670 100644
--- a/arch/arm/mach-rpc/dma.c
+++ b/arch/arm/mach-rpc/dma.c
@@ -20,7 +20,7 @@
 #include <linux/uaccess.h>
 
 #include <asm/mach/dma.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 
 struct iomd_dma {
 	struct dma_struct	dma;
diff --git a/arch/arm/include/asm/hardware/iomd.h b/arch/arm/mach-rpc/include/mach/iomd.h
similarity index 98%
rename from arch/arm/include/asm/hardware/iomd.h
rename to arch/arm/mach-rpc/include/mach/iomd.h
index e3f130345ebc..2a3f4a5f3fd9 100644
--- a/arch/arm/include/asm/hardware/iomd.h
+++ b/arch/arm/mach-rpc/include/mach/iomd.h
@@ -1,7 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  arch/arm/include/asm/hardware/iomd.h
- *
  *  Copyright (C) 1999 Russell King
  *
  *  This file contains information out the IOMD ASIC used in the
diff --git a/arch/arm/mach-rpc/irq.c b/arch/arm/mach-rpc/irq.c
index e924c9b813ab..649d81874c86 100644
--- a/arch/arm/mach-rpc/irq.c
+++ b/arch/arm/mach-rpc/irq.c
@@ -4,7 +4,7 @@
 #include <linux/io.h>
 
 #include <asm/mach/irq.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 #include <asm/irq.h>
 #include <asm/fiq.h>
 
diff --git a/arch/arm/mach-rpc/riscpc.c b/arch/arm/mach-rpc/riscpc.c
index f70fb9c4b0cb..d068f5e4873d 100644
--- a/arch/arm/mach-rpc/riscpc.c
+++ b/arch/arm/mach-rpc/riscpc.c
@@ -22,7 +22,7 @@
 #include <asm/elf.h>
 #include <asm/mach-types.h>
 #include <mach/hardware.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 #include <asm/page.h>
 #include <asm/domain.h>
 #include <asm/setup.h>
diff --git a/arch/arm/mach-rpc/time.c b/arch/arm/mach-rpc/time.c
index ad93c4dfafcd..566113f9774f 100644
--- a/arch/arm/mach-rpc/time.c
+++ b/arch/arm/mach-rpc/time.c
@@ -17,7 +17,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 
 #include <asm/mach/time.h>
 
diff --git a/drivers/i2c/busses/i2c-acorn.c b/drivers/i2c/busses/i2c-acorn.c
index 99b6b1c3fd9e..703b4a42f466 100644
--- a/drivers/i2c/busses/i2c-acorn.c
+++ b/drivers/i2c/busses/i2c-acorn.c
@@ -13,7 +13,7 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 
 #define FORCE_ONES	0xdc
 #define SCL		0x02
diff --git a/drivers/input/mouse/rpcmouse.c b/drivers/input/mouse/rpcmouse.c
index 6774029e0a1a..475c3ca22fd4 100644
--- a/drivers/input/mouse/rpcmouse.c
+++ b/drivers/input/mouse/rpcmouse.c
@@ -23,7 +23,7 @@
 
 #include <mach/hardware.h>
 #include <asm/irq.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 
 MODULE_AUTHOR("Vojtech Pavlik, Russell King");
 MODULE_DESCRIPTION("Acorn RiscPC mouse driver");
diff --git a/drivers/input/serio/rpckbd.c b/drivers/input/serio/rpckbd.c
index 4d817850ba3b..e452ad07e2fa 100644
--- a/drivers/input/serio/rpckbd.c
+++ b/drivers/input/serio/rpckbd.c
@@ -17,7 +17,7 @@
 #include <linux/slab.h>
 
 #include <mach/hardware.h>
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 
 MODULE_AUTHOR("Vojtech Pavlik, Russell King");
 MODULE_DESCRIPTION("Acorn RiscPC PS/2 keyboard controller driver");
diff --git a/drivers/video/fbdev/acornfb.h b/drivers/video/fbdev/acornfb.h
index f8df4ecb4fd7..e65388587f80 100644
--- a/drivers/video/fbdev/acornfb.h
+++ b/drivers/video/fbdev/acornfb.h
@@ -7,7 +7,7 @@
  *  Frame buffer code for Acorn platforms
  */
 #if defined(HAS_VIDC20)
-#include <asm/hardware/iomd.h>
+#include <mach/iomd.h>
 #define VIDC_PALETTE_SIZE	256
 #define VIDC_NAME		"VIDC20"
 #endif
-- 
2.43.0

