Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795438045;
	b=GJMStVhABbUC3mm5+ZdKPXzvtc0mLKvHr2B2FoORnQxuy22L8XUc69CZS//CmpmsfBSH
	 mCJLiwv5xfjJ2Z9n1kEXMOomCw81ap46bH33OzH3ArScQyRtCjeRCUL42S12+RbvwQXrn
	 8pwLNGKMJ6njv+24D0nPR+pvaTN92D3tZ99yg0hq0fNM/YJjpXv2dKIkHGmLQaphIG1Ly
	 x5xaK0d0WppiDBAvfdElfNhMgQurz2RUWyRkQwkcMtqIoiPzXvX02N/vEWXGuck/G6DE/
	 b4ua3pFx/jg237QZRhv5jtRaZ0QthOs/v00GGus0l0fuqfMz6v72N+8npKatCQOlkPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JLWRIyW6L3H78bd/BFlmj2ybIy9WVHoAXMpJ3dEd5x4=;
	b=Mdt9sGPxCN/FxCaCEzsbvVvM8au5kvwWZF08GKDwRLpnPhFptcWQxQybcWkeBHezL5Sb
	 rJJfLxR4hPg/++e7oQYZpoupfjxRKBltKXb5xntRm0ZW9jowsfy4kf/6r1aa5f6R5BchQ
	 5yB1/bjhQXASSmr5RAAXfCv8FfR8gxiT3waiS89JMDS8lFg3AerF+EuHKykZUdKM7JVTK
	 Pvvx6A/IHnPseyvtCQ7S5L9J17M1Mjsvm6osXVEcjqF8/Wu80xn4khXkIkTFRy6hkzeVc
	 yrzIGNCm+0coy807am/QQAGfykFpRy/I55ttbS5Ba2M83bI9LEDbVArajNQv7eYM7zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="DbwGP/cw";
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE6606A31F
	for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 12:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BDE6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DbwGP/cw
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cde1479f76fso1960386a12.0
        for <linux-input@vger.kernel.org>; Mon, 23 Nov 2026 04:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795438045; x=1796042845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JLWRIyW6L3H78bd/BFlmj2ybIy9WVHoAXMpJ3dEd5x4=;
        b=DbwGP/cwdpTOtGUruhFiB4Bmbuh2pxwLCoG+NMc7KVnrn5W8cxeooMpUbVXi4UvOi6
         hS5h6/P1Z59KqHBq7Ng0wA2hkJqtDssAYfcAkXL7UJycIZaImTndQpoyc+ZKGQbqJ9oz
         7RXaj8VKPYVwUW+V3RM91bTPIkbNnN7NbjE6FnRfs2Vzp7vxxyyMLDth2in5ckFdfbbE
         eC6Nuufo3B8NI9pxMF6q5PqWeCq/gWXUFCbq8MFeqFtXU+myIoCeWnRXitZKpiJTUbFN
         zPjU1+BFBmn6sI3GuLspEKKoFSsj9eX2fCFuHQowYFDZTf5b2bispBLdHQC3nFW3uZ2e
         apyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438045; x=1796042845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JLWRIyW6L3H78bd/BFlmj2ybIy9WVHoAXMpJ3dEd5x4=;
        b=2XCiVt2WCHyLKcXu9O6wNaPlBxDZ3zp3FnhtMTpKpaO6L52fbhp+81uxiZZjku+wGH
         FkHG3/Wtykrt5yDP0pMgJ/mYQcyxNS7YhALlHCreBLR1i6dhk3cT7YZ6/10Kh6G7w7PE
         wDDxxy+6pKqIywP/DGReTreVOWez6F3cuRtu2j54GGxLDQX5xgw9jTd0dj+1AKgQygB/
         q4QeUv8TAWNlxu0xitSTwI7SkQmtIhw9QIeXBTZ4W55RjIOgET8eKcHQF1GhaOqgieTJ
         mfYNmEp1MrHh59Mxj/FhbxcKakyy2vGvLL92f2JSruWklMH7fF/HOssNkSaBXSlRo+GB
         j9Bg==
X-Forwarded-Encrypted: i=1; AL+hErGM2ZUOtm5lvWP0cStdD56wr67VG6dZtYNGDkbGJrY1trD1obhkcyUMMIQ4xk+2FlodbFJSd7D0b68uKA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+Gn2qmYYa0Yi8vwGS73uplUfEQOOk9oEsgieK72+rqsPRwjFJr
	GkkmAV7uFVrQK5iZKSpR2HS92iid7d6qjbLQtQZRMeVrJ0y+EGaG7Rmw
X-Gm-Gg: AZFdTZcGFc5cbATNkGBdpH/xfrQOEJA7eW7aPSrUPIKnDcO93WhxunExLvM1Xd65nCs
	q1aTj11Rh1dFAkjdfbjL439ukucEW/S5ydwUoCscomp4lOzRisZHd7MJh2bOu9Rg4q+JOWDZvfQ
	yQGHXELcd3r3zJNf9s3H6d7AcmCiCGlscUPomdHNwGaQTw2VM7v+vzr1msJbg7LPxGgOHyndUnJ
	9ZSIfHp3hoGInl+F2ifOqsRijk/t33G0MY1ujmHEHPkPcgjYze75njGyVGSvlVeP6Nmx8iPk8BI
	RpqjRTsIcsgD88hIiM2mWowcaJJt+haMsPxBkgDPjRqFo79tPLpYQzFgKJwvaQuwkrA95gGx5XZ
	g9+h+oIjRN67zoEMUtVN6LKIwN9rfjySJ0udbFfdUHFBBEB2vSNKsEPfBerghc9hdmA4HK56Yb9
	gmGN+lSgcpi5VPuP7HKBCxciXRoS3L1m7WMV2Vo7UX+AO+HyL8BkUROSUsqYcIGZWA5YdcOTEs8
	yDTB+U3kjPqFdixk5M+f4lpTR9oPfqLrZobFOGJlMNI5hGCRuqcPDHKXV9zJJOuiXU/sXN9D0uO
	A3NqTP2Z+uMHyLHBPjdZY983ksWpJdb+yO3UaKvCfDrA4WaQYdU=
X-Received: by 2002:a17:902:e803:b0:2ef:effd:4606 with SMTP id d9443c01a7336-2f03efb019emr116976325ad.2.1795438044765;
        Mon, 23 Nov 2026 04:47:24 -0800 (PST)
Received: from gb05.tail50fddd.ts.net ([139.5.199.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0dc0f8sm51919435ad.27.2026.11.23.04.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 04:47:24 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Zhang Lixu <lixu.zhang@intel.com>,
	Zheng Shuhao <viennaoffh@gmail.com>,
	Arnav Kapoor <kapoorarnav43@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Subject: [PATCH v3] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Mon, 23 Nov 2026 18:17:15 +0530
Message-ID: <20261123124715.351511-1-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.56.1
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

In sensor_hub_remove(), spin_lock_irqsave(&data->lock, flags) is held
while calling device_for_each_child(), which iterates child devices via
klist_next() and acquires the driver core's &k->k_lock.

Because &data->lock is acquired in softirq context by
sensor_hub_raw_event() while &k->k_lock is acquired elsewhere with
softirqs enabled, nesting &k->k_lock under &data->lock triggers a
SOFTIRQ-safe -> SOFTIRQ-unsafe lockdep warning and risks an ABBA
deadlock between process context and softirq context.

Move spin_lock_irqsave()/spin_unlock_irqrestore() into
sensor_hub_finalize_pending_fn() and pass data through
device_for_each_child(), so &data->lock is only held while inspecting
and completing each child's pending state after klist_next() releases
&k->k_lock.

Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-data on remove")
Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6afddf21.a11fe2ad.1b4426.0003.GAE@google.com/T/
Suggested-by: Zheng Shuhao <viennaoffh@gmail.com>
Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
Changes in v3:
 - Actually pass 'data' instead of NULL to device_for_each_child()
   (missed in the v2 submission).
 - Drop the NULL platform_data guard since hid/for-next already checks
   dev_is_platform() and !hsdev.

Changes in v2:
 - Attempted to pass 'data' instead of NULL to device_for_each_child().

 drivers/hid/hid-sensor-hub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index e9d6eb3b3831..090e5a232efa 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -808,6 +808,8 @@ static int sensor_hub_probe(struct hid_device *hdev,
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev;
+	struct sensor_hub_data *sd = data;
+	unsigned long flags;
 
 	if (!dev_is_platform(dev))
 		return 0;
@@ -816,8 +818,10 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 	if (!hsdev)
 		return 0;
 
+	spin_lock_irqsave(&sd->lock, flags);
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
+	spin_unlock_irqrestore(&sd->lock, flags);
 
 	return 0;
 }
@@ -825,14 +829,11 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
-	unsigned long flags;
 
 	hid_dbg(hdev, " hardware removed\n");
 
-	spin_lock_irqsave(&data->lock, flags);
 	device_for_each_child(&hdev->dev, NULL,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
 
 	mfd_remove_devices(&hdev->dev);
 	/* Clients share one HID open; release it if references remain. */
-- 
2.56.1

