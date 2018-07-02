From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 3/5] Input: hilkbd - Add casts to HP9000/300 I/O accessors
Date: Mon,  2 Jul 2018 15:35:30 +0200
Message-ID: <20180702133532.5412-4-geert@linux-m68k.org>
References: <20180702133532.5412-1-geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702133532.5412-1-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>, "David S . Miller" <davem@davemloft.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

Internally, hilkbd uses "unsigned long" I/O addresses everywhere.
This works fine as:
  - On PA-RISC, hilkbd uses the gsc_{read,write}b() I/O accessors, which
    take "unsigned long" addresses,
  - On m68k, hilkbd uses {read,write}b(), which are currently mapped to
    {in,out}_8(), and convert the passed addresses to pointers
    internally.

However, the asm-generic version of {read,write}b() does not perform
such conversions, and requires passing pointers instead.  Hence add
casts to prepare for switching m68k to the asm-generic version.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
This is a dependency for "m68k/io: Switch mmu variant to
<asm-generic/io.h>".
---
 drivers/input/keyboard/hilkbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/keyboard/hilkbd.c b/drivers/input/keyboard/hilkbd.c
index a4e404aaf64bdb82..5c7afdec192c139b 100644
--- a/drivers/input/keyboard/hilkbd.c
+++ b/drivers/input/keyboard/hilkbd.c
@@ -57,8 +57,8 @@ MODULE_LICENSE("GPL v2");
  #define HIL_DATA		0x1
  #define HIL_CMD		0x3
  #define HIL_IRQ		2
- #define hil_readb(p)		readb(p)
- #define hil_writeb(v,p)	writeb((v),(p))
+ #define hil_readb(p)		readb((const volatile void __iomem *)(p))
+ #define hil_writeb(v, p)	writeb((v), (volatile void __iomem *)(p))
 
 #else
 #error "HIL is not supported on this platform"
-- 
2.17.1
