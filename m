Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168F38839F
	for <linux-input@vger.kernel.org>; Sat, 17 Oct 2026 01:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201213; cv=none; b=e+ffS8ydQLSne3XAfsIEWkzqWEohu7IgTvTQ6scN1oQyGtgmzluoLpRPvpBd1lswFHIsQCl/K1yl7ne8qNxhbjIcSFP5MAWBwFjhtuA9TjY1clprqp8/KlYMTpxwxquC8Z3wXZ8WPD2UZ5+Jb23nmKq8TdNpbH9iNk/E9KXhZmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201213; c=relaxed/simple;
	bh=ap9ePz+9PV6ufOeUJx8Qbab0l1IL7Xz3NBboXApR0a4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hX/g0lT6WDT1c/QirACrS1DLPX6Hi7BoujlnyDL6motNE4y1alYSuPoB12GPsw2s8i0u9hzuH2QeRuaeOlxnvhXGf8+b/KtHlxqXZjD644hsm9zz3L+OxrfDefdhWGg6A3AhRTKP1Z9jUr7yrvsW6/fQFZaIhtL5qI1+gVVEtLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVgy+QxN; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVgy+QxN"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-144f79153f5so1293654c88.0
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 18:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792201211; x=1792806011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bYkTuU5A/bCkZlXHIgBMm3vkDI/xApJANJAk++gOls=;
        b=kVgy+QxNeQmUtop95axvQfj9JtvdNkQNSr56P38igpKUNLY9MU7LIxxzD3T3zrY8Ro
         LOB7ziT/q75pokly/OVycnJseXOkdde2Dc0ZbxJW0qekoP4+TwEF97SuR/oj2LnogUDd
         nK5Wcy47Zj86PVNviIWpytGU074Uqz4+S7ll6Rq2w2idx+SKWT6iZDVpl26Zybbh9Sb5
         r+XEGjWQeGZjs5l+sNhP5FUkq8JOLj+kn5yBOfM91OYlH9ZG9gVvKs7aSmjb5tWaby9w
         FGvjFLCO4F4GEYIjnDZfRVqVp6QYjZEBJDxWwWFqh1i/yDB68ME1ySXEkrUbuLhjh0Hh
         aAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792201211; x=1792806011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5bYkTuU5A/bCkZlXHIgBMm3vkDI/xApJANJAk++gOls=;
        b=LX9F9QrV6+M6Ktarg6TaaimfY1GhZyJHvfVcqMX9NWHjYUFZLqHMMTGLjoERk3n+el
         zbkbb8K8Qga52cXOs3VYYb6rm74lH9JwnuUk7CA+5yAk1AVPqu02W9NWZTFNiKWkDTxu
         5Dnx/9CAa7GbFF1wBgVVtXayYvVK6n3sarIMc1WR2A2/0atjJRtH7gMGRaRBleyKST7Z
         drLCBe/t/QQsb0j+PBzXgfl4i4M01m+ho8wHVabvW2GZwHgCNnB6EwP8wIjgVKG2iUKC
         jVMtKiu5Nx1ZFHeJlk4UhMOLWW7VxkOlo1XLSl3ZEp4BuJwRPbHhj6uKDdzREWzQWD5S
         acDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwulw1NfDsEFcFm/TSULXwYJ7jLYP5WegHbX4Y2Ls6P/7Z54hs4ZYZ33CryTYZyrD9C/Yw10Hv2YA+Lcg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIgBhpDwonZ5vGumQDsR+hLHqQOz2wAefG6pgtOg7+F6cjYygaK
	dqSh5GUvBYK4/pRCnSR2GbVwaRHpEILqhCSStfcRr8oZl0NWBsmmKh+i
X-Gm-Gg: AYBFou0QA494CbwROA5w0Jl/pFlSoGE0iFTo1OJuuYzT0PomZmJJ+IJ8OtKKcqBm8nX
	LEDWfybSpaXrjit6rwRsM8i04oh6gA5tGPUOXo/Uu9ELFeab9mtZQ4EesrmRCELvJOFPO2bp0Zi
	KJXpBYhWVawY7500nhqrJBabA+GwbPfsHJA3uwbnG0Tqi+arKW2G2BHwr/1/8N0aMMMOnSAK/TY
	kS1FqIJuKmcdGyc7P/L7MDtzMbNtgjUzUlVstDn4SDBofeTdpL52aa413bGm7BMqOVG3cZdxrgK
	mlXG3EPpQfavqZwXW/zweqgFv5tVz7wiYkvDxuKqafBXK5lagrBclVuAEAY5qlfBrsP53xoG1By
	koxiI0FnjDti5oP69V3HsM3W67cvIVWcqTthXMod83UdWPrWR1VkWP2JptMAc769tk7M3gfdaqS
	SZSAzG17yWISbD4mB+hj7uG9ioUu44hsRanuDNNRhRdzoKQtc7RSStqc/HgpBfY8EDqlDh0+pIq
	kCG9egU2IKwPmeRxzYvRLfgiV8kKjZUXdIjESshlSa7GrNx8FvNfly4Ppn85zbCiUpvmyajUjQH
X-Received: by 2002:a05:7022:b043:20b0:14c:c588:ac21 with SMTP id a92af1059eb24-1851069db0fmr1875193c88.9.1792201211295;
        Fri, 16 Oct 2026 18:40:11 -0700 (PDT)
Received: from lappy.taila8a9bd.ts.net (108-228-232-20.lightspeed.sndgca.sbcglobal.net. [108.228.232.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831acba710sm12128429c88.13.2026.10.16.18.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 18:40:10 -0700 (PDT)
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@lists.opengamingcollective.org,
	stable@vger.kernel.org
Subject: [PATCH v2 04/11] HID: hid-lenovo-go-s: Use pm_ptr for reset_resume callback
Date: Fri, 16 Oct 2026 18:39:49 -0700
Message-ID: <20261017013956.2440130-5-derekjohn.clark@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
References: <20261017013956.2440130-1-derekjohn.clark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds missing pm_ptr to the .reset_resume callback for hid-lenovo-go-s

Fixes: 3524900cc571bd922a ("HID: hid-lenovo-go-s: restore OS_TYPE after resume from s2idle")
Cc: stable@vger.kernel.org
Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
---
 drivers/hid/hid-lenovo-go-s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-lenovo-go-s.c b/drivers/hid/hid-lenovo-go-s.c
index b27e82ec9b76..a16733edad5d 100644
--- a/drivers/hid/hid-lenovo-go-s.c
+++ b/drivers/hid/hid-lenovo-go-s.c
@@ -1560,7 +1560,7 @@ static struct hid_driver hid_lenovo_go_s = {
 	.probe = hid_gos_probe,
 	.remove = hid_gos_remove,
 	.raw_event = hid_gos_raw_event,
-	.reset_resume = hid_gos_reset_resume,
+	.reset_resume = pm_ptr(hid_gos_reset_resume),
 };
 module_hid_driver(hid_lenovo_go_s);
 
-- 
2.55.0

