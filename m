Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F2842A789
	for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 18:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817560; cv=none; b=Qkpi7LNecubpRBtpFecqheV5/3E1TnCC3usUVQfG/Kv8xvcAgir/B73LwVDDrt06MO/OM40lY/qWtZu7/62jcV1bMGemSkOOXxaOIQxE9zF7+//R1i0OIlFhL6c8o22pKM4XsNFxq0SUvtV86kF5SgjSUQhinp7Dp7NC+nxL248=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817560; c=relaxed/simple;
	bh=aNmSWjEydJ4no+zgI5MBjNFoFnJbhyxNFgYPOGgcmCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oc1iPEaz4dD5QyEknP7K+LEl2uMPtx25Fs/gNP2JmqymCcqqCEKNGUwBn/asOBXOHbhi1sT5IshJYqgzJGGNE7zBthpYJdMYnEoH7Rm3rFV2Aq2MiWxR7YCaGaZ51cisOhM8nX97T2Z21spc+i6aWsWv8MLgArqZBNZy9dGv+t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnki1St5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnki1St5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d032846c95so30354035ad.1
        for <linux-input@vger.kernel.org>; Sat, 15 Aug 2026 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817557; x=1787422357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4IBLoStoWuAaMxx5pGLOYj88i0LHcpdj+qZYVP/wkhk=;
        b=qnki1St5Ihi5oeZnzRzhA1gULKXuWLsllCFbKM7XAFyiFfni3CqIvT+bs6EqD5K1CC
         G/2zi+Xem41wHg72M5MPAIQoX0Owq1SWT/5XiTQe7Cq9idsjrADoxnsjUTBTtdCjrSS/
         H2LdpfILlPSMfP5mzZoEXBvZwWoNSqqh621W/ivaAF47DPiuy3s90KWNY9qFKWJHNaHf
         Zx+jBBn/sF1jtmcI3DqcHkeHwIR/s0VvRdarraReE7oS7ff/yu6f0N3a281gsGz3giZX
         pBFa4+5AAcybX8IrSKGb64mU/JXnlxp9YuewpQJSFiUq3KfDAU9bOnP6RHATywip9t9I
         9Xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817557; x=1787422357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4IBLoStoWuAaMxx5pGLOYj88i0LHcpdj+qZYVP/wkhk=;
        b=dp5ekcqX2k0xp1+zPusma+bue9y5UtygxD43flZ4WzsIQk7RlCXrO5tbrX9GnAhgof
         vXG1RtgEOso3wF8tAHcOKHP71ylTgckdKNBURXw/4Pw6iBxX4J8Hivj3wsXlKve/ZecD
         B/rQVoBmpqrlE2NM2nM/fFcZLVZteM484o0Yf/Z/mHWoArA50FEdgQW4FaU1IuXZceOV
         7FvG6TRHv+QAhQsFxdoGTx8fds6UxhogD8cY+fNYbHPCooKOxoz/ShTzsVAngA70eGoj
         o4/5ZeDPW8+9NZTXCGHvULK6QfX6piPCxl6/XJLzzf3LGnnSwQb77rL4kIDVRgrxUNKs
         tOtQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr33wj/PA7mRe5GtzL7YOAFe/nWp5dmISQOSriUv/q7scSO3zoqX53AUEEop4yzPYP+lFbuBtlUxGkwiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqmZVAZFsMiOajy7hmkxji3wRUs28g0ySIpQGJ1VdafnG2MVxY
	bl/Dndar8goSc5bV9kxA3sJkCmXGS0OtNkT0dTzYQWlay1/NGP8Q6nyw
X-Gm-Gg: AR+sD12e1zEFVeE841wifi1TVUlvOQKzlmBe1F+FmLiin1UHTtRgPmvHSHbbdGv+Aiw
	Cbg1dcdowslXgs8ga5cUXwssaQyPb2XtYqdsaMq/3HUV8ZbfFcCi77t1Oojn8fPCFd1PfcIGERe
	cqsrjL9GEOZIEfQv4TUShtvDH24xgLdNGaVFtq0+ZuogPEXsz4OHY5Cr5viFEc4mCDOeypFPnlu
	NZOu49B9uEZjZmp7/xmoZOTJZiveNiuuyFNkBF6HHTFJdK/GytWeNQop6wiUWabNxB40A0Mj2rn
	I6WJd3Z1pOx/dYypUURo3/Vg+cfSJid+4KzNZ0aCqp3opCL9kCnnQm//lfLOfBzr5zERX2rZ1uj
	/T8IUzGlRkMh2EQaCGygNdFdef8r8rK/oA86bOp91WjzEiHmqmlNJSFzMqrUaWoUy1U3hzuRHOh
	x2VGcx9saEnOmsXKfZb03X5TqfdsEScAtGkmTblaETl3Xj2WNVF7+y70SlNkK2FqkSrA==
X-Received: by 2002:a05:6a21:150c:b0:3c3:791e:5e18 with SMTP id adf61e73a8af0-3cc71ac3791mr16373444637.7.1786817557118;
        Sat, 15 Aug 2026 11:12:37 -0700 (PDT)
Received: from Default ([2409:40f4:10ff:af94:b1ac:4b85:928a:7483])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387ac9b1sm24250171c88.2.2026.08.15.11.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 11:12:36 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: chenchangcheng@kylinos.cn
Cc: bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH 0/2] HID: corsair: fix two use-after-free bugs on device removal
Date: Sat, 15 Aug 2026 23:42:23 +0530
Message-ID: <20260815181223.686663-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727013500.23435-3-chenchangcheng@kylinos.cn>
References: <20260727013500.23435-3-chenchangcheng@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 Jul 2026 09:35:00 +0800, Chen Changcheng wrote:

>The cleanup functions k90_cleanup_backlight() and
>k90_cleanup_macro_functions() call led_classdev_unregister() before
>cancel_work_sync():
>
>    led_classdev_unregister()     <-- may free led->cdev.dev
>    cancel_work_sync()            <-- wait for worker
>
>If the LED worker (k90_backlight_work / k90_record_led_work) is
>already running on another CPU, the following race can occur:
>
>    CPU 1 (worker)               CPU 2 (remove)
>    ---------------------         --------------------
>    if (led->removed) -> false
>    (passed the guard, about to read led->cdev.dev)
>    * preempted
>                                   removed = true
>                                   led_classdev_unregister()
>                                     -> led->cdev.dev freed
>                                   cancel_work_sync()
>                                     -> waits for worker
>    * resumes
>    dev = led->cdev.dev->parent   <-- UAF!
>
>Fix by swapping the order so that the worker is cancelled first:
>
>    cancel_work_sync()            <-- wait for worker first
>    led_classdev_unregister()     <-- then safe to unregister
>
>The removed flag is set before cancel_work_sync() so that if
>led_classdev_unregister() internally triggers another brightness
>update (which re-schedules the work), the worker will see the flag
>and return immediately.

The premise looks good, but after re-scheduling the work(possibly),
what happens when we call kfree in the cleanup function, that leads
to a ODEBUG warning as our work might be active when we try to kfree.
How can this solve the ODEBUG warning?

Reproduced here: https://syzkaller.appspot.com/bug?extid=0a031a76585d1c7e737d

Thanks,
Jeffin.
