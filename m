Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE433CF034
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 12:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035051; cv=none; b=a/+z86FG5Qq6lnSimz/4ZRfwAs3KlrlwngALSGm7cTO6euSk9BKg04n7gh+gtSnGyFdXmBGoWw+GB/sLTwvBb7DDd/MgZt++xJYct6AQ4pLSwbfCauMqJgbLlUPZMR501SNb55WOLve/WahC+vCudRwKwS+sAkYAq8EdRodeZjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035051; c=relaxed/simple;
	bh=tGur+6p1qJtuprGn4ZdKp9sdtFjxIeU0ejIEl2uOVyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gWuzVrNcRsI1WYCBG/I/huLVM37VwOlaZl/Dzd59NY1GK9zbVWjb4nHtfLN0AEptPvTO4+ZJI4W2GbswX/kfp6TOgR87cIODhmjNtciQX+eaEmbttjNlEz4XoEe+hD96sBXUG4tpVAmMs4pDrM68V/HmzhKFob/XKSEciy7CySE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijVwXmiZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijVwXmiZ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35691a231a7so5390699a91.3
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777035049; x=1777639849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=89u8XM/KjnVhQmxm/v4ehKlcpnc8v2ojHxWAH7ZV8N8=;
        b=ijVwXmiZ9IZ1zAvQmMhZ0/fF4q0Mcb1sxyHxzRyMg9go1W62BWMysKFlD4/DF3eVL2
         afk0X2Pch9kx9RtXUAi1eX/LNCEg3xChcBZu/hknItOhDjvgm7dWy7CDK++jU0xDHdrt
         PWPeOnJ3oU17gHRZ+11h+1ouXVItPnI4HOsVO9ts18Xh/IY8TUOIoyrCy5DhGgmG8ulH
         OpLUqMvKYBY1I+bu66ZNe3B4huW4Vs9Hhthr+1bC+1nO5O2z2g/qfw/AgNcsEZf1RKgg
         sd7LxY/XpXJik8zsiM5OL3ZI6vKqgxuvbOD2yHpFcqEQzKe4HBlbMfg3++m8Y8hwrTYz
         tYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777035049; x=1777639849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=89u8XM/KjnVhQmxm/v4ehKlcpnc8v2ojHxWAH7ZV8N8=;
        b=qpzLPpI5+DCOMx7+1a9qLeFdYz7WpKIY+SqcVKVNAucPedwIyL9znWQl6c9HwHoq1s
         OPdecXqf0v3GFrWcODhu5QjtSWti9l5OOxYgebQnKYfzs4A/gRkZbySJoxyQPWcU94Fx
         fUPT2/Hfl5r3qryh4orjQL2IB+JptV8bTHioEMde9fcG1s2QzMeUulXuA6Ih/CN4/D+O
         6bCWdPvc6cwFi/w5mAElne8cR6CRe3vQkkXq6kokO2XjDSRGrg4lsvMbysJNJc1/4KDI
         Rt8vUY6fcNJyNTOWZNJFpvDZPy59rN64EIoa5HarWA2LaZa7v5EAB6WKQ/IMTmD42lGb
         YcZQ==
X-Gm-Message-State: AOJu0YyycnansojVs6zaLA8/b/xsY0KAqZOOdbTAaadLxu8vtGOwbgEV
	7ybgFY45lvgSHSCfk3V2TkytE9tvq2YRG7S+ieyvmsmiS0mK/Cf6qFw=
X-Gm-Gg: AeBDieu/Qzrf4xi96+oFdNOkFE9M4MYqcrNyeHZy5umK2aI8SRhg8UzO8Pjolf65knT
	BVaGHnxKiXtzsoJOwVgPM7UD/d+7YmCWe6aoNL82AQGS9ulRiWAcAK0kJulb8vNiWo9E9XCDWLn
	Lrkm1MQc+MS9yIRJi75U/aSKE2tzWhZsvZqWnqwZOLdnup5J5I4p+QaozYMQ8r/crHgJUtD/9xv
	KV6Lop5nxW2Jytjt+iHmwfIzLlEtINHO8APJJT+Y0nGpgT1wO1b0mN0zJTAATX806yZptVQcGVV
	OrISIho6FWD5n0c57NAmwfxgVsjVAFhN7mpVI3qi7I6/62ox3RiVdNli7lSsvHhR0apwGxNkZAT
	TE4LhnYwG+gz4B+LOhWco74kygeVz+aT6VC9ozKqOqK5BYsNSZWHrYzj+AZHvqQGd7CGJlqKDY5
	NKopIodsg/iyi1w5uiQ5CXdPx689CJgklifCpsHDUlh+ggbAsy6MNH0730iEmGlDgjVaS9tLLOY
	dNFs5IA++PUdJ81WZf81bKA6rjipnSUPhgfmYj7CJnXTpM=
X-Received: by 2002:a17:90b:5865:b0:35d:b00a:3c54 with SMTP id 98e67ed59e1d1-3614049447emr34675303a91.22.1777035048876;
        Fri, 24 Apr 2026 05:50:48 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186adddsm24456463a91.2.2026.04.24.05.50.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 24 Apr 2026 05:50:48 -0700 (PDT)
From: "=?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?=" <mhun512@gmail.com>
X-Google-Original-From: =?UTF-8?q?=EB=B0=95=EB=AA=85=ED=9B=88?= <pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>
Subject: [PATCH] HID: google: hammer: stop hardware on devres action failure
Date: Fri, 24 Apr 2026 21:50:41 +0900
Message-ID: <20260424125043.52639-1-pakmyeonghun@bagmyeonghun-ui-MacBookPro.local>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

hammer_probe() starts the HID hardware before registering the devres
action that stops it. If devm_add_action() fails, probe returns an
error with the hardware still started because the cleanup action was
never registered and the driver's remove callback is not called after a
failed probe.

Use devm_add_action_or_reset() so the stop action runs immediately on
registration failure while preserving the existing devres-managed cleanup
path for later probe failures and remove.

Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/hid/hid-google-hammer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
index 1af477e584..c99c3c0d44 100644
--- a/drivers/hid/hid-google-hammer.c
+++ b/drivers/hid/hid-google-hammer.c
@@ -496,7 +496,7 @@ static int hammer_probe(struct hid_device *hdev,
 	if (error)
 		return error;
 
-	error = devm_add_action(&hdev->dev, hammer_stop, hdev);
+	error = devm_add_action_or_reset(&hdev->dev, hammer_stop, hdev);
 	if (error)
 		return error;
 
-- 
2.50.1

