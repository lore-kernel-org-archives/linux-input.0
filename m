Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69583522694
	for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790111147; cv=none; b=stoLA4hWgyyf6xtSZzpFcprpCqFUJ8fLYy/iTTlnTv2MhjdT9I3YALIR7TtziGoqfbW3H7vrSAKSW/YRdQIhQS+qTZysWXuu6V3qGxvRDykL000v54FBrkeFOGzuMPlPRu1BrrdO/jdwmm5Zk4lsihSCmHHCdzoBGZWdSBmZNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790111147; c=relaxed/simple;
	bh=MznEH0TSSJNDns08TLLQFMMA/yS10ggZ0IYUvrXf7WI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZomPqSisUBvD6fOzysY0EGaqHzwQVphm8WRgHTePhzbye5CrQ/t6bnxrYIPrK2t4z3xtB8wF61E4lVjcdpeC/q5pQZUrYOXILaeFNkj0eTblE6CdAUkbUqU1KufeZ0Mpwfa8SqaX5zP/2barjnXoo4fhct4wE5DRSwAiS2DakuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QN04uSwo; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QN04uSwo"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cebad4adso238200a12.1
        for <linux-input@vger.kernel.org>; Tue, 22 Sep 2026 14:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790111131; x=1790715931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5UcDSQfjol8c/MRKdgxKYWGRN9zsJz0+FFVZfxAT1YE=;
        b=QN04uSwoAnOGYX3m01Yg/WO0OGbLYwd31xvAXYcVNQZz0aEYUI0E+cyMVQocIU5yV1
         aoPJ4tbWK/Gu1g6X1kFXVbqerwUCHqhc3iB7QAF2Oovb7lrMW/P8SOnEBcmZOvgFS1+I
         ALSnTJvI55axzOf3k1vUYZTYDVlmTmSB3eYN1X6ihI7ScwtHrIY11uY1kAMKhosew2Zs
         WshkE07wNcab0IF63iH3AhB2HoMUpuD8sQDDe781Cy2ElgXi1KR/bOJS5m/WT6oJf27B
         kCgYvzZuGoxDXvfxhjOD6qcpCVGU1Z+9s6sn9kvoyP+iY1QwK7ESMFEAuUYJVEaO+uxW
         VxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790111131; x=1790715931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5UcDSQfjol8c/MRKdgxKYWGRN9zsJz0+FFVZfxAT1YE=;
        b=NH9UfrATKJVSCR6cXagDKrqZaUmn/0mLpGaDy6S01NNRTUI6XLnS1wOmwY9J2qtJr6
         cdw6YXha2X4jQHauC5pms0yTAvLESByaX22CSLRaWxpCubcVmtVhhtWxQhRFJn0yUYA5
         PFv70qAwdqqPfkyY0e9MLxBT2AVRG3+RBjYHZ90EKfX17LWlYjgLJ9Ce5GG9/aEuSIsb
         qnADTxjQjec11jfy05NYIds+LI9Q/bv34ATYY1hhoIrpIb3JbJ5MhqCcR8yv7q8yo8DD
         d+V6VRLmmpEg/01/bg6sQuqH/yJ6OjHC6eH4wX3L4t2PpIJbAF2ajUmtjBYYks/GqDW0
         e3bw==
X-Forwarded-Encrypted: i=1; AKwUvBxwbEM4vGwYjesA/34pJF7PJBJUnSVzLJXzQ7VrsoSYBxQLU4+Rwx4YDgrmlJ/S5AiqDgt920Ypl4yG+Q==@vger.kernel.org
X-Gm-Message-State: AFuF++klnfltBP29hbVN4RgdwW6UMx1xaqCebpOTK8Fi6E92Q7fzeTOW
	m4yluNPnTVHgct+RCViJJoYltDuKv5jWBaeXdA8FoAkRfhjMgRnK78kc
X-Gm-Gg: AYBFou3RKLqFsO9gHMXcD9F+AMMeeMnJSJUzl2GksWqpo3/oSfQLpUuufzrol1qz+PS
	QnpMVLwo3YZYY7Rgh3b/W0TIaIRlLcQ8XEVfuL/qQik1xmKwUuWzKtIa7hXehHI4V3qP55ZWv1L
	1j5S+tXlb1s01vO3tS2d7mcz1dfS2eWu+LKxug4bramogksOONF6W+GK+8tyL6okz4odu2LeDhg
	PVarCMmYpsoXM3/Om2+hgvccqHzc5DQW0SPlI6k2tMcwBUsErbugIfGLDM8oincEXDZMTfEHR/F
	IhqxpADXFiH+DdOPD2/InAlRU8JMKbtHon/ClBIJFVNWAdlpRm6o6BqM4EtuH1hp11cBseyzUW3
	1zosi9ZK2lTqBIfC/T+uolobmzh/iaPNZz0LKlGqkVxgI6aUFOx1TduAboL9lOyXXdn4Yc6QWMf
	WjdtSYq8i1r/SmQoVdIkl9NdogMUDpOcThKXuUuVCF/jtDz153YQgg7IFIvq0FMG7CQSLqQpF+k
	weGiog=
X-Received: by 2002:a05:6a21:e08c:b0:3da:ec28:2cc9 with SMTP id adf61e73a8af0-3ddf7e52c5bmr651260637.23.1790111130866;
        Tue, 22 Sep 2026 14:05:30 -0700 (PDT)
Received: from fedora ([2607:fb92:3080:83e3:3c6f:fd76:69b:10ff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1d5c1646sm300083b3a.30.2026.09.22.14.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 14:05:30 -0700 (PDT)
From: Ping Cheng <pinglinux@gmail.com>
X-Google-Original-From: Ping Cheng <ping.cheng@wacom.com>
To: lee@kernel.org,
	jikos@kernel.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org
Cc: stable@vger.kernel.org,
	Ping Cheng <ping.cheng@wacom.com>
Subject: [PATCH 2/2] HID: wacom: Setup SW_MUTE_DEVICE according to the order of input registration
Date: Tue, 22 Sep 2026 14:05:26 -0700
Message-ID: <20260922210527.22420-1-ping.cheng@wacom.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ping Cheng <ping.cheng@wacom.com>

The refactored SW_MUTE_DEVICE code assumed that stylus will be
the first regiestered input. In reality, touch can be registered
before stylus, such as the Wacom Cintiq Pro 13 and 16.

This patch covers both touch-first and stylus-first cases.

Cc: stable@vger.kernel.org
Fixes: ba16e5ffbaa1 ("HID: wacom: Advertise SW_MUTE_DEVICE capability prior to registration")
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
---
 drivers/hid/wacom_wac.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index c4cd87b781c4..9520296cb349 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -3977,10 +3977,12 @@ int wacom_setup_touch_input_capabilities(struct input_dev *input_dev,
 
 	if (features->type == HID_GENERIC) {
 		hid_dbg(hdev, "generic touch setup\n");
-		if (wacom_wac->has_mute_touch_switch ||
-		    (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch))) {
+
+		/* setup touch switch for those devices that report pen interface first
+		 * can only be done here since we only call this routine once
+		 */
+		if (wacom_wac->shared && READ_ONCE(wacom_wac->shared->has_mute_touch_switch)) {
 			input_set_capability(input_dev, EV_SW, SW_MUTE_DEVICE);
-			wacom_wac->has_mute_touch_switch = true;
 		}
 		/* setup has already been done */
 		return 0;
@@ -4403,7 +4405,21 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 		break;
 
 	case INTUOSHT3_BT:
+		break;
+
 	case HID_GENERIC:
+		if (wacom_wac->shared) {
+			/*
+			 * setup touch switch capability can only be done here
+			 * for those devices that have touch input registered
+			 * before stylus and pad inputs.
+			 */
+			if (wacom_wac->has_mute_touch_switch &&
+			    wacom_wac->shared->touch_input) {
+				input_set_capability(wacom_wac->shared->touch_input,
+				    EV_SW, SW_MUTE_DEVICE);
+			}
+		}
 		break;
 
 	default:
-- 
2.55.0

