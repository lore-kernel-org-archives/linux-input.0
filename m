Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9E370AD6
	for <linux-input@vger.kernel.org>; Tue,  7 Jul 2026 14:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436034; cv=none; b=pTYE+NzC+LWmzYceokVz4e9ZSu8M9DCpjKsluFICwEcxHIKGHVJGDggKbdxoY18PEjkl3ZLDlmrpRSExZBK3Igq5MZQdtZOtHVA32yzxz5Ve3opBr1of8Ge0bZu8hdJm5anENh6hBl5DiNzJ6jrDuWVRN8eYGOBJs0DO+kdJcxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436034; c=relaxed/simple;
	bh=lld4jGgxU4Hlbg9rvCRAmSf1xq4K+TvfNOTHD6OlPNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gTOyxldPv2a05gsg+joJmWsumwHw3EO8eCB+ToxuZKZkLD0pQWsi7Wdt/rE7kXBRwbTC9Tp+hiXTp/YY75WxMXQG0Raj0g9KrsHkcSnMPQzKum8e0VdUDMxIeVAe/RKWTSIc4/0U7YfKXzBIvfjeHEEIVc60O5DX7LoxeiKRd1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CKMUVPBj; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CKMUVPBj"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so30006455e9.0
        for <linux-input@vger.kernel.org>; Tue, 07 Jul 2026 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783436029; x=1784040829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RiCOHMt+5LAxuaUpE48p7KSrrHt8xlEb8cavqElM1eA=;
        b=CKMUVPBj07i/NxhSQQgg2eeYEj8iWjIXqCI4JQfLlTlFmu1FUjgoyiurI/DEN7wGK5
         YqvxpjwxPquH+0BqRipb5JC/9l78fTAmd4fOoaaH+ZTUa0MWk4ycLAOLfF5QbOC+zLDz
         4AUHp2hWHt81Q2gHIJqh1ikXPMiLU2hb6c1M3qstFbsG4hHXNpvjgOJw4jiWtIi2Q2Jy
         HvQYxCUG6kc2cE0Uk8xMVeis8hTrbxtI2qNflfnNOQiGpAI9YQqZTcdgJ/+7H9jcOqsQ
         N/EyQY2ANBadKhsiB5tesRl2kUTIfjBut3zpcG8mJQEiKiFd41HNQPCbhm8zDpImOGpD
         qTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783436029; x=1784040829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RiCOHMt+5LAxuaUpE48p7KSrrHt8xlEb8cavqElM1eA=;
        b=RdVFLaBro5cRGeN+UAy62sqC0ifivvMpyyQzZ7Jdoi9NLXzlSDSbR9DYZLCDKDP3vc
         fAdhRHWlmU4o6tbMIoGEXF80iismb8n3cpFs/VoHQsfl8NCJ86WUndYMnEYoG9wmltrU
         MhCvbRUGqqXtxYdFn3aa2DdPnMtTbIIkVltBGZmIZzZPzCl4LF0gz/G9/5T5lKLRm4AQ
         +P9g/k7dlRY+5rXuqh7lxYhDAffGFrNIG8gDWsSMCc7VIbpbOICLv6cDc4bPAtAYUaeJ
         gv8MoKTgqnLM6H+S5BqYtIPFOoCH4/runx7TK4v1/lllzbymbCCIGjR88xy3WWsSPo5E
         OU2A==
X-Forwarded-Encrypted: i=1; AHgh+RqPf5BJGNgYsrCvzyxoku60Q6vxxBXw/i0H23pwlDiRoyNMPIdbkDQ1UyfD6XlqC0mwN+wwzGYO4c1lzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv7CaF/hMnq0afmBu4lbDBKOjiVTXJ4vmjdgdhaXGbGNw123Lf
	xHOW6OHB+iI6ccCs91QOJ6JFvtrbNbtV2QCyK5+TmLN4gOw63LlKGslUXqYg4ICMsNo=
X-Gm-Gg: AfdE7cnBehvUkwylyi9ubMCMH+Cbaq4R6LPehIXvXcrn/zwUcOI8CivOZcRJV001Ib4
	hiKchGD1K9gyoCzyiUsJPiloriOnNdJTNr4PLdF4xa/p5hKBBAwX02jZagq1MBhv3+BeWA64NmB
	qSJp+qk11rGUuOZNwoPqQNsxEggLyAtPLbkF/isiLGpyGogeDV+9ekHo2W3p93bQX8tE5SbRLQK
	7x+6JnwRZydT+VDorrDWSfrtiSAqAjWDiRN0UZfS1J7ILR52O+Hesqae0Jta9RBq/MrnC9tPh19
	vFFzLueB0snAXYZ3vSHehB8GfWjEhOCLZkdTgcQx7e3dGv4dRt2s/K8ziePo8H6/4W6TUoBsLjU
	8/BIDd1jVK654Tx1USa5vR628tsUNVI2GVbT6nhFvp8mIOT96GSsXKgvnSTfjykfPGfUqhBLaNE
	pEK5ffF/HzWDi6wBRvr3z0UHNvRUbRamJPVH0=
X-Received: by 2002:a05:600c:4e8e:b0:493:c194:4e7a with SMTP id 5b1f17b1804b1-493df0377e0mr57163165e9.3.1783436028465;
        Tue, 07 Jul 2026 07:53:48 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e10af550sm60425025e9.1.2026.07.07.07.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 07:53:48 -0700 (PDT)
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
	Benjamin Tissoires <bentiss@kernel.org>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>
Subject: [PATCH RFC 1/2] HID: hid-oxp: Replace system_wq with system_dfl_wq
Date: Tue,  7 Jul 2026 16:53:02 +0200
Message-ID: <20260707145327.313292-2-marco.crivellari@suse.com>
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

The function end up calling __queue_delayed_work(), which set a global
timer that could fire anywhere, enqueuing the work where the timer fired.

Unbound works could benefit from scheduler task placement, to optimize
performance and power consumption.

Since the workqueue work doesn't rely on per-cpu variables, there is no
obvious reason that justify the use of a per-cpu workqueue. So change the
workqueue with the new unbound version, system_dfl_wq.

Cc: Derek J. Clark <derekjohn.clark@gmail.com>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/hid/hid-oxp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-oxp.c b/drivers/hid/hid-oxp.c
index 20a54f337220..d2ded6b08ce9 100644
--- a/drivers/hid/hid-oxp.c
+++ b/drivers/hid/hid-oxp.c
@@ -398,7 +398,7 @@ static int oxp_hid_raw_event_gen_2(struct hid_device *hdev,
 	 * Re-apply our settings after this has been received.
 	 */
 	if (data[3] == OXP_EFFECT_MONO_TRUE) {
-		mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
+		mod_delayed_work(system_dfl_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
 		return 0;
 	}
 
@@ -788,7 +788,7 @@ static ssize_t map_button_store(struct device *dev,
 	default:
 		return -EINVAL;
 	}
-	mod_delayed_work(system_wq, &drvdata.oxp_btn_queue, msecs_to_jiffies(50));
+	mod_delayed_work(system_dfl_wq, &drvdata.oxp_btn_queue, msecs_to_jiffies(50));
 	return count;
 }
 
@@ -1349,7 +1349,7 @@ static void oxp_rgb_brightness_set(struct led_classdev *led_cdev,
 				   enum led_brightness brightness)
 {
 	led_cdev->brightness = brightness;
-	mod_delayed_work(system_wq, &drvdata.oxp_rgb_queue, msecs_to_jiffies(50));
+	mod_delayed_work(system_dfl_wq, &drvdata.oxp_rgb_queue, msecs_to_jiffies(50));
 }
 
 static struct attribute *oxp_rgb_attrs[] = {
@@ -1502,7 +1502,7 @@ static int oxp_cfg_probe(struct hid_device *hdev, u16 up)
 	drvdata.rumble_intensity = 5;
 
 	INIT_DELAYED_WORK(&drvdata.oxp_mcu_init, oxp_mcu_init_fn);
-	mod_delayed_work(system_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
+	mod_delayed_work(system_dfl_wq, &drvdata.oxp_mcu_init, msecs_to_jiffies(50));
 
 	ret = devm_device_add_group(&hdev->dev, &oxp_cfg_attrs_group);
 	if (ret)
-- 
2.54.0

