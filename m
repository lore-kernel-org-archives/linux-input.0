Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F74374E5A
	for <linux-input@vger.kernel.org>; Wed, 13 May 2026 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778657977; cv=none; b=ElYeNQlYe407890j+w/OMByPhucpU3rZx+wXwddRg0ZyhFGkjADYBdaUVG55CdK6dc6FkYO799hhiujXBi4i/YkKRFllkou0PmZEg15EU/g5mmh907aePk6xSrYB450wXC8sgFJvQjnu7INl6MiKUgO7BxAX3ZPVh3FdWfvmJi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778657977; c=relaxed/simple;
	bh=H12n7XT8L0vS9/nUJhthKydiP6KILzegUqtu7PMuprU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BuIvKJoiPAmSqD1EKxZcUWLuYvJUQlYZplMYXPADCgdUCuLwCnt977ORD/PGy2mE01uZAfVKf+skDMbifDWrZvKEImXD01GOhZKjjkCZKUYPhOCF7RM1u8oRcbkQW9b3SwC1WGa4aJAqnoe/eaF9DEqy5RsnZCiNWir4BwBXd5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Cz6QKmxq; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Cz6QKmxq"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so3962041a91.0
        for <linux-input@vger.kernel.org>; Wed, 13 May 2026 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778657975; x=1779262775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQjma9I5R6nbaFglLQyZciBB/30vaX5pQDI/IG+cY1s=;
        b=Cz6QKmxqRuVXW0+DPk2Lt81eurMBvjQlMlTLVh4MpUBUaliK6YRa+8urkMD9YeVLE8
         ozzWZsO0fAcmPWXIVfTkrOiasWTjue1zP8HgoCh19iHlH6CCy4lAhWMayOXG+gWUOhER
         bUvu8/b8gTSOuynzEDKunA59O0iCW2BG7VGIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778657975; x=1779262775;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQjma9I5R6nbaFglLQyZciBB/30vaX5pQDI/IG+cY1s=;
        b=kvnE6WRqVMquG2V7K9V4UNSOcUwiPZvgkdwuPu7xJOVb6AHqVQkSyY7CohHFmWlJh2
         R5BYSMjIbOqOEHrnNOa5ilfrza277l0ajiA87acy6IZKBoAcOpFxas4euHMQENREUEiW
         M9thzKbbu0xSKIUSdT0ZSluzogeKLda0VGJ6Qf7t4ElQZfpbxEczz6Wl/jhmTeB7BhjJ
         PZfZ4hJAByss7ww6kwSNPxEUwPDU1jy1EO4vH9Wy39q721oJP1uWQdFib+ZVmcdJ/+H8
         SQ5aHBshF3DMN5VEdUDSVlFnCOpK/8lzkvhbKUW+v4gFVB562XzZBrDdj/QMmEu3+QHN
         9SQA==
X-Forwarded-Encrypted: i=1; AFNElJ+5H3OwNzYYXgSrQWaBwHof0w2jKAelOlEWJvdCD/QenEy9RMPMJAq5cCH1XKWxfSf2yx8oCii0lRSMRQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ/KQhinYGHIkrIPQ9RRIGkMhNjtQ9RetwmDOj0huOcNSjPL2z
	rh+YKAajtH7E6U4hPWqIr5AphkDK8DFlPJZojreY3yKsaxeN35s98Euu9h+f0ferpA==
X-Gm-Gg: Acq92OHB5f4zKN2uL3lIVobr22th8F39XLg+WlEmvk/68kXr5lA2v9RymBkf0onFIRW
	psBniSFGdZPGB5Xc9DCoyw2gXJCaUcjFJgQZDoZv4MyjSP2CIa1j+yjk1J93+EeUH8nokaw03eE
	Xa+V6ZvmcEkX+fNnAQHLckgts1o3QDy9P7zVCZ6OweSEIQE/xiKi0MrS7ftxh3efcN0j1MIgaXg
	K+r6kYmvpFoyZPMI9ZH1v5HUg4Q1gcBui2P+TW7uhDfgE++IWD86QOC981qDbjkG26ksbbjGcuZ
	kkNG/vndeQRtky3Zyvw/NEMa20uyG0E9bzv+EmVyHMm6oBwBF6bFoz+p1K06jMPSLMNB4h4JtHn
	p+gXhZs8NSYqqMuxJQ/iL4Ead+lh2kVTbIPTrcL6H3TfzPr1RMeVThSGmZxVr8+oesqF6jvkto0
	vIFbtQXc8qa0fY+85oC+I+RuiWu5enxBSVzEg+R9i2rQ5JNcIaVim2mbS+ySYQaCPciu/UdBBO6
	yurlFP1PYh4BtV13uTdQ0dDQOInX4oajyM=
X-Received: by 2002:a17:90b:3901:b0:367:bb54:8768 with SMTP id 98e67ed59e1d1-368f77c90f0mr1889106a91.4.1778657975026;
        Wed, 13 May 2026 00:39:35 -0700 (PDT)
Received: from ranjankumar.c.googlers.com.com (220.185.124.34.bc.googleusercontent.com. [34.124.185.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368acf6ef8fsm1865760a91.3.2026.05.13.00.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 00:39:34 -0700 (PDT)
From: Ranjan Kumar <kumarranja@chromium.org>
To: dmitry.torokhov@gmail.com
Cc: bleung@chromium.org,
	dusonlin@emc.com.tw,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ranjan Kumar <kumarranja@chromium.org>
Subject: [PATCH] Input: elan_i2c - prevent division by zero on invalid device parameters
Date: Wed, 13 May 2026 07:39:08 +0000
Message-ID: <20260513073908.3326178-1-kumarranja@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
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
before performing the division. If invalid values are detected, log an
error and return -EINVAL to gracefully abort the initialization and
maintain system stability.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Fixes: e3a9a1290688 ("Input: elan_i2c - do not query the info if they are provided")
Signed-off-by: Ranjan Kumar <kumarranja@chromium.org>
---
 drivers/input/mouse/elan_i2c_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fee1796da3d0..b5fd63928afd 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -425,6 +425,14 @@ static int elan_query_device_parameters(struct elan_tp_data *data)
 		if (error)
 			return error;
 	}
+
+	if (unlikely(x_traces == 0 || y_traces == 0)) {
+		dev_err(&client->dev,
+			"Invalid trace numbers: x=%u, y=%u\n",
+			x_traces, y_traces);
+		return -EINVAL;
+	}
+
 	data->width_x = data->max_x / x_traces;
 	data->width_y = data->max_y / y_traces;
 
@@ -440,6 +448,14 @@ static int elan_query_device_parameters(struct elan_tp_data *data)
 		data->x_res = elan_convert_resolution(hw_x_res, data->pattern);
 		data->y_res = elan_convert_resolution(hw_y_res, data->pattern);
 	} else {
+
+		if (unlikely(x_mm == 0 || y_mm == 0)) {
+			dev_err(&client->dev,
+				"Invalid physical dimensions: x_mm=%u, y_mm=%u\n",
+				x_mm, y_mm);
+			return -EINVAL;
+		}
+
 		data->x_res = (data->max_x + 1) / x_mm;
 		data->y_res = (data->max_y + 1) / y_mm;
 	}
-- 
2.54.0.563.g4f69b47b94-goog

