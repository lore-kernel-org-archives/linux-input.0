Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2044140A93D
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 09:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405261; cv=none; b=pkh+Bm6ytxq5XnQeFPkb+oVXKjo3gG/weF0NHahZrf0cal93pRZzO1ZD1uF3gjg9ZFG1DqyRt4DPRpost9upp4HuB4JwVEtUGGsnByjJ5CLh/n5vG2k1J+FU97gOVmaZYMTTumMaZe1YW0Lcm+u77UE5qXaXvIZeT36pdTQ93cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405261; c=relaxed/simple;
	bh=+1kG1LOgrdyUm3Ugd5qlvXICJ++Du9lkw4y4hiXGGwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fO5JAwNCqUggFDUB2lXjHHvZTl9/mGfn4uXfvZgCTaiVs82HKtTBYHxw/wAudb5XJnYYUqNM5D924eqIZXlM/S/GTMCprUKiZf5zlXc/y4iJ8vN9ITOOCYt/1DZWnMr9QEUJZKDOAbblUvnWrbXydxGYwlQy5JXPXt4Axr8Su5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxeFaABh; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxeFaABh"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-476a130c138so2037717f8f.0
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 02:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785405258; x=1786010058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j8LCb1Sw8DxNmSI9/f1r7jjKG7eFOKs76XqcIrSrmfM=;
        b=OxeFaABhQG/lVWhu+Lvu9qTb8TjCmlDDQHE/pANGUUzbv4imTHom80PSr1HksVqURu
         cf81gQNaZKV/mOkMqr+c3dll9ii6NflUbMniRFNCjpiEioJ906yxw1mjyg8fO1yPMDS6
         LOqFIjhV9MXsd/ai638g2+SF9sj+PqqKrGbWgBEqzfC8Ky3IyMZPu06FGjMs+Vfh5OGJ
         xN7EyBdQR1p3ZH+FMcmXJFfJmyOvo922e98wV0DBQwvBDQwGPZT2MvfjsSPOV94sI5b3
         0X8+vJEbAYEF0z53OWelikCdhr2AvKvRlp8eHUDy8yJwGdN/vvf8SYyI2fGdNqhJZ8TU
         4vng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405258; x=1786010058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j8LCb1Sw8DxNmSI9/f1r7jjKG7eFOKs76XqcIrSrmfM=;
        b=PbOYPH1ZvpxgcjbVTQCK317Wuxi/rIypb7/cGGiS9W0GVjafaQ5q9U52IXRMy//d4p
         cIjSppr9oDqE00b0en2zWv49Ql7ZywZwaPEsVGx5d9l1uHyKkejZBxGf7fY+YJbH2T8o
         Su8wGNvt3IQC8BtRfg46VS6lXJVrz+lHPF2wYSQ71j9M41+8PU0KzLF0zFKp4At3EcrZ
         SjhzgwDqMrHfflsH14C5JFHuS8JDpzYuFhXyuo5mOky505LG/VVBrBKPgxdMVxLPHswI
         yjHb18tvpdDmp1OtiJd/YtFo9gAtV0lKnXAKOm6TS4hzipXIRNpZw7mhJzGlvO+YPVnU
         w/6A==
X-Gm-Message-State: AOJu0YzfIhsgJNKcRknYb2NdjDlj1IEqmYtc4vUhhybrXyKdg7opIURc
	JDI1F6PnT949RZtiWJ0L5vDBuG2G3o35JoMuHBCXTtFedhWb4dQ59efu
X-Gm-Gg: AR+sD11b3sA6PFs1gcDWdQzug0LVCv1DOBj6606+EFscq8DTA3CXyKPznBAqTIsV3Oz
	V7Y4eTvCjvT1xCM02PfzjmrDPGFbWIX+S39wxEmumu3qRiKoQObFlqmgQdP+nFRSJ0LaiDJP2D8
	1ZEuwXcW7gB/r6lgR5c+XsMyVqs5JapT/7ycze03nV4p3gpnuy7nrIPhciSD+9B251aH7DDX48L
	FL8geMHoMIsbgqYZyZlK+x0u4pLyJbC8nX/Rkccktcr/G3pWAFDP1mTofrqgVieBS0rpwgQbjny
	WXrpUeQFSW8oyV69lgpvMBoN48Yc4h0IH8J1yi+fqioSVX7ThO0YIQEDJgkBhB4IExaVyGGpGDU
	2l/kRph73B+AhrquXtBWdR5rIqFgs4po0OeyD3tIUEEpmBr/CH1aOkLRmjvhIMMkBeZ+6SQ5oGz
	L4YIudIwj/PCy8ftT42zcBxISEipZyyV6LWEJNACrCUfPeyNL2q/2pDR+/ySGy8KqK9EgEy5npW
	4c3Ly8GEWJh4NnHV6e8wIb9SgDr/qch
X-Received: by 2002:a05:6000:2c0f:b0:47f:8b2c:3d20 with SMTP id ffacd0b85a97d-47fc82003e9mr2554601f8f.33.1785405258462;
        Thu, 30 Jul 2026 02:54:18 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc8934ba3sm4317500f8f.27.2026.07.30.02.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:54:17 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH 1/3] input: uapi: Add trigger_left and trigger_right to ff_rumble_effect struct
Date: Thu, 30 Jul 2026 11:53:15 +0200
Message-ID: <20260730095317.767418-2-guillaume.casal.42@gmail.com>
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

This adds two variables to control the trigger motors to the struct that
is passed in from userspace. This is ABI compatible because it does not
change the total size of the union that contains this struct: the union
is sized by struct ff_periodic_effect, which is larger.

Originally posted in 2022 and never merged:
https://lore.kernel.org/lkml/20220410220449.5071-1-dbdaniel42@gmail.com/

Rebased onto v7.2-rc5 with no functional change; the kernel-doc entries for
the two new members are the only addition.

Signed-off-by: Daniel Bomar <dbdaniel42@gmail.com>
Signed-off-by: Guillaume Casal <guillaume.casal.42@gmail.com>
---
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -420,6 +420,8 @@
  * struct ff_rumble_effect - defines parameters of a periodic force-feedback effect
  * @strong_magnitude: magnitude of the heavy motor
  * @weak_magnitude: magnitude of the light one
+ * @trigger_left: magnitude of the motor behind the left trigger
+ * @trigger_right: magnitude of the motor behind the right trigger
  *
  * Some rumble pads have two motors of different weight. Strong_magnitude
  * represents the magnitude of the vibration generated by the heavy one.
@@ -427,6 +429,8 @@
 struct ff_rumble_effect {
 	__u16 strong_magnitude;
 	__u16 weak_magnitude;
+	__u16 trigger_left;
+	__u16 trigger_right;
 };
 
 /**
