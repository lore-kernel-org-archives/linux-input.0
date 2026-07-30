Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EBF421EF8
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418832; cv=none; b=QwCDNZ/m0ivus5L51YInbFkahwwGLRHr9fBvdI4aZanfxFLkUzyXtZOMBHMqL1rcWVzAtMxY8TXo8luRAud38wP0sqBFEFgFlYgFAkZ7j0XgBRdp2I2+33y4DTyUOxPHSox+NJ5rwkDeIoR5IlITj7fUh5eHhMfHvxFs6QcINLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418832; c=relaxed/simple;
	bh=U6QB4MnHdBIHYeizwxxukTDFw4uQE3ezii4oQvWyL/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iFDcaoTuAnK3taAIwJnBq5GemrcNnH3zvRi21kUBOH+iYy2FaWC786BzL7x+NMog2pYXMXG/5uzgkb2V47DL1oPOOA3kqSbu6mkbZZN72bryuYV4krMGRMRvqP2laBaX2nTvbeoJynQJPkDR77XRmLXSFLsdcRF6xBUR5E+pmHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjVdyoC/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjVdyoC/"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-49545ba3d4eso9637395e9.3
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785418830; x=1786023630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K4/IxvVyXaXnWBb9xawSOoIIvBUnkDkziVXhjgbdIiU=;
        b=UjVdyoC/zdcYYeV9c5QMwRxyR704HmRe/8A3KddTbJYzhOp7vho8WXePHE34V21xTL
         hpU/kXO1flQRNMKhz+CeyxgaZ3yaQEWXAXLyEMUgvGW+T9Gz2h4FQUw8TPsNxMgP6/7s
         Xtg6K1mU4Xx6WCeaf3x41RKfV7fIDF6L5KslTuCCl43/IYCAs4nI8M/2tYO09M0Sd98g
         KEX2nObxex9vDfvVlDF1RpTVzBAOb/ADw8wr4R9WjDzLZS1PZe7m2tMNQ0Vy3h2DIk09
         QPTamNyqTS41LlRsqFf2H1IeVFHQ4gaOl9N7LyGEujFn4nzjt9HpsIQEP3Nvygs9yqOB
         +QVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785418830; x=1786023630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K4/IxvVyXaXnWBb9xawSOoIIvBUnkDkziVXhjgbdIiU=;
        b=RHAVAyyo4AKkFteAXXEoimcMaIHkqHgG4h1eqj32a7MGDJ39oOYjMLT27FWeerXs1j
         TYtB1qeTtserHDFZ9xDcmpSq3oQYsHDC30LrGxULO/tDWoO/pP7RHRy7SM3P/8wNj8Zj
         t4XHBGlvCjQoBLceBt7+Br991+U6sJJLYf6QXm2ME3WIW4t6zXZMJ5Rbk1mKNO+a0yTf
         4PPs++bcZk4IoZStC+hL0gWVAInhCbO3/B7Qg/xnVXl8Cx7R8oDfOl+X/B1iGK6zmoUu
         /lTctrW4MaXvvtT5p4TI+XIKwScyTWieD/J7nbUL09s5OuFcfQ8GSftrxFz9JoQ82wDM
         Br1A==
X-Gm-Message-State: AOJu0Yxswg707f4h3AZaBHAERUX5reaZcrR6PCdbrXwf7Tv7c13hY/+W
	TfXXwTffajS+qRfDOoWEcH1RX5hqETMMsLdRIn/aqKhv4wF0BGBRyrll
X-Gm-Gg: AR+sD12HN4PQHwAYoTvpoOyOi6u38pPgtUSd6SOb5oktRpkVAyYCILIyBOEorP/P5iM
	MxNUvFHDUUW+L3C5WSFGrPVszNy8a+SUNL1ApJUMNrRGiZEZBMEVYm+R2pdYWbziFQmVUA/b81Z
	LWTblZx4108PgoqyaMpaVO73zJi/A/MW52MRKwRszELTRmO4UX+hnZdcL0MsMqVQDhXjutPdvWE
	yyGDE6UaVg5TxOUAFr9OiCFponPU78i+qWWNjC8ZSaYLOSYEpjJpKxuBSAych3OweqQYuUbKv1w
	MjOBVru7fBr/5CeIIDq7AnjoHfgHX8klDgygOgGi9b8XGB5xGJDNV7CBHnB1ejNnZdYpQQiojGY
	lRfENGKWPu0u2SbDgjpNYkEHULsIX9HZSyCuIqyzknAjmws98JgwZp2ifDdK+/gpPxtZS93SY3H
	R68/mvYiMt05b0jN5TKRO/pQkxkzBfREiisAsxj1SXNr+6+Y46j9vWqRf3txJYKdwJDBdvE9c/D
	zXJ4/lMFTy8Y5iMgn3r
X-Received: by 2002:a05:600c:4ecd:b0:493:c10c:22f0 with SMTP id 5b1f17b1804b1-49804c531c5mr6353345e9.20.1785418829509;
        Thu, 30 Jul 2026 06:40:29 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-498012168e7sm66405305e9.15.2026.07.30.06.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 06:40:28 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH v2 2/4] input: ff-memless: Handle FF_TRIGGER_RUMBLE
Date: Thu, 30 Jul 2026 15:40:02 +0200
Message-ID: <20260730134004.1118476-3-guillaume.casal.42@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
References: <20260730095317.767418-1-guillaume.casal.42@gmail.com>
 <20260730134004.1118476-1-guillaume.casal.42@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Combine trigger rumble effects the way the other types are combined, so
that drivers using input_ff_create_memless() receive them.

Because ml_get_combo_effect() groups playing effects by type, a trigger
rumble effect forms its own combo and reaches the driver in its own
play_effect() call, leaving FF_RUMBLE untouched. An effect that has
finished still contributes its type to the combo with zero magnitudes,
so the existing stop path works unchanged.

Signed-off-by: Guillaume Casal <guillaume.casal.42@gmail.com>
---
diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -289,6 +289,15 @@
 			min(weak + effect->u.rumble.weak_magnitude, 0xffffU);
 		break;
 
+	case FF_TRIGGER_RUMBLE:
+		effect->u.trigger_rumble.left_magnitude =
+			min((u32)new->u.trigger_rumble.left_magnitude * gain / 0xffff +
+			    effect->u.trigger_rumble.left_magnitude, 0xffffU);
+		effect->u.trigger_rumble.right_magnitude =
+			min((u32)new->u.trigger_rumble.right_magnitude * gain / 0xffff +
+			    effect->u.trigger_rumble.right_magnitude, 0xffffU);
+		break;
+
 	case FF_PERIODIC:
 		i = apply_envelope(state, abs(new->u.periodic.magnitude),
 				   &new->u.periodic.envelope);
