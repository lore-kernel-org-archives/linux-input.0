Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794614548;
	b=rjrD5TdI1kGkWFdhZ+jDx931PkyQyfj3YRw0/pqJuDsLy5Hu2SUPO6ZeV1nHKYPh1w6K
	 q5zt9UXycrTf4UQmEo/L0bawCTP1Cii/IqRwqG6f+viPM0mPHCtLbpIn8zw8nAQVeeo2i
	 6AHoqvia5XBhksIpOB4snFyhPQJ5KAZLZ5nE53GjsDPZTGyyM5s7kS9eP9IIVdQTvHsju
	 g0q/ZNeUxjpaketUNHJ0ExxOwKEyWaDGCayAGS1wA8LHwawawnIhysuP97T0DswRs94a9
	 biL3lWnuvOKMGJ28AXEJlWnyVWgt4zHTcmg0F10pX0TbwYy/xFvWgetc8X2GfIxl+8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794614548;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1U8awJ9myB9NQ9BFpOtadS9kZucwnK4t/vce0ts4uRI=;
	b=D/1QpScrLaAkATsuZO5PMNIMTY3Mun8uwva/LWyIE1eZclRSY+WnsifUa6SkpcJCs+b0
	 VwVJF0QFvBwTweKGEXYtXekxpFxv8pU8REm+cXDPhXQ5FAWbT5np9fEop4H9wDFDMjxjN
	 SD0+h6NEvEAU23hXfQpnUcZvV5yGfNpYzAuK+E65k5Z+OSgnTT7RddVGV7hpP9EG49yu3
	 SXDtiMwnDpGlPrgNtz295vQQi/s80z4ovLYzrM+SIpU4prbZt+NLsOUl6jTpBrLcUCWbv
	 gG+o8riK89MxCouxB9kYyaClhIIh6iva85RJjy/1X/I0+5Up7Edfkg/xaDwpRAaPLFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxfwu3HJ;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1023606A33D
	for <linux-input@vger.kernel.org>; Sat, 14 Nov 2026 00:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1023606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kxfwu3HJ
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso2700408eec.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2026 16:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794614547; x=1795219347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1U8awJ9myB9NQ9BFpOtadS9kZucwnK4t/vce0ts4uRI=;
        b=kxfwu3HJirJIrBDPvXWzt6wbNk1ZaiwMJOqqe560I5WFXn1dw/RQ44c9FUUqUOHQG2
         XaXCo11CFFopHr5jD4ZQqtzQwQi7Ou73148hzv8JeBTWcuz2g48PktEGHM0Bh9hpTXDO
         4ex8agvS1O7NgnTbpvOs0DUPuQCNxoTqT7Li12SO+VAJiKvLlZANX13fRtN2zFt73T5Y
         JnF1m+wR2KICBwB4vX10crl0cs6HVrg+GmCk6TYZxbBN544hRdtN6Javhdr0SRXQRXYo
         o3Cog3rc7+zIMBZdCHwZQvK/HXalkmDQ5w5AR9oq8QsGlK9iWrHuJD4gL+nNKakFwqRp
         as+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794614547; x=1795219347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1U8awJ9myB9NQ9BFpOtadS9kZucwnK4t/vce0ts4uRI=;
        b=wsxcXPUvRSnecd7rpQpVI+PvMHfcjODA+aJh06VKgd5isCVuq/ovvnglRb7Esv4FHa
         RW0p630/9oh78xndtJYrsSWTS+Lw0H7+QHKqkCEUxOvO24MYzveh89eHCiTTCzBshO4s
         6+tQ/MQ3Do9/7N+/XXA4zE4oIfm4hNV38WHc+/THH/57QtruE0uCxXP6+uIuJ95uNyl3
         FI0BKk+OQ0GYMUwQStAQ5lVM2boXAP/zQvxTaMgMlt49UVyiQkYLQJn2qppGRRdHF5Z1
         TbqCVksGwjQXCnLkryasfO78uB3WIvUSS55UZX777pbx8qJhNLw9LezoSKiICJI0z2bD
         fChA==
X-Forwarded-Encrypted: i=1; AL+hErHBAQlNKntNQek5yL4buRRJ7OGj4uRJPFTQ0yc/xodOB0MeXqTqdoRJVbYx+mCRBUmnhB1nRpLQbnVEQw==@vger.kernel.org
X-Gm-Message-State: APuU4Z86ajzgaos90WVZkfFLOIkdDrR2Vr5VGwmABqk2GzIc2oPLGOlE
	JcXCEASPD5lUSgjIYuaonOoDyDOCem+VOi+FQ5xwMrZkzqV1XIt7MCg7
X-Gm-Gg: AYBFou37kdA/Gsb24mWk/i8Gk4it8/9XO4oPUG191LGvIPT/zE/hqb5RoN50Rgn4fCg
	DKKUEkDHol8ZmtUXR092N8a9p4RMvAm3JC9SlP+K7gR+9SxmT5fCCtHpU3+rlt67qkk3+sZm5t0
	rSlPg6xdi2OBwptAB0o4+s7Ra005hNL9OGPcDf3Mm+HuNvd/6pMCC2TqZtsOKVB77xg+JzaEDVe
	uAqB+u5um9GqpcuB5I5EdSqkpA9YTeAY7rJq8cy8zGiQ5kPZHzS4NiOnE1gaOzWs1SxjpvjervX
	uvVYAlhIpoD7P6QSN5Rmq0/XHOs4X+fHaM1Eb/LL1+07fFqT/ButeJnQNwcWs1/OmYLme41CCsX
	wRstNmNsvdjkczmz+Lnt44e8iU+0SxCmYCsd3jv0HImKWW7CUHYkKi8aBze75ZlBqWvOcwOnOwS
	jbU5qAzMOz+V9kd/GVFpVC2EYBEzag6t3Z3Ac58MhQXRR9p7Fqy2yxmVREMlOFJr/5Afdgg4s9b
	/1RpqnHoaoyzaIZ2UGiO2hLwc+usn/LeMc52uv5WSTv7qIAgVgXAUIPgAsTqr8rqa+eS1vGC2jq
	lF7as3OhXcPWY7Ken+zf9Iy+iDEZckxXi0ZA9DpcFvlgK5UG/ABcQ+MGt9EQnzHAD84mhT9kzx4
	/MjpHHPEKJtnIoqbTOF8/clqnYYmRr9Ydc8mfpw==
X-Received: by 2002:a05:693c:895a:20b0:369:f97f:72c1 with SMTP id 5a478bee46e88-3796721d051mr3595351eec.36.1794614546836;
        Fri, 13 Nov 2026 16:02:26 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:560:7267:5908:e9a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d269asm11309849eec.23.2026.11.13.16.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:02:25 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Yuki Horii <yuuki198708@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Input: tsc2007 - use scnprintf() when formatting phys string
Date: Fri, 13 Nov 2026 16:02:19 -0800
Message-ID: <20261114000220.1280581-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261114000220.1280581-1-dmitry.torokhov@gmail.com>
References: <20261114000220.1280581-1-dmitry.torokhov@gmail.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scnprintf() instead of snprintf() when constructing the physical
device path string to follow kernel string formatting conventions.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index fc707e672424..d55034914808 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -252,7 +252,7 @@ static int tsc2007_input_configure(struct tsc2007 *ts)
 
 	ts->input = input_dev;
 
-	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
+	scnprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(dev));
 
 	input_dev->name = "TSC2007 Touchscreen";
 	input_dev->phys = ts->phys;
-- 
2.56.0.679.gc527c65306-goog

