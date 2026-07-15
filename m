Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3024963CB
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784145861; cv=none; b=G+DCEU9beCoPN3PmdrY5sLCkwB2+Z8ngS8MOc7pHiJPZzpRBEyLHDqkAKEBUhTKNXnmYoMvyt8G2iGjD+vsmBdaNA25eh+Pa961Z6rxAwIjHS/dkdPTdjmdoskR5zCgCnwc26fzy5p4HyByBSK6XA9FKJPQ6oFrlFI+7xHHuhJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784145861; c=relaxed/simple;
	bh=AsGw2cfLkaONb+hz1lp1JsC0pssrsQjFnxY03Ut6hJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/gHyswvdHcPwW+jzxo7I3i2PS/+yxvRmDWBkkYvNFKyx0DFUYTp0mHZqhlcCt1qWmi9nwy2OC62ydehFL7kUurrcuGQwdoKBwbfZ8zCyM3SXBo0UGptZLKSvfwOh97jPz4cM1c2kvjZQNe8bExmVlp6nytTQNS9ccdSAlMq+pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+UDWPTv; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+UDWPTv"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-43b7e186a0cso2110331fac.0
        for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 13:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784145857; x=1784750657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AsGw2cfLkaONb+hz1lp1JsC0pssrsQjFnxY03Ut6hJE=;
        b=f+UDWPTvhTLvpaUFs5mAgdRDEibmq7Kap7Kuf++80dNphcX/o1qi/AoIc3Uwk/Xs9u
         l/bkQ4GP4siHpfg6uZV5RniWK/E03Z2Z7iGPnUyyB3INk25DKurjj15ebPDbzdtj4zxt
         xbQnNDicuc0IZg1M9IgAP2YOSyd5iRCdS5RfnSIS3A2f8onsbvrJx47koEjlPb8sdsGN
         FXy8cn7ouNUUDpS00YwivHpmiKCvJ+UjfweLWCw1lCeCpbVKLge28ELEb6yj8tuql6en
         l6BTmIFRYD5rp8ImGVvrP+KfKB6BUb4OEgaIsyl0M0z5AaDkPIkjJTO3ddjNH6MCcGWc
         g7GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784145857; x=1784750657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AsGw2cfLkaONb+hz1lp1JsC0pssrsQjFnxY03Ut6hJE=;
        b=J2unc1Du74H4g1FrL6Vqzi0YcEw1neNMJFKvSaNaZYecYQ7ztVoFOWpa6zfy3Z1CZe
         O/6C4q9IlJ1cFqybq2uPaYGYga9uirQiXDeLpGw9BlfdpwxZx5HG0u3IE9wMbJG7Wjsl
         K7bafYSU5No2L6qYCCBuN1MQj3feblXtWGlji/qnJDVswNHaNavffij8En5E+rF4kgwG
         eR1GdUGKRRhruoj7kkTUhMZwKw8v0rqeDnfFnKR1aOxw0uLexCTMXApVsPf9om35/OM0
         rWfJ74DGGY1EHKDjp3MEMx5ZKHiYWR8QaF6C69gomwTQb31p0WG15IHviYTSDdPVmJV8
         R3cw==
X-Forwarded-Encrypted: i=1; AHgh+RoabnmulU8+8oKOb79cqBA/noqlcirUxLBOSgZ6E8x4u4BTwzsX3+9XoswlaNOZ62//4I8SrjuArOTqmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyzuobqdrJ1U9q8WKLSdidu72fMWCnFIvn7NgloN1ENa+M4vAwf
	sfscXJ5eK4kv4bF3UNs4rCdZ49+LoWMbos6ZM3EJh4WBMwhA+pJGZFtf
X-Gm-Gg: AfdE7cmqbApOftIuLoM//lB0hHRavV5o58OircxEpl6F+0C0dZDobknpRFX4njgB3ER
	Gn6u6sdTP9/cMapKb/XkKJlPWMcZRalkI1gurCsqvjFBJkzfa6y6kR14SFhchqzulEMc2uAsuY4
	c3tOgP23RV1UxJ9OavCNG3yYl9InnvNjJ3ra/Z5VewFwD3EP7OYQsL7guMUHjlY01zJXfZW6J5j
	LWS2lSMLlnB/OZDzcQwdCY82smrq9Ztkn0B7eD3U70XwpP6vkYNWJiN45P3UFlV8oEpluIlKpPD
	fs1nnvpfhs9UqC70yc955vr7Q1XNtqR83MyI7j+hak+1DstfbNYzclbYB8KYjHJXVBtxp+APsU8
	hnNNCdSsPQWhlTJJrdi/RPLt3bHUq6/MQU6xh6Gg1zLMg7cZbOsGBfj9r0UL/4hsXGedTJ4EGrF
	XiR0a3rH8cu7IQ
X-Received: by 2002:a05:6808:f8a:b0:4a4:744:a4ff with SMTP id 5614622812f47-4a495ec0433mr2616051b6e.4.1784145856699;
        Wed, 15 Jul 2026 13:04:16 -0700 (PDT)
Received: from desktop ([2806:2f0:9260:f072:92d3:78b1:9863:130a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1ad6b73c1sm16842969b6e.7.2026.07.15.13.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 13:04:15 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: Alec Hall <signshop.alec@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: Re: [PATCH 3/3] HID: magicmouse: report charge status over Bluetooth
Date: Wed, 15 Jul 2026 14:03:54 -0600
Message-ID: <20260715200354.1307250-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260714101235.99447-4-signshop.alec@gmail.com>
References: <20260714101235.99447-4-signshop.alec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Alec,

Thanks, that all sounds good -- if mine lands first, great; the wrapper
split is exactly as you describe, so rebasing 3/3 is just relocating your
report-check hunk.

On the NULL msc->input deref: good timing -- I actually already have a fix
for that one ready, from digging into the same Sashiko review on your
series. Rather than a guard in the callbacks, I went at the root cause in
magicmouse_probe(): the USB Magic Mouse 2 / Trackpad 2 path returns 0
before the existing "input not registered" check, so I moved that check
ahead of the early return. That rejects a device that bound without an
input and covers both ->raw_event and ->event in one go.

I just sent it as a separate patch so we don't duplicate -- happy for you
to review, and shout if you'd rather take it instead.

Thanks,
Jose
