Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795538913;
	b=HVi5cHnhqRb5X8wE6Gx31ovNx56ELqqBK1uK5lZOlx/goTKLtR8eKOEpFhAhpZveKAuk
	 DuCJkulXewVf/fEBy94u0hejsnEuCiP5hZfLSGtqycw1PCYBZX2fG3/l9IFFVKyJRYUG7
	 D/gX+//zh07qW+IEpKXv8JvZxf3zXEPzA0cb5xqwPTUCdIJASe3IabTMwlMCC7yaXEyRY
	 L6/uPzIsDqFJrkwbAl3oZktnyVhlfCzCXL3YWWaQB2UIpePmOyaA8JVw8I7IymJrupKCj
	 V7GWXt0sbR+sjO/nIV4FcGFQuTEDe3PdU7S7HGG5+zDHMLb/8voSeF48BegLSPO/pUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795538913;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=6o3VUbH948ixiGmN0/qDOxf1Zgrb47dKqWd1dXfZfFM=;
	b=oZfc0MzjABjqN/16cm59qlIvoC+2MM4VSguVGKXkTlenSLODsu5CAuDJ2yZ9CX3cT4JP
	 xnCGqFOJyEDbiRpKZLOsXETNeVpiLnlX0B/pgM4fCsRVtZFWYXqipGv4wP06M8EnxNsUn
	 1GpDcSTPHMEk28x4F/K0bE6XhoaHx+vTB00061fqTBnos+ZPx1aqDzU85OeMCvxuiANXb
	 6a4MnnXgkMt08ufJ4eESsrTso6kruoVdaOS9baO6iKsK8FgBQ5LVIzPYV2MJ3EQSA1MfD
	 5Dd8r41d/kkybxfJu88Aw+Ts59gQtxTdbmVbBmpfEeJlPfhxeq0vJNhAK85Fdxt1wTg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b="C6rkXr6/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.112
Received: from sender5-pp-f112.zoho.com (sender5-pp-f112.zoho.com [165.173.182.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA460A2608;
	Tue, 24 Nov 2026 16:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03CA460A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=C6rkXr6/
ARC-Seal: i=1; a=rsa-sha256; t=1795538743; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kpTrr41vj1n2cmcIKWoJBh7niGFPymscQMZ2Uov10MtXZJhzc+tXT/QcFWR1dDTWRP3y/O4iCtes1FOV1tfbUzd4NniLaTsGqICJJc/T0MeWCAapXHAcBEpd7LnTK0rKgzcZICiwVbEYLK+9s4dzVyQZZTTFIJtagqvF7/t5Rn0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795538743; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6o3VUbH948ixiGmN0/qDOxf1Zgrb47dKqWd1dXfZfFM=; 
	b=AA9CIrOS6ZqQqZxBwblL6DP6I3PHV6c5T5xrF1c3YCeVgdqdXO4NXg2d6NeVKizxu5z85sLXLNCPQ2f1a699Vs0DfHinkyUsb32eLRhgaBnOicJD7ww+SVK244n6aIB8RE3iLZcbP4CjGd32szm77l3UHe83OU7uS1Ok7JQfAnE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=C6rkXr6/tP5pGf9ELv5JdG8toUFyPubTXWt1qrgje32T3/q29w6tpV9T8D5PWbGGvrPg1HHgJQ3eaGjkybnVn4hU00wPSeM4CxEloVs02ULRuXCBd435fAx3vB0QIubzVoLmCj0n3lA/UzGtHa/KjEtWoVtW1r6jUbv8TG+dvOSoO8ATrAZmTjKS+BGVaAQVmuDEVwoMWsI6k6egioLMDnz7RJ7qmMBXAsVdWjGk4Rf+85Iw0qqQTc0HZn00Hpo+m7dCKatNMC0yqRVSbNoWOo3ta3WRYwDHC7dIQOcmrcZd7VJPG0Db3FDB/IeGDNRVDeFxOSmrfVYJXY+GO7WhqQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=6o3VUbH948ixiGmN0/qDOxf1Zgrb47dKqWd1dXfZfFM=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795538741466762.3926118253756;
	Tue, 24 Nov 2026 08:45:41 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Wed, 25 Nov 2026 00:44:37 +0800
Subject: [PATCH v4 9/9] HID: haptic: Remove stubs in favor of inlined dead
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
Message-Id: <20261125-hid-haptic-kmod-v4-9-03713a89f656@rong.moe>
References: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
In-Reply-To: <20261125-hid-haptic-kmod-v4-0-03713a89f656@rong.moe>
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
Changes in v3:
- Fix the return value of hid_haptic_connected_to_input() when
  hid-haptic is disabled (thanks Sashiko)
---
 drivers/hid/hid-haptic.h | 83 +++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 51 deletions(-)

diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index a459c5eb9580..375891d1d5de 100644
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
+		return false;
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
 
@@ -154,6 +170,9 @@ static inline int hid_haptic_input_mapping(struct hid_device *hdev,
 					   struct hid_field *field, struct hid_usage *usage,
 					   unsigned long **bit, int *max)
 {
+	if (!hid_haptic_enabled())
+		return 0;
+
 	if (usage->hid == HID_HP_MANUALTRIGGER) {
 		haptic->manual_trigger_report = field->report;
 		/* we don't really want to map these fields */
@@ -168,6 +187,9 @@ static inline int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_dev
 	struct hid_plugin_haptic *self_plugin;
 	struct hid_plugin *plugin;
 
+	if (!hid_haptic_enabled())
+		return 0;
+
 	plugin = hid_plugin_get(HID_PLUGIN_HAPTIC);
 	if (IS_ERR(plugin))
 		return PTR_ERR(plugin);
@@ -183,6 +205,9 @@ static inline bool hid_haptic_input_configured(struct hid_device *hdev,
 					       struct hid_haptic_device *haptic,
 					       struct hid_input *hi)
 {
+	if (!hid_haptic_enabled())
+		return false;
+
 	if (IS_ERR_OR_NULL(haptic->input_dev) ||
 	    !hid_haptic_connected_to_input(haptic, hi->input) ||
 	    !haptic->auto_trigger_report || !haptic->manual_trigger_report)
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

