From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 4/5] m68k/io: Move mem*io define guards to <asm/kmap.h>
Date: Mon,  2 Jul 2018 15:35:31 +0200
Message-ID: <20180702133532.5412-5-geert@linux-m68k.org>
References: <20180702133532.5412-1-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702133532.5412-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>, "David S . Miller" <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

The mem*io define guards are applicable to all users of <asm/kmap.h>.
Hence move them, and drop the #ifdef.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
To avoid redefined warnings, this depends on "net: mac8390: Use standard
memcpy_{from,to}io()".
---
 arch/m68k/include/asm/io_no.h | 11 -----------
 arch/m68k/include/asm/kmap.h  |  3 +++
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
index 83a0a6d449f44bdd..c207428fae5953e7 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -131,17 +131,6 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 #define PCI_SPACE_LIMIT	PCI_IO_MASK
 #endif /* CONFIG_PCI */
 
-/*
- * These are defined in kmap.h as static inline functions. To maintain
- * previous behavior we put these define guards here so io_mm.h doesn't
- * see them.
- */
-#ifdef CONFIG_MMU
-#define memset_io memset_io
-#define memcpy_fromio memcpy_fromio
-#define memcpy_toio memcpy_toio
-#endif
-
 #include <asm/kmap.h>
 #include <asm/virtconvert.h>
 #include <asm-generic/io.h>
diff --git a/arch/m68k/include/asm/kmap.h b/arch/m68k/include/asm/kmap.h
index bf1026def698f21f..dd4a365bf463d3cf 100644
--- a/arch/m68k/include/asm/kmap.h
+++ b/arch/m68k/include/asm/kmap.h
@@ -48,18 +48,21 @@ static inline void __iomem *ioremap_fullcache(unsigned long physaddr,
 	return __ioremap(physaddr, size, IOMAP_FULL_CACHING);
 }
 
+#define memset_io memset_io
 static inline void memset_io(volatile void __iomem *addr, unsigned char val,
 			     int count)
 {
 	__builtin_memset((void __force *) addr, val, count);
 }
 
+#define memcpy_fromio memcpy_fromio
 static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
 				 int count)
 {
 	__builtin_memcpy(dst, (void __force *) src, count);
 }
 
+#define memcpy_toio memcpy_toio
 static inline void memcpy_toio(volatile void __iomem *dst, const void *src,
 			       int count)
 {
-- 
2.17.1
