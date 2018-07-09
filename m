From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/5] m68k/io: Add missing ioremap define guards, fix typo
Date: Mon,  9 Jul 2018 11:30:36 +0200
Message-ID: <20180709093040.23597-2-geert@linux-m68k.org>
References: <20180709093040.23597-1-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709093040.23597-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

  - Add missing define guard for ioremap_wt(),
  - Move ARCH_HAS_IOREMAP_WT from <asm/io_mm.h> to <asm/kmap.h>, as it
    is applicable to Coldfire with MMU, too,
  - Fix typo s/ioremap_fillcache/ioremap_fullcache/,
  - Add define guard for iounmap() for consistency with other
    architectures.

Fixes: 9746882f547d2f00 ("m68k: group io mapping definitions and functions")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
v2:
  - Move ARCH_HAS_IOREMAP_WT to fix "ioremap_wt redefined" warnings with
    m5475evb defconfig.
---
 arch/m68k/include/asm/io_mm.h | 2 --
 arch/m68k/include/asm/kmap.h  | 6 +++++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index fe485f4f5fac4d92..7e518303786c2d65 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -21,8 +21,6 @@
 
 #ifdef __KERNEL__
 
-#define ARCH_HAS_IOREMAP_WT
-
 #include <linux/compiler.h>
 #include <asm/raw_io.h>
 #include <asm/virtconvert.h>
diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index 84b8333db8ad1987..608e12f058a7cd7d 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -4,6 +4,8 @@
 
 #ifdef CONFIG_MMU
 
+#define ARCH_HAS_IOREMAP_WT
+
 /* Values for nocacheflag and cmode */
 #define IOMAP_FULL_CACHING		0
 #define IOMAP_NOCACHE_SER		1
@@ -16,6 +18,7 @@
  */
 extern void __iomem *__ioremap(unsigned long physaddr, unsigned long size,
 			       int cacheflag);
+#define iounmap iounmap
 extern void iounmap(void __iomem *addr);
 extern void __iounmap(void *addr, unsigned long size);
 
@@ -33,13 +36,14 @@ static inline void __iomem *ioremap_nocache(unsigned long physaddr,
 }
 
 #define ioremap_uc ioremap_nocache
+#define ioremap_wt ioremap_wt
 static inline void __iomem *ioremap_wt(unsigned long physaddr,
 				       unsigned long size)
 {
 	return __ioremap(physaddr, size, IOMAP_WRITETHROUGH);
 }
 
-#define ioremap_fillcache ioremap_fullcache
+#define ioremap_fullcache ioremap_fullcache
 static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
 					      unsigned long size)
 {
-- 
2.17.1
