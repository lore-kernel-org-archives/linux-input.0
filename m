Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E383368BF
	for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 21:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979997; cv=none; b=Ji3Nq37fdIx8+uCLR8DxWWtiqBJvOpspbeS4frD5u/p/DMVL1zsJo3/S6reVTlRrjqNsuhJQXl1/1yCxZ2nfcOJUISuJRLngkQO3oZ2wmEAm75+iggGGinSmtzZcVfiRJGFqu4JW3he1K9Dsbw0hxEuO4YtIgXG6HxQEcXgfBtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979997; c=relaxed/simple;
	bh=H0cwLVGaX4dKbobyhMaQ5PNoidoTkOFDxl0nwbS8RTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgLcIII8iLCCBcQdTuPWsInf99EFPp4K1uyKXEHB2ZAiX93M8isLRJcX60EW+1EsloJ3SDTWAVbwSzaPePlonJJZ7TgZJsVP3x68DSIl5+MfBmhwtIUfqZ6QMU8pKSAEzBPvxZX8NyaKXHtjjJJO7r5t6cUB7VkM2sfszyVXE7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=kJs9Y7Dg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="kJs9Y7Dg"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-47df6a5202bso2150850f8f.0
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2026 14:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1783979994; x=1784584794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LI09mRpsYnchiZqtEGapuavy2o/KNyJgShSvZvNJrfM=;
        b=kJs9Y7DgNcZTTkkVB1P/8hBHtc/3TI2PIBO5cv1RndCQ2qoExSD7rzjWWcZnNJRnJZ
         z7SXNzQA+PKujx5o7Uhxrd1WFmvpE3H34pjhf4s3qM62+xCEv5vgrEwgnvZhvbO7VoLz
         l6pN+vIRfLsM52GbsabUroAx/NX3ke0nctmFctZwhRcrCSalPCWflS6cWGzPtQl6OPaT
         hEvz1XPYLqBhBcOY3agwdbizizk4cGDz7eerwk59lvxjzG44IOZDG5TRXiCqfq8e6l6O
         L2xni45W5oBWWL3g+H3rw4GViTnM6mvp88p1+1h+eQgue6LoUC0gAurM5N09Ujh8KCs4
         Kqdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783979994; x=1784584794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LI09mRpsYnchiZqtEGapuavy2o/KNyJgShSvZvNJrfM=;
        b=qCZByJjnFVbWABjNiEb6NNj7M6iKsRv3ZDMLtlIf6a1kYC3x9QRfpm7ObQ2JUrZxoN
         aDcX7NefBU3eYAHC/PytpgNRV56dPS7lT9E79a6Xr88e4D6IvzzvDk6PpahhtlwmMF94
         eujdedZVW+2/dDBY1h2Ub456zXA91x5rmttXyHLlwrSrf9z+GRSJLZjBfrTuMNnBNoKe
         XY4J3ltYeJJdvDQDTAKhrfUdlcP/K3OtLuK4irLKZ3uM8tjzw0rSPrljnyQ632JUtruW
         NCbxRHnr4iDKdmlhFvEF5aGP/9VPigemAEOX6pBYHIrHXjBfDwnyDhjAU3y8nn9se6rP
         dK6A==
X-Forwarded-Encrypted: i=1; AHgh+RqHoY+FKxyRCSp1lpy5yhL4VFeJY1mASWsevy6Ozi452g/ev7JZbKxIdoaukXJkx4LP8jm87c7Y01SULA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvHzBRJzJyxPyvPKErgHkkPFParNNx+SlgxLAy4pOBWhw+EovR
	BHq7JolQC/KCdoHOh/MeLkCbtwO+FLL7ZduENv5qpk5NwIZkG1/VYvfifWcxhbyAYTU1
X-Gm-Gg: AfdE7cmYJWdGdG4V3Y6ACgPGZUogWmVyZx+zFGGmPMbZ6Qv7A6hJEjszrypH+YPHV/P
	1ZJMVpVi0NLUD7WuiLBdUZXrXs9vgR7KkwI2bRiQ67VcdoTaHgPwZI7fcelgzaju0ShrixcLN3o
	5E7hvLb8NSPDPFTZSbXczYwbVfoeiwZc0aoCInEdfiYD74BgZV/t8l6pHaJgWIVJ2V9ydrbyzKW
	wBRtaCURPGZYcK90rr1MQ03LlOmNyoGM4jdPxfWby+Mnk/J1I74kXX0n/Ti4/SwdnScSOJNCQvn
	3H+IveSrYbooVWVA8Menp/iN4LtsNJsJzQakD/WI1g3GC7B+CYnxotkAZaucBxeyDhw6pPsBKtN
	1pb0Qr0kaugwD/iF7yuLluXO+lwIA2Iu9T4SEINhXt11hfg+YabPn5f62EUt/35+HtRKE45oGFr
	qecav3EyBh9L/TquEoqTn7CV+sEJzohNb4Rj9KV/RuHDIjSrqkZ/YVbRHHT7C/HG2ILiV+NEE12
	TnEBgdDrcJFG61w0vrQ9v0P4Ei4Ajw0ttk=
X-Received: by 2002:a05:6000:26ca:b0:441:1e1e:a050 with SMTP id ffacd0b85a97d-47f2dcb5325mr12237283f8f.16.1783979993692;
        Mon, 13 Jul 2026 14:59:53 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4635a63esm2584715f8f.9.2026.07.13.14.59.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Jul 2026 14:59:53 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Nikolai Kondrashov <spbnick@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] HID: uclogic: fix desc_ptr leak in probe error path
Date: Mon, 13 Jul 2026 23:59:50 +0200
Message-ID: <20260713215950.24193-2-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713215950.24193-1-doruk@0sec.ai>
References: <20260713215950.24193-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uclogic_probe() calls uclogic_params_get_desc(), which stores a
kmalloc-allocated replacement report descriptor into drvdata->desc_ptr.
If a later init step (hid_parse() or hid_hw_start()) fails, probe jumps
to the "failure" label, which only runs uclogic_params_cleanup() on
drvdata->params and returns. The device core does not call
uclogic_remove() when probe fails, so the kfree(drvdata->desc_ptr) that
uclogic_remove() normally performs never runs, leaking the descriptor.

drvdata itself is devm-allocated and freed automatically, but desc_ptr
is a plain kmalloc/krealloc buffer and must be freed explicitly. Free it
on the probe error path. The kfree is gated on params_initialized, under
which desc_ptr is either NULL (a no-op) or the allocated descriptor.

Found by 0sec (https://0sec.ai).

Fixes: 9614219e9310 ("HID: uclogic: Extract tablet parameter discovery into a module")
Cc: stable@vger.kernel.org
Assisted-by: 0sec
Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
---
 drivers/hid/hid-uclogic-core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index d74f98efa879..ad9914ed0c71 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -265,8 +265,10 @@ static int uclogic_probe(struct hid_device *hdev,
 	return 0;
 failure:
 	/* Assume "remove" might not be called if "probe" failed */
-	if (params_initialized)
+	if (params_initialized) {
+		kfree(drvdata->desc_ptr);
 		uclogic_params_cleanup(&drvdata->params);
+	}
 	/*
 	 * If hid_hw_start() started I/O and then failed, raw_event may have
 	 * armed the timer; shut it down so it cannot fire on the devm-freed
-- 
2.43.0

