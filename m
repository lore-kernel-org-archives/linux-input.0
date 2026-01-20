Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB573A4AA4
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 20:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768939331; cv=none; b=HlCjIam9xT3tPZX76i/FU3lh0upVnlR+DuHEfRLRxOi7sPIbeOrogHbo4HBMd5gPKVDBnQnib31PeFeMLbHnxIARpt2kuzWFPh38S3+w8JTr7TAZCltrt1Bcp8pGc8ERk7AvVNnpbvARAXvaOYPNv9IBngQiuXiSUd1/bk9Gtxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768939331; c=relaxed/simple;
	bh=zLX0U5ed9Z5ZisaA7/CdhPs4p52bedAyyBDRAWxNW64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=np6fkCF3wAgtV1uBjhmVgXOdA7a6OLmF6uNYSOGQPSDsbeysm+/gpLfmquBVDfzTVP8bTfDsOsfKbtF6ib9GaHJ3Qo/wEs3Hv6sKJeKOoWAYFhwYs+ImN8T/ZkkGd/gBpc+34PnZOWM1uDID4hZtS0XzPH5A2aB1sNhKeD3IGPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2Mob5vR; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2Mob5vR"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5eae7bb8018so1903811137.2
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768939328; x=1769544128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=af9lydIVBoA+R4nYo8yd4wwTFlh3+uzAUYIdFOSZ9pk=;
        b=C2Mob5vRu10mv+9ue2muyP1cEqHZXv8YUNuYUYeSzxrttkRwewvnFbg9Lk3FhB1n7h
         FxWUX69EtLNnsCUdGms1KAzebzRTCAFq3V9sXQ64LzESweLdU3z9vQ3BQFSEEnYWbmft
         Ptgdp/pBtkk/PQuLwcyr7bcBHUlVnS642KNzwIXieGkp4l9HQPwrpiacEN7NX2G+HY+q
         OcFdvE0uhIIuHPB+ZMHaDSGBurVVqrTLdlqOZYgk46C1yv1OEuOyReGgqxgxyy6fNusr
         z3FjYJbFBbJubKDg8gDgRz00wG0DbHdWPMLPjl15vXxFVJ4ZCDr4TQpACKyhkywqG31D
         PrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768939328; x=1769544128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=af9lydIVBoA+R4nYo8yd4wwTFlh3+uzAUYIdFOSZ9pk=;
        b=qqdYLl2nw7QRESjSJproI4OfbJspK+KZANCGBUKiJJYK1L84MgIwoydPbOgSEGMVBK
         BXDpK6sN1S+fH7tjdF/PVa/ySdfZaPdC78VgyttTosyIlOq+P4htGPzGczGyQ8yiM6c/
         8GAUDdx18CTZsTLAQnUZma0+buLnGVI90d1KLLfMV7Nmntpd0OufWvTe0ccNgRiDkiTW
         8LopE6Dn520c478QaA010mPe4zerb2VGXKMuK5aWDRDfEhEk4xf8IhkKvnv4vrmzao9j
         e2UTzC6trgBot9TYTpUiJ+atGShEzrBNRz9kB4GKu2Sbhi5CWJhyC4IQsqMgOzr8g0Ki
         +HgQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9M2SFpO7gOlD2R2VPB3p18XvLbbter7aSbwIPJOEek3nUg19POV/S28BzsyU/CngGnY6aBKo4pfxu/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVyUPTKOBDtOnb1TuJWQf4b7c2bPV5oIDu0iAvQ7xO99kPhZ/h
	enKyS2hwolzdWDaBIeGbiFIaLIuFfhACFxizGcRHOqRe+RPIlXrSYnD1
X-Gm-Gg: AZuq6aI5zvgFP5RoAHi3c6O2VAg9DcMIZyzsN1ZI6QyrjMfM127RqSNToxzFc8XVN+o
	A0aV23IgJeKSCpjvtbN9W2kwohcvmwgHeiK4rmQN2woPQjQLutlAdB8BqaGOSu935+8LhOZchUe
	2uS1EzbWrBgGDreW/gIqOwZUPBlM93vU3wu0MkNyCwWKxQ75ZvmuSr8CtR/AGfgHobsyz2SsYjP
	rt+DU1shNygo3QI93InyBKcgCAqxDhh2pHCeLHnKzLFDleE6OkYDNaW1CaLBUTSzrpPhxB5o+Tw
	PHjtfwxRci1LuRV9+NNxIvMU5U2aEVK2Qv7Q2L2m6J3MXISyOuwdSbhktYUrgZY9bOdKr42/d6h
	wEcGMotUjahqKuPLR2/5snJBmSQVWBgT/ePdce/LBxip+FKSewjfI/pZl+dOtR1ai+rLTdiQXxP
	gtheqPKEiBGLy5JY7pHy7K1Z3m498lhn+QX9Ri/RXkc8GHHPNWWcAEY26BG42YhPpxIGL/qQ==
X-Received: by 2002:a05:6102:3596:b0:5ec:f42c:79e4 with SMTP id ada2fe7eead31-5f1a6fdd154mr4434644137.12.1768939326488;
        Tue, 20 Jan 2026 12:02:06 -0800 (PST)
Received: from benjamin-desktop-fedora.mynetworksettings.com ([141.154.77.127])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6a7298472sm1112863585a.53.2026.01.20.12.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:02:06 -0800 (PST)
From: Benjamin Wheeler <benjaminwheeler0510@gmail.com>
To: srimanachanta@gmail.com
Cc: bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] HID: steelseries: Add battery request info (byte flags) to device info.
Date: Tue, 20 Jan 2026 15:02:01 -0500
Message-ID: <20260120200202.1225216-3-benjaminwheeler0510@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120200202.1225216-1-benjaminwheeler0510@gmail.com>
References: <20260112041941.40531-1-srimanachanta@gmail.com>
 <20260120200202.1225216-1-benjaminwheeler0510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This way, the device info is decoupled from the functions that call it.
This will allow for simplification of calling these functions.

Signed-off-by: Benjamin Wheeler <benjaminwheeler0510@gmail.com>
---
 drivers/hid/hid-steelseries.c | 79 +++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 63b086fa6df0..dabc4763f072 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -31,12 +31,22 @@
 /* Legacy quirk flag for SRW-S1 */
 #define STEELSERIES_SRWS1 BIT(0)
 
+/**
+ * Stores info about how to send a report to this device.
+ */
+struct steelseries_report_data {
+	const u8 data[2];
+	const u8 len; // Only ever 1 or 2, no need for size_t.
+	const enum hid_report_type type;
+};
+
 struct steelseries_device_info {
 	u16 product_id;
 	const char *name;
 	u8 interface_binding_mode; /* 0 = first enumerated, 1 = specific interface(s) */
 	u16 valid_interfaces; /* Bitmask when mode = 1, ignored when mode = 0 */
 	unsigned long capabilities;
+	const struct steelseries_report_data *const report_data;
 };
 
 struct steelseries_device {
@@ -382,12 +392,55 @@ static const __u8 *steelseries_srws1_report_fixup(struct hid_device *hdev,
 	return rdesc;
 }
 
+// Report data for: arctis 1, 1x, 7p, 7x
+static const struct steelseries_report_data report_data__1_1x_7p_7x = {
+	.data = { 0x06, 0x12 },
+	.len = 2,
+	.type = HID_FEATURE_REPORT
+};
+
+// Report data for: arctis 7, 7 v2 (2019 ed.)
+static const struct steelseries_report_data report_data__7_7v2 = {
+	.data = { 0x06, 0x18 },
+	.len = 2,
+	.type = HID_OUTPUT_REPORT
+};
+
+// Report data for: 7 plus, 7 plus P, 7 plus X, 7 plus Destiny, all novas besides nova 3p, nova 3x
+static const struct steelseries_report_data report_data__7plus_nova = {
+	.data = { 0x00, 0xb0 },
+	.len = 2,
+	.type = HID_OUTPUT_REPORT
+};
+
+// Report data for: arctis 9
+static const struct steelseries_report_data report_data__9 = {
+	.data = { 0x00, 0x20 },
+	.len = 2,
+	.type = HID_FEATURE_REPORT
+};
+
+// Report data for: Pro
+static const struct steelseries_report_data report_data__pro = {
+	.data = { 0x40, 0xAA },
+	.len = 2,
+	.type = HID_OUTPUT_REPORT
+};
+
+// Report data for: Nova 3p, 3x
+static const struct steelseries_report_data report_data__nova_3p_3x = {
+	.data = { 0xb0 },
+	.len = 1,
+	.type = HID_OUTPUT_REPORT
+};
+
 static const struct steelseries_device_info arctis_1_info = {
 	.product_id = USB_DEVICE_ID_STEELSERIES_ARCTIS_1,
 	.name = "Arctis 1 Wireless",
 	.interface_binding_mode = 1,
 	.valid_interfaces = BIT(3),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_INACTIVE_TIME,
+	.report_data = &report_data__1_1x_7p_7x,
 };
 
 static const struct steelseries_device_info arctis_1_x_info = {
@@ -396,6 +449,7 @@ static const struct steelseries_device_info arctis_1_x_info = {
 	.interface_binding_mode = 1,
 	.valid_interfaces = BIT(3),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_INACTIVE_TIME,
+	.report_data = &report_data__1_1x_7p_7x,
 };
 
 static const struct steelseries_device_info arctis_7_info = {
@@ -404,6 +458,7 @@ static const struct steelseries_device_info arctis_7_info = {
 	.interface_binding_mode = 1,
 	.valid_interfaces = BIT(5),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_INACTIVE_TIME,
+	.report_data = &report_data__7_7v2,
 };
 
 static const struct steelseries_device_info arctis_7_p_info = {
@@ -412,6 +467,7 @@ static const struct steelseries_device_info arctis_7_p_info = {
 	.interface_binding_mode = 1,
 	.valid_interfaces = BIT(3),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_INACTIVE_TIME,
+	.report_data = &report_data__1_1x_7p_7x,
 };
 
 static const struct steelseries_device_info arctis_7_x_info = {
@@ -420,6 +476,7 @@ static const struct steelseries_device_info arctis_7_x_info = {
 	.interface_binding_mode = 1,
 	.valid_interfaces = BIT(3),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_INACTIVE_TIME,
+	.report_data = &report_data__1_1x_7p_7x,
 };
 
 static const struct steelseries_device_info arctis_7_gen2_info = {
@@ -428,6 +485,7 @@ static const struct steelseries_device_info arctis_7_gen2_info = {
 	.interface_binding_mode = 1,
 	.valid_interfaces = BIT(5),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_INACTIVE_TIME,
+	.report_data = &report_data__7_7v2,
 };
 
 static const struct steelseries_device_info arctis_7_plus_info = {
@@ -437,6 +495,7 @@ static const struct steelseries_device_info arctis_7_plus_info = {
 	.valid_interfaces = BIT(3),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY |
 			SS_CAP_INACTIVE_TIME | SS_CAP_CHATMIX,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_7_plus_p_info = {
@@ -446,6 +505,7 @@ static const struct steelseries_device_info arctis_7_plus_p_info = {
 	.valid_interfaces = BIT(3),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY |
 			SS_CAP_INACTIVE_TIME | SS_CAP_CHATMIX,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_7_plus_x_info = {
@@ -455,6 +515,7 @@ static const struct steelseries_device_info arctis_7_plus_x_info = {
 	.valid_interfaces = BIT(3),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY |
 			SS_CAP_INACTIVE_TIME | SS_CAP_CHATMIX,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_7_plus_destiny_info = {
@@ -464,6 +525,7 @@ static const struct steelseries_device_info arctis_7_plus_destiny_info = {
 	.valid_interfaces = BIT(3),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY |
 			SS_CAP_INACTIVE_TIME | SS_CAP_CHATMIX,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_9_info = {
@@ -473,6 +535,7 @@ static const struct steelseries_device_info arctis_9_info = {
 	.valid_interfaces = 0,
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY |
 			SS_CAP_INACTIVE_TIME | SS_CAP_CHATMIX,
+	.report_data = &report_data__9,
 };
 
 static const struct steelseries_device_info arctis_pro_info = {
@@ -481,6 +544,7 @@ static const struct steelseries_device_info arctis_pro_info = {
 	.interface_binding_mode = 0,
 	.valid_interfaces = 0,
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_INACTIVE_TIME,
+	.report_data = &report_data__pro,
 };
 
 static const struct steelseries_device_info arctis_nova_3_info = {
@@ -490,6 +554,7 @@ static const struct steelseries_device_info arctis_nova_3_info = {
 	.valid_interfaces = BIT(4),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_3_p_info = {
@@ -499,6 +564,7 @@ static const struct steelseries_device_info arctis_nova_3_p_info = {
 	.valid_interfaces = BIT(0),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY |
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_VOLUME,
+	.report_data = &report_data__nova_3p_3x,
 };
 
 static const struct steelseries_device_info arctis_nova_3_x_info = {
@@ -508,6 +574,7 @@ static const struct steelseries_device_info arctis_nova_3_x_info = {
 	.valid_interfaces = BIT(0),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY |
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_VOLUME,
+	.report_data = &report_data__nova_3p_3x,
 };
 
 static const struct steelseries_device_info arctis_nova_5_info = {
@@ -518,6 +585,7 @@ static const struct steelseries_device_info arctis_nova_5_info = {
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_CHATMIX |
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_5_x_info = {
@@ -528,6 +596,7 @@ static const struct steelseries_device_info arctis_nova_5_x_info = {
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_CHATMIX |
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_7_info = {
@@ -539,6 +608,7 @@ static const struct steelseries_device_info arctis_nova_7_info = {
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_POWER_ON | SS_CAP_BT_CALL_VOL,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_7_x_info = {
@@ -550,6 +620,7 @@ static const struct steelseries_device_info arctis_nova_7_x_info = {
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_POWER_ON | SS_CAP_BT_CALL_VOL,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_7_p_info = {
@@ -561,6 +632,7 @@ static const struct steelseries_device_info arctis_nova_7_p_info = {
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_POWER_ON | SS_CAP_BT_CALL_VOL,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_7_x_rev2_info = {
@@ -572,6 +644,7 @@ static const struct steelseries_device_info arctis_nova_7_x_rev2_info = {
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_POWER_ON | SS_CAP_BT_CALL_VOL,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_7_diablo_info = {
@@ -583,6 +656,7 @@ static const struct steelseries_device_info arctis_nova_7_diablo_info = {
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_POWER_ON | SS_CAP_BT_CALL_VOL,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_7_wow_info = {
@@ -594,6 +668,7 @@ static const struct steelseries_device_info arctis_nova_7_wow_info = {
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_POWER_ON | SS_CAP_BT_CALL_VOL,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_7_gen2_info = {
@@ -605,6 +680,7 @@ static const struct steelseries_device_info arctis_nova_7_gen2_info = {
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_POWER_ON | SS_CAP_BT_CALL_VOL,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_7_x_gen2_info = {
@@ -616,6 +692,7 @@ static const struct steelseries_device_info arctis_nova_7_x_gen2_info = {
 			SS_CAP_INACTIVE_TIME | SS_CAP_MIC_MUTE_LED |
 			SS_CAP_MIC_VOLUME | SS_CAP_VOLUME_LIMITER |
 			SS_CAP_BT_POWER_ON | SS_CAP_BT_CALL_VOL,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_pro_info = {
@@ -624,6 +701,7 @@ static const struct steelseries_device_info arctis_nova_pro_info = {
 	.interface_binding_mode = 1,
 	.valid_interfaces = BIT(4),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_INACTIVE_TIME,
+	.report_data = &report_data__7plus_nova,
 };
 
 static const struct steelseries_device_info arctis_nova_pro_x_info = {
@@ -632,6 +710,7 @@ static const struct steelseries_device_info arctis_nova_pro_x_info = {
 	.interface_binding_mode = 1,
 	.valid_interfaces = BIT(4),
 	.capabilities = SS_CAP_SIDETONE | SS_CAP_BATTERY | SS_CAP_INACTIVE_TIME,
+	.report_data = &report_data__7plus_nova,
 };
 
 #define STEELSERIES_HEADSET_BATTERY_TIMEOUT_MS 3000
-- 
2.52.0

