Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1A529B76F
	for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 14:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771164881; cv=none; b=KB4wKwRnBW1zUIORGt0v626EyHGK4eBybv5Lk8jvS9N7AHwnGqK2Zx3k2QNy+lDd4XcAnbwdXqZ6p21NhkcTGkovVQ+RAzSkLqI/w9cYFswTbAfglIzYZgev7YzN/NcQ6elwv8GyqUXpUWZU4yOLbhbgdt9R/jVELPLTeqGczq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771164881; c=relaxed/simple;
	bh=3XeYvg0yD9eAI9rnarFcQbWdNAPXqphE0tHqiyPUNIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YMYkB7WWQMsVVEq3PoxMH9cSdFsCDEC37x51JbpN2KXfI3ae1GPb6TzLUYt1DgZ2vt2xTjtlfcCLJRiXUjBxhfn5Duk/AhHd8MWv9bCnEtfsg9lFeLflewolBdVGA6O/NLMTsKaH/YG0ieUKmgVN/D0WG4p1OEPonWQPFOVFpY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AuFML5uY; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuFML5uY"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-65815ec51d3so3795330a12.2
        for <linux-input@vger.kernel.org>; Sun, 15 Feb 2026 06:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771164878; x=1771769678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjPrzEGlEG8pNjTnVxylr4XLvPoRq/OKYW6EWcfUcmU=;
        b=AuFML5uYJvuUT5Gmc/lOjcnByQsPtlCpCVHGQJBoICZIKh5uEEG/hNFkbYxI5ls7RG
         x9HDONufB2kyQ/NFEHkItNzxaij+35KHXgtN+ZrNzVSc+aySgJ//6+8RSYMK6RJIqVFU
         lji+nf9fSMOFMIq+XItq3Hhwal40n3Ww3ftvNnyszGKMqH5dy9sR6FM66Kb96M7RyiuW
         8eYkg8tFZggVAOtJBIrCucUh/NscdV6IIUofKeb6LsEZINhF76OZKxnbKHmOuelekRuP
         A4ISiDa06Be1kwtSQzMUQ76e+wP5MpdDUa7HaRKJqyf32t26rwMMZpiiuW7os3TWbaRi
         5pJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771164878; x=1771769678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cjPrzEGlEG8pNjTnVxylr4XLvPoRq/OKYW6EWcfUcmU=;
        b=AS3mT8S8qGvXBP4ReUv6y81J1w28+aPd1YqGq2CmxdlcCnOlJ+pUbInR2az7bqng/0
         BYTB8vMfWIDrJZSc/oN8HHpyCb0YmEqmZLbL5BRAbZ55ea1Zxy+6UwfshnMzHmqO+P8W
         iXxLtS0FSMGDz9ZdSwdcKUo+WA1TM0vERe9y0yokqA/eZS0fP04IyPWYksuQYubpNMxB
         1ithXxmrVvZDn8hEdOnQnePfcIpG/0pscLK3knu+ZyqzBZCccr0KijKK5fzQY4azAqgz
         ny8hYxJfK+BOmk65lqqHkqnaEHRhaYpJuNNXqbol0uFrbR2R1LYDZyQ/Vn4ma5M9g15N
         NLuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaOQt6PpGt9tW19hdZ1y+7l+bcLR8uHTeN0T2kdBZdY1dr2lpcHKoAr5AOcta4Ui3xyTkWmnHfG04bmw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9oUM2pODH6vhwk9U4mDz7bQOl8NZ1CSdGEWXSrY3NxKK0zJeP
	mFLRN54/9Pt801SnddWuuTT73CrkQRj93Ue6mdCMZ7aIF6eeE2QLpMO1b6N4xg==
X-Gm-Gg: AZuq6aI4rXf0sQHMeLuKEUwXZ392tUT8t1xgqfMWGXss7HlRqdmHkq42AkWVZ3Mwt90
	NOCK4N+kKQ6pp18dgXUG8lkAvwijzYdq4L22+AL7GviDvYGDHCgFg2V1miNPyDaRizaYyy3ov7z
	xjTUtbvKvZFB2KbeBwpGj+juF11q0WhZ7kgzXxnOhVmZy5EdKn4TDf5fa0PwvTh8xvdk8Qh1RrU
	p/LKhHxdux++PprQccnTTyFPMrtnvt8Owgp2B2GnnLBPjBU2rjHs64eFi1AZaRjGIYnu0o4X3m6
	r6xtwoYYU8OPO3+Lp39M6Wruy/6k2I0CIVWUL1ul59nLAPQ3PDQd/L5nThDe73QobuIOJJMBWYr
	QhINFVWsk6yNPbJB1NtNkL2DSzx/9ZgVbeR0MfzTH8/8WQWXtXYyMCBFC5YrWhdUrpWPJln7LYC
	gn/BgZJKwJdjJOtQ==
X-Received: by 2002:a17:906:478c:b0:b8d:f6f1:e27a with SMTP id a640c23a62f3a-b8fc3d32247mr249194266b.65.1771164878132;
        Sun, 15 Feb 2026 06:14:38 -0800 (PST)
Received: from jekhomev ([46.251.53.180])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65bad29df12sm1518889a12.14.2026.02.15.06.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Feb 2026 06:14:37 -0800 (PST)
From: Yauhen Kharuzhy <jekhor@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>
Subject: [PATCH v2 1/5] input: drv260x: Add I2C IDs for all device variants
Date: Sun, 15 Feb 2026 16:14:31 +0200
Message-ID: <20260215141435.727872-2-jekhor@gmail.com>
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

Add drv2604(L) and drv2605 to the list of supported I2C device IDs
for clarity.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/input/misc/drv260x.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index 96cd6a078c8a..18360bdfe877 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -598,6 +598,9 @@ static int drv260x_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(drv260x_pm_ops, drv260x_suspend, drv260x_resume);
 
 static const struct i2c_device_id drv260x_id[] = {
+	{ "drv2604" },
+	{ "drv2604l" },
+	{ "drv2605" },
 	{ "drv2605l" },
 	{ }
 };
-- 
2.51.0

