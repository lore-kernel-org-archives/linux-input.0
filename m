Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B254B04B3
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 18:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854514; cv=none; b=OxWs8y+YB9JUZhlnRXAspLGaNEuXCNl5xr3fPBIw2BymOV6vZCFJINQmGRDQ7IYqgz9IezTctMTJBW7cQ59Kj23e4S7CIGkA77zXRryDeTF25GKYVAwH/ogVDjVuYmh/wLugZWDDyoI4uZkFqvskBfdiD9zryW2pgM64oIvff6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854514; c=relaxed/simple;
	bh=YmQyD7/4tLeVkJmPWIOhB1qOMLJH7j0iUgM4+DNA6Uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CB6r1dymQaPWXB2kq6oeq7dFBIoaJqwVZF/c7of0aeNdosJ833WswjcZZrodb6/LsH14knqi7BycesH49z509XJyoOgNxr7wmAjf7neNXIE0ex09qI5x+iwweZe/p7qqsQb6D8aeZ0FVh9i+PcJqr7w9+xFYGNCvQ9Znkau6hhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmAGiXJg; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmAGiXJg"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso458665e9.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 11:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787854511; x=1788459311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YmQyD7/4tLeVkJmPWIOhB1qOMLJH7j0iUgM4+DNA6Uc=;
        b=mmAGiXJgDHM5oTfvBo33W7mCuK4DfoqxrkI8QpITmmP+txg6QCbukIixHpWpEsA9/Q
         yA7XtsD5ChMCcMloFTOFRMFWa0lZwRIEC9fdnwuEQ32WxVi7J1J0YhmEQ/NdQUWdQiSX
         metBY5HkIRodpEVL2/+6Xf8TTexk5a1x5BJRds8keAytdcbie5D0OaW4SBDo1dZsXmqb
         ZLMBwRhYKL/fJscvylcycZH4d9N4rhxSCS39zIkwazbNTfLyW6U/FujOCFmrWxti+eK2
         76fzks2bPg6sI8lgKVnLFOg/9tOZwlcmXUzjrzRl50+JEWtpXgy+W/d28N3C7u8mrnOe
         prlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787854511; x=1788459311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YmQyD7/4tLeVkJmPWIOhB1qOMLJH7j0iUgM4+DNA6Uc=;
        b=hONK5KHFSqp87fTeCA9TRiIBpNpHxHsdSHP/sz1yerk/oYDfUV2hOCCrF8E3BMeon/
         mOai4tLZZ1NJgxjvSY6ClcK9bmqYa2PzF/27I0nXV6TG9zTLxT9hu13FYfLOBillmEa4
         GfRcxZTplt1fv7K1zEv6XP/5xMa6jEoZFKcz0BE7QjFlXX8KeO52+QEBsFcSTOHKwzsj
         QL1OG1QunAj4O0M4YiWyFfYMQzlOukVjOl1Nr1H+fem5bavcysB0YLWMczg9BE0i7nfV
         vj1QTClo56fYOUZ5SveDz/Vv3AOuUjARpqzjEEdsVcUswLKuKRx+a11rHL/F2AOmqHKY
         thuQ==
X-Gm-Message-State: AFuF++nXmLsNOj2GVSGcaXG4Un3vYZK6yon/mqgOsK4i1vMRJlmPBLPw
	F07BN9AvE8GZFhfjE4JdvZiLwJabZ/HVKvu2DziSd1RtGpErk8Ekk5Hq
X-Gm-Gg: AR+sD12dNwHGQ2e6T8zk5Cc5r75kxhCnKm0q7Cirhi6YuhUJ2SyZy9vzIVXLT8774He
	+9dImQFy42JxfAGy0TWvHGntudP9zY6uqi+2W+bdy6XEcrVXNExf0rtWNqI1bnubz9N7/OIYrp+
	n72YeVs4uG8dDB1IdkxDZg14WmhXSmLVWOeDoiJO+UX//Xy3QMWMHCuUaH8MocKmHMiTSPnGBnA
	8orMcnR1ik4IHJq9P8sVo6TDeMT9iVJMJOxhk1sheNE0KBTKSEa8Fj1zjb4TjD0gFW7Klb6F9i1
	d9YQgQStfvvgwlrT/PHLtKLBVjLS9RtoUGFD7CnIX99YKVwDvLRPqxAL8DCOc0g8ATOg0XaeIRh
	YSrFuMg15cu3mER/ks61UuUP0eBvI7kFL9VCM4mnD5/+NMBMjIWwtVn1PJ7B5pPPxXCzG8pf2Qg
	T9ub3JX/sPDEVFn2+N0IARvgzFMeXWrTPOXzSLUKWE6OSApzAPYBX0pN/bXmqNCbS9mXZI0oYEx
	GHIdrdEEJ12i7LpLEl3nFLjbF60mMgonjgeb6TlYyBG
X-Received: by 2002:a05:600c:354b:b0:495:4d88:e630 with SMTP id 5b1f17b1804b1-49b91c4fb4amr10535475e9.10.1787854510977;
        Thu, 27 Aug 2026 11:15:10 -0700 (PDT)
Received: from 1Z10 ([78.213.170.242])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482e279e391sm10333386f8f.2.2026.08.27.11.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:15:10 -0700 (PDT)
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Heidelberg <david@ixit.cz>,
	linux-kernel@vger.kernel.org,
	Maurizio Casciano <mauriziocasciano7@gmail.com>
Subject: Re: [PATCH 1/2] Input: drv260x: Make vbat supply optional
Date: Thu, 27 Aug 2026 20:15:07 +0200
Message-ID: <20260827181507.2425796-1-mauriziocasciano7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <apAWXyPRtSe0Uk9_@google.com>
References: <apAWXyPRtSe0Uk9_@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Agreed, thank you. The supply is connected and managed by ACPI/board
firmware, so the dummy regulator is the expected representation here.

I am withdrawing this patch; vbat remains mandatory in drv260x.

Maurizio
