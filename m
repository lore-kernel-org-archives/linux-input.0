Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253844;
	b=UR+GPG0WKEv2lLhqtxPZeOYV4+o4CTjHEWDs0z3hO5ZAFYbVMPtAAg7P7MeUTm+YHbJ3
	 Pq66iZq8NJPXUIUX382nxqjhKP8eMYD/YPF2lTqz4hbS39WiYNHuyqFXisIs3XTgB430x
	 pWcbUaR34Urft0MhZIvPcEExLI1kaFx7YG2DybqC5NZe4GNY0PnrqrMe6BFzLyvIa2OGP
	 nnDBQqZWSB8dxITt/yL0iiPoGVh1KiLzf7Ccs7KNSh+6Q9qp50I2AXpDFnMizD2KNMB3c
	 K0fwsPYWrRfbQ8cr+T9Us82WQwLu6M6Q5Cce+qm03qJomN9p5V+tri7kDM+mgZLdQfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253844;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=4Kq5DaV16w0JeD18C2Kpb1My2sLJ6azsHZ1Yzio01fE=;
	b=SaIoIJ5GLY/jnA2w2HPB0yi7886D4K4P4s2iNMfUP9M3jsCO6HGR0fSJ0gPF7gDOPqcK
	 3vqoote1M+uZnQcFxKX5kn2YQbPCcmcNlGuJHNlwNSY8GqUKxxUxz9t7wfNgHAS7sWWsc
	 hCm2QjFkOvUSTPzX7q0UZmepCmhK4ujGgUWpyyfaxVwMBI1REtWAvOPMFlKt7vlzqZCIQ
	 ncSDIom9wc9xbrFSZnHFQ12a6sOC/U0GbiIkyxbjckKehJtWn6TJKanmgdaPoVM9WIp4m
	 +7bgGAJwsmLaDBQTbqENNlb4I/e1y+zurAp8yIESYYKXSEGvR/V/0boGNeHJ1a8JmaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=iLlhcxu0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17936606A334;
	Mon,  9 Nov 2026 19:50:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17936606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=iLlhcxu0
ARC-Seal: i=1; a=rsa-sha256; t=1794253810; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e6+UXE3421OHcM/XFN6S7wvbwL1Vh/NzI4fomt2FWYQEZWGG9ybj0yJ/TpWKjUHPaN5bdsB+bS+9NxUR9CPMONHQctxc2R4vSCH4Mt8b0AoCNR2ll1oxT/QppJ+td5gSG5sYNgeRI2e8zxBPquinI2UKBMbMBhF4WL9N0PlAofE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794253810; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=4Kq5DaV16w0JeD18C2Kpb1My2sLJ6azsHZ1Yzio01fE=; 
	b=i9w0RkcmYjiArLnXeiv1cjMRpqGcfhWMsejcoFyWRWGMJjq/QfXFH+ox4pVmprgxdLo1qb7E2Z6sVyWm55aI3NP08MuX9W6EkkxLLirlIRQW44J6om+BH0gNxSr7dn8cu4I929krqaHVx+6ikrJwNlMz2VemFr/QAmPFlkfIWvM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=iLlhcxu04JXEPjZBcNXmy0u3pZpZUe7KWTquJGTG39bRLBtzmXl8RJNgjQIMRVZZHjTnxf8DunTH+1rpvzx6T8uMMiELSQ/ZZtgJor/4CI9JjmyUA6XOP5Ouz2h8/LLMqsF79G91n1r17ojQ3WUUoWPu3ZCVAzf6N4e4TdDa/lblLmg0w+6Ry11RTXdJThXqQ+ASartvXYCsAC6UHSZ0gkcpUEsJFYbQdxSH86yshEVxfYsUs4D3KGEYQvsgjH7cQ40btgus7Lx8lbj5HIKfLHqDvsWUG1P1Qbudufyz2eEQWOoAt6Yu80sCkO8gsXjbA/b6YdRNCMtx9k1FAxMZLQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=4Kq5DaV16w0JeD18C2Kpb1My2sLJ6azsHZ1Yzio01fE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794253808016573.208494093635;
	Mon, 9 Nov 2026 11:50:08 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Tue, 10 Nov 2026 03:49:41 +0800
Subject: [PATCH v2 4/9] HID: haptic, multitouch: Fix haptic device
 double-free and unnecessary allocation
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-haptic-kmod-v2-4-b835a067cb62@rong.moe>
References: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
In-Reply-To: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

The haptic device is allocated by devm_kzalloc(), which will be freed by
devres on HID device release. At that time, the ff core has already
freed it on input device release previously, causing double-free.

Allocate the haptic device using kzalloc_obj() to ensure its release can
be safely delegates to the ff core.

The allocation code is also moved to hid-haptic.h, so that it can be
replaced by a stub in !CONFIG_HID_HAPTIC builds, eliminating the
meaningless alloc-and-free sequence.

Fixes: 344ff3584957 ("HID: haptic: initialize haptic device")
Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.h     | 17 +++++++++++++++++
 drivers/hid/hid-multitouch.c | 39 +++++++++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index cd4d9c74d2dc..7878cd73ccdb 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -5,6 +5,7 @@
  *  Copyright (c) 2021 Angela Czubak <acz@semihalf.com>
  */
 
+#include <linux/err.h>
 #include <linux/hid.h>
 
 #define HID_HAPTIC_ORDINAL_WAVEFORMNONE 1
@@ -54,6 +55,17 @@ struct hid_haptic_device {
 };
 
 #if IS_ENABLED(CONFIG_HID_HAPTIC)
+static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev)
+{
+	struct hid_haptic_device *haptic;
+
+	haptic = kzalloc_obj(struct hid_haptic_device);
+	if (haptic)
+		haptic->hdev = hdev;
+
+	return haptic;
+}
+
 static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *haptic,
 						 struct input_dev *input)
 {
@@ -80,6 +92,11 @@ void hid_haptic_pressure_reset(struct hid_haptic_device *haptic);
 void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
 				  __s32 pressure);
 #else
+static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
 static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *haptic,
 						 struct input_dev *input)
 {
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 5eea774dee44..a9c8396c804e 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -34,6 +34,7 @@
 #include <linux/bitmap.h>
 #include <linux/bits.h>
 #include <linux/device.h>
+#include <linux/err.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -2129,11 +2130,18 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		dev_err(&hdev->dev, "cannot allocate multitouch data\n");
 		return -ENOMEM;
 	}
-	td->haptic = devm_kzalloc_obj(&hdev->dev, *(td->haptic));
-	if (!td->haptic)
+
+	td->haptic = hid_haptic_alloc(hdev);
+	if (IS_ERR(td->haptic)) {
+		ret = PTR_ERR(td->haptic);
+		if (ret == -EOPNOTSUPP)
+			td->haptic = NULL;
+		else
+			return ret;
+	} else if (!td->haptic) {
 		return -ENOMEM;
+	}
 
-	td->haptic->hdev = hdev;
 	td->hdev = hdev;
 	td->mtclass = *mtclass;
 	td->inputmode_value = MT_INPUTMODE_TOUCHSCREEN;
@@ -2178,12 +2186,14 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_parse(hdev);
 	if (ret != 0)
-		return ret;
+		goto out;
 
 	if (mtclass->name == MT_CLS_APPLE_TOUCHBAR &&
 	    !hid_find_field(hdev, HID_INPUT_REPORT,
-			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX))
-		return -ENODEV;
+			    HID_DG_TOUCHPAD, HID_DG_TRANSDUCER_INDEX)) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	if (mtclass->quirks & MT_QUIRK_FIX_CONST_CONTACT_ID)
 		mt_fix_const_fields(hdev, HID_DG_CONTACTID);
@@ -2193,7 +2203,7 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT);
 	if (ret)
-		return ret;
+		goto out;
 
 	ret = sysfs_create_group(&hdev->dev.kobj, &mt_attribute_group);
 	if (ret)
@@ -2202,10 +2212,19 @@ static int mt_probe(struct hid_device *hdev, const struct hid_device_id *id)
 
 	mt_set_modes(hdev, HID_LATENCY_NORMAL, TOUCHPAD_REPORT_ALL);
 
-	if (!td->is_haptic_touchpad)
-		devm_kfree(&hdev->dev, td->haptic);
+	ret = 0;
 
-	return 0;
+out:
+	/*
+	 * Don't double free when the haptic device has been delegated to the ff
+	 * core.
+	 */
+	if (td->haptic && !td->is_haptic_touchpad) {
+		kfree(td->haptic);
+		td->haptic = NULL;
+	}
+
+	return ret;
 }
 
 static int mt_suspend(struct hid_device *hdev, pm_message_t state)

-- 
2.55.0

