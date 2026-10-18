Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476F938F639
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792318424; cv=none; b=K/w/SA6GKxbcEXsLneA/48m6/27JMS8QFMjMDSp5BI8vdLdk+9pRlUiCvYiI1ijQTUvuqrCjbI1OcMjb6HyeenGTPJ+t3RdTanU6Z6bMOSpF1/Zxiddn1xzBKBYVPbw6JxGmneUVL6YBPzqJ/RE9+SoorqKWbbYBnsGL26VEy/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792318424; c=relaxed/simple;
	bh=Um5la9q9xZ3y69EgjeoKr9fw+rbLpYHSq90twHQdDrk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XggieJzrP4kLUpql0h6H1W+BKpPJ13RvSwGKjQEJm13cRd8wjyi0LzyvW/+tsSoF4NlQvDuOIYz87hALeNDzS0jQkGFpMCnkasIX6WuxD1h2XZIlsqxj+wfhz0chSmakZZpzPcbQa5MDvcvDhExtXfK1nXJWt5JJF9q0D23U9ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DJ26zKMZ; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DJ26zKMZ"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3a0aaa0fd13so1191402a91.2
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 03:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792318418; x=1792923218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwVVGv7Ypjc6OhBGHWkusgpjgoIKhERu3f/aqggLBqg=;
        b=DJ26zKMZ/5JZyxIZ3uALFK6MaczlP51dwUO+o64F3pVJs3BSIy5I8pvU5EzD2irLPL
         zwHqgiFINrNh7AR5xFZq1ubYjoHrzbC1kjc450SPGiIJtKr5eqUWww/PnwYk4UBAHHuA
         I0vETsuihIaf1XcKfznSfj5+wEbg72n6F8jSwGtD7pfHFubxranrX9xF06BKvjP07eGB
         LD1sSqk8NvbbG7ahAwNlpJPt7+9WzWgJFTj4OGQqSGHmyEs+rs8LvLcg9VnrZnQniQOg
         sgEi68qwMyUyAQ8znIbANyF6oug65R/15rwm+aJnF9nEXUnM9crOUFXodRLIog4Ggp+Z
         MH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792318418; x=1792923218;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwVVGv7Ypjc6OhBGHWkusgpjgoIKhERu3f/aqggLBqg=;
        b=ujmxW0Hwj3lx/embOGnKqYw2lMmiJzaYm3GGPiZYYmvdyUIhEyRtnndWQ0kOVocuOA
         KsdjpVHqkHComnVqIOqiZZpQFF1rT6vi3gIbcC1Sls00K7B0NCtFY1tjv49NUeA+FrnT
         y5UHqBRQpPYW5Q3CijKayMSTwY+5nlh/XVR12+QDpFpGsB5Jbi2EITeoH8AX+fUWvJmf
         r+unLrE5EGIa91kzw/Q3SRP/TI0r7AEf+kBR0sSvMgberwTT/hLGLnxi+pYWtjMp4CX3
         JwuG8iJiXQ7CWfRr6ELYup50WyVaEJzN2LNN0JZYf/T8TzdMuIclOO/hxm0N2cwfV+cu
         b1nQ==
X-Gm-Message-State: AFq9FYI8wAhH3Qp6SE5aTRnzs0yE06RZu6ac44yOX4Q0sCS4TdJUNUzD
	yl98HJdolMvUy+N49uh1LUq9Lf7L33e8R7tStZoB7C9TrT+ECRtoPvW+qOM/UbXY
X-Gm-Gg: AYBFou2OXoyIQYGMamBfvWXLtgYmvw3P/7bUV8cyiiDwhFLQ8NnhNJ0nHK4PTCY5Adj
	h5vX+yXSmYeMCSiG2JnURMBzIAt5ndX344CxjsC4r7gdLOrovSyOUl/2F/vqPJB3+ldcM0uzEuZ
	O3tuNANOFEUNYJzi9Awv/seJeEUPOkA4/dLBVS7Hy1xdW415Du3LqGuWmCNyN3rVc2YwcwU6lbu
	2JZ5FviIzxlTn85+D8fyzyoDa1WFbYyl4vb6Nh/yd6JBISH5F8DpkqpGZClrxebzcGs8W5G0HHp
	BEgUanmMMBInI1qkV8MMsVZc+J15iYxEv7G1+cB4cuhed8MeYKyNBda93Rkyl7pXakrAW3u8Ny3
	rl8jbu+YJonWK3sB7bxqZRU7AmDr9znBLrWNAMEgEUGlLT+Uhl2rIIflL76CXv4zF77l5RM7Y/K
	NOmdILKib55O6NTMiGeAGjNkH1wmF/D6SB93wx4e6pTKMPk/0nItmFrcw2knrDko5ynrTi5Od3U
	AnsM5usnFoqxL1Mv2nWFtQIIn3he3M8AmZMZC3tmvhKr2N3BQ==
X-Received: by 2002:a17:90b:224e:b0:3ab:884b:65a9 with SMTP id 98e67ed59e1d1-3aceebf67eamr4308680a91.25.1792318418481;
        Sun, 18 Oct 2026 03:13:38 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net ([2401:7400:c804:b668:a144:150d:733a:5ba2])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3acc48e8646sm10798142a91.10.2026.10.18.03.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 03:13:37 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: linux-input@vger.kernel.org
Cc: Ho Jie Feng <hjf3108@gmail.com>,
	Basavaraj Natikar <basavaraj.natikar@amd.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] HID: amd-sfh: Use shared interrupts
Date: Sun, 18 Oct 2026 18:04:06 +0800
Message-ID: <20261018100406.44560-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AMD SFH driver requests interrupts without IRQF_SHARED.
This can cause VFIO PCI passthrough initialization to fail
when a passed-through device shares the interrupt with AMD MP2.

Request the interrupt with IRQF_SHARED and check if any flags
are cleared before acknowledging an interrupt.

Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
 drivers/hid/amd-sfh-hid/amd_sfh_common.h |  6 +++---
 drivers/hid/amd-sfh-hid/amd_sfh_pcie.c   | 18 ++++++++++++------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_common.h b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
index e8cc7f1d289cc..4481a50359de6 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_common.h
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_common.h
@@ -85,7 +85,7 @@ struct amd_mp2_ops {
 	void (*stop)(struct amd_mp2_dev *privdata, u16 sensor_idx);
 	void (*stop_all)(struct amd_mp2_dev *privdata);
 	int (*response)(struct amd_mp2_dev *mp2, u8 sid, u32 sensor_sts);
-	void (*clear_intr)(struct amd_mp2_dev *privdata);
+	bool (*clear_intr)(struct amd_mp2_dev *privdata);
 	int (*init_intr)(struct amd_mp2_dev *privdata);
 	int (*discovery_status)(struct amd_mp2_dev *privdata);
 	void (*suspend)(struct amd_mp2_dev *mp2);
@@ -100,9 +100,9 @@ struct amd_mp2_ops {
 
 void amd_sfh_work(struct work_struct *work);
 void amd_sfh_work_buffer(struct work_struct *work);
-void amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata);
+bool amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata);
 int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata);
-void amd_sfh_clear_intr(struct amd_mp2_dev *privdata);
+bool amd_sfh_clear_intr(struct amd_mp2_dev *privdata);
 int amd_sfh_irq_init(struct amd_mp2_dev *privdata);
 
 static inline u64 amd_get_c2p_val(struct amd_mp2_dev *mp2, u32 idx)
diff --git a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
index b3cb13b8c5e87..f48a096a6d2bc 100644
--- a/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
+++ b/drivers/hid/amd-sfh-hid/amd_sfh_pcie.c
@@ -103,25 +103,31 @@ static void amd_stop_all_sensor_v2(struct amd_mp2_dev *privdata)
 	writel(cmd_base.ul, privdata->mmio + AMD_C2P_MSG0);
 }
 
-void amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata)
+bool amd_sfh_clear_intr_v2(struct amd_mp2_dev *privdata)
 {
 	if (readl(privdata->mmio + amd_get_p2c_val(privdata, 4))) {
 		writel(0, privdata->mmio + amd_get_p2c_val(privdata, 4));
 		writel(0xf, privdata->mmio + amd_get_p2c_val(privdata, 5));
+		return true;
 	}
+
+	return false;
 }
 
-void amd_sfh_clear_intr(struct amd_mp2_dev *privdata)
+bool amd_sfh_clear_intr(struct amd_mp2_dev *privdata)
 {
 	if (privdata->mp2_ops->clear_intr)
-		privdata->mp2_ops->clear_intr(privdata);
+		return privdata->mp2_ops->clear_intr(privdata);
+
+	return false;
 }
 
 static irqreturn_t amd_sfh_irq_handler(int irq, void *data)
 {
-	amd_sfh_clear_intr(data);
+	if (amd_sfh_clear_intr(data))
+		return IRQ_HANDLED;
 
-	return IRQ_HANDLED;
+	return IRQ_NONE;
 }
 
 int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
@@ -129,7 +135,7 @@ int amd_sfh_irq_init_v2(struct amd_mp2_dev *privdata)
 	pcim_intx(privdata->pdev, true);
 
 	return devm_request_irq(&privdata->pdev->dev, privdata->pdev->irq,
-				amd_sfh_irq_handler, 0, DRIVER_NAME, privdata);
+				amd_sfh_irq_handler, IRQF_SHARED, DRIVER_NAME, privdata);
 }
 
 static int amd_sfh_dis_sts_v2(struct amd_mp2_dev *privdata)

base-commit: ae6927c533a4454570950125ca8ba909c45f20f9
-- 
2.55.0

