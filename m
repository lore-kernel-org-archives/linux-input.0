Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1359234B191
	for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770831268; cv=none; b=gzHSJrbIRfmmku1Lbz6IFqAVqsLu2mOqZxzQlAHoZGEBRkosOlwIXrcqbl+0aSNoBT92bozRcktL0TpRo5E6H74jaYGlwTXIxwgpWIMKgCT4GlQvUb2flaFzZop6GU0CE7vlUAgOjFQQeC3Mgq3BizQcCWGiQ+AsfZRVY55o7wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770831268; c=relaxed/simple;
	bh=B35W/wwKBO3Nf3zh7OtfXnLc3eCK7kEDavT8yq8z8ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JUHcTg10Uo7i5PuVj7K0D4+/anT2Zl1Dnu/HPKBD11bFkNGKBcfvfsHiZ8zSTqkmeAgaUTsF3HY9iPX4/r8oP/DNNpTmuWfkw/RkFjHDGazdCvYImnzuCb3u5ZgLxUmvph7BS4XOJxDzyPzon9jggcQSiT0sDLLkpdES4zphYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=k3yw4Rls; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k3yw4Rls"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-436356740e6so4902962f8f.2
        for <linux-input@vger.kernel.org>; Wed, 11 Feb 2026 09:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1770831265; x=1771436065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IXarn4uDm4FdMVdtkYEZm68FznhquSU537u2m3QOY98=;
        b=k3yw4RlsK4MH550+QxnKI3yhfiQmtj5k/uX2wdNGcdR+lk8NuU4JdeJh13eXMXU7SI
         zwjWrN9SIkHgQOXhYq4wHl7wYGNywbvYgrEgDXCVCF5Et14LoOj/b8RAtuSpEYSg+CAK
         nE3Ayx4pV6rXA+hXxweA6LmuvfWJoZAl0PT7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770831265; x=1771436065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IXarn4uDm4FdMVdtkYEZm68FznhquSU537u2m3QOY98=;
        b=Jk7IopzcGm0VW21abAS6TdiBkzRzvygBlA5Rx5BD4wBamEaVvOXBl2RTCbFMUNJgIQ
         ndiERY1qa7Ix5dmTeEdF2YlA3EBrh31A57Bqg0G0TN+IrDOxyX0gLQ2/WfpAEygzWZS6
         kO0Bs7bvLoVPAYw0TLRn2WOxIyktLN/96etPnO6nAVgrbatRoXO+p1mWwqoY9ai1Dpvw
         xDS6onOJTkyVbr/ueoF+k4cBFq9rAAIOe2d8mlUHX5PPw51EM4ETzAhXFwOpzi0L3QTf
         ZHhqGWS7Z7GwQo371zw6HzlpynNUpL4ZUnOFkK0Emd/5qOKdVnYduuV0gi8Xz0qtZDxS
         qn3A==
X-Forwarded-Encrypted: i=1; AJvYcCX3CzgRfdegZJDzWJazt3dIoRgDUBewzmQWvSNCrxZqaF1/Gwnq5KJrj76ge9LchpmkPogiV2a1tTsvhw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf7n8Cko3lb+VLSaXbowt4L4wELNjFf1DeHssu5MW6fZIKhBbZ
	JTRwbRZpfYenvtpiR53ojWtBg38an/zovS3YPV634/VyuQrpNscjTCWXKUzdMPAy1w==
X-Gm-Gg: AZuq6aIdNVGNTGy3HM9lizNLcnxJueGaabj7GVOyh5wGRS3OHVv8COA7VuDooe9NsIi
	JjHkBRhxq9AGLBXH0gmpqFfXP6xj5YaJDI0QQvNhPr9cXxVAVFRhCxUaPy1vp5ep0/QWTEZbxpx
	WoY6jG6HNM3Gjz2ha7bd+5uDN+8fYHWgcFKuLM13py0F3oe1kX43ryWMRcbQWwA1eCDi/78y5TR
	kRQPIPjkjmljdODxw3aZukSiJySYNZ/NBlfgYNZScIXq0fAkNZ/GZ0sqEaL6W2vFFbmkQiaTu4B
	R5UpE53uIl1BqhLMmrUpwOq7Nv8d+TAinN0UbA5uHUp3ZYofVxWJaS3fy4L8Ma7ugyoKzCHPnKS
	jkHT5Trs2+iFFCAjpXHlwmbbyQogJh0JvwkxE461hnrYKh4jgN6+hYUCRnqnRa3J7fjwmdXeEjO
	3EBU1U0q8CfibB3seJyZwKjFUaErU=
X-Received: by 2002:a05:6000:2c05:b0:435:e440:f518 with SMTP id ffacd0b85a97d-4378acb17dcmr384254f8f.54.1770831265487;
        Wed, 11 Feb 2026 09:34:25 -0800 (PST)
Received: from balto-ws ([37.228.206.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783d50f24sm5885498f8f.14.2026.02.11.09.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 09:34:25 -0800 (PST)
From: Fabio Baltieri <fabiobaltieri@chromium.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Simon Glass <sjg@chromium.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 1/2] Input: export input_default_setkeycode
Date: Wed, 11 Feb 2026 17:34:20 +0000
Message-ID: <20260211173421.1206478-2-fabiobaltieri@chromium.org>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To: <20260211173421.1206478-1-fabiobaltieri@chromium.org>
References: <20260211173421.1206478-1-fabiobaltieri@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Export input_default_setkeycode so that a driver can set a custom
setkeycode handler to do take some driver specific action but still call
the default handler at some point.

Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
---
 drivers/input/input.c | 9 ++++++---
 include/linux/input.h | 4 ++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index a500e1e276c2..d3a1878f25db 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -800,14 +800,16 @@ static int input_default_getkeycode(struct input_dev *dev,
 	return 0;
 }
 
-static int input_default_setkeycode(struct input_dev *dev,
-				    const struct input_keymap_entry *ke,
-				    unsigned int *old_keycode)
+int input_default_setkeycode(struct input_dev *dev,
+			     const struct input_keymap_entry *ke,
+			     unsigned int *old_keycode)
 {
 	unsigned int index;
 	int error;
 	int i;
 
+	lockdep_assert_held(&dev->event_lock);
+
 	if (!dev->keycodesize)
 		return -EINVAL;
 
@@ -861,6 +863,7 @@ static int input_default_setkeycode(struct input_dev *dev,
 	__set_bit(ke->keycode, dev->keybit);
 	return 0;
 }
+EXPORT_SYMBOL(input_default_setkeycode);
 
 /**
  * input_get_keycode - retrieve keycode currently mapped to a given scancode
diff --git a/include/linux/input.h b/include/linux/input.h
index 7d7cb0593a63..06ca62328db1 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -517,6 +517,10 @@ INPUT_GENERATE_ABS_ACCESSORS(res, resolution)
 int input_scancode_to_scalar(const struct input_keymap_entry *ke,
 			     unsigned int *scancode);
 
+int input_default_setkeycode(struct input_dev *dev,
+			     const struct input_keymap_entry *ke,
+			     unsigned int *old_keycode);
+
 int input_get_keycode(struct input_dev *dev, struct input_keymap_entry *ke);
 int input_set_keycode(struct input_dev *dev,
 		      const struct input_keymap_entry *ke);
-- 
2.53.0.239.g8d8fc8a987-goog

