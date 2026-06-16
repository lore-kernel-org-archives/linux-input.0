Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EB642DFE0
	for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 11:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608299; cv=none; b=tSDlc0Ctht/ly3Sog/8vyToVn52qlNUP5tVSInmDeNXEgIIuFzaCz11Erv+oNQGmqnEfdSP94XANkyD+imP7evDktRLMy3UaAzmd55bQpppQMXyFuopdPRkSN3QDSoy4AiJhsWtcZ2VBiTVwjNhtwRYLQKwGtncTkzMuk0qH070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608299; c=relaxed/simple;
	bh=WGX0XQW1Y1v+z1IdcNozewhJkNcGnleipMvP0AiYsYg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FtZM8xXElRiGCjEmXD1nw8Ba2XfHFdXdMqDVMPx/UwFYETkJmfiMvSFGWVC0f9oeYstRaGd2KJ8B4dCxvpqUvc2XJLy5uvJKeotsOrY9EbzA0NBt9eMTnuITeev6SnMHHkYPpm9LuvP6vutO/ZIpog8uTBb8C4i0hes2Vc1qlvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF7xvg+w; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF7xvg+w"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c0c35980fdso45023975ad.2
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2026 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781608298; x=1782213098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaMLitRf+7HaGQy1+AJ28uDdAxg83p9TaFLMbB8gFSg=;
        b=QF7xvg+wrM+W2gP6yMxGVWCQTZ8zAaaycK3FOWkFzJiQZnql6uO2cHA8U9qxxOgDdm
         C55IXiKRfmlM2dtW18FXeIROeEQl80g/XE/z9wVdsjAVbTiWvQ7IdYomrtqpRq5iTi8G
         9coY4YQHMTPXsLPll0IOunzTH1HG8n+G3Qn1NAYXZ9Ver59weHLjrQgP+Fy6TigVVDol
         xbjAJZu7NiWOLmwR434d15PgxjdvthniCFwfN9TqipDIe+7d5i8Vk7RTrf9tyZPLpt9T
         6paGvaZxAKVvWF2sDIgbz44Rs9hk0kw51u2B3LxcZC5jaMwH4PQJa1UBBXlnErRG7Ohd
         JXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781608298; x=1782213098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaMLitRf+7HaGQy1+AJ28uDdAxg83p9TaFLMbB8gFSg=;
        b=NSDUwvtoxAGy3az/wo2dEAd71R3CVzgC+h1BwCThm5+268ik+8hW+90zgMxnFDi7C3
         aCYQmNS5ZNaMESzOsaTqLIYbt3e0dg+1f6rjDbe7RWHWiyqi0K3B+V0HUXuF688m1Z62
         QalM5wxTkIQAKtKmkUBeJ/N9+vWw7/gVMc5zoAJIT6AehN/5xECY1Mhrt1eXTeV9cyaW
         lHZLGvTxqVs3sZYcW9BxEbOdYfFNMJwzDK4FDw0apZPoUsn4suoH+3MCN3FnVmSCZ4DX
         pilFzi6nh7gUFQg/JE3uxHYa+4ttJtbfDV1r/2021jt1FxyPxOBtNZdAWn5E5UeGtNvK
         vpDw==
X-Gm-Message-State: AOJu0YxQoQYLG670QBtBEFYEzXllDzoztcvaBMVDekIjpWcXSUaJMN6C
	sUl+L2dEKpM7cY9Zf4xT24954kVNPOH3b1qRMSwzlesHzGsIm7iQy5jQ
X-Gm-Gg: Acq92OHkpXwZ5BRt1fXsF1kt5ucYbZdCDq1/sAiH79Ez6vDhPLRGdiSqQIBa62qTCmh
	/bkgfYb7ZZtXxW3Mju4fxwwGZsvMz+vzWQp0uMszNAdoLTA+9dwlotrw6vgc+3ZKFf+4jFVQJLO
	BySGkl9qVS6/Qc5lqqzv9mANHIEI/MnTbcAw8E+UPhr3I7o+1gDkP9p0hCbdWJVNncRrhw9BMCP
	T8aqskez1cFh5s71fPmFkeayAe+ppgU/XVmB0kzmf8D5CuJtgfUpUYfeicuEa6iNXJy0TXdUTjQ
	w6w8CUyngC2G70ytunIIkZdczSJD1CujS3urUNVGCOeZ8u2hdxrSA0BxpNaEdCWCFyPKyTZP3G3
	vjJSmoAyLl+3m67hDGkF0ZNICMl44sNwKnQuKsArhc3ZIpnzkrlwiq/PMe+xjejXAqqU23Hjjz/
	eXe03D8N+/tRejcrsBWkJ4ne7NlqGP1ltz8D/l6uHLx7C1pfej6WpXnryG6dE=
X-Received: by 2002:a17:902:cf04:b0:2c0:c940:dc32 with SMTP id d9443c01a7336-2c69a114289mr36693965ad.16.1781608298360;
        Tue, 16 Jun 2026 04:11:38 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f1f0a36sm125248315ad.15.2026.06.16.04.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 04:11:37 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com,
	David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] iio: hid-sensor-accel-3d: use ! instead of explicit NULL check
Date: Tue, 16 Jun 2026 16:41:32 +0530
Message-Id: <20260616-15-jun-hid-iio-alignment-v1-11-0cd544286575@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
References: <20260616-15-jun-hid-iio-alignment-v1-0-0cd544286575@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15.2
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Replace 'if (indio_dev == NULL)' with 'if (!indio_dev)' in to follow
the preferred kernel style.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 42c4259bf209..0999f7dbf434 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -329,7 +329,7 @@ static int hid_accel_3d_probe(struct platform_device *pdev)
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev,
 					  sizeof(struct accel_3d_state));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, indio_dev);

-- 
2.34.1

