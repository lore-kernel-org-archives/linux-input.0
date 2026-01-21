Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F604425CCB
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977663; cv=none; b=CHnuaZHGlvljb88ooGiv6noeG3Lgnl+oAv3bn2RL7eOsreTVmk9JULyz5JDGWMiIorgr30YYp+RMOLJkkHhSXFTE+MN5NpyhMsuLduieK9vBkXKWkFRMNo1Szn8H2o8x4y7uRLTRJ8c4N0hLtLVhWGGjYMTuZJzMnDLgORK6mb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977663; c=relaxed/simple;
	bh=0VwuN9/IjqODQZh9DgW6KWamSmxw251Z9dlyrHTtyUk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CnOGlsugeFp4Ed7S5ZJC/Acow756WsL6naLq0n3futnVRzBbAUBCJq68ffmWqVNXVUuE7IjUvJ0AlKr6rB8g+S+YGi61StRx52a10tsu+Ecc4SNdb2Xf1N+nNhMu54Z0PFYJOS50C2uvK/ZA/4drfBGHzF9drUE34uwpELqxDPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZzmT6Vv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZzmT6Vv"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81f5381d168so5578814b3a.2
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 22:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768977661; x=1769582461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mkqmypmkTIuPWsY5B5pc0P3WmdN0p6dQtsQrpbKtq3k=;
        b=PZzmT6VvkW6SabKT1DHfyulMWAENwq/B2k1U+ijWGlu3ihENu6V/Aq8kT4j1/O0D3j
         7KcWMrniJMRd3zN4wpDK6EIaltDhDCw17p3qR28BWR/F/f77R7nJSrf1EF1o22ZWGXyp
         kGF2KI8iLV38EDrS1uih+0J15MvpO2Yirpf8djQ1tS6xRWN90HDnFhbTwtnEpUdyOyHx
         ps3v+kr0kWSuZztljpb7PtHZarLpBZV3nAdu81QNjY2am6qxXJwAzttqMxj3aPBWPPSe
         kNFa06QlxmpvTLWoV71cGe1n+VzopXG1VH8+G3YUV41Aj5HrLqdRcfR3bjchxAhARbo9
         weUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768977661; x=1769582461;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkqmypmkTIuPWsY5B5pc0P3WmdN0p6dQtsQrpbKtq3k=;
        b=SU6bc+y7OgmerNY3wLRtdUhbFKlH17Zau7XiDi8hGw19a9dvYRJ40AWysxgFEAH0lw
         AuIjEva+2tGnjc6fUP6CevBuwFFKr3ImMpngUPwuNjrlVvBJN17Bx7CLdAXq891l1RBj
         TdvuuWZtNpkgUowchcj8IwAR7+lrIHt1oyXduSLmvWH2WAlHVRBB8kli8Zn/MEq7kzla
         YOxlmIHqjqBrBSa0yNF9Ltk67PNinBo531TtyOhr0MJPWF7Dkz9D6mTE+yERGsqsSqKA
         gsXTqOuwQAhSEl9jKbBfQ5y/SuSOGA0LVP9XlO/xpcoNapKqC0+Fyj9aGUdw+cf/X8d/
         NnmA==
X-Gm-Message-State: AOJu0YxtmyT6wZQuVioubSV/63+SEDo/wGk0ZCEDvBVBcGBhHyUvD+e7
	xBuw2xPht0r+miFR5AWCBaYHAyTb4Xh6cYjj4yEA1C1i/w+ShsrNGoTXEClTfw==
X-Gm-Gg: AZuq6aK7mDgqS/taADcvgZ4n3Hw3eMXOih/yIb+L47IzYtw41hTK3TslMYW/uiRIxxQ
	XQOfRvaYzLHaCjYTHSn49FnnK0rP5PlvwJ7ScwBKBYAUZIXfqafasDKJTZ8U5uQtjBObB0/tpWO
	sxwfDtQpYdtytZe3+GdDciZ8vaHwFBgw/It293KNEHFaPl4DJtMtw6YE3LWsCqri68CSCgbhgeG
	+2t0sSPhpPYQpj5Auc1DMShP6YCdCoJ55s2FDX/JllGsm25uRYEvXYTWDDihx4+noFAW+TIxl8h
	VG6ubTlXfK5sP3ZXaWB6XiH4YvuOIEvohn90DGA2wcacqgKWpjc6h6KXBr+bOk5yA5UJ9OPqb7x
	vw42VvebRTMIch7ebTslzmysbGp9DCzbdGYU0McN77xVtCA68iQOaf7+rU5/jirpS4O8NHG5Ug9
	kQZvc2QqK1VZIYzYQAK7R8WGnU8LG/AmGmRXO2Ps5E
X-Received: by 2002:a05:6a00:244d:b0:81e:2bca:d133 with SMTP id d2e1a72fcca58-81fe87dcc5emr4313356b3a.24.1768977661233;
        Tue, 20 Jan 2026 22:41:01 -0800 (PST)
Received: from localhost.localdomain ([121.190.139.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fa10bda5csm13898092b3a.19.2026.01.20.22.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 22:41:00 -0800 (PST)
From: Minseong Kim <ii4gsp@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Minseong Kim <ii4gsp@gmail.com>
Subject: [PATCH v2] Input: synaptics_i2c - guard polling restart in resume
Date: Wed, 21 Jan 2026 15:37:38 +0900
Message-ID: <20260121063738.799967-1-ii4gsp@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

synaptics_i2c_resume() restarts delayed work unconditionally, even when
the input device is not opened. Guard the polling restart by taking the
input device mutex and checking input_device_enabled() before re-queuing
the delayed work.

Fixes: eef3e4cab72ea ("Input: add driver for Synaptics I2C touchpad")
Cc: stable@vger.kernel.org
Signed-off-by: Minseong Kim <ii4gsp@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index a0d707e47d93..fc65e28c1b31 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -615,13 +615,17 @@ static int synaptics_i2c_resume(struct device *dev)
 	int ret;
 	struct i2c_client *client = to_i2c_client(dev);
 	struct synaptics_i2c *touch = i2c_get_clientdata(client);
+	struct input_dev *input = touch->input;
 
 	ret = synaptics_i2c_reset_config(client);
 	if (ret)
 		return ret;
 
-	mod_delayed_work(system_wq, &touch->dwork,
+	mutex_lock(&input->mutex);
+	if (input_device_enabled(input))
+		mod_delayed_work(system_wq, &touch->dwork,
 				msecs_to_jiffies(NO_DATA_SLEEP_MSECS));
+	mutex_unlock(&input->mutex);
 
 	return 0;
 }
-- 
2.48.1

