Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792896537;
	b=1ob4Hc4yH1ZOeHxFlwGGwTn06/9wWWRu8uJ+tJ+ITO/AwDv4TqCeq8aBcwipot+Qm+tE
	 SXtTE3JI8DgXHeQf9Ayl+KuOGsvSV/O/U4okqNFj8fZzCa41WVg0O00Tc5eB9mcdbXP0k
	 qjIOFDCVCz8ahaEDSKW76uoEfQLgVFTM+yHHXljDURlGn0byu6qDBnif+SteoHzfF7xEU
	 4VWZ0Rm+dWqCJNIBz74rdRlfw1D6fxz0ozM+ECRZVgpaKy0HUIFMV5JEpGkbE4NQ2SboE
	 sqFlczg+MmyAl9UOjpPqsY+OFC9+1IH4bjWjCrq1k7e4zcPhqrCYw0qeUG13rB1KJeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792896537;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
	b=O7a0xcJ63T3K/geh66p8h1UB4FAu1eV18XVXJTc5pfnBuWWT1/0vtd5RpsyCysG/4zOT
	 evSiObokSBPjL5pmrkAQvv1a95JdaPrVqELbuRpgpgz0CM+kXz/hk/d5kMY5xde/oR4Ls
	 nECOp36ODzkciDRP6U/wHwMVSZXXpUihMouE4FOALFgChsS2uij7TSkd+PAPY8rGf/S3n
	 WKiJHhsD5puKPV5t6SKmV5HQWtoh/06167+V0PMt9oN7gM2o4HIN4rq9V1RcEDi9pJ6o7
	 aZlbgz1QP0yrn2A9+EtWWrBy1pHi0Ll2AkeR8FTnCg5uhBvLMnJ4LmVQlqfqk+TzuPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AogBztQa;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED5960A2628
	for <linux-input@vger.kernel.org>; Sun, 25 Oct 2026 02:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ED5960A2628
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AogBztQa
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3550c917fd3so3023636eec.0
        for <linux-input@vger.kernel.org>; Sat, 24 Oct 2026 19:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792896532; x=1793501332; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
        b=AogBztQaefRHxqIf7r7yyiPJ32TbkKSI3EZbJyc0kM0DrFhuCiEAqIV7SisQG5g01m
         lP8walfX9nQXhaXidqzuNwI6Liv8Yr7pKoxYww/l1I3zNqNPsE0AbTEz1Y9/wA1xXQ+u
         pQ6Bjf0E790OrznGUopeKOQszZ9uwLfYdMH3COcZyZ4oSsC6QlaWXUQep2FG9atErDPJ
         rLSXwIHURFU/vZ1FggsB7lHTTHi5Nztr+uIT7tAjeUcGHkirI6ugimoSrRGeOsGzaU7p
         Ogm+9BojY6irQAwGPPBCC/Udjma2QscUnzmO2cmOitOQmo9ottCgL420ReMargrfLKyq
         LgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792896532; x=1793501332;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2WNFFspM+rHRPvmlX/IdB/mvBFJYspViUI+mUu/7+EQ=;
        b=LynlHfuq6Fe8ATyr8eYTzshG/LQHHLNqVvmv7M7daRtobiH4z5JAX97qYf8eWTh3yh
         5GEwv6KxlvzgVD/76/aOHKvnjZM8VGuV86lJuaPpTlWwZDL5i1kCwS4ZHqd/ikUNfN5b
         hAXu/zpyeyuudC+Fz8FCySrFPDglCcHZX3he2KnIlWn/QaRenRlERbJkZFK5fYMb77MA
         g+aDAakvNldYmUdMAnq08mwRWJZHBcnsBRXFJy64mSHy5D1LaaFx2Bv5fnabbFa+pZXq
         WZRZ+9ZMlzFxl7EcIpiIoIC8iRVTKSC5MwC23gXNmO3JUptU8yxVpMjssDaFpevf9U2m
         inbA==
X-Forwarded-Encrypted: i=1; AKwUvBxv6ic2H8i9weQIArHm9KkfToASi4HteXGKv8hEBSEcIM5fgf7kUA3/48i7fozwh3adR2yUcwTiCZglcA==@vger.kernel.org
X-Gm-Message-State: AFq9FYJYiEg1UutQNSoRWxFkhnZy9fP0g40TdSISg+x1kZgGDKn1nnWn
	FcQ/+0iBeDcDXrcZlr155TI2Wq+UwCbY9/0QjDfKLo4cwa0qY+2lYKjg2FN3fQ==
X-Gm-Gg: AYBFou2qnJ77TXGETFpWXosElCqVhEJzIM1UDo1AxVQMXd/ejZPhjUHv0P0gm3NG436
	XZgfv9dtm5gXxsIxo4rlC+CpYiQFSvkfVV4w+/ljvA3u9xKN3r4Hnz7aNV+u9Zg/tmgj/zwYh2k
	RDta3ze6V8T7D56V4TPTmqjP/Mhc1GS1hJqraqyVwerR1yFx7t5JmPdlcB4kQoMP8MGBQMIS7vk
	oNj+eIfmf+sa6BJ8rPBauQpVaFtmJe8/xYu/4D3iIKHp4z1KJNXgHPgyPfbsJLFwNDfuZxPMjyP
	dKHDibsZxa/jfPOT31sMskQ2QeEWT8sWKYy9GCaUbtEGqTIBbBLEZqXX7RaK5uhO8Jc0qPQy6ZP
	wfljzdWgVHKWu3J1dsuZHArEuXh3C+PEjcufxIOoN9dRilcKXxyBDrjYD4v7cs7//zXY+bWomGO
	P4LWLgT1oTkyk2fnUhjFmcQmR52auNMomz6F1uB8YLhqFpoKxfGCn/TX89HK/UQCwOZ0HIieQf1
	6FSjVjCfC9BPONOPK/Z3MM4+nEkET6P4gXJ252s2gpIfzLfnicDWSrTwOPYN238xT84Wy4NPyt8
	PSADUaLUbAC5EyDBbZRtbDhECJwYLhOTtWTYTTpEjoX/GLeB+AlG5a11a5VegBHn
X-Received: by 2002:a05:7022:ea5b:b0:19e:1ad9:1c2 with SMTP id a92af1059eb24-19e1ad9061emr760295c88.38.1792896531619;
        Sat, 24 Oct 2026 19:48:51 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:8fe4:693:7158:24de])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm10521272c88.21.2026.10.24.19.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 19:48:51 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Sat, 24 Oct 2026 19:48:43 -0700
Subject: [PATCH 3/8] Input: cyapa - use 4-argument
 i2c_smbus_read_block_data()
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-i2c-smbus-read-block-data-v1-3-19bb97467982@gmail.com>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
To: Mika Westerberg <westeri@kernel.org>, 
 Andi Shyti <andi.shyti@kernel.org>, Corey Minyard <corey@minyard.net>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Sebastian Reichel <sre@kernel.org>
Cc: linux-i2c@vger.kernel.org, linux-acpi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 openipmi-developer@lists.sourceforge.net, 
 platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Pass the transfer length to i2c_smbus_read_block_data() in
cyapa_smbus_read_block(), accounting for the final chunk size.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/mouse/cyapa_gen3.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen3.c b/drivers/input/mouse/cyapa_gen3.c
index fc3fb954523b..0cdebf2c34e7 100644
--- a/drivers/input/mouse/cyapa_gen3.c
+++ b/drivers/input/mouse/cyapa_gen3.c
@@ -256,7 +256,7 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 	if (SMBUS_GROUP_BLOCK_CMD_MASK & cmd) {
 		/* read specific block registers command. */
 		smbus_cmd = SMBUS_ENCODE_RW(cmd, SMBUS_READ);
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, values);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd, len, values);
 		goto out;
 	}
 
@@ -265,7 +265,11 @@ ssize_t cyapa_smbus_read_block(struct cyapa *cyapa, u8 cmd, size_t len,
 		smbus_cmd = SMBUS_ENCODE_IDX(cmd, index);
 		smbus_cmd = SMBUS_ENCODE_RW(smbus_cmd, SMBUS_READ);
 		buf = values + I2C_SMBUS_BLOCK_MAX * index;
-		ret = i2c_smbus_read_block_data(client, smbus_cmd, buf);
+		ret = i2c_smbus_read_block_data(client, smbus_cmd,
+						min_t(size_t,
+						      len - I2C_SMBUS_BLOCK_MAX * index,
+						      I2C_SMBUS_BLOCK_MAX),
+						buf);
 		if (ret < 0)
 			goto out;
 	}

-- 
2.56.0.257.gf7497c7d27-goog

