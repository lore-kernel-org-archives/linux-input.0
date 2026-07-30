Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A221440BCB2
	for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 09:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405264; cv=none; b=RmbVbT7ioGIqqwgE5hgKgGQMKVVs/BUn2Vg3xhzqhzqMS0jxCH8uYO8FSxFMDySWkr4lV682lVR8+IMDV+PnZWk3V1cydJygmC2AktFf6Smaov69QUsekgGnsI8dHYiQEBmkRC8DaWQH0uupD0lhnkqtpCMlRoZVKUP0tvBHI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405264; c=relaxed/simple;
	bh=t7VOJCb/L4PJvS+40deXgNJ2DlBYK9GoZnNl6BXFWmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLvaavGplIhVm63G3Gjsaf4XsHlF5m36HZRgdao/ilqQVU8JqyMlqia1z+RHRC2/xiVJbMeaOeJfyDm1vU6JGLI0YHbdcNx+JW6FAW3k6t0kQrrixVUlQRgryKrZ+D5FbgYA7jQ/A0/ESD4ogRuccBLCIHh3jvQ0QbnvZqUF/0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9ikov/W; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9ikov/W"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1627128f8f.1
        for <linux-input@vger.kernel.org>; Thu, 30 Jul 2026 02:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785405261; x=1786010061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u6aaGhbINYf5d9TXocydF5rdjIZpDYkHNwB+gKs1vBs=;
        b=q9ikov/WNlZS3E4nW9ms6EBN8oRNthyGcEBVKarMsZF4+kg1P7PmMT3jaEggpjwdD6
         r3o9xHXN0rCDWFLZqWe8wIdnVCV5IV2TDZ5noE4rAhedpvZz1thb6ayJJrIS8fITD+aq
         PPZSkWQ+QK9xfmFmRhoE1KON434A8KPrgO6vKHoZyVLDK+xvSukgZV3XjxpIzHKYLFOi
         Wxu3GB7dJKiAmv8kS2LD/elr+VC4RU7C3UMIiSm7M06B5LX3W6zXsqaoglc7SL9OYNkv
         7FfnZFSlmLtMtm3hw1mJ01tM9xeGo14JnAYy8v/0v0QQCCacRdnNTqwlsX+c8fBKNMf/
         Q2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785405261; x=1786010061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u6aaGhbINYf5d9TXocydF5rdjIZpDYkHNwB+gKs1vBs=;
        b=nsdW2UqV/piUGJXeRSZ0nxDQ5ZLYl/FdTqhcPi9wd+hNAV41a4iEO8o4DsP29thk37
         LlaQq+ngxRx9hHUgWbSNEuRcMvNg6wBtqhO0BOr3ofJq5qgvBMqNIQqOi3Zn7OrXtlgd
         Mts80lAx6xLfimAgdmbREnFQnDf0Xx5AAATJdaZW19rVOU92Z6RmJNt1gsraJBq/Xvmb
         KoBfuWBpGw+8hiXtAQbGB6m5AIymm8t+0ujJK0ccnyYBVV3AMawIfhSAYEqVgYXI+0Y1
         s+5dJ6NkKWyis4y+1VTlH57kQq+8m6CwoP+h0nXJZLlT/54lOUAtvBt74k/b4dqdjyVS
         anbw==
X-Gm-Message-State: AOJu0YzDDZymBNUhZrzWl1esG+0U05CZaKceNkJMzGn6x2+5nt6vnxzq
	aqpYsMISiLB+7HfaB4Q6Vj3yie8ABTHiTu/d+MLycGX76qjPimnLxL/f
X-Gm-Gg: AR+sD10gICGcKPqdWilyMptW0xYvyhM6g0lEmUfIPdIFJEcSoj04SJGSCJ+TR08ikgX
	RTZySz5WrKDiT+zcGpkv70d4oBOTihmrgV8fTiezl7jeFKtpAPa6yAFoSrfahCQj16W8kSRxt9D
	OvoG0m+kgepePk4jpBg4oUDv4AVkeGZhNdHqwUJm9Kn/aqO5Icyzg6pnsf98Cnj3DJzG2YBFZRB
	ZGuKM9LLydlfFErmaxl2wJ6muVfCv3oq5qTa5xsPajlGw33Us8ZQ1tsV0ufY6bm+mC2nvzq9FUV
	vvWNxV54SaN5IIyqw3m2cLQ1uXfTcLTpBjrC5/8yn/JdyXXg3wBC4qKjhAmutbn+fU0jrepEZMd
	E3bXivOk30Q9JdXYsPC2rjCcxLbNyZysXtMMpoH+A/6zcxSBVCcJVjLkttkKa0E96eeF1YLIJ+L
	Pe8DDnLysxz0Cl50+1NioRuHY+LEiQvxyQynrUM3mKeBjXoCF2/NV3yt8KvcfsDh67HVQZx70f+
	d6cuE3s3/h4+81e7Y2I
X-Received: by 2002:a05:6000:2c12:b0:47f:7005:2893 with SMTP id ffacd0b85a97d-47fc821ab12mr2765286f8f.58.1785405260792;
        Thu, 30 Jul 2026 02:54:20 -0700 (PDT)
Received: from mortifia-tour.localdomain ([2a01:cb11:e0e:6900:846:ff2d:816e:3783])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc8934ba3sm4317500f8f.27.2026.07.30.02.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 02:54:20 -0700 (PDT)
From: Guillaume Casal <guillaume.casal.42@gmail.com>
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dbdaniel42@gmail.com
Subject: [PATCH 3/3] input: Add FF_TRIGGER_RUMBLE capability bit
Date: Thu, 30 Jul 2026 11:53:17 +0200
Message-ID: <20260730095317.767418-4-guillaume.casal.42@gmail.com>
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

The preceding patches let userspace ask for rumble in the motors located
under the triggers, but give it no way to find out whether the device has
such motors at all. Without that, an application can only set the new
magnitudes and hope, and it cannot tell a device that ignores them from
one that has no trigger motors.

Add FF_TRIGGER_RUMBLE as a capability bit. Drivers that fill in the
trigger magnitudes advertise it with

	input_set_capability(dev, EV_FF, FF_TRIGGER_RUMBLE);

and userspace tests for it in the EVIOCGBIT(EV_FF) bitmap, exactly as it
already tests for FF_RUMBLE.

It is deliberately not an effect type. The magnitudes keep travelling
inside struct ff_rumble_effect and FF_RUMBLE remains the transport, so
FF_EFFECT_MIN and FF_EFFECT_MAX are untouched. Placing it at 0x62, above
FF_AUTOCENTER, keeps it out of the effect id space whose upper bound
FF_MAX_EFFECTS already documents. Unlike its neighbours FF_GAIN and
FF_AUTOCENTER it is read-only: it reports what the hardware has rather
than something userspace sets, and it is never used as an effect id.

Signed-off-by: Guillaume Casal <guillaume.casal.42@gmail.com>
---
diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
--- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -528,6 +528,7 @@
 
 #define FF_GAIN		0x60
 #define FF_AUTOCENTER	0x61
+#define FF_TRIGGER_RUMBLE	0x62
 
 /*
  * ff->playback(effect_id = FF_GAIN) is the first effect_id to
