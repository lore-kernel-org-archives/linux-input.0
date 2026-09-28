Received: from mail-wr2-f38.google.com (mail-wr2-f38.google.com [74.125.225.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09CA30C619
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790619433; cv=none; b=XBRwtAvL4RCFU8+xLnKkHuR6bIf/VlZIyOwF1URi9vuwNzL9IKfOPvDXiOhYwfraGJuiAFdVOWpGZbogqN9RTtA3HewDDsBhH0lpgdUPspdbqzla9NAIgAmQEFWApryKnL2QICr53VkkPujcKMQoFpf/G5pAg4WeBVi+z+O/r0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790619433; c=relaxed/simple;
	bh=LBceeQL6zeowdtsbVWYN2KERwU9s973+eLElj1dczx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=miX3LXEN7r4TOXACjSN2kCGvdpqpuF08uZ8whc49Trx0VwLLNtIUTEfaWIPxBBmdQPTU1BFwqlRrOtE3Hs03WQWw5VgCvlE1sS5t0ALXfpQQjx4kkY+BrudgS+SwExNuvGc+G2FOnRPTyyv0ZQje1eGqGrq0NO9gnMS41i42FjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRvI5f5S; arc=none smtp.client-ip=74.125.225.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRvI5f5S"
Received: by mail-wr2-f38.google.com with SMTP id ffacd0b85a97d-482f6350f89so2129093f8f.3
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790619430; x=1791224230; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LBceeQL6zeowdtsbVWYN2KERwU9s973+eLElj1dczx4=;
        b=WRvI5f5SGGD8V2mJ2722ICmkaWtt2rWyIeoXQd3+wII8NtKWmwWsMKzmM9n+sDx/IK
         JQG3ol2rskRZTQawwZWuaZSdVcjCJEEhlmCC7OLDdE73esOKHIRATyiFnEedAari3Kaq
         m7/AfElL4aeYl7KfyolRst+SanTnZkOU7USNbY+zf4fSadOdMilqXQ3yuZL5DrbQl2YY
         vk/+0f+maqWpLvdpNRerLzAWJRRn7sBabzrlPbzbxydx/EGy6UxG9E5uclrYdf5Dba8A
         lKn11yStzs2hYt1i4LhvjLl44Y+zu7j+4lCMumUhGK/veGefIk5EylSlpLrdKIhDYjvM
         iewA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790619430; x=1791224230;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LBceeQL6zeowdtsbVWYN2KERwU9s973+eLElj1dczx4=;
        b=hJEMAHdQ7QIpVRNjkd61+j9FQh2gH/uh0qJljnOLKqGpEv7LBezrqPbzDx7fvPyelJ
         1HHkGEOs7AoP9VzwRHDRP8i3I5clDFK3teUKyRBSnwu43IfK5xLVwiERXZdAxfjoWniv
         rcSvOZUPYJxtH1z/ImVSFIGQpE4ySUyoV5rI9f8pzff7cRBrZj++NyM6GSZBaEJl8bXj
         jVdo8Fup4QarRoyT44EzxNX/g4ktyLA4vGPjF805tK+Sd7i9INdZgwEy8mentsl3Io56
         A27RcAigD+d4Kqm0ts6AHwImq3lli9udrTeJE8zfh4ZrI5YDMBAi+xkh3RCyMaEgdouo
         r6GQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrGPgXVT1gz++iqlQOVQxcxJE+WF8bTWYDnXo7ypH1IMGhN1dFSyxfV3w5xEIrkgoewEMiSzlZiDZfWQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJTAL/SEeWyypPYF2BlY17wDS0QAUppy8Jd9eyqsBtZOnvIr6mx
	0BSiesV9OjwlfSgUcx1dTsir1e69sxJtWwTxxZsBj4dy4VAa4T2pNkI=
X-Gm-Gg: AYBFou3KqM7zKvRwT2jnM/cQMB3iNsCh17aI4ExgCg/lhxDL1q6QMTeZ/0jLqLMcArC
	1lmZDcLXdK3RJc6Iw1R+ib1DxLZQy85q23JtKI9B/dcrujnM87NaDUH/Q3GnrOFgPZsk0xhomTS
	3j+swCmT6sRrEVfm9JA71SHaHwgxUuvMyxopFtERicoFvMT5e66YIu/4bgKqyiGTjqStkLb0gkB
	QMt44RzXxkU/tyguDmbBzdkqTEcV0gBMTm8KhkM3yRurooRDQ4b5GUiPCPeEq/i2BW9Uw8RdKI0
	uCbJPP/aGTQaUk0MMh6zD9hA+UUhQilv94nnEhmdv1+rmcRXBru1/dUyVsZxzRKm8ZC6oBnNAVL
	+KyNKsmRcNNsfASZz9v4nE9gL2Kd5UiLjtP6cchm8jVziax8DWjRC373aFhEVAzW6L1W3xeNcdg
	LsKTgObjtZhQPFykUEArwTxU7unaL9GuZpO/kwi49JABC+VQVEBB5dK68h3ptAqrE6dM/GKwfxw
	QVeQpot3HQTKx8L+d7Y0bNC27LliADVvuTQtP8y+F4U4NPaad0CR+sGZXg=
X-Received: by 2002:a05:6000:27d5:b0:488:8525:4985 with SMTP id ffacd0b85a97d-48885254b3emr10941836f8f.24.1790619429708;
        Mon, 28 Sep 2026 11:17:09 -0700 (PDT)
Received: from localhost.localdomain ([31.223.84.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a6470b7sm29540093f8f.27.2026.09.28.11.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 11:17:09 -0700 (PDT)
From: "=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?=" <habilerenturker@gmail.com>
X-Google-Original-From: =?UTF-8?q?Habil=20Eren=20T=C3=BCrker?= <habilerenturker@hotmail.com>
To: sashiko-bot@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] Input: fix potential use-after-free in input_devices_seq_show
Date: Mon, 28 Sep 2026 21:15:24 +0300
Message-ID: <20260928181704.61015-1-habilerenturker@hotmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928172128.D6AB41F000FF@smtp.kernel.org>
References: <20260928172128.D6AB41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch is withdrawn.

Sashiko's assessment is correct. input_mutex already protects the device
during seq_file iteration, so the explicit refcounting is unnecessary.
Additionally, the patch had two bugs: a refcount imbalance in next() and
a missing IS_ERR() check in stop(), which could lead to a kernel panic
or use-after-free.

I will investigate the actual root cause further.

Regards,
Türker
