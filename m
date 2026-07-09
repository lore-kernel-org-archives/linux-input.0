Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7974DD6D1
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 18:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621605; cv=none; b=J2VUwuzZRNY5oqqSkDzds/pXcMdIUAUwAi27KhfLfX/cOC49WuX+SRsXX8jvfywkR9L8o/99W3lIxru+LSe8QYpSiZENqaYl1cvBZzL+OKjSiBiOJqs1qpzBYFKS3DZBwh3djSwLJ08Gbh9s9KGqHEHg621T9uShb4dko4Yan3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621605; c=relaxed/simple;
	bh=A/EVFQ6wYhI64IGvHsFzOQA2AB04c1cvyU/n7v6hT1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yt02jGyRDr3TcOGBtOr8NZGpfuOboUmbSB7Pu3strh4cm7aYd3SMHY06y6W+diIiPYieferon2TLHFv2jVOIduuGHJIrDV2XbIYmFh5NFZ/AFAEGFrMBhagMwuXkuWiu29vlwr4JcKc2Ybb6lWc8o7WqnK24F+d1vrzsxy5LkIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=TRXgaKIy; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="TRXgaKIy"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-697cee2eb6dso129436a12.0
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2026 11:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1783621602; x=1784226402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PZNSzLgNXFsl2MkCEfxALl8xB83GtVUhNfVdGW8uxKI=;
        b=TRXgaKIysu8DIppZufQZnrWMWlhfK4Y9f2mG0Muh5uFvdUuKA9gN3VSpbeXxx8D/Vn
         Y/sQHebqtJbE2yVkKN43SoRjDscTFhOcPsN6x5VjC0r29KcIYnDLc/4x1bz/Jj+t5U9I
         u9vH1v9/1F4eSfyboazRJq1vAk+QnW8HNbGzFcb0W05BxMiLV4taprK6UsuWwgjuVI1L
         isMVcHE2IEel6zc+QbPTX/iudR/n2L9LZcjvXtrPKZ3n39/CV1EKYmgJoIyC3EXa0RRD
         Lhu+acBrMTxilPfkOHySwWsP1xF05xtvy+pN77W16AOcBhVunD2qxrZ7xdGZ2az5UoZd
         hpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621602; x=1784226402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PZNSzLgNXFsl2MkCEfxALl8xB83GtVUhNfVdGW8uxKI=;
        b=BLwWAgv6lZbtJ5eTAW7fpXd7d6pW2BlLbJ74TVmfFt8VOuvMmpN/2hwbQXzVOl3dj7
         1HR45mqgkbDacYr6SXLWUK4kfmxzQaPlsGLtCaDZGPo994AL/WJXTQ7TmkTHMS7m+E9C
         ZVULBshXqigEqdYyiEsg34SYrMfx6ilApHSebR0tBr5nWsZSOSmzNp6E/0C3+ir5tQqs
         CQMfDB7f1aFKdAJyhSAtcYPojdKTCM7JkToxjOTj56ypaBRfcpVOaEyOqqbDt2R/629Q
         KOSinlrqPbpllGa7b4/qiP4bBuomdNpymFuQ78FLBw4cGaiSz9e1HDlO/KB/mTukZtxd
         aMjA==
X-Gm-Message-State: AOJu0YxjddDC89tvjy3Ed00zAvQA8lK2cspXpgb9QAv+MJHW4IcHHL4W
	8zC1BtNU0RyGsRXOy4sV6k8EYRMOkJrpkXKHHVNRZFYliCugXwwG0LqhaPH+vtxqKA==
X-Gm-Gg: AfdE7ck5hEKtSeH6zXaPKgbYJZ4oF4GrDjbjTyuyq9u7/iYqAGYN6EoMhw9CK8r+Co8
	F7kiykQGkC7xJMeEXQo+efAsjAHQncXlcuH02yyOKujAKT+t6/2bM3qWbWAB2f8h/2H2O037hsO
	zthZSiy1wwlw22fGKA/gSa7OuRlKUKNXR0txxEOBlBasKwfbPZojlUK3T5dYFGggt9W7XNugMO4
	JCiujPO0l3DCY14u0yfjkvZFMHxx5eBIlcvH44SH3bSjbbuhby5es2oVuU6ODlPSEsyGPo/UJ2X
	sK7oGsB9ccbKEvGI0+9iwGq7qxUyqMsbqB/+cm0pK2GbpWiVZIpv5aqjs8WWw+qABgfhl8+NXKU
	mb9IL2Pjvz2euLTs9NBz72Lz8POb2/nXvwjQjj11GPLM6L8Jxoe/3uC4ykMOqHdlJ5pcV4gniTy
	pq/jize0OyBoBSnUBBRtIsNhWPWyHNft6dI3UnBN+SMO1tvC5iOM1ImwtOHEpM7u9Ma7w0ZgZfX
	DJDLjfTz9ky3RU9G1UmaCabB9xpP0W38m64mfLaav/1ZZXtWrC7
X-Received: by 2002:a05:6402:42c2:b0:698:4d33:b191 with SMTP id 4fb4d7f45d1cf-69ab4453e4cmr3557603a12.9.1783621602646;
        Thu, 09 Jul 2026 11:26:42 -0700 (PDT)
Received: from localhost.localdomain (2a06.4004.215b.0000.2aa0.6bff.feb3.5b8c.static6.kviknet.net. [2a06:4004:215b:0:2aa0:6bff:feb3:5b8c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19dbee72sm9934268a12.30.2026.07.09.11.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:26:41 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH v2 2/3] Input: ilitek_ts: handle short I2C transfers
Date: Thu,  9 Jul 2026 20:26:01 +0200
Message-ID: <20260709182602.7308-3-kristian@mide.dk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709182602.7308-1-kristian@mide.dk>
References: <20260626214248.5563-1-kristian@mide.dk>
 <20260709182602.7308-1-kristian@mide.dk>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check that i2c_transfer() returns the expected number of
messages in ilitek_i2c_write_and_read().

Short transfers were previously treated as success, allowing
callers to continue with partially filled buffers. In the report
path that can expose uninitialized stack data through debugging
output and can also confuse packet parsing.
---
 drivers/input/touchscreen/ilitek_ts_i2c.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 54e39721f..6146baa2b 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -131,11 +131,15 @@ static int ilitek_i2c_write_and_read(struct ilitek_ts_data *ts,
 		error = i2c_transfer(client->adapter, msgs, ARRAY_SIZE(msgs));
 		if (error < 0)
 			return error;
+		if (error != ARRAY_SIZE(msgs))
+			return -EIO;
 	} else {
 		if (write_len > 0) {
 			error = i2c_transfer(client->adapter, msgs, 1);
 			if (error < 0)
 				return error;
+			if (error != 1)
+				return -EIO;
 		}
 		if (delay > 0)
 			fsleep(delay * 1000);
@@ -144,6 +148,8 @@ static int ilitek_i2c_write_and_read(struct ilitek_ts_data *ts,
 			error = i2c_transfer(client->adapter, msgs + 1, 1);
 			if (error < 0)
 				return error;
+			if (error != 1)
+				return -EIO;
 		}
 	}
 
-- 
2.54.0

