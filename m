Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C138453E302
	for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919404; cv=none; b=Us4+Iq4oG92IahZQoeYQPXsuM9rPRASABTe8pt9+4mrtDpA+4SkOlMma3Lsaar1+n9A40C32/zRYRqqi9kErKW8i6BCmePxZI/yHRr0KLI8TehB5GplQKjZGIG80NtMKoB85exbHjIgk2qMziWdYrX0LEtmJr24Ztl+lmLRUql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919404; c=relaxed/simple;
	bh=g2qxUy7IFikV6xUmbIyhiAzQ6YzIq1HUqLdaIb5t1mY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jwXKnGMP3ULcjzcE+KSwgB4ycTujSbsTVsxPecP1nj0wik+2QJZWctwmlrYLudCo9fiZ+yHkESFBSjJONNo9BQS9U+arvwDM5qubxxcoj532D9nefX729akIqllWTSwIwxcVouFwqBGIpxY1Ub5mr+92vL6UIkoHXqjpP/aRSV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiangzp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hOsEzCNi; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiangzp.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hOsEzCNi"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-35d4538fd74so1139738eec.1
        for <linux-input@vger.kernel.org>; Tue, 13 Oct 2026 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791919402; x=1792524202; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lEEdqCEQUD4T9M1eE5hxDiuhPAtkdgQ/QcKfOV1qWHk=;
        b=hOsEzCNiK4MKjF9bMqH9pExzZDKArax/dvIvBhsq3yNT8JIweQqP4x5/hHBL50dqBC
         CmzZgLgt+68Sve/gtAWYIS9VVT4ohMNvTH6Sly0f87jNQ/IDwOOOq2SzznGbBdvMqy1n
         cuOpyiuxAxvsd6gd9sN64+yEeYHM2By5PLsOB7LtWRXKMSUC5pVNFFTLyIVWg6j6kFAq
         UgWz7MOh4Rly2t+pYK7ovEAYVQebodlT6TiOejP4kZj4OENIwjFE4MhCnCvdCq1h3+hn
         6EjxenKVEABoSsrjVAihjE/1Cz4FOF4eVmAJe+MABJVkYVYr+oBV+RkT+cSgIrGuXmHE
         FGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919402; x=1792524202;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lEEdqCEQUD4T9M1eE5hxDiuhPAtkdgQ/QcKfOV1qWHk=;
        b=FBnBxAvSJHYpnYHxCCyaVRe+LPXKwg0dE2rvJcnqB/uqzS9kavN+bzqdanlONNL7pH
         cvUto89jTdbPAl6iRFAcxtIvG+q1IuiPVkocuPN0kJMClmewrAoPDCh2RH+2xu8RuY5o
         Xnppr8Mgw4rmypyhZf8dlgUUJ7fw6nWOEyy1LJlleqnIOqT2ssQULGN6G4WiUEFRUds3
         xZD1PjfAOB1FOZ5sCSBYP/gdweKKxa+HJ4BmE5hXREbZPTMQt2Q2Oibp5mOjmXAjJa4M
         xIN1YACvjInGRWsC/YJjHX302g6YBczVIdiwmKfTS1RDY34quk8HGPDVM6FNVPfWAoMi
         S0gw==
X-Forwarded-Encrypted: i=1; AKwUvBzEQssmNv1Ymd8zXHL8w/RstitB3fFYdR6Pa6/h6msH/peVPZPwYVRjIBhqKU7c5cpNkqdsYJZ1Z8rYEQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJkj961wxy4x4VKSqSMtilJW1NeVeVIHSXdP3SgWsh1D7QOBio5
	j62XyHy05ktolEmF9ugDoYrcBXIpKIeCiw9cFlM6JiMXYLkJrz0jvaI1nTiHUIcpsBlsbdgF9Ri
	rqG1zI9PV/g==
X-Received: from dybgx38.prod.google.com ([2002:a05:7301:2426:b0:352:745b:e97e])
 (user=jiangzp job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:20d1:20b0:35c:a8da:c525
 with SMTP id 5a478bee46e88-35ca8dad3a3mr3370915eec.31.1791919401241; Tue, 13
 Oct 2026 12:23:21 -0700 (PDT)
Date: Tue, 13 Oct 2026 19:23:18 +0000
In-Reply-To: <20261012220225.3594376-1-jiangzp@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261012220225.3594376-1-jiangzp@google.com>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261013192318.1828453-1-jiangzp@google.com>
Subject: [PATCH v3] HID: vivaldi: avoid redundant feature report reads per usage
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
Changes in v3:
- Add comment explaining why the report is only read at usage_index == 0
  and how failed reads rely on zero-initialized field->value[].
- Jump/fall through to parse_usage on read failure so usage_index == 0
  updates num_function_row_keys consistently with subsequent usages and
  preserves original behavior when only one usage is present.

Changes in v2:
- Move per-usage validation (HID_UP_ORDINAL and fn_key bounds) after the
  usage_index == 0 hardware read so the report is still fetched even if
  usage[0] is non-ordinal or out of bounds.

 drivers/hid/hid-vivaldi-common.c | 34 +++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
index c3c9fe9e697b..2d85555289d8 100644
--- a/drivers/hid/hid-vivaldi-common.c
+++ b/drivers/hid/hid-vivaldi-common.c
@@ -33,21 +33,22 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
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
+	/*
+	 * Read the feature report only at usage_index == 0, as a single read
+	 * populates field->value[] for all usages in the field. If the read
+	 * fails, subsequent usages will not re-read the report and will rely
+	 * on field->value[] being zero-initialized.
+	 */
+	if (usage->usage_index)
+		goto parse_usage;
 
 	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!report_data)
@@ -72,7 +73,7 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 	if (ret < 0) {
 		dev_warn(&hdev->dev, "failed to fetch feature %d\n",
 			 field->report->id);
-		goto out;
+		goto parse_usage;
 	}
 
 	if (!report->id) {
@@ -86,11 +87,20 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 
 	ret = __hid_report_raw_event(hdev, HID_FEATURE_REPORT, report_data,
 				     report_len, report_len, 0);
-	if (ret) {
+	if (ret)
 		dev_warn(&hdev->dev, "failed to report feature %d\n",
 			 field->report->id);
+
+parse_usage:
+	if ((usage->hid & HID_USAGE_PAGE) != HID_UP_ORDINAL)
 		goto out;
-	}
+
+	fn_key = usage->hid & HID_USAGE;
+	if (fn_key < MIN_FN_ROW_KEY || fn_key > MAX_FN_ROW_KEY)
+		goto out;
+
+	if (fn_key > data->num_function_row_keys)
+		data->num_function_row_keys = fn_key;
 
 	data->function_row_physmap[fn_key - MIN_FN_ROW_KEY] =
 		field->value[usage->usage_index];
-- 
2.56.0.385.gd3acb90ef8-goog

