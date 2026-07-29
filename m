Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E9C42C504
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 17:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785345014; cv=none; b=cOS5n9jnTlWmz5v9qtMHjTCIlg5myHFKO2opYZ/CYPBA5++kAUbAAbQ6nDmLIWltNKibS0EWAzTK6WjlXaaeVOo24A8fYB73KqT93blTp1rlNnC7lotOUQFshpxXUEq5gudVPLCbL+aO+z5GhBB57irOFomNvh1xCQjby29cQjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785345014; c=relaxed/simple;
	bh=UR6pIQnyTzjaXOdm6+laYMyYYaPga4w7/YCHcdqAzSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQHE89+K7ZiOHqHGUt78ZnRMZnC4yUa9ftOznxAoiaIIHnu5bGdijpUQJ42xE5tL7TTeW0V7v3R8ybMwWOjs8YNxwtT0Hv0/HeaaIoBPdK/f2gG8AvxxuvHWYwtYqDsj8gOvzXeq9ZM2t/0Qy5DADJj/5cGAJclKkcNQ5Hxog6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p8am9Inq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8am9Inq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84867f07d63so1510529b3a.2
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 10:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785345013; x=1785949813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JSM1Q/WNGN2fXPGxJdqhDOrZHCVLS2fhYK8dJtwyhB0=;
        b=p8am9InqE83RMj930d7xUmnWvod1v8waMzYbcG3mNiDJGirDCYQ9fgxMzqsYm/FDAD
         WN/b6ZeIBHrD+xGueePkuarc8WbvCigfLC3x80guZJ41yQhK3E4xDwghnG75AlT4IIMe
         1HR+21D9+stanjIaJVoZSd5xus5oqlq5axtXa9hzupXA/intuD2jbi7zNOrYh9M4JkDD
         lFU/BqCxe4AYcvgF5ZvckZVIDr9yYJmRB0YxlAD4FKWEKlEcvnbx4IHozFpmaP9sVZ8k
         w06xlcaDsYC6QzzQGP1mEtMlQVDiEIQ76V7MParO8rXEe8ByMQtwRiVS3UQDOOMIq223
         vryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785345013; x=1785949813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JSM1Q/WNGN2fXPGxJdqhDOrZHCVLS2fhYK8dJtwyhB0=;
        b=r1IE2kxQbgdGHIXBvr3wHew4Wl/Qzbx7gzhV6toDD/YRElFLxt6rL+K7M91cYRn7uP
         vSxFyLXzq1mVPPxyjXq0K6OS9WaAQnuhudyjTexOnv6elO2b4A4DcfIiP8K0EzQhuNK8
         fZSAAnShdsoWjiD6h57gmGbOQsRd4gmdU8qr2Af82L330ydWuGhzpsRq4STkSQv2E+iU
         GP7GwM6Jv9Gn2/ODd7aE/dUMLefLh6x7pFbCfMGp5ZI7KayMmweepbingb8b+LXxs6rx
         DFP48/JiK+O4Hf7PUQmp7Mi1IWefgxXl8QfbAPZcyFjGx5LrmuDdumC02CC9irMJYZta
         RUvw==
X-Gm-Message-State: AOJu0YwpFYFTYyJmNsInUlGhTFfYYQE5diIeb1swFR8Hc3+e12Mmg5b/
	kQFZpIkiJWwrhj+DXBm34B3Yfc9NTpZnMd/y3AY5tvX35QqfO8nCAIP43OfkY9sw
X-Gm-Gg: AR+sD12IxOX97+i6h9SuObPHAmJplQ5LTwIZiDcjHEODlaZglKEwX9kYuCG3UerTKrr
	dgHkssfkBip0McyQo3YDZY2TD39h2R8+smul87XWaul69PW01jycYspvMDmzreiMiuZsl0YbStw
	JZjxY5AyuFWfVyXQhqopMklFxTmYQmvdWF+k9RWPhyvWUNRqx29Cr937SNPati8XdfN8LSkqREN
	2QJ/butV4YjfZiBJgvGVMP3gR1zMwB5cozMaQ7LcTw6XEwHLPEK/2s7PR1SLSZGpckUtgpz79w5
	zeZNcikn0p3NiIjXn5yuCJWpa22sw7AOM/4up/gNxycRo+K3d3eAFiOBFQDXjLOay/UxIp+5sBQ
	OKikrLmVm4YAiYSLTjK04/yC0B7p5EKJOjlKEJb3bI9XdVOSK29hBTjsJ4wJ0k4znu/HbI1W/AU
	q01wJH964KjzESwPqxi2toQNd0anqpACn1mUCMe5d2HycTNqOUGFCCSH4=
X-Received: by 2002:a05:6a00:1895:b0:84e:695:edfe with SMTP id d2e1a72fcca58-84e933f1cd1mr7926377b3a.59.1785345012698;
        Wed, 29 Jul 2026 10:10:12 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0052e04sm1694231b3a.22.2026.07.29.10.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 10:10:12 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] Input: synaptics_i2c - return 0 explicitly on success
Date: Thu, 30 Jul 2026 02:09:35 +0900
Message-ID: <20260729171001.260698-4-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729171001.260698-1-ekffu200098@gmail.com>
References: <20260729171001.260698-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

error is always zero at the last return in synaptics_i2c_reg_set().
Explicitly return 0 on the success path instead of returning error,
which is the preferred way when there are multiple failure points.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/input/mouse/synaptics_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics_i2c.c b/drivers/input/mouse/synaptics_i2c.c
index d4cf982f1263..66e833974c6d 100644
--- a/drivers/input/mouse/synaptics_i2c.c
+++ b/drivers/input/mouse/synaptics_i2c.c
@@ -261,7 +261,7 @@ static s32 synaptics_i2c_reg_set(struct i2c_client *client, u16 reg, u8 val)
 	if (error)
 		return error;
 
-	return error;
+	return 0;
 }
 
 static s32 synaptics_i2c_word_get(struct i2c_client *client, u16 reg)
-- 
2.43.0

