Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793554979;
	b=brnD0MOFcWKJTJvolBfYuZnjFeunyHyte/19RKYZup11fhOBzS7mhrdxHTaxi8NUf+3A
	 +ghCEH/it3otsn3+74+NI/4/F3xTMRd3sbxBH/R5ml8d6SgbNApTOl0JEPXn4BerrQ7nW
	 MyZBE85e18suj6ZNi4cHSgKfiroBe3myGPZMUR9FH4gJVHioCCpPgkKY0LUkE8PWiFOcz
	 NqXz8qWdr8MaIwka84EO34SxKqVx0b+PNfVdD/PD2pJJ01mJNZwgFE+CWRbXsQZzMi7Js
	 o7svYXmJoNtChkroDLMP447eQhJUWgBll8QUykAORpmUnIZDNRjQ2C9xZ0gbi6KcL+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793554979;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-ZohoMailClient;
	bh=BNmw8lqJR7Y2KMGYNHw4JTp4uK2A0i8pYLTb2X9FeUA=;
	b=Rqb68uD1ZvIylMb01nbsZCtJ8OOA6d3O4AbXlw6tQN51uy4yAtOgWQe/o7Re6vCBVynV
	 gtfM3IyE5+H5rWd59oVJ9unP6Br4JAxpBed3VFu74UsBTsTWRG7hPTlOKRwwoWLMycIZI
	 iD3bhEWdSklbHxcp6gCmDdXhO8equlnF4bAXqL9PPqxkK8ge3yc3de2174Ucqtrs2m4MI
	 UatDzjyQnP2Rd/f0ONA3I7sjRDodZg9HeimV5Nx2QptIfNTHer9VmCPr2Y/1PItxMDrRF
	 ED4YSLbYqQC3yrd2aS2EQC1RQRZ1AtD+DL4hgz3voGlk5wEnlxdJ7BTSG+epymfCk7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rong.moe;
	spf=pass smtp.mailfrom=rong.moe;
	dkim=pass header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=nkDAmRSM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.12
Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B7B606A32C;
	Sun,  1 Nov 2026 17:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1B7B606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rong.moe header.i=@rong.moe header.a=rsa-sha256 header.s=zmail2048 header.b=nkDAmRSM
ARC-Seal: i=1; a=rsa-sha256; t=1793554913; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hTk2If6uwrAuM+DltiX/VMovbGYPHuM3g3Or2aaRgsTJ1koPqMyo9Q5fdSUIbkS/X73xaxaufzcmfmWcTR+rTPgQxwp7pJza541YlgL3oB7JZtsmetPJ8sX8hW/591H+aow2oaPNIviXwRuJV5K4XUfTeAd/G7URuL23JagJz5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793554913; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BNmw8lqJR7Y2KMGYNHw4JTp4uK2A0i8pYLTb2X9FeUA=; 
	b=Wd59pnEu/HpRI8ke8EUjJqRa10zW1D2uVUdy21qr3yYtm2R8zl7TIXAYpdeW1+bNgAph7he/QYT4rZJPwyRR7EwZH0Z6Ovu0xGK/Yopgzoz5gPjTqDY4EtpHqhZ0JwY+GeWTUvHdm6NyAilz1KYcXvPItQsyyCldn+ofqYBFMLk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: a=rsa-sha256; b=nkDAmRSMqgceTP9hA8EpJtG+s5BasQ60/kHUykExXjeBE5D/lGVllNaOujzC2rQmZYU0RVqvYwdEfQYC44yZ9IxH2SG858yR19mK1ZSuVcMmAnBBKj2Tw5/4LkSe8vvklSSb7rGpco4lZk0FirFp1J3vzY3wQPLDb7JbTZyG5W6WJdgYgE8tWcIfb6Xqw4j3oKxUiHx3pkjhIRk3AO2HJMYwawV//agQWNaKWJTi+wxFxfkQJGaGLo8DDyYSc280BAXHFDAeHX41M+6qvKxGcMqp88WsfJQGT4/qbuulgWSO2u3u8u1JdD0s0GuZN33UDN8uAKKvq146pYu+EdQ95w==; c=relaxed/relaxed; s=zmail2048; d=rong.moe; v=1; bh=BNmw8lqJR7Y2KMGYNHw4JTp4uK2A0i8pYLTb2X9FeUA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793554911825818.9169893929994;
	Sun, 1 Nov 2026 09:41:51 -0800 (PST)
From: Rong Zhang <i@rong.moe>
Date: Mon, 02 Nov 2026 01:41:26 +0800
Subject: [PATCH 9/9] HID: haptic: Remove stubs in favor of inlined dead
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
Message-Id: <20261102-hid-haptic-kmod-v1-9-a3de5626dade@rong.moe>
References: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
In-Reply-To: <20261102-hid-haptic-kmod-v1-0-a3de5626dade@rong.moe>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Jonathan Denose <jdenose@google.com>, Angela Czubak <aczubak@google.com>, 
 Henrik Rydberg <rydberg@bitmath.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rong Zhang <i@rong.moe>
X-Mailer: b4 0.17-dev-6be7c
X-ZohoMailClient: External

All stubs in hid-haptic.h can be replaced by equivalent
!hid_plugin_enabled(HID_PLUGIN_HAPTIC) checks. The compiler will
eliminate calls to all methods when the plugin is disabled.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/hid/hid-haptic.h | 74 ++++++++++++++++++------------------------------
 1 file changed, 28 insertions(+), 46 deletions(-)

diff --git a/drivers/hid/hid-haptic.h b/drivers/hid/hid-haptic.h
index d3e8fb9aa3b4..165427f878b0 100644
--- a/drivers/hid/hid-haptic.h
+++ b/drivers/hid/hid-haptic.h
@@ -66,12 +66,18 @@ struct hid_plugin_haptic {
 		    struct input_dev *dev);
 };
 
-#if IS_ENABLED(CONFIG_HID_HAPTIC)
+static inline bool hid_haptic_enabled(void)
+{
+	return hid_plugin_enabled(HID_PLUGIN_HAPTIC);
+}
 
 static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev, gfp_t gfp)
 {
 	struct hid_haptic_device *haptic;
 
+	if (!hid_haptic_enabled())
+		return ERR_PTR(-EOPNOTSUPP);
+
 	haptic = kzalloc_obj(struct hid_haptic_device, gfp);
 	if (haptic)
 		haptic->hdev = hdev;
@@ -85,6 +91,9 @@ static inline void hid_haptic_feature_mapping(struct hid_device *hdev,
 {
 	u16 usage_hid;
 
+	if (!hid_haptic_enabled())
+		return;
+
 	if (usage->hid == HID_HP_AUTOTRIGGER) {
 		if (usage->usage_index >= field->report_count) {
 			dev_err(&hdev->dev, "HID_HP_AUTOTRIGGER out of range\n");
@@ -112,6 +121,9 @@ static inline void hid_haptic_feature_mapping(struct hid_device *hdev,
 static inline void hid_haptic_check_pressure_unit(struct hid_haptic_device *haptic,
 						  struct hid_input *hi, struct hid_field *field)
 {
+	if (!hid_haptic_enabled())
+		return;
+
 	if (hi->application != HID_DG_TOUCHPAD)
 		return;
 
@@ -150,6 +162,9 @@ static inline int hid_haptic_input_mapping(struct hid_device *hdev,
 					   struct hid_field *field, struct hid_usage *usage,
 					   unsigned long **bit, int *max)
 {
+	if (!hid_haptic_enabled())
+		return 0;
+
 	if (usage->hid == HID_HP_MANUALTRIGGER) {
 		haptic->manual_trigger_report = field->report;
 		/* we don't really want to map these fields */
@@ -164,6 +179,9 @@ static inline int hid_haptic_init(struct hid_device *hdev, struct hid_haptic_dev
 	struct hid_plugin_haptic *self_plugin;
 	struct hid_plugin *plugin;
 
+	if (!hid_haptic_enabled())
+		return 0;
+
 	plugin = hid_plugin_get(HID_PLUGIN_HAPTIC);
 	if (IS_ERR(plugin))
 		return PTR_ERR(plugin);
@@ -179,6 +197,9 @@ static inline bool hid_haptic_input_configured(struct hid_device *hdev,
 					       struct hid_haptic_device *haptic,
 					       struct hid_input *hi)
 {
+	if (!hid_haptic_enabled())
+		return false;
+
 	if (IS_ERR_OR_NULL(haptic->input_dev) || haptic->input_dev != hi->input ||
 	    !haptic->auto_trigger_report || !haptic->manual_trigger_report)
 		return false;
@@ -190,56 +211,17 @@ static inline bool hid_haptic_input_configured(struct hid_device *hdev,
 
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
-
-static inline struct hid_haptic_device *hid_haptic_alloc(struct hid_device *hdev, gfp_t gfp)
-{
-	return ERR_PTR(-EOPNOTSUPP);
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

