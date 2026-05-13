Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A19368D77;
	Wed, 13 May 2026 08:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659278; cv=none; b=N4IcfNA48mqNpA/yxFa67f+psoHzZ4WShz3bH9E7f5GpC5AFsF8CVirIQXHXTWT3hlaBl1AqxgVakFnm+YpIAEoqdlIxRih9S8JVFqftlXDcQUzWeV+u//YqCEVMdfrNCGIq6o1GKSGRWPNWTWMtsX2xlkrwrPq0ygjgHfB7mQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659278; c=relaxed/simple;
	bh=58qnot80DX+F+OvA46/Uf+lFEZfUYoIG7HZYVg2Hp9U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pUlvrxp/f7Y2h4PWYidZPuI7agIgDa5XJgm1LBlOStviX4+ciisS1ZQhefEjhgcBzNKb7Ip9RHBqrE4SHil8VPvwjF7cKMfcgzDS+rFYKSDtfuo+Thu4GdJhwr24+PadMPztzxxJaIsIsJU1LYEmqYcwIy6Q1cYbjQtzu0iFiLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+n4kDjk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+n4kDjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B461C2BCB7;
	Wed, 13 May 2026 08:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778659278;
	bh=58qnot80DX+F+OvA46/Uf+lFEZfUYoIG7HZYVg2Hp9U=;
	h=From:To:Cc:Subject:Date:From;
	b=t+n4kDjkbd++erQODQq7cEBlevxeThPl0uBOEpZuvBX78YcbVrimzXF8zRxp5aVy7
	 l6A+5zi+VbrZQ6coLwXp0TJd32MiO+aLFPGZcJQIWxn7vWoqs17OMDe8+IbOuPl/kV
	 +xfUIUuVIC8KXtG2jGtTPG9BXqCpHoloKhXRGgUUQbhJEWBC0nAxkMFccnoerlfqiA
	 lMYW7m0qgY3pZs1LfEhf46vCIO9XZRT24/0RpCeEakvcT8zX4PFEPra7zSz0GSZpXg
	 C0R2gehIonZwRB8DWnB61vTHZR5XOoWG+qlQcc9llZ1MXEX+7UVbcF2RSi5isO1yeG
	 HTNlxNhIEDyiw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Ping Cheng <ping.cheng@wacom.com>,
	Jason Gerecke <jason.gerecke@wacom.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/1] HID: wacom: Fix OOB write in wacom_hid_set_device_mode()
Date: Wed, 13 May 2026 08:59:34 +0100
Message-ID: <20260513075935.1715836-1-lee@kernel.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wacom_hid_set_device_mode() currently assumes that the HID_DG_INPUTMODE
usage is always located in the first field (field[0]) of the feature report.
However, a device can specify HID_DG_INPUTMODE in a different field.

If HID_DG_INPUTMODE is in a field other than the first one and the first
field has a report_count smaller than the usage_index of HID_DG_INPUTMODE,
this leads to an out-of-bounds write to r->field[0]->value.

Fix this by storing the field index of HID_DG_INPUTMODE in 'struct
hid_data' during feature mapping.  In wacom_hid_set_device_mode(), use
this stored field index to access the correct field and add bounds
checks to ensure both the field index and the value index are within
valid ranges before writing.

Cc: stable@vger.kernel.org
Fixes: 5ae6e89f7409 ("HID: wacom: implement the finger part of the HID generic handling")
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/wacom_sys.c | 13 ++++++++++---
 drivers/hid/wacom_wac.h |  1 +
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 1b1112772777..a6c5281afa06 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -341,6 +341,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 
 		hid_data->inputmode = field->report->id;
 		hid_data->inputmode_index = usage->usage_index;
+		hid_data->inputmode_field_index = field->index;
 		break;
 
 	case HID_UP_DIGITIZER:
@@ -556,9 +557,14 @@ static int wacom_hid_set_device_mode(struct hid_device *hdev)
 
 	re = &(hdev->report_enum[HID_FEATURE_REPORT]);
 	r = re->report_id_hash[hid_data->inputmode];
-	if (r) {
-		r->field[0]->value[hid_data->inputmode_index] = 2;
-		hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
+	if (r && hid_data->inputmode_field_index >= 0 &&
+	    hid_data->inputmode_field_index < r->maxfield) {
+		struct hid_field *field = r->field[hid_data->inputmode_field_index];
+
+		if (field && hid_data->inputmode_index < field->report_count) {
+			field->value[hid_data->inputmode_index] = 2;
+			hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
+		}
 	}
 	return 0;
 }
@@ -2819,6 +2825,7 @@ static int wacom_probe(struct hid_device *hdev,
 		return error;
 
 	wacom_wac->hid_data.inputmode = -1;
+	wacom_wac->hid_data.inputmode_field_index = -1;
 	wacom_wac->mode_report = -1;
 
 	if (hid_is_usb(hdev)) {
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index c8803d5c6a71..b2e74d7ab3c4 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -298,6 +298,7 @@ struct wacom_shared {
 struct hid_data {
 	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
 	__s16 inputmode_index;	/* InputMode HID feature index in the report */
+	__s16 inputmode_field_index; /* InputMode HID feature field index in the report */
 	bool sense_state;
 	bool inrange_state;
 	bool invert_state;
-- 
2.54.0.563.g4f69b47b94-goog

