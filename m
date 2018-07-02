From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/5] m68k/io: Add missing ioremap define guards, fix typo
Date: Mon,  2 Jul 2018 15:35:28 +0200
Message-ID: <20180702133532.5412-2-geert@linux-m68k.org>
References: <20180702133532.5412-1-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702133532.5412-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>, "David S . Miller" <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

  - Add missing define guard for ioremap_wt(),
  - Fix typo s/ioremap_fillcache/ioremap_fullcache/,
  - Add define guard for iounmap() for consistency with other
    architectures.

Fixes: 9746882f547d2f00 ("m68k: group io mapping definitions and functions")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/kmap.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index 84b8333db8ad1987..bf1026def698f21f 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -16,6 +16,7 @@
  */
 extern void __iomem *__ioremap(unsigned long physaddr, unsigned long size,
 			       int cacheflag);
+#define iounmap iounmap
 extern void iounmap(void __iomem *addr);
 extern void __iounmap(void *addr, unsigned long size);
 
@@ -33,13 +34,14 @@ static inline void __iomem *ioremap_nocache(unsigned long physaddr,
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
