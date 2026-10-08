Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D843B9927
	for <linux-input@vger.kernel.org>; Thu,  8 Oct 2026 05:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791438038; cv=none; b=gmRR+LaJnT8/9vFd75fPRsjCgQjD+jmamjo7QOMbdAjjVSwXcax4MH0HZ3t7h74RoaME+r2lVB6uynxlnC52M6jg21zuEpzWxkLIO+TOT2cngha2lMu5MqnV6ysnXQXYRpeJeb/BEyxXGQSNAe2KuEgqd06AqZi9Yhp8TRFGHN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791438038; c=relaxed/simple;
	bh=CvBIAcTaNvBuf6s0Q0MU5WX2dqdvQEhblCbv7hdG+20=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RvKW1exek6y4zlHtYqXoTI/78+w+Ilk+QxyhiGlLptirO9rScl5hXxL4X/DVTFFmxGfQqQKb3nx1zOHTgOwdJucmN+WCMvCwlzRhSgye6DGI9BJl/M2TYq6F5HbHa+Fkl8hsuKfi/bKWfyrog7OpD1+W+lpAtOBl6hSlJJmCCpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOPzuVWF; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOPzuVWF"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33c2520ad38so6119403eec.1
        for <linux-input@vger.kernel.org>; Wed, 07 Oct 2026 22:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791438037; x=1792042837; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X9kdlXgDyFx5+Qdxi4wxGtejd514wpSbKU1RMyqlmI4=;
        b=QOPzuVWF4Lui7eUCXDZWz8oTardi6iBrdtoA47B5u4MoSn+pBhFFxNhLRgV5CA3Ud7
         J+To4vfgZFU0zynuw8LTsVk5ym6DLOCPTQGjzQSIx62LLCRgEYU8ZvCfOmUtNaGxH3t4
         4egiryehox/eBL+ckbslvF+YRzs3RKFWiD7nNElvmnKH0Z8dNSnUa6h8Z8oRSEUcRJKg
         3lyC1hk4wnJAJW6EM8ux00adAWunBI3GDb5XDHZsczxHYbf+M0psGbchSE6k77u6JOzS
         /Zkizl5XELwFE61G9QixO3rufsrakcMhZcIQKvMngG9NeHIUkq3syG1Kw8QQ00S3nWEO
         MDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791438037; x=1792042837;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X9kdlXgDyFx5+Qdxi4wxGtejd514wpSbKU1RMyqlmI4=;
        b=EG5HtrHW1kVaYdvqp9MybBDSw9ZQ1EdYlPCfxOfy8YB8x0Uxcmcyo9egvN5Zb+lAi/
         7YsvykLr51ge8rd7LbX5a9SGKZdrHmXF9lI8De5RzkBEp7BmeiRXxgpYJXIhzX9Vo4PF
         d6+HkfAgWBua4qWfWJ0LHiOPEKLt/Fp5bQ299Z+h6iOZ80t8cdjVKJcRgA3WmRIDcxQ+
         ZbfWgyYhxCyBvZq0RU5hgUeww9sYPDmk1HGy0/iVnJuDGUHYApQJC9W36wDgOtYLsXjt
         oGBCldcJDPVtsB2t6+sWUO1mx69GFHHP6XOJ9MOIylajBtaCsewrg0vXYECSK9PF+Bal
         xc6g==
X-Gm-Message-State: AFuF++lvUCLprnJRg2MT3JSZlMLnc1g9xHC3r7935LguN7FXOzTLb0rn
	H8xmiAYRWfpcKfF9Zb4j8uewgE7vuzQ498DLGkSQ09ro/e4fAWGHMco8MvOqU+4UZ3k=
X-Gm-Gg: AYBFou3q9zFYk+wegY7rnZYyPJExdqcmcmQ+DODsSO58byJ1Tw74iwbitB11E702SbK
	E0lpLrSR3ZRrS0m/jNyPA12DQILkmOo/R0eqZh2aR31A12EwP2X3CqoE3kR3nIhkUsv2UccMExX
	gdR5Du7O79RgnrwSCZwb9pubBqQEUPWfgoenVyzRV5TGW+cXZtL7QIdSbZHtZTfH4yqRgebIyrD
	oDU2BMO2U9njLOMFW9RIZaGXue0M8yYrFFP9G8EkbHhMp1ex/GFL4KHrIPKE61lBEVBky9ExFRR
	R7tIXQnDu1KqUeERKueHneqCdURwxlsN5IlwwC9z6Zw8Z7TbF2WsXvCiKeAYbZVF06U6Kx0VfFN
	u7P1kFoj6ofuYEAkeIZW+b21uxE7uuIVBaYDL6nuQ+PaSSHY3cONeSpIz08FUuXoTc4qrhAMSrt
	Nqi+0GEgpL1jk5qI5805otshXDO3GJ1++Fh7SBEVbVjxsgatSU9HUQVxl+8ai1GlA8mPj3aYqpH
	UtaXEktg9Wyzj2N4Yrn/YzApE1HL83gnn6rgWFi
X-Received: by 2002:a05:7301:3d0e:b0:351:5112:ec4b with SMTP id 5a478bee46e88-3515da5dc10mr4941142eec.2.1791438036553;
        Wed, 07 Oct 2026 22:40:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3002:e11e:c053:ebcb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515aeb5fffsm11498076eec.6.2026.10.07.22.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:40:36 -0700 (PDT)
Date: Wed, 7 Oct 2026 22:40:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Input: matrix_keypad - propagate error code from
 matrix_keypad_build_keymap()
Message-ID: <ascss_vYXDPXIxmn@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When switching to managed resources in matrix_keypad_probe(), the error
return path after matrix_keypad_build_keymap() was replaced with a
hardcoded -ENOMEM instead of propagating the real error code.

Return the original error so the actual failure reason is preserved.

Fixes: 7d0f351da460 ("Input: matrix_keypad - switch to using managed resources")
Reported-by: sashiko-bot@kernel.org
Assisted-by: LLM
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/matrix_keypad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index f4a63a7bdad1..596696a0773b 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -443,7 +443,7 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 					 NULL, input_dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to build keymap\n");
-		return -ENOMEM;
+		return err;
 	}
 
 	if (!device_property_read_bool(&pdev->dev, "linux,no-autorepeat"))
-- 
2.56.0.385.gd3acb90ef8-goog


-- 
Dmitry
