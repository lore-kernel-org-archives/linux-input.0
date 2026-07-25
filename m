Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52372D8795
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784984907; cv=none; b=oIAmIxwFfLBPocv1w3B09CnNvBBr0Nm3QHapTjzRbgzqVBtMU427Bq4IsMyfn96H7wlMG38JIOqRLpIfxPQtMOa3nT7I6B+HlWxpsyN/fWOeVhLVgQ8eGN8KKDDSkIrPo0NNaDRh0oyXVUkR+GmHEQY8LTThzcdLZnOIxEkZ82A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784984907; c=relaxed/simple;
	bh=1LZQZYl4oSctsRtcSKwMoS4mq13skfED8+DCXsqP9u8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXfXKd9xQ9yjn940LY2vKaeRG2NkooK3F38oGsyigh9Hg12aGYAdnLUGex4cCKVB3wR6LT/T+kbBU70ExtLnGoH2UwoKY//NheR26/LSevVs/GZyI4K3Gsea5Ar1lybxMs9YSWtOroGnsB6KbZodMNtpQa2O83D6hQ66/RVk7c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V/LCiCgS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V/LCiCgS"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cae1a3a744so10025075ad.3
        for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 06:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784984901; x=1785589701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wE/oVeYrmfIPAhJkzj10OLexdHg4SoKB+UjC7ETk4oo=;
        b=V/LCiCgSf9cH0BGS7JwY4vBbYWZnZnSwn9ERPsqB/OXwyFZZIqaJNQKvHVIyXv8mbz
         M5L0vFwHBWiLS/K2f1i2+y0ZvvsHVlF2NQc+1lTfwhd3PE/Nb5sWpVUVgYMDZcvJ3WDU
         DN4poBKRr+MyeVaH0fcbAaw8iG6xOxeFv6e0+d4jgfSQaG8oAEeToP1O19S9M/kN5CAB
         O7iWy+YI6Vunjk/OfnCe7ORQxJCZj34Lbg6zwhnb/OcYlyca7T9LDLMvvp/GzbJ5JqwU
         t3k8UpYs+D3PC5H+V6oxpY4OXAKrSwdqZ/4p2ptIiwVPzLu3rqmQRcbDB1HmWmpzHplK
         Y1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784984901; x=1785589701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wE/oVeYrmfIPAhJkzj10OLexdHg4SoKB+UjC7ETk4oo=;
        b=tRrC6TvyutoiOBnA9v0LkQB7rMbzz8iYaGgQ8FDJDSYE1QJwhG6xRIG9N2BzS5b/Zo
         qhOK6zpLSfhU9ThMrtms4BRhaFscDnsdNZKze5SzfDuDcREmZuPC3Vo2uLcIN/PViCsh
         87itl8M5orDsgtUNg8x/ZAFhktzdChGtN5JidFwFfG3QIpCLikSMOJM3xbvJvaYg1OGa
         HykeCcey0vzSFTURSYWnFJ9l2dfYSnoLX22gpGCpgNvavmIAV8h6HWIRPowcotF/3Bux
         gTK5vgp+zUsbV3wk4hXuxeUoBMKPCw81tQ2Gb93Zc2FQPMnbvmpq54A7HdJ5NHJ5s4Tj
         iHQg==
X-Gm-Message-State: AOJu0YwT7zKuTj4VE3gwEO0d/tHXRxvgjfDcnyn8qnhpgTRmCnPNpJur
	qnZms5dF4I4b9KuyQdoVgzDV0AbuzzAuk7e7aCfk5woKx/45hB4z+MPu+dxsQLjV
X-Gm-Gg: AR+sD12Dgxnf5Lr1cerI1VImMCbZqMw5Bp8f0wNdSMV8Vw6P00shY0tg6pPS/ooXqMJ
	VSPH76aMUbAg5UHRK3L/xSOxw2Z0YdUcSXX2BEwE/z8iEG+Va8CmaxnozlPn2dmHWjpl1DzjF/j
	s1C0dsuQAazoU5Awe0EonMCBij7lXNN0EnbdZSTFRReW2VZV7XFSuW/4cnFVz5wb2aFhBm93iyP
	b5s0AFrFWrzeuJTlLMMgCJL6QWRCtzD0BQTgL0iVUrg2puRYlIxHaXom/Ju4dt7R8VT2Zh1yAmi
	E2xMPyfI3Mu0AA3INaJ6s3AUaJg0qqqo/tJWS4atTFgQ38C4YhXod9wXlD1Zo1KYulDI1ax//aJ
	qjRHyryxhvBGUzWC/TTUk9ZJrjYu1GoekXxB+Xxaq0cQyqC+hEWesFJdrCmyI1OCgSLjffJkdcx
	qPqlL9PguZEYsrc37F9WD3vi4DQ60SdIdsS2I/
X-Received: by 2002:a17:903:3888:b0:2ca:6eca:492f with SMTP id d9443c01a7336-2cfde7a9a70mr20687655ad.14.1784984901405;
        Sat, 25 Jul 2026 06:08:21 -0700 (PDT)
Received: from ubuntu.localdomain ([49.43.243.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc59cfb4sm10282077eec.26.2026.07.25.06.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 06:08:20 -0700 (PDT)
From: Bivash Kumar Singh <bivashraj750@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Bivash Kumar Singh <bivashraj750@gmail.com>
Subject: [PATCH] Input: inexio: replace printk with dev_dbg and fix missing space
Date: Sat, 25 Jul 2026 18:38:03 +0530
Message-ID: <20260725130803.6763-1-bivashraj750@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace printk(KERN_DEBUG) with dev_dbg() using the serio device,
which is the correct logging style for driver code. Also fix missing
space after comma in the function argument, and remove the redundant
'inexio.c:' filename prefix from the message.

Signed-off-by: Bivash Kumar Singh <bivashraj750@gmail.com>
---
 drivers/input/touchscreen/inexio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/inexio.c b/drivers/input/touchscreen/inexio.c
index ac3836ff2a30..2fa04eaec292 100644
--- a/drivers/input/touchscreen/inexio.c
+++ b/drivers/input/touchscreen/inexio.c
@@ -81,7 +81,9 @@ static irqreturn_t inexio_interrupt(struct serio *serio,
 	if (INEXIO_RESPONSE_BEGIN_BYTE&pinexio->data[0])
 		inexio_process_data(pinexio);
 	else
-		printk(KERN_DEBUG "inexio.c: unknown/unsynchronized data from device, byte %x\n",pinexio->data[0]);
+		dev_dbg(&serio->dev,
+			"unknown/unsynchronized data from device, byte %x\n",
+			pinexio->data[0]);
 
 	return IRQ_HANDLED;
 }
-- 
2.53.0

