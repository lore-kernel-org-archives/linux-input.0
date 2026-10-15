Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCAC469850
	for <linux-input@vger.kernel.org>; Thu, 15 Oct 2026 06:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046553; cv=none; b=D3eBdjy0zp5spMAXf83u6WauRZuv8wgC7XvpX/BHPs89FNEfMnpgMTFh7xyPbLl83C9BPKflHruGdQYtqFBCYGDK9njm2+XlYm8MjQntnz5VQ2wK69xg6nrZGw/B7q/ZtTGrC0UG9dd8M8MvR4iiNjZL5uf26E9/18fZFB3/H7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046553; c=relaxed/simple;
	bh=ggn8bVnKJA7RHxnagUCHzG2BcdHrEmbAPi5sFWORlCE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I3+P81dKKHtcIK2LGVSknNrx8JM2qo2P5D6StfGXCJcAquZ4MYUAAQ7Gued5v5DSMlTsHqcKqH24xuhWg3uBhVM+V45ccLu9NxGMeFDg8sbbS+UkOqG2TW1UvdolGnFvHnvkcm9epgzUV6tBD+6gX3Thd7W1wSx86lAGw7IUnyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiangzp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6qE9L6o; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiangzp.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6qE9L6o"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-155a75f91e1so1255887c88.1
        for <linux-input@vger.kernel.org>; Wed, 14 Oct 2026 23:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792046550; x=1792651350; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CWLkBV9BBgDEhHUePIRuI9XTWV7QJLsODe5VGAKrDB0=;
        b=h6qE9L6oAReYZJOkCTL2XJ+xvRhV5YoVsgUWY3CsgMeB6llEKDKj8vBmJS4/BOphnD
         hnXiiNne/OHZCNzwlV1hYHmTHHkZX6Gc0B6REo2ekRJgT+dP29+LeR6eVc7wuJFIoNrx
         5qbl0ylyM/aM9IDuNAej4Z62zLXgaMtCh1Sc/U0jZpA5El9gV5spmPZ5xhobLz253jE+
         BUYcWdTXKJLnImMRBwGqNd3dOn3SOAzrrOIcDzfhxoYYVgK77mNcP3Ki2q1KL9VRTIj4
         dFfC9vaEimWaSWuOncqZa2NVWFwPKj1eLGceKUOz2voRcxDiW4yebFpEMYFwZ8uXbe5a
         WZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792046550; x=1792651350;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CWLkBV9BBgDEhHUePIRuI9XTWV7QJLsODe5VGAKrDB0=;
        b=pCdFJ6qB8MjtK440MhqeMp3HYNG+uR6ORORVl7wP9IlbduJUU1RwVbrXg1N/ph/Ecw
         7Lk0jhGoP4burf2GqHMIj6Tr8z0pj8xuxq4m5zec7M1FBYqc/LbZvpeurGaJIRFoHOAw
         hk5PoRyVW1aOqpYc098QmRv89KF5aVcOapENx2GI7nMak0AM4Xe6eec13HcWYFDU+yKO
         vbXHIzwWTp363cwEOhTSbLTYc6J2Dv6sJsTjvKY1tb/yvWzrTF0y5rGxwXeZykRnecfT
         VbYZeSVG0AvMq0z3IrgIx6rmLXRAYA3ukzlUcUcThE7B6bdUgFWdYPvgnOY47ATtNZnQ
         oicg==
X-Forwarded-Encrypted: i=1; AKwUvBxJvTjsw0WopVjBtHr9RyPW0Qtp+2lMicAxfo3Fv1i2zPhNkP0YfFdTMTHZoh9XPdPPvPcN2R0a8IOm5A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKRc8pvz9GMU3CIR2RZRhFfkrik3kq/w7Ayf+zAPEVCK1YF/MSf
	7HARQiiljrQMNHGy1OA3DxcXU8v6+mgPV4dvbAFYYFfFfHdS/DXvUKrqjiU9EchsOR+Dd6cmkXz
	10BEd46tsRQ==
X-Received: from dldyr19-n2.prod.google.com ([2002:a05:701b:4513:20b0:143:75c2:6d21])
 (user=jiangzp job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e804:b0:13c:f65c:d5b5
 with SMTP id a92af1059eb24-16a0b37d130mr26218964c88.3.1792046549601; Wed, 14
 Oct 2026 23:42:29 -0700 (PDT)
Date: Thu, 15 Oct 2026 06:42:23 +0000
In-Reply-To: <01c8cf7d695261ba8270ff57aa8f2a6f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <01c8cf7d695261ba8270ff57aa8f2a6f@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261015064223.1939367-1-jiangzp@google.com>
Subject: [PATCH v4] HID: vivaldi: avoid redundant feature report reads per usage
From: Zhengping Jiang <jiangzp@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Sean O'Brien" <seobrien@chromium.org>, Shashikirana H K <shashikiranah@chromium.org>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"

vivaldi_feature_mapping() is invoked by report_features() in ascending
usage_index order for each usage in the top-row physical keymap field.
Because fetching the feature report at usage_index == 0 already reads
the entire report from hardware, calling hid_hw_raw_request() again for
subsequent usages redundantly reads the same report N times (e.g., 12
sequential BLE GATT reads taking ~2s on Vivaldi BLE keyboards).

Bail out immediately when usage->usage_index != 0, fetch the feature
report once at usage_index == 0, and iterate over all usages in the
field to populate data->function_row_physmap[].

Fixes: 33bbe04a15f2 ("HID: google: extract Vivaldi hid feature mapping for use in hid-hammer")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---
Based on "[PATCH v2] HID: vivaldi: Extract feature report value directly in vivaldi_feature_mapping()":
https://lore.kernel.org/r/20261013-upstream-vivaldi-fix-v2-1-ecc20329d24c@chromium.org

Changes in v4:
- Rebase on top of Shashikirana's patch using hid_field_extract() and
  __free(kfree), as suggested by Dmitry Torokhov.
- Return immediately when usage->usage_index != 0, fetch the report once
  at usage_index == 0, and loop over all usages in the field so failed
  reads do not update num_function_row_keys or expose an all-zero keymap.
- Fix caller name in commit description (report_features()).

Changes in v3:
- Add comment explaining why the report is only read at usage_index == 0
  and how failed reads rely on zero-initialized field->value[].
- Jump/fall through to parse_usage on read failure.

Changes in v2:
- Move per-usage validation (HID_UP_ORDINAL and fn_key bounds) after the
  usage_index == 0 hardware read.

 drivers/hid/hid-vivaldi-common.c | 33 +++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
index 1359a107e63b..973393d09356 100644
--- a/drivers/hid/hid-vivaldi-common.c
+++ b/drivers/hid/hid-vivaldi-common.c
@@ -39,19 +39,11 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 	unsigned int offset;
 	u32 report_len;
 	int ret;
+	int i;
 
-	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP ||
-	    (usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL ||
-	    usage->usage_index >= field->report_count)
+	if (field->logical != HID_USAGE_FN_ROW_PHYSMAP || usage->usage_index)
 		return;
 
-	fn_key = usage->hid & HID_USAGE;
-	if (fn_key < MIN_FN_ROW_KEY || fn_key > MAX_FN_ROW_KEY)
-		return;
-
-	if (fn_key > data->num_function_row_keys)
-		data->num_function_row_keys = fn_key;
-
 	u8 *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
 		return;
@@ -74,9 +66,24 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 		return;
 	}
 
-	offset = field->report_offset + usage->usage_index * field->report_size;
-	data->function_row_physmap[fn_key - MIN_FN_ROW_KEY] =
-		hid_field_extract(hdev, buf + 1, offset, field->report_size);
+	for (i = 0; i < field->maxusage && i < field->report_count; i++) {
+		usage = &field->usage[i];
+
+		if ((usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
+			continue;
+
+		fn_key = usage->hid & HID_USAGE;
+		if (fn_key < MIN_FN_ROW_KEY || fn_key > MAX_FN_ROW_KEY)
+			continue;
+
+		if (fn_key > data->num_function_row_keys)
+			data->num_function_row_keys = fn_key;
+
+		offset = field->report_offset + i * field->report_size;
+		data->function_row_physmap[fn_key - MIN_FN_ROW_KEY] =
+			hid_field_extract(hdev, buf + 1, offset,
+					  field->report_size);
+	}
 }
 EXPORT_SYMBOL_GPL(vivaldi_feature_mapping);
 
-- 
2.56.0.385.gd3acb90ef8-goog

