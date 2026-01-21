Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9536D4F1
	for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 21:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031728; cv=none; b=pUfEE4TWEPcGnjMEqxP7hWJ9YjUa8dnO2Sd7JImY2fXwYU2Ft+T+dOP/YMhriTlsWQGcRNhYnQduzzc0BjK6TOdEGdESADCQx7xko3BSpfE1cJXmF+j90cQEXXx+MR3aDOtWkv0IUPRYJsa6KgPzeqQjHi++NT6ULmBdNCgcX4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031728; c=relaxed/simple;
	bh=M8oQ0q+6xlkrire61zib4w+js5dW929OXGx9RGG+2sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IksUVQkpDOZd7gKpbMpHzhu39C7FIHImZBY2Y+P2jhKfkXmrcCG4HQBSZlSXcqikAPMQ1i6rg7/OUZx68ep3kwx5VClg/fIuXiK49vY8e1y9HokS9Cm2NzJ7Oh0TY7gkw8Hpoi4qQ9g0kT+UFPkKTe8YTxpJl8yEl0iDQf8L52w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYmo5QcF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYmo5QcF"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso2938645e9.2
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 13:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769031721; x=1769636521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70Ms2GnAoWzuHwMSo94L5mFs+gfdu8prUboYjtNpRhM=;
        b=UYmo5QcF5pFdAcwdyqDg6ZWAEJ4daoPtp+fD5feknUNJgYsV5TTaEzKte7nbYcXOwE
         7KumauM4fB0qXX3IWj2adna7P0OXrdouKdyBcCpl/v9NR33CtzJ0yALMl7kf5IApXTlJ
         iHXrAD8SL1ctRMive3NNel/F+DkswEerxm8q9F8c24RHPG7Jj7MYe8SF3BL0FEozlV19
         2fzPpZoLW1do+oYjLp75Hv35ph5BMTc0u7/7aUpSQ01a+UsXVShvzDQ49Du1egBOBriA
         Ga81lUoPTCwbTyTjaC7d/z2uvNRCU1jVtKk+a04zWkmOvGdnm+pInFoHtUljAXSnj3Eu
         vuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769031721; x=1769636521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70Ms2GnAoWzuHwMSo94L5mFs+gfdu8prUboYjtNpRhM=;
        b=DncV11CUA7S2Umn3DbxHujRKXx+wN99ZDlV2AlmgymaM1mHQ033jcsFZNgwR9YEOBh
         CGGGzqgpWEI5ilqIYms3L2Fo1wR5Y/9bs/LJyEIBsUlCuMBupFmcxK209YE6Ei5OYDZN
         XCY/OSCQRL4eh4ezosIFdlTHUyT4GvWWEYUAcj/LqkPkIEglxgbMqdnTbi3umZ9RbpMW
         AsLhkV34WrvL88mi7GWo3ETI7BzSVfADzZ5IXGl8roXvtsTVYuBHBWBZZyxteju4yRSY
         zJTN+3ZBAFNxMknyootwYK8PQJ6cueHnY3zHJpnglvIXyNbqlS8RrtMz7YobnzX4d+HD
         +2BA==
X-Gm-Message-State: AOJu0YxIrUla632UH/0T29XjPqxVHLHm38XbQnvgtMNEOm+6r69wXP4M
	kW6E+nyii30zeMRdZBxdqiQ9q21cUB8b7PZQW9X/Zma3Y1rI0/WkMoa0jDVf0DdA
X-Gm-Gg: AZuq6aL9PN76te9tq+p1pMLtrBftb6qMeNCcv96m04vekU1Tdtj3bngi4e/DCysPloH
	I6e896G+hiOg2D4h2gLXAZNjAq0s/SPqAVfD/DjTCgUU3hiz7POXCzOrVEbA2Y1VKsrUgMl3YXq
	ihff2ld4YckKKUyQ/guCo1ykL73lzrIDJfrt0s/S0LKeZbei3Hr69tbvrdQ36UGEXedtAnmFH/G
	59AASByb9uothPl6afLP03+N6ZyOqkXp/VXHHEn2sWAVftJNu89LaUfXG9QPMOUbGRIuDZN/vlK
	Xl7TpGIi4RXKwV0944JCnnJosGo/B4nidtMq41loz60eA6POUIzyx3Kr7FyvBan54vo2rTqUOQk
	11XVqk8/JLddqny4Pb/0e51lexEAhFH8e9bZ/0NkwfWDvfEWtxGUEgMiNuRKxstMH8795GpGlQl
	8RWBNf3QF47Hpr5eCcHuiTLUZS
X-Received: by 2002:a05:600c:1990:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-4803e7f3d7bmr101505225e9.32.1769031721019;
        Wed, 21 Jan 2026 13:42:01 -0800 (PST)
Received: from unknown.tail46804.ts.net ([78.209.83.30])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-43569926ffcsm38351929f8f.18.2026.01.21.13.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:42:00 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: linux-input@vger.kernel.org
Cc: devicetree@vger.kernel.org,
	krzk@kernel.org,
	dmitry.torokhov@gmail.com,
	Gianluca Boiano <morf3089@gmail.com>
Subject: [PATCH v2 0/2] input: touchscreen: novatek-nvt-ts: Add NT36672A e7t variant
Date: Wed, 21 Jan 2026 22:41:38 +0100
Message-ID: <20260121214141.36858-1-morf3089@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260120193600.1089458-1-morf3089@gmail.com>
References: <20260120193600.1089458-1-morf3089@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for the Novatek NT36672A touchscreen variant
found on the Xiaomi Redmi Note 6 Pro (tulip).

The e7t variant uses a different wake_type value (0x02 instead of 0x01),
which was causing probe failures with error -5.

Changes in v2:
- Removed Closes: tag referencing downstream repository (Krzysztof)

Gianluca Boiano (2):
  dt-bindings: input: novatek,nvt-ts: Add nt36672a-e7t-ts compatible
  input: touchscreen: novatek-nvt-ts: Add support for NT36672A e7t
    variant

 .../bindings/input/touchscreen/novatek,nvt-ts.yaml         | 1 +
 drivers/input/touchscreen/novatek-nvt-ts.c                 | 7 +++++++
 2 files changed, 8 insertions(+)

--
2.52.0

