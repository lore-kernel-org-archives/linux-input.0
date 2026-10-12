Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F6E3C1D66
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 22:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842551; cv=none; b=L7DgTI9/BgmwhIYvvxjZVHxf/0gt+cYBGvs6VKzKUE4cAqPOQp+4v631/jB+IsumvzOabs843SS9AKz8D+t/v0IikoeP5VMG+PbxEt9pJStQp/Cu89iupq7YlngAX45AFMUX7Yy5i1IZ9B7ArHJcp07MtoegVXt7KKVR0uiDkAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842551; c=relaxed/simple;
	bh=u+4RBqQ3qnd5BN/OvTzrflVmINUVUgX0ASpwstZ3+8U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kLqC3kZ4zD2n7wyxrDcQAbEB5a9KIQQdo58gi5F/H6/YhnbnZeZehCKwCPC/xyaVg2j+AaGxNEQKvrgmMM/Kcb17oNsb1QvYZ0sY4s7v+xJSBMyJdvoGV9mjIjopncK49Q3P9IViBp0NVKNbWrRHLJ+InFyXcpjnYcSRBX8ZTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiangzp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YEqY+DQY; arc=none smtp.client-ip=74.125.82.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiangzp.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YEqY+DQY"
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-139b62317d0so10336736c88.0
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 15:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791842549; x=1792447349; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dK37uDggPehTbaqCSmGG9mh9y9+JNNVrtr91iIxz57Y=;
        b=YEqY+DQYeVP4wkW5rFBceLSWyi4V/Mf41YAwvdhPO1sB/thzdvyM9UieXQCSZpeFh+
         cZv9tmtg5kajtXlUyLZV8sWsD4UhQxYxLqYawMgRx/BbWB2X+AeH4C/ofE39vVhSJpT3
         v++VUfOn26hrPXrerJcWUL8t6UoJHgVu2E+IWJR94xgOrRAgQix7KEE0Z/G0SFRsfXW8
         FL0VbU2xCedbgKJqgnndXpQEyjVQjNyRRLPz12tBhBmGpYxao27KjUPEbmrauUsyT5Nq
         +ee+1siAxvbK0jfeVwB4xFoj1RTZ2zzK+o/jZRpj1aCUA8ohocnTVrvIs4KI1IEKy+oN
         4/Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842549; x=1792447349;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dK37uDggPehTbaqCSmGG9mh9y9+JNNVrtr91iIxz57Y=;
        b=mPAYt3HLBT6EB2NAvCvURVMg9jIt3a2MDxXYtZcwSdtv+xq/yR0Pf6kkOJ78bxd6SP
         oFfSN8YrYD7ufVe9Uk8mF9AM4XRoeynP3AP6k1h+pZfw2T3IOz+fLMsOVIkKF5CIZRi7
         RGtexRcVSlk4uvxhymNVCPWCC4BOcxLsv3xa91aNm/cGPXPyK4DGeUXUn0rQc5xz8Q74
         JwsQNGG1WisqCo8sIpzsEygY0NWuup4Uw8FrrnReHku+Gl6fPRDalEGWYgRYL+la5Q2n
         BvcNqXgM2AOQozpxQUI0JilxVSoaCGt4LpVvRizvc9ikS27yAR/EIR6nukpqRydnk9ib
         Y9Ng==
X-Forwarded-Encrypted: i=1; AKwUvByIXKBnEln4778MhgqhblPYZwfRCRF7pCozSBYYqiwPL7di/rqPmwPjEkVt+Ek2mQWz7ik/xmfYXknrug==@vger.kernel.org
X-Gm-Message-State: AFq9FYL4KRvQTH32fiuyB6EwsQPHI3zIlnUiqwPP3iLte7EKJXXycRpF
	7EOgA6Vwo12TpLVWapqB6NmnWQdhEjPZZVnMWMSPElXGHVBcrStfkeBOjgC3GUR+hqorJXE1uTN
	fjxekj2R3JQ==
X-Received: from dycpg4.prod.google.com ([2002:a05:7300:dd04:b0:352:3ca9:9a5b])
 (user=jiangzp job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2411:b0:165:aced:1fde
 with SMTP id a92af1059eb24-16a4f2527efmr15339880c88.0.1791842548405; Mon, 12
 Oct 2026 15:02:28 -0700 (PDT)
Date: Mon, 12 Oct 2026 22:02:25 +0000
In-Reply-To: <20261012212902.3491839-1-jiangzp@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012212902.3491839-1-jiangzp@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012220225.3594376-1-jiangzp@google.com>
Subject: [PATCH v2] HID: vivaldi: avoid redundant feature report reads per usage
From: Zhengping Jiang <jiangzp@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Stephen Boyd <swboyd@chromium.org>, 
	Archie Pusaka <apusaka@google.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"

vivaldi_feature_mapping() is invoked by hidinput_configure_usages() in
ascending usage_index order for each usage in the top-row physical keymap
field. Because fetching the feature report at usage_index == 0 already
reads the entire report from hardware and populates field->value[] for all
usages in the field, calling hid_hw_raw_request() again for subsequent
usages redundantly reads the same report N times (e.g., 12 sequential BLE
GATT reads taking ~2s on Vivaldi BLE keyboards).

Fetch the feature report from hardware once per HID_USAGE_FN_ROW_PHYSMAP
field at usage_index == 0 before validating individual usage entries, and
reuse field->value[usage->usage_index] for subsequent usages in the field.

Fixes: 33bbe04a15f2 ("HID: google: extract Vivaldi hid feature mapping for use in hid-hammer")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---
Changes in v2:
- Move per-usage validation (HID_UP_ORDINAL and fn_key bounds) after the
  usage_index == 0 hardware read so the report is still fetched even if
  usage[0] is non-ordinal or out of bounds.

 drivers/hid/hid-vivaldi-common.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
index c3c9fe9e697b..94caaf254f69 100644
--- a/drivers/hid/hid-vivaldi-common.c
+++ b/drivers/hid/hid-vivaldi-common.c
@@ -33,21 +33,16 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 {
 	struct vivaldi_data *data = hid_get_drvdata(hdev);
 	struct hid_report *report = field->report;
-	u8 *report_data, *buf;
+	u8 *report_data, *buf = NULL;
 	u32 report_len;
 	unsigned int fn_key;
 	int ret;
 
-	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP ||
-	    (usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
+	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP)
 		return;
 
-	fn_key = usage->hid & HID_USAGE;
-	if (fn_key < MIN_FN_ROW_KEY || fn_key > MAX_FN_ROW_KEY)
-		return;
-
-	if (fn_key > data->num_function_row_keys)
-		data->num_function_row_keys = fn_key;
+	if (usage->usage_index)
+		goto parse_usage;
 
 	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!report_data)
@@ -92,6 +87,17 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 		goto out;
 	}
 
+parse_usage:
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
+		goto out;
+
+	fn_key = usage->hid & HID_USAGE;
+	if (fn_key < MIN_FN_ROW_KEY || fn_key > MAX_FN_ROW_KEY)
+		goto out;
+
+	if (fn_key > data->num_function_row_keys)
+		data->num_function_row_keys = fn_key;
+
 	data->function_row_physmap[fn_key - MIN_FN_ROW_KEY] =
 		field->value[usage->usage_index];
 
-- 
2.56.0.385.gd3acb90ef8-goog

