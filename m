Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CDF2E3360
	for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772307151; cv=none; b=e3sBKoqApqa1ilWIm0ymiQJ6/JcAAATVLhJN2MqxdJ/DG0GXpY2p57VyaIr8jAply/00C1/+B9hd6FuAuJms3S0oxbMNpgTKsGSVWCuCtVSQuhgQC82jGMyGj4Cqi/rATX8+HJoPCas9ClS2ZfQ4qmNN1pCA6YadAF6kdcj1OcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772307151; c=relaxed/simple;
	bh=0sAsa6ybtQ5ZkMfGyBtMQWtOKY2OoObuTvD4DUN3Ryw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sRuxt6c/vzeEzpPFA4bcPRLEgGo45xfWgQQQ7VlMUqjAXuW9wHU5SgiDzIkFwUJxNhVG8LTzGQnPXTBTXV/54Zg9i1Ua3j+ForVONyQ4F6yeHAuCZ5HRV0kKEfYBf/yKlS+7vw936s31VgVbYGhePZqb0tVTPyxA1zhQ110g7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZ30iMMW; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZ30iMMW"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8ca01dc7d40so341245785a.1
        for <linux-input@vger.kernel.org>; Sat, 28 Feb 2026 11:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772307149; x=1772911949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HPxClJAjqyS7cuTPxVrKNCN3pobl/Xm4GZM4HVCQihM=;
        b=HZ30iMMWvctxvO5n98bkHaxykv6vTApJZV6eKGkNOPjZfI/IlSeXEYHNoxCnaORdg5
         rYxYyDgGXi+iFvmVcjfv9ijWir4NtytTuXyVHO7Fmx2AyXOOkOHDx+aUVyYTzZYPMqD0
         xKN518I5rbwXVyI/fiCJ/BHXFYpHd053/Zk6IiuZwy64wPT09wdxarjQdYx5RAttkYVm
         orlNASpk0HwpKAwVmXGXgWzWUgZXDlthwCAwjQXpCgwzuciSW475vihkAVeo9JnIeD9R
         nK0UyG69p7s+BE+XhlaVO0pgtZtoDO9ZFMo6vwoNjmLRmML4a5eaiQfHh9KoH2qYu8ol
         omWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772307149; x=1772911949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPxClJAjqyS7cuTPxVrKNCN3pobl/Xm4GZM4HVCQihM=;
        b=o+NjQTNEhxGxtmge1zSB+Y01skYurFgMhgv3+ztZhthrZARRVZIGlB0c9Xa/gQye2L
         /cdhvxysePGoDz1WzuvuG6h7QIdm1OzbLL46AXOtsvH0ZCbX41+Ff6eTyWw7UIJxPKwb
         LZcrtrg7K56qasj/4+/jLLbSo0R8K4AEwHL1687CiJSbi60zqYuWqNXasdiuBt0651ru
         zFjBEUG1adt5vfuhMF4m4pQSQIFX2h6hoBMTThrpHcA/tlGxpP/oHPNgnfRuSpDoCuvo
         8INprDKLjnoa/Rxi+aOBtUmm25yuIUfhDA2q86F9x5Rat0/dcyOs0KOT9kSIYLY6kWPk
         p1kA==
X-Gm-Message-State: AOJu0YxXHhcu1s3oKS5Ee3fOkC2VM8oibzb+qMh46suNvC8CSkldPOax
	SU5KRKHNBGn3/wIugXjJC/hp857neKss0GiyE9ZYUzvphegtoK4jHhg4
X-Gm-Gg: ATEYQzwdZPtxtx9BN//6+UCpLltM9333J9bmGIfG2uWaxixmT4xZHXBYYxL2qMWNMWz
	z0iFd1uLCvabiPdcTSXS76r00LliFBrQ4NObkmHfgcZCOKSrH2wmhti5hgfvAXB5GRXs8hX7pB+
	XMOaLksvz4h8aJGQhlPD0TWxbOkjubswXGyNgy2Zj7rd4tGJvFixGQX+wHUUPpKrXjs+2wBadP2
	0T5VdmMlwkhRpWvDGurEuELnanhennM2vNqewL69RJyHpL/OMGS4vbDJeb+620fthCCMkAacPbK
	G/TWgkKMaCRCIBIuC1pCSmyDwGt4sYp/JrJXuuJnqces1DEd7Na2329VlyDP5OCyPN4hibTgipu
	OjKNJecEpGQAfV+0ljWrinoikBGlFhu9SjuxvmZ4ZVl/by9eirTrU1iQGF3kpOYEj8EHZ4bCAEX
	R6CSWg7NB9me4S0Lz57qvM1D4EnVnwXyR8iK+x8/gWjh9xWlPAtTCsPu47YN6G4gklJw68L2052
	XVY
X-Received: by 2002:a05:620a:199f:b0:8cb:81db:8e46 with SMTP id af79cd13be357-8cbc8e7ea89mr927555685a.23.1772307148718;
        Sat, 28 Feb 2026 11:32:28 -0800 (PST)
Received: from instance-20260207-1316.vcn12250046.oraclevcn.com ([150.136.248.187])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf732bc1sm771295685a.46.2026.02.28.11.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:32:27 -0800 (PST)
From: techyguyperplexable <hlcj1234567@gmail.com>
X-Google-Original-From: techyguyperplexable <objecting@objecting.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	techyguyperplexable <objecting@objecting.org>
Subject: [PATCH] Input: elo - fix style issues
Date: Sat, 28 Feb 2026 19:32:26 +0000
Message-ID: <20260228193226.2466067-1-objecting@objecting.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix array constness and spacing issues reported by checkpatch.

Signed-off-by: techyguyperplexable <objecting@objecting.org>
---
 drivers/input/touchscreen/elo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/elo.c b/drivers/input/touchscreen/elo.c
index 434b9b47e964..40ae132cde21 100644
--- a/drivers/input/touchscreen/elo.c
+++ b/drivers/input/touchscreen/elo.c
@@ -257,7 +257,7 @@ static int elo_command_10(struct elo *elo, unsigned char *packet)
 
 static int elo_setup_10(struct elo *elo)
 {
-	static const char *elo_types[] = { "Accu", "Dura", "Intelli", "Carroll" };
+	static const char * const elo_types[] = { "Accu", "Dura", "Intelli", "Carroll" };
 	struct input_dev *dev = elo->dev;
 	unsigned char packet[ELO10_PACKET_LEN] = { ELO10_ID_CMD };
 
@@ -273,7 +273,7 @@ static int elo_setup_10(struct elo *elo)
 
 	dev_info(&elo->serio->dev,
 		 "%sTouch touchscreen, fw: %02x.%02x, features: 0x%02x, controller: 0x%02x\n",
-		 elo_types[(packet[1] -'0') & 0x03],
+		 elo_types[(packet[1] - '0') & 0x03],
 		 packet[5], packet[4], packet[3], packet[7]);
 
 	return 0;
-- 
2.43.0

