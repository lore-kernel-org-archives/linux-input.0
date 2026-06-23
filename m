Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B6138D3F4
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782235400; cv=none; b=uTdSTzJRrJjggEZfLOJMhpSQh4wL3ZWX9+nPAKByRmsfXlCQPYqeB099iFzdPScfBCCXndc8zoYAWZUzd+VQJs5fvNRRqha495Ap+A7vtqQKmn/bFIjX5h/EbNHuF37X1zu3NoIczoRrunPZR5UhJyTS4cRiP2Gf2qPUX5kW+5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782235400; c=relaxed/simple;
	bh=LZsEYuufEHTiNQUqc8bd2+wq78EdqPaThHjQvLu1SOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=URqNhqtl7cgIY4ZYKlAqv4xa1izYz6j53YV/9jXiCfYB5/JQXFioKCU/QJPsNM4KprpT7cm/aRgaZjBpk7oUS4y91dH2CMB5bZ4X8gnPbkqyfjikbuW4zMNEVoEySffbhHTS2/YZYS+3yuE1rdT5T2pmWK3koHyEMA5/9Ml+y6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n+7MFWKM; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n+7MFWKM"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51a13ceb03bso130211cf.2
        for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 10:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782235398; x=1782840198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/TKiGctW0K3321xyS6+70Yb3LhXGmvmAuiP60b89Wo=;
        b=n+7MFWKMJ3qKdM4JkOwIHnklOLormidj1TICi6c0sD4neVzw6IE2ATwXu9a8u+nk5f
         pkoJLthU+r0lagd9InWBmOsEri7KJan3CqCbh+RR1K7A8JD01ZPratCcqT5FYY6NSH4T
         cMLYjtrrhhLlv1ho5FuilsqodQ/ADQzOEALNpZidkEg8tpaWBZpj0hZnfk5lS1738DD7
         5TxsddJhKlcZBPcQ0oOUhXxYGjmS0RcYMC3wws4cNKZ1a2r/gVChl2NWG0wWWd77Vs4b
         SR6G033mo/7SMbIanWOQ6uEeVTZzRl1BIjUrfkMC0uLcM3VSabH3QST+TqnzGB1M/9aX
         BSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782235398; x=1782840198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/TKiGctW0K3321xyS6+70Yb3LhXGmvmAuiP60b89Wo=;
        b=DCRi1QrGMQZRpFf1rkf44/hwolTPlhRwiWSz+S6dEvuJ+HK0G9Wt3mbHx1DugcTBTf
         X2jEjTpVaEUvhXxPfv8Xc+seeZ9KZFzr6HjJnXK+E4VMZUfwiUtBKE9LD7vq0T2mH2Tj
         sYhhP7bKaiEDberpqFoTLGUGzyYYOOYqiNSAhhzGFe37Io0C++CmQiHvFV4sMWfpmmDG
         iuLMFGGsViSfVlXsh59KIWOqPgPM6I0Cz/OVt95pyxPuCTKDtpWnmBTVgcfeEEKAQaN6
         Vw5Ao6CjXL+/aSQs4Zk/xKI70tCrsFQO4YicXB0jdvml95gMOu4z1x2RLH4R1JcKqQpd
         CJEQ==
X-Gm-Message-State: AOJu0YxnUPc7YYFcT/SKUSMqFAL0luv0CkqkZR7r2mfMY+6XlOhIHjqT
	WSUgsTlUwW9h22iyLP7WCnXQaFg7Znr0xwllifXkhf3Z81YgBPECNKYV3EQ4+g==
X-Gm-Gg: AfdE7cngaSLlM1jRnu1DZpfilMtL8HJWlhTlHG+bB4ZL/81q3kzw828MvQ+AsA3SmHt
	v3Av2Uv6vyVaaACcLccSYg0XJ+DPmFB1j88CIqc7xoBHFfSlth604EhOZmuvkj1+terEHvyx58L
	QHJz0/pg+QV01uym+ARDnSO5g/hR0v2dSP89D1qeuHfqCbvwawsafiRoD01a0HX00s6vMgC7qFN
	znyeDT2nVfSL22u3mMBRaDL4d4+iOVp2q+VC58N58gbjAclztJ6T6/s1IDyYi80hHRf4S1M0hkJ
	9dqtcP7fDiVpmxAAsm69V9ptdBBkjnPtftVjX7wz2QfaMxNeT8bnby6hmLZaSGs2yjknLkaToCx
	ZSWzvw6TT1nCHBvp3dh/mskJot3KeA9js8J/dPOZ2ijtRD72pwDwarLko5bNgAeovhlKG12wgli
	PRyUn6SdUzx7DcwKvyyxhI3DkRMVqx6CD2/ZjLw5NKg1xGkWz7CTUYSG9hxvU=
X-Received: by 2002:a05:622a:5cd:b0:517:2c1e:8b6 with SMTP id d75a77b69052e-51a61be3325mr24661cf.38.1782235398226;
        Tue, 23 Jun 2026 10:23:18 -0700 (PDT)
Received: from achantapc.mynetworksettings.com ([2600:4040:124c:e000:ff10:313f:67f6:deeb])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51a515c72c1sm29390531cf.10.2026.06.23.10.23.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:23:17 -0700 (PDT)
From: Sriman Achanta <srimanachanta@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Wood <simon@mungewell.org>,
	Christian Mayer <git@mayer-bgk.de>,
	Bastien Nocera <hadess@hadess.net>,
	Sriman Achanta <srimanachanta@gmail.com>
Subject: [PATCH v4 07/10] HID: steelseries: Correct Arctis 9 battery calibration range
Date: Tue, 23 Jun 2026 13:23:07 -0400
Message-ID: <20260623172310.272708-8-srimanachanta@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623172310.272708-1-srimanachanta@gmail.com>
References: <20260623172310.272708-1-srimanachanta@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Map the Arctis 9 raw battery value over 0x64 (empty) to 0x9a (full)
instead of 0x68 to 0x9d. These values match the HeadsetControl project
[1] and fit the calibration points from an independent reverse
engineering of the battery tray (about 25% at raw 112, 50% at raw 125)
[2].

I do not have this headset. The values come from those references and
were not measured directly.

[1] https://github.com/Sapd/HeadsetControl/blob/master/lib/devices/steelseries_arctis_9.hpp
[2] https://magnier.io/reverse-engineering-arctis-9-battery-tray/

Signed-off-by: Sriman Achanta <srimanachanta@gmail.com>
---
 drivers/hid/hid-steelseries-arctis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-steelseries-arctis.c b/drivers/hid/hid-steelseries-arctis.c
index 4be586db0004..1f0e9cb5138f 100644
--- a/drivers/hid/hid-steelseries-arctis.c
+++ b/drivers/hid/hid-steelseries-arctis.c
@@ -146,7 +146,7 @@ static void steelseries_arctis_9_parse_status(struct steelseries_device *sd,
 	if (data[0] == 0xaa) {
 		sd->headset_connected = (data[1] == 0x01);
 		sd->battery_charging = (data[4] == 0x01);
-		sd->battery_capacity = steelseries_map_capacity(data[3], 0x68, 0x9d);
+		sd->battery_capacity = steelseries_map_capacity(data[3], 0x64, 0x9a);
 	}
 }
 
-- 
2.54.0

