Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A22937F748
	for <linux-input@vger.kernel.org>; Sat, 13 Jun 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781364650; cv=none; b=nx0GGHS+0+pylFaoQ2B4ZwxJbEU+3tjrgmNIGKFeEQd2ZfW2d0g47UWGXv4qqcyRrR99rxJCje8PWk8dpjt+IFgVh8+1gXv5xVjKUuZsZxUyuQV765yFbSMmP4F1wKg00Bj1+r2vVNbl7++pDlBUVzTg7asJWnNu75R7vSRFEiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781364650; c=relaxed/simple;
	bh=/NkXRBdpBcvCQDy0NVB1p+IEdH3M8AYrYBio8yu7EFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qMqXkch1Le9uWjZEyReZtHySD6mSBuKSWA4esTzayWpg2ikWGvIIpMyEshq6XtBK2f1wJVU0GDCb3L46+cwB4Vp5mIrcgboMgn3FbvFTs6eVuTfoBJ5XVSkwrVReB+MQzL2WsoFt84oCTvbpriKSAcsWLketnCexUOkwi/eFCTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DTsFOVOY; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DTsFOVOY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781364638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=neHECkpkrl0f2eL1rmrqpo8oK4ZifRZpF3yJLogXsSs=;
	b=DTsFOVOYlFt47fsRnqmMYYTPb5BPgctaJhFpPsKYnPmqzHrC2YsrbIm+oHsjGtS8yWG+qi
	Vbp035iozZHkSgSs9N9pqCbuGQyDY3WqJ82Cs3dtlzyE899fMsAJDfykWBkPrIg2psWLSb
	ReeaV9hdAhEYKVlw5jKBK5pBYiGKKnI=
From: Denis Benato <denis.benato@linux.dev>
To: linux-kernel@vger.kernel.org
Cc: linux-input@vger.kernel.org,
	"Benjamin Tissoires" <bentiss@kernel.org>,
	"Jiri Kosina" <jikos@kernel.org>,
	"Luke D . Jones" <luke@ljones.dev>,
	"Mateusz Schyboll" <dragonn@op.pl>,
	"Denis Benato" <benato.denis96@gmail.com>,
	"Denis Benato" <denis.benato@linux.dev>,
	"Antheas Kapenekakis" <lkml@antheas.dev>,
	"Connor Belli" <connorbelli2003@gmail.com>,
	sahiko-bot@kernel.org
Subject: [PATCH v3 5/8] HID: asus: avoid sleeping calls in atomic context
Date: Sat, 13 Jun 2026 15:30:26 +0000
Message-ID: <20260613153029.2559774-6-denis.benato@linux.dev>
In-Reply-To: <20260613153029.2559774-1-denis.benato@linux.dev>
References: <20260613153029.2559774-1-denis.benato@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Avoid possibly calling asus_wmi_send_event(): a method that can sleep in
asus_raw_event() that is called in atomic context.

This commit changes when methods are called, not method parameters:
the driver behaves as before.

Fixes: 1489a34e97ef ("HID: asus: Implement Fn+F5 fan control key handler")
Reported-by: sahiko-bot@kernel.org
Signed-off-by: Denis Benato <denis.benato@linux.dev>
---
 drivers/hid/hid-asus.c | 67 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index f38b18ad65c6..a6467172c455 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -150,6 +150,13 @@ struct asus_drvdata {
 	unsigned long battery_next_query;
 	struct work_struct fn_lock_sync_work;
 	bool fn_lock;
+#if IS_REACHABLE(CONFIG_ASUS_WMI)
+	struct work_struct wmi_work;
+	bool wmi_work_disabled;
+	u8 wmi_data[FEATURE_KBD_REPORT_SIZE];
+	int wmi_size;
+	spinlock_t wmi_lock;
+#endif
 	struct asus_xgm_led *xgm_led;
 };
 
@@ -338,6 +345,7 @@ static int asus_e1239t_event(struct asus_drvdata *drvdat, u8 *data, int size)
 	return 0;
 }
 
+#if IS_REACHABLE(CONFIG_ASUS_WMI)
 /*
  * Send events to asus-wmi driver for handling special keys
  */
@@ -361,6 +369,32 @@ static int asus_wmi_send_event(struct asus_drvdata *drvdata, u8 code)
 	return 0;
 }
 
+static void asus_wmi_work(struct work_struct *work)
+{
+	struct asus_drvdata *drvdata = container_of(work, struct asus_drvdata, wmi_work);
+	u8 report_data[FEATURE_KBD_REPORT_SIZE];
+	int report_size;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&drvdata->wmi_lock, flags);
+	memcpy(report_data, drvdata->wmi_data, drvdata->wmi_size);
+	report_size = drvdata->wmi_size;
+	spin_unlock_irqrestore(&drvdata->wmi_lock, flags);
+
+	ret = asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
+	if (ret) {
+		if (ret != -ENODEV)
+			hid_warn(drvdata->hdev, "Failed to notify asus-wmi: %d\n", ret);
+
+		/* Fallback: pass the raw event to the HID core */
+		hid_report_raw_event(drvdata->hdev, HID_INPUT_REPORT,
+				     report_data, report_size,
+				     report_size, 1);
+	}
+}
+#endif
+
 static int asus_event(struct hid_device *hdev, struct hid_field *field,
 		      struct hid_usage *usage, __s32 value)
 {
@@ -397,6 +431,9 @@ static int asus_raw_event(struct hid_device *hdev,
 		struct hid_report *report, u8 *data, int size)
 {
 	struct asus_drvdata *drvdata = hid_get_drvdata(hdev);
+#if IS_REACHABLE(CONFIG_ASUS_WMI)
+	unsigned long flags;
+#endif
 
 	if (drvdata->battery && data[0] == BATTERY_REPORT_ID)
 		return asus_report_battery(drvdata, data, size);
@@ -422,19 +459,18 @@ static int asus_raw_event(struct hid_device *hdev,
 			 * pass to userspace so it can implement its own fan control.
 			 */
 			if (data[1] == ASUS_FAN_CTRL_KEY_CODE) {
-				int ret = asus_wmi_send_event(drvdata, ASUS_FAN_CTRL_KEY_CODE);
-
-				if (ret == 0) {
-					/* Successfully handled by asus-wmi, block event */
+#if IS_REACHABLE(CONFIG_ASUS_WMI)
+				spin_lock_irqsave(&drvdata->wmi_lock, flags);
+				memcpy(drvdata->wmi_data, data, min_t(int, size, sizeof(drvdata->wmi_data)));
+				drvdata->wmi_size = size;
+				spin_unlock_irqrestore(&drvdata->wmi_lock, flags);
+
+				if (!drvdata->wmi_work_disabled) {
+					schedule_work(&drvdata->wmi_work);
+					/* Successfully handled asynchronously, block event */
 					return -1;
 				}
-
-				/*
-				 * Warn if asus-wmi failed (but not if it's unavailable).
-				 * Let the event reach userspace in all failure cases.
-				 */
-				if (ret != -ENODEV)
-					hid_warn(hdev, "Failed to notify asus-wmi: %d\n", ret);
+#endif
 			}
 
 			/*
@@ -1350,6 +1386,10 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		hdev->quirks |= HID_QUIRK_NO_INIT_REPORTS;
 
 	drvdata->hdev = hdev;
+#if IS_REACHABLE(CONFIG_ASUS_WMI)
+	INIT_WORK(&drvdata->wmi_work, asus_wmi_work);
+	spin_lock_init(&drvdata->wmi_lock);
+#endif
 
 	if (drvdata->quirks & (QUIRK_T100CHI | QUIRK_T90CHI)) {
 		ret = asus_battery_probe(hdev);
@@ -1460,6 +1500,11 @@ static void asus_remove(struct hid_device *hdev)
 	if (drvdata->quirks & QUIRK_HID_FN_LOCK)
 		cancel_work_sync(&drvdata->fn_lock_sync_work);
 
+#if IS_REACHABLE(CONFIG_ASUS_WMI)
+	drvdata->wmi_work_disabled = true;
+	cancel_work_sync(&drvdata->wmi_work);
+#endif
+
 	if (drvdata->xgm_led)
 		led_classdev_unregister(&drvdata->xgm_led->cdev);
 
-- 
2.47.3

