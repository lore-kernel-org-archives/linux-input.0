Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DDC283C93
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784542491; cv=none; b=sSQXIK1eagXBnZf7zASTFyShvNrzOvNYcRTtAJoenoBTFF+D7QyZKM5nSI+LkuCgzFQDWnlyV0FmDnYjUahMeOYo7xZGoz6UKVeJlW3ZDVBnAHnQLFmvkWpJTz2JiOBRalid0BGTgAuVRnd6nOS90vj76MUqxg3STxTAHVCAbNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784542491; c=relaxed/simple;
	bh=c7stYBGDTiMxAAyVPwsitkZNDJvZL6GV9gusqMZ+Axs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X1M8jpZS0jlbpdeq9eVtlt4OJfaa3Kxc/2jNlR8gSR/CHVPjSYg1lc12MbPGrMPWWdVtOND3hP/8g28CbgWmzsPc+e7JSGS3HnTc5OdL6+zB701jCSRrMduugpNMGB+nKS8itH01f6A1S3q4GUCQtqWjIKeXND3ZFE6MDTVgaAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso10803414b3a.2
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 03:14:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784542481; x=1785147281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SuMKE1uWiwj902HlgiIkBhdF1y5a/vGWxiJr/uifbSs=;
        b=cmAjqKFghM/fBtN6p00EY35TIbFquOh8bEpv4EMduY3be+SkVWK59xbK8zSBb8Sg28
         wOx2iiRhzsW6nJkvx+nP2NTAnsxx386tJ5cmobARsmvM3GA/nBX8oeFuvHhK9LJdT5e3
         jBK4mniF8k8ZQVScz+KE4f0DsmiLW6b9/dWZKGjbXO7/yaQVT3Ud4Pp5IO5FlnfDIEql
         wNGgx9V/3fgYtakR6llZkOrygg9QUwc9WXzZc16i0uhi3hrLnt5CWTk3JwgM/hXtV3tQ
         GRzexkj/vpFoFFxWBSiIUTL0EDge4zSdvVJXQC1DWN/yYUUA1PdoQQQngy5d8g3QRXYm
         a2Hg==
X-Forwarded-Encrypted: i=1; AHgh+RoxwHEmNXfzxyeotAB1NgeC09WMTPPfRmbLaA6u71kE2NBni2LDyB1eQjBQqAOrCO106sigM+wCXrtacA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yze7/kvw9AIS53yvgVRdLjIEm5G53w+ubrXpI19Rzc3hQINAh7r
	Bcz3XnBr3v6Yk249wbkrUBmFLD/NN0lCZurWDsL42Ll5aDEnFic7vak=
X-Gm-Gg: AfdE7ckwU6xsivCf/gxt03Ttzdgx4FSRs0VTb2XY99FF78OBloeVc4ABPHgN/cXHM9W
	aKKMYbmKYXZhmlLTuWtCT8Z4Lf22QtsGX2AOMuftgLeT5yjCHg/w6an67yBoxPd7hZ5WgjAvAHg
	N6H8kKNro14g+BT3F3nSDJQDs10dlpoofbFt8FfFJcR6jmf4DrOrOKshrNSsiJ/jIvt6g6ed/Kh
	+0dxiKHvGqm1nzv5wusgxrPIOOvVkbgdslfLMsn5yShd2nOTdUCOjUXr+HjvwxrdvEusC076QAV
	9rFLrzrDYOVEW00hJcTodZOpSZNZ/r9lFJ778Krn4rfXFqxQYPoq4NUcLGuf9VsQoxnGEdQJMwi
	4GaFxNcceoTD/jA8gzoeFVzwu80PUIIvkGn2LQuurLpj3VGSBNl1lhnWU+99/DEPnZQJcNE3W1w
	e+KqwwQBUIXEMkasmdHFj4AcNZSc8xaHgNC2tOYW0XsHTwmi7GuyXneWEnqZKS23limLymcTscS
	J83xYcVJVoK3hgWog==
X-Received: by 2002:a05:6a00:94e8:b0:845:4928:8655 with SMTP id d2e1a72fcca58-84c294d0b5amr13409476b3a.39.1784542480867;
        Mon, 20 Jul 2026 03:14:40 -0700 (PDT)
Received: from penguin.tail0a1999.ts.net (61-228-16-100.dynamic-ip.hinet.net. [61.228.16.100])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cb517f94c31sm4411321a12.13.2026.07.20.03.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 03:14:40 -0700 (PDT)
From: Shih-Yuan Lee <fourdollars@debian.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shih-Yuan Lee <fourdollars@debian.org>
Subject: [PATCH v2 0/5] Input: applespi - Fix probe timeout and use-after-free bugs
Date: Mon, 20 Jul 2026 18:14:30 +0800
Message-Id: <20260720101435.13612-1-fourdollars@debian.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series simplifies the applespi driver by making touchpad
detection and registration synchronous during probe, and fixes a
use-after-free bug in applespi_remove().

Changes since v1:
- Split the large touchpad registration patch into 4 distinct, single-purpose
  commits (wait queue consolidation & timeouts, async queue slots tracking,
  synchronous registration, and async probe preference) for better readability.
- Fixed a self-deadlock in applespi_async() where it attempted to acquire
  cmd_msg_lock while already held by applespi_notify() and other callers.
- Updated applespi_async() to assert the lock is held by the caller.
- Protected touchpad info flags under cmd_msg_lock in response handling.
- Simplified applespi_tp_dim_open() by removing redundant NULL checks.
- Overhauled GPE disabling and teardown order in applespi_remove() to prevent
  GPE interrupt storms and unbind deadlocks.
- Addressed reviewer feedback from Sashiko.

Shih-Yuan Lee (5):
  Input: applespi - use unified wait queue with timeouts for drain
  Input: applespi - track asynchronous SPI transfers in flight
  Input: applespi - register touchpad synchronously in probe
  Input: applespi - prefer asynchronous driver probing
  Input: applespi - fix use-after-free in applespi_remove()

 drivers/input/keyboard/applespi.c | 175 ++++++++++++++++++++++++------
 1 file changed, 140 insertions(+), 35 deletions(-)

-- 
2.39.5
