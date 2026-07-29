Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4012D838E
	for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 18:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350086; cv=none; b=Ozr+zTRDYjh/RYiJe9T2JzJ4Ip9KS2bj90jqt3kN9V+VS67OSEarx6n+bSUscPQ0jMLdeHxxrij7xkRfq54/E5PxO8C+iXIOS6xiywssasuuVge0lU9B/XdLL1tCh0NARMJSFUZLSYkgtMD2BW9HZPxvD6ccSm8mbrMr1WbLz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350086; c=relaxed/simple;
	bh=c2TsB0jY1H8c4jyzK0RgzjvEkLN7ODWjeKPNPAnP1T4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdSErLq3Gp6rPIH99476GjpQH5XThk5S31o7EettGhQADP6+D1z3RgsGkfD/0uzjWqXm0kPbQGugVRhKwN76XLPlQx2HnWX132TYFgyNJsmVYl3kYhkv6LNJISuWnfRoo06XopJH/T2rRn+gqWy+NnLtX5huSKna6B9bBSOhSCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxS03VVZ; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxS03VVZ"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso796244a12.2
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2026 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785350081; x=1785954881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ng6gcsobGxCVjmyl427Ar8FyFTwKr2tmMEzIY0pxgxQ=;
        b=XxS03VVZnMRzd8zYyYK3MNqHo+8NO3N/6SWmkv6rGpQzCcECWO/kEDxwSCllmpbBT6
         Tv6Iwlm4Kvl4XtigwpqoJPV4iooPF0fBzl/XqlefA5h5ZWZRaxenCGhQZykB+qgmPuCs
         ZB6+y3ZXIJG3WxVGh19syNLJT4JPGBfEtoFat5eyRHCRS2LMA/fM+LqlgeI7dvoeXfVK
         nqWs44G1VsoKOaAaPHvnKJ7zbkWquJqktWLQSlNMC3S4ZcNtaRg4byAyFQq4rgj4uT3W
         mGpov1Mr1vTOLauWy5RkMmaZpfE29vPzEgIiFeqBeNpntobjEr2caetFsmDDEYuO7QMv
         ri1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785350081; x=1785954881;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ng6gcsobGxCVjmyl427Ar8FyFTwKr2tmMEzIY0pxgxQ=;
        b=D1p4MBRhXvErZc3U6t/bCkSj1CFfcb6biTAUEdLQOu240JNXm3Z4mz6dgOq1aqV7KP
         78x/CxXAkczOv7mivu1AXn8T5rO8eGgtRD8wWdJirfLD0u6otCOc55uLSIeyRPk1AYgn
         UVGLmT4dji3i4DjSdWDanfFzQYbOPcY+sfHK0zJOoNvspQtGu+rpAqf8uXmeQN++j1Mu
         xYeQRKQ4DkG6MeUH1hJDIsUrjU2d4eLsWzQ4gp6R8PuKLEuKyZ6YYNdRGQN5k1v8Jcki
         sL0Z8yHZLT4kB8QdQptsA8ks+apDVPcS1mmdki3fFGQPuZkH3NhTyTZYWqC9OVWWXAKN
         qxGw==
X-Gm-Message-State: AOJu0YzMQhM+ZMLz5oPAtHFGlrT9J3wPn91P4XxG4jIml6t12yV9gpZP
	eKEckk7fN2wSkRex1L2b+fVLYC1p9K75QGpWUz70JOE08KLVAt8JEgpI
X-Gm-Gg: AR+sD10C6edZ/Fp8BUovT9uq7pOm4BZL8FYVHURO0+m5vzzSRa3XAJFzHMNiHm2Tc2y
	ikfiQR3v6FqOSVNWDywzQAVRCPFbIv5AL06btBvizNg1U3TL9rbyTUK661wOnkas5unmREx7Xxl
	JX78yYkUE+vLhrkCYUKsHdRhCyIT+mTngFBd7KlycrLV6KwOKTtKEvuvBs0CouTMtsOKq93u0O8
	IdzuR2SoswDdns4zKzpof/vLcKSO5Ys5DK0RdxOZixeOOQbpkzrGCOcG4DoF5byt5d7Al2JNn7N
	FgC6SvVEjw6rxMj+LH4NdXt1RaBaDIW6dSWXs4PQjptwVsfjOfxhFQpsykTIdTrki1hXsonomPe
	iDv3ACryQ8GcMUq7m9e9cDMCbql39LUYNvlTdnhSt5/OBvCrBKs1RfxyZZtlPrgNltdU8asNXnX
	EM2Pz2d4rTbAMGFvxRM5suUxXctx8VMUCc144lwM3Wf/A3iJF0lpwHtd4jCkxJfCvrgTmXy7nVw
	iZfWLaxnLHWE1rDaX+X0FqaBtRmjGCFspnVaWvKfw==
X-Received: by 2002:a05:6a21:99a6:b0:3bb:2883:a723 with SMTP id adf61e73a8af0-3c8ba5b9c38mr8511518637.35.1785350081331;
        Wed, 29 Jul 2026 11:34:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7d64:4b7a:74dc:6d35])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d37368sm22611947eec.22.2026.07.29.11.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 11:34:40 -0700 (PDT)
Date: Wed, 29 Jul 2026 11:34:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "zhangliuyang.zly" <zhangliuyang.zly@bytedance.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: evdev: drain queued events before reporting
 device removal
Message-ID: <ampG4-NiSpXev-Vu@google.com>
References: <20260729092753.1596400-1-zhangliuyang.zly@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729092753.1596400-1-zhangliuyang.zly@bytedance.com>

Hi,

On Wed, Jul 29, 2026 at 05:27:53PM +0800, zhangliuyang.zly wrote:
> When an input device is unregistered, the input core calls
> input_dev_release_keys() and sends a SYN_REPORT before closing the input
> handles. This is intended to deliver synthetic key-up events for keys that
> are still pressed when the device disappears.
> 
> However, evdev_read() currently checks evdev->exist before draining the
> per-client event queue. If evdev_disconnect() marks the evdev node dead
> before userspace reads the queued synthetic release packet, read() returns
> -ENODEV immediately and the queued key-up events are lost from userspace's
> point of view.
> 
> This can happen on Android with USB OTG 2.4G keyboard receivers. The input
> core generates the release event during disconnect, but Android EventHub 
> may observe the evdev hangup/removal first and then fail to read the 
> pending EV_KEY value=0 event. The framework then falls back to device 
> reset/cancel semantics instead of dispatching a normal ACTION_UP.
> 
> Allow evdev_read() to drain already queued events even after evdev->exist 
> is cleared. Return -ENODEV only when the client queue is empty, or when 
> the client has been revoked. Keep zero-length reads compatible with the 
> previous error-checking behavior.

I'd rather Android handle devices going away properly. Input core tries
to clear the key state for its own internal purposes (sysrq handling,
etc); userspace should take care of this on its own.

Thanks.

-- 
Dmitry
