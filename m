Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253882;
	b=UNLUCKDfrZRe833lMvprLcTeozzOAFStSmyNkDT9Ci8fS+bq2dmXzfR5DekmzSHrxAeV
	 LGQizhgABib8fvMikstZFg4R6f5mpUvVELqj2XOYIyQAW9iJ/v3r+vVQG+opDG3WsuSr9
	 Ds1hJKV3hnzodw9gDu6JFsX9Z1llm+rmCODgFFZWSHKRNm20RfUrj2hiaWRvlQRWP/hKi
	 eDlzorKUD3Fn9KXz7sR/Z59mrIMqFc1PcCqgSHiWnXsDnDI3u/TTF9mHMIA913049C9PZ
	 m1baCcUjKYZ32yVUVKVKohmEt9NUF1dTYX5uB2bDZwKIvF3pvKl9whxeRfSEj1E54YA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253882;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=6IILC2xu3YWtamZV32PJaIAFJ/CjBf+OCBBfnhJfPOM=;
	b=ctYie3brkUiEY3LUtrax3bzhgckMfrRvbmlXy+R1jcfZs/A0XuMPhQIxcGm7BJDjY/nl
	 RCbByay3jcGjp8R5OU/ARttxgSLHU2MzG51G/I1JtnxD0RU9SG0W9RbK547MervzTZh4X
	 JXRoIxNNnFVkzG69w5ivI7mQtpt594cULYf5RBG6J2tW9nmcz//v+P30DIUnuK7mtubSQ
	 ZIjFy/XNql8q/qPBg/tqFmPIa5ZYaPs5g2n/6wUUCmQYB1Muv02E6KdXqV2x9oEA6etf6
	 qYKRcZ29CUUt+czwGR7Jhuuwi8bHLmQt/accQaaKsrCW+GcrCkeAtdMrnPUov887QxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=HLxAvnT7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06131606A339;
	Mon,  9 Nov 2026 19:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06131606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=HLxAvnT7
ARC-Seal: i=1; a=rsa-sha256; t=1794253820; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nnsinw2KyP2v4sL59QqO6riHAGKp0aVF/QHTHNuTHojIUnNqO6MpeU5KIGc1euGrXHB+b+2tJWtwsiuqQvUTjomhNB1sT1R4ysn3B9aqz0TX9ig6KFp0LoXfqRw2s/gdgbtV24FhYhKl5jUWCQqXENy9oRcrEGAZnHb7R6Vb+qA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794253820; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6IILC2xu3YWtamZV32PJaIAFJ/CjBf+OCBBfnhJfPOM=; 
	b=l25FH43q0qx+qY6mRGVeAoxs5Rg1AC25lMXQEle7xeXHeP5X8DWZkw6DFhsoVaANRa/ODrfSpW6fl0vT5IOIfLbfxtynb6Gx9Cqn4Sq9/iOHZ1YzSrggQlSk5z9bRPCSdrM/VvfZHdRT0HBGWJTCtfcLujLF9KV81ZGD2h3hKgE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=HLxAvnT7mU5D5InkISK6MTN4XshBMy4wj4Yw7i1WABn4tTZpuJrMopG7wjZN6i4j1PM902cByk7PLFE9nKMVQokoQ8NHh3W669adycj9ngQergR1I9q/GTOw1CqENqEsWmXlYyPpep3bvDYJ9H3brcdtzwwEMFVw3zivOYMa5260wN3n4FO3/55w2HThnOnZ8te1ZvpLnkvVLXbnM2SniwuO8ixH3UbKFWLPEb01ktsZUZDIXYCIAt55glzxHy5e0HkA9i1/4vqIi/A1VKNQntyyrOOM28H4DOqDPSVNTbaQSNAw9VGnBT9og0KSPXS/V7tiT0Cx0iIW2g2qfhRbsw==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=6IILC2xu3YWtamZV32PJaIAFJ/CjBf+OCBBfnhJfPOM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794253818808547.8468535492777;
	Mon, 9 Nov 2026 11:50:18 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Tue, 10 Nov 2026 03:49:46 +0800
Subject: [PATCH v2 9/9] HID: haptic: Remove stubs in favor of inlined dead
 code elimination
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
Message-Id: <20261110-hid-haptic-kmod-v2-9-b835a067cb62@rong.moe>
References: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
In-Reply-To: <20261110-hid-haptic-kmod-v2-0-b835a067cb62@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Angela Czubak <aczubak@google.com>, Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-ce4c1
X-ZohoMailClient: External

All stubs in hid-haptic.h can be replaced by equivalent
!hid_plugin_enabled(HID_PLUGIN_HAPTIC) checks. The compiler will
eliminate calls to all methods when the plugin is disabled.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.h | 83 +++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index a71ccee569f3..070b56189ccb 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -65,11 +65,18 @@ struct hid_plugin_haptic {
 		    struct input_dev *dev);
 };
 
-#if IS_ENABLED(CONFIG_HID_HAPTIC)
+static inline bool hid_haptic_enabled(void)
+{
+	return hid_plugin_enabled(HID_PLUGIN_HAPTIC);
+}
+
 static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev)
 {
 	struct hid_haptic_device *haptic;
 
+	if (!hid_haptic_enabled())
+		return ERR_PTR(-EOPNOTSUPP);
+
 	haptic = kzalloc_obj(struct hid_haptic_device);
 	if (haptic)
 		haptic->hdev = hdev;
@@ -80,6 +87,9 @@ static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev
 static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *haptic,
 						 struct input_dev *input)
 {
+	if (!hid_haptic_enabled())
+		return ERR_PTR(-EOPNOTSUPP);
+
 	return haptic->input_dev == input;
 }
 
@@ -89,6 +99,9 @@ static inline void hid_haptic_feature_mapping(struct hid_device *hdev,
 {
 	u16 usage_hid;
 
+	if (!hid_haptic_enabled())
+		return;
+
 	if (usage->hid == HID_HP_AUTOTRIGGER) {
 		if (usage->usage_index >= field->report_count) {
 			dev_err(&hdev->dev, "HID_HP_AUTOTRIGGER out of range\n");
@@ -116,6 +129,9 @@ static inline void hid_haptic_feature_mapping(struct hid_device *hdev,
 static inline void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
 						  struct hid_input *hi, struct hid_field *field)
 {
+	if (!hid_haptic_enabled())
+		return;
+
 	if (hi->application != HID_DG_TOUCHPAD)
 		return;
 
@@ -155,6 +171,9 @@ static inline int hid_haptic_input_mapping(struct hid_device *hdev,
 					   struct hid_field *field, struct hid_usage *usage,
 					   unsigned long **bit, int *max)
 {
+	if (!hid_haptic_enabled())
+		return 0;
+
 	if (usage->hid == HID_HP_MANUALTRIGGER) {
 		haptic->manual_trigger_report = field->report;
 		/* we don't really want to map these fields */
@@ -169,6 +188,9 @@ static inline int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_dev
 	struct hid_plugin_haptic *self_plugin;
 	struct hid_plugin *plugin;
 
+	if (!hid_haptic_enabled())
+		return 0;
+
 	plugin = hid_plugin_get(HID_PLUGIN_HAPTIC);
 	if (IS_ERR(plugin))
 		return PTR_ERR(plugin);
@@ -184,6 +206,9 @@ static inline bool hid_haptic_input_configured(struct hid_device *hdev,
 					       struct hid_haptic_device *haptic,
 					       struct hid_input *hi)
 {
+	if (!hid_haptic_enabled())
+		return false;
+
 	if (IS_ERR_OR_NULL(haptic->input_dev) || haptic->input_dev != hi->input ||
 	    !haptic->auto_trigger_report || !haptic->manual_trigger_report)
 		return false;
@@ -195,61 +220,17 @@ static inline bool hid_haptic_input_configured(struct hid_device *hdev,
 
 static inline void hid_haptic_pressure_reset(struct hid_haptic_device *haptic)
 {
+	if (!hid_haptic_enabled())
+		return;
+
 	haptic->pressure_sum = 0;
 }
 
 static inline void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
 						__s32 pressure)
 {
-	haptic->pressure_sum += pressure;
-}
-#else
-static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline bool hid_haptic_connected_to_input(struct hid_haptic_device *haptic,
-						 struct input_dev *input)
-{
-	return false;
-}
+	if (!hid_haptic_enabled())
+		return;
 
-static inline
-void hid_haptic_feature_mapping(struct hid_device *hdev,
-				struct hid_haptic_device *haptic,
-				struct hid_field *field, struct hid_usage
-				*usage)
-{}
-static inline
-void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
-				    struct hid_input *hi, struct hid_field *field)
-{}
-static inline
-int hid_haptic_input_mapping(struct hid_device *hdev,
-			     struct hid_haptic_device *haptic,
-			     struct hid_input *hi,
-			     struct hid_field *field, struct hid_usage *usage,
-			     unsigned long **bit, int *max)
-{
-	return 0;
-}
-static inline
-bool hid_haptic_input_configured(struct hid_device *hdev,
-				 struct hid_haptic_device *haptic, struct hid_input *hi)
-{
-	return false;
-}
-static inline
-int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_device *haptic,
-		    struct input_dev *dev)
-{
-	return 0;
+	haptic->pressure_sum += pressure;
 }
-static inline
-void hid_haptic_pressure_reset(struct hid_haptic_device *haptic) {}
-static inline
-void hid_haptic_pressure_increase(struct hid_haptic_device *haptic,
-				  __s32 pressure)
-{}
-#endif

-- 
2.55.0

