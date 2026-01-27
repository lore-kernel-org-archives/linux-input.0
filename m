Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4EC32573C
	for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 18:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769537933; cv=none; b=JS0SzsAhsHgakPCF6EUE0IDUkEOZz0g2c+Wg6brRE3sAjeTq9TDulpf7Fr8PzS3rNLi2kqQeyZRUmho4HnqUAEQo5XhQBoG+iujHEGWUZDCtPnMI0DwriVsjxUjMY2pH3xTzfEmCmhPaLvAFI3isIwLe1F/0M5XId2wQKHmCmng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769537933; c=relaxed/simple;
	bh=m8l/JHIKwDXpw8kXt72dUmH+CSF7ZFdf/0su0TkI4IA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sdf3Z1XeS+IfHhDbeqXG6ifm+uJxutTkqu0xu+YYI/WidoO7TWEsE6aJBpBz7Dm6vzsbx22TGyJ96jYbnSM+I9d/tkMRzSMWp8y6me5RAo0nM7quT32ccDT/KpfCPfbdrRCeS3nasBehtFH6GfPZ+vdlGnD8dci61+rc36sF7e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3Mpf3C4; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3Mpf3C4"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7cfccba483eso1852667a34.0
        for <linux-input@vger.kernel.org>; Tue, 27 Jan 2026 10:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769537931; x=1770142731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9SpGI9Pzq5Dm09rUS6lSA+BfLBYRvBZFXWRwHy0175w=;
        b=F3Mpf3C4+brDvah2QOynlCAvEy7n1plcEzIDTDLCz9CTjJXaYESXh5QgcbLXY7u1M9
         96ghHJ0utMzGX2ecb9IX+GSHyKk84ylz7hmgAl/NQiKgaP9ezoHTGYV4wEB4bOvukqvl
         mlD2sZorPSE+ERT9zJ6JM0guafOZhmRD0F8aqAylR7fwzpKeK5CxWEvwlnSi+/hGMBBm
         TeUAeUmG6SvMgbePvgnO6k9XX1GvLn1Gv3Q0DCr2djWLPOQkceVzY/VUe09dwosxkYxA
         EXg5QGyyitnQD8AhKo7iOq5QzV0abuHIPIWvUrZHf8nbVmYCoKj9r/Inf5UwzzuFcKRW
         WXOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769537931; x=1770142731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SpGI9Pzq5Dm09rUS6lSA+BfLBYRvBZFXWRwHy0175w=;
        b=Aqjc6+oVZeuHfkTWAnCTk79IJZUsZx12Qg3/EXkjRH/8yItw8arnkxnpkGapyzF56y
         RYH1q/o5nZwntNUuCRBSov/1c2h026INTNZ8JWsLnAq68kSvJEXPJMb2lCI9C9DEfQdv
         a1+CF6mRCcJQvp52/OcH5ukEn3Ut1pmertCcRBJxovCiKunBO4Nf6m3IowR2msDoVG5P
         bx/ZB60FP3+J4HyDq2ITDJxYZV7U9xBmUJRIEdvmFKSxJUSTtoJsP1MXLFYCsSYLdoJ+
         YgONoll1BLhrkXk6xCtAtqD0nH9DCCJnD7KV+O+NZzl5iyS3wOUrgYjSp8TIB7BpHgub
         aV9A==
X-Gm-Message-State: AOJu0Yxg325MYRGYI7pagWe1Nmo+Qy41G6CvjjLzJ5vnNw2D9CBB+oLd
	ZKHRmclAAM2lrlUGNPy/4IrrdvVlwm4lv1CzCoUmcbBB2QrNWHgf49xo7tXL9A==
X-Gm-Gg: AZuq6aKowfq2IZflyLiT8magttKd7W/cgRry2/tn6MK7X6Ro5ZGEC/4sOr2s+JR+L5c
	SwDjOi2VxfZtcHub4UHyderbWkrJj4iQ5DlBOlvifx9Zcfu3NrDwGnbARSh4M5zDmt7pO21BX7B
	jL/sKJJQ2V6vSXSw3ZiZsbYR7yfz/rYzLJXBjbg8M0hUlpM9qVyuObLeIvESBMZ1A1tu9Br1/gS
	ooOzBh7Bf2ICfrWB7T4S283+8wEjNkehCWkIc+URM9UIVwfXIxe/tTCKOocaTlgf55yoXnAdzPF
	/F5irXWSwAJyvXPh2EfqeKXWFQRfO0N043X9StndiH72S+isMeEz8oGiPoKOiwxUuFce3ebUcUU
	WlvjeC9uQdi9SalQv5Q9+G8GmWRDZ1vlF1zb07ehNrD83PzQUSeESdSYpK0ft1Ou+LX/VjSGvG+
	o+mAJU5qLk8aXnHzTJRxKCwZ0=
X-Received: by 2002:a05:6830:4425:b0:7b0:826e:4002 with SMTP id 46e09a7af769-7d1850e65b8mr1560738a34.20.1769537930590;
        Tue, 27 Jan 2026 10:18:50 -0800 (PST)
Received: from bonzupii-an51715 ([2600:100a:b119:c98a:c3be:f98b:ab28:1f54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c69f197sm267780a34.12.2026.01.27.10.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 10:18:50 -0800 (PST)
From: Bonzupii <bluefox9516@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Micah Ostrow <bluefox9516@gmail.com>
Subject: [PATCH] Input: apbps2 - fix comment style and typos
Date: Tue, 27 Jan 2026 12:17:35 -0600
Message-ID: <20260127181735.57132-1-bluefox9516@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Micah Ostrow <bluefox9516@gmail.com>

Capitalize comment starts to match kernel coding style.
Fix spelling: "reciever" -> "receiver"
Fix grammar: "it's" (contraction of "it is") -> "its" (possessive)
Remove uncertainty from "Clear error bits?" comment.

Compile tested only.

Signed-off-by: Micah Ostrow <bluefox9516@gmail.com>
---
 drivers/input/serio/apbps2.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/serio/apbps2.c b/drivers/input/serio/apbps2.c
index b815337be2f4..a5fbb27088be 100644
--- a/drivers/input/serio/apbps2.c
+++ b/drivers/input/serio/apbps2.c
@@ -67,7 +67,7 @@ static irqreturn_t apbps2_isr(int irq, void *dev_id)
 		rxflags = (status & APBPS2_STATUS_PE) ? SERIO_PARITY : 0;
 		rxflags |= (status & APBPS2_STATUS_FE) ? SERIO_FRAME : 0;
 
-		/* clear error bits? */
+		/* Clear error bits */
 		if (rxflags)
 			iowrite32be(0, &priv->regs->status);
 
@@ -82,9 +82,9 @@ static irqreturn_t apbps2_isr(int irq, void *dev_id)
 static int apbps2_write(struct serio *io, unsigned char val)
 {
 	struct apbps2_priv *priv = io->port_data;
-	unsigned int tleft = 10000; /* timeout in 100ms */
+	unsigned int tleft = 10000; /* Timeout in 100ms */
 
-	/* delay until PS/2 controller has room for more chars */
+	/* Delay until PS/2 controller has room for more chars */
 	while ((ioread32be(&priv->regs->status) & APBPS2_STATUS_TF) && tleft--)
 		udelay(10);
 
@@ -104,7 +104,7 @@ static int apbps2_open(struct serio *io)
 	struct apbps2_priv *priv = io->port_data;
 	int limit;
 
-	/* clear error flags */
+	/* Clear error flags */
 	iowrite32be(0, &priv->regs->status);
 
 	/* Clear old data if available (unlikely) */
@@ -112,7 +112,7 @@ static int apbps2_open(struct serio *io)
 	while ((ioread32be(&priv->regs->status) & APBPS2_STATUS_DR) && --limit)
 		ioread32be(&priv->regs->data);
 
-	/* Enable reciever and it's interrupt */
+	/* Enable receiver and its interrupt */
 	iowrite32be(APBPS2_CTRL_RE | APBPS2_CTRL_RI, &priv->regs->ctrl);
 
 	return 0;
@@ -122,7 +122,7 @@ static void apbps2_close(struct serio *io)
 {
 	struct apbps2_priv *priv = io->port_data;
 
-	/* stop interrupts at PS/2 HW level */
+	/* Stop interrupts at PS/2 HW level */
 	iowrite32be(0, &priv->regs->ctrl);
 }
 
@@ -139,7 +139,7 @@ static int apbps2_of_probe(struct platform_device *ofdev)
 		return -ENOMEM;
 	}
 
-	/* Find Device Address */
+	/* Find device address */
 	priv->regs = devm_platform_get_and_ioremap_resource(ofdev, 0, NULL);
 	if (IS_ERR(priv->regs))
 		return PTR_ERR(priv->regs);
-- 
2.52.0

