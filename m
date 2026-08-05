Received: from mx.hiro.moe (mx.hiro.moe [118.91.186.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881023DAAC5;
	Wed,  5 Aug 2026 19:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.91.186.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785956866; cv=none; b=YCFPypYeQ61ttT3TYv7r7h3zCT0efmvPemZ5fzkRA35+xcW/B63pE4wQ1WXUpkGGbfIjNhiRemaLMdw3phUl1TSdFArCtZiYh+zmqo+2SQaffSa4St9kvKyLjMgSX1jz5PWzekkrorBChJI82BsqjK8jXpjdVtwARjyiGFA3wmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785956866; c=relaxed/simple;
	bh=LcfOuQL/DTf+VuNERCxYkeZGTFdnIPrpgO4tHX6l0v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QR8x11donaORSS8TD/ltXIErsutWkycakcnA3cgZP1jBb9alDlrfIdsZsSqbSXgQM1rVwwPZfSVs0MA1KnWkQzYpEhPSCQiyAVtsQHWSVKneyt0w/iAiEGsS5rO91KoUmyb1JsduR3wAL0jNuL25EePHuvScnf5dRt2W9aToGWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bakabaka9.tech; spf=pass smtp.mailfrom=bakabaka9.tech; dkim=pass (2048-bit key) header.d=bakabaka9.tech header.i=@bakabaka9.tech header.b=RM7x/1DH; arc=none smtp.client-ip=118.91.186.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bakabaka9.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bakabaka9.tech
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bakabaka9.tech header.i=@bakabaka9.tech header.b="RM7x/1DH"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBF53C99E5;
	Thu,  6 Aug 2026 02:58:12 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bakabaka9.tech;
	s=dkim; t=1785956295; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=lvYoLdsKTcl0fSewV/cx+DkK9/GJsf16sAKIu/NWIVc=;
	b=RM7x/1DHlrEhscKnRluSrdgfTCWts4zXjl+WtSFS0Sy+rmfRxXnh3tLOvvqWloPECHjQjX
	7xCBMur8lelytBoec5sSQKOSFipS1l91PM2p75pAJRrp79Xrjwl7Ix3GUGEVnOogQE6+6P
	vipwIXBwA0VHH78KnS27XX45LgZodVUzXCxF+dIodYrJSMO8JZpToBih3xRV/TzzkNQ1Vk
	DsE21/78X6ZP9H0uQnb+s5WpPXmGwewaYly1f+cxnODUiGNJKLOUBJ0fcXcMqAyu2JDFvn
	MavtD0jMNq4kv2zMLtMWpxX2wwKLHfmFEBF/DhT7R85k3j+2muWrHm98Vjjtkg==
From: bakabaka9 <baka9@bakabaka9.tech>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Xingrui Li <baka9@bakabaka9.tech>,
	stable@kernel.org
Subject: [PATCH v2 RESEND] HID: sensor-hub: Fix out-of-bounds write in sensor_hub_get_feature
Date: Wed,  5 Aug 2026 18:57:53 +0000
Message-ID: <20260805185753.3069-1-baka9@bakabaka9.tech>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Xingrui Li <baka9@bakabaka9.tech>

sensor_hub_get_feature() clamps its return value to the caller's buffer
size, but the copy loop still copies field->report_size / 8 bytes for
each report value. A malicious HID descriptor can advertise a large
feature field size while an IIO caller supplies a small stack buffer,
such as a single s32, causing an out-of-bounds write.

HID core stores parsed report values in __s32 slots and clamps extracted
values to 32 bits. Reject feature fields that require more than one slot
per value, guard the total byte count calculation, and clamp each
per-value copy to the remaining caller buffer.

Fixes: 5459ada2b3cd69 ("HID: sensor-hub: Fix packing of result buffer for feature report")
Cc: stable@kernel.org
Assisted-by: OpenAI:GPT-5.5-Cyber
Signed-off-by: Xingrui Li <baka9@bakabaka9.tech>
---
 drivers/hid/hid-sensor-hub.c | 42 +++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 34f710c465b8..6470a290ebfc 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -239,12 +239,17 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 			   u32 field_index, int buffer_size, void *buffer)
 {
 	struct hid_report *report;
+	struct hid_field *field;
 	struct sensor_hub_data *data = hid_get_drvdata(hsdev->hdev);
-	int report_size;
+	size_t field_size;
+	size_t report_size;
+	size_t copied = 0;
+	size_t to_copy;
 	int ret = 0;
-	u8 *val_ptr;
-	int buffer_index = 0;
-	int i;
+	unsigned int i;
+
+	if (!buffer || buffer_size <= 0)
+		return -EINVAL;
 
 	memset(buffer, 0, buffer_size);
 
@@ -258,26 +263,29 @@ int sensor_hub_get_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
 	hid_hw_request(hsdev->hdev, report, HID_REQ_GET_REPORT);
 	hid_hw_wait(hsdev->hdev);
 
+	field = report->field[field_index];
+
 	/* calculate number of bytes required to read this field */
-	report_size = DIV_ROUND_UP(report->field[field_index]->report_size,
-				   8) *
-				   report->field[field_index]->report_count;
-	if (!report_size) {
+	field_size = DIV_ROUND_UP(field->report_size, 8);
+	/* HID core stores each parsed report value in a __s32 slot. */
+	if (!field_size || field_size > sizeof(field->value[0])) {
+		ret = -EINVAL;
+		goto done_proc;
+	}
+	if (field->report_count > SIZE_MAX / field_size) {
 		ret = -EINVAL;
 		goto done_proc;
 	}
-	ret = min(report_size, buffer_size);
 
-	val_ptr = (u8 *)report->field[field_index]->value;
-	for (i = 0; i < report->field[field_index]->report_count; ++i) {
-		if (buffer_index >= ret)
-			break;
+	report_size = field_size * field->report_count;
+	report_size = min_t(size_t, report_size, buffer_size);
 
-		memcpy(&((u8 *)buffer)[buffer_index], val_ptr,
-		       report->field[field_index]->report_size / 8);
-		val_ptr += sizeof(__s32);
-		buffer_index += (report->field[field_index]->report_size / 8);
+	for (i = 0; i < field->report_count && copied < report_size; ++i) {
+		to_copy = min(field_size, report_size - copied);
+		memcpy(&((u8 *)buffer)[copied], &field->value[i], to_copy);
+		copied += to_copy;
 	}
+	ret = copied;
 
 done_proc:
 	mutex_unlock(&data->mutex);
-- 
2.43.0

