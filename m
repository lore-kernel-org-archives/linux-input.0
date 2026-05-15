Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925BC318121
	for <linux-input@vger.kernel.org>; Fri, 15 May 2026 06:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828176; cv=none; b=SLFhjHLB/Pz1XGK/pdKcNzkiO+FTUJk2SNig2ALnPr789QrHhtOBMYn1GBEDdNAcCmooq/aF+kBFK/vx5kdADmORM97AOMB5nr4UpvSmQ79AO8tRNCxS0cvZS7BYGEe0hS/9bAG54cl7UmvYfBMkbnQzcOL0vG/6bT7f3Hx3e3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828176; c=relaxed/simple;
	bh=6JtnPIk9pt5yNv5Zwo+M8IPxJi0/Vqhv8YUANrQafBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H1scXRmRTS7yeQtd3B7qsVeOmmxHUML6jhdzlyr71O4E1w9USnRWCppNrdLPY4Rfb2eBPrT3bVnqdztRxmVSzsswBxZfjMZtnE0BLOSJ3qCftHp7X7u6J4lNeIJCNHF1P4A1GqwzSCOF/LTqf91sK2WWKOb/FmopKhW2LC/xK3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Z8KWnZUi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z8KWnZUi"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36931e4f5e8so1553590a91.2
        for <linux-input@vger.kernel.org>; Thu, 14 May 2026 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1778828175; x=1779432975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VL9MOgE8V1tj2rmnSqeusE5lJRxKq56SKAjQcQI/xkI=;
        b=Z8KWnZUioj2bH44XPFv9uusEUz7u70MwyTfXThRyGfez7etfUO4JQ8WP/MGDOKTKop
         k06Q4TSrC/9qC5Eju6SOSqJjSKcfAn6NsBYh+g8HtXOfUuNCXI5asjANMhTin2FXgEx5
         hbwdOOMyj4ZTgF3NRF3a8I0e8zk/3GtQYlF6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778828175; x=1779432975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VL9MOgE8V1tj2rmnSqeusE5lJRxKq56SKAjQcQI/xkI=;
        b=rpphS0GRUMIzZJ0lVhy0ptT+E0HSwUrLQcTf4hUGx/QewkZ5CAFzAJEv3kpLgbGDTD
         mIbG0nHUBR2HDfnCSkYg33wJt3JYDKolLFjeO2CzH1Piz1vfLZm2oRbwJUa5rDNkMfsX
         RfChPoK6B9PEZWoz+Jk7WReBBfTtc4uLD5t9E+e435JulbeRDE5N7Gxeoc2NOPHIrxCa
         77bEKbE/62mfkUd1JaU7fBYRDDK7Lxko7UmMeOIDQIPw9+1VYpYfsU62o+PPjepyMYQX
         oj6iZrXVMkIBUpjmyopyGz75gmcaK7xHIRpaXY3Sx2xDrhUoHktjSNeiOB38ymHo9cVS
         MvuA==
X-Forwarded-Encrypted: i=1; AFNElJ9tWSwhz+bqNIQqX2cenv9ZG6ct3zrQAMkdaXuyu+K2FA/cby5a8LQL+kNim2H6J5NAjKoyWXi+7+QYAw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTbhXJAM8fm0PNAaAeyOOIpSEeDJZK9pfsbYlcJBsr1pVJIFk/
	hC8jnq4m3PpAhbMJG+9FB+0bRtj+wgtmzhRs0rzvZ3Xd08HyrUJdYUAirnFiaj0WAA==
X-Gm-Gg: Acq92OGyvUTJOAaT38943gyx7H9Qh3vPMdz3jjEZyJ0mkIT0cjZ/D5iyGmj1VGNzmJ4
	Ighs9penpYScI//bhtKO4n/LiOr8DCBsCmPK3AMLKt7kIeEh0EISlryTzQ81cLqe5u09v1+Tx0o
	goFsXn2lK0KHvaDdEvqJuJh1hk8U+NWLenGO4utRr2Bjrjs7sYrKZdJnkhFS0X/FzI7Rx0SqebK
	eAkUEVG7zbb0aktR+7JYx/Vzp/au0jzhJn2ncce+1Or4rn+i9RWVTDhVpDGZPe4ECpEMacGbcGx
	SxKA6G14h81TLIL5M2ADSMNx86jrxEKoikGCqzy5uUUExHZHZAR1REwhJJyGHc3J8XdUAAP4faA
	FeqWcfM7oAnAeEe1yv0uaTB1N30Ln7lIPEen5luc7IwpRGuwpvRZR0qqV9T5jVtB2BMNsbjb9E5
	i/5UlM1SdfCfuxME8snnTZ1PTKIj0Vfm9VaL4Js5wCdL72IyIGL5W+1dG9SGLbPYj7YiMmsr/zf
	CAzX06OiqygmoufnS7fxIg2
X-Received: by 2002:a17:90b:540d:b0:361:3224:2f65 with SMTP id 98e67ed59e1d1-369519af6d2mr2650718a91.3.1778828174112;
        Thu, 14 May 2026 23:56:14 -0700 (PDT)
Received: from ranjankumar.c.googlers.com.com (220.185.124.34.bc.googleusercontent.com. [34.124.185.220])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369513fe6f2sm1688068a91.0.2026.05.14.23.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 23:56:13 -0700 (PDT)
From: Ranjan Kumar <kumarranja@chromium.org>
To: dmitry.torokhov@gmail.com
Cc: bleung@chromium.org,
	bentiss@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ranjan Kumar <kumarranja@chromium.org>
Subject: [PATCH v2] Input: elan_i2c - prevent division by zero on invalid device parameters
Date: Fri, 15 May 2026 06:52:35 +0000
Message-ID: <20260515065235.1913403-1-kumarranja@chromium.org>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
In-Reply-To: <agTlxHSZqSI8cnjK@google.com>
References: <agTlxHSZqSI8cnjK@google.com>
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
before performing the division. If invalid values are detected, log a
warning and fall back to safe default values (1) to safely bypass the
division.

This prevents the kernel panic while allowing the probe to complete
successfully. Completing the probe ensures the sysfs nodes are created,
keeping the firmware update path intact so a recovery firmware can be
flashed to the device.

Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
Fixes: e3a9a1290688 ("Input: elan_i2c - do not query the info if they are provided")
Signed-off-by: Ranjan Kumar <kumarranja@chromium.org>
---
Changes in v2:
 - Changed error handling from aborting probe with -EINVAL to logging a
   warning and falling back to default values (1).
 - Bypassing the division instead of aborting preserves the sysfs
   interface for firmware updates and keeps the pointer functional.

 drivers/input/mouse/elan_i2c_core.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fee1796da3d0..32b2849ab36a 100644
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
+		data->width_x = 1;
+		data->width_y = 1;
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

