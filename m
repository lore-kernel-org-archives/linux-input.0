Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796C53CE48E
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586559; cv=none; b=o88mVAVBvWnMXr7dgE9EOdhoJIZY8gYjCznGEfa/Bj4/xVkaGvOMP/YhE1oBBD7kJMRg++0HkHQiPWY9Qqly+mfb5CMh89uLn1UvfnvBcgFwPxhQzv51pTRifyHzA3jgPysPrnlgCI4qaQuE17hZ725HKFetMssoRhCcjdMCW8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586559; c=relaxed/simple;
	bh=KwNAHrSwIKI2LxPgE/Al2FUyUeSEKJkFwLGNFJ2NfUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cTeoHs9mRk+tu6H/SxGfVz531nHCZjKSqsSZUDUp5b38YkdctovQYJ9G4O5p4L9hvQ4RUIarWgaKv+NO43p8FcLGEHJB2yp1iFpOwZRkDo9supCG4VkargKYzIjgnWJSwVRQYZG1K2xTmd+CODB4PtrxtiKw4m1D1ay9kwx/tfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1ndhOgD; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1ndhOgD"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1370417c01cso5355106c88.1
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 22:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586558; x=1782191358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEHP92EpttD0Ex4sU8fQpe9LCvz5Lf/+figQNr8VguU=;
        b=P1ndhOgDBCfVUEUU4NPtoliyoI0JwzQ3WGzrjTMopo7ek5XHari7/v+v412e954VhI
         Vw0hlBFbNrbOTqQ9DNJy9fQ/5/tQ5+80ekT1UXgi90FEK3iWWqhOKa+SZj+Z0xgWCEdv
         VzB/uF7V5/jsgUn0KHRv89jgCAA2i41bnstSk5iMQt+S8nILmzwW6D3542gBKFG9sPRH
         O4A4A2S2NFi9bya/ZFfj0VJAqaYX27frh3v0cIkQ7aaomNiwEP1QssT7c/1FKuUxKiof
         9E0TvaWt/9dkBxBtAt3H2moL53JVMui0wTlutOJ5Wxk/iRs5Q2GxrySC3r28fbYvjT8X
         tzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586558; x=1782191358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IEHP92EpttD0Ex4sU8fQpe9LCvz5Lf/+figQNr8VguU=;
        b=BgOpQon24NDgHgMVgXOlMF3zhkWF4pTBHUKoCEa+X2d9h8x4WnIaviBw/tlT3tE+wN
         8tFWnp/X1WQgCcg/zRq17/NJv7jiQJ1O36gW8cOMyE0JuvKI1CeCn4DWLifahCExKSp2
         gyJFN9AZW8C+7f5eyiDM0bNFPqEqSs9V7S0d9+C5GfLEt5Cu6urB62UjGRNO60SoQ1oc
         m/1jER6MGpSm84+g5Jf00SjA/hAmaoku988mWen5p/5srjxWxdZZwRgF51FlfS4cHd1n
         Og4nfib7kOFmrWfIVSjb0PdKBPsxa2NUpJtJGi66h9zGoo2ia6cZrAJ1xVKuYeeRUxRb
         ZWqQ==
X-Gm-Message-State: AOJu0YyC+gWWlrVG8X/hy/TAJ1hkI/8zqs442w89Z2OHo0PucukEMSiG
	wlTvwffDMTl9unj4x4qKTwUsvYr05lZkgHUzHmWM4St4QuUxF+2TUfOFwY/brA==
X-Gm-Gg: Acq92OEu2vTcGoPUUopbSUMe++CmMANavZO2mhJGBzIAxQOMXCxu2jVMVc0ama1P5ok
	kIRgR938Q6+PWqQYePE3Ypcq7YcLJusmCp/sWzO7I1tdKH1+NL1LghXE10kmrisr8nEHttzCQ1u
	xrTRj9Hc1duxdrkgzoVfUyORL09xLF2d3UXxcFZQAbFwDXryLiTBEX65wYl+Gn++nlNoJ8U5H/W
	kpy8KGCeIs8Y53U/R3wpX84l1ZOlCXMIrfdxwRKZghMBbdmVF/T6AM5X70kBJlkjDcikO1ywL6M
	pwJoCdSWAybtRnVs5+FXtIUOXBVQNRnmS7+qqk23GESd7y+ZxLbEcQ3ulWy6u6H48qm/JDI4+Nx
	9LiGKS7oyrrVvnyLhwt7iYixEERzQPCLGHSIHWUfqXp3JG4sCJdOZ5MHnZo16HBysSglZ7Har72
	eCf7EGTs5pGiRfY7X/ohA01MfDmq5M+Toh+5Z2AYmIkdPAOsFNW6oDOjsnJ3Tn6sOUndRfNR9zP
	0Nk8zqxtz0yWvo=
X-Received: by 2002:a05:7300:d51a:b0:304:d788:ac5 with SMTP id 5a478bee46e88-30ba600f526mr1323444eec.35.1781586557562;
        Mon, 15 Jun 2026 22:09:17 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4fe55sm17266615eec.25.2026.06.15.22.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:09:16 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] Input: mms114 - prefer GPL over GPL v2 for module license
Date: Mon, 15 Jun 2026 22:09:07 -0700
Message-ID: <20260616050912.1531241-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As explained in commit bf7fbeeae6db ("module: Cure the MODULE_LICENSE
"GPL" vs. "GPL v2" bogosity"), "GPL" and "GPL v2" have identical
semantics in the module loader, but "GPL" is preferred to avoid
unnecessary confusion and maintain consistency across the kernel.

Change MODULE_LICENSE("GPL v2") to MODULE_LICENSE("GPL").

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index 53ad35d61d47..db23b51f4630 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -722,4 +722,4 @@ module_i2c_driver(mms114_driver);
 /* Module information */
 MODULE_AUTHOR("Joonyoung Shim <jy0922.shim@samsung.com>");
 MODULE_DESCRIPTION("MELFAS mms114 Touchscreen driver");
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
-- 
2.54.0.1136.gdb2ca164c4-goog

