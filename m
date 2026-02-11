Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD83590CF
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770854353; cv=none; b=KS23vBDvQfukoWmqdChAJmz4QVNIX3hb1pP13LrqH7NYLUkVgYj3vCs+XxN+cV1lqlRHCzc4q5wQx40eWAYmaw4SmcZ5GLtD4fpS7jazESzb+PgGcUmrg1ahpz7KqiQU3vTjNpWhwt92DOrsd59KQZBLkq4KfWYeEn9NKR1S3f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770854353; c=relaxed/simple;
	bh=bvJI20HyeMvKHVjdYdFK+wgYX2p2czI+rM4pevr1pUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8l78rAkGc+abJxS7OVLIm0MPAr3XHNHVf7hvJQRk/staVB9doLF/4fqn9YHd9erwl0WFui0ZOlmWoYp+JbJiGIwKuE+Y+DVfccD7TIi62XmJRUhYO59l8wKNEx0vIvQGHqAzl0QSI6isLOHJr9XlPBF/fH45b+XyxFJXUag4Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKQ4nJDp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKQ4nJDp"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b884a84e655so385707866b.0
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 15:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770854350; x=1771459150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVdkTm/zOeP3cGpXIWZBQZFEMblYWk3KTVOwDmAO374=;
        b=jKQ4nJDp2LgtlHgekVIuuwkUjRweD5hnWi/FSiZFS1qOdcQ176fXwCOFBWGOsDWsgq
         S5bcQw5WTv+PzBUHXUeqV1uZ8xdR6zz3FmRca4MLDB0gV8HvLLD9lzjgCwlb7tYXKj4L
         UsGQtHUV7okuQEf8sxHXJE79ZeTThlt+IJ3VZWKkw+/yRSaijJz9tEQVRi4DU2GEcnwZ
         vOkxNy5QE9RmU/yanDkfOfwdONlLFAm1ctVteUIvN5dbZ5Kj0aUdSl3V6RjNoex5spTV
         TnIpSF/cZubQw0vhaBZOZycAPsTjqXgFc+YTI3ANWG9WHIzC7791WBk0bxagDXnnYBl/
         ++QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770854350; x=1771459150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVdkTm/zOeP3cGpXIWZBQZFEMblYWk3KTVOwDmAO374=;
        b=Kld6bwXxTDIEPdW62lXWUTUSIb/JSe02bcAkSL/XJAQEvVSTCVCIEwLPMHewcsxnLG
         HJKyn5kg/PixdwgI2uSpuD74eKyOyptwEpX75fUvFjrpPQML/fDKTgJiH8HqXhwVWfOS
         CtuiJd2+cDtf3QFn9beMz2Zp9wn5U8XjohJwMqSoC/Z2R09QSwlp+IEfzLfbPzZlwRs/
         ietuJh26A0kKoMo2lnalI+7WxiZw+Se8bKYTHd8xUgiR1Nd9tKrrBIXqelSMGw8N1nSY
         VgbkwtuNmYt9CexTeuZ1tXYekkCljifIZmsh/RZG844E+1jdprGQ15FilmfTa3tF4qpD
         AcrA==
X-Forwarded-Encrypted: i=1; AJvYcCVFs95hMwt/LcUhh0RLkFGgpa3dbmn4bEnVitkNHvGF0FGxksT5cEBhwnlAjtqNA+DInZNlz9fsu/OcNA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZrh45H4epXcgMw4ugrnt3ApXy3k9OUOuDDC0kFURCpNnYlqe9
	U0gxbwRXS1WBQgjvL0xm/Fep/A51FdhlIT/lOHJvmpEdpz8mXT5mEwRZWaZ0Ow==
X-Gm-Gg: AZuq6aKSuTDrEgPwVcRoWpfc6SDB0posI+GpMaG355u3BvDI+hRbaebXDz6xSrKvX8g
	b8nWnu5f2jPBq4RPfspnigHZv6ejF41QTbHnmCNltvw6hzsGU31v60DoSLARsA2Ho2nJfL/wcwv
	Ruf8bX1X9UMXA4U1I/GoBFk0bQR2ZsWbDJRT2ancMKMNVV2/HyrtdebljD6WDNQZEkrhnPafQHz
	4L2/8P8kRaI1DRbqW7yOketcWR4egnznhdU7ZWAdY3nfeS4YE4123SJoKWXKUGjPmiVqrALuqVt
	a8888JBx0DPXGAX7MNaaTfG2+5kJnuVXZsWSG5e2pZqmEIhBpVjMqRRYV3pJ5QCUK8JH98TbbOf
	G9hRrPta7BzOBMDKuyRfZXA2t3DaZ+MFa3kNWGd1wCZHncCjlyA7WFGUK5Ebezk0gZSZDNry3RI
	VuIZ9ANFOU4xPF2g==
X-Received: by 2002:a17:906:c145:b0:b72:58b6:b263 with SMTP id a640c23a62f3a-b8f92c8961cmr16354866b.60.1770854350087;
        Wed, 11 Feb 2026 15:59:10 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8f9561f722sm1593466b.10.2026.02.11.15.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 15:59:09 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH 4/5] input: drv260x: Stop waiting for GO bit clearing after timeout
Date: Thu, 12 Feb 2026 01:46:54 +0200
Message-ID: <20260211235902.4156624-5-jekhor@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211235902.4156624-1-jekhor@gmail.com>
References: <20260211235902.4156624-1-jekhor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If something goes wrong during effect playing or calibration, the GO bit
may not be cleared after some time, and the driver will get stuck.
To prevent this, add a timeout to the waiting loop.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/input/misc/drv260x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index f08a3d6c3ed8..f7bfac6d3973 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -173,6 +173,12 @@
 #define DRV260X_AUTOCAL_TIME_500MS		(2 << 4)
 #define DRV260X_AUTOCAL_TIME_1000MS		(3 << 4)
 
+/*
+ * Timeout for waiting for the GO status bit, in seconds. Should be reasonably
+ * large to allow long-duration effects and a calibration cycle
+ */
+#define DRV260X_GO_TIMEOUT_S 5
+
 /**
  * struct drv260x_data -
  * @input_dev: Pointer to the input device
@@ -339,6 +345,7 @@ static int drv260x_init(struct drv260x_data *haptics)
 {
 	int error;
 	unsigned int cal_buf;
+	unsigned long timeout;
 	u8 id;
 
 	error = regmap_read(haptics->regmap, DRV260X_STATUS, &cal_buf);
@@ -442,6 +449,7 @@ static int drv260x_init(struct drv260x_data *haptics)
 		return error;
 	}
 
+	timeout = jiffies + DRV260X_GO_TIMEOUT_S * HZ;
 	do {
 		usleep_range(15000, 15500);
 		error = regmap_read(haptics->regmap, DRV260X_GO, &cal_buf);
@@ -451,6 +459,10 @@ static int drv260x_init(struct drv260x_data *haptics)
 				error);
 			return error;
 		}
+		if (jiffies - timeout <= 0) {
+			dev_err(&haptics->client->dev, "GO timeout\n");
+			break;
+		}
 	} while (cal_buf == DRV260X_GO_BIT);
 
 	return 0;
-- 
2.51.0

