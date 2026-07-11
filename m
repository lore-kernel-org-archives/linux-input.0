Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA9E3C279B
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770604; cv=none; b=ZQvmgW3mRGUV7aEzlnjW8vMNHogSrz3MmXxxKks7OJMAXpMygO3Pf0jGrfuUmSPi4YdARPdkqJ9SsVafiNALnhvIXFvzmb095Fw4jVz9mFCAqxnWVDjl2HHc73Tnu9dkKgs94s9taE9sZ7B531U6EfLQApfIxFwRS6sx/nvysYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770604; c=relaxed/simple;
	bh=o2Hiy84rnP/9UMKURCEIhcD7/nHJlcIAPilhOK3M2oU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d6/hay9VtWN4oIIx4VYYnb0u1z6IXOo8N9FbuwcY9xh2vLvFGW3hcBUuJ9U3YuwX5BSb0J8qEmxS+IK1WWVaGl7qz9POfPwmXNp3FuTi600lN1uvBAwpk3jgFsMS2ODzRc+41W/qZw5EHOSKCuCMa9tlSgXk+VSst3+xS+7hsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3825c406ffeso1793117a91.0
        for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 04:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770601; x=1784375401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kJ53oWqRjCNjVlROCxKHTEOJ8pLHHBllpxRR0nGEHyI=;
        b=KTwHov72dRbcC2/Y4NjWWJv5oyDeswNckfxjuQ1DgQd9B+qZpVeM/nxGLxNQj5CQ01
         xQziq9o3wWuyJaCGvcxmBrx//2q+0YMM3Dm3C1OJ87EIU5PCGkopQMUsvjiOADeYzlBq
         vFkjOATa1CPMj+xP1Ljj0IWtRKscqP8iP07wsGPo1XUFwHJZVaqdc/LwfOjX5sxK4TyA
         /N6mit9h/xDU5h/IQtPojnlwZozsR6aO+3j/9r2jMDo1T+nAVpY/LWXzAhSSGmvQOdSM
         KM4KrM9hK14D5X26iPvXhMnSR39/T8ykFm7dIZ9Egq3W4TAG8L7cOsS97AIKZyMVkW1j
         UFCg==
X-Forwarded-Encrypted: i=1; AHgh+Rpuk2F6LZMfshQrJsnl9X+WB89N3063tYlAZL+qX+Jou4f08Ju8lrx+1raiTHrjN9fiqA9GLed9tL67VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXgS3KFM4L3Io884m1neDGdwAkP1I7a0QSD9DYdRQVoYGPEff5
	7tXwk6S+tMciILDcl2MNfSSmvQelnsCTL/Tnw9qqGj/sOatsQuR9scg+joTGd/FJ9t25
X-Gm-Gg: AfdE7cmfi19v4Dqe6PAwiz+hhNjeHLhq/D5/3mrPh2pvCXrezPMw0qryIoX1zkLgeV2
	VLBLJi/qAUB/TV/NhEg8vhCWVr66e21wil1nFcfaDqGFMEk/l0HEMF7Vea634J7C2FkSpCveCMF
	KP5GzErvKLl6XOMRWnFL3Va5JzvfpTqM3IKcxonDXGfNHlc3PO1bZd5wAxSdajTXl9NrQ4tEKnl
	9GXhO28ILANlsvbu4mZYqPA6G4cE2oIIEMrMVCOh2tBe5k0pGgbnyp3j5InoE8LYQQEpej0jVUj
	NJmfyeEw4PRQNTya1w4kpsVxBGlIHgARJz1xwNe1FOmZAkzjIHgYCMQLSOClwM7Y4nX5kvseSxd
	4a6yRa4OygS98z0Nad4FB9Aj98IfBz0morShWzidUklzql8PX+tWstb98JLp6aKwfZwrv/qVMSN
	rmTk7avel7hcANNMbrxgUw3Dwpm23a5Khd62dEFCVtoqAToN+CXsdPOLuDZJeJZJOvwN1sKXPgF
	ipZONTOM1Q9jT+t8hmr/fpm7Q==
X-Received: by 2002:a17:90b:5344:b0:381:1b66:4734 with SMTP id 98e67ed59e1d1-38dc75d0b31mr2658787a91.6.1783770601104;
        Sat, 11 Jul 2026 04:50:01 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-52-13.dynamic-ip.hinet.net. [61.228.52.13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm3957570a91.1.2026.07.11.04.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:50:00 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Shih-Yuan Lee <fourdollars@debian.org>,
	linux-input@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 1/3] Input: applespi - cancel pending work on driver remove
Date: Sat, 11 Jul 2026 19:49:35 +0800
Message-Id: <20260711114937.16670-2-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260711114937.16670-1-fourdollars@debian.org>
References: <20260711055247.5412-1-fourdollars@debian.org>
 <20260711114937.16670-1-fourdollars@debian.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During driver removal in applespi_remove(), the managed private data
structure is freed by devres. However, the driver does not cancel the
asynchronous work applespi->work, which registers the touchpad input
device.

This creates a use-after-free (UAF) vulnerability if a pending or
running worker thread attempts to access the private data after the
remove function returns.

Fix this by explicitly calling cancel_work_sync(&applespi->work) in
applespi_remove() before cleanups.

Signed-off-by: Shih-Yuan Lee <fourdollars@debian.org>
---
 drivers/input/keyboard/applespi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
index b5ff71cd5a70..3bdb9e7cfb8b 100644
--- a/drivers/input/keyboard/applespi.c
+++ b/drivers/input/keyboard/applespi.c
@@ -1822,6 +1822,8 @@ static void applespi_remove(struct spi_device *spi)
 
 	applespi_drain_reads(applespi);
 
+	cancel_work_sync(&applespi->work);
+
 	debugfs_remove_recursive(applespi->debugfs_root);
 }
 
-- 
2.39.5

