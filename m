Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB82495527
	for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 22:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792361029; cv=none; b=FNzwc+P43j8TeV7FMNIuqAdt/M7ng7m685UQFO0BH6xpOeW1/OxeFTyZg4lTJf0R0b5IxkKHKHK0wQ8kEK9zC1Y45poTufmSebb2/JsYOmQOrFhZCFMU1b6A4BaZ47SXZ2Cd1meQXQp7TkZpZ6uuz3OX1TnYFEpjOO477Th6tSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792361029; c=relaxed/simple;
	bh=fLPb8kE775oBdl47IoHKogj9ZqIRFUWk55lG7MgAYNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohgzbrG+qL0rSFBskV7SropZnelGZRfgOaFPqdIQq2C8NiqkBBn+nzTQf5WO2uCuo4r4+5yToY0UWg9RvWGEVM2+ZJELMYUzlI9tFtJWYol/BN9zapn0de+tY/xbKqd5BjCMHXq4J7vl1fZOgdRoaD11bMFV+M2YKrCGy4x+lIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L6fcgFk4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L6fcgFk4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so3329825e9.1
        for <linux-input@vger.kernel.org>; Sun, 18 Oct 2026 15:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792361027; x=1792965827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f/Q05qxdTDTmhGuswkD33MZaClxV6rlgBVgFFN3G8GI=;
        b=L6fcgFk4wFCecUOMrMRbgJ327e++InffjP308Uf4fLiP+B/9TFmILR9ax9IONtOpOe
         uHSEX5CzSeta/XoYpw8qeBLbz4i2a6x0viIXZzIE8rEYhqmX7yL3rawazThIxJk1EET2
         TEQgZ8D9vQEbSTO3tHJsIBebtQa+7H1mx/RUzeYHFTAPmqpTKoAgOpEDeA/uSCUBG08v
         C1TgtrcVT6W4fzhb9He9KYA3J/dCNVfLxZ43aQpdQ0mEjCR7Skb3LtwKfz1bZjBwFKc6
         mlpZflnUEZog8dx0PpfQ8IRnoMfci+SgOp6TocWix+PupxT41PjRCe9blFmMgh6cV51X
         Fr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792361027; x=1792965827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f/Q05qxdTDTmhGuswkD33MZaClxV6rlgBVgFFN3G8GI=;
        b=QMAJPbPl/lm8BqfwEWZhcNeoalWyKl7RoqZO0qq3BiKifJf32CYNr/jrrEq88xDlZX
         1hwrOjCoYnpIZgF+AlDjOZ/Hiwlr7paJ0ePzzekyuYhiPH9oYQ8LwhuUTWYW/lsfXkWi
         8ptOfkDMzotqH8HwHbkYAMps1IttMN+j6H2b1smOpn/LFoZAeUpyOQlOEGIZLSyyhvdE
         mnJ8LL9acY1b2rYdav7/H8sqgF3E5kBVxPg0KIJeBpMNlR+51ruJnNyfCuWN30N4yfNq
         gGtv8U4t8pDpqoUzN9YpGFwgikuB4szbcdcUkO4mfcsysCgxCsJYrb7etFA1aosWaqg5
         3ckw==
X-Gm-Message-State: AFq9FYK1cnXBkaEVyxEGiLy+fD0WeMNIF5D/6Sslbzqh9TWRKohsP4hE
	nWARMTmK4ACuuAfpX+JNBBqppGqNTAl/cTqOun0Z6w7TKkTDBndISaQ=
X-Gm-Gg: AYBFou3PKFpN0U2Tt9xeKJ+YX7P/JEmSRJLdnikCVtDR59R+sbuiGBlzhlFt034eKPc
	oipdzTSHXhAGAcLJUgORzEweOrB5qyjzulB5DLBeilgVSR71+Bfd0rOkRoqz63K1oNR4d35pdXn
	aacwquU/D8U4j+ssJyM9c7wTNauL1pWHGgpux3goQa7L09/xCLAsvI3M8O3iec7pt+JBVl/Y8ql
	8WKMd45AaCa6ENypttUxBUDmjwc0P6fEzXukHy8JikSPnpROHI4h+6YohcxxgrosFVW0WeMwwVo
	+vs0d8jWywjux1jpB7P78od88/gyamcJB0SlB8+HsQPS0KhuXQ6D1D9B7XjNT0dyZu13M497j6w
	Ej6kNCGu00UTz2r0gHzOwzCdpuiyswV1w67SfMxT/7r4G3HZucsAL3MvDflZNCNc7/mrxgEJoXL
	2pI7QSBoB5Jx78oZDTNU4sFm/Oz+W7KuoOpbbribo=
X-Received: by 2002:a05:600c:1c0f:b0:4a1:e489:f89f with SMTP id 5b1f17b1804b1-4a1e489fa4bmr56224815e9.14.1792361026632;
        Sun, 18 Oct 2026 15:03:46 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm278731975e9.0.2026.10.18.15.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:03:45 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/8] HID: pxrc: validate report size in raw_event callback
Date: Sun, 18 Oct 2026 22:03:37 +0000
Message-ID: <20261018220344.1987142-2-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261018220344.1987142-1-tristmd@gmail.com>
References: <20261018220344.1987142-1-tristmd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

pxrc_raw_event() reads and writes data[1] and data[7] without
checking that the report buffer is large enough. A device sending a
short report could cause out-of-bounds memory access because
hid-core invokes raw_event before it validates the report length in
hid_report_raw_event().

Add a size check at the start of the function.

Fixes: acc3e34613da ("HID: Add driver for PhoenixRC Flight Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/hid/hid-pxrc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-pxrc.c b/drivers/hid/hid-pxrc.c
index 71fe0c06ddcdf..e3755d8b85c22 100644
--- a/drivers/hid/hid-pxrc.c
+++ b/drivers/hid/hid-pxrc.c
@@ -55,6 +55,9 @@ static int pxrc_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct pxrc_priv *priv = hid_get_drvdata(hdev);
 
+	if (size < 8)
+		return 0;
+
 	if (priv->alternate)
 		priv->slider = data[7];
 	else
-- 
2.47.3

