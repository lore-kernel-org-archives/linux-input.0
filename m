Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C75D3DDDCB
	for <linux-input@vger.kernel.org>; Mon, 18 May 2026 06:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085690; cv=none; b=fAhBLJ30chD2mJfZK+F7ynpyRO2rte3ulhU0ZmpaJdLFUtTneeej/EDpH7Aupk0oV5uJ+3J2Q7Om0mQx16dhvTxi5Kd//SfJIMGpw8t/1lDn7DGQjIdR4x8Nj/maBC0H4jkmZV6amAlUjkag2FLI3aOKLon6Y7b8u2BfDfnl3YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085690; c=relaxed/simple;
	bh=PF+n4KOP9NgWo/xGyeMKj/3893fM/5sKdK+hvMSSslg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eOhnat+Qm2U8rpfm4mcp5LEJyyMC9TkkSHxtcTcqFyf1T090IkfBS/i5CK/Y+00HxTtRlti+WKdAgWI9KAmoyzWDkLYzXUUqIK77zlBQBDWq/JvhPvEBFjzvnxI5+n4yGCB2Za3KMq3R7IWP2qOjSpeqiOcKPm5ycm9U7ewb8Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PD693mCU; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PD693mCU"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c801b30188dso767946a12.3
        for <linux-input@vger.kernel.org>; Sun, 17 May 2026 23:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779085686; x=1779690486; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUdS91k6DCIDDf+xxGRcNX7yYkxmhqfcOdKFFb6YxKY=;
        b=PD693mCU6eeeekDE6eV4y682dwMt476wKNjgDycsZDnWM+5mANQbiCZbJPPUDOKHSO
         bHqIApZovBwxLXzCHsB5Jvavn5fW9YZle1FogFnBI/ENs8AOcq+hvmKi9r79p7U/GxRm
         +L1/kQnp5dsaBrrO6Kj/GxWfwZ4lYCgBlXz88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779085686; x=1779690486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IUdS91k6DCIDDf+xxGRcNX7yYkxmhqfcOdKFFb6YxKY=;
        b=KbnZlKKEBIey/yLrpbPJ74GKFxddNbHAlWsJ/BXWGqhWdIZiNzbK7ulv0xsPCfDajr
         XZEYVdbufyKtiEdIeTea+PrUhOb/QWYYhFQegP4y53rAvavlncXFULfuqfzMhXe702dZ
         XDnVRTNJc4FJjHT9h6V7xl247GaIbeOgeiy98Ig9ieHWeaSSkon4uQTLM8FzDqr8HWgI
         atatXO7aQNvOOPOukB+/BGZWqqX3jK3hLae5lw5ZI5DLMW43vfWO1YBEAKXHB9TrvkQP
         ptb13ICDSwRGk/uacSrsvtTRn5NHBQiGvNo8XlY1pEPKwpQMWUn0MAQCwPFnYbOMOEZf
         t3WA==
X-Forwarded-Encrypted: i=1; AFNElJ9J9tTDG50DROI92qnnQVAN+BSP2k7LX/22ZCWt1HMcHyL5FiJPtKDX4G54G3GJJPQYBfjk1Jy8Cj4nYA==@vger.kernel.org
X-Gm-Message-State: AOJu0YykNEugpSuUZTYhoVvJCQuPS/BrzPF2p+sxDdjfMEgWo8eHbN8C
	cmQU2O/BJ3+FiC3nNws4hQVYNsIWxWjNrpRI2Wn/3VWuifeNRTrurieuj9JgRiR0ag==
X-Gm-Gg: Acq92OG05j8pilTvmObcGKVGquX0kt8pWHjNg8k0RVTZZbtAxZkMzE8dF4GMClGbUG6
	ph7Db74CAcrx5doe86EYWG1+gOkaFLmqsBt1VT4RmRIiP7JH3XA/Z5ICYFpLGIKMNPWNokxPu1C
	jYfNvzZRoZtoWy3hq6zfJKvGNK/zkTHVeFgZQGiLe+55g6flk2Z/8cTue+dLdMR7brB2NsklwTK
	UoKzfuzWh5+zt00/J/Zv27hSJPA8BdlEvKs61eq2cU18LEwVxG0oJXN5fIgIBn2sWFFbqSJsiYy
	Lxnz/HjcLTB9VgV5LgVk51my4X2L1CCMueJSoZ7zMfgPuoDWAgjHOkvU0qS/f51arlBi09kAgS+
	xF+kZ0AxZSnIExDk9nYHjw3h05nIwb7KDSabe+xRLJb8vjzfs++fEKnAywXnsDxYkYWhi15hrK1
	xAzi9DwCRud7/c6uY9cFKx8oOqA2/piRO8beFzd1XRGaJHpedNd8TObc019xPRPd3DCLoAaEBae
	eSseQl4sXFudbUYXJvA1Mh9
X-Received: by 2002:a05:6a20:7fa3:b0:3af:91a:ff72 with SMTP id adf61e73a8af0-3b22ebd4615mr16180689637.34.1779085685907;
        Sun, 17 May 2026 23:28:05 -0700 (PDT)
Received: from ranjankumar.c.googlers.com.com (220.185.124.34.bc.googleusercontent.com. [34.124.185.220])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb062e56sm12525109a12.5.2026.05.17.23.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 23:28:05 -0700 (PDT)
From: Ranjan Kumar <kumarranja@chromium.org>
To: dmitry.torokhov@gmail.com
Cc: bleung@chromium.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ranjan Kumar <kumarranja@chromium.org>
Subject: [PATCH v3] Input: elan_i2c - prevent division by zero on invalid device parameters
Date: Mon, 18 May 2026 06:26:24 +0000
Message-ID: <20260518062624.1147959-1-kumarranja@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <20260515071052.7DDA0C2BCB0@smtp.kernel.org>
References: <20260515071052.7DDA0C2BCB0@smtp.kernel.org>
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
values for x_traces, y_traces, x_mm, or y_mm, it results in a fatal
division-by-zero exception leading to a kernel panic during device probe.

Add sanity checks to ensure these physical parameters are non-zero
before performing the division. If invalid trace values are detected,
log a warning and fall back to ETP_FWIDTH_REDUCE to prevent arithmetic
underflow during touch reporting. For invalid physical dimensions, fall
back to a safe default of 1.

This prevents the kernel panic while allowing the probe to complete
successfully. Completing the probe ensures the sysfs nodes are created,
keeping the firmware update path intact so a recovery firmware can be
flashed to the device.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Fixes: e3a9a1290688 ("Input: elan_i2c - do not query the info if they are provided")
Signed-off-by: Ranjan Kumar <kumarranja@chromium.org>
---
Changes in v3:
 - Changed trace fallback values from 1 to ETP_FWIDTH_REDUCE to prevent 
   an unsigned integer underflow in elan_report_absolute(). 
 Changes in v2:
 - Changed error handling from aborting probe with -EINVAL to logging a
   warning and falling back to default values.

 drivers/input/mouse/elan_i2c_core.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fee1796da3d0..c64e1dd1e60b 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -425,8 +425,17 @@ static int elan_query_device_parameters(struct elan_tp_data *data)
 		if (error)
 			return error;
 	}
-	data->width_x = data->max_x / x_traces;
-	data->width_y = data->max_y / y_traces;
+
+	if (unlikely(x_traces == 0 || y_traces == 0)) {
+		dev_warn(&client->dev,
+			 "invalid trace numbers: x=%u, y=%u\n",
+			 x_traces, y_traces);
+		data->width_x = ETP_FWIDTH_REDUCE;
+		data->width_y = ETP_FWIDTH_REDUCE;
+	} else {
+		data->width_x = data->max_x / x_traces;
+		data->width_y = data->max_y / y_traces;
+	}
 
 	if (device_property_read_u32(&client->dev,
 				     "touchscreen-x-mm", &x_mm) ||
@@ -440,8 +449,16 @@ static int elan_query_device_parameters(struct elan_tp_data *data)
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
-- 
2.54.0.563.g4f69b47b94-goog

