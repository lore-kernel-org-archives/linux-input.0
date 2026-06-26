Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B423539DBE0
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 05:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782451092; cv=none; b=FGIVy0EMuJ/Nem6VA5Fsfp3HcTYhF4iwDKXS4LlXVNGNZ8nGLNBGXMwT/bCIZfioYHDB5QiNPmjtSDXmX0Wv3CBWZw7MUXQnM1zBci4wC46C4ZIbGktdUHDFszDYKYn4NjHolYQ2wvi9zGp3Aw3sd4WmvrEcsvRgIt33/OToRpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782451092; c=relaxed/simple;
	bh=w9BRv4G/Z4TxVw3Bis+zhuru73hqyT+jHylpJ1c6Fq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pju2G+WbOs6VDStoTXw2Bnwe2fr7zxAzUb5rMIw3RADViDBRRb8XOqeASg76HPsLyS+7zHmXlrqTckSmC/XjUQ86UnXTBSH4dXrX7k9A8hoIOd+rfsjskJEervAMRz9w65xTVnQhCa+MrvRH99obnfaOSs08U9aIPV3DI6/I3+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwnlIc2h; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwnlIc2h"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1363fe80fe8so1335928c88.0
        for <linux-input@vger.kernel.org>; Thu, 25 Jun 2026 22:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782451091; x=1783055891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5KCEVqg43xVNnx9u3vD7/j+0QLcI2+mbLsn7eDrFzY=;
        b=rwnlIc2ha7t6wf5fC1Klh9IWELwQEJ6RcZRf9yIJfRdAimT6kvb7DjIU/wWeaJHG7g
         0d4/Qvv+6WpsJcixJDMQ/BcZkWUfOYn4/LyY3f5PfONJUD5NBIGVbG531f+zhhRz+hhj
         xQQO2ipy3N/9cjAhpiv/R683c3g0TayVpaRpWLzAV1EJ+mebLVVsJy/7erWnRWtaLNqz
         nWYdyOZfqwb4G6JCtIiYJM2d5aK2Zop99AtkbjD3+h2fSZ4DwJiJjncTtVWucSeJllPW
         xtmc4NqwY9B4WNyES3QP2VxJ//COio3BaXiW40KGF0TU6dVf3Ji3t9ea326fCpeNxS8H
         U1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782451091; x=1783055891;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T5KCEVqg43xVNnx9u3vD7/j+0QLcI2+mbLsn7eDrFzY=;
        b=ifAGKuDCqhBoNNlbJExRScjkq8T/vfGf4fD1o2UwM5HJ+7TooJhDFFUESSSJIsglKp
         kWSOlj71LYR8PSXF72qXVgzGMzM0SJPnT27IZA13POdnUZI/5sWsqmsM/Q27qBpVM6f4
         pCfI1yigF/uhRYGudjSBWpw0VkDxiTs36VlorjtIvMrgLaXo+Y5iETPJ3qWZ0FfcX6dz
         sI2XVKtS4J/tHirzlj/SObu8sZDw7lBRcvvkNAUvVa4bKwWUwF2pkIzt4/CwEGk7WQBJ
         ykg4LwYS7q8ZYLXbxN42Y9sGVfThRh4uJMOdaGj8LKGq3vlyjBPJKEGGNPyltNUKX1cF
         84nA==
X-Gm-Message-State: AOJu0Yw3+GPKtOmw2N9iP+VrzUD6HRSePhacrKTVS90mHHCq0o+F80Kd
	mnSm6rkpTARvAzRXcph5NQ1S5h0kCmcHwFjqDFdxK8UzSQGhJ4uVysJl
X-Gm-Gg: AfdE7ckIR40J0alvJI7WoQe5lZ9/V5lvggQpn5woRXErY3OhmOgoOeKqesLsIV9V70k
	eHcClCjkH1hlPOfqxhJXuHrvO5aWu5Rl7muAJdNjv2Xr3pnM/GkZ2jRSmmUgT2CNjoFGYGwO2Im
	O43/7d887VJL9JfIXV4zzFGd4r3AiqP8g/2ttAS2ft7tPIH5+VLDnpOJl+NwK9WVeQwJoy/dbsY
	TcssC0EoIjufAJnIvPFtjl3fUx14dWEfuuaeT3CxNbImbQR9bSnkJyIM3gy5nLIb/ie9MZrb3Lw
	eW/ZEFYk+WDJ/hTszMKu5cXkB5qzV5ITz7Zuxdd4G/EzpubtmzvbJxVYO0VQBtABX/kVfjppaUe
	k2XaPrnLnKMZjPSDLLrOhtxD3oNlF9T9/8y/VLfGdlq+poFYbxfXATdDMh4yWFyxMdz1egTysC6
	lgoPY+gXXrWUNJXsXmkoyAAZoYApdn1mCkXxjRBlyxvcS1YvJ5YtYSgANcz9aPdrHTuLFqkL2RC
	s8W
X-Received: by 2002:a05:7300:1821:b0:2ef:83d4:647f with SMTP id 5a478bee46e88-30c84f216d4mr5261124eec.25.1782451090822;
        Thu, 25 Jun 2026 22:18:10 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c9e9214sm14804188eec.20.2026.06.25.22.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 22:18:10 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bryam Vargas <hexlabsecurity@proton.me>,
	Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 04/10] Input: synaptics-rmi4 - cancel delayed work on F54 remove
Date: Thu, 25 Jun 2026 22:17:53 -0700
Message-ID: <20260626051802.4033172-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that any pending delayed work is cancelled before destroying
the workqueue in rmi_f54_remove() to prevent a potential Use-After-Free.

While destroy_workqueue() drains the queue, it does not cancel pending
timers for delayed work. If the timer has not yet expired when
destroy_workqueue() is called, the work is not in the queue yet. Once
the timer expires later, the timer handler will attempt to queue the
work onto the already destroyed workqueue, or access the freed f54
structure (since it is devm-allocated), leading to a crash.

Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
Reported-by: sashiko-bot@kernel.org
Cc: stable@vger.kernel.org
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/rmi4/rmi_f54.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
index 75839a54656b..aebe74d2032c 100644
--- a/drivers/input/rmi4/rmi_f54.c
+++ b/drivers/input/rmi4/rmi_f54.c
@@ -749,6 +749,7 @@ static void rmi_f54_remove(struct rmi_function *fn)
 
 	video_unregister_device(&f54->vdev);
 	v4l2_device_unregister(&f54->v4l2);
+	cancel_delayed_work_sync(&f54->work);
 	destroy_workqueue(f54->workqueue);
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

