Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D63C1991
	for <linux-input@vger.kernel.org>; Tue,  5 May 2026 05:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777957219; cv=none; b=HtpUX8LgUkQREyocR9mFc3TLW1KHCJbrLl4MC4T+Ujj4/wF5DXKra75JtZ+UcyGDvtsf2lH5vGhcLMeOAdoyJFBxke04+6i8DE2g4OLGhp4i2ujLht9Byc6oXDFNWMt1bs2ssHsfWFVN5V6wDfFrcHBL3h7mPK4ESa72mw4HzL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777957219; c=relaxed/simple;
	bh=+j6UST8T7/rqDpInMrYEJxa35ttSBlioBojgrsKk74o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3i7bRXN6t2Q2H3/bbTp7vMNPiioLFAmaG1T9azpW29qO1/fPJNB1vSENXeot+A3HwLZNUm3YhU1xFVrLCY7/aadFQb+/v94jTh/MrlgPAROldPA1B6SX5EGK3CskBY7tAedvUI+Lbxi7Om3KWnReA8RiYsGWPqVuXlt+8reakY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHBXuxv5; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHBXuxv5"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12dfee30612so2048329c88.0
        for <linux-input@vger.kernel.org>; Mon, 04 May 2026 22:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777957217; x=1778562017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+gGcl/944U3F8F8GDunPMH9kl1f17h8w0DZqDYpc2Y=;
        b=PHBXuxv5urt2R++iuZK9EBz/1FSnVml/p9kg7D6fIjEg50LOJ5Gebp3oNY3qJ17wEz
         x1E1AYsF4XKEqHWNQDfDqJ4nAk1G8QEK+Stu02b/qM9H6vCFzGIQRccpd7KFhefmUbDx
         cQ7+t6IMnKaqQ8zQFxJMxrLMi61SQnL4m96fNsyxRHDGZ1YL6uJmhiNgkUu4Jl2KFz1E
         nYO5Xkoj2xdOr3UY70GpIZ9bkBE+cphYayxQMYL8IOLwJLWv8954nWaepmKLwRJzbaV3
         CnxL60biBQx24wM5QoERXf/z2sOyheYOwSAyX5H4KdfZakLp7q1nFtU3VdJRzPMikD7n
         Iivw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777957217; x=1778562017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8+gGcl/944U3F8F8GDunPMH9kl1f17h8w0DZqDYpc2Y=;
        b=Q3eT4s0Y91XZ4jxcXcJ4orx30J+h5ivQA35VCZFzPCj88ZzpJq1i/ze2Fv6pg0UHOE
         WOZl1SiTS1v5Lzz0Lx0R6EDZjJNijMzwOxgaD7DzsaXE6AIC5HLXgOAtCfbcKVcQNgcb
         Xtd3zVJRB/nHT49E2IBDT6yG+rKqdZtwEiR65XOgVgwCqw0fuBwDYT7O7ERqaTTv0QUM
         cqPbCvmZ+NC0qAV7neQZ/1Iaq4R1lP8mfZ208byXWCvZ4qNwnWya7xfJnGZ1YyAnSlWw
         guC+hTYiOkxBHoQjj6+yLkqKq7U32tlAPoLZjft4jSthKXmgxYpwTZ1kefhMyCtBrwnE
         sTvQ==
X-Gm-Message-State: AOJu0Yz7NBL+yQ79vVouW7PR7jxDt4v1HBAsax1MJtwcjRRPArl0JjAN
	HWgVQe0OGnPbcU2mCebPnhzEovsvhvP90jV1YGYI8MuWQa0L+USSaEtwLMTI+A==
X-Gm-Gg: AeBDiet7qYHjdQu6YOfm2h4+cyqtDDzPV5yKymEVG8D52kDkA+nkE7M6PwkC0WETsRI
	B6bcLAqeMuIKvcR2fuXTmFRsd+2dlTY0n83dbKlnqexNqIy4dpPjMkEtL7iQJSSEnfN7Fjg7oow
	oG1RvZMmAIbZEEqgoVHoFOSQIPeHn62PCXWW0rf1UBZIDc7IGPV8bGMrv2+KHV33CLPUB8OO0tA
	2VXJZhaa84bRJkEDVuUXIxWiaUliTKaw+tpPbf1h4YuxYUpsluC9wG5m2ADRl9yjd6HoZxvwfak
	DFW5VXoRqwoWV2WBB8BXzQa7x/tSYq2HLuWxvGd78o4VVPtrTjAoKYbQ5ssiEE52OiCfp1dxLtZ
	3ufbEKatIn0xvZ359Ncq9lOjqTxpjyZfby2F7aQlmWMFc8PPU3sL9pt3S7axgOGimSUbWkBbBO7
	kpcOXtz5bAQIqHeIsY66NVhRuFyN/Nr/+fVGLk/9r0sTwmEI8QUtjjePtAjuMxtq3RUdXoTfYhc
	SvRVWVA9BxS++r6eyWJiBcPCL+M2l/BLIaD
X-Received: by 2002:a05:7022:68aa:b0:128:d5f1:d593 with SMTP id a92af1059eb24-12dfd7ae797mr6453452c88.1.1777957216539;
        Mon, 04 May 2026 22:00:16 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:94ef:a6f3:2c96:2d58])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df827a73fsm16897502c88.1.2026.05.04.22.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 22:00:14 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Marge Yang <Marge.Yang@tw.synaptics.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/20] Input: rmi4 - use kzalloc_flex() for struct rmi_function
Date: Mon,  4 May 2026 21:59:41 -0700
Message-ID: <20260505045952.1570713-11-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
References: <20260505045952.1570713-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct rmi_function contains a flexible array member irq_mask.
Convert the manual kzalloc size calculation to use the kzalloc_flex()
macro.

Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_bus.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index 71a25df73984..64d5cb72e113 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -242,9 +242,7 @@ struct rmi_function *rmi_alloc_function(struct rmi_device *rmi_dev, u8 id)
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
 	struct rmi_function *fn;
 
-	fn = kzalloc(sizeof(*fn) +
-			BITS_TO_LONGS(data->irq_count) * sizeof(unsigned long),
-		     GFP_KERNEL);
+	fn = kzalloc_flex(*fn, irq_mask, BITS_TO_LONGS(data->irq_count));
 	if (!fn)
 		return NULL;
 
-- 
2.54.0.545.g6539524ca2-goog

