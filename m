Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B48434D4FA;
	Mon,  4 May 2026 08:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884474; cv=none; b=qdmW1X+M0QxeGLyC1dfLpwxLb52s/rzcx0y1TUQNkyaHbe7nQ2d2N4SGVlmW+57ZEmKab/lBxgqJyTsXSzE3XqXUdqBvlL35ogwNOGM86xzAGznlwMoJHytcjNJjkJ8OjgcePb1OWQHeRLouU/N71Bfk7UCO+BuMh2WVJc/FW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884474; c=relaxed/simple;
	bh=LcCUxJZ9vDXuOX5QsjD4mqmdPrRKSI5jsjauA/s8Qsg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=chrHoISDnFU7sIwUm9GzaOA/ye1EsOCJhvFMjC319kK0+wBgelm1k5fvWUjiZh5cmY7trTNNd7pfUq3Mup7suAlUys0u/W6rtQUguagsfrDkXY0CK03+nPyUYjgHfC/ivWDl0vtaYdF2IYlGxwuUKr2eJ/BhiBtmXummaMzPWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJEbFzGO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJEbFzGO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303D5C2BCF4;
	Mon,  4 May 2026 08:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777884474;
	bh=LcCUxJZ9vDXuOX5QsjD4mqmdPrRKSI5jsjauA/s8Qsg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oJEbFzGO/HeaDcyQfs9EYHpLd5MGXMATak+RRUXiV3D5Qx9mkVGrRjQBqbW1YkIV6
	 quXO9WD9nbWEb3BTD1Cnmabm1ar9pSOmNNebiSo1C+VlBR9ilEpOzVA07hVJHu1WHs
	 xLM9LlIhS5LhYGl08iGbeOAWFi/6ANvF+B7jS6IJlIpjNyAdpmIy49ZJsxlXTK/dPd
	 FQUzug4JkKk/d7Hvx4s0ZmCOurDxeo9/gAOgWoNAl8oeN5c6uID2eLzbv+aiSi94Vr
	 03ZxNgdgosMVptmq7fhufGFzkriFkkVf1zdIbduNsvt42LDvTtzaOCSO0ch/UDthCv
	 nHZUtztBz2k7w==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Mon, 04 May 2026 10:47:24 +0200
Subject: [PATCH v3 3/4] HID: multitouch: use __free(kfree) to clean up
 temporary buffers
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-wip-fix-core-v3-3-ce1f11f4968f@kernel.org>
References: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
In-Reply-To: <20260504-wip-fix-core-v3-0-ce1f11f4968f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Ping Cheng <ping.cheng@wacom.com>, 
 Jason Gerecke <jason.gerecke@wacom.com>, Viresh Kumar <vireshk@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: Icenowy Zheng <uwu@icenowy.me>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org, 
 linux-staging@lists.linux.dev, linux-usb@vger.kernel.org, 
 Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777884459; l=2586;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=LcCUxJZ9vDXuOX5QsjD4mqmdPrRKSI5jsjauA/s8Qsg=;
 b=BR42A1lrnPuRPFKsvC0KYNwOErDyVZ7Eg+qiAzaOplp9OLE8nEWArXfGLIfCFj0HRRhHH7wU6
 2axtBUqFVXwAtDuLY1US0Lrl/AdYYD5GL1txUO2cXLdZ7luUy7bfM2Y
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This simplifies error handling and protects against memory leaks.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-multitouch.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index eeab0b6e32cc..b19463e545d6 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -507,7 +507,6 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 {
 	int ret;
 	u32 size = hid_report_len(report);
-	u8 *buf;
 
 	/*
 	 * Do not fetch the feature report if the device has been explicitly
@@ -516,7 +515,7 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 	if (hdev->quirks & HID_QUIRK_NO_INIT_REPORTS)
 		return;
 
-	buf = hid_alloc_report_buf(report, GFP_KERNEL);
+	u8 *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
 	if (!buf)
 		return;
 
@@ -529,7 +528,7 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 		/* The report ID in the request and the response should match */
 		if (report->id != buf[0]) {
 			hid_err(hdev, "Returned feature report did not match the request\n");
-			goto free;
+			return;
 		}
 
 		ret = hid_report_raw_event(hdev, HID_FEATURE_REPORT, buf,
@@ -537,9 +536,6 @@ static void mt_get_feature(struct hid_device *hdev, struct hid_report *report)
 		if (ret)
 			dev_warn(&hdev->dev, "failed to report feature\n");
 	}
-
-free:
-	kfree(buf);
 }
 
 static void mt_feature_mapping(struct hid_device *hdev,
@@ -1658,7 +1654,6 @@ static bool mt_need_to_apply_feature(struct hid_device *hdev,
 	struct mt_class *cls = &td->mtclass;
 	struct hid_report *report = field->report;
 	unsigned int index = usage->usage_index;
-	char *buf;
 	u32 report_len;
 	int max;
 
@@ -1673,17 +1668,18 @@ static bool mt_need_to_apply_feature(struct hid_device *hdev,
 			return false;
 
 		if (cls->quirks & MT_QUIRK_FORCE_GET_FEATURE) {
-			report_len = hid_report_len(report);
-			buf = hid_alloc_report_buf(report, GFP_KERNEL);
+			char *buf __free(kfree) = hid_alloc_report_buf(report, GFP_KERNEL);
+
 			if (!buf) {
 				hid_err(hdev,
 					"failed to allocate buffer for report\n");
 				return false;
 			}
+
+			report_len = hid_report_len(report);
 			hid_hw_raw_request(hdev, report->id, buf, report_len,
 					   HID_FEATURE_REPORT,
 					   HID_REQ_GET_REPORT);
-			kfree(buf);
 		}
 
 		field->value[index] = td->inputmode_value;

-- 
2.54.0

