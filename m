Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC9C4DD6F6
	for <linux-input@vger.kernel.org>; Thu,  9 Jul 2026 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621608; cv=none; b=eSHirdYPLBnnAuzcufcbzlSlQwljvVsEjMwE9/k9hRItAkklGmaqQ8C4yXllAgIgEMbasfyNlVtwCaVDRn1tJNgETgHUndW2SvLV9lFD6w/yujJe+hI0CYyHInIvO7LGO0zOc0eBrQTdQptNJBakll4rzoufliBybVQzm+r5EJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621608; c=relaxed/simple;
	bh=+RRk05P8eEMUoAlzBhTqIruC6/GFlnyrqTcoczbOpAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcqYDIUVwD5t7LNX/O7skJquw1IyDqqy7VL/AFMzHbN4Suzci7BZhsiEDc6Xn7bIvN2t0gMgE7e7srzcyGLGT+uIH7EMVwGifxLxHdDi3ZL5+LZ187ZsJPPD+APKNz9Tajr05QgkI4OkcOBd/jMHYsPRL30cy3z1iYAzu9jU0Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk; spf=none smtp.mailfrom=mide.dk; dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b=LLb9Wyrv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mide.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mide.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mide-dk.20251104.gappssmtp.com header.i=@mide-dk.20251104.gappssmtp.com header.b="LLb9Wyrv"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698b899b4c8so143498a12.0
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2026 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mide-dk.20251104.gappssmtp.com; s=20251104; t=1783621606; x=1784226406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hQPY+ruvZrK4yneef6ZD/gimTKExq2v3MyDuX/ycW4I=;
        b=LLb9Wyrvj+W96sL4bmAhD2hWg1Y50czeO3bnR48E0LoQD4CRN8i8JSR0BKe/URsj/l
         uI/Gi1jGh9QLlIEv13x/mZdprHm5/ANEdCvar43fKkFZxn9fb1LB3me7TerqLr8fx8CM
         88zjMrjO5XMdVU5ecrXoDuPAjBL9zuvoaT2g/26rp0AkI7z/aHRgY00aZ63OXqGGQy4U
         vxslYGYtTzRvIdPfkDhhhzkLxTdHkhpgP8TR2NMchPkaAP8XvuXIktJK/3BeEiaaADSt
         JffkpkbIFPDuXDwuSIM3tbBQwS/PtfLa1sCCr/p5CYGr4DVzEpKvM9vxKRIFr4AsVtau
         SJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621606; x=1784226406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hQPY+ruvZrK4yneef6ZD/gimTKExq2v3MyDuX/ycW4I=;
        b=ZaDOP/ARrPrjeNqXUz9Jazzhx1m+Qa1hXoDoeHkW0hiiqiBGEIN2QjFY/OlVbsdgLp
         9PfZP/zMksEZiT2QoBOnOi7Sk98N8OOLx5UKvBLBW9cVISJZxnb0Z6xfFCC73KF29ce8
         1VNBzK4udAGC9bZrihrUkbkQ9NmN1l62yU/WDdJarkWoi42Kxhx3I9rzsAIUgkMWSBml
         fPsoJ1RHBKt42b2elV/fXbcCfLPYeJpdeW15JvYcKC0QhlQj2v1t0kZ8J2KpcN4M3vBX
         Wwc2qG/0L4mjImzQYYFvtEx82bgWdNzEjObJWIb1zwCU49CUjUi9cwcvIN7f8UO1xTrp
         jkQA==
X-Gm-Message-State: AOJu0Yw/IKDTbkWdG6m0aU1zSF4VF3tCVZ3NJYhJi3EDwWgDziAooqh5
	+j5UbKffPSkM5++1CFNsac7IWdT0e9P+IuH1kxlVW3teFzOgu/65oCV5Tv+CPbsqXw==
X-Gm-Gg: AfdE7cn2/oITl4uxC7m8SFIyJTtW74SigeGde0FDi1S/tmdm0qfDHbfj1cjAwCAFJLc
	OGjn949o5eHVPnqlweN7sxpjJpHqLWFAWmRjUaeoN2iKa+/V4tffNdCLhYWgooKjflBZk867jB+
	oPwHj5pBjRMqTYechYVYX9EGyKrHT3wqJUWLqAXBt92sI3RitP+NsjZGzdvIcrv0XFEqQ8omu2z
	ywz/Udcgjv8+b8HAEkFIQA2TITndq4GQQCBmfvkAGnyzYCjSdyFPgl4UdZXl+L2ktS65TGbJdEZ
	7UIV9IJHWHI7zfVYFloQqrwfAp7/Dy8w7lDoWp/HsFzvpchYMsBDNlaEpRoO70MylawBv6Zu0i+
	ZQbuwrdZksgqG5NShYzZ3cP7FgAlcLQ+fg9gYSjbAVQ7/VfBMQ8CyPVJiljypqJZe0sZyN+kQtK
	tckfV+4SS9kRLMaHzipW+YqYUG0rBZ7LM/PR/SXjNrR7ydKwfXEDVvXwpMXLF9ZhXFUCAbGi0UR
	8ApdSxhnnC+d679VpRHTYqxaFAT/9+3TlCx/KFTU1KIl4nt7ri+
X-Received: by 2002:a05:6402:51d1:b0:698:1504:bb1c with SMTP id 4fb4d7f45d1cf-69ab44a2841mr3157631a12.29.1783621605676;
        Thu, 09 Jul 2026 11:26:45 -0700 (PDT)
Received: from localhost.localdomain (2a06.4004.215b.0000.2aa0.6bff.feb3.5b8c.static6.kviknet.net. [2a06:4004:215b:0:2aa0:6bff:feb3:5b8c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69a19dbee72sm9934268a12.30.2026.07.09.11.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:26:44 -0700 (PDT)
From: Kristian Mide <kristian@mide.dk>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kristian Mide <kristian@mide.dk>
Subject: [PATCH v2 3/3] Input: ilitek_ts: ratelimit unexpected report logging
Date: Thu,  9 Jul 2026 20:26:02 +0200
Message-ID: <20260709182602.7308-4-kristian@mide.dk>
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

Unexpected report IDs can repeat quickly when the controller
emits unknown packets.

Use dev_err_ratelimited() and include the first 16 bytes of the
raw packet to keep dmesg usable while preserving enough context
for debugging.
---
 drivers/input/touchscreen/ilitek_ts_i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ilitek_ts_i2c.c b/drivers/input/touchscreen/ilitek_ts_i2c.c
index 6146baa2b..e68bc0522 100644
--- a/drivers/input/touchscreen/ilitek_ts_i2c.c
+++ b/drivers/input/touchscreen/ilitek_ts_i2c.c
@@ -238,7 +238,9 @@ static int ilitek_process_and_report_v6(struct ilitek_ts_data *ts)
 		return ilitek_process_pen_report(ts, buf);
 
 	if (buf[0] != ILITEK_TP_I2C_REPORT_ID) {
-		dev_err(dev, "get touch info failed. Wrong id: 0x%02X\n", buf[0]);
+		dev_err_ratelimited(dev,
+				    "get touch info failed. Wrong id: 0x%02X raw[0:16]=%*ph\n",
+				    buf[0], 16, buf);
 		return -EINVAL;
 	}
 
-- 
2.54.0

