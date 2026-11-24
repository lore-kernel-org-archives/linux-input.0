Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795514783;
	b=L6mO4Hr1RHYr9B7zRgLfgv0/R7fbMoFGYj1osGvT9IGFBz53GfhvYLEtVaQSqnzM0oL9
	 mpDFio0rRCCGjNa5d7rh8fW85E3NET0Y4siPeEO0HhMHxpuZSnscV1xE9YasV0bbKZPdX
	 ALhmrCXRzy0wBJd/VJmnbMezSbQ5kaQhyvIWESah5Ax0KVziGA8ve838Mb3Y9t347c0GK
	 uLLnz9wfDduET2EvIpqLDD+amGiXcXKs6YvgyZqH5hmzfzTIpwN109OHZ4Sz1cTJSajF+
	 wcJiEfqDokFmd/bjy1U7boCwo4uwGwsdBWS1SPQ1aYotqE6DG8iE1OLC44J/JqpJ28Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795514783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=goejSGAp4IfnqTSxRNc89CxXB1nwqTfFiuZjHrzldo0=;
	b=HRdrKHnHnA2sMwT+NTOxnCHy+divXcf6UE/4XfXChWvewwCwEHJiO7rQ8NKaIMT7dW5P
	 Pk5C1x71++YjPx5YaQSJVLjie8XzE074QStd6I1Wje/8rYxKy5DXsYtpNRj7942blPkm0
	 ualMLBTM0rtupf0ePsK463b6Sm7+Adks81E4O0fz574XWkJzHMqK1cnNSAZz6aoWmVfNY
	 gsuG7T+pEenMVKP5p52ExRZeFwMparuQI/4CF5+giSHXcVcrMPyBQSFeqf/4zBL6Eva0Y
	 Rz525vuPEJEsMeTaUCz4GimOyw0OeYXJ/uRYK4mEwqT1seZFZNeOSRertsPJGsB/LQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=0x0f.com;
	spf=pass smtp.mailfrom=0x0f.com;
	dkim=pass header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b="Kn+IoJc/";
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51706606A31E
	for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 10:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51706606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0x0f.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.a=rsa-sha256 header.s=google header.b=Kn+IoJc/
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b40d23e1adso3003016a91.0
        for <linux-input@vger.kernel.org>; Tue, 24 Nov 2026 02:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google; t=1795514781; x=1796119581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=goejSGAp4IfnqTSxRNc89CxXB1nwqTfFiuZjHrzldo0=;
        b=Kn+IoJc/DvaEwHC14URhDRXWuXoxofpgo12wxLoC9rw3Shv2Z+C/lga6OrLMaZbeLX
         nrRChIM/IMr2wWUjscp4KYeeVRp3C1x0NehlmI/lpa16AFCgMvZsU4764Bi2i+RrfsVR
         k6ldQXVZ0qyok45U6DYl4ppxawZ1a2/85SU68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795514781; x=1796119581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=goejSGAp4IfnqTSxRNc89CxXB1nwqTfFiuZjHrzldo0=;
        b=kkAL/JovejZa2bzujGkkLZ+z9NHyxx5tcEQarhtBpL+I15B+rMLWsg3euzk5MEeF77
         WdHqpFDltGeb4ImlfcF4W49ZgVvIAbXbp3HqyOEsElCfKy1qcI8e2J+hwesNTcXgb8Xi
         JOl7RtkciSJKxTlqMiYuwb7rXqiu1u0XvppHvXs2/fvHa1IgWpialQsjEJt4rnaxarNo
         BaE9V9pMQLsNzbDg30faQgDnN2BWJQW29uoAOdSYkTsI/AGMGbcFp54e/tBSczsS0LUD
         FLAnM7b8BleZDVzVh2bmHHjVaZb9L7zBD1SQj0X6lZVHYcb1ctkDVyOb7utlneM7o9sr
         KHCQ==
X-Forwarded-Encrypted: i=1; AL+hErHNJ/WAfYvbDezCFFSV1x+/2Liq5N1ood2ZpSeLPdk++Insnpb6X3IuLTeSiDmuiDZVEUoy6LdsvABt1g==@vger.kernel.org
X-Gm-Message-State: APuU4Z/ABpN5D3i3HdkLKwwbXS212aHlsCPEsEwxZZQZMLGmwhSiXTnh
	DjXHMaYiWEie+ydr5XRsLI//G1OgJDUo04yzSUemQsLsFl9DVSC1gEbP1FnLdTN47NU=
X-Gm-Gg: AZFdTZdjvqSMdFhxFAhF6aDtTvwI04HLVr4IyeM8u/4I7nPW/n6oEOCe6Dpl3A91bO7
	Izx2S+JD95YUdip608xW5wRF+DsqHvoMB+ESIY9/HI6WuRFu6DqfUBtf0U4e/WualINygAdZBVQ
	hVncUt8n6jg3BLAZQalIEUphrmeQPjuSLczeVdGZV2cPGNPvjbAT7s2VQ8KzT+Q+YibC2D6Dn/9
	J5F95rA3/Ss1A4iYG5ACJV7I0zAooQ4RDY6af9pwCPU3vxcD2kDI78/XTY3KsaWeLMRGXIB9GaD
	F5y37Dl+O25+btxL9IaLlBTzPubKEjAShr4Fiz9N8DcGCrp6l72oyW5QSerUeVbK/xosMyc2QLe
	ShBsuZyKTmOGobD/NAEiTnjB6Y+KNDO0D1v3WbAmCYXUAsFLSSyB8NTIsV5zPSgOX/GeuZLJUu3
	T+gdgE9zQ1Mi2YWQo8W7XVO8MrdA7OtNGyjyK+045L6lpaBAHCYcCwG+TKLPAkB/YHUMKtb7dmJ
	dxtwypVf2aCRRDBb7bMXAQffa5m+SgXt7N4nJ+Jwpd55qWlC3JqBuvK5XeM4o7v7O1uwl6jN7LD
	1V53LUdL/UH/oT4UazhKWlpiCg4G1lqL7Pq53el3+SFlY/3Fx3JXTs1Z115ASwtrT+z3kqM=
X-Received: by 2002:a17:90b:2f8f:b0:3ac:9f24:44be with SMTP id 98e67ed59e1d1-3b41c92a3dbmr13975688a91.29.1795514781425;
        Tue, 24 Nov 2026 02:06:21 -0800 (PST)
Received: from shiro (p1721212-ipxg00e01sizuokaden.shizuoka.ocn.ne.jp. [153.166.141.212])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3b420e1307csm21080437a91.7.2026.11.24.02.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 02:06:20 -0800 (PST)
From: Daniel Palmer <daniel@0x0f.com>
To: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org
Cc: linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH] Input: amimouse - Fix the buttons
Date: Tue, 24 Nov 2026 19:06:04 +0900
Message-ID: <20261124100604.2380938-1-daniel@0x0f.com>
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

On the Amiga the left button is connected to CIAAPRA bit 6 (/FIR0)
and the middle and right ones are POTINP (called potgor in the code)
bits 8 (DATLX) and 10 (DATLY), all of these are active low according
to the "Amiga Hardware Reference Manual (3rd edition)":

In chapter 8, "Interface Hardware": under "Mouse Buttons" a 0 in CIAAPRA
bit 6 means "switch closed", and under "Digital I/O on the Controller
Port" reading POTINP "will produce a 0 if the button is pressed, a 1 if
it is not".

Invert the bits from the registers so the state of the buttons is
correct.

Tested with Quake on a real Amiga 4000.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/input/mouse/amimouse.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/mouse/amimouse.c b/drivers/input/mouse/amimouse.c
index d203c2a6c438..caf35ddf3d06 100644
--- a/drivers/input/mouse/amimouse.c
+++ b/drivers/input/mouse/amimouse.c
@@ -58,9 +58,10 @@ static irqreturn_t amimouse_interrupt(int irq, void *data)
 	input_report_rel(dev, REL_X, dx);
 	input_report_rel(dev, REL_Y, dy);
 
-	input_report_key(dev, BTN_LEFT,   ciaa.pra & 0x40);
-	input_report_key(dev, BTN_MIDDLE, potgor & 0x0100);
-	input_report_key(dev, BTN_RIGHT,  potgor & 0x0400);
+	/* the buttons are active low */
+	input_report_key(dev, BTN_LEFT,   !(ciaa.pra & 0x40));
+	input_report_key(dev, BTN_MIDDLE, !(potgor & 0x0100));
+	input_report_key(dev, BTN_RIGHT,  !(potgor & 0x0400));
 
 	input_sync(dev);
 
-- 
2.55.0

