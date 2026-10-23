Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792743514;
	b=ecY6F3l9g5CUQ/Hauoq9EqJ4iZH83PJmco/TL8bm04HavwhefzZJfISdSntrd58/qNIR
	 gWTGb0WR8JVicnkkVHrARieITj3k4vjEMqZO0kJFjbqS0GBMDs40LvmASx+6RUbjVveNJ
	 zxkZdfVHKHOjWtllUqyGkzG3c7MG1hCHUBJkuEAAb1UWzGzRQdydGeCugBZF1fbIBpNoR
	 uF4ad8wNqRQWzVAZkZ0CYAMNAi1wbvTZJuP2fKQJo7IAzPktf2RzBJyhQhyCeQANVh3h1
	 9ibYZz9J3jxemJ2QYhqvUtP0S0TDWx5hIf7YQEYf/QzKPAJkfwDhEVIa4Idrl+4XMlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792743514;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=n5vPrfbmjtB4d4z+h+75wRb54w4l+pZIgRZmf289DF4=;
	b=YhVSQb6Fe6IVd65s51WmbpeWs6JbwkQ3Qq/MC2NcUxycQAEbK56+IkCYiogp196hfHx2
	 RCa2QEV/YF+2yaBlKyYRc5Qv71iI9gdSPiUysBB+dhTaybmCXRis9P64YNYCswwDi4we7
	 S6VMnUUNJtnHYVr+S+zsClOlSApIF2wQFbUYFfFnHonFAL6NOO0VEVb+eYWwKvvwswtRH
	 jS56OLTHeGbCwoqxsEqwpIVmprOKIKTFmKH0f0966XHsoEjXsCeCs3KHB0by4dyjehYhf
	 nWkXbIu+HRwsxY27J7pwOy+LeMxDyB/8U4/WVwhHCwsMxTyXUHJc4ibKa13KRssNX5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U5UB5jg0;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9C3606A332
	for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 08:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9C3606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U5UB5jg0
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so378072a91.2
        for <linux-input@vger.kernel.org>; Fri, 23 Oct 2026 01:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792743512; x=1793348312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n5vPrfbmjtB4d4z+h+75wRb54w4l+pZIgRZmf289DF4=;
        b=U5UB5jg0MQlQYbNuXux7dTw0ltZUfisJz2vPD77hmiYC1LgyP+lRIaq9jgJJOZgBOi
         gKtT3TZaCHB7A/dhbwoNvRDF4oaHHMlqvxpddr+A0+3m7zKvAXqKRmqEcGoEYpQ/o/gB
         +F7BMs1HeZFjJGro8fl7JS9LqgHF3wpYFr46oxMDCyC6d28VJAeAounbfIyUm2Xu2yPN
         Uk4vecIvihbZNNs5Av71eI8AfdKv2CWnvfXkDOJge03MnA9oyBYWFyvokDyZ8fd57e7J
         wXWLOIURgjr3thaczfszRlW0Xtk7WsPb+OhrYw6/k1gpMsguNmvnK3LCFFHiI8tTqmIL
         csTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792743512; x=1793348312;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n5vPrfbmjtB4d4z+h+75wRb54w4l+pZIgRZmf289DF4=;
        b=QuvShwQmoBkEwjH8Q+y3NDyVduxO6UyGDvaEfiy6UlF96rSMsLICSCG6YV0LmYGyVc
         uwt6WyJvizoKNrtJYTUf5F3nNU3H163CttFnERXVPNKLD4tZov7lgH0YR3OPQW+r+uTp
         kJNj03Mpfw+I0Q3RQTQEvNTFn89WBoWQPFp84jLLP9Yv9oz/QKBd2SLA4YNqRO1/RIhv
         2+y3lwCB6xBEC1Bq29WT0NM8k3MuZ0kxgZJ8x+WDK4DaDR+GMlNx+Ok+fRTsjh0bDL+e
         jjc/8aA/gXY7jlJrsOTRZk7TExC7on1cFzHfV/tgck0eMvebKW7CVpRXR8u88ZEfVKLh
         CRqQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTAo23TA2bNLrypQ+uEw4wwNphyMHYyf65YmMEiduZl47TCMGh74Ssno532kdu1MtG6iaW2IbSxBAqmg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK9EMYvdubT+imkmRIIXM498z/4OpT7tod1UArssUIU21cC3VFN
	mY/2oSQi59ariQeIOLdet16uv29LHTSRNkAC3c5HAJXumlgz0BvwSiDGutZbTDzX
X-Gm-Gg: AYBFou0ivjBW/Es6nc5grz8y6YuPGQ6m6z8A7ObTq9cj43s7WvMyieKax664/pbAuVd
	Tj0RgWm/rxHDvr8m16xTw4PlxnedGS8zg4HS+TiGpZcSYHRyiTx53uj/VbvRWOVyvJ4OoylMArV
	ke6FV6k+IsuPRsdkb7xZn/p3Adc90EGoCjKCYpaq8q2VYPy3QaojgqSRh8sG9QN0iyfAhqAVm7K
	JGRbzeAZifRTBj3e+VGHM3uU77hHhpxEYgKeh8cUxGLIESBjtH7xtH9ECUaTCvxDO6Mx5EEcZFY
	ojGo0bAdCUshoGnO0xC66Tcwy+YDdiB6tfhOnDZAspyRygXYcic+NuJ551uysNC8AhlaIdjXzHL
	RKzGJx7J48+IWfPlIwIHW5G9JJa5S+PmcMZdi50IhepFhM9eZ3zFI6JLYevDvJkXc1AAaz60ZPc
	VAilAMDGS896vTTjJ30Tzdx2eQsONXUXEzOCLDqO+80BGa0Zj4V+cWVejFLy7l/j+BUOZgdqlv6
	tqVS60jkvWb7laMaL0Y1xQwulFv+ysoBXK0oVUXkCnoFPt9PEVt19rHDh19huQKGudg9o+dUXXL
	VESSwEywyLZKAVKuJ7D248x+SxyRZ9/yJCRzMNGmh7YRaXmQ0l3X
X-Received: by 2002:a17:90a:d007:b0:3ac:9a5e:9ce9 with SMTP id 98e67ed59e1d1-3adce02dfbdmr1235557a91.29.1792743512400;
        Fri, 23 Oct 2026 01:18:32 -0700 (PDT)
Received: from hostname.tail4fb79.ts.net ([2401:7400:c804:b668:65cc:625f:9c43:1e88])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3adcb1b134csm2532052a91.8.2026.10.23.01.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:18:31 -0700 (PDT)
From: Ho Jie Feng <hjf3108@gmail.com>
To: basavaraj.natikar@amd.com
Cc: stable@vger.kernel.org,
	Ho Jie Feng <hjf3108@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: amd_sfh: Use shared interrupts
Date: Fri, 23 Oct 2026 16:18:02 +0800
Message-ID: <20261023081803.21761-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The AMD SFH driver requests interrupts without IRQF_SHARED.
This can cause VFIO PCI passthrough initialization to fail
when a passed-through device shares the interrupt with AMD MP2.

Request the interrupt with IRQF_SHARED. Check for a pending MP2
interrupt before clearing and acknowledging it, and return IRQ_NONE
when no MP2 interrupt is pending so the interrupt can be shared with
other devices.

On an AMD Ryzen 7 7735HS host running 7.0.0-38-generic kernel
from Ubuntu, trying to pass through an xHCI controller
(1022:161d, 0000:e6:00.3) fails with this message:

  genirq: Flags mismatch irq 45.
  00200080 (vfio-intx(0000:e6:00.3)) vs. 00200000 (pcie_mp2_amd)

QEMU reports:

  vfio 0000:e6:00.3: Failed to set up TRIGGER eventfd signaling for
  interrupt INTX-0: VFIO_DEVICE_SET_IRQS failure: Device or resource busy

With this change, the passthrough is successful through VFIO
on the same host.

Fixes: 7f016b35ca76 ("HID: amd_sfh: Add interrupt handler to process interrupts")
Cc: stable@vger.kernel.org
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

base-commit: 2c2fe95ab19b09bef7391e3e5cdf8146d09792b6
-- 
2.55.0

