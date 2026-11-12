Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794466244;
	b=FH9uM3r/5VY7XkFhNzCATQLOy5VdGHAETtEtlCeM3BKhCuafsKm9MhbVubZ0+/GvskZw
	 ytYbJvzMuck9nyqq4mk+c86jADi6GcvIIo08wLMPnnUDNwr6PgQxiAimFT0ZUXaiHNLCc
	 Xzut18kQWMXMjg2NtA8lt7Dn5RVQnjgykudZCUhZOkNl+Z22LEf7tL43/zWhF6qHxT2QD
	 syosrhknnwsFFRApssfL8mQIKQcppZXbN3nbVTR6fAbnc9gm9NNht932q+D8S1bFmYQDD
	 sZ9nt0jDiV3Zdn6i3SRwkfgb25tBotLmcNxaSV6qEH4fN5qqHMXtb7RBAukBixKfEvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794466244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iEBOkObUh/AxvYQxzQbYn4+DPmNA3eLC0/205PmvV2k=;
	b=Eu9DoPnrNcIgvi/X7zRofVbkHZRe0S4+j19kJNCuecJ8QhQEmXzFZrY5otBDLV298wnj
	 XxA6q/iXacwEuvzWjXOIcNqihuix/7hEi2LvH0CI55n/Tyw/sS4qlw3D2mPndp3MqWaSa
	 f+lYUjTDQteXU/vH0Fi+W3oT4caSLMlarJ7XZoOi3Hkb4Ik6sDAij0Nvyx46RHyP4ELsL
	 37jnkSvoZ6Gqe6Q8Q2tpdvfqZeL5s9ATuVd+3vZanKJPyPeSvcSe5SylFQc7ByYThLD5m
	 243x/zoAfD9Y9doO/ODwSkuCto5KjiKL0DxUIX2g1bW8PFGCnIEdJUH1T5auTNPvbwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RASHtTpU;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C22960A2639
	for <linux-input@vger.kernel.org>; Thu, 12 Nov 2026 06:50:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C22960A2639
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RASHtTpU
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3b094e649d3so2308671a91.0
        for <linux-input@vger.kernel.org>; Wed, 11 Nov 2026 22:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794466244; x=1795071044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iEBOkObUh/AxvYQxzQbYn4+DPmNA3eLC0/205PmvV2k=;
        b=RASHtTpUa6G3Vjd5SL01RtOojB+8z2ad/x7Fwc1rhK+x6p4zOrdGvGJfk/SgLDH5Bt
         tpyA4BfsftJjostyJ7+zKifD2K1hAJlYwXqK6dQE69sBprIi9px5cd16i7tGRWMU9pWz
         +whOqNUkqPfg96EMCNLXR2g7qj5I6W93rKdt9UvCU8Kfp3P2yLi6it7ZSSlAuBAB3fSl
         PRF686aEDeZ+Poig7xV5ccCA7VazDt9LKus2CJNFpstgiqyjDvCzD3JXM2L4LzK/2awb
         tHkEiSiRgSioKpI64uOg6Q+VoMdZ4VtSRIPNzEnZhworbUHUtqgBWNTEI9opIBPyDGEE
         kEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794466244; x=1795071044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iEBOkObUh/AxvYQxzQbYn4+DPmNA3eLC0/205PmvV2k=;
        b=mD9jSEFf/pP0l7Vwr/2kHKpCLJN1sg1ielFGml/ihd5fqoTVt8SmLOxhQ91/Kcv19D
         gv2XN9980V9/s7nNDcOCa5GB6IK1luqNWKv7x6LI6rQkL3ApE7N7JqmoWy9W5afQpmRh
         5YVlX46x8MGJHRe9TrWpX40ZPfZvtmX0koXArA6gGWqOIQKvvo+dLSA9bWVrLBKKzVR9
         jRRzDv4VOm+ZjQWKcB8/fWeCBJY/V0pzIzuQ1ZslUDw7SYrqdhYm7QWoLYjDmHrpSeVy
         f7DL5OX47VWz3tcHDd3mAk5Z1WWDOp7dcCt6neblPrrlBBdMaZZ/5lncYT3cWKiXwIGn
         POxw==
X-Forwarded-Encrypted: i=1; AL+hErF8fNNQezBT3/sAEgrTMvVFbg8IlG5Ok8kX5bMPFl/+4szh2mzCyWsuvZ6pigI1z5Cg5T+K3oGukbvwOA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9v0e7XN+KBgIa5v9JHUTIvNru+vJExwHf39KTa/RkjvV07rmjH
	B7SQH0UUQlhpHn0WmG2eGXSObkLmiddvb15tt68gE09+K6T0WT0c8gaI
X-Gm-Gg: AYBFou1W5CAOPz77PeAXbzd+qCjuaO9aEvTBLgOzGAkwavcST93liVKKiQjG5VXUsNJ
	pey4gfgHVWAfAvny1wemFSyBTWFadbQ3LrDwhi8sESE7SovLgcW6IOnMNumntxftqw5o56nF8aE
	V++w70s4B84H9KKBr/pwixMRh2HcKCtrrh4QdAxvrrD6quyiif5xJBaNw/fONHuv+lX9uGC7Q9J
	yfWxJxTV2rBkuwP94T5Mtm/iuIGyFvA+pxRtoSZdUfCsofvDCssZfZ4Zl05U4ib1qlFgxjuVLdC
	Rqd+Z1/ka9r8DlbINdDZ+dfBsmybbvU/6WckRWDSCKOgmjvXyIjHe4AMwIGz0xofXu/cOlPWBhi
	UrTDXLmFZTWhqDj5uTv8M0wbRDjghnezvC4DTaYOUSM0Ry40mr7P3nSTLm1USKBlYdC3zQixS5g
	M6HqVK9vpiMDuQ9lblJOiLh15Y3l446SIdB88p94TgNcxZblTbiOATDBqL41wa99ABK5TC1XVu0
	p1YCI3uIe/XCxCkcEziFZp8bM2OvpDAKfCwK6Y/k3dcoF8m5K3+lT6YJ7Hf2mVmi+E/stDzILUl
	B7a5ftQvoWHWZi1lo0p9QsACHDOuy4sLaOG/SW5I+AGVaOtfoPEOarxtr6nvGibSz9Y8qrFG5UR
	/7QoK89yPOV7UMKlz
X-Received: by 2002:a17:90b:4ecc:b0:3ac:a521:959 with SMTP id 98e67ed59e1d1-3b182edaefemr4410200a91.29.1794466243863;
        Wed, 11 Nov 2026 22:50:43 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:182d:659:ffce:39a4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197c8aae8sm3073297a91.14.2026.11.11.22.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:50:43 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Andreas Kemnade <andreas@kemnade.info>,
	Johannes Kirchmair <johannes.kirchmair@skidata.com>,
	Yuki Horii <yuuki198708@gmail.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	linux-input@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] Input: tsc2007 - remove unneeded memory barriers
Date: Wed, 11 Nov 2026 22:50:34 -0800
Message-ID: <20261112065037.1800467-3-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
References: <20261112065037.1800467-1-dmitry.torokhov@gmail.com>
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

The driver invokes mb() after setting the stopped flag in tsc2007_stop()
and tsc2007_open(). These mandatory barriers lack pairing barriers on
the reader side and are unnecessary.

The wait queue operations wake_up() and wait_event_timeout(), along
with disable_irq() and enable_irq(), already provide the required
synchronization and memory ordering when stopping and starting the
touchscreen worker thread. Remove the redundant barriers.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tsc2007_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007_core.c b/drivers/input/touchscreen/tsc2007_core.c
index b3c4c0c9c42d..51e4d985afcc 100644
--- a/drivers/input/touchscreen/tsc2007_core.c
+++ b/drivers/input/touchscreen/tsc2007_core.c
@@ -171,7 +171,6 @@ static irqreturn_t tsc2007_soft_irq(int irq, void *handle)
 static void tsc2007_stop(struct tsc2007 *ts)
 {
 	ts->stopped = true;
-	mb();
 	wake_up(&ts->wait);
 
 	if (ts->irq)
@@ -184,7 +183,6 @@ static int tsc2007_open(struct input_dev *input_dev)
 	int err;
 
 	ts->stopped = false;
-	mb();
 
 	if (ts->irq)
 		enable_irq(ts->irq);
-- 
2.56.0.567.gdb80ae8cd5-goog

