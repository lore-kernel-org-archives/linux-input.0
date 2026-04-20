Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7550B345CDA
	for <linux-input@vger.kernel.org>; Mon, 20 Apr 2026 05:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776662012; cv=none; b=eKyZTnjTbaVc93oFCng0ekwiQQQcWvlfG2YFxBtJu4Ny5isvx1IGhLwH2pyQNHRT8ck7Qx3yBdHZ1YYUUsdbqyPyhRiK4RdaMRt6B7bFraowff1DTrsLG7pJ9WHIkwymit1oRbiy+2YmQcHQPsSxaSSQ4+h1E9rFGce1d85GSO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776662012; c=relaxed/simple;
	bh=7L62x4gY/v3QQvwui5xxufG2Wru8DoRupfNvesncSmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F3yP2CJIp7Qhy2/Fxq9okrR0XxNNWO+RsQL7XBnxp/2/o1y7ktGEyTdL56tMDG8zVejUps/SBU8u0I811TS51u1OcEn5K01lWjYkw3xU/PMbRqbMvsMQ+JnrjWkWBIsO/Tn1iZSLj652ebQfZXnBNAcKwLedfJt7iQtUs9KMRvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=wd5kdikl; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="wd5kdikl"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d95017a68so1607942a91.3
        for <linux-input@vger.kernel.org>; Sun, 19 Apr 2026 22:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1776662011; x=1777266811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohv7AE5gLk0wYKHxc3xY7d0lJNWC0W185pFd5vo3VDQ=;
        b=wd5kdiklulS4htlDbk18hkwB7UEykoLGU44iIlGG4NNMsSNZLWb2W7QZG3IKm1OdE+
         HBMUgPDVUju7rfh/S5Ibm6+L86BlRX+T5GiMDIeW1M8bdAZxvYxMx9O4MAi7w3LABF8E
         Ve422CWRWDt7IQAFK1QvKkzYxNX16tIVT36gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776662011; x=1777266811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ohv7AE5gLk0wYKHxc3xY7d0lJNWC0W185pFd5vo3VDQ=;
        b=gtLQlqsCNHCYJ17+TfDBPQ5jrgGTdp6eLEWr6UXO0qUSukH2XHjtCJNC3AF5WnGeaY
         3farpMKJeQw8wrkBwzkCqezPNdLV1LaK8XqsN4cWZ0CDOFquenjCBuQgd9czr8RYsIKN
         ml2OHeSGh6eXekStU3obQ/y+VPkaYzmjhTZZh181AKp3nNK0hyf+IxyF5/GLDmudPyzx
         vlrflM4JvAqISt+yjNe9lKvXT4rX7EivoB2ovu5qbg109+lorUj42Jx4fl407Zmw0t3g
         N1aMDZNKM/eivDO7ru5qfZuIzVbjyWMSBSkdkd4CuCtEio3nsm8Lmt3jQyuGQqZ+MIiM
         AxQg==
X-Forwarded-Encrypted: i=1; AFNElJ/KFx0e4F0u+yJGzmNYizKICXESbMpSC8ee59+ZGizu9boWADwHCuTFWXkw5N/8ZJZHEyeP7N/SFuSLuA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM7THizIUgnGK6uccANiWaYf+Y+7twXHroRD15Yjrh70L/h9Wa
	xEDPYSUd7IjnhOXtnkvHJ0M79TfBtxTpm6h8v64chbaiWNTx1v8KcJRmwybqldhT3AA=
X-Gm-Gg: AeBDietZV2FFPlZWN34VsVylbgrBfA/9G5vjciNGFaMzxBaF0eHaLiQ9OI3vGzKfo0Y
	BEe2kqk3Q5ZCPEG6q6l9xzG9RPwi5FiXp5SYWJf9ngf5PM/s+qxaCHdAw0hEK9RmECdJKbzFVDS
	TTcM2gG/vOuFHS9oidc5ELl73ZfkLuNSsad0NNjLEiXt+fv2WRbhmVN4UGXb7WL3yLRzgXRHXrB
	eoCJEprUhCIV4wo647u5nz1o2n79zclXntOdE22HoMo9qvM0iykkr2cfR02HEVOo/v49b7JODJv
	z1+AOsDx7znDRKpheSj28qTuH1CrsJJK/mMevyhsTa7G43p9qIXsSSRW3rLUN5DRdSp630haeJ5
	bMi7dqez9i4k1G4SPMQzpxZWWwzd3WQze2jn/ZgW3EydZnPvjtoGr3qsnrVUUwFM+1oYdlCANA5
	R8e6BPpaLwgpHHlCbuXRt9vr5oW9RHiSXg1yb+C/Df/J7OCLqR5NG3gukGu65dpyUvSVO70w==
X-Received: by 2002:a17:90b:1d50:b0:35e:599f:aef0 with SMTP id 98e67ed59e1d1-361404254c0mr10472512a91.11.1776662010863;
        Sun, 19 Apr 2026 22:13:30 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614186a52csm11032591a91.4.2026.04.19.22.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 22:13:30 -0700 (PDT)
From: Sangyun Kim <sangyun.kim@snu.ac.kr>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: qasdev00@gmail.com,
	gargaditya08@live.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] HID: appletb-kbd: fix UAF and mutex-in-atomic in inactivity timer
Date: Mon, 20 Apr 2026 14:13:16 +0900
Message-Id: <20260420051318.1411671-1-sangyun.kim@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two defects in hid-appletb-kbd's inactivity
timer subsystem.  The two patches target different bugs and are
logically independent; they are sent together because they touch the
same tear-down code and because the same maintainer will review both.

Patch 1 fixes a slab use-after-free with two related tear-down windows
introduced by commit 38224c472a03 ("HID: appletb-kbd: fix slab
use-after-free bug in appletb_kbd_probe"):

  A) Within "if (kbd->backlight_dev)" the order was
     put_device() then timer_delete_sync().  A concurrent
     hid_appletb_bl unbind between those two calls can drop the last
     devm reference and free the backlight_device; the still-armed
     inactivity timer softirq then dereferences the freed object
     through backlight_device_set_brightness() -> mutex_lock(&ops_lock).

  B) The "if (kbd->backlight_dev)" block ran before
     hid_hw_close()/hid_hw_stop(), so even after window A is closed a
     late ".event" callback from the HID core (USB URB completion on
     real hardware) can arrive between timer_delete_sync() and
     put_device(), reach reset_inactivity_timer(), re-arm the timer
     via mod_timer(), and reopen the same UAF.

Both windows produce the same KASAN slab-use-after-free on the object
allocated by devm_backlight_device_register().  Patch 1 closes them
together by moving hid_hw_close()/hid_hw_stop() before the backlight
cleanup and, inside that cleanup block, calling timer_delete_sync()
before put_device().  Shipping both as one commit avoids leaving
stable kernels in a half-fixed state where only window A is closed.

Patch 2 fixes a separate "sleeping function called from invalid
context" bug in the same subsystem.  The inactivity timer is a
struct timer_list, so the callback runs in softirq context and calls
backlight_device_set_brightness() -> mutex_lock() from atomic
context; reset_inactivity_timer() has the same issue on the
brightness-restore path (it is called from appletb_kbd_hid_event()
and appletb_kbd_inp_event(), which run in softirq/IRQ context on
real USB hardware).  Convert the inactivity timer to a delayed_work
and defer the brightness-restore call to a dedicated work_struct so
both sleeping calls run in process context.

Sangyun Kim (2):
  HID: appletb-kbd: fix UAF in inactivity-timer cleanup path
  HID: appletb-kbd: run inactivity autodim from workqueues

 drivers/hid/hid-appletb-kbd.c | 56 ++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 20 deletions(-)

-- 
2.34.1

