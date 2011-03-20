From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] input: TOUCHSCREEN_TSC2005 should depend on
 GENERIC_HARDIRQS
Date: Sun, 20 Mar 2011 13:23:16 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1103201312320.6633@ayla.of.borg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lauri Leukkunen <lauri.leukkunen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Dmitry Torokhov <dtor@mail.ru>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

drivers/input/touchscreen/tsc2005.c: In function =A1tsc2005_probe=A2:
drivers/input/touchscreen/tsc2005.c:666: error: implicit declaration of=
 function =A1set_irq_wake=A2

In addition, migrate from set_irq_wake() (marked "do not use" as of com=
mit
a0cd9ca2b907d7ee26575e7b63ac92dad768a75e ("genirq: Namespace cleanup"))=
 to
irq_set_irq_wake().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/input/touchscreen/Kconfig   |    2 +-
 drivers/input/touchscreen/tsc2005.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscr=
een/Kconfig
index 112ec55..434fd80 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -641,7 +641,7 @@ config TOUCHSCREEN_TOUCHIT213
=20
 config TOUCHSCREEN_TSC2005
         tristate "TSC2005 based touchscreens"
-        depends on SPI_MASTER
+        depends on SPI_MASTER && GENERIC_HARDIRQS
         help
           Say Y here if you have a TSC2005 based touchscreen.
=20
diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchs=
creen/tsc2005.c
index 8742061..437b9cd 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -663,7 +663,7 @@ static int __devinit tsc2005_probe(struct spi_devic=
e *spi)
 		goto err_remove_sysfs;
 	}
=20
-	set_irq_wake(spi->irq, 1);
+	irq_set_irq_wake(spi->irq, 1);
 	return 0;
=20
 err_remove_sysfs:
--=20
1.7.0.4

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
