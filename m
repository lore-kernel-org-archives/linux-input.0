Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5533E8C47
	for <linux-input@vger.kernel.org>; Mon,  4 May 2026 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920897; cv=none; b=pAMAOgbTbhHolTwEm0kEfAuprimifxVHbd4ADR+fdUJtE9O5Z4D3A1X/GveZP6hNmU/WxtyT1SsB0xeK1o9k4jLa8IdgXbp/wIuSI9sJwah8IpC5nbntb721+tpMyKScwa/bL8LFNaL6l0hKVpXF2BO0IiNNrIMm8wCvdXxMk/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920897; c=relaxed/simple;
	bh=P7VWyi/2lbgt4sThwchGcXNL9lz2H3z6UR0REd9qUIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hs/GYlhbwT+LuDpAwr5XBLKCF0sOqb2xL05tYKzkDgaU30xPoGjzsi97MZpyOLrul/kA/3GNto989XjAguY2MF6ZHTfF5Cl+NXsJvXPYAfQoOp5oPJuv4XcbHKe7Vz07HIviprVR01r5bk1KBUb9+llV6pBmSBzjOOuiP+n9mxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERW/NoBk; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERW/NoBk"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12c19d23b19so6399303c88.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 11:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777920894; x=1778525694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GIvP0Uw5IC9qQ1n84oFyoPGgjxzZR2GoiMZtJIt8iCY=;
        b=ERW/NoBkgU9XUADqa3YxUD4uXjosvCY4cHWDP8kngtWIKU9MImM8xQMk+BE0BJorY6
         zLHGweHOYpFe7N6OCP7lWz1PSGn2OQyHrI28SwikKJbK1PKB96XC51bhQmh0a14iLx4h
         5HIEIk0N4wxiHMzM1p7oNCfJsipeI0Kha3sKKpOQN+Lq+aEGAHjMp/XLxokcbUJ3VKwy
         jLtkV1o4rw8vcTYO+2jKEWPWg9ez96TccCADbSGKpZSCRmHtCSFGSnaQemA7GwitnfSq
         5zTGG/r5p5UG6byEJCGG+44m7KFFomx0mDy7ls7owcd9H8ieOV/GxQcC7gMvwx8I7s7F
         Vs0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920894; x=1778525694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GIvP0Uw5IC9qQ1n84oFyoPGgjxzZR2GoiMZtJIt8iCY=;
        b=jC7xoj1PaVuY8Hj70NBi6W8dPiUO2p589X6u7MkvVDuv2Or0jx6YLuqzkT99QRDbZG
         l2xF5uXx0UQswEq1V4+Ob06tl9WWozhlR3j0LWZlA17Bys3xGfSd3xQGsq63+a2n6yhX
         kRKV9TT96dlqm+OWL59txR73Bgtb9jH8xcAt0ivvcjGEMQvOuNvrlfbdEfCnQ1lwjEj+
         pSCKLy+DQCG4v2PCtxpX8wu3q9C2EyXkPkMEChsB0nqeL2RudXVr0P+GxRQIjTmtI+lM
         INM2C0z5aYM11HNVUElnjBLz3zZ9XDBvsgdg5HRrPG/9T0grYS+p0nMxRlE0f6GOxdS1
         tYmg==
X-Forwarded-Encrypted: i=1; AFNElJ9JVdthe0Uk90EwcIKROjIDvZDZr2DdBrjSfQondpLBdh6Z5I554POXo28B5n760nkHbLxaq5qVaFdfsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhV2oVYk/Wt9VHLubH5WyvznwRK3cC1KBg04VXx7DEjeQ7Mc8m
	I1JikmkvDgH8sBVqs0ZxBrEY8QDjdXccdKA6okSd/7G309t0E5vK1Uxo
X-Gm-Gg: AeBDievTaE5hUCKH+zVFaMWG+eyroW2ETITAykrn46YrDoRpoCMM96fJzoGUF9PLm+v
	90ILnhu2W8TcTAhsKABgL5jz+1wrrlbu+YlM6Au45n3ve4l2O6/7+3pN6LR8SFFXdGhI4/k/Erm
	QszKeMI4zIn8ZredWrDDczxCKUH9J3A9Em1wrQ+ROXlENmX8QOBFiHYHrD0YAkOVxCjfPVjLH/Q
	RPKixkIMw0D2mOchtdmY3GKqeuFzlZYIBMm7HBCHP76pvn8GuZa/i/z6aPVrpUbwf3eNEhlBcde
	5pY43rObMUDgDPyQJ4llwdID63E3h/ZcRZoN+IgXZmuIeo2DSHl1twwm061G/LRaCY8KKwMcrVx
	ki0ZUsTvY9051y8qK7+tlYBq/+mEh19yFSR1DBVatfQJ33z4wBN/bPIPo24IOTU9TcrbkF2wD25
	XrTIzJnW3LN/OGhjf6TCEY21sKGUOR8y5IVYNbeN/oszi1NlQSCL6vvNLtXU5lnO9wVub99LVqG
	uScDjMCmTcxYsi/YD13iWejyA==
X-Received: by 2002:a05:7300:f194:b0:2e2:185b:87d9 with SMTP id 5a478bee46e88-2efb9e7cf64mr5468284eec.20.1777920894192;
        Mon, 04 May 2026 11:54:54 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:5b87:9b19:32e2:2981])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3bf6812asm16830718eec.28.2026.05.04.11.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:54:53 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Nick Dyer <nick@shmanahar.org>,
	linux-input@vger.kernel.org
Cc: Ricardo Ribalda <ribalda@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Input: atmel_mxt_ts - check mem_size before calculating config memory size
Date: Mon,  4 May 2026 11:54:46 -0700
Message-ID: <20260504185448.4055973-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
References: <20260504185448.4055973-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In mxt_update_cfg(), the driver calculates the memory size needed to store
the configuration as data->mem_size - cfg.start_ofs. If data->mem_size is
less than or equal to cfg.start_ofs, this calculation will underflow or
result in a zero-size buffer, neither of which is valid for a configuration
update.

Add a check to return -EINVAL if data->mem_size is too small. While at it,
change the types of start_ofs and mem_size in struct mxt_cfg to u16 to
match the device address space.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/atmel_mxt_ts.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index 28b2bd889c70..d660cc5b5fe3 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -275,8 +275,8 @@ struct mxt_cfg {
 	off_t raw_pos;
 
 	u8 *mem;
-	size_t mem_size;
-	int start_ofs;
+	u16 mem_size;
+	u16 start_ofs;
 
 	struct mxt_info info;
 };
@@ -1657,6 +1657,13 @@ static int mxt_update_cfg(struct mxt_data *data, const struct firmware *fw)
 	cfg.start_ofs = MXT_OBJECT_START +
 			data->info->object_num * sizeof(struct mxt_object) +
 			MXT_INFO_CHECKSUM_SIZE;
+
+	if (data->mem_size < cfg.start_ofs) {
+		dev_err(dev, "Memory size too small: %u < %u\n",
+			data->mem_size, cfg.start_ofs);
+		return -EINVAL;
+	}
+
 	cfg.mem_size = data->mem_size - cfg.start_ofs;
 
 	u8 *mem_buf __free(kfree) = cfg.mem = kzalloc(cfg.mem_size, GFP_KERNEL);
-- 
2.54.0.545.g6539524ca2-goog

