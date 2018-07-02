From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5/5] m68k/io: Switch mmu variant to <asm-generic/io.h>
Date: Mon,  2 Jul 2018 15:35:32 +0200
Message-ID: <20180702133532.5412-6-geert@linux-m68k.org>
References: <20180702133532.5412-1-geert@linux-m68k.org>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180702133532.5412-1-geert@linux-m68k.org>
Sender: netdev-owner@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>, "David S . Miller" <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

The dummy functions defined in <asm/io_mm.h> can be provided by
<asm-generic/io.h>.

As nommu already uses <asm-generic/io.h>, move its inclusion to
<asm/io.h>, and add/adjust include guards where appropriate.

This gets rid of lots of "statement with no effect" and "unused
variable" warnings when compile-testing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/io.h    |  7 ++++++
 arch/m68k/include/asm/io_mm.h | 40 +++--------------------------------
 arch/m68k/include/asm/io_no.h |  1 -
 3 files changed, 10 insertions(+), 38 deletions(-)

diff --git a/arch/m68k/include/asm/io.h b/arch/m68k/include/asm/io.h
index ca2849afb0877339..aabe6420ead2a599 100644
--- a/arch/m68k/include/asm/io.h
+++ b/arch/m68k/include/asm/io.h
@@ -1,6 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _M68K_IO_H
+#define _M68K_IO_H
+
 #if defined(__uClinux__) || defined(CONFIG_COLDFIRE)
 #include <asm/io_no.h>
 #else
 #include <asm/io_mm.h>
 #endif
+
+#include <asm-generic/io.h>
+
+#endif /* _M68K_IO_H */
diff --git a/arch/m68k/include/asm/io_mm.h b/arch/m68k/include/asm/io_mm.h
index fe485f4f5fac4d92..49ced111e6db0324 100644
--- a/arch/m68k/include/asm/io_mm.h
+++ b/arch/m68k/include/asm/io_mm.h
@@ -16,8 +16,8 @@
  *    isa_readX(),isa_writeX()  are for ISA memory
  */
 
-#ifndef _IO_H
-#define _IO_H
+#ifndef _M68K_IO_MM_H
+#define _M68K_IO_MM_H
 
 #ifdef __KERNEL__
 
@@ -369,40 +369,6 @@ static inline void isa_delay(void)
 #define writew(val, addr)	out_le16((addr), (val))
 #endif /* CONFIG_ATARI_ROM_ISA */
 
-#if !defined(CONFIG_ISA) && !defined(CONFIG_ATARI_ROM_ISA)
-/*
- * We need to define dummy functions for GENERIC_IOMAP support.
- */
-#define inb(port)          0xff
-#define inb_p(port)        0xff
-#define outb(val,port)     ((void)0)
-#define outb_p(val,port)   ((void)0)
-#define inw(port)          0xffff
-#define inw_p(port)        0xffff
-#define outw(val,port)     ((void)0)
-#define outw_p(val,port)   ((void)0)
-#define inl(port)          0xffffffffUL
-#define inl_p(port)        0xffffffffUL
-#define outl(val,port)     ((void)0)
-#define outl_p(val,port)   ((void)0)
-
-#define insb(port,buf,nr)  ((void)0)
-#define outsb(port,buf,nr) ((void)0)
-#define insw(port,buf,nr)  ((void)0)
-#define outsw(port,buf,nr) ((void)0)
-#define insl(port,buf,nr)  ((void)0)
-#define outsl(port,buf,nr) ((void)0)
-
-/*
- * These should be valid on any ioremap()ed region
- */
-#define readb(addr)      in_8(addr)
-#define writeb(val,addr) out_8((addr),(val))
-#define readw(addr)      in_le16(addr)
-#define writew(val,addr) out_le16((addr),(val))
-
-#endif /* !CONFIG_ISA && !CONFIG_ATARI_ROM_ISA */
-
 #define readl(addr)      in_le32(addr)
 #define writel(val,addr) out_le32((addr),(val))
 
@@ -444,4 +410,4 @@ static inline void isa_delay(void)
 #define writew_relaxed(b, addr)	writew(b, addr)
 #define writel_relaxed(b, addr)	writel(b, addr)
 
-#endif /* _IO_H */
+#endif /* _M68K_IO_MM_H */
diff --git a/arch/m68k/include/asm/io_no.h b/arch/m68k/include/asm/io_no.h
index c207428fae5953e7..0498192e1d983292 100644
--- a/arch/m68k/include/asm/io_no.h
+++ b/arch/m68k/include/asm/io_no.h
@@ -133,6 +133,5 @@ static inline void writel(u32 value, volatile void __iomem *addr)
 
 #include <asm/kmap.h>
 #include <asm/virtconvert.h>
-#include <asm-generic/io.h>
 
 #endif /* _M68KNOMMU_IO_H */
-- 
2.17.1
