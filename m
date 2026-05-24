Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238E3126B2
	for <linux-input@vger.kernel.org>; Sun, 24 May 2026 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650496; cv=none; b=nKozfa7Y+aTznIfukKl56ok/Ndbsl397eMFPZ5ZQUoyF1WdTw/BFK1Oy92PCrqqOKhALOHanyCxeZkkH7WFoDJMslvuRz7y3Zq9pooF4mhffMhcowJ0yl+U2xHJlLTaGzurWtle6Gt7npH3he/cT29fWvFtxCpyhxww8Y/HkiA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650496; c=relaxed/simple;
	bh=uU2eiFyXTnxuQK4zNACnVAy+a/gOKwty4OvYdhC1GG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RBdXfP1g1dMVHHKWdII/4PiiWh9nSGo2Sz4gWePzLtzZY622NCokTLn3s+R3HJ1BxDMbQo+5phEcNIDfobUPhqbs0xNDfy+sr2Y7nNy6uhuReg48OtSrpeGsJiClDDm56/bzdRz7SB4KWP/Th5EjVmCrCg0Ef9TPSqWt7lrNxsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW6w0NGy; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW6w0NGy"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-836ed29d1e5so3935658b3a.2
        for <linux-input@vger.kernel.org>; Sun, 24 May 2026 12:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650495; x=1780255295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+gs4epJAJOE0qHD1Os2VxBK03Jh6dC2/iMJV4EcBlM=;
        b=kW6w0NGyUuaZ8r1idtHAMqDQqZzQIZcmNF1NVqRpZh3JmA1dhP7f+rDa5Pg1/4Fk3k
         77UpUHO0iqr9uGMuBXbU+btRAF1mcUYYcuyBolZlHD4JHRacEF74b07aUn6jQIIcqzQ9
         WGQOAIfPCN1v+DSbPwqg2hB6vhXUdMUzChFc851czR0ybhLltRy0UyPSXPHEKsOrHjbu
         Itt1hMYrl3fUl+8zYQvNi6HrSc14Z2fofkDPAZsOSfEjZLdQd+kJ1IXVU3R//gohQL35
         SzWopjejjuqLSnBdaJxS8mfD9g8fF0pSm8inwQHJy8svivxOktqU9FLR86ENP4YYZfFM
         uSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650495; x=1780255295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P+gs4epJAJOE0qHD1Os2VxBK03Jh6dC2/iMJV4EcBlM=;
        b=pP04TjU57yUhUX8I+91ae8VoncImoHRdFh62GebgFeHRFWxXouV+FUhC6AdGy8ZAn3
         dGllpdIfG+XRT6zK2dwiaHmw/gF6xiq+euvz/UR2MskevTB4SG5X0ItN8E2HvaDHhjpY
         nA43+LDqTWQYGF/dNHtPdu5VwIHV67c0PlpztqGnDJgWn3T2KiKAMV3pIo03hmI+wBqc
         KrEZvprScVx8f2SH4QkLw9MU9B0p+mmoGt8LMDiciYVb4s/RL8HSynKCFloqSbxyndGj
         PD4Ip5EWR56w7AhQWdRtLcwoqp1VuIUtvfMaoAnQRoS+QewCIAUBcpw4Xah4kDDAefLU
         7v1w==
X-Forwarded-Encrypted: i=1; AFNElJ9lbqBCn4BDawW1nN9uHLCH46WtehNjE1S5/hBIkiERGg4t0Rpwxj5N7bsxkr4BwSyWZMZDvwnY2xbarw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7wfw/OcfB3t83DB3WgmOT/en8hJ6Zr4htfPO1qmdCDeT7tEGV
	qRFOBEVgFugmw9qVoUwnEuYrzpXfM33QqftsRKTYZgW6W39dBSyDFqJm
X-Gm-Gg: Acq92OHxZTEFaIUQq5bI1kF4fmqEQH7CWh/7PUetOjb7+B1DpnpSW6umS9TdiLOSvxj
	HDct/Yk6f4lg8z/6KqXQt7fnMMi14t4MZmbvmCN7ty/btAWrm2uPO42saN6WcvHD5v+gJ0jqAf4
	AcKUgWURI3zbNPl+eQU1FrmyZoLapX0PwhaZzL8hiGrG5BVjadk9xVu2/PhX4XKtLoF+wZbxJ0C
	Wkbiril9mMAeotzbPQ1dOu8cwWgq4t7s0/Yuhv+lSrUd60yzQJQb5uedUoT9EIHTQ/ZMgOJGkCc
	i8chFCBBEo9r/l+w6HgkgnChSuK0DBcSFx29Ll+g0DvUXHR4kxg+wXxEkerZoB/mgpyLcNmPJ/I
	JfkKLM9xSZVIi1XXGgfkl7n7yKq5Jsk91FMVNjT2Qq3QyrDQt5Eo8TDHoZu/0YjAafFhw8SY1Wa
	axF4D4O1H7vzrS+Axic4dCy5npGcTiTr/FcNZ+XjULrrY/mWjm
X-Received: by 2002:a05:6a00:180a:b0:81f:4e6a:7276 with SMTP id d2e1a72fcca58-8415f326747mr10650744b3a.14.1779650494774;
        Sun, 24 May 2026 12:21:34 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:34 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/36] iio: light: hid-sensor-prox: use u32 instead of unsigned
Date: Mon, 25 May 2026 00:50:28 +0530
Message-Id: <20260524192059.1193716-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260524192059.1193716-1-sanjayembedded@gmail.com>
References: <20260524192059.1193716-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-prox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index efa904a70d0e..ac55808f161b 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -176,7 +176,7 @@ static const struct iio_info prox_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -193,7 +193,7 @@ static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
-- 
2.34.1

