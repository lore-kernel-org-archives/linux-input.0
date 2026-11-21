Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.36.144.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795293679;
	b=a1PjYTaOv2a001pw21SihiIHuhMVi4V6W8pKRnhPJ2WG9AbmMrzjuXF5TKWL9xXS3N4W
	 L70xfnYY6G+YziKkl1dJbV6XDckCOFG7qAD4Mwe4bmARCgoKyU3NBbbkgWxtY7JWg+Z4R
	 jkSPdn7gbF7eSBPFyRUhiQ+zHoKXQSAL0TPGZmvKLW0F4VqkIuEgUriizoB4en5jmk/kp
	 0QDnDSd5csRblwH10SCNFP+QrXyhb51OtLSkdgkSB57+wG/whoHjczvJeP8d3NgWk4c+F
	 zAexiqAG4aHPcpAaBJSiWJUxGiSPsncX4agfZyaVhzXFBTAeegphnjLKzVr2P6qTHyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795293679;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=fmju87T4Fa2QAGnAL9j5gIorzJmuW3FK3+tNe5lkgEc=;
	b=HBwiMEO45auRXRc1k0XBbfZnubfGnYJXa6WPp8mjzhnz47868CIF82XkyHsO8uVNndxe
	 G0k2JHXwEoskCNBS+NZkvBHqzFIEowQP6RtTxNBsqKvBhR1E0tYRpEjosq0W1bA2Eknr5
	 0yw8NGqubKWcXQH27OuTUYebMWLXIQ97klYxk47o/RcgW9jHpMJkhwrW7mSWuXcC0TOPp
	 BU21W6Y1PNF7PqsX16dKtxTM5LsMi5DuVQxHGV7fPvOpWKviD97u1Folc/WmhrveByYbC
	 vzgUh8S2t8HNjtMn8EytPWf2KgGFJaIZQekhs0j+4C15Brs9RnQxdJuDeamvRuk8qxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yoxcu.de;
	spf=pass smtp.mailfrom=yoxcu.de;
	dkim=pass header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=UK9nEjc5;
	arc=none smtp.remote-ip=194.36.144.171
Received: from morty.yoxcu.de (morty.yoxcu.de [194.36.144.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A94606A333;
	Sat, 21 Nov 2026 20:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65A94606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yoxcu.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yoxcu.de header.i=@yoxcu.de header.a=rsa-sha256 header.s=dkim header.b=UK9nEjc5
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A76CA1D86DDA;
	Sat, 21 Nov 2026 21:41:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoxcu.de; s=dkim;
	t=1795293676; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=fmju87T4Fa2QAGnAL9j5gIorzJmuW3FK3+tNe5lkgEc=;
	b=UK9nEjc5E619jyK0d2+Z6h14iQXnoHetD7k+nMyqh5zv0TiN/n7ij2MQP7/3C3pZmz12f1
	y908r0JuYpGeiMWCHNHPm6zQ7tMYVJYs6XfShhgWx/AVvToFLWX+8VKTcYrg8G0QqgrTU8
	WRtYqA/pOIr6QCwnj77pqiyfdjxh0aWmkYnSve2kowB4AVaBOYXxgjWrIKbcHLFY11e5rQ
	UF5f+qMNE+nemY0jmlty3oFTMzb/JGtlepVVRkrB7TF62CzlQJ81x8d2hAtAL6shIwvQYC
	o52h11kqn52YypZnaPNalQgCdNrZdpadbh0exyd8BT/yh12UMFcLDDRYbEKADw==
From: Michael Auer <mick@yoxcu.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Auer <mick@yoxcu.de>
Subject: [PATCH] Input: pm8941-pwrkey - report wakeup events
Date: Sat, 21 Nov 2026 21:41:12 +0100
Message-ID: <20261121204112.847960-1-mick@yoxcu.de>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The power key (and resin, with "wakeup-source") is a wakeup source, but
the driver never reports a wakeup event. Its wakeup_count in
/sys/class/wakeup stays 0 even after it woke the system, so user space
cannot tell a key press from other wakeups. PowerDevil, for example,
uses the wakeup counts to decide whether to turn the display on after
resume.

Report a wakeup event from the interrupt handler, as other power key
drivers do.

Signed-off-by: Michael Auer <mick@yoxcu.de>
---
Tested on a OnePlus 6 (sdm845, PM8998) with an sdm845-mainline 7.1-rc1
based kernel: a power key wakeup from suspend moves wakeup_count from 0
to 1. On input/next it was only build tested (W=1, arm64 and x86_64
allmodconfig).

The event is reported for every interrupt, press and release. After
resume the press can be read as a release (the handler then simulates
the press), so reporting only presses could miss the wakeup.

Tool use: the analysis, the code and the commit messages were
written with an LLM coding assistant (Claude Code). I reviewed all
of it and tested it on my phone as described above.

 drivers/input/misc/pm8941-pwrkey.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/pm8941-pwrkey.c b/drivers/input/misc/pm8941-pwrkey.c
index 34b4afbb1984..3827e751297a 100644
--- a/drivers/input/misc/pm8941-pwrkey.c
+++ b/drivers/input/misc/pm8941-pwrkey.c
@@ -161,6 +161,9 @@ static irqreturn_t pm8941_pwrkey_irq(int irq, void *_data)
 		}
 	}
 
+	/* Let user space see that the key woke the system */
+	pm_wakeup_event(pwrkey->dev, 0);
+
 	err = regmap_read(pwrkey->regmap, pwrkey->baseaddr + PON_RT_STS, &sts);
 	if (err)
 		return IRQ_HANDLED;

base-commit: ab13b5fc808e043a13f861a7c1c2ba8173c22b84
-- 
2.43.0

