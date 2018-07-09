From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/5] m68k: IO Fixes and Cleanups
Date: Mon,  9 Jul 2018 11:30:35 +0200
Message-ID: <20180709093040.23597-1-geert@linux-m68k.org>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Greg Ungerer <gerg@linux-m68k.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-m68k@lists.linux-m68k.org, netdev@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: linux-input@vger.kernel.org

	Hi all,

This patch series contains fixes and cleanups for I/O accessors on m68k
platforms (with MMU).

The first patch contains small fixes without any dependencies.
Patches 2 and 3 make small adjustments to drivers that are dependencies
for further cleanup.
Patch 4 and 5 complete the cleanup.

Changes compared to v1:
  - Move ARCH_HAS_IOREMAP_WT to fix "ioremap_wt redefined" warnings with
    m5475evb defconfig,
  - Add Acked-by.

Given the dependencies, I think it's easiest if the respective
maintainers would provide their Acked-by, so all patches can go in
through the m68k tree.

Thanks!

Geert Uytterhoeven (5):
  m68k/io: Add missing ioremap define guards, fix typo
  net: mac8390: Use standard memcpy_{from,to}io()
  Input: hilkbd - Add casts to HP9000/300 I/O accessors
  m68k/io: Move mem*io define guards to <asm/kmap.h>
  m68k/io: Switch mmu variant to <asm-generic/io.h>

 arch/m68k/include/asm/io.h          |  7 +++++
 arch/m68k/include/asm/io_mm.h       | 42 +++--------------------------
 arch/m68k/include/asm/io_no.h       | 12 ---------
 arch/m68k/include/asm/kmap.h        |  9 ++++++-
 drivers/input/keyboard/hilkbd.c     |  4 +--
 drivers/net/ethernet/8390/mac8390.c | 20 +++++++-------
 6 files changed, 30 insertions(+), 64 deletions(-)

-- 
2.17.1

Gr{oetje,eeting}s,

						Geert
