Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9853CE091
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 05:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586563; cv=none; b=EeZOTFKCPlTh7qQC0ldX1sptKgImuwf+yKIwLreRvPvPIfMIo/7jqdCWYK/HAx5Kgnzf66gd2hF/rF3LvgIFBwD/E37IeWxEb1Bx7nOByxkpoGd6mMzyCWSjE5oA3rSSUv4zv+5eAGJE48/G7IjFeB0Pj56GvkiyAMwHSV13+ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586563; c=relaxed/simple;
	bh=ru6x3RlJfbCUE8DVyQmiWDo3PoM/e9yRCjb96yp2+mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sa8Mle1y6CFew4wMgc37pxjhtL60u0v1q7QDf5AbadgK22JCzjRxc5Qy2hnv4Saz4EogGw+DXuT83rdpuAHrM7TxEAonRbitNio1wfmkq6KYhQQAAG7tbOfLdEgOqaNbkgFhWwtpoFQ9XDoFLfaq976hQplRwVC2RM0SN2RlqDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7RdUsL5; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7RdUsL5"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-30b6dad2382so3637664eec.0
        for <linux-input@vger.kernel.org>; Mon, 15 Jun 2026 22:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781586561; x=1782191361; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FeVlvWkv22rR4PXPj+5zPYJxlOA+VvyqrnuksJQx60Q=;
        b=N7RdUsL5a+6zG+KkzIkofLTLXmlNunh4eygZUxcxQ7stVKgTik1vDtcQovtS+3mWio
         lzXznluU0gcfStW6zJBuz3UmAPVYyaLQ2Y2pmgb5msrepwo7FHw22uQOdt5RvXoBaTHl
         9BjRTa5mjxlXYN+yTpTLGOrIE1fHIDjKa8bHl/3RD/kmKJgwnINJVHEf8z7SM9Tj3GtG
         xWsVh6K7A+F1oriYNUGZ+lAaitKeBI/DJYxsuvRc6TAm2v+b7W/+K8XFd+aZYRBUdZpn
         pT/uYU4qbyHSMw3NLyoLZcDDCf/cXJEea61meg3J5VFWmqjc/V8jIX1eEGn2dpOEdWCq
         4ucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781586561; x=1782191361;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FeVlvWkv22rR4PXPj+5zPYJxlOA+VvyqrnuksJQx60Q=;
        b=OrQspSAFQQThyonDOEc0UJAt4ntW72Ixv1tw2o4Ya6k0aoLtM7ELUGSrcmxav7/zvK
         4GCWiwCP8NFq/+xLq31r9dxlaLZ+kjtff/r/qHwc4JrLmMFNIrYuBEWINJPGZB3G8UvX
         j/nQLDZD7OUeQLQVtxAqCxeN7DLkFAJPglqSgrKEiOFf+Ls4XW1lPA4a56JkzJN2KMTR
         kWGWpcVMsd8HvKo/DD0Nfk3uc2IIuMKz/x+EKUJDLEKVBgruV60Px5+y/iAEOwIwddzr
         /OPxQoLiguH2d2nEjVl5FGm9PSaXg3jeY1J3/JFGQji6wemTDLyYb1tJqUQpIhU4wSaZ
         1Gqw==
X-Gm-Message-State: AOJu0Yx57c2XgLJNsW1qyXVmvJ3Am+Px8AJ/wwXo61vn1T9duvG+N5Oo
	1sWvBiwFSDTRkSyEOPZwBMfaJaVqM7gLTn29PjBN5jFGCvYR52K2xYL+Arh9mg==
X-Gm-Gg: Acq92OHmLDtUoG6xp18U+DEAtydFGxeUIpFD8Fmw1L0Z0v4f11YFdvA0B7Sq1R/OskZ
	+/nrAqEtClTUdvxorfOrOlGR/wF6XroIH1s+nVZMFljqmAfYxMCKr1A1ls8jkO/cOABiveCJr06
	kZNFxuCrwKdAgqlmqQLL+/sYl0HYfkS0+U90LKMSQKMsBgbrSbfCukNg8wHU0LdHHGk+6oQrRTf
	VHEXw3YR4xAlb6GUqfwM+LChVhYpy5QrwZw3++YYzsd+JD9QeP41pNEqx9qEDJlDtCcx9CGCbch
	uWH4gxmo680ShwP/E47YAY5KN26uGocrSQNt0Z22sCw/IM1ZPIgUKnYtc6OxVDC13XJVcyCLD1B
	ACXuAAJ0SWDsuwGrtpblK1HOyqxTqPBZZvyfQEe4b1fPXTTiwDm+BCaYRnHN1MkIpNEbnqRKi4r
	Pxjpo0tUq88FGOHIL7JzWt4AAUwlTXBBgAJcFuivK8LvuXHmTdeld2yaMtD5nEiUJvlvXg0HUtW
	byN+Rs+2SU1+a0=
X-Received: by 2002:a05:7300:f10a:b0:307:91f5:92e2 with SMTP id 5a478bee46e88-3081ff4b659mr9497608eec.4.1781586561366;
        Mon, 15 Jun 2026 22:09:21 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3714:f5c2:9b83:3df1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081ea4fe55sm17266615eec.25.2026.06.15.22.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 22:09:20 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>,
	Bryam Vargas <hexlabsecurity@proton.me>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] Input: mms114 - replace BUG() and fix alignment
Date: Mon, 15 Jun 2026 22:09:10 -0700
Message-ID: <20260616050912.1531241-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
References: <20260616050912.1531241-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid crashing the kernel with BUG() when userspace attempts to read
the write-only mode control register. Instead, trigger a warning with
WARN_ON() and return -EINVAL to allow the kernel to recover.

Additionally, fix parameter alignment to match the open parenthesis
in several functions to conform to the kernel coding style.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/mms114.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
index c59aec8f2feb..bf01eee0560a 100644
--- a/drivers/input/touchscreen/mms114.c
+++ b/drivers/input/touchscreen/mms114.c
@@ -95,8 +95,8 @@ static int __mms114_read_reg(struct mms114_data *data, u8 reg,
 	u8 buf = reg;
 	int error;
 
-	if (reg <= MMS114_MODE_CONTROL && reg + len > MMS114_MODE_CONTROL)
-		BUG();
+	if (WARN_ON(reg <= MMS114_MODE_CONTROL && reg + len > MMS114_MODE_CONTROL))
+		return -EINVAL;
 
 	/* Write register */
 	xfer[0].addr = client->addr;
@@ -310,8 +310,7 @@ static int mms114_get_version(struct mms114_data *data)
 		if (error)
 			return error;
 
-		group = i2c_smbus_read_byte_data(data->client,
-						  MMS152_COMPAT_GROUP);
+		group = i2c_smbus_read_byte_data(data->client, MMS152_COMPAT_GROUP);
 		if (group < 0)
 			return group;
 
@@ -371,14 +370,14 @@ static int mms114_setup_regs(struct mms114_data *data)
 
 	if (data->contact_threshold) {
 		error = mms114_write_reg(data, MMS114_CONTACT_THRESHOLD,
-				data->contact_threshold);
+					 data->contact_threshold);
 		if (error < 0)
 			return error;
 	}
 
 	if (data->moving_threshold) {
 		error = mms114_write_reg(data, MMS114_MOVING_THRESHOLD,
-				data->moving_threshold);
+					 data->moving_threshold);
 		if (error < 0)
 			return error;
 	}
@@ -464,9 +463,9 @@ static int mms114_parse_legacy_bindings(struct mms114_data *data)
 	}
 
 	device_property_read_u32(dev, "contact-threshold",
-				&data->contact_threshold);
+				 &data->contact_threshold);
 	device_property_read_u32(dev, "moving-threshold",
-				&data->moving_threshold);
+				 &data->moving_threshold);
 
 	if (device_property_read_bool(dev, "x-invert"))
 		props->invert_x = true;
@@ -519,7 +518,7 @@ static int mms114_probe(struct i2c_client *client)
 		return data->num_keycodes;
 	} else if (data->num_keycodes > MMS114_MAX_TOUCHKEYS) {
 		dev_warn(&client->dev,
-			"Found %d linux,keycodes but max is %d, ignoring the rest\n",
+			 "Found %d linux,keycodes but max is %d, ignoring the rest\n",
 			 data->num_keycodes, MMS114_MAX_TOUCHKEYS);
 		data->num_keycodes = MMS114_MAX_TOUCHKEYS;
 	}
-- 
2.54.0.1136.gdb2ca164c4-goog

