Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B46E1B6D08
	for <linux-input@vger.kernel.org>; Sun, 22 Feb 2026 00:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771720652; cv=none; b=FO43qvLKRNm4hYNQ1nGwuPr0xSwe19tl7Et0P8JLl9+GMqcOzHU1c1WI0VGTF9CzeRnysd5v95fYvSrJgn+R24D1p+9c4AcPYI3o5QGajfj3N80UKBTZddmw6wb6MvwK/y6GZRPQl9+bKe/zQQOXNoCOz9ox1BJDsG+5p8ci9uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771720652; c=relaxed/simple;
	bh=79Tv9tRoMEQ8y2QqVKokbi5C0O0eIUWbIEJdGGLSgh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMk5QcZttPukx7JiwLKQbqrPdZlFADKfOBQ3T7c8dHm5PFONf0IPKDWJQG1HGeA7+aWLgT8FiaQO6Gk24WQUAnLzsGRgO2Q5m9TWzC2ZaC8uEQgHEFPOH16sWhUqv2uG/StClOpuP+y/X4aMFsM0PI8IXwXx7rpBmScvBqfdAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gC9YrZHW; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gC9YrZHW"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1273349c56bso3898045c88.0
        for <linux-input@vger.kernel.org>; Sat, 21 Feb 2026 16:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771720649; x=1772325449; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F2zPNTCZUxKLns6t4TdoBG+3JsE9yOyBYeDgC9tcG8I=;
        b=gC9YrZHWj/T/esAtwejv6HRbZAMu+Y6naO3ANcnfMlp5miUVLOX137X8wNjwbQ5/Ol
         EV985jAcUaqi7pgDHsfXwyRdMfmSh85svG9kCoMIzVS8UMoUx3E6nVmi2coBVK5fR/yI
         T50hPxpjlpSm5wzMOy5nTjxe+83leNFUNBUnKUoUmnxGEQ9Kf3qFNU7b1sAwGB0HyoMV
         ozj2Lcv2DMZbtZteOiQziEosXiCKnmqPFwB7wEpP+DTP1zwe38xJRirzx9L7CjG8Wbr0
         H1siSdJZux/ju/LvcklQjuSV9YBBfYgkVFkLhdlJmZuVayWrVjdS+0UlKzVFal20xoPu
         wAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771720649; x=1772325449;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F2zPNTCZUxKLns6t4TdoBG+3JsE9yOyBYeDgC9tcG8I=;
        b=rE38HkLur60+3Mh5xTvwi7UKtUxAO4Prj5hI0nn688lQflIUgG6fZ8ScdS/Cqj+H6z
         47GsM+d7zbMX6B/DNTX48aZxGxBAUVHVCzGPEEvdy212GldiPwPxN4zI4SHydJRVJmld
         e+AIXSeTEnABhb9eyeKwsYVDpCZVeAy0t7FrLSAjXPFVf2rWe+hUHL/QJsii+GYLPoOb
         Ry/isplmOkPWB5t8ZhPkrV5t8IAezJgUwp2qI72HdI7QStCi+8l95Q9LBQtu3Hm6pKk9
         73isEWZJTXoaGH8o7DCsZE71O/isbs312vA/LdVHzfcrZxvsW2z5heozfl6H0xIS0UkS
         kMgA==
X-Forwarded-Encrypted: i=1; AJvYcCU+aVfdPTqEvVrH0AuiDjHViA4ZnmIacC1XQgNzr//fLJmCJeYa0Va4ZZiMfsJ5M4CQJbbCnXmNWnkofA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyour6HtCbx10r+BqGRE6zLl6Mw8KeSYSsd8hiVtbJVSn8+ZoC+
	tyZYzkpB9u5MpcDraTQZE7pVKOKM9l/Tq2iykavD52LATm1mGqozsU20
X-Gm-Gg: AZuq6aIhAxZN+dX6dRHJw1s+CinL/LKX5YWxORssbY6OOFrxqrVkBJ0SJ6ssaNXQaTF
	+D5NgjyTlayltUjldnMasMEZhjcVTwbKs7KofswhelbanUL28y6TQjEO2UMuTRb66sn8JV30DrF
	Fx03gGDMqW80yFsVW61Fibt21/Guk25iCgBz61MjOdBpIcA2thrXqhqolF5aDRBB1+VPvvCPUHd
	iBHc0xy5naNRamisFX6BwKb0bgcWIAk552NwEsmO6y1z1irlXGIWFep+RnNIFEcYJ4Kms7zzirq
	wkAjqFU0IKKfr3dlN/gd8uqzBA9fQ9BDy4TzugNg1vGAiVL4NM91xd4u06O/6VHVJxlzMCqpbfO
	/wL5f04HQvV4QL6ErrPEpAqCKfru4ndYJIUUxwq02oZR+nRqd0yZP3EOAFJLEsJWnBNCJZmVXeL
	3F6oICcdL3oawWtXLs5B5AJPRecYblzmlOERs/iG4c9bcCp0lUks0/h3htp71ooHvPnQAwQgtuz
	yZoIBg+SrsFbZdQCkFjikBl
X-Received: by 2002:a05:7022:4182:b0:11b:d561:bc16 with SMTP id a92af1059eb24-1276ad18725mr1911089c88.22.1771720649210;
        Sat, 21 Feb 2026 16:37:29 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:73d:b075:516c:4a69])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dc167d3sm2383191eec.24.2026.02.21.16.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 16:37:28 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Fabio Baltieri <fabiobaltieri@chromium.org>,
	Benson Leung <bleung@chromium.org>
Cc: Guenter Roeck <groeck@chromium.org>,
	Simon Glass <sjg@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	linux-input@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] Input: cros_ec_keyb - do not allocate keyboard state separately
Date: Sat, 21 Feb 2026 16:37:14 -0800
Message-ID: <20260222003717.471977-6-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.53.0.345.g96ddfc5eaa-goog
In-Reply-To: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
References: <20260222003717.471977-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we know the upper bound for the number of columnts, and know
that it is pretty small, there is no point in allocating it separately.
We are wasting more memory tracking the allocations.

Embed valid_keys and old_kb_state directly into cros_ec_keyb structure.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/cros_ec_keyb.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
index 1b4ee30e1998..02176aee0530 100644
--- a/drivers/input/keyboard/cros_ec_keyb.c
+++ b/drivers/input/keyboard/cros_ec_keyb.c
@@ -59,8 +59,8 @@ struct cros_ec_keyb {
 	unsigned int cols;
 	int row_shift;
 	bool ghost_filter;
-	u8 *valid_keys;
-	u8 *old_kb_state;
+	u8 valid_keys[CROS_EC_KEYBOARD_COLS_MAX];
+	u8 old_kb_state[CROS_EC_KEYBOARD_COLS_MAX];
 
 	struct device *dev;
 	struct cros_ec_device *ec;
@@ -750,14 +750,6 @@ static int cros_ec_keyb_register_matrix(struct cros_ec_keyb *ckdev)
 		return -EINVAL;
 	}
 
-	ckdev->valid_keys = devm_kzalloc(dev, ckdev->cols, GFP_KERNEL);
-	if (!ckdev->valid_keys)
-		return -ENOMEM;
-
-	ckdev->old_kb_state = devm_kzalloc(dev, ckdev->cols, GFP_KERNEL);
-	if (!ckdev->old_kb_state)
-		return -ENOMEM;
-
 	/*
 	 * We call the keyboard matrix 'input0'. Allocate phys before input
 	 * dev, to ensure correct tear-down ordering.
-- 
2.53.0.345.g96ddfc5eaa-goog

