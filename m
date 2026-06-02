Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4D3101A0
	for <linux-input@vger.kernel.org>; Tue,  2 Jun 2026 03:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780372768; cv=none; b=QSelvgg6/S1IZfi/yvhXAoy41+vfJjrL2EFOp8dZmJBPF7iYo6+V5PF0PVVyP5AOfTkHiuEC4JAxqKVAd6iSIDjlB/6wZJxs1cgeADTOBDIBJxCi42/bGZ6CV1R4VGbC9kAMMATplUx1uVe4SBOEn/bP942jMuZJDrT8uaZBaio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780372768; c=relaxed/simple;
	bh=GFSQG6OrUOieUbhj2mx43eRLCYFP9/IuBr8J1PcqPj4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4Mb8QsCx9D6d2PmjY0I/Ayh2+AMB8LIqjqnDQa/ARMNF6NQl14Ab5aEKcGirzBM4MR8mwf9Ah2/W0essi4R/neeMuWNVu4HKQhqUFzmGbWwRcqyvieYsQ+JlFI9SEmwyflTJbxEPknWseoktu559bmlK6Qw7vbTgJuNK/67sts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEa4Acp/; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEa4Acp/"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-5174a1da4b2so19530181cf.2
        for <linux-input@vger.kernel.org>; Mon, 01 Jun 2026 20:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780372766; x=1780977566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BSgCuJA/tA0laIMmqGKOL/31DJd5ibkvLEv/sSjsCkw=;
        b=iEa4Acp/OvUFf8mHdzONGCi5vtHjtwFzPfEb2rgrMIn8x6Yx2+gHTJsCdC6hIuzFsw
         ub0dmpNqoJU1Irtqba0bKzMVFkyYGli6jLV3jtbTvjpiw7gz+2nmnIZeUr0CKRxumJtD
         zthqFB5HOTY0gk6NyzztxCnofrW2Z+pvSvENHZ3Ottrk+32+ELPrum4WNj5WFWt6pBRQ
         YZC5F06yka/bf9Noy/kJc6TOKjaIjA2Lzf4PCYIjthwbMxgw7dP7WOiEcoo+TeXdKixS
         RWij8be0V9nKSSg/4P7vXllCIzApkmMuL5k0rcjKYlj7i6lUZNez8Gl24vVxo85LkfFq
         PVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780372766; x=1780977566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BSgCuJA/tA0laIMmqGKOL/31DJd5ibkvLEv/sSjsCkw=;
        b=JywVBP8WtEyfHkYWsYPzbYgxrv384f0zU9ggVaCqK7/hKKPNpEpeDx7lghA+yRrFWH
         T19aN5gQxJmF42IZG5eELXu+EUkIxhBSV6mj19azHjKZh/YXLHMIGU1WSEaw6s7SSzST
         5vicC+z9q52rbkCto6UlNcVPdq+O/ugW3kkcEf6I9rvSrJb4CKnu53spYB+QA09h50Ct
         kG4Uu3hs7EVE1n43bUs1QYLWTTCzel+9TXfhcYJk22sjGUnXZd1ZiA0V7q+tnbV1R2Zo
         +hRukDWykWcgqFErJ+Xdm0cC4OPjA7PX2BK9hVh3Ll1mNi8KWHo4x372VawqB5ZMAwX9
         Ytiw==
X-Gm-Message-State: AOJu0YxFxLQTXLr28RYKuAxVt0shwmJRBt3AeGLr17QQoYXl9Y6gVe19
	M9FPn5B6/g1h+nYSy9lxDK0zxuerdTpnpuraWNcUBfc6PKUlGn4BXgQfvcJ+Dg==
X-Gm-Gg: Acq92OECPLlRxiSo2w3GMSv2PNYJLvgRg6stwXTCHdNEgS8qASl7mBGwjT1YnGot7Dn
	8uBvvnvLL0+X4FdOo9Wr4wOR7DXl0HgAqatXJoj7DEbYALGgh/FdUMC2xtkSCSAMaLWPrho9B81
	wY4eNrRVARYAblaqfvdLiQ8/EgfgB6AM5SCauvHkKVLC4F0li4JjwnDqvkwe8++VKTwQCY25Hr6
	/M2ZZ/2KZS9RHWv+P1GbbVoEJ4Ie/RnGWkqM0BpHfX8PdH9voOY8kETaCF/JqNUtvdl/RzREZj+
	gjC9rs2Q95rvpYM46jqAfChgJtMGVjggMLkbGMup9HQi/MsVzl8V1S9qRafo49rxc+mlH3I9pHF
	ydQobELQgaKTiWgXfl839/bcArCkCjwVIHbl6hs4t+MtD7T/LgUpxE5dBQu/fJyJT/pJRmemiGd
	j+eHb+6Gnm4zIIfS5sU+g49RS6AdgUU88M2ps0V18wHKVez8qjrJGlq3122QdZ7XhHFkwP+uxU1
	8E/Y376HGS4RnaB8xUqjjK+WPnH0mNzU1rNaq5E2+RE4w==
X-Received: by 2002:a05:622a:1cca:b0:50d:8792:b6d1 with SMTP id d75a77b69052e-5173a7d90bcmr179325091cf.38.1780372766150;
        Mon, 01 Jun 2026 20:59:26 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51768c76e53sm7933791cf.4.2026.06.01.20.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 20:59:25 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	chleroy@kernel.org,
	Michal Simek <michal.simek@amd.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/ZYNQ ARCHITECTURE)
Subject: [PATCH] Input: xilinx_ps2 - replace in_be32/out_be32 with ioread32be/iowrite32be
Date: Mon,  1 Jun 2026 20:59:07 -0700
Message-ID: <20260602035907.623599-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mechanical conversion of the ppc4xx-specific accessors to the generic
portable helpers.

Allows enabling COMPILE_TEST for extra compile coverage.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/input/serio/Kconfig      |  2 +-
 drivers/input/serio/xilinx_ps2.c | 24 ++++++++++++------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/input/serio/Kconfig b/drivers/input/serio/Kconfig
index 5f15a6462056..60d886631c42 100644
--- a/drivers/input/serio/Kconfig
+++ b/drivers/input/serio/Kconfig
@@ -190,7 +190,7 @@ config SERIO_RAW
 
 config SERIO_XILINX_XPS_PS2
 	tristate "Xilinx XPS PS/2 Controller Support"
-	depends on PPC || MICROBLAZE
+	depends on PPC || MICROBLAZE || COMPILE_TEST
 	help
 	  This driver supports XPS PS/2 IP from the Xilinx EDK on
 	  PowerPC platform.
diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 411d55ca1a66..7eb96375b515 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -89,9 +89,9 @@ static int xps2_recv(struct xps2data *drvdata, u8 *byte)
 	int status = -1;
 
 	/* If there is data available in the PS/2 receiver, read it */
-	sr = in_be32(drvdata->base_address + XPS2_STATUS_OFFSET);
+	sr = ioread32be(drvdata->base_address + XPS2_STATUS_OFFSET);
 	if (sr & XPS2_STATUS_RX_FULL) {
-		*byte = in_be32(drvdata->base_address + XPS2_RX_DATA_OFFSET);
+		*byte = ioread32be(drvdata->base_address + XPS2_RX_DATA_OFFSET);
 		status = 0;
 	}
 
@@ -109,8 +109,8 @@ static irqreturn_t xps2_interrupt(int irq, void *dev_id)
 	int status;
 
 	/* Get the PS/2 interrupts and clear them */
-	intr_sr = in_be32(drvdata->base_address + XPS2_IPISR_OFFSET);
-	out_be32(drvdata->base_address + XPS2_IPISR_OFFSET, intr_sr);
+	intr_sr = ioread32be(drvdata->base_address + XPS2_IPISR_OFFSET);
+	iowrite32be(intr_sr, drvdata->base_address + XPS2_IPISR_OFFSET);
 
 	/* Check which interrupt is active */
 	if (intr_sr & XPS2_IPIXR_RX_OVF)
@@ -160,11 +160,11 @@ static int sxps2_write(struct serio *pserio, unsigned char c)
 	guard(spinlock_irqsave)(&drvdata->lock);
 
 	/* If the PS/2 transmitter is empty send a byte of data */
-	sr = in_be32(drvdata->base_address + XPS2_STATUS_OFFSET);
+	sr = ioread32be(drvdata->base_address + XPS2_STATUS_OFFSET);
 	if (sr & XPS2_STATUS_TX_FULL)
 		return -EAGAIN;
 
-	out_be32(drvdata->base_address + XPS2_TX_DATA_OFFSET, c);
+	iowrite32be(c, drvdata->base_address + XPS2_TX_DATA_OFFSET);
 	return 0;
 }
 
@@ -189,8 +189,8 @@ static int sxps2_open(struct serio *pserio)
 	}
 
 	/* start reception by enabling the interrupts */
-	out_be32(drvdata->base_address + XPS2_GIER_OFFSET, XPS2_GIER_GIE_MASK);
-	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, XPS2_IPIXR_RX_ALL);
+	iowrite32be(XPS2_GIER_GIE_MASK, drvdata->base_address + XPS2_GIER_OFFSET);
+	iowrite32be(XPS2_IPIXR_RX_ALL, drvdata->base_address + XPS2_IPIER_OFFSET);
 	(void)xps2_recv(drvdata, &c);
 
 	return 0;		/* success */
@@ -207,8 +207,8 @@ static void sxps2_close(struct serio *pserio)
 	struct xps2data *drvdata = pserio->port_data;
 
 	/* Disable the PS2 interrupts */
-	out_be32(drvdata->base_address + XPS2_GIER_OFFSET, 0x00);
-	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, 0x00);
+	iowrite32be(0x00, drvdata->base_address + XPS2_GIER_OFFSET);
+	iowrite32be(0x00, drvdata->base_address + XPS2_IPIER_OFFSET);
 	free_irq(drvdata->irq, drvdata);
 }
 
@@ -278,13 +278,13 @@ static int xps2_of_probe(struct platform_device *ofdev)
 	}
 
 	/* Disable all the interrupts, just in case */
-	out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, 0);
+	iowrite32be(0, drvdata->base_address + XPS2_IPIER_OFFSET);
 
 	/*
 	 * Reset the PS2 device and abort any current transaction,
 	 * to make sure we have the PS2 in a good state.
 	 */
-	out_be32(drvdata->base_address + XPS2_SRST_OFFSET, XPS2_SRST_RESET);
+	iowrite32be(XPS2_SRST_RESET, drvdata->base_address + XPS2_SRST_OFFSET);
 
 	dev_info(dev, "Xilinx PS2 at 0x%08llX mapped to 0x%p, irq=%d\n",
 		 (unsigned long long)phys_addr, drvdata->base_address,
-- 
2.54.0

