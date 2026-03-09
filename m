Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF5364026
	for <linux-input@vger.kernel.org>; Mon,  9 Mar 2026 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773040489; cv=none; b=KGwHr37s05HC9Xf2T5HSkvoNaQNlaWo01l/lYmAam8fV3O7YobEyZg+d0BWkLXQmzAPvEQ9YVqWUsKyKgh9gNlbwkxLDQqujFt8b3fAsJ/sq3KyBb6sQqCDdYrWaf6bqFVML1FNVdNHGphMZ7z6noq4Grr4MnzbbE57vUWGJZtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773040489; c=relaxed/simple;
	bh=rkC8P++ezNTx6+/pK7aTphkaTcqlYYJAX7IJ7kVb1lI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQ1tAHE/3UMsRbwiMe/jBGGeZ0HXTTbIXfupzCMMqYHjOoipPCasaj15zUs2Z8Tk/RVzaZXnq5FVFZnJRb239tfuKl7h++Wm6kNapjMvylBURw7XuFKVo8Y+KmAT58AGhi0DxuLobyxm8f0Rerq9PBElEkXnT1Q79JisPumILOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpKJ//s+; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpKJ//s+"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-827270d50d4so11367476b3a.3
        for <linux-input@vger.kernel.org>; Mon, 09 Mar 2026 00:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773040486; x=1773645286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G6HUsO3M7ZZ8Ut9rj2caYw8IlrcrpP3M6Iiwk8QM1Y8=;
        b=DpKJ//s+AXZi2R5MlKiTt5zgJXd/2cR61b/JU1Sj03Cj2RjIxuz+MsarEou9It1ut9
         2VRpuCF6ekrwH2CpmLsLX2noj0CoghtMCf7XLdhWCkXkL1LrkIWOdRdAJXQy9xsBIeKz
         F0w6VRi1k1pAuAJNsjqv7d32Nd/IKyFT8HUAzqwXiy45McdqMlxr8VghKvCPlZhloeUU
         RDw5fa5MewdSoE3nR5wtGocXBvmmn8KarLDGTvXj0lFlWyAbcRGXvAM5w9INo1NB4tiJ
         5W1darsja702o5v7C2VqsecQAUo14gyO7te1gDNquA61KQeEOnhqCEFmAPxlOD3F8Owe
         YBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773040486; x=1773645286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G6HUsO3M7ZZ8Ut9rj2caYw8IlrcrpP3M6Iiwk8QM1Y8=;
        b=YCw1jcZTKSDGOsX2CkVKAbqSnGXVrkJS+bO0uHW3nWE4ZYyNICQt7cuImbm8qdIEsF
         bnRel3Q3iER4NP2z1VG9UZ+AJ9Bh6JFBo7E3WUnS/hddbq4PCSxFkxnTki1nGxwb5dsd
         Fk2A2GcGsQfxFp3cOrxp5K6mDwEYQKs33uQx7IU1d3ER60OSrBEduMZuc8Fu0sTUi3YL
         ZfX5HvnTtyPLQqz83esTRXj5U+bnvP161ObWwvx9gWhjrTUM4M0SVGTJYAy9IulhCvq4
         ED2Nqi6ABPii9suyZOTKWZaooCISXXkewKdiTzwMaQKEXbTfr5C3ZAa+aiSoFzek+6UB
         vS2g==
X-Forwarded-Encrypted: i=1; AJvYcCUWQMy9Cs8mx+dwOgA9UYTNkT6O6PB4uv3N3a9wcB6w6wpH2kVrJrtURBYCVWgJh5qZeOipCe60/qs1OQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YycNOgGmHmc92FQ4H9v+/tXo9JMC+aFy0QsMLyHN3Sqtn5mGmlg
	g+ojaoFg+iWd1zh9bhg5CbY6DwmXGedBMLbGkBsW2I4IHiZj/Wbq6HhH
X-Gm-Gg: ATEYQzyGVdzN5Fs2FqYSwYQ8q9FBsmIjvtat4xv25dl7do5xRezXNEITduAspDsLpjQ
	DUdEtZ7w6b6ryAaeRK8/OpzMnhOiKpfHm3bEIYg7Zun2wF67T6U82Hr+D0uDkHBtFAuPlmoau5i
	snL7UctC9rKRD/WXu062c0f66h/wIKENH+Du30fdM0MYMdmlX0BwW1JC/kD03r2srlsW7QEIMb+
	CAantG/RqxzUbP9WCP2r7g+8kAfOkyrgvdpeYVbZ+sFA86S9ljyvrGA2bjd7M+dy0In0JiITGrR
	1e1I5pyYDKZTlOsW3R7Vm+hRHjJ/1rb2UDCU3qtcrLHFEv3kE92TuzqQC4Xbqx2oNDdZINy9te9
	B5XlT0zLJ2yPLWH+EYMlNKldZpAiuARK1fhsfX2Soiv3OSkUNkfzP18fS06V6CFQKCrfsCouhgH
	ZGyQaLGfHZRQkjevCdKb3gyIz5dy9skmF6CDRADmbV+dNNNFmDXqwln1eI7g==
X-Received: by 2002:a05:6a00:1827:b0:829:6f37:158a with SMTP id d2e1a72fcca58-829a2e3f823mr9422325b3a.18.1773040486495;
        Mon, 09 Mar 2026 00:14:46 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636cfbsm9052571b3a.13.2026.03.09.00.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 00:14:46 -0700 (PDT)
From: phucduc.bui@gmail.com
To: dmitry.torokhov@gmail.com
Cc: phucduc.bui@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: mpr121: Drop redundant wakeup handling
Date: Mon,  9 Mar 2026 14:14:13 +0700
Message-ID: <20260309071413.92709-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

The driver currently calls device_init_wakeup() and manually toggles
IRQ wake in suspend and resume paths. This is unnecessary since the
I2C core already handles wakeup configuration when the device is
described in Device Tree with the "wakeup-source" property.

Note: Compile-tested only, not verified on hardware.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/input/keyboard/mpr121_touchkey.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index bd1a944ded46..47edc161ec77 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -295,8 +295,6 @@ static int mpr_touchkey_probe(struct i2c_client *client)
 		return error;
 
 	i2c_set_clientdata(client, mpr121);
-	device_init_wakeup(dev,
-			device_property_read_bool(dev, "wakeup-source"));
 
 	return 0;
 }
@@ -305,9 +303,6 @@ static int mpr_suspend(struct device *dev)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 
-	if (device_may_wakeup(&client->dev))
-		enable_irq_wake(client->irq);
-
 	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR, 0x00);
 
 	return 0;
@@ -318,9 +313,6 @@ static int mpr_resume(struct device *dev)
 	struct i2c_client *client = to_i2c_client(dev);
 	struct mpr121_touchkey *mpr121 = i2c_get_clientdata(client);
 
-	if (device_may_wakeup(&client->dev))
-		disable_irq_wake(client->irq);
-
 	i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
 				  mpr121->keycount);
 
-- 
2.43.0

