Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318C53AE184
	for <linux-input@vger.kernel.org>; Fri, 12 Jun 2026 06:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244319; cv=none; b=btAUHcAecNtlfMYcToPhg3muw1mN9PRHdnIHYuG0q0MyeQH8IeDLJZtOcxGq9m1MteFgScCSMpPKc6oNTX8zLH4mCljYu2RJI6IuldZgR4vvOIZ8JhZf/V82c+69R2vFLMDTiMS3L2wi6QcOiBQAZAGw+j2wNTOOBPaBtQKWEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244319; c=relaxed/simple;
	bh=RGbsxkupUge19BKTktVT3c2j6x8Gro8DhveJEyZMbKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aefotNsQXz53T0EHbD3b7iMzT0rna/VbJjt2m9rOZoHM454vLOAUrsc2soVaqbgLAW0sVYoztx395dfwML72xF8ZbHNceUgHk2kiytgaIdtPo3FN2H/bbnLcAKnHV3a0GfkblJg7d7khKqYZvhQ4+1HNYUM+AXGmRRA4gEU6yJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CuE0C/+n; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CuE0C/+n"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8423b08b293so333613b3a.3
        for <linux-input@vger.kernel.org>; Thu, 11 Jun 2026 23:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781244309; x=1781849109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZhVY0AvrduauhTvBrssxSpj3AMAEp/6iK3/KNj+gtk=;
        b=CuE0C/+nwi8OqN+tUGUujBoRSGDeHTJ6UhhelCWrb2v43Lj2TlEJrmDGWaysaSLiNs
         i6yFCwt9q10D9V4p6aBtTYSlBO13jimt/HjOP1+GAKgR4mBy79O9wDfb9q62qJQaSxUi
         M+1D/9PIhzA1nZo51J2GqJBx+4BcMcLfOn35c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781244309; x=1781849109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gZhVY0AvrduauhTvBrssxSpj3AMAEp/6iK3/KNj+gtk=;
        b=YjHihMZliNDD2cdx0TIaWpRPYlaWyi5NXZomh0FyJSXUvy/QD36oggM+MErBrDmx85
         U2wetGodMTs0EqHQ6rZwxFYmPmFaLQLV5EJpd9M95Wjg2ixtRrmZmDDeVGnUfjw+hvHY
         woqvvzsTK8KLpqAlB/N7Mc7rxJI/zk3skEq9E8v7Vi6m4Uehozr76H8GRBXOyevQu/0z
         +yl9nvIIdSEHnorcGVobKr0Fa0urDY8McH+MZfZwwCkC8BO0H56hKTmJqpAcrrN3rxqw
         g1P1p+cgyb7QnwxeMkQ9phdtqwYC2xvzjp9LIUHri/jky9kyYfNiA9B8UDf7Au94etW0
         Kcpw==
X-Forwarded-Encrypted: i=1; AFNElJ/269GmNoJWY2wn4wg1Ha0OR3r35Qks4yvaTr3xcnLqO0zMSDDz0V0U3BSCobDga/e1osa7FhRa6iC0JQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiNa4xLB8zUD9yeTQH9pMwGIc+CoInXaxaNolBVUyj9xdlnTL
	ltq5BwvlmLyDLfKPsg14YWFxgiMrDTYlvRbK+3pbc9HkoBsBuDWZy/diSQIiFajbeQ==
X-Gm-Gg: Acq92OFTT+JhdZELlmMNhylAttZDyO9Y+YmetDPPYp65ymKVm8yrCRlxzlc+b1b40sI
	LjqODnY4YQ2krsaDpDb34+VWjcwrOOBMdPYtjnViDP+LnPLEIlUt94mTP4NxJeauCAnjBPqxGqW
	AFLb90vgqaWZfK6ApWAbq4U1Jzl9sFz9z69TwW2niYAOJuIiqGnlOj6YGJ6a2UEfSaSvW2DVsGD
	35MOrDit4j9VmtW8oXKiRVvEyQ63zjmKHn8/s1vYhgWZCdKGsxcDvHSHaaEzy2cbCph09eDFR2n
	WFE8B758uF1FteaAh2cjyZvuFEHx0U4GLK3uVxV0mYyE5EP6lxc7Iy4QO8+foLtGwXPbuQaLkaW
	JHvfn2StdMzb8gZEEdtZs5WpOsuNrBAlAXM0AdQsYhrybIvyRElY4iDEDrXhM7LRzX9c8ECloFU
	zih7ycEgOBUv//5BSyvw0qLXzkfOuEsfAHaYVSxn9UDGDFyAH6loxP0SQS/nUqZZZf6vDf7YY7H
	W1zzwQACusPX7M7R/LmBi01yZE8kqTCjRM=
X-Received: by 2002:a05:6a00:4fc7:b0:842:54c1:8e15 with SMTP id d2e1a72fcca58-8434ce42058mr1569469b3a.29.1781244309171;
        Thu, 11 Jun 2026 23:05:09 -0700 (PDT)
Received: from ranjankumar.c.googlers.com.com (127.128.126.34.bc.googleusercontent.com. [34.126.128.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b04808dsm1084616b3a.52.2026.06.11.23.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 23:05:08 -0700 (PDT)
From: Ranjan Kumar <kumarranja@chromium.org>
To: dmitry.torokhov@gmail.com
Cc: bleung@chromium.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ranjan Kumar <kumarranja@chromium.org>
Subject: [PATCH v4] Input: elan_i2c - prevent division by zero and arithmetic underflow
Date: Fri, 12 Jun 2026 06:03:39 +0000
Message-ID: <20260612060339.3829666-1-kumarranja@chromium.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <aiefjOflOlbUiWDa@google.com>
References: <aiefjOflOlbUiWDa@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Elan I2C touchpad driver queries the device for its physical
dimensions and trace counts to calculate the device resolution and width.
However, if the device firmware or device tree provides invalid zero
values for x_traces or y_traces, it results in a fatal division-by-zero
exception leading to a kernel panic during device probe.

Add checks to ensure these parameters are non-zero before performing
the division. If invalid trace values are detected, fall back to a safe
default of 1.

Additionally, prevent an arithmetic underflow in the touch reporting
logic. Previously, if the calculated or fallback width was smaller than
ETP_FWIDTH_REDUCE (90), the subtraction would underflow, resulting in a
massive unsigned integer being reported to userspace. Clamp the adjusted
width to a minimum of 0 to safely handle small physical dimensions and
fallback scenarios.

Completing the probe with safe fallback values ensures the sysfs nodes
are created, keeping the firmware update path intact so a recovery
firmware can be flashed to the device.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Fixes: e3a9a1290688 ("Input: elan_i2c - do not query the info if they are provided")
Signed-off-by: Ranjan Kumar <kumarranja@chromium.org>
---
Changes in v4:
 - Reverted probe fallback width back to 1.
 - Added check in elan_report_contact() to clamp adjusted widths to a 
   minimum of 0, fixing the root cause of the arithmetic underflow.

Changes in v3:
 - Changed fallback width from 1 to ETP_FWIDTH_REDUCE to prevent underflow.

Changes in v2:
 - Added check for invalid trace values of 0 to prevent division by zero.

 drivers/input/mouse/elan_i2c_core.c | 36 ++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index 5cba02a156ce..edb0a28d25aa 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -428,8 +428,17 @@ static int elan_query_device_parameters(struct elan_tp_data *data)
 		if (error)
 			return error;
 	}
-	data->width_x = data->max_x / x_traces;
-	data->width_y = data->max_y / y_traces;
+
+	if (!x_traces || !y_traces) {
+		dev_warn(&client->dev,
+			 "invalid trace numbers: x=%u, y=%u\n",
+			 x_traces, y_traces);
+		data->width_x = 1;
+		data->width_y = 1;
+	} else {
+		data->width_x = data->max_x / x_traces;
+		data->width_y = data->max_y / y_traces;
+	}
 
 	if (device_property_read_u32(&client->dev,
 				     "touchscreen-x-mm", &x_mm) ||
@@ -443,8 +452,16 @@ static int elan_query_device_parameters(struct elan_tp_data *data)
 		data->x_res = elan_convert_resolution(hw_x_res, data->pattern);
 		data->y_res = elan_convert_resolution(hw_y_res, data->pattern);
 	} else {
-		data->x_res = (data->max_x + 1) / x_mm;
-		data->y_res = (data->max_y + 1) / y_mm;
+		if (unlikely(x_mm == 0 || y_mm == 0)) {
+			dev_warn(&client->dev,
+				 "invalid physical dimensions: x_mm=%u, y_mm=%u\n",
+				 x_mm, y_mm);
+			data->x_res = 1;
+			data->y_res = 1;
+		} else {
+			data->x_res = (data->max_x + 1) / x_mm;
+			data->y_res = (data->max_y + 1) / y_mm;
+		}
 	}
 
 	if (device_property_read_bool(&client->dev, "elan,clickpad"))
@@ -956,6 +973,7 @@ static void elan_report_contact(struct elan_tp_data *data, int contact_num,
 
 		if (data->report_features & ETP_FEATURE_REPORT_MK) {
 			unsigned int mk_x, mk_y, area_x, area_y;
+			int adj_width_x, adj_width_y;
 			u8 mk_data = high_precision ?
 				packet[ETP_MK_DATA_OFFSET + contact_num] :
 				finger_data[3];
@@ -967,8 +985,14 @@ static void elan_report_contact(struct elan_tp_data *data, int contact_num,
 			 * To avoid treating large finger as palm, let's reduce
 			 * the width x and y per trace.
 			 */
-			area_x = mk_x * (data->width_x - ETP_FWIDTH_REDUCE);
-			area_y = mk_y * (data->width_y - ETP_FWIDTH_REDUCE);
+
+			adj_width_x = data->width_x > ETP_FWIDTH_REDUCE ?
+					data->width_x - ETP_FWIDTH_REDUCE : 0;
+			adj_width_y = data->width_y > ETP_FWIDTH_REDUCE ?
+					data->width_y - ETP_FWIDTH_REDUCE : 0;
+
+			area_x = mk_x * adj_width_x;
+			area_y = mk_y * adj_width_y;
 
 			input_report_abs(input, ABS_TOOL_WIDTH, mk_x);
 			input_report_abs(input, ABS_MT_TOUCH_MAJOR,
-- 
2.54.0.1099.g489fc7bff1-goog

