Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83E36A36B
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436034; cv=none; b=iGdOQfXyr3/TLgiXvPoZRPOdL8mjBiB17AS/2PEJg2l2sBY85wxO5e1bMyxfKsZtryRzolk7fKwUP1bX4wHeqImHhbfSLTXQ5LwOf6fLaot3rUzTvwCv/n7GHWmoR26DEFlOhSYeXbRaQtKQ2MxVrsakFygrxtrJjDOLwc+F9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436034; c=relaxed/simple;
	bh=pX2TimW5v6Qj7a5oYWCVjyPbM4B36Q3dDcYe5sGR7KA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EexzBUnlClGrHp4aOECeuSM+Ty+JI+GGX90m3YN8o9SXIfNJRvXZT4gJs2+1tW7+OeBAc0Ib6kpKWdKyNS2YcTs//69kUslvfcBa3HHCIAhBDIuHSzQTLmEff1NKuhLb++PDbm+Ln0VDJ88EZBj592MIfrcg2/K05m/bQgJX9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bdyjhg0x; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bdyjhg0x"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-475cb71a4ebso4338212f8f.0
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2026 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783436029; x=1784040829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ev6RUIj+xitJEV4aPgTHTZOjmqQHTKeTmeEw+FhXfnk=;
        b=bdyjhg0xPNy1wyxFfwT6ZWbwrJ3nlKuXCAR8llKUDOsAPMupdkvMD1kxST4FggaKwt
         hT9pl3g2Ky0Yj20dlocrsMXYQVo/rjoGHcLO23oUXM9+Gb2msLBF5bltJR7uyaIHC0G+
         Bp6ncEJwzyv1+1yZ+mcwfzLEJhTVVh7O3cyRQ/xeHl+fQA+RgHDSJgAPevjDbhRIv5Cq
         HD/+uCH5v1uzNgzDxzefxYT9vhytukxPmszjBOoMRz/9cPVnNVvjT0eqHFVPp68+Dkk9
         TxYh3TiRc3W4ANWpMQ9rE2zHD91gZmfADwkhbuK7iae3PQmFxt2l7gf6U8qbjGvPBcFQ
         XoOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436029; x=1784040829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ev6RUIj+xitJEV4aPgTHTZOjmqQHTKeTmeEw+FhXfnk=;
        b=rNZDSJBpiQ48wtD7F8AgMy2u9Fo0dWZ5shuHiXCjIZDpN+CtuznfB9yqr3KQgNzRXI
         B5k2MKg52ntVd4sy0GY9gnqlfY2W9u8HpFOqNLNQTEVm6teVS3FUdZljGo+YrqRGUO2t
         B1QCv54aSPnLGtG+wlY9cnL3jqC2R9wN7RuEw5iVR5Sas0DBQ1GfVugpZFIMSNloU3kJ
         ssDVKMFEDjPwmsWjM9Pt4jPRSruIAdRLU6PhIu06Owh2ll5vMtv6BBNJd0Fe/meVwqDe
         HGaW47zs7+lAYjAUzD986h4GRHZcqIDAB6Q35Yod31BEgfKAkUumPa4PV6AWfCG8ktrt
         zxpg==
X-Forwarded-Encrypted: i=1; AHgh+RpWCs7TWhK37UkDFnNwQfyVzHL3dvgr4vv5EbZVVagnLUxzXyq8bZ62G1bU9rlH160OGnLLg3cM/cYWlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YywJCQHkAS6dJJYsQtbqwSMMlSEiDFFT1q+O9nuSG7ew7CDfrTA
	aAeJEvfD6YGxiU2Q/3CDVuRR7cXepx8O7u1dU+orF4Z570Q7SPV+ehy24YGtBU8XWHeOjZea/pp
	7fXCk/xk=
X-Gm-Gg: AfdE7clTy0AmNgextltvLwLGiPkOFAmjg1Ts2IqsKQHO7B58ZNHL2twIQ76IBO1HC0T
	EpyZBt4LvlpkzeceLCkUrIvdTmELUOz1LbrnwbV4qWK7MuBwGRsXl9rcVtcEoFNC8oa59Cciyz2
	SIQIknb2SceI4TIPUdyIzL9W5C6qq86W1gcflivA3M61NvuFC5q4BRsudw6QbYEVlXsoQ57cqm4
	nuuj1PqqhkD5RWjr6JhE2IrM14WwS2ec3Dp8csE/1n6zbcBTB/A/1orQkTue/CvlZwaQlaVUS0T
	RSxcFCVLmeN1kZpr3vxZzLjd/cP10X+cHs9P2n5mqvuEWb5triMr0Te6ZMziRmaUP+BJqEwB2Qb
	MwB/7J+he5lrXkG8+LRv9UREc+ykXxtWG48dxlLUExoXNJqSjEnGGMnFme07NYaERm51/3+s2nl
	ua8xFDoazegvHjYqPZQU92ZNSnIspCvYO1fG2+IDObFld1vQ==
X-Received: by 2002:a05:600c:190d:b0:493:e4b2:5290 with SMTP id 5b1f17b1804b1-493e4b252bemr7683005e9.12.1783436029438;
        Tue, 07 Jul 2026 07:53:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e10af550sm60425025e9.1.2026.07.07.07.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:53:49 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Subject: [PATCH RFC 2/2] HID: appletb-kdb: Replace system_wq with system_dfl_wq
Date: Tue,  7 Jul 2026 16:53:03 +0200
Message-ID: <20260707145327.313292-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707145327.313292-1-marco.crivellari@suse.com>
References: <20260707145327.313292-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the code enqueue work items using mod_delayed_work(), using
system_wq, the old per-CPU Workqueue.

The function end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption.

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change the
workqueue with the new unbound version, system_dfl_wq.

Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/hid/hid-appletb-kbd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index 462010a75899..5cc27066f602 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -175,7 +175,7 @@ static void appletb_inactivity_work(struct work_struct *work)
 		if (!kbd->has_dimmed) {
 			backlight_device_set_brightness(kbd->backlight_dev, 1);
 			kbd->has_dimmed = true;
-			mod_delayed_work(system_wq, &kbd->inactivity_work,
+			mod_delayed_work(system_dfl_wq, &kbd->inactivity_work,
 					 secs_to_jiffies(appletb_tb_idle_timeout));
 		} else if (!kbd->has_turned_off) {
 			backlight_device_set_brightness(kbd->backlight_dev, 0);
@@ -201,7 +201,7 @@ static void reset_inactivity_timer(struct appletb_kbd *kbd)
 			kbd->has_turned_off = false;
 			schedule_work(&kbd->restore_brightness_work);
 		}
-		mod_delayed_work(system_wq, &kbd->inactivity_work,
+		mod_delayed_work(system_dfl_wq, &kbd->inactivity_work,
 				 secs_to_jiffies(appletb_tb_dim_timeout));
 	}
 }
@@ -423,7 +423,7 @@ static int appletb_kbd_probe(struct hid_device *hdev, const struct hid_device_id
 		INIT_DELAYED_WORK(&kbd->inactivity_work, appletb_inactivity_work);
 		INIT_WORK(&kbd->restore_brightness_work,
 			  appletb_restore_brightness_work);
-		mod_delayed_work(system_wq, &kbd->inactivity_work,
+		mod_delayed_work(system_dfl_wq, &kbd->inactivity_work,
 				 secs_to_jiffies(appletb_tb_dim_timeout));
 	}
 
-- 
2.54.0

