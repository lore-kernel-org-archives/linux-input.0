Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEBB3921D6
	for <linux-input@vger.kernel.org>; Thu, 10 Sep 2026 03:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789010494; cv=none; b=hXb1BG6iTaj0itmDVOw6kHRYAi4FWjr55e40bmRUIyoT3szWDoDf3fYYJ+7m8a9JW6CCjmM+3+XbnOUGCniFgzUOhn+iBDrqD1g1opWbJfFoevGiVwozZ0gjMUkxKw+C1wPjuswYjrJ0VJvfQMGMt3NlXiesRtEwTFuzyJ7gtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789010494; c=relaxed/simple;
	bh=8jNRGrzAMfC74cF7QqblcNHcIj2RnLHXXe610hq/Vjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJXauTGBmBFQ0XrkcrnZhO4A56DhQsq8rhyJThk3OQoUzsrat1Z2fgz44B/ZHo/N7ypnFwCqJT3dOjxfHEScDx6IizJ5JQHHDCNyHrFqoeVsuoPjLGr4HoDzE2KK6J318NhTKOO7nDNWBWfLJVz27YDwFgB5hkW+SnBCVmHjo/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUgJu/pa; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUgJu/pa"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1b0ddbd1eso65144eaf.3
        for <linux-input@vger.kernel.org>; Wed, 09 Sep 2026 20:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789010491; x=1789615291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NSfuMa1PaK7LxfGHLbiVRQmOmAt7jKjptTGVArTkaVc=;
        b=sUgJu/pa74fYdEWss+vwiyBP7BlMRkYj4+FdiZvmMBt5IY8z3hueuEWyU+xmevdXQU
         AkI2yGuxd5iBaC5x0B0NLJk6sMMCt94EpuXYPZ39/HtdDNruzwE1x27Ju3DAO3S7qpNB
         ewY4Gb1FdTKFR4ISANInAS3sDP/LJtgWrpXUUrqW2ErnN+A1h0p4dfRGs5+gX0glqZ6A
         eknYnDfE244YEpRAWTX3By1fQZr5NJqS998zYksccEnc+05IEAng+BWNZVKiGoDFQYf4
         UsRK8nOUb50gjGyt7f7WkGHetAabx0w48aFZ5SeU2LjdygYjDvBmob+dajT2hKEfuHha
         3Gog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789010491; x=1789615291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NSfuMa1PaK7LxfGHLbiVRQmOmAt7jKjptTGVArTkaVc=;
        b=Tl9ukqjC57E8tOJoe2YrLcX8A3KDd04msoB0y/+1/ar06Xic06fnubLSAhuRMf6mog
         N6RiEdSKfAeRZuq41BGCQ9+WGwS0vxrN684a6otX5bGLHHEXR/43Jlrv1YwGZ5vBQEUY
         q7tPzI+XYHhwGTDEF1jstq1+Amjf9sgx1lCOw58K+djOd3p8Y6NVyyblJDNOtlXTb9Rm
         qSxP2kCaa1w2caS8hQBMxcq2UMrZToEZ+X56VJFlQzvzg5EDByBC1wVpAPHbCASi7mGl
         DDWnEJyt4iKTe+tVjv5jhYileUJbWZXPqwVbKmB64scORRnH9+rVhsN1hj+QiCbqjdOw
         LJiw==
X-Gm-Message-State: AFuF++lK5maMsdJj669LiH4MTYukbIU0tIH9BzL7dnc2r8rX+zcvij+M
	2KC/8pKHGmCmo7wyekJVkRV6LdZOR3VHEBWEY6x3IpoHmxaAdNiMX6gj
X-Gm-Gg: AYBFou0KQBM8Go/PVGGdcFpvu8d/WGAlCG/XSdwYW4+AQWq7wnNVhwz/hLlcXFh2512
	UDi1NOOX8A6VcDHqGYXH3yh911YblzGA7ZVTMmlHVczP7ljGK4cfgptbrQRFVlHE37urGoIprjZ
	mroTmKlgf2oWa1+vk3S0dbBQ7wM/hf+mYbRll9URNA/fCAlx7e55Q1GfrDrtiKcbdGibgZrsD/p
	9XiroZyrFG+sMIR9hWNfdrCUi9pb9NJ/pXDADNj6H4IAv15czUjK4uwRdFHU5z3SPjPT25fg7Lm
	qroRD2s7l5qGYqU+26qE8fSTXQ3/tzR6hHnm2Wb6jV91VhfK3/Nffehjcc/YWi0wBRaYRW3IHi8
	nacxRStoJFOQUg8uiwgUWgj9+pR9u2WGEVsOFWIxliJ/hlo1E7Nv7iC5K+S4YN7N68bZfqA6m7E
	BXGqAFKfxaxvQw2HK2D3s+CeWyzXx4ihaNVz6jX5OPVNgwdoB8hS8hDBL9WrdfqBFh/2+4hBlu7
	h+AeimOBz+rFHDHNSfYylc3ySyk5iYkEpgG/jxBqJ2rT1BgzV3JYpw=
X-Received: by 2002:a05:6830:67d2:b0:7e6:6ced:992f with SMTP id 46e09a7af769-7fb7bba55e3mr17226582a34.2.1789010491566;
        Wed, 09 Sep 2026 20:21:31 -0700 (PDT)
Received: from localhost ([76.187.192.44])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f9f6da9a49sm19758315a34.13.2026.09.09.20.21.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Sep 2026 20:21:31 -0700 (PDT)
From: Andrei Aldea <andrei1998@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	linux-leds@vger.kernel.org
Subject: [PATCH 04/15] HID: hid-oxp: reject invalid Gen2 RGB status values
Date: Wed,  9 Sep 2026 22:21:04 -0500
Message-ID: <20260910032115.28669-5-andrei1998@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910032115.28669-1-andrei1998@gmail.com>
References: <20260910032115.28669-1-andrei1998@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Do not replace the cached RGB state with a Gen2 status report whose enable,
speed or hardware brightness fields are outside the supported ranges.

Fixes: 252c4bf1d931 ("HID: hid-oxp: Add Second Generation RGB Control")
Assisted-by: LLM
Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Andrei Aldea <andrei1998@gmail.com>
---
 drivers/hid/hid-oxp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 86a559c..c3cfa95 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -415,6 +415,10 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 		return 0;
 
 	rgb_rep = (struct oxp_gen_2_rgb_report *)data;
+	if (rgb_rep->enabled > OXP_FEAT_ENABLED || rgb_rep->speed > 9 ||
+	    rgb_rep->brightness > 4)
+		return 0;
+
 	/* Ensure we save monocolor as the list value */
 	drvdata.rgb_effect = rgb_rep->effect == OXP_EFFECT_MONO_TRUE ?
 			     OXP_EFFECT_MONO_LIST :
