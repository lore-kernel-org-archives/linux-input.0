Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A103A48F7
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451098; cv=none; b=gsHgA4bibgT8OiYNXE0colqFi7f4eTRCSH6mwXRgOdkhv7FyexGRSi593pO8ydon3N9/L274p2siXjruKcKviIdYesn9fXHcDqwCIfygcx96lqzCdD2dcFrlgDr8FKV42ya/tWzWF9vDot1NyXp1jD9hEWwKi54MkwGQHNQqU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451098; c=relaxed/simple;
	bh=s7DOHv/ROkYwlVelXhyoi/lVRJTpsMT4RrCwpaul0tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jKPHZgORzZxmRWK5gH0/jbyxCJGFX7qIk9jiUItAeTm5tt04eIC4h/gOCd7a+piF8qHI+VrwM5pJ8Gy58BzF3BFfJTfGpi6pfsDLUiW+SD8epltR7C7Rt3daqntSG6F+GoJyVoX63hM2vEVhdoAZO/9m9JaeEkAGebTiKB/NXLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv34ZJNC; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv34ZJNC"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30ca1b4b278so268844eec.0
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451096; x=1783055896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M9/TPgtI7fXBhlRGyeTOm0rVTsJRoJjoDje29Ql19gY=;
        b=Pv34ZJNCIKShXllRvgJCCs42YcEl0+HHroy6XSGpbF7XhARe3C0x+I2rT22pyU15CS
         ZLxRs4nyIthRJKa4etbdwrMovKxIQOXzKwl4mwx4h1HpLnWlSiXdB+lEtSVkMlYi144g
         s5qbgfF2wuy6TyL3g5GPKog+c1MQRUdYP4Mw/O69pubjtxNeqvUoJ0L4kQBIG5NoWJWF
         BWhHwdXtlFFZ7cYbqpurN98uGKYntmDAOEGj+hwv6vfF2/JMZ/bgwN5hWiJrXH4HDI6E
         TXKkutLpK3VtE419Onu8Msjgz1svrzgLfgioX/Zrki/BNYSks8vEtc0Aerr3pjCCGJY6
         rX6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451096; x=1783055896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M9/TPgtI7fXBhlRGyeTOm0rVTsJRoJjoDje29Ql19gY=;
        b=cvNUq1lSErV4ktKy9KARB77kXC/I3HMyYJarqU4OJSOLv8IZsbaKoNmT7qBPpRCm60
         Wlkt35QUL9PeQO7yinAAVuZYHdHwHASjhy2UEdJPxMe57q0dJa7urgcJdpFXfF96ciZ+
         04CTwgna1yhVek6p7j5moa2J9C9zRoo1nS6rs/OZVm3Ns5XszLV1HOeOfapeamtDgaEI
         +XonRcyAJESA6AWprdSHA2qJDqWS0f75A9vxXrO+EzjP2X9RwErE8/FbaZGBVdkyAabb
         jAgyRuYwk22jO5evW4+gNdQ14BvILGASk8ukFi3nskhpcCAyUl9VMphRtnYd4ype3Fy4
         j9pw==
X-Gm-Message-State: AOJu0YydwRexm4DdNxHaFSth9fdaoQ07RVa14/KjgQgtYTqO3LkX1LLY
	KkUkbMczJOsinpA5VpR9A67QdlBlyaF/TGLzhpXmNzBm85w2c7zHsWXIJSbFzw==
X-Gm-Gg: AfdE7cmC5tBWeq5tJVid02bjv4AXtjei46eg/26Hd7dAtzqj/MS6lWTjOsoEk6UOzYn
	ZYKZXUg3Pulqj+ztnAF/SajimLSU36cHtuE/nBspMC30UCYlUoOcsMZLjRF8A4VoD9jTS8XsxY/
	hJTLOH5X7oWJTQ2ekd5zGL7R6QEY0bb1v2oakxIGcNcD7uEVXK/O2hAhDCk9nhZeLJEz7Sk8HGk
	eF9xgL5sywUtTWZ9isT0cXMkHc1zpCf/RXK0CzRdw7e0TMJpg5zeg34e++OJvmGzsmPRdu6v5EQ
	nKneeHWuEvwickvMq6e3/cD4HJnotaqvqQ+s4wkJmSSTrlFInWT92vBIJERI0fPdYeYqntySWHI
	04he3yzxjRF9wE+KJtI/OIiwoqVRWqkkRQWeqyABe5s1UvhHfZQ/qnPp+P8rKiCb6xlaR/6HNm7
	UBDjxnehyvCDBQSYpPH9veOLdsI3vTeBoh423InjScLflReXQwZ0d4HrcQhZaVig0nzJYcJvUoK
	tvCJIbnyHdrDoY=
X-Received: by 2002:a05:7300:d0b:b0:30c:6025:da8a with SMTP id 5a478bee46e88-30c84e231b0mr6202067eec.14.1782451096307;
        Thu, 25 Jun 2026 22:18:16 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:15 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] Input: synaptics-rmi4 - F54 style and typo fixes
Date: Thu, 25 Jun 2026 22:17:57 -0700
Message-ID: <20260626051802.4033172-8-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up style issues in rmi_f54.c reported by checkpatch.pl --strict:
- Convert (1 << X) caps to BIT(X).
- Align assignment operator '=' in report_types array.
- Add comments to status_mutex, data_mutex, and lock explaining what they protect.
- Align function arguments/parameters with open parenthesis in rmi_f54_get_reptype() and rmi_f54_vidioc_querycap().
- Fix typo 'firmare' -> 'firmware' in comment.
- Align dev_err() argument with open parenthesis in rmi_f54_work().
- Use '!ptr' instead of 'ptr == NULL' for report_data check in rmi_f54_probe().

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 38 ++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 93526feea563..850e1742c480 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/bits.h>
 #include <linux/rmi.h>
 #include <linux/input.h>
 #include <linux/slab.h>
@@ -35,9 +36,9 @@
 #define F54_FORCE_CAL           2
 
 /* F54 capabilities */
-#define F54_CAP_BASELINE	(1 << 2)
-#define F54_CAP_IMAGE8		(1 << 3)
-#define F54_CAP_IMAGE16		(1 << 6)
+#define F54_CAP_BASELINE	BIT(2)
+#define F54_CAP_IMAGE8		BIT(3)
+#define F54_CAP_IMAGE16		BIT(6)
 
 /**
  * enum rmi_f54_report_type - RMI4 F54 report types
@@ -83,14 +84,13 @@ enum rmi_f54_report_type {
 };
 
 static const char * const rmi_f54_report_type_names[] = {
-	[F54_REPORT_NONE]		= "Unknown",
-	[F54_8BIT_IMAGE]		= "Normalized 8-Bit Image",
-	[F54_16BIT_IMAGE]		= "Normalized 16-Bit Image",
-	[F54_RAW_16BIT_IMAGE]		= "Raw 16-Bit Image",
-	[F54_TRUE_BASELINE]		= "True Baseline",
-	[F54_FULL_RAW_CAP]		= "Full Raw Capacitance",
-	[F54_FULL_RAW_CAP_RX_OFFSET_REMOVED]
-					= "Full Raw Capacitance RX Offset Removed",
+	[F54_REPORT_NONE]			= "Unknown",
+	[F54_8BIT_IMAGE]			= "Normalized 8-Bit Image",
+	[F54_16BIT_IMAGE]			= "Normalized 16-Bit Image",
+	[F54_RAW_16BIT_IMAGE]			= "Raw 16-Bit Image",
+	[F54_TRUE_BASELINE]			= "True Baseline",
+	[F54_FULL_RAW_CAP]			= "Full Raw Capacitance",
+	[F54_FULL_RAW_CAP_RX_OFFSET_REMOVED]	= "Full Raw Capacitance RX Offset Removed",
 };
 
 struct f54_data {
@@ -109,8 +109,8 @@ struct f54_data {
 	int report_error;
 
 	bool is_busy;
-	struct mutex status_mutex;
-	struct mutex data_mutex;
+	struct mutex status_mutex; /* Protects is_busy and command state */
+	struct mutex data_mutex;   /* Protects report_data buffer */
 
 	struct workqueue_struct *workqueue;
 	struct delayed_work work;
@@ -123,7 +123,7 @@ struct f54_data {
 	struct v4l2_pix_format format;
 	struct video_device vdev;
 	struct vb2_queue queue;
-	struct mutex lock;
+	struct mutex lock; /* Serializes V4L2 device and queue access */
 	u32 sequence;
 	int input;
 	enum rmi_f54_report_type inputs[F54_MAX_REPORT_TYPE];
@@ -153,7 +153,7 @@ static bool is_f54_report_type_valid(struct f54_data *f54,
 }
 
 static enum rmi_f54_report_type rmi_f54_get_reptype(struct f54_data *f54,
-						unsigned int i)
+						    unsigned int i)
 {
 	if (i >= F54_MAX_REPORT_TYPE)
 		return F54_REPORT_NONE;
@@ -193,7 +193,7 @@ static int rmi_f54_request_report(struct rmi_function *fn, u8 report_type)
 
 	/*
 	 * Small delay after disabling interrupts to avoid race condition
-	 * in firmare. This value is a bit higher than absolutely necessary.
+	 * in firmware. This value is a bit higher than absolutely necessary.
 	 * Should be removed once issue is resolved in firmware.
 	 */
 	usleep_range(2000, 3000);
@@ -406,7 +406,7 @@ static int rmi_f54_vidioc_querycap(struct file *file, void *priv,
 	strscpy(cap->driver, F54_NAME, sizeof(cap->driver));
 	strscpy(cap->card, SYNAPTICS_INPUT_DEVICE_NAME, sizeof(cap->card));
 	snprintf(cap->bus_info, sizeof(cap->bus_info),
-		"rmi4:%s", dev_name(&f54->fn->dev));
+		 "rmi4:%s", dev_name(&f54->fn->dev));
 
 	return 0;
 }
@@ -563,7 +563,7 @@ static void rmi_f54_work(struct work_struct *work)
 	report_size = rmi_f54_get_report_size(f54);
 	if (report_size == 0) {
 		dev_err(&fn->dev, "Bad report size, report type=%d\n",
-				f54->report_type);
+			f54->report_type);
 		error = -EINVAL;
 		goto out;     /* retry won't help */
 	}
@@ -709,7 +709,7 @@ static int rmi_f54_probe(struct rmi_function *fn)
 	f54->max_report_size = array3_size(tx, rx, sizeof(u16));
 	f54->report_data = devm_kzalloc(&fn->dev, f54->max_report_size,
 					GFP_KERNEL);
-	if (f54->report_data == NULL)
+	if (!f54->report_data)
 		return -ENOMEM;
 
 	INIT_DELAYED_WORK(&f54->work, rmi_f54_work);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

