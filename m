Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED77436370
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031732; cv=none; b=MNp4ydNMMsHcGnKwx5fD5D3r9xfLl5gObrvNTscI1j5FiaDYKAsfXFJAP9wvRPWj0crw+hghvCeG72GRZ1kmHHCdW07oNOCCfCBqDyNx5VE0QJptRO9aI2gHE43wXFmwG1mhS8ILaWdC9CiBGIly84/LUqVCLE5zeZ8VQsH9HZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031732; c=relaxed/simple;
	bh=te36EN2hRUW93/ENPny/FcNtk4yqn76AHGFIBrtKCpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PCE0tTUi0+9vtFvCB2nz/o3fzNOryI17w4mSwXSkETrTWbSR2PAmlm18w1uqWJYZAfedb8uUAwaxzFxSlog09WdYMdOcKv96hdSsI7cyzJrn5Vk85ghLGfUhgHBZxPqeFRRk36WnayocY+bqfgaO0sk/11lPJisvGp5Z1lYYioY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kk158TJh; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kk158TJh"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so165783f8f.3
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 13:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769031728; x=1769636528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Infj0dCslIntYgR3E8l36IUqDoy5IPerf5hDlX8iy1w=;
        b=Kk158TJhLwgJPWni4IC2ci1YYbMCtza0mVsc00jKdLRMRlHqbq8QJUzgt1i9gLWoh2
         nv5Ri1jNIzXVks7zjDB7u4PeAcdnBlWA1N/nEUFzwlmbE43QVNBNnIb8ofT4GKvLfs8e
         WOX+apm91VnqxWBI07szES81PYjoRSonWM/es2uTnM1b+ZRrgUv9qvH0L4zCdvLNw7KZ
         Q1bBgwkyEsbaGsSYJrFZWeTxEXrliaSTK9Gfu+2/7OQoxDtz7LpvX1Mm/W3wD4rx96EC
         HPo6qnawR/mSCLFclbcPyjCNvWjuDFCATnJV027yLggM5kdEG9jvonT+r2tUIC3aV3t9
         Jl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769031728; x=1769636528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Infj0dCslIntYgR3E8l36IUqDoy5IPerf5hDlX8iy1w=;
        b=IQAkEK7ECNViEX9alJSLFcnconWxsl6g1/yPXMPq5qbx42v8hG3lPXjRnEDQe55HKY
         wnkpN3pCRCGnqQy+m+YqCOmE9muqWicuV3xfr+76pmjHiUIbLleYdgKTXd6//qSgpXZZ
         8u3/9HMhAABu4aWcH6wHkQMwpBI7WdxKS/hn+Va0DiX+ufSn7tRU7DpaAH+qjVnDB3Ji
         aBORRbgDhR1h2wfI+Hf6SAOuF3O0HipqfsXYp3ePVwJMyZ2304FpKSgmnx/1kpf6twdy
         wqbVoQFNukSY0t0mTSPqv4YB2p4UPZWlCwbBTLNSFuKyN9YwFr9kAsbuDK8a+MnEmgHR
         PwoQ==
X-Gm-Message-State: AOJu0YzRiQTHbz7lNUPlQvRhvOrTo+4aFiQ6N2KT+Y8eAM/4E9PHI+gz
	DZo87M2BUkkyQc3EW9tMRiAEpx3Oe37d74bXJTXA4XYlb6PSURL1pHW6kR6zk7Tw
X-Gm-Gg: AZuq6aJV5RmSrviZ6sKtzq3uq3YTIrLpI7/cDEFPeY/98aBsKAYllRLu/+IYqhbDM3+
	swVQ673gDOIvvGp1OkqcQ34im69OO7O21Lhwbu8wsKTyYcDRa8aak9nPGkDfDvnVY9Q4l7VzcIR
	pWKnJVBId6YyB0ZP/pJRWsi+/moqnYaYJcGwOkFCw2F+LNhEDDqpU536ZlnfUpJnDNCXknXCGHT
	xYWhFwxEUAI9eLiukh71l0YubVtGry3t5PM6Nd8ekBHtzSvfC20m3yXvy3j6fo/eM0sq28qpwH7
	szfdmi4LJFoDpiicbE1fkBqBEm09s1xRxjIDWfe55oYggRlU9HmLFUPRkCgh0WifnPQjersqSJ5
	PEQ5un9DjJaAa/ExOj7vp0fH8yNjFEsqe22XEopGwENcgHizQCg3tcj3o/mlYr7hkCdYmWGdGnt
	iD+BcDIgO4WMrIzdMLT2yx5wg0
X-Received: by 2002:a05:6000:25c7:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-43590174d1fmr11438375f8f.44.1769031727741;
        Wed, 21 Jan 2026 13:42:07 -0800 (PST)
Received: from unknown.tail46804.ts.net ([78.209.83.30])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43569926ffcsm38351929f8f.18.2026.01.21.13.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:42:07 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	krzk@kernel.org,
	dmitry.torokhov@gmail.com,
	Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH v2 2/2] input: touchscreen: novatek-nvt-ts: Add support for NT36672A e7t variant
Date: Wed, 21 Jan 2026 22:41:40 +0100
Message-ID: <20260121214141.36858-3-morf3089@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121214141.36858-1-morf3089@gmail.com>
References: <20260120193600.1089458-1-morf3089@gmail.com>
 <20260121214141.36858-1-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the Novatek NT36672A touchscreen variant found on the
Xiaomi Redmi Note 6 Pro (tulip) which uses a different wake_type value
(0x02 instead of 0x01).

The touchscreen was failing to initialize with error -5 due to the
wake_type parameter mismatch during probe. This adds a new chip data
structure for the e7t variant with the correct wake_type value.

Signed-off-by: Gianluca Boiano <morf3089@gmail.com>
---
 drivers/input/touchscreen/novatek-nvt-ts.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/touchscreen/novatek-nvt-ts.c b/drivers/input/touchscreen/novatek-nvt-ts.c
index 44b58e0dc1ad..b1c379d87de0 100644
--- a/drivers/input/touchscreen/novatek-nvt-ts.c
+++ b/drivers/input/touchscreen/novatek-nvt-ts.c
@@ -323,9 +323,15 @@ static const struct nvt_ts_i2c_chip_data nvt_nt36672a_ts_data = {
 	.chip_id = 0x08,
 };
 
+static const struct nvt_ts_i2c_chip_data nvt_nt36672a_e7t_ts_data = {
+	.wake_type = 0x02,
+	.chip_id = 0x08,
+};
+
 static const struct of_device_id nvt_ts_of_match[] = {
 	{ .compatible = "novatek,nt11205-ts", .data = &nvt_nt11205_ts_data },
 	{ .compatible = "novatek,nt36672a-ts", .data = &nvt_nt36672a_ts_data },
+	{ .compatible = "novatek,nt36672a-e7t-ts", .data = &nvt_nt36672a_e7t_ts_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, nvt_ts_of_match);
@@ -333,6 +339,7 @@ MODULE_DEVICE_TABLE(of, nvt_ts_of_match);
 static const struct i2c_device_id nvt_ts_i2c_id[] = {
 	{ "nt11205-ts", (unsigned long) &nvt_nt11205_ts_data },
 	{ "nt36672a-ts", (unsigned long) &nvt_nt36672a_ts_data },
+	{ "nt36672a-e7t-ts", (unsigned long) &nvt_nt36672a_e7t_ts_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, nvt_ts_i2c_id);
-- 
2.52.0

