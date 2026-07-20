Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D33218E91
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784517869; cv=none; b=I6BQHB2M1tc36r6BjBmeOrqsB4J/p4FnxPBMqrgOFQm3hCef4+f4aTg0++JJ1dKY9vHo6LdxMI0fcnpi2AkCyQLTU7Zv9WIxK7CWghYPstNdkkEtTQiSVxhdxRPHIdy7VhIooyUqcPM20caSkz8dNqiCpmCSJe6ApaKLnZFDe4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784517869; c=relaxed/simple;
	bh=fXJaTY342P+XgEXJoBCmz19fLa3a/cowk/nshHOKq1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NG7KCd1ZC5aftrqa37QYQKvFwXEl7udrXc2nVrzTdbRCkdnXkf0ilJFOmoJY8zUL0j6H6iHYlYzG1eewPdUoAMBxi965xeERLRQtecAUr896XGbQhFSi7bef1zst4U/vapPcVL8oq5Z+0Ur2pi6SF8Dj5RyxXs76hBylF6HmU1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQm0+g54; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQm0+g54"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc97653887so105868625ad.1
        for <linux-input@vger.kernel.org>; Sun, 19 Jul 2026 20:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784517866; x=1785122666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VYfXfJSEmYiCJ+wWNEWlG54FSQalHemp2b+6QF0xc2w=;
        b=WQm0+g54CtxJvHcMYIsWS4S8xhiYWfAlsLtghiq0awdVGzzDSD6mN98a3/pNS10OMB
         /qNbSkWx7uj7djB5SDkNuyh9svqNSOgj/FOL9Rn7NsmVjmmODkSpOmSzZ9lU704CfYdC
         uoYqkadA81jHh2grYMR5ZTbH6I+nCJMdsyu7FeItSTt8qIby8ssR7CritBH88enfAKgO
         Urjf2Z2t1Bm0IPJzksUJynSEWXB3FZbvs4aVU3gANgPCotS/y/x568YZiBSR2bBqP9lZ
         iZMAsGolFwzvb2Q6UBi0MZfGYBVmoJQAR9KgHMVKaWafgHOUREXhmNTkT2x/7BCLM5NM
         6aLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784517866; x=1785122666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VYfXfJSEmYiCJ+wWNEWlG54FSQalHemp2b+6QF0xc2w=;
        b=jORpVPPmrsDAWmodGjdOyNOOTbyKQxWcDxtap4Mp3aDAHqPXPT+FENT8K3Se1kNjZJ
         rs0c1an0tQSLudnbbYGXcD5POtfyXVwNdMz9T4KdzTUHRxkxCu12M7mRz6EEIRV1Yiu7
         908yWfriYppon0xGGSHxCjm6McrafXSh89Wtcs0r/a3+nkgatOpHLCJYushgAs08XqdK
         p20nVi9itCvsKtNYieswK8BqCsuo6t1FoXcMqyMGsYVBWUAFZneQ1a6F+VLAFAjni/dn
         zc6vVxLYj2bnUkUWv8T1uELC9UnxrttZWINhJPIxYh2WX+Vg6225LcO9uajRJ7o7gDqf
         t1uA==
X-Gm-Message-State: AOJu0Yyzf8ZNOgXBYRXDOTSZLidQOn9V6N6fIxtw8I+h6NEYLTQmvpB2
	SJsLemhMO7d+UfQclh0RkpV0NMR7jjqLESkAGUV9F05TKSbbQ3qsdWTwNi/8pREb
X-Gm-Gg: AfdE7cnZxGlSjeOFpiGhksN8OxbUL8esxoTY3H9/MvtigIG5Qb9ZR4s2NohY5rOVw2s
	0AMUiVlePw4jNiKpeWyM0BQnAkzqQSxGXneUp4L29owq/3oBuLXVXiBbHwQ/jjgLWokQksGPF5U
	Wj+aWNNC9UFy8zsjhAfYTI8bHiwBdZWv9Kx50a4wU4+XdgNsMt17C7jorLmZ1ieTwEALjgyPH93
	qHHJvZ7Jtmw1r9U27npGW55Dnfk/bUw++Mt2y2e9Zae/sj5ZjT7Ox5s6mn1WJaRqm3BTAtUxrUq
	12CAVHf1DZA4yse032D0oSLy2TZb3FBOFzeLN4AC4DXD1dNPNS/pTB8ic97V/atVNZj1DCN/LOK
	Ttze1snPpzf0Nqy6x5GDWeie8VCCeFAn/GDmUn0yjXtbB6FPmpQkidvDqBsHB9hXPOm9uuvgUeU
	XXz0Q4m+nSdGjpLeopEZH8SL/wtw==
X-Received: by 2002:a17:903:1248:b0:2c9:cf5d:d9bc with SMTP id d9443c01a7336-2cf349c979dmr132096095ad.35.1784517865544;
        Sun, 19 Jul 2026 20:24:25 -0700 (PDT)
Received: from ubuntu.localdomain ([49.43.240.68])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31429f9bcd9sm31788505eec.3.2026.07.19.20.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 20:24:25 -0700 (PDT)
From: Bivash Kumar Singh <bivashraj750@gmail.com>
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com,
	Bivash Kumar Singh <bivashraj750@gmail.com>
Subject: [PATCH v5] Input: gunze: replace deprecated APIs and fix warning style
Date: Mon, 20 Jul 2026 08:54:06 +0530
Message-ID: <20260720032407.4644-1-bivashraj750@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718190040.10613-1-bivashraj750@gmail.com>
References: <20260718190040.10613-1-bivashraj750@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace printk(KERN_WARNING) with dev_warn_ratelimited() using the
serio device, which is the correct logging style for driver code and
prevents log spam on noisy serial lines.

Replace simple_strtoul() with sscanf() to parse the comma-separated
coordinate data. NUL-terminate the receive buffer in gunze_interrupt()
before calling gunze_process_packet() so sscanf() and the warning
message can safely treat the data as a string.

Signed-off-by: Bivash Kumar Singh <bivashraj750@gmail.com>
---
Changes in v5:
  - Switch from kstrtoul() to sscanf() as suggested by Dmitry Torokhov.
    sscanf() naturally handles comma-separated coordinate data without
    needing a local buffer copy or manual NUL termination tricks.
  - NUL-terminate receive buffer in gunze_interrupt() before processing.
  - Use dev_warn_ratelimited() to prevent log spam on noisy serial lines.

Changes in v4:
  - Remove early return on kstrtoul() failure to prevent touch state
    getting permanently stuck if a release packet contains noisy data.
    Initialize x and y to 0 as safe fallback values instead.
    (reported by Sashiko AI review)

Changes in v3:
  - Fix comment style: add space after /* and use NUL instead of NULL
  - Add missing Changes section that was absent in v2

Changes in v2:
  - Copy packet data to a local NUL-terminated buffer before calling
    kstrtoul(), so the comma separator does not cause parsing to fail
    on every valid touch event. (reported by Sashiko AI review)
---
 drivers/input/touchscreen/gunze.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/input/touchscreen/gunze.c b/drivers/input/touchscreen/gunze.c
index 2baeb4f3b941..7a92052eba80 100644
--- a/drivers/input/touchscreen/gunze.c
+++ b/drivers/input/touchscreen/gunze.c
@@ -41,15 +41,20 @@ struct gunze {
 static void gunze_process_packet(struct gunze *gunze)
 {
 	struct input_dev *dev = gunze->dev;
+	unsigned int x, y;
 
-	if (gunze->idx != GUNZE_MAX_LENGTH || gunze->data[5] != ',' ||
-		(gunze->data[0] != 'T' && gunze->data[0] != 'R')) {
-		printk(KERN_WARNING "gunze.c: bad packet: >%.*s<\n", GUNZE_MAX_LENGTH, gunze->data);
+	if (gunze->data[0] != 'T' && gunze->data[0] != 'R') {
+		dev_warn_ratelimited(&gunze->serio->dev, "bad packet: >%s<\n", gunze->data);
 		return;
 	}
 
-	input_report_abs(dev, ABS_X, simple_strtoul(gunze->data + 1, NULL, 10));
-	input_report_abs(dev, ABS_Y, 1024 - simple_strtoul(gunze->data + 6, NULL, 10));
+	if (sscanf(gunze->data + 1, "%4u,%4u", &x, &y) != 2) {
+		dev_warn_ratelimited(&gunze->serio->dev, "bad packet: >%s<\n", gunze->data);
+		return;
+	}
+
+	input_report_abs(dev, ABS_X, x);
+	input_report_abs(dev, ABS_Y, 1024 - y);
 	input_report_key(dev, BTN_TOUCH, gunze->data[0] == 'T');
 	input_sync(dev);
 }
@@ -60,6 +65,7 @@ static irqreturn_t gunze_interrupt(struct serio *serio,
 	struct gunze *gunze = serio_get_drvdata(serio);
 
 	if (data == '\r') {
+		gunze->data[gunze->idx] = '\0';
 		gunze_process_packet(gunze);
 		gunze->idx = 0;
 	} else {
-- 
2.53.0

