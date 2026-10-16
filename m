Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FA137AA78
	for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792168448; cv=none; b=e/2NkZOH1TKfQllvZeftpR4P00rpoS22CmcwXCdesvGTDKbLfQXkL3PcwQ/WZq5ruK7PkikfElSzv/xzbHuyNRtWUU6Bz9dwtFQtSMEQbQeO7OUI1PGusfuKv3okaid5Rekp/h+FN77EBAdksWPTEeo2a2ba8u0QVRCIeoaEylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792168448; c=relaxed/simple;
	bh=qiRAXZkRJEXPmqs8IIFVKCH0Z9Kb5ltx/zf1mIOnkpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NX7PA92IY3hQrGV6GYv4KknoakF/jS/68DX8gHxpVq0NO/X/R8AbssDmNpne1JUAdnGghjiTSP2T7Qvyxvf17tflzFpT4HHAi/eMirZ7JfC5zTCodAVWHglMqXMvgWTkViSpOpC8JeoSpxFgpod5KqDJlmctm/5C1ljnsXpGWm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMryacOp; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMryacOp"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93e63ee7b4cso12514585a.2
        for <linux-input@vger.kernel.org>; Fri, 16 Oct 2026 09:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792168445; x=1792773245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hHrZ44E7mwbp2nfJxIBL5668mhyMNf3IrRHINSdc80I=;
        b=gMryacOp8OWOdnsjDfFoTn8t8hmkzwqNlobI0iYqM7L86wd8LtgLd9xDswuqApgHiT
         OqJ8mcsHshjwy9LbrNuu/JYC4K3SMkLY7RLcJmkt7pcRAs9oyMVGyVKibvaB7pTl4eS9
         oznDAaLfB9LHGYgVA9IxXyuA/Eq15F1kxhnZppNHTMY6/pLRPlKMw2409G6mWEjhVCzK
         khyy94UVbgzDUjAY4sjwefWJLpfQARWUWPat0aYwAc1G+jitJAUk8Mk8x+Fw6VHr9Q2f
         yFMA4jyA3rNdbP3+l+B2Nh5HQAjSPmRZ+kH6N8GnPlsiWeYtVM92Ma1ywOriLhcsGmOC
         /r5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792168445; x=1792773245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hHrZ44E7mwbp2nfJxIBL5668mhyMNf3IrRHINSdc80I=;
        b=Ad+PZjQjNGV2lv6eSLtGfnoecgVu2JsWBmAVxhKNbormDs7xGvVrERkAaJSv6XnBeC
         TXCUvMwwm/rVpSqyWsY8DIzEGFLtoS05mffkmlcuTaHG7KBDyiMitG4cJPJiMUXxXQ1f
         R3dcaOAFiLq9mUTt1OAnX9DW57sNuXYj6rc+51CN5aBUtDV98QoEaLqkuOUvo+Y9pAZE
         Kip95BM0hfUEnHswYcZikO3QahcF0STbkxDRAWL5GKYV0lhZMJs+jHVYyloNz0MQfGYz
         XGipRu4MmjodYWtZCOMVD7JMWJUzt7xz8Rj/nQcS5mHRbM8N7ZVNTkPwqIgI1a8TJdCA
         b3Mg==
X-Forwarded-Encrypted: i=1; AKwUvBzH/rWy+69Uo5ANyXp8EHyBFAmi7QNctNVNN8zZivM/WoC9KFH1koC3xaqorA4VpYiwXso3WpAeZ39ZzA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLu+VEnyYSl7eV1OZgbUnGO18Hyf7GSsqojffC9A8kzyX7bcJ8f
	z3q11pzZOX58EhglhPHsjrcDbRw6H6WsSdvM7d/0w2tjRMiLcm3dJ7IIe40LSp3tUu8=
X-Gm-Gg: AYBFou2uIjLDJPUPyliIG1U3nnAITKE9id+xVqoFW/olE+k+F/13Y0U51Ng+EZPZvZX
	oYEsLYpaKJAGNTr1rQqz9OXUwmY/C3kBkOQog/2wAVAqARpOnSPjOnKONpI7g0CtBdQUx/0Kf/x
	c216gKiSd6BB/Dbg/6wH/RhZUXiTzlkAS858yxDBeDoqH92ac4W4QFk6YpD2xEgfSINIbFJmCdT
	7jFrrumYLwc+Uf6ePEgpBXU03+/rgwF2XAQtOTeN/ge7uPc3cov3o9u0NnhMknS8kO3rx5p3e6i
	y/wqch/WFuccrCUtjGewV3AerW8Xu5jPk1gzRsZhS//0Imlr6RPyTPW3+sabv9tmMR2gMZ4wbtT
	ZAEe/X/D0wHoUH3wZg8c77CVUkDKGKQeRzJxOCLhxr3E/Rb9ZbksJnm9xGKd8lKR+B6rwRLYpnk
	IKrcoraBojQEZUCcJMoHIoAnTSUrxCMZjMlXDq1ehuz0zOxwc7pGDHPQ3gcem/F6A=
X-Received: by 2002:a05:620a:439b:b0:939:4a44:5f99 with SMTP id af79cd13be357-93f29b7eac0mr63046685a.10.1792168444661;
        Fri, 16 Oct 2026 09:34:04 -0700 (PDT)
Received: from beelink ([187.15.139.183])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcc47bccasm25272806d6.20.2026.10.16.09.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 09:34:04 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v7 0/2] HID: multitouch: fix use-after-free of haptic data on delayed input release
Date: Fri, 16 Oct 2026 13:33:47 -0300
Message-ID: <20261016163349.3293666-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016151343.3120300-1-qwe.aldo@gmail.com>
References: <20261016151343.3120300-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v7 fixes issues found by Sashiko on v5 and v6.

Patch 1 now moves input_set_capability(EV_FF) after input_ff_create()
so the capability is not advertised when FF setup fails -- the caller
masks the error and EVIOCGEFFECTS would deref a NULL dev->ff.

Patch 2 keeps the devm_add_action() design.  Changes since v5:
  - module_put in hid_haptic_destroy (not devm_release) so the module
    stays loaded until FF is done; __module_get for devm_release itself
  - guard against double-init (return 0 when haptic->wq is set)
  - NULL haptic->hdev and haptic->input_dev after put in devm_release
  - restore dev->flush/event on devm_add_action failure

v6: https://lore.kernel.org/linux-input/20261016151343.3120300-1-qwe.aldo@gmail.com/
v5: https://lore.kernel.org/linux-input/20261016135516.2957381-1-qwe.aldo@gmail.com/
v4: https://lore.kernel.org/linux-input/20261009103333.2476105-1-qwe.aldo@gmail.com/
v1: https://lore.kernel.org/linux-input/20261009031207.3233206-1-qwe.aldo@gmail.com/

Aldo Ariel Panzardo (2):
  HID: haptic: reorder try_module_get/get_device before input_ff_create
  HID: multitouch: fix use-after-free of haptic data on delayed input
    release

 drivers/hid/hid-haptic.c | 105 +++++++++++++++++++++++++++++++++------
 1 file changed, 79 insertions(+), 26 deletions(-)

--
2.53.0
