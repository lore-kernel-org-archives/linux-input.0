Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18FC3264D7
	for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 20:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788123179; cv=none; b=nVc9YLgGt58A28Ms3NDHbT+NHdtSUCMmmUCsoASXWhIJ92LyFMQ0K5YWBtOrGrw9j/iWf4jDgcEM/dPQ5tHKjmeaaJOIM9U1rXBtsmMEBpX7nLCrq5dH5+HC9bi6yYAK348uP+w2ucvhjCSZRdF2DkOsobfEKtmfOBaaMVLK9t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788123179; c=relaxed/simple;
	bh=acCrqg8IpFZBPKIGBafgy4kHQIbRWqxM2O/BWjgnWqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CzT19DVBR6Lnfb12slumcmHc0AhdniyW6jr5antAfakkBg1T4xWls6nEotz64v6u8F97v53QeWJl1jBZ6W2ju/cN9RmwzgmcFFekaOaYa3dMahAZ2UT2oyFI+zKHDXpipmgsEWPteFJyVbbnablUjrAvsChOlZvpZ2AAhCsxP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPzKy9ME; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPzKy9ME"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc1c9879395so2116125a12.1
        for <linux-input@vger.kernel.org>; Sun, 30 Aug 2026 13:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788123174; x=1788727974; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ChRQxZ6nhdb/L1XpAtq/GVRDJWbntfU/ug1ECOX+bsc=;
        b=dPzKy9MEnC0jeaONH4i0j0to4Ht5vNM2NxNv1T1I2s8FHTjpXGwmL8EkvxxK0DMOFt
         OJqq9OVdBoJEllEzSbNd3WLivUkEEDAhHY9I+bvvWdldVv4Q4VZ0G63TFLBpuaheQc4s
         33tHbxqUhBCcADR8efj9OLzs9a9ov7c3z8Kg+7G9rPL3HHG0K28dE2qErrO7CHy/pVj+
         4Sglj/lwQg4+6wa/e61iMR4sF45ZifsQu57DsCrpxibkVwx/Km542yll3+8fV3aXMkr0
         WLXVhQfrE/2w1qSYH4Ey8yBUrQ3MKDkXESexAaZ63DjiCr4XrmTodsmJOk3AX9QPv1xU
         AyIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788123174; x=1788727974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ChRQxZ6nhdb/L1XpAtq/GVRDJWbntfU/ug1ECOX+bsc=;
        b=VYqnsqnTWmT641/BE4Sww/sSQ+d1eVswGoWLseeL/IHbgr5vh8Qt7dPUOVggeXj+oa
         QvxbpUcd/jlzHAdDkwVohL60lGap05OmODOg+6HLNtYwGEnDlMGySKEpu3FBPaelRhD2
         02rdij5zdsswL1LjhHR2m8j+iObjCs1Gxv4VOSVL+5VjZe1m8UHwqzym6aKHoPhPrAli
         9By8nYB614Hu78qnH2OnrMjpBV4Bw8n2VBQvkM+85W1PRZ8fL6pknyLLmCkroyEU/W8e
         l8CTT8dYNotUqL2yQ3E9nnFywrRgGTT8ErddkQL9GcICn3kRNm84iuha75wVMr4nMeX2
         PF8w==
X-Forwarded-Encrypted: i=1; AHgh+RrctlQjbrMm13J+GYaoNalvMhegTCotKvBmcHVdJz+oELFonMSUVtwosAQ1nMR0m5iTpsjZSp43lzqu9Q==@vger.kernel.org
X-Gm-Message-State: AFuF++llug2PBo5Qike2031IeeOBC6MPilsqGwe34Ofs/VPTTXoK9zzu
	CN8986y0FcOqD8EgtnPrEv3rEMCM+Uxy+5TGwTPQYi278IHVv21HqEd+
X-Gm-Gg: AR+sD137c7suQEKThDjhFDkl+Qx8CKRcdjZjEcDWVPytR2bPkXnmsZpfORwqp1FwhXR
	SsXRwcNi5TxfWtkv9dVM2f85xa96FWmAMf/4lTGTTdH2hUIJUtD9O9+ueAfzDWECCRNEdyeafDF
	G0C10nOF3habj+WIKQUax5J3Wa5KhsquEKCSK8Ke456fRqZgGYXb7J83tLVcJCCNuypaqVgo6kU
	xtFR9VNayaxnPMtr0gPYNPKDcp/xuQ1QZQt7DmzJZtevLm2WGZCt5UoHuNZG4JUdLMkCvCk3Obl
	VhOMTbAviiLcYdoiuNpkvcVZ8vtqCxCUs9Oo6jn7ak0Vokh8ZYEUEkx+29G4XSOCY14L5oc7Abk
	ydTLKUsA8QqEdTJ49YeDE5lM/6IaAwIfp3GrOhRVROc8eWIKaZvLebk8b6dpCyukNJwXAmDwK39
	ijc+1Qr8F0t4CQpw7OE8Q7MnEml8ir1jo+fjqH1Ht2MI+IaJJtp5YDZ1RGog4oBxsnsf6pm6OSl
	5FnZfHjXqY/Nlr+SeecAWpXHw91cvZL0spfuWiSwzeWguBxxGg=
X-Received: by 2002:a05:6a20:a108:b0:3cc:f280:ebc6 with SMTP id adf61e73a8af0-3d265c4270cmr33754961637.5.1788123174088;
        Sun, 30 Aug 2026 13:52:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:c021:485f:75be:3c7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm26849437eec.24.2026.08.30.13.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 13:52:53 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sun, 30 Aug 2026 13:52:46 -0700
Subject: [PATCH 1/7] Input: gscps2 - clean up driver code style and
 structure
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260830-gscps2-v1-1-c733d4cae7f9@gmail.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
In-Reply-To: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-parisc@vger.kernel.org
X-Mailer: b4 0.16-dev-b242f

Clean up code style issues and function ordering in the gscps2 driver:
- Reorder functions to place gscps2_interrupt() before its callers,
  allowing removal of its forward declaration.
- Change gscps2_enable() to accept a boolean parameter and remove the
  ENABLE and DISABLE macro definitions.
- Convert printk() calls to dev_dbg() and dev_warn().
- Fix operator spacing and multi-variable assignment.
- Add spinlock comment and use cpu_relax() in spin-wait loop.

Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/serio/gscps2.c | 208 +++++++++++++++++++------------------------
 1 file changed, 91 insertions(+), 117 deletions(-)

diff --git a/drivers/input/serio/gscps2.c b/drivers/input/serio/gscps2.c
index 43453ec533b2..b82c56ba8ff7 100644
--- a/drivers/input/serio/gscps2.c
+++ b/drivers/input/serio/gscps2.c
@@ -1,6 +1,4 @@
 /*
- * drivers/input/serio/gscps2.c
- *
  * Copyright (c) 2004-2006 Helge Deller <deller@gmx.de>
  * Copyright (c) 2002 Laurent Canet <canetl@esiee.fr>
  * Copyright (c) 2002 Thibaut Varene <varenet@parisc-linux.org>
@@ -37,16 +35,10 @@ MODULE_AUTHOR("Laurent Canet <canetl@esiee.fr>, Thibaut Varene <varenet@parisc-l
 MODULE_DESCRIPTION("HP GSC PS2 port driver");
 MODULE_LICENSE("GPL");
 
-#define PFX "gscps2.c: "
-
 /*
  * Driver constants
  */
 
-/* various constants */
-#define ENABLE			1
-#define DISABLE			0
-
 #define GSC_DINO_OFFSET		0x0800	/* offset for DINO controller versus LASI one */
 
 /* PS/2 IO port offsets */
@@ -77,23 +69,21 @@ MODULE_LICENSE("GPL");
 #define GSC_ID_KEYBOARD		0	/* device ID values */
 #define GSC_ID_MOUSE		1
 
-#ifndef CONFIG_SERIO_GSCPS2_RDI_KEYCODES
-# define CONFLICT(x, y) x
-#else
-# define CONFLICT(x, y) y
-#endif
+#define RDI_CONFLICT(x, y) \
+	((x) * !IS_ENABLED(CONFIG_SERIO_GSCPS2_RDI_KEYCODES) + \
+	 (y) * IS_ENABLED(CONFIG_SERIO_GSCPS2_RDI_KEYCODES))
 
 /*
  * Sadly RDI (Tadpole) decided to ship a different keyboard layout
  * than HP for their PS/2 laptop keyboard which leads to conflicting
  * keycodes between a normal HP PS/2 keyboard and a RDI PrecisionBook.
- *                       HP:            RDI:
+ *                           HP:                RDI:
  */
-#define C_07	CONFLICT(KEY_F12,	KEY_F1)
-#define C_11	CONFLICT(KEY_LEFTALT,	KEY_LEFTCTRL)
-#define C_14	CONFLICT(KEY_LEFTCTRL,	KEY_CAPSLOCK)
-#define C_58	CONFLICT(KEY_CAPSLOCK,	KEY_RIGHTCTRL)
-#define C_61	CONFLICT(KEY_102ND,	KEY_LEFT)
+#define C_07	RDI_CONFLICT(KEY_F12,		KEY_F1)
+#define C_11	RDI_CONFLICT(KEY_LEFTALT,	KEY_LEFTCTRL)
+#define C_14	RDI_CONFLICT(KEY_LEFTCTRL,	KEY_CAPSLOCK)
+#define C_58	RDI_CONFLICT(KEY_CAPSLOCK,	KEY_RIGHTCTRL)
+#define C_61	RDI_CONFLICT(KEY_102ND,		KEY_LEFT)
 
 /*
  * Special keycode value recognized by atkbd (ATKBD_KEY_NULL) to silently
@@ -188,8 +178,6 @@ static const struct software_node gscps2_keyboard_node = {
 	.properties = gscps2_props,
 };
 
-static irqreturn_t gscps2_interrupt(int irq, void *dev);
-
 #define BUFFER_SIZE 0x0f
 
 /* GSC PS/2 port device struct */
@@ -197,33 +185,34 @@ struct gscps2port {
 	struct list_head node;
 	struct parisc_device *padev;
 	struct serio *port;
-	spinlock_t lock;
+	spinlock_t lock; /* serializes HW access */
 	char __iomem *addr;
 	u8 act, append; /* position in buffer[] */
 	struct {
 		u8 data;
 		u8 str;
-	} buffer[BUFFER_SIZE+1];
+	} buffer[BUFFER_SIZE + 1];
 	int id;
 };
 
+static LIST_HEAD(ps2port_list);
+
 /*
  * Various HW level routines
  */
 
-#define gscps2_readb_input(x)		readb((x)+GSC_RCVDATA)
-#define gscps2_readb_control(x)		readb((x)+GSC_CONTROL)
-#define gscps2_readb_status(x)		readb((x)+GSC_STATUS)
-#define gscps2_writeb_control(x, y)	writeb((x), (y)+GSC_CONTROL)
-
+#define gscps2_readb_input(x)		readb((x) + GSC_RCVDATA)
+#define gscps2_readb_control(x)		readb((x) + GSC_CONTROL)
+#define gscps2_readb_status(x)		readb((x) + GSC_STATUS)
+#define gscps2_writeb_control(x, y)	writeb((x), (y) + GSC_CONTROL)
 
 /*
  * wait_TBE() - wait for Transmit Buffer Empty
  */
-
 static int wait_TBE(char __iomem *addr)
 {
 	int timeout = 25000; /* device is expected to react within 250 msec */
+
 	while (gscps2_readb_status(addr) & GSC_STAT_TBNE) {
 		if (!--timeout)
 			return 0;	/* This should not happen */
@@ -232,88 +221,17 @@ static int wait_TBE(char __iomem *addr)
 	return 1;
 }
 
-
 /*
  * gscps2_flush() - flush the receive buffer
  */
-
 static void gscps2_flush(struct gscps2port *ps2port)
 {
 	while (gscps2_readb_status(ps2port->addr) & GSC_STAT_RBNE)
 		gscps2_readb_input(ps2port->addr);
-	ps2port->act = ps2port->append = 0;
-}
-
-/*
- * gscps2_writeb_output() - write a byte to the port
- *
- * returns 1 on success, 0 on error
- */
-
-static inline int gscps2_writeb_output(struct gscps2port *ps2port, u8 data)
-{
-	char __iomem *addr = ps2port->addr;
-
-	if (!wait_TBE(addr)) {
-		printk(KERN_DEBUG PFX "timeout - could not write byte %#x\n", data);
-		return 0;
-	}
-
-	while (gscps2_readb_status(addr) & GSC_STAT_RBNE)
-		/* wait */;
-
-	scoped_guard(spinlock_irqsave, &ps2port->lock)
-		writeb(data, addr+GSC_XMTDATA);
-
-	/* this is ugly, but due to timing of the port it seems to be necessary. */
-	mdelay(6);
-
-	/* make sure any received data is returned as fast as possible */
-	/* this is important e.g. when we set the LEDs on the keyboard */
-	gscps2_interrupt(0, NULL);
-
-	return 1;
-}
-
-
-/*
- * gscps2_enable() - enables or disables the port
- */
-
-static void gscps2_enable(struct gscps2port *ps2port, int enable)
-{
-	u8 data;
-
-	/* now enable/disable the port */
-	scoped_guard(spinlock_irqsave, &ps2port->lock) {
-		gscps2_flush(ps2port);
-		data = gscps2_readb_control(ps2port->addr);
-		if (enable)
-			data |= GSC_CTRL_ENBL;
-		else
-			data &= ~GSC_CTRL_ENBL;
-		gscps2_writeb_control(data, ps2port->addr);
-	}
-
-	wait_TBE(ps2port->addr);
-	gscps2_flush(ps2port);
-}
-
-/*
- * gscps2_reset() - resets the PS/2 port
- */
-
-static void gscps2_reset(struct gscps2port *ps2port)
-{
-	/* reset the interface */
-	guard(spinlock_irqsave)(&ps2port->lock);
-	gscps2_flush(ps2port);
-	writeb(0xff, ps2port->addr + GSC_RESET);
-	gscps2_flush(ps2port);
+	ps2port->act = 0;
+	ps2port->append = 0;
 }
 
-static LIST_HEAD(ps2port_list);
-
 static void gscps2_read_data(struct gscps2port *ps2port)
 {
 	u8 status;
@@ -348,8 +266,8 @@ static bool gscps2_report_data(struct gscps2port *ps2port)
 		data   = ps2port->buffer[ps2port->act].data;
 
 		ps2port->act = (ps2port->act + 1) & BUFFER_SIZE;
-		rxflags = ((status & GSC_STAT_TERR) ? SERIO_TIMEOUT : 0 ) |
-			  ((status & GSC_STAT_PERR) ? SERIO_PARITY  : 0 );
+		rxflags = ((status & GSC_STAT_TERR) ? SERIO_TIMEOUT : 0) |
+			  ((status & GSC_STAT_PERR) ? SERIO_PARITY  : 0);
 
 		serio_interrupt(ps2port->port, data, rxflags);
 	}
@@ -370,7 +288,6 @@ static bool gscps2_report_data(struct gscps2port *ps2port)
  * the data as fast as possible and handle the reporting to the upper layer
  * later.
  */
-
 static irqreturn_t gscps2_interrupt(int irq, void *dev)
 {
 	struct gscps2port *ps2port;
@@ -392,17 +309,79 @@ static irqreturn_t gscps2_interrupt(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+/*
+ * gscps2_writeb_output() - write a byte to the port
+ *
+ * returns 1 on success, 0 on error
+ */
+static inline int gscps2_writeb_output(struct gscps2port *ps2port, u8 data)
+{
+	char __iomem *addr = ps2port->addr;
+
+	if (!wait_TBE(addr)) {
+		dev_dbg(&ps2port->padev->dev, "timeout - could not write byte %#x\n", data);
+		return 0;
+	}
+
+	while (gscps2_readb_status(addr) & GSC_STAT_RBNE)
+		cpu_relax();
+
+	scoped_guard(spinlock_irqsave, &ps2port->lock)
+		writeb(data, addr + GSC_XMTDATA);
+
+	/* this is ugly, but due to timing of the port it seems to be necessary. */
+	mdelay(6);
+
+	/* make sure any received data is returned as fast as possible */
+	/* this is important e.g. when we set the LEDs on the keyboard */
+	gscps2_interrupt(0, NULL);
+
+	return 1;
+}
 
 /*
- * gscps2_write() - send a byte out through the aux interface.
+ * gscps2_enable() - enables or disables the port
  */
+static void gscps2_enable(struct gscps2port *ps2port, bool enable)
+{
+	u8 data;
 
+	/* now enable/disable the port */
+	scoped_guard(spinlock_irqsave, &ps2port->lock) {
+		gscps2_flush(ps2port);
+		data = gscps2_readb_control(ps2port->addr);
+		if (enable)
+			data |= GSC_CTRL_ENBL;
+		else
+			data &= ~GSC_CTRL_ENBL;
+		gscps2_writeb_control(data, ps2port->addr);
+	}
+
+	wait_TBE(ps2port->addr);
+	gscps2_flush(ps2port);
+}
+
+/*
+ * gscps2_reset() - resets the PS/2 port
+ */
+static void gscps2_reset(struct gscps2port *ps2port)
+{
+	/* reset the interface */
+	guard(spinlock_irqsave)(&ps2port->lock);
+	gscps2_flush(ps2port);
+	writeb(0xff, ps2port->addr + GSC_RESET);
+	gscps2_flush(ps2port);
+}
+
+/*
+ * gscps2_write() - send a byte out through the aux interface.
+ */
 static int gscps2_write(struct serio *port, unsigned char data)
 {
 	struct gscps2port *ps2port = port->port_data;
 
 	if (!gscps2_writeb_output(ps2port, data)) {
-		printk(KERN_DEBUG PFX "sending byte %#x failed.\n", data);
+		dev_dbg(&ps2port->padev->dev, "sending byte %#x failed.\n", data);
 		return -1;
 	}
 	return 0;
@@ -412,7 +391,6 @@ static int gscps2_write(struct serio *port, unsigned char data)
  * gscps2_open() is called when a port is opened by the higher layer.
  * It resets and enables the port.
  */
-
 static int gscps2_open(struct serio *port)
 {
 	struct gscps2port *ps2port = port->port_data;
@@ -420,7 +398,7 @@ static int gscps2_open(struct serio *port)
 	gscps2_reset(ps2port);
 
 	/* enable it */
-	gscps2_enable(ps2port, ENABLE);
+	gscps2_enable(ps2port, true);
 
 	gscps2_interrupt(0, NULL);
 
@@ -430,11 +408,11 @@ static int gscps2_open(struct serio *port)
 /*
  * gscps2_close() disables the port
  */
-
 static void gscps2_close(struct serio *port)
 {
 	struct gscps2port *ps2port = port->port_data;
-	gscps2_enable(ps2port, DISABLE);
+
+	gscps2_enable(ps2port, false);
 }
 
 /**
@@ -443,7 +421,6 @@ static void gscps2_close(struct serio *port)
  *
  * @return: success/error report
  */
-
 static int __init gscps2_probe(struct parisc_device *dev)
 {
 	struct gscps2port *ps2port;
@@ -494,8 +471,8 @@ static int __init gscps2_probe(struct parisc_device *dev)
 		goto fail_miserably;
 
 	if (ps2port->id != GSC_ID_KEYBOARD && ps2port->id != GSC_ID_MOUSE) {
-		printk(KERN_WARNING PFX "Unsupported PS/2 port at 0x%08lx (id=%d) ignored\n",
-				hpa, ps2port->id);
+		dev_warn(&dev->dev, "Unsupported PS/2 port at 0x%08lx (id=%d) ignored\n",
+			 hpa, ps2port->id);
 		ret = -ENODEV;
 		goto fail;
 	}
@@ -552,7 +529,6 @@ static int __init gscps2_probe(struct parisc_device *dev)
  *
  * @return: success/error report
  */
-
 static void __exit gscps2_remove(struct parisc_device *dev)
 {
 	struct gscps2port *ps2port = dev_get_drvdata(&dev->dev);
@@ -572,7 +548,6 @@ static void __exit gscps2_remove(struct parisc_device *dev)
 	kfree(ps2port);
 }
 
-
 static const struct parisc_device_id gscps2_device_tbl[] __initconst = {
 	{ HPHW_FIO, HVERSION_REV_ANY_ID, HVERSION_ANY_ID, 0x00084 }, /* LASI PS/2 */
 #ifdef DINO_TESTED
@@ -610,6 +585,5 @@ static void __exit gscps2_exit(void)
 	software_node_unregister(&gscps2_keyboard_node);
 }
 
-
 module_init(gscps2_init);
 module_exit(gscps2_exit);

-- 
2.55.0.897.gb25b4bd76c-goog

