Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB372F1FFE
	for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 14:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771164884; cv=none; b=sMKi+urcjTvmGXda1x50f1n65bfdPtWqpudNs/KFNYeHXFtxUXj2ABSgJJVjTo8PbcUbt8ida3koJIa45obmgIykN+OeRsTKipkA6QGk6xnGjCx6DBLA4rkuTRMW3QD0qDDxY+WUfvRArq0YopT9vue/1rh8lcsMUiccLmMD9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771164884; c=relaxed/simple;
	bh=jcchjRNCvGfItTeDkLXOz0hsgTUAvNyiOuc4FYzs1hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM6kJJRwIdGdI7TpXHV5969PjtLWq0NJGrmyIRwWJoMDM6YjQKN5d9dzN5RUO5Bfuj2B6Z46bYiK3A2HSClDVTazydkEX02yO3GikvnhcfEluMgKgzfSep3irt6UXAGYriqfl9o7k5SYNcGR2Ii8GuIHSMnVIwxR3m4EMvOiQ+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MvUWp5gh; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvUWp5gh"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-65bfe9c585cso384847a12.0
        for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 06:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771164881; x=1771769681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DooOO52QZ+8TB3pgOr/A4ea8lODlOP66uM7pu3OXrv4=;
        b=MvUWp5ghKbViYw73qLUbDZo0dnpS9AiGx3Hp4ILLu4qpwCAeVH2VGoGN41/Hh1oTx9
         Ii0ZXVYhOmOXFUtXTA9B1O3BeeUcgw6YNA8xLO/O7r3Q/Xezv0iFrCs7gQteW8JdrtWT
         knjZvINHl1KH6QBQ6WciAosLYWlR66yKEUVXJp4vzc0o2d/Vg4+Tu4aVMEEbS4j+OV/K
         yifuCuFaVPd4wxVZT1afYrJjjb1EuL6M6vVTGj2u5VZnzXWZ7WlTnzN5b3DXwtS5Ogqe
         thb4wlijr9jkLVvwN+WNgjGoGbhUq5hBuyY5+rPIJKt4ceIvmszVN44lPwrBZKJQeMGo
         Bflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771164881; x=1771769681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DooOO52QZ+8TB3pgOr/A4ea8lODlOP66uM7pu3OXrv4=;
        b=ouIqWCTCCfb2TcanJkC2eTNjj3h6Ue6cbTprTbBu1sqNCKVsD/Q3gzQojhmRkosbKy
         Ov/K8cAmWKSQZfildmWou2SWSRZCA0ymObvJu/AMYT+Ng4k9B/kS2LmgmVFDPrMh4Wld
         cJWK61k5K68N9EefNYuwFKaC58RhWAzcefSndxgLZipVaYcmG8or+yYXHYZfxVeDkmlg
         N50GEeUofGMOFfHflNJaLm4OXFlaB0SvjTmYbnzITuO1SDeb9YzBnX7T9RwtgyrLKCdq
         sYRX3Kr6tRN6h+6SPnrfaOTtJtSeKQ27NM5D/d1n7c1sPCi+W6K8IVyWIX1DOnvlpCFt
         5dyg==
X-Forwarded-Encrypted: i=1; AJvYcCXRf9v7kzQjrDUiCfb1lcoQjUCyey+TN8sc+gWGb0i7wn1w6mAnL5NNQHzUENj/tOajXXeBFAWYCVkLmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYabcxOHnfE1MRdw4V9EF8CGCWVR+aNrMz1UmAe/7ceMhToEU
	/x6dUf/mgVfTECf+2DQ3HvaNEZhJc4jNTvDfG4rMStck0l+gsqHXc2rO
X-Gm-Gg: AZuq6aKGC+gUZNt3ZcwZ5PJOKrw1jr+/CRu6qwnYC9mHDFkuA+XCK/DAFl34wfI3848
	0mupoqHpAVA5p/Z9VZkgZyj59Mp+yGJ4EmOjfqITd4IifI5fz5p5riKfR7WFjD4b7h84CGl92s7
	7z2ZDbjoIL9W5UmicZzREfcDO6vICwpd316RUKnah3qcOGU9VPD6J5r1ecxKEX8fnoNHcfTzC1w
	9QZpTx+u5qL2+HhVEyWQqaUZ338C4u5Vkoldv7vo04cAcPXEP1TaDtmJQMONfmjLFR1DZzX30Eg
	62AKTj6WcFeuC75+qy8+7rWjTH7PEJTbvcEVoYaBz3xGnRqGjOY+aBSk4zh1nROE6ziI7CygTOB
	H6oUpmkg5WyqfEgMERlyJd6vkNq9xpoANZmVHw8SpF3w8W+ppRVM+VppLA7oV0YUH/Z+DralZgw
	r94kNrLJ1w8fyfPF1dbD0w1+0y
X-Received: by 2002:a05:6402:27d3:b0:659:4a1f:c6a8 with SMTP id 4fb4d7f45d1cf-65bc785cd09mr2229711a12.12.1771164881195;
        Sun, 15 Feb 2026 06:14:41 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29df12sm1518889a12.14.2026.02.15.06.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 06:14:40 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 5/5] input: drv260x: Handle calibration timeout
Date: Sun, 15 Feb 2026 16:14:35 +0200
Message-ID: <20260215141435.727872-6-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215141435.727872-1-jekhor@gmail.com>
References: <20260215141435.727872-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If something goes wrong during calibration (for instance, if the 'enable'
GPIO was not properly defined), the GO bit may not be cleared after some
time, causing the driver to get stuck.

To prevent this, add a timeout check to the waiting loop and return an
error if it times out.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/input/misc/drv260x.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 71fbdabc6589..7ab891210fad 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -166,6 +166,12 @@
 #define DRV260X_AUTOCAL_TIME_500MS		(2 << 4)
 #define DRV260X_AUTOCAL_TIME_1000MS		(3 << 4)
 
+/*
+ * Timeout for waiting for the GO status bit, in seconds. Should be reasonably
+ * large to wait for a auto-calibration cycle completion.
+ */
+#define DRV260X_GO_TIMEOUT_S 5
+
 /**
  * struct drv260x_data -
  * @input_dev: Pointer to the input device
@@ -309,6 +315,7 @@ static int drv260x_init(struct drv260x_data *haptics)
 {
 	int error;
 	unsigned int cal_buf;
+	unsigned long timeout;
 
 	error = regmap_write(haptics->regmap,
 			     DRV260X_RATED_VOLT, haptics->rated_voltage);
@@ -398,6 +405,7 @@ static int drv260x_init(struct drv260x_data *haptics)
 		return error;
 	}
 
+	timeout = jiffies + DRV260X_GO_TIMEOUT_S * HZ;
 	do {
 		usleep_range(15000, 15500);
 		error = regmap_read(haptics->regmap, DRV260X_GO, &cal_buf);
@@ -407,6 +415,11 @@ static int drv260x_init(struct drv260x_data *haptics)
 				error);
 			return error;
 		}
+		if (time_after(jiffies, timeout)) {
+			dev_err(&haptics->client->dev,
+				"Calibration timeout. The device cannot be used.\n");
+			return -ETIMEDOUT;
+		}
 	} while (cal_buf == DRV260X_GO_BIT);
 
 	return 0;
-- 
2.51.0

