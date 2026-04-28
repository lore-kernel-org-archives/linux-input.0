Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A26A282F3F
	for <linux-input@vger.kernel.org>; Tue, 28 Apr 2026 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338566; cv=none; b=AMtR9vq2evLjcBaxqIn/2KVwNp42gVKR9GT4x1dWiTeblOJ18gTqcBm3pCzX9s0+0dUdlX/JivJoxCcA+nUvERwL1Lbm4Dyxx4RoaGFKalHZ1f8YFCbICNxS75JVR65oUwOTOlpYAijSupSsZ/78Nt/vbnzabx408w094c4OZVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338566; c=relaxed/simple;
	bh=r/elXJM0fR9V2vGs3JzDAmTG3GxkVjz51UhlEFnw6jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+VAMTwsh7vvnuoIcpXHttyGOispTfyctRELw5tvKZEGUpL1/9AniF2JAGMasEx5xSPH8If1fjKS93t828i4X6lZzjGdC2SXlNh6ZX49uEdLBZ0F4ygWRyopU/avdLGmOOTKdD9e8u4wEmJCeSupsJnd0nCWmxLelIAo4gUnL5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFRnZk3I; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFRnZk3I"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d9916deb14so19170292eec.0
        for <linux-input@vger.kernel.org>; Mon, 27 Apr 2026 18:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777338564; x=1777943364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V1UWV0CnQblrZEKWmmzMKh8oajfG3299hpJ7cT8CIuo=;
        b=iFRnZk3ITSRmxH7NkzG/vprI/o5ytQJu8Z1aZ2NcyzHHGPiTOkAC3T8CXnl3CVFdRQ
         yqpSGWcEbf+blMdzomdGkaTwRhhYClhoeqWW1F71QU//TwwG7GWUJJxG3EtEp2wMBMvZ
         7Vm0TDUF4QeWZNZ143XwqQrI3/WGEw6jFTvEVL7iLtYTa1iB+kaD43ZU51OQ1OMKG01E
         hZca01+7P8dFU3VoI8MH7sYEKMo7kv0CddJbpMZDLnU+zWN1CpEpF/EttZBPy4zMEOAQ
         va3YOOkYB+G8BsP9sgfQ1TK0kdiLYkPI4auskCcF0NYjoBm+OvPqCJgDrR4kiLQM3E6y
         YrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777338564; x=1777943364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V1UWV0CnQblrZEKWmmzMKh8oajfG3299hpJ7cT8CIuo=;
        b=r4NoqtrRL2gKBf0yeZ6YkTWbhmhldxrRzs7XrR447BNYfvmbor2raTKWrmfDjkg/eS
         QNMXs+bivfyOtIVsGc14isG8Y6kisA3GH9TXMGj23rUSIvB4dih+ciuxAEZnOXBZM8st
         8T26eerapJFxnJECGkSKClIzUdriSmsMP686Nm1RnxkoSH05+d9iigutBDrnF7umkdmB
         sKQzqBv2WwAA+bqJo4VOUf5tgksRIn8MEHC6h+awYWAMlR6CrP74irm0hWaCy4ujaCGX
         wu2LltGuvwsNkbWk//vNAMaCk1ZrTdF2leZ0irsxHM9xU4Xq1LyOms1PVvchC08wVxar
         Ygqg==
X-Gm-Message-State: AOJu0YzIpPYQJy9aJ9BJybG9QVNH1+Rx8/dx8e0t0+xlRwMNkRcuMHEA
	Psr7q6mGFWc40H3dEZkXcF6meoB0h3I2aPy+vH5tScV2ZzmGeoAI97QgTyOG7Q==
X-Gm-Gg: AeBDietSTsua+04eOs2X8l81jFSYXUAoomqcf/+9meaOwTE/R3yhfcGxzNku86lfop3
	2btcEz1GhCG2cTIk1EY6HJu41Yh0FaavSMfOLe6FdvtVbdaBq/GdpomeKOPHxQy/P/jUGtzpbkc
	mN4iYQYujN0bnvHkZnbVeXB43gRZyD8rBwhjRejgX/0Z7mVzWuSpYMYUVXiq4LSUnl5rwBsIb7+
	ohBJfiAiM+zH+UCkrVECfXQcwFD51KSoxcC10xIdx1lsdDzBAUq7YYAynFqtsIh6b15GhVEFYrI
	Koygk8hAR9A/T6EBVPiEINN174ZiYYYYfsDAbWE0PeStbaBNwar19xwbi+RKVCExIEkB2PnpBOd
	y71QHmfvvuqYiUK6HfkEK39+byanVNvQWwmMLcH0dUeFRpaCE6dKNibzldmcLka85W5j4/0LEGA
	XIxHLX5QL6te7+IoFWOyw2hdTDXZBKQLDkB16loQKcNM+D8t5bRAmV2bAgq9CJyHXEXc4rbBGP4
	laBkzr82PdagjhJtxPnNCHrWOWbgDrormVP
X-Received: by 2002:a05:7300:5721:b0:2d9:b466:5e19 with SMTP id 5a478bee46e88-2ed0a155432mr640510eec.21.1777338564052;
        Mon, 27 Apr 2026 18:09:24 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:e678:f42a:a63c:516c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed09fb64d7sm1071380eec.9.2026.04.27.18.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 18:09:23 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] Input: rmi4 - fix num_subpackets overflow in register descriptor
Date: Mon, 27 Apr 2026 18:09:16 -0700
Message-ID: <20260428010917.1320927-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260428010917.1320927-1-dmitry.torokhov@gmail.com>
References: <20260428010917.1320927-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RMI_REG_DESC_SUBPACKET_BITS is defined as 296 (37 * BITS_PER_BYTE). This
may overflow num_subpackets in struct rmi_register_desc_item which is
defined as a u8.

Fix this by changing the type of num_subpackets to u16.

Pack the structure by rearranging the members to avoid holes, change
reg_size from unsigned long to u32 to save space and ensure consistent
size across 32-bit and 64-bit architectures, and use DECLARE_BITMAP()
for subpacket_map.

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_driver.h | 8 ++++----
 drivers/input/rmi4/rmi_f12.c    | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/input/rmi4/rmi_driver.h b/drivers/input/rmi4/rmi_driver.h
index e84495caab15..865ffc7882f3 100644
--- a/drivers/input/rmi4/rmi_driver.h
+++ b/drivers/input/rmi4/rmi_driver.h
@@ -11,6 +11,7 @@
 #include <linux/hrtimer.h>
 #include <linux/ktime.h>
 #include <linux/input.h>
+#include <linux/types.h>
 #include "rmi_bus.h"
 
 #define SYNAPTICS_INPUT_DEVICE_NAME "Synaptics RMI4 Touch Sensor"
@@ -52,10 +53,9 @@ struct pdt_entry {
 /* describes a single packet register */
 struct rmi_register_desc_item {
 	u16 reg;
-	unsigned long reg_size;
-	u8 num_subpackets;
-	unsigned long subpacket_map[BITS_TO_LONGS(
-				RMI_REG_DESC_SUBPACKET_BITS)];
+	u16 num_subpackets;
+	u32 reg_size;
+	DECLARE_BITMAP(subpacket_map, RMI_REG_DESC_SUBPACKET_BITS);
 };
 
 /*
diff --git a/drivers/input/rmi4/rmi_f12.c b/drivers/input/rmi4/rmi_f12.c
index 8246fe77114b..9bcc27e9d308 100644
--- a/drivers/input/rmi4/rmi_f12.c
+++ b/drivers/input/rmi4/rmi_f12.c
@@ -88,7 +88,7 @@ static int rmi_f12_read_sensor_tuning(struct f12_data *f12)
 
 	if (item->reg_size > sizeof(buf)) {
 		dev_err(&fn->dev,
-			"F12 control8 should be no bigger than %zd bytes, not: %ld\n",
+			"F12 control8 should be no bigger than %zd bytes, not: %d\n",
 			sizeof(buf), item->reg_size);
 		return -ENODEV;
 	}
-- 
2.54.0.545.g6539524ca2-goog

