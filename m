Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300CB3BF68D
	for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840560; cv=none; b=oEJgB0s2YmrlH+uJKsuDjW/S67ChgH72ahJlWn+DnezoO+z7xbwqmW5RdYu43geT6nLohEexuJ1E7hXSEP3m4ztTR3cTXp3AUDafOwHq25xEOE+W4K49LiKj0IUR58/zpzwvRoEA7aXBe6qymB3/u7fLUINkwkaCJnt90/+eot8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840560; c=relaxed/simple;
	bh=aRKMbIGGKLQZB5T9Mq5bX2WoGw64VZBibz5j826Kskg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jvb8JN72IfC5oM63Ymnrm/wvlPGb2Qx8/KJuMmo8GKGMSwFQOwbieppbQKPpk3nTmqSSzBGIUklm00v5c37Juncd1Ik9r1nQOFLG+N4fDxUzTp+dchLaZyMeHO6LYf/A59UfH2lE/XTm76w6OmbFa2ha7Mo9YXh1hcsFOs7QQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiangzp.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rmsPW6qS; arc=none smtp.client-ip=74.125.82.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiangzp.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rmsPW6qS"
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-147be78cd56so9327700c88.1
        for <linux-input@vger.kernel.org>; Mon, 12 Oct 2026 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791840558; x=1792445358; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Sfy4MAE5xrKVWAYhshU9QLY8Lh9h2prWnQYSdhiJr0=;
        b=rmsPW6qSheNG2A5GXI6Mda2Bi1YWkE1Z5fWcBAeqtWe5Q6kxUOhJtjmjdHtBY7mkzn
         DMuprobZcc1N00EHDVFOPM/Nr+DMBwFX/MMQpA4oXXKJES19wVPqEAg0GH6CP09vFnwO
         EG4eLVGCf5S4tAzV79xj1+XGitfHEcp+tmBEV+wqv6/tPpBQ0Paz8wyH6h+PAySJuZyn
         0CSqM6+5ir960EyQFDaKnOfOmAxUm4jYZ4g7b4fB+1jGFzpgBVy6spC3igC1jShski3S
         vX5/36dnlig2vQhTzV574sGO/y2TLeW+3qdQfmz/aH6KoBF7uKlF4sYnC1lV5cYH2Dae
         YdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840558; x=1792445358;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Sfy4MAE5xrKVWAYhshU9QLY8Lh9h2prWnQYSdhiJr0=;
        b=DMsP1EDG4srGBHvt8Zuvovu7kyvjk/JGbQUiMAwa/cG/daO4hkgJp5cUBQIoOKhgx0
         fOpteUSfyaoAZTX5zQsh1nCPeJQ1ta6ZRdSB1AT4qP0+JTrAQDoylVkd4WlcHHUOvTOf
         OgjDirKDcjatVOa5xnT3W0Qgb67SS5c2QCKO70qsOcbJoXUazOLcQRCLCDzNLkiMtU5K
         ao6hWGf9CC7IhyPwqDS/CQhKAqqMJJvwEGHm4QOMGtmOgzfu+F+av66TEWqGzWQKuasB
         OWAqmHoIlNbhYog4JKMx4LwTxUeZ+m71FWm3CQwZoxsKzubK+GjLAmBfYEcNa02RwQUd
         jUDA==
X-Forwarded-Encrypted: i=1; AKwUvBzLa4GGjiLLCldVwCaaoPAY4S7aioAYqAjOUxP1NnGpkTmaOpvtW8u4OtIVy1U3J/Z02/KI/i6liXvjPg==@vger.kernel.org
X-Gm-Message-State: AFq9FYI1hvH+Um74GbGVpNcplmDN0DDZJuo9L7dS/KRtvBu3zv2HWllA
	2CsQayrxK7TQbhsu4/71Jrz+uqblzKaj8YCsvUCEZ0oItwh494j2Kn/r632thwRdJQ5kgl8+K8f
	H6Zn5+dXcZQ==
X-Received: from dlep17-n2.prod.google.com ([2002:a05:701b:4591:20b0:14a:c841:ce30])
 (user=jiangzp job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e11:b0:145:3a5:d918
 with SMTP id a92af1059eb24-16a640fd0admr22091007c88.33.1791840557790; Mon, 12
 Oct 2026 14:29:17 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:29:02 +0000
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Message-ID: <20261012212902.3491839-1-jiangzp@google.com>
Subject: [PATCH] HID: vivaldi: avoid redundant feature report reads per usage
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

Only fetch the feature report from hardware on the first usage
(usage->usage_index == 0) and reuse field->value[usage->usage_index] for
subsequent usages in the field.

Fixes: 33bbe04a15f2 ("HID: google: extract Vivaldi hid feature mapping for use in hid-hammer")
Signed-off-by: Zhengping Jiang <jiangzp@google.com>
---
 drivers/hid/hid-vivaldi-common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hid/hid-vivaldi-common.c b/drivers/hid/hid-vivaldi-common.c
index c3c9fe9e697b..cfee7be4d759 100644
--- a/drivers/hid/hid-vivaldi-common.c
+++ b/drivers/hid/hid-vivaldi-common.c
@@ -49,6 +49,12 @@ void vivaldi_feature_mapping(struct hid_device *hdev,
 	if (fn_key > data->num_function_row_keys)
 		data->num_function_row_keys = fn_key;
 
+	if (usage->usage_index) {
+		data->function_row_physmap[fn_key - MIN_FN_ROW_KEY] =
+			field->value[usage->usage_index];
+		return;
+	}
+
 	report_data = buf = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!report_data)
 		return;
-- 
2.56.0.385.gd3acb90ef8-goog

