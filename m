Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116060;
	b=mrNW3QzoQ50bdHerOokLPkKGhb8a/Sbc6SEvOhvrascfE9IUARJ6KvTLzmD2afxm1Dor
	 xEWuV0Owo5UeTCNG+rghqsZJlKM7Xeb9haz8iBWausRN5W1ImCeriICIdiSrrTYvYUgXH
	 /+NfihmQM8C42CdqMP7OzlvVVP+SEsQnewXpkpdf54eeq3KEGbCGUku7cK/3F6f9yILa2
	 7KdTHPF96oL5m2I4wsJPaUH1ls6eeAV28+Pdn9TP2ZzQUPIIRYymNxmtM4avigoBXcOnf
	 T+6gtSTzO88ptZuSBDb0Y5duWtYqmncMKrr5l27tQgFB/NDgIUkoNpFTutBQ3DLW84A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116060;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b0c6CGAGUF6g8vtfSwTL1Y354j7cyJnIuNNGjuPfWNo=;
	b=hdrECLvS4Vk8QD8Nbg18fHf6yW5MlcoXRPZLJzlNJmd6gwfU3R+yckHcvwfPBeh23J6A
	 MlpeMIkhFDOG/aWm+hX61DoVHmXqiQlliMm5gKEIBF5FDFkkxVySla6YwDAoeQOBDLZvI
	 lQtXVRtVromS+8d0q8ByUeWMxgtCO8YA3VIYhSqtKTTPTiCbndfZT6Z9oidTvJiHFwmoO
	 yZQIAKyxSaL/8Ry/VxoglVy2BScBVmDiMbLgrNfqXYMsuXtWsSVsDRqHv6lJXMZBJVXV1
	 VoVyi9IPvNP19bVgwuagLuDNTS38IeYSY3EIUArsNjyIZ0vpRq0HWf1J6nPZVh583hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qNv+F2up;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547EC606A320
	for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 19:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 547EC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qNv+F2up
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e9995ce866so667385ad.0
        for <linux-input@vger.kernel.org>; Thu, 19 Nov 2026 11:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795116059; x=1795720859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b0c6CGAGUF6g8vtfSwTL1Y354j7cyJnIuNNGjuPfWNo=;
        b=qNv+F2upay5nHaiW1qXWUZPBc0wtvYrsbaPLKxcBjuBMxIfvcKIMBkAVP7tef86ztS
         8GydGE8h32QinKjD+nR0s+whfjhhclwBKtHCTyVmwHWbRkFe6QlTTFCCyeYg4/7UejnS
         jZc7fskxiat+VCWRrP/uU0oRaYek6TTznytdpZmd1/2ewt6YJCuXb+BYX4ipwMn1QUDo
         DL5zFGqRH15Sm+c7lKYXtjYzcqYdtMMgB02Neiiwd71EVE3VEWqeDTRaKKsZ9UlOfvfs
         3FIslBoUlo/U9bttxtetyDa5a8bJO5nRV2HVPahgSDVDyW72hFSeuPpxTNrTSh1Fxnmc
         TaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116059; x=1795720859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b0c6CGAGUF6g8vtfSwTL1Y354j7cyJnIuNNGjuPfWNo=;
        b=LtaHWA3dSgeVk5uxjgjBCYjhK6LnGrxKWGPCilX60cYg1b4Q1Jkph2K4WHn8w67d0e
         eEZ8geqKRbQNXehG2NsrWcHyLPOrnDvNOuVYCwAzm53is0v3GszWK58DZ8WbniPKnfqz
         N4fvMAes6xqYa+jRyjzt2k7S8zUKhvUohEZ44lQj3BezFxuzzBSRyq+bIgSkZsPQH8Fl
         SBwQ1UU+MYsfRDgYU/A2FYXDwnqiSgicvwICVbpubJBFZIJuIpZU+EHzgbYWkkC5O3zx
         n27L4hwVotQ7xWPrbU8edgqsfcdRW3ltNeiWl3dOAtBluznczC/OUhx0XQDoR3M1ubQN
         Rz9A==
X-Forwarded-Encrypted: i=1; AL+hErF6T+YA8924dd5uISRkZbnx4rdy6y173QR0D3aH8yc5lM+THed7NQ3Ufqb+Filxhf9mmM6a6CFcD+waqA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8YAWR+Kv0s/tZJ0LwSyv7Jg9tGsbiR2PqWQmsvQ3qgBgd0ZXf+
	VxpHlo5xwrd+zawUelBQjqrpsne+lXEwxtg82BAJlFeOi0JbJCbFc2IF
X-Gm-Gg: AZFdTZfzUiLjgGR/1vBrZkoUgLILQvGi29+Fzz/tHztZUfTPvfSeQWCNXhp5nR224B2
	QzYgdRSmnJdEMhEO68evHcIM9OXe8+5DWedHZsms7RzcSd4Qw+xwRxJJ+BGouMsHAtw8aGz9cyY
	t8CMbkICDjTmAQgU3ywHcWhrQ1/0QdariFwq+lL/IV69wBrRe6XemLl9L3Z4laUT4GZckvbZ+uk
	NRvBx8I8NQ46OVUG1p/Htfyx+9yEGzZ8DR2wwpf+vh+ATK9SqO3eAuuD9aquiHDub52q86MhxqO
	tgRWaz4tpoFnJnCxPUrg89uDmMKulYy6IrjH7mXupTiHBHEWYO1zGCPwEMnzfSFpPO/1zvjEYHv
	m2kZ4P/FtVQRLvkNzPbVR0G2LPdOIJf/KUoNzdxMWCAfQBv2FBx2v4Qu2OWvNaN89aG7pL8SNJQ
	nuML9FGCpd8iELmMU6jmkWtiyOmm27kTdxeXI9s4CD9AqU3HK/PROKkZbLMADFKiQFtyiwLlM+C
	7FSXafV3nqj6RP0xdGTrBDI57LfUYXiYdG/TGrh4OGvjdZcylCoESzH6uKckaT3CjyyXA9E4Uoc
	zE19EynHY0xO8d9TSiPdpYlwMbep7Pjeh70cjLQkAPdspcQbx83q1aemr/7eltLQcHeaY/hU
X-Received: by 2002:a17:902:ec8b:b0:2e9:66f6:7894 with SMTP id d9443c01a7336-2f03f15c27amr7776685ad.40.1795116058661;
        Thu, 19 Nov 2026 11:20:58 -0800 (PST)
Received: from gb05.tail50fddd.ts.net ([139.5.199.74])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c1935sm3948805ad.26.2026.11.19.11.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:20:58 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>,
	syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Subject: [PATCH] HID: hid-sensor-hub: avoid lock inversion in sensor_hub_remove()
Date: Fri, 20 Nov 2026 00:50:46 +0530
Message-ID: <20261119192046.1015750-1-ayaanmirzabaig85@gmail.com>
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

Reported-by: syzbot+fb951970a334aaff00ba@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6afddf21.a11fe2ad.1b4426.0003.GAE@google.com/T/
Fixes: 8a5b38c3fd70 ("HID: hid-sensor-hub: don't use stale platform-data on remove")

Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
 drivers/hid/hid-sensor-hub.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 028e70ec7bac..4ade5b5ece56 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -836,9 +836,13 @@ static int sensor_hub_probe(struct hid_device *hdev,
 static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 {
 	struct hid_sensor_hub_device *hsdev = dev->platform_data;
+	struct sensor_hub_data *sd = data;
+	unsigned long flags;
 
+	spin_lock_irqsave(&sd->lock, flags);
 	if (hsdev->pending.status)
 		complete(&hsdev->pending.ready);
+	spin_unlock_irqrestore(&sd->lock, flags);
 
 	return 0;
 }
@@ -846,16 +850,13 @@ static int sensor_hub_finalize_pending_fn(struct device *dev, void *data)
 static void sensor_hub_remove(struct hid_device *hdev)
 {
 	struct sensor_hub_data *data = hid_get_drvdata(hdev);
-	unsigned long flags;
 
 	hid_dbg(hdev, " hardware removed\n");
 	hid_hw_close(hdev);
 	hid_hw_stop(hdev);
 
-	spin_lock_irqsave(&data->lock, flags);
 	device_for_each_child(&hdev->dev, NULL,
 			      sensor_hub_finalize_pending_fn);
-	spin_unlock_irqrestore(&data->lock, flags);
 
 	mfd_remove_devices(&hdev->dev);
 	mutex_destroy(&data->mutex);
-- 
2.56.1

