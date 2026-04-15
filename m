Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E9733EAED;
	Wed, 15 Apr 2026 09:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776245943; cv=none; b=RKRzpa5NLw2to+Gr4Gjmlj25992qqTZCF1xTrfB5/i1nfo/T9g7aTuWKfndtOWwP9KcCuq/6hCuUJXHL4y8jEYPF0aJf4/HTHl9NdTB0DetOtrzIzoVjt2n8TmAB1rzIbiml3En0juI/M/z+bTb7jIRbbGJ2yuKeHNya0evuQRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776245943; c=relaxed/simple;
	bh=Pa/2L7eIdmrjdbfKI3MgdidyJjVklBaEyUx380P8wuQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A1HzpcS2g/tp6wiJEAgHn5CU0wsVyq0QNWjju1HiVDfQFe7M0xpyxDEphA7vMkGy8vlYHss0StTBq/txO3h0HaA4aJ4rJps5tNUOxepSkdyiOAucH5eDydqG2dxzGqc7uSrTOFae/VESusUVW+3yp05X1Go2pcBGiBj7xzizYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0aN0MKJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0aN0MKJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B43DC2BCB5;
	Wed, 15 Apr 2026 09:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776245943;
	bh=Pa/2L7eIdmrjdbfKI3MgdidyJjVklBaEyUx380P8wuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c0aN0MKJyBm9bTh6R4TV4N2SEYc7mLxtaBzqWedRdWwfUe1tU2kMwH+QaWFYaBYVV
	 KlCd4YsGAbO5YrrJ5xRKCQtEZYrFcrMXAT7QgD/JSGlRNUCVRc7z7BsRuLr9M01X/e
	 Ksyy/LlZRxjkr1usvyBIR6xEQ1DyxJ3W8cdAKi1RahJecm9n+xXffDptiw6xaw3c1V
	 zzCwT8hI6TUuJRXX4vj2QXsrZFPn3MQBqYikeo6T6L9sg6ptFBbFQXfJ1fQksw2/rJ
	 h1EYlQ5b3lS25HJyMZqwdmn0kgitQBDKge5BoDLMnsI0seFDSm1dEoWVPPbkOcvbsR
	 3qaRoVOiiaizw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Wed, 15 Apr 2026 11:38:17 +0200
Subject: [PATCH 4/4] HID: wacom: use __free(kfree) to clean up temporary
 buffers
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-wip-fix-core-v1-4-ed3c4c823175@kernel.org>
References: <20260415-wip-fix-core-v1-0-ed3c4c823175@kernel.org>
In-Reply-To: <20260415-wip-fix-core-v1-0-ed3c4c823175@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, 
 =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Ping Cheng <ping.cheng@wacom.com>, 
 Jason Gerecke <jason.gerecke@wacom.com>, Viresh Kumar <vireshk@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lee Jones <lee@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev, 
 linux-usb@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776245925; l=6343;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=Pa/2L7eIdmrjdbfKI3MgdidyJjVklBaEyUx380P8wuQ=;
 b=vhEu+X9T66hBNoOYo7P05gF1lMEmsh9t5aU8x+zJIuPvy9dGXF9cn/pcOPluf0mPx1Ul5LioQ
 SLmszMqNYXgDDA9cGsq1vxSJqCI1Kf+daEzRjJYf5wfIfoypihzpRoZ
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This simplifies error handling and protects against memory leaks.

Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/wacom_sys.c | 40 +++++++++++++---------------------------
 1 file changed, 13 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b351e3..adb31f54e524 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -70,11 +70,10 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 {
 	while (!kfifo_is_empty(fifo)) {
 		int size = kfifo_peek_len(fifo);
-		u8 *buf;
 		unsigned int count;
 		int err;
 
-		buf = kzalloc(size, GFP_KERNEL);
+		u8 *buf __free(kfree) = kzalloc(size, GFP_KERNEL);
 		if (!buf) {
 			kfifo_skip(fifo);
 			continue;
@@ -87,7 +86,6 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 			// to flush seems reasonable enough, however.
 			hid_warn(hdev, "%s: removed fifo entry with unexpected size\n",
 				 __func__);
-			kfree(buf);
 			continue;
 		}
 		err = hid_report_raw_event(hdev, HID_INPUT_REPORT, buf, size, size, false);
@@ -95,8 +93,6 @@ static void wacom_wac_queue_flush(struct hid_device *hdev,
 			hid_warn(hdev, "%s: unable to flush event due to error %d\n",
 				 __func__, err);
 		}
-
-		kfree(buf);
 	}
 }
 
@@ -311,7 +307,6 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 	struct wacom_features *features = &wacom->wacom_wac.features;
 	struct hid_data *hid_data = &wacom->wacom_wac.hid_data;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
-	u8 *data;
 	int ret;
 	u32 n;
 
@@ -325,10 +320,11 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 		/* leave touch_max as is if predefined */
 		if (!features->touch_max) {
 			/* read manually */
-			n = hid_report_len(field->report);
-			data = hid_alloc_report_buf(field->report, GFP_KERNEL);
+			u8 *data __free(kfree) = hid_alloc_report_buf(field->report, GFP_KERNEL);
+
 			if (!data)
 				break;
+			n = hid_report_len(field->report);
 			data[0] = field->report->id;
 			ret = wacom_get_report(hdev, HID_FEATURE_REPORT,
 					       data, n, WAC_CMD_RETRIES);
@@ -344,7 +340,6 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 					 "defaulting to %d\n",
 					  features->touch_max);
 			}
-			kfree(data);
 		}
 		break;
 	case HID_DG_INPUTMODE:
@@ -386,10 +381,11 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 	case WACOM_HID_WD_OFFSETRIGHT:
 	case WACOM_HID_WD_OFFSETBOTTOM:
 		/* read manually */
-		n = hid_report_len(field->report);
-		data = hid_alloc_report_buf(field->report, GFP_KERNEL);
+		u8 *data __free(kfree) = hid_alloc_report_buf(field->report, GFP_KERNEL);
+
 		if (!data)
 			break;
+		n = hid_report_len(field->report);
 		data[0] = field->report->id;
 		ret = wacom_get_report(hdev, HID_FEATURE_REPORT,
 					data, n, WAC_CMD_RETRIES);
@@ -400,7 +396,6 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 			hid_warn(hdev, "%s: could not retrieve sensor offsets\n",
 				 __func__);
 		}
-		kfree(data);
 		break;
 	}
 }
@@ -581,7 +576,6 @@ static int wacom_hid_set_device_mode(struct hid_device *hdev)
 static int wacom_set_device_mode(struct hid_device *hdev,
 				 struct wacom_wac *wacom_wac)
 {
-	u8 *rep_data;
 	struct hid_report *r;
 	struct hid_report_enum *re;
 	u32 length;
@@ -595,7 +589,7 @@ static int wacom_set_device_mode(struct hid_device *hdev,
 	if (!r)
 		return -EINVAL;
 
-	rep_data = hid_alloc_report_buf(r, GFP_KERNEL);
+	u8 *rep_data __free(kfree) = hid_alloc_report_buf(r, GFP_KERNEL);
 	if (!rep_data)
 		return -ENOMEM;
 
@@ -614,8 +608,6 @@ static int wacom_set_device_mode(struct hid_device *hdev,
 		 rep_data[1] != wacom_wac->mode_report &&
 		 limit++ < WAC_MSG_RETRIES);
 
-	kfree(rep_data);
-
 	return error < 0 ? error : 0;
 }
 
@@ -921,7 +913,6 @@ static int wacom_add_shared_data(struct hid_device *hdev)
 
 static int wacom_led_control(struct wacom *wacom)
 {
-	unsigned char *buf;
 	int retval;
 	unsigned char report_id = WAC_CMD_LED_CONTROL;
 	int buf_size = 9;
@@ -940,7 +931,8 @@ static int wacom_led_control(struct wacom *wacom)
 		report_id = WAC_CMD_WL_INTUOSP2;
 		buf_size = 51;
 	}
-	buf = kzalloc(buf_size, GFP_KERNEL);
+
+	unsigned char *buf __free(kfree) = kzalloc(buf_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -996,7 +988,6 @@ static int wacom_led_control(struct wacom *wacom)
 
 	retval = wacom_set_report(wacom->hdev, HID_FEATURE_REPORT, buf, buf_size,
 				  WAC_CMD_RETRIES);
-	kfree(buf);
 
 	return retval;
 }
@@ -1004,11 +995,10 @@ static int wacom_led_control(struct wacom *wacom)
 static int wacom_led_putimage(struct wacom *wacom, int button_id, u8 xfer_id,
 		const unsigned len, const void *img)
 {
-	unsigned char *buf;
 	int i, retval;
 	const unsigned chunk_len = len / 4; /* 4 chunks are needed to be sent */
 
-	buf = kzalloc(chunk_len + 3 , GFP_KERNEL);
+	unsigned char *buf __free(kfree) = kzalloc(chunk_len + 3, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -1018,7 +1008,7 @@ static int wacom_led_putimage(struct wacom *wacom, int button_id, u8 xfer_id,
 	retval = wacom_set_report(wacom->hdev, HID_FEATURE_REPORT, buf, 2,
 				  WAC_CMD_RETRIES);
 	if (retval < 0)
-		goto out;
+		return retval;
 
 	buf[0] = xfer_id;
 	buf[1] = button_id & 0x07;
@@ -1038,8 +1028,6 @@ static int wacom_led_putimage(struct wacom *wacom, int button_id, u8 xfer_id,
 	wacom_set_report(wacom->hdev, HID_FEATURE_REPORT, buf, 2,
 			 WAC_CMD_RETRIES);
 
-out:
-	kfree(buf);
 	return retval;
 }
 
@@ -1948,10 +1936,9 @@ static int wacom_remote_create_attr_group(struct wacom *wacom, __u32 serial,
 static int wacom_cmd_unpair_remote(struct wacom *wacom, unsigned char selector)
 {
 	const size_t buf_size = 2;
-	unsigned char *buf;
 	int retval;
 
-	buf = kzalloc(buf_size, GFP_KERNEL);
+	unsigned char *buf __free(kfree) = kzalloc(buf_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
@@ -1960,7 +1947,6 @@ static int wacom_cmd_unpair_remote(struct wacom *wacom, unsigned char selector)
 
 	retval = wacom_set_report(wacom->hdev, HID_OUTPUT_REPORT, buf,
 				  buf_size, WAC_CMD_RETRIES);
-	kfree(buf);
 
 	return retval;
 }

-- 
2.53.0

