Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794506145;
	b=PSGmQmHtsFvX9xDyVN2JpxYwY7Nu3dT58AWKMrUdt+pVMLUKhCW+8oSNSGR/kJn/2QlS
	 eFc4ae9lc+7jJY38xDlw6ym+Hd+w93y0Gs7oKcnTejbwTgEe+T49EBEYND+poH6E44fpT
	 3zZKV5h1HFTDvyYhRvi1c05pehQpNLmBY7isscni6/5DNa+U0AdyO1RzCnTeC+yct59zn
	 5KEuZBQI0JKi0z75zEArcC3AqcK1sCTFMsGE6dy8Coq6POdGiORX09EqvlGwhhim8XYkm
	 oIkPtF8N9R8qe5J6PJTcwKOyCumAI00qbfxYjmrZQ2gctstDn7VlALZEYEmMzvXi+eg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794506145;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=xBhnSUL/Ssr/La5u3Nm2jlnx6zAOqzoLlfJIClWhvo8=;
	b=zPnm97B+HAZJEHfx2z1fnJyr3K9P2PAEr0+oQUvgYIpy/p7e5Ch2gyJNTuRea8mODcCN
	 ysGg7Ms3Z2D9d5BMrVSYAXRSa339VtXIEbw+yVoNOsXo8oCp9epl0+ac3T3cHVvPlR0oX
	 v8/TbP4UCz0Y3bfx19VmIw13/FKsmW++imkDECfJ/B0neB+F4qX4pzymkzQvc+3NHmQo9
	 zz6IAUA4Kcu8lfqBhvayt1hifyv8+CTuM2Cq88WfU+nQlr5MPDaBm7+0WHLKUr+rDLgv0
	 uHcL6xyx0XLt/qJog5Yi4eBM+sgy+oBbHba2jskvtWkB5GomDMXTicnInpzyQPPgx7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=AIvo3Kf3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C78606A327;
	Thu, 12 Nov 2026 17:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9C78606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=AIvo3Kf3
ARC-Seal: i=1; a=rsa-sha256; t=1794506077; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LETeYScF35iNDG2sJhcOL8PJSK0kk0WMvZQ0lLoyP3dpOPKr3boHcHOTXsC+OvFZUIDZE10QUYgv2vAeMPXweuEjZ1fV1DVsHyUt2CFmun/I94pCIJjjcyxsUCH/+GwDQcA9MMiUznaW0QEIStn9UZ7ROFOo5TfTlvTyfGJRGy4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1794506077; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xBhnSUL/Ssr/La5u3Nm2jlnx6zAOqzoLlfJIClWhvo8=; 
	b=RZzlvGCRAGQapgJlXPtYtn3/3UeK5rS59quU2tMQu45kHqNUVFEm/xOtgt2JJ/6A1a1Kz3l1Usih7EiKX4wlPY3lSIS5hXZNqkOmo5BIPnpCHv9jA83dlukB0+QFnhOexogmHF5MubesEGmn8tVN25WbtEda/mQutm5jpCX5V9c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=AIvo3Kf3PU5DkoBUOMM476DTcGlj+LdTjxIVACmprRIFiGfHtTzSlUFfEJxDEsn0+DlRJCFvfXG0bcsTakXZO+6tHy4Ye9HcTKZ95lP8MfcXz5v5y+YtH0fNJnzzBY9NQh5ScB/692psQcB/mkMa/YjMzRUO+oJ+cnf9OIrL1nIjagzCVioBkJYALZJimu7iQ8ueP6YCtiUbsP0rsZ9oyr965HnvohSSmRqKn2WOELODjn1lFj+afiSVOWTWfhQSs6wWYWo/ymBlVgMXodPOkAMRew1i2Kg2Upk2UTtItZTDaGONrl62Dvry1b61nmVx1Wo9LJW+QrgPKzMX8Z+mHQ==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=xBhnSUL/Ssr/La5u3Nm2jlnx6zAOqzoLlfJIClWhvo8=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794506075574774.6704790129594;
	Thu, 12 Nov 2026 09:54:35 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Fri, 13 Nov 2026 01:54:02 +0800
Subject: [PATCH v3 9/9] HID: haptic: Remove stubs in favor of inlined dead
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
Message-Id: <20261113-hid-haptic-kmod-v3-9-e7dfa8766c0d@rong.moe>
References: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
In-Reply-To: <20261113-hid-haptic-kmod-v3-0-e7dfa8766c0d@rong.moe>
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
index a71ccee569f3..8b18b06afa10 100644
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

