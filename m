Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468F841BA7F
	for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785273883; cv=none; b=QIGF6Ui2d2/PF/QZ93WBXNaCJkrBMaX3KDX2QCv0dXkuvsC67KgQBsNW7OzV+Wsn6F/Bf1mX+quEExhtEQ0PDx7BZ/mgJbxnspZQvyo6FEeUWNJ8rG6vLAxxOkl0zEPB6NNKveN96m+3p6MH/lnUVRY3RRnbo+YW9MpFy3lUGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785273883; c=relaxed/simple;
	bh=/vvy3k075P3w9kqNf6MtDsYcYu5igFK6uSufRvYshc0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUov3gtA2N1P4k8Wt96gakrddRKL80TA0twX/XKlp0AdN18oG6oNB1WyzCVznagLhzWQOb/B1fmjfcqsb86eMkTMLv1Y3N5kT/YYI8hLT641ns7N+1Q3fU1iCpsV9/H8pcYCZHLl0gmbAZXx6uvnfiMKLDWphmHrZvimqTY4SY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwmajiTN; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwmajiTN"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485ef63b68so315333b3a.1
        for <linux-input@vger.kernel.org>; Tue, 28 Jul 2026 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785273881; x=1785878681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RP1icAzXLBZOEuHs6IcxkLzVEHKGI5tOjFuXZMBauq4=;
        b=mwmajiTN/Hjt/l5jzpL9dGj5JwtguUS6R87Rt+47owOFouhTDv21mrjK0xWHv6wxoy
         P7Gn6DfqGikrxt0vpyZDTvAOldXksi9GSsR8wc+kdr5DY9aLHsRiraD0zsq8eMybkPwQ
         Kv0tkw23I4sW8UjDglXKkxQ8hoVPjrootkSLccQ19Nv3HXIsdJIR+oyue9SYouhMqA0W
         EDDtNUOSN+vlORblpGysLRKKqN4QruoTZ5edooRT7wIg08ahOKj52clefWqVo1m/JKi/
         rFvFILr7APSm+2VJL2M5ArQ2hIu8HQs/bvPPQSfLs/CZmKx9aw9U37WSg2urDfrK4bfU
         cVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785273882; x=1785878682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RP1icAzXLBZOEuHs6IcxkLzVEHKGI5tOjFuXZMBauq4=;
        b=AaODgHIM97+5X30wFgpGaVwbqIzvQL1grk35MYnW61uRskqpbAFwGjtnZTm0TqfOvp
         S8JkaCoYmGeoSiMSSJl1dfgCUV/ZARFtYwxCjdr+yGPVljFme7JIjgNS6xD6mb7zON9M
         BaERo7XVEQLCx/xZ+afZb3SLQVqn7oLfM5bG9xZxa0Uue5rnS6MMBaJiv8fD2YmnqYRS
         coirKrBQr6arW3O5U+ylsI6GdI0Ld7YYzXJMbTIK7GBUlVy+B0xlrMbbWi6Hs7Jf/j6m
         azoDb715p3hxUVEoZxDtAnKl6eo9Yv4R/3aKinSPy1j0f6dYDUunxQsUB289a+KoK0wB
         2tPQ==
X-Gm-Message-State: AOJu0YypKoJHsHEDutm/YtJW77NSJWQ2/ZwgUVqeuicqkPgX/8r882Mj
	8TB5fblfdBR+vR+13HMjjmSlAQrwCxMTcizuqOZLzDsfM6I7GHAIz7AQzYLzqQ==
X-Gm-Gg: AR+sD10+THUEsaOYTTLH/8netcljFauG0HjBhSbzpiorEva8dwAIL0dsMeG+Lw5end0
	aevMDGZof9RYM8iHQXyrI35NRUgQ3AI/4KvEau4bnH97kBASJYjEDbke9awyzUruJY48YWV2VZy
	r+hbrDQ6DDRSJPPwJnOBqJq8xy2SpmKjc+i+nUm6Irc9WXanunGXUXymdq4/DV+Uykl0VGhJ1JL
	S5RcMWkv6w/dWLhK8K+hqcxF1/TPTa75X0Hz+QkOndQih7zJ+kmyqGOsLW3SPirS3toIONbKBgh
	Iu/MjoxbK8PS3d27m/yvWRXmOgWWG7/0mGA4pAkA7GBgRUcAiSMEb5fpPO85mbzF122h9MKjz0B
	SRAFEq5fDTvLfXRtaKZQHPzh8zg40QjU5oTtHN2E8gN8TFX8X+2ODGywOSi8RVJjgcvJCGWXHBX
	Yt5oE3fXz2MbRnLyMifuDBkzyfAR4EM3x/CDoIgKIVFChkLxfyfqxJVve19vUj77bTSpAhCvXK4
	DkN7/HGqafcYqcHPWRj+i7d9gHi2mWokszOQQK58PiT7EIpgqo8Z5Rrv/T44KHbDSk7JRxuNIXW
	NxGUIW/iOFfMV4pSGrH1UwYu0Z4FaQuvYjCt7WA=
X-Received: by 2002:a05:6a00:b50:b0:848:19f6:4dfb with SMTP id d2e1a72fcca58-84e9335a753mr4385834b3a.56.1785273881527;
        Tue, 28 Jul 2026 14:24:41 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbdb83459f6sm80892a12.14.2026.07.28.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:24:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support)
Subject: [PATCHv2 0/2] Input: mtk-pmic-keys: probe cleanups
Date: Tue, 28 Jul 2026 14:24:36 -0700
Message-ID: <20260728212438.54078-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace an open-coded of_match_device() lookup with
of_device_get_match_data(), then rework the key-counting logic
to iterate child nodes in a single pass instead of pre-counting.

v2: split patches up and add irq checks.

Rosen Penev (2):
  Input: mtk-pmic-keys: use of_device_get_match_data()
  Input: mtk-pmic-keys: Count available keys during probe instead of
    pre-counting

 drivers/input/keyboard/mtk-pmic-keys.c | 76 ++++++++++++--------------
 1 file changed, 35 insertions(+), 41 deletions(-)

-- 
2.55.0

