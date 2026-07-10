Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900AD2D0C98
	for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 02:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650544; cv=none; b=l5JpoFKjitsHcOhyN64+Ijet1K9/+7I3nR/edXPsBHofaIcSmTzYZzUVXu2eBrgLBgh+p2vjKombEcd20dhHU/S9EkwZVLkkCeLWxcK8qMz2OMn5+C/QW8LTGpewl+felhVZpNnXx+2RgDshKMeAGuRtMhRJR/7A8mCm/aqRyh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650544; c=relaxed/simple;
	bh=Xw9MV5+tUH91OggMUmq95ucMnBMqMCwFdkfsgGxUsO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JI3F4JWW6w28h+FgSUHK0+HT/+w+yHt/c2+1EaiI4hKq5JNbgxa1gRcYhXR4f1X1heuLj2rZou/kpNy+BiY1SG0T5vGlsLDBwvuICVRoSCN4l/tUcaonb/QdoT5B+PnY1/WxkW0ppVQh71cuH0EMmEuVhLAuIhvQaX7n/nJFSiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwzJ0DGW; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwzJ0DGW"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92b21f65b60so95657885a.1
        for <linux-input@vger.kernel.org>; Thu, 09 Jul 2026 19:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650541; x=1784255341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qddLIoiRhTm7oXx/mi01gsuC6rzOXTw4K1iEgY1KrG0=;
        b=dwzJ0DGW7BUBPpqc5p98Oq48MJutxTn3/qCpjSJKkMsrM1TeqTp9lGJC+C1F/LJhbi
         YJbQU45ADJCa4/PsiaR9iIF0Ot2qf7WZtV5f+bRq/sxGTYvUya8sZA3AjejiAg8StKX6
         1IzlGG+fJzr3+QyVcgRgwbYP1d23+7sw5tDgw4Prtb3cCK8RYkhJrmhXn9XTDq6YXACY
         fzI7LHe8lL9m0zhM+tuhW7wBSFagbcRDoc1oygJeDHRBADFNj90v+tEr1jX1FH1+QZjM
         51+chwgWvMKx0FGCeDAwZCKQ0KHgiyMfpSHLac3QZtn7nR/JJswCN7Iq8yXymyRyf+f2
         JXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650541; x=1784255341;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qddLIoiRhTm7oXx/mi01gsuC6rzOXTw4K1iEgY1KrG0=;
        b=SkueJjbiAhr2CUp6Hn6xbK4U2U/rjl2AZCDT80TTTsv00Kf1PNGgnzOIMh+2bd+CJj
         5vu+KqwwhaYzyD4bVszxtvmzSQ/TXQ2xHJOOg12CvUolGBJrtTQSLiX6MzsxvcBMNjoU
         whOY8cg+TcsNRGmAS5O2U+iSfFuZ80OpqAI2kPL0W4ToVN/8HbhQzojVFX5ZXpBkarBP
         vi/c0yyqQxK8RF3FVqPmUemp3Z0X3679RHE/+9w6l3i7tkbcSTTYW83mpkJFKP3CqPAH
         N98Z3wMEUzlBjuNJwkFnBqxMgyIMoJZ/otfyeGrT8jcdq674HIvafHyEl7nxLC63sR5o
         x8QA==
X-Forwarded-Encrypted: i=1; AHgh+RqTlL82NyaRGSknCbZzRk8l6SddrhmGTitg/nAYDUjfBJEUzxQn6wkyoIjGJPVx/QHGvVNVB0cjFBi16A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVMPk1o7vv0Grr9qcIuF9wUsXLHG1KEXtp6wqB+VJ8QxqCRAra
	woKkz0QmT4fLzSaKaLKapezR8N6iiEp8oqV+spFAJAwC1QsFW5LlFUuY
X-Gm-Gg: AfdE7cm2dVlXtJ0Aqx+AUdL2WStqmvtx9pDAHepKlrgYOATloqjUwZiqLvAPAUTTAw2
	vMdGl//oWxNGhqnHG2JCMbYZPaRWfVwQYIYxnRKYyVeMvzk/Ft+NoA4clviFQ5ShZFluX6iy15u
	Ckq/Ml/X6DwY6ioZCV35XCE0KuwZ381qtKKfLafAHMaBwcTPF+OFO+teS3XZF7dH0ji0UuZwKnx
	xVWt0Avp6cSkwWQ9bcSCudHPMoT+LAuCFfxvJbISfjIoBOsjvS/TUvN3DvmDQSv7utAYps8wovD
	968qjWpURzZi8hqN4JOE5fRTdEmv++AyNwrmOC4rSLSfTbcG3+0KkNKD0RDhxatIsO4zCVfK6tl
	UMPDnMvK2pcY1/z98CRf3YOK08zkkmG/cS806cA2dmjHPNZeuZCsi46fCHIUb0dPhfjeG64E7z7
	ugBRMQZhJDdna5YdLK7s/ZUG02/FWV2w9n2OeqsmEy6/PWTrN6TtISBAW8tbwovhQryAhDR7RQq
	+VLc3LLpzmXMbYzUGT8jfG7TVI9W8xT
X-Received: by 2002:a05:620a:1993:b0:92e:7d7f:9102 with SMTP id af79cd13be357-92ee54ab5d8mr206888585a.2.1783650541428;
        Thu, 09 Jul 2026 19:29:01 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b86276sm90507885a.11.2026.07.09.19.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:29:00 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	kys@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	linux-input@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] HID: hyperv: validate initial device info bounds
Date: Thu,  9 Jul 2026 22:28:53 -0400
Message-ID: <20260710022854.3739558-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710022854.3739558-1-michael.bommarito@gmail.com>
References: <20260710022854.3739558-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The Hyper-V synthetic HID host supplies SYNTH_HID_INITIAL_DEVICE_INFO
messages that contain a HID descriptor followed by the report descriptor
bytes. mousevsc_on_receive_device_info() trusts bLength and
wDescriptorLength without checking that the received packet contains both
byte ranges.

A malformed host or backend message can therefore make the guest read
past the received VMBus packet while copying the report descriptor. Pass
the received initial-device-info size into the parser and reject
descriptor lengths that exceed the packet.

Impact: A malicious Hyper-V host or backend can crash a guest by sending
a short initial device-info message with an oversized HID report
descriptor length.

Fixes: b95f5bcb811e ("HID: Move the hid-hyperv driver out of staging")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/hid/hid-hyperv.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 7d2b0063df151..fd90196430e29 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -171,18 +171,32 @@ static void mousevsc_free_device(struct mousevsc_dev *device)
 }
 
 static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
-				struct synthhid_device_info *device_info)
+					    struct synthhid_device_info *device_info,
+					    u32 device_info_size)
 {
 	int ret = 0;
 	struct hid_descriptor *desc;
 	struct mousevsc_prt_msg ack;
+	size_t desc_offset;
+	size_t desc_size;
 
 	input_device->dev_info_status = -ENOMEM;
 
+	if (device_info_size < sizeof(*device_info)) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
+
 	input_device->hid_dev_info = device_info->hid_dev_info;
 	desc = &device_info->hid_descriptor;
+	desc_offset = offsetof(struct synthhid_device_info, hid_descriptor);
+	desc_size = device_info_size - desc_offset;
 	if (desc->bLength == 0)
 		goto cleanup;
+	if (desc->bLength < sizeof(*desc) || desc->bLength > desc_size) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
 
 	/* The pointer is not NULL when we resume from hibernation */
 	kfree(input_device->hid_desc);
@@ -197,6 +211,10 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
 	}
+	if (input_device->report_desc_size > desc_size - desc->bLength) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
 
 	/* The pointer is not NULL when we resume from hibernation */
 	kfree(input_device->report_desc);
@@ -273,14 +291,17 @@ static void mousevsc_on_receive(struct hv_device *device,
 		break;
 
 	case SYNTH_HID_INITIAL_DEVICE_INFO:
-		WARN_ON(pipe_msg->size < sizeof(struct hv_input_dev_info));
+		if (WARN_ON_ONCE(pipe_msg->size <
+				 sizeof(struct synthhid_device_info)))
+			break;
 
 		/*
 		 * Parse out the device info into device attr,
 		 * hid desc and report desc
 		 */
 		mousevsc_on_receive_device_info(input_dev,
-			(struct synthhid_device_info *)pipe_msg->data);
+						(struct synthhid_device_info *)pipe_msg->data,
+						pipe_msg->size);
 		break;
 	case SYNTH_HID_INPUT_REPORT:
 		input_report =
-- 
2.53.0
