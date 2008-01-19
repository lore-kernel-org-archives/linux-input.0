From: tsbogend@alpha.franken.de (Thomas Bogendoerfer)
Subject: Re: [PATCH] I8042: SNI RM support
Date: Sat, 19 Jan 2008 16:19:18 +0100
Message-ID: <20080119151917.GA7548@alpha.franken.de>
References: <20080112233904.4E149C2F36@solo.franken.de> <200801160022.43487.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elvis.franken.de ([193.175.24.41]:59018 "EHLO elvis.franken.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756733AbYASPT3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 19 Jan 2008 10:19:29 -0500
Content-Disposition: inline
In-Reply-To: <200801160022.43487.dtor@insightbb.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: linux-input@vger.kernel.org, linux-mips@linux-mips.org

On Wed, Jan 16, 2008 at 12:22:42AM -0500, Dmitry Torokhov wrote:
> On Saturday 12 January 2008 18:39, Thomas Bogendoerfer wrote:
> > +
> > +/*
> > + * IRQs.
> > + */
> > +static int i8042_kbd_irq = -1;
> > +static int i8042_aux_irq = -1;
> 
> Why initialize with -1 and not leave at 0? Or even initialize with 1/12
> and override with 33/44 in i8042_platform_init()?

no specific reason, I just took i8042-sparcio.h and changed it to fit my
needs. Below is a patch which doesn't initialize both irq variables.

Thomas.


SNI RM200 don't have the i8042 controller connected to the EISA bus, but
have a second address range for onboard devices. This patch handles
the two possible address ranges for the i8042 on SNI RMs

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

 drivers/input/serio/i8042-snirm.h |   75 +++++++++++++++++++++++++++++++++++++
 drivers/input/serio/i8042.h       |    2 +
 2 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-snirm.h b/drivers/input/serio/i8042-snirm.h
new file mode 100644
index 0000000..409a934
--- /dev/null
+++ b/drivers/input/serio/i8042-snirm.h
@@ -0,0 +1,75 @@
+#ifndef _I8042_SNIRM_H
+#define _I8042_SNIRM_H
+
+#include <asm/sni.h>
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ */
+
+/*
+ * Names.
+ */
+
+#define I8042_KBD_PHYS_DESC "onboard/serio0"
+#define I8042_AUX_PHYS_DESC "onboard/serio1"
+#define I8042_MUX_PHYS_DESC "onboard/serio%d"
+
+/*
+ * IRQs.
+ */
+static int i8042_kbd_irq;
+static int i8042_aux_irq;
+#define I8042_KBD_IRQ i8042_kbd_irq
+#define I8042_AUX_IRQ i8042_aux_irq
+
+static void __iomem *kbd_iobase;
+
+#define I8042_COMMAND_REG	(kbd_iobase + 0x64UL)
+#define I8042_DATA_REG		(kbd_iobase + 0x60UL)
+
+static inline int i8042_read_data(void)
+{
+	return readb(kbd_iobase + 0x60UL);
+}
+
+static inline int i8042_read_status(void)
+{
+	return readb(kbd_iobase + 0x64UL);
+}
+
+static inline void i8042_write_data(int val)
+{
+	writeb(val, kbd_iobase + 0x60UL);
+}
+
+static inline void i8042_write_command(int val)
+{
+	writeb(val, kbd_iobase + 0x64UL);
+}
+static inline int i8042_platform_init(void)
+{
+	/* RM200 is strange ... */
+	if (sni_brd_type == SNI_BRD_RM200) {
+		kbd_iobase = ioremap(0x16000000, 4);
+		i8042_kbd_irq = 33;
+		i8042_aux_irq = 44;
+	} else {
+		kbd_iobase = ioremap(0x14000000, 4);
+		i8042_kbd_irq = 1;
+		i8042_aux_irq = 12;
+	}
+	if (!kbd_iobase)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static inline void i8042_platform_exit(void)
+{
+
+}
+
+#endif /* _I8042_SNIRM_H */
diff --git a/drivers/input/serio/i8042.h b/drivers/input/serio/i8042.h
index dd22d91..b5e9917 100644
--- a/drivers/input/serio/i8042.h
+++ b/drivers/input/serio/i8042.h
@@ -18,6 +18,8 @@
 #include "i8042-jazzio.h"
 #elif defined(CONFIG_SGI_IP22)
 #include "i8042-ip22io.h"
+#elif defined(CONFIG_SNI_RM)
+#include "i8042-snirm.h"
 #elif defined(CONFIG_PPC)
 #include "i8042-ppcio.h"
 #elif defined(CONFIG_SPARC)


-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
