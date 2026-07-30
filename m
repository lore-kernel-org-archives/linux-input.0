Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840940B11B
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 09:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405263; cv=none; b=Po/YdAB/2WhuPMGbQfRxOe1NfeKjZcSVoR7V1v5KkKt3GjIsCEvVBjbPZwmwdzphYXnu2P/0C7eW61vQbGDHzK2HhC0WKGRpYfi+2+Ml75UmJF+25R1HrFoFTz9OcWR0ExMPQLJXGB+syhzY71h+IlajrwREn5qsT+5h/hvejNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405263; c=relaxed/simple;
	bh=y4tI16hHtdG3uKai+9eKoa3K7t1hNtd1v0mm0q4QKqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dLmZMjCEJ0s7RlKlqEjK0J99G/ruFO6UhvXJItIBwpON/iELy82Rt1ZcWPSbd9qfGWkRZn7nHiWKqqawlBuJl3T/82BcHa/tOJgWN21BYZg7pJHwVqVjyWbo+Z95qWNxTyVgjmkPgAoavl9XwDCEMOzwODyyeeQXn/ZfHbi6Fss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmDqPYlr; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmDqPYlr"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4955158f26aso12875835e9.3
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785405260; x=1786010060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gDtM8TIlU2j08SsqGLqgONB/QjOq5938O/GycKF1jtk=;
        b=NmDqPYlrPz+FUoq3MIUeZ1rtycZWxQ+cHc/89ZkxZjvfWPkt67nJaH/HCaEYfbDfS2
         H9iQqza13Uwg2QSnQQQ8tqJ9g5co4yaLRFfIMLsHLVmZ4HrVLRcDZChTedThCCjdg0td
         I2s7h41BswpVqQEt7OxhkITOQksi4jHlDN4ErUglwMqQm5UBim1IWDbnQ7aFhRlSdUL5
         lvmLPOc9CHHgMgAxEqhvoiCpD/yGGG1k/3Vac3XuT8bcx4tiNOKBga4ZJz8/mBHSTRBb
         uiPhWcRLo4biPmrUAiFqAEaNukvTE/EZ4YcMn5VOCD3//Hw47qU9sdSzTWnvF9gIrdYh
         3vMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405260; x=1786010060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gDtM8TIlU2j08SsqGLqgONB/QjOq5938O/GycKF1jtk=;
        b=df3GuitxfbsMP6SBNkWRXeUp65S4ixUJw1wt8eqF8viTNSBgk4iwcjum1EPve1UtX6
         qqGPWkKd/whl8Wv4XsX/dnYaEAcmUQNJTFII2HEPNAj5Zkay/sZfaLI2nQljNRC7/p8h
         Dpv3v3KtBoty1yFIBWVUIxMHusEcQiLNZHOZPMgNYGIszEtcL8xXzkYdw6HKfzEAexH2
         dmZLtD6vdchMn2L+XG92tigu69qwVuzo//aaINsjXnZYiNjPrRSrIjgggYG/Djto5ZAg
         DADhHvJUwzEZ7zSvoIfKUwFYu7bbVYpsxjMmW15VGHiJz9rFfSNoKhhEKHpk5TmlG+hf
         0/BA==
X-Gm-Message-State: AOJu0YyH8tlz700Gio/GdiKLqvlFAVQcoGm3ApLEFECrqKsgm2w2fqmM
	FmZIJGtucLhjg7ZzJWL0xkqjEU1mWoftdvmfaBHMDWXhMNIxg7cpty9Q
X-Gm-Gg: AR+sD11JwpLpqO3jTs7A2ogdmdMjH8lYSHtECPRoGUhp2sTnpjkJm+HDMulKZgColLH
	H5N4N8QRg//sW7FH3rcgJQHEKoqTRkRXL0/IdVltEZvi6c7wuoN7g+PWpS7eKnG4CvLLuJ/cplL
	y0z31V9/KVqREIo3YVarcA1rnr7y/9CnAiLrEwlHvcXYZPm9qKVFIIBb7ZjQTU6HiJMl9Quzi9i
	BJUhWGuq3LT7xjC3WdX/0Z7xg1nOe0y8uNVlkQhgFcIK+TvzuiYw5cmqpCW+2tLNj9qzCr10IOo
	yn9CmkUAyiN0alXSZCJry6V6JCTCP15bvLIFuL8tOqj4QV+7+gVmusOZHvYFAAvEVcjxdQDn7/j
	OErkiT71gEyxFTpcAA/tsGdAClptyuzdUBTRCOgeFYlT1SoNf5+2jaWVWs4TGh+gEy2BQnvUTbn
	OuPjWQQrcrkSmxW4KEBLixKq8YfTsUSRKqTF8299Gd9lf28PlERf+D0D53Kly3KJI5brYaxnWUB
	7g7jSj9Q+6qmf9UAa/+
X-Received: by 2002:a05:600c:1386:b0:496:df96:ea8 with SMTP id 5b1f17b1804b1-49800e816c9mr21481395e9.17.1785405259633;
        Thu, 30 Jul 2026 02:54:19 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc8934ba3sm4317500f8f.27.2026.07.30.02.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:54:18 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH 2/3] input: ff-memless: Add trigger left/right in ml_combine_effects
Date: Thu, 30 Jul 2026 11:53:16 +0200
Message-ID: <20260730095317.767418-3-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
References: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Bomar <dbdaniel42@gmail.com>

Combine the new trigger magnitudes alongside the existing strong and weak
magnitudes, so that drivers using input_ff_create_memless() receive them
the same way.

Originally posted in 2022 and never merged:
https://lore.kernel.org/lkml/20220410220449.5071-1-dbdaniel42@gmail.com/

Rebased onto v7.2-rc5 with no functional change.

Signed-off-by: Daniel Bomar <dbdaniel42@gmail.com>
Signed-off-by: Guillaume Casal <guillaume.casal.42@gmail.com>
---
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -243,7 +243,7 @@
 			       int gain)
 {
 	struct ff_effect *new = state->effect;
-	unsigned int strong, weak, i;
+	unsigned int strong, weak, trigger_left, trigger_right, i;
 	int x, y;
 	s16 level;
 
@@ -269,6 +269,8 @@
 	case FF_RUMBLE:
 		strong = (u32)new->u.rumble.strong_magnitude * gain / 0xffff;
 		weak = (u32)new->u.rumble.weak_magnitude * gain / 0xffff;
+		trigger_left = (u32)new->u.rumble.trigger_left * gain / 0xffff;
+		trigger_right = (u32)new->u.rumble.trigger_right * gain / 0xffff;
 
 		if (effect->u.rumble.strong_magnitude + strong)
 			effect->direction = ml_calculate_direction(
@@ -287,6 +289,10 @@
 			    0xffffU);
 		effect->u.rumble.weak_magnitude =
 			min(weak + effect->u.rumble.weak_magnitude, 0xffffU);
+		effect->u.rumble.trigger_left =
+			min(trigger_left + effect->u.rumble.trigger_left, 0xffffU);
+		effect->u.rumble.trigger_right =
+			min(trigger_right + effect->u.rumble.trigger_right, 0xffffU);
 		break;
 
 	case FF_PERIODIC:
