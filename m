Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9533101C0
	for <linux-input@vger.kernel.org>; Sat, 23 May 2026 05:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779512809; cv=none; b=SrzVlSeoiSqmTHFFEPXGJggR6BVNjvj9xZpKS0GMBad4LRlXfNOweVaWA5ICboen+F+BZaxwdOIjja7owlUo3oKpid4lshgyVBexGAlKACqI+sWNVlKQboh8gtl7b5r6iYqvSq1N7xGvf+dJny5TqbEZBoB5W8pJt2H2fYLR+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779512809; c=relaxed/simple;
	bh=eYtv1lkT9JAScsMqNpsnBxVKcem9nE2s9ZDyYN1kMoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RqsBGbnMYHDy3AWuIPxO4NvYlKEGJaSL55viGf1TAIXuvgXSBsniN7dZydsPn5jKiADuTvdxNPb3R7pUZ6Ly9Bhto1Wf/paU+fnxWKvRnVdZm9WawSnoZkGOJKGWP3qXHB4TkcXRuRGUxvj0nPAZKC8Ib8sqdb6ijoe+rdWvoCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeoP6MnF; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeoP6MnF"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3025d725a05so19112193eec.1
        for <linux-input@vger.kernel.org>; Fri, 22 May 2026 22:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779512807; x=1780117607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dFO8Uu1VVSz//xwzZEbkB241DoN8aKb8CDZkxNZZvD8=;
        b=oeoP6MnFHyyAeujPYmJidup4ff0OX3fylPp+YVIjNrbriZaeinYH7KKhBp9ny35JZ9
         orWnlIbNeckDTptZOlcEpweR2tVoNQUADzCAYjSx3CW8wAwpVFeBJbvSBQVZchSIf0ul
         qb413QzkKAHVzOC7XBE1VY1yrs77olYE4O/Y/afBBapuoY2AH6Lt8FP/kkN6vLnfNIDQ
         oNSnTFTAk7T/al09SJ694F3CJTC58HWhwBRZF9SF3JhLaauDnbi/d3kkvmd7VJRJhdxr
         te9WVuNWiPoq778co9VI3mzBRi/ABk7aQi7ZFmj6NexWxs3sGiS1pz/BDNRjV8cnyStU
         4wbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779512807; x=1780117607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dFO8Uu1VVSz//xwzZEbkB241DoN8aKb8CDZkxNZZvD8=;
        b=Mp+9007ikw1JnU26QhJYa+fy48lmx9iuFRTYyWwmEEQYx/6jZfsQqcjGAq9QrTfun4
         +QN2Ol98lwUR0ljV6KopZeTd9ztEnQDZRri7oqP0TOtA99/iGfJJq+GhABzlC5nkOfa/
         Wv8djxszunGbpeeEe5AiSKTRYuDCoZiORJpq//6Rjo1HwIEcuQo4ViAELj/8iY0Y6JNs
         G+lXhekWf1ecaiA0d/F/f+QE7mxAP+7LOjNTksyR3O/y5RdY55RUkKo+V6g0sz9WwinL
         CuWeg+KIil6akgpm+gQXmYXTUAS9Kv51YTCuHv1cAniSelUBH1sTi6h6HYTG7f1E+yII
         mpnQ==
X-Gm-Message-State: AOJu0YzDGhFCJca3YT693W4OFbnmrsp+wMum6iKMsDy3+9h4PSfIUkC3
	ahYlZl27GOcMArZ3exAq+/Y+weu5MwhqVrPH4G7Sx8wU1KY3V8yiOHoy+zskWw==
X-Gm-Gg: Acq92OF6B6L4vW4+w3sbjLARBlcUYLO1oUTZOoYeVkUqJelhqhztvSeSSNOptyzuFeo
	lqNutey8AoZPeVdc5O9z5CrYC2hnWfmFUPOpXt+Yn1m0kNbcZsbxkF+TaT+ChQF2G5u3X2eUkUE
	MLtnzdnxq9MX5kqauAW+rKl/WH8qZ+KcU+x1oZj2QQXWwMgV9JrUX44ZJ0j3ulVM+4rtbJ6VXl+
	Uvh3G5r2WXmoqZdv+l630h38qNSKDGrzT8Sy2XbMgDyrQWDYjD7klz67M9JRZP3/nGfwsZ1u+Yw
	OEhYv58NW5UYraZ2QzqgGIHmfbWPKam76GigHVHJecYjMoMa8Qe6/ydPdcIeryc+M0CmqAIfFIW
	BHM+N5pd8R9bwLSivMlOmfUfSZmH+PEsg1RVTFQXndxa4QDHW0eC1z0NaSmtsSPRvU+Qa4V7BBg
	62QhDBTmtrEwsUK4e83bbel/u9NNULwR42DMK0ivj56G3cMeSJfJ0yl7aDa3sGAcb9VjGPVspgB
	KhCs7wkjv8PRw==
X-Received: by 2002:a05:7301:2b06:b0:2d9:6373:ad10 with SMTP id 5a478bee46e88-304490383d1mr3310920eec.7.1779512807127;
        Fri, 22 May 2026 22:06:47 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:7e45:2bd:3c86:d34a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30451f3feadsm3502583eec.13.2026.05.22.22.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:06:45 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Seungjin Bae <eeodqql09@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko bot <sashiko-bot@kernel.org>
Subject: [PATCH 05/11] Input: ims-pcu - fix race condition in reset_device sysfs callback
Date: Fri, 22 May 2026 22:06:23 -0700
Message-ID: <20260523050634.501509-5-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
In-Reply-To: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
References: <20260523050634.501509-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ims_pcu_reset_device() sysfs callback calls ims_pcu_execute_command()
without acquiring pcu->cmd_mutex. This can lead to data races and
corruption of the shared command buffer if triggered concurrently with
other commands.

Acquire pcu->cmd_mutex before calling ims_pcu_execute_command().

Fixes: 628329d52474 ("Input: add IMS Passenger Control Unit driver")
Cc: stable@vger.kernel.org
Reported-by: Sashiko bot <sashiko-bot@kernel.org>
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/misc/ims-pcu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index f86f9a5a7564..7fdff9dd1b5f 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1152,6 +1152,8 @@ static ssize_t ims_pcu_reset_device(struct device *dev,
 
 	dev_info(pcu->dev, "Attempting to reset device\n");
 
+	guard(mutex)(&pcu->cmd_mutex);
+
 	error = ims_pcu_execute_command(pcu, PCU_RESET, &reset_byte, 1);
 	if (error) {
 		dev_info(pcu->dev,
-- 
2.54.0.746.g67dd491aae-goog

