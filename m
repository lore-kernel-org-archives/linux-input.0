Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C87221721
	for <linux-input@vger.kernel.org>; Tue, 30 Jun 2026 05:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782798560; cv=none; b=teYVAMq6LTK8CW4z0VUJnXfjzJn/MH7aPxYESv1W/L745wjW1jxGA7Le0JB7tskTMfOoEo6mSUkQgwpFsL3bhG/Hzc3lyBr10CvoeXRIrgGenAvXjn+oms1VfbgfvyAdugAm4bAarit5l6ylcLEk+6pX0PVsm/j/0kmy7iDyjA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782798560; c=relaxed/simple;
	bh=uFVCqxuvzV/SjM4ctblQMcFsOO8dhR/B1b1CTE7hXgs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DvM//llCCqTntuQvkcOS+D8RejKY9j8O6JWJyAoC5DPMBhkL2/EpxXWwdzcLQYiOudY3+j4NoLsOABvqX9NBpMlIFoj1lxB0zbJElgzoWcBmhZVZYR0A8j25Dp+iYX3dgMxavldRR7Na4d04XCa3/XcxXjqxP1BwQJLw7M/K5jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNc9vikO; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNc9vikO"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-139e498e428so140025c88.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2026 22:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782798559; x=1783403359; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G7tAnL5amZcdWJzi4p0de5TpZYJsvurjiCg2/XYr1Xg=;
        b=kNc9vikOv/C9jq30Lc9ck27naSt5f1CmhgGvQnYJczOgq4gYfh/tTe5cYnyWWL4Jeu
         i/jplzccv2c98MEb+6d8oyQlVaDgcufriE60Duywlt1E5VVZcZ61lPQxq1lnb8GhgrfF
         oeMAykYQEkQYGS+w5arvMh5I1REWC7KynQ5H3WGwLhX/wFJXfKCLkjucSHxJEetrK897
         3Kr9wRSKrERDOSc0tzp8NGFjwVqty9wGBQ7USMgU8hO3u9pAf03+PEmskEUMLU3v9o9t
         UU2nlcLol4xLEAuVCfAFi9hK64yjV8xRJxhh5WFXVamVsySnlXrAe6xu6FlrLZnmhnW6
         AylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782798559; x=1783403359;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7tAnL5amZcdWJzi4p0de5TpZYJsvurjiCg2/XYr1Xg=;
        b=aA+kpMj4wp//hNwIuBIxmqi/G+rFbFcaO6fNgUTeRfr6zklmRv/oZG4NIFsHVhH2LS
         zWJyJGYtwn4UEQj04BB9mB4wpf8f9vHzUfPnwTSHzZSxUBK2UXcVwMtlxZ5Q585FQqHO
         mQ/6cjAeXeUR40aaTV9GJSXAXStBsisDvgkxdWbeuoabSekDbOq1VyVKDC/g477Zn2yB
         VEhO9wb6bcwQli78ukMSho7JkrNe9sLC4hvcus/q3/EzRMJOxAe+99SEoH0RBMupYWZp
         Jl0R0CVO6YDg5d7WyPj1/y42kdWijTg2WGt6g1UfvEeJl588F4XuqCpcyNnIhJs4+vvo
         Cucg==
X-Forwarded-Encrypted: i=1; AFNElJ/hZWZIRhx0FRsaHxRHotobPHvSHxGVVD6NkPBs1jThF0TQqy/NTLxd0cXn/GW/ERgf9OacMyNX5f/8+A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0NLXDHKpGNSoYP6qq0OCojzYfnJ96zzcVVJ8VPb7/WM//iyj+
	NsBXdusVrJPKQBjDi7bWWbuCxUx79QujQD6FSdw3yIsj9NcLm3MgmqRu
X-Gm-Gg: AfdE7ckUTT9fbG91c7wHn2mo5EdnKLecH2z3eVkrUMwDyuPtWB2Aw55EX6mvI3BmpLg
	8CKKbyVEtVjCC7ZR/C6soBSoK6+FwSrkFPfBr1kTKK/6NnkLHtwJMuXyh5NQr9Yq44TO1muyc1z
	2IgHLHc9uEqLc3v0QiOrRZ+Em4qH/Pd7gtuDHp2PACtnw8AwdrFYbXFy0Lu4e/uKfbs9/gXiovO
	h/9k4rnPLhE+8W97cEg2n4eUm6jwPjPCwbzhZkBHLf/G5pFQbxhVUk5z28DUwPVw+NR23XTPT/s
	eMHuYBmQZoI/OsvlnznQ//hjrxrOqVL0VB6kxRrXw9f5W+QX6DbVZdv/ZsfczrdHGlsSDO2z0tP
	H/GxH9Hkus3/9XodOn70cIHnWSqJeQRWjjKEpOll5Q/ziQxhW4AKIZ3SZrwisewbXEI4edqmhsc
	7oVjSwCVeQR2cl461IGnlnA5X+7k50HnYvUQoM/es6arCvDr49s3l1bA==
X-Received: by 2002:a05:7300:8ca4:b0:30c:ab96:7306 with SMTP id 5a478bee46e88-30eea0e9753mr398200eec.22.1782798558792;
        Mon, 29 Jun 2026 22:49:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8d36:e610:a260:756f])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee3264f52sm3901774eec.28.2026.06.29.22.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 22:49:18 -0700 (PDT)
Date: Mon, 29 Jun 2026 22:49:15 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Adrian McMenamin <adrianmcmenamin@gmail.com>, 
	linux-input@vger.kernel.org
Cc: Florian Fuchs <fuchsfl@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: maplecontrol - set driver data before registering
 input device
Message-ID: <akNYib9hQFNN1fA9@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Set maple driver data before calling input_register_device() to
ensure that it is available if the device is opened immediately and
the callback is triggered.

Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/joystick/maplecontrol.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/input/joystick/maplecontrol.c b/drivers/input/joystick/maplecontrol.c
index 7f36f73844a9..6293b6e8148b 100644
--- a/drivers/input/joystick/maplecontrol.c
+++ b/drivers/input/joystick/maplecontrol.c
@@ -112,6 +112,8 @@ static int probe_maple_controller(struct device *dev)
 	pad->dev = idev;
 	pad->mdev = mdev;
 
+	maple_set_drvdata(mdev, pad);
+
 	idev->open = dc_pad_open;
 	idev->close = dc_pad_close;
 
@@ -146,7 +148,6 @@ static int probe_maple_controller(struct device *dev)
 		goto fail;
 
 	mdev->driver = mdrv;
-	maple_set_drvdata(mdev, pad);
 
 	return 0;
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog


-- 
Dmitry
