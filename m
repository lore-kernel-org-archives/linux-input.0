Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743423EAB2
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 04:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773203330; cv=none; b=HtLTzqywaJTnsAPUeY0uAgd/7rDWNoFml//cetyhzbLxHGYeVFOZ1YpEDBLRBw6YMimL27hM86uuxs2L/V/Ekzc27DIKQhk/WKBTqAH8HnGySyplN67Wa7bApCI6H1bbw5G68Zv/bT+qXIUOXGsIClXwe10VC7X16GfeoM3kB68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773203330; c=relaxed/simple;
	bh=ay7kLC7nSOMoueeuZ07rwxwG7DCmth5fcpnKLvgPIH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ObZAS6BoU+oHJwEOgkpayuWC++38DBkIUv80F0U9YUqgIFQQOrozt3AidqeboaJ6eN1h6oXoHvnDxapIYtL+W8HR5WxhuFvFFn4kEPf5+vf+wsdwEkYKydagHBD1KyHv4HYCwN+ESaydbYSxcB4h/yxeRbks1dFl5u4nT1Brh4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fIImguK6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIImguK6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so8350840a91.0
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 21:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773203328; x=1773808128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ay7kLC7nSOMoueeuZ07rwxwG7DCmth5fcpnKLvgPIH0=;
        b=fIImguK6zYCfpwa+XtsVjt7lUYGrG8nEpJRwKzl+FL8fz89fgoxc9QLTJ65tLjR4Qh
         NSwC2u4JhpDw/gno06Zk+tMm4r4TU5k0I5F7r7PeUQqEQqivcBo+WtU2Yft3QieFEEF0
         gtUkeCaPlwkDpmrvLEVpzfgeQL3jdq7z49dZ2q3ztt55UOv37wDxIJnWKTVRnbkNy7ll
         H9oPNJ8+aqIvgiNUjPOtF6I82Zfn0yAVhebr0SlnjFCI9bQ+jDzyvPjhZM6LNsIFvVb/
         NQWNoaHdwAs4qg34kCHkpZz2T04iYf8CTB53SLlKsrUZ35b6Y7xRmM3oVl/RnyWlITBR
         RMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773203328; x=1773808128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ay7kLC7nSOMoueeuZ07rwxwG7DCmth5fcpnKLvgPIH0=;
        b=PoNWqYOk6PAdHsVRPUXt72u+5RCEBz4Adw+VVRqAtgSzTaI/tjW2Z6BdYW/j+fNHXF
         DHeKLJ35EpxrMje5feLLYcK/XZkAGFFCxUSW3mnKj2CeDdlttiyB8gVMNJraGzf9C6D5
         CPwweBrfyh1s10JWufJ/XSTYYA86T+uSc5bdxYumpxhlb/mo4behHX5KT8PuuvT493GS
         I9appvl+waf9saYSTOC0+LZYBJHCrH3lmNng4pBbZI2qhDYucJb7gVkK4FgUlgstr+t/
         /cOXXUH8IMv23jKty8i+WI+fKWRxRSTPvSX3duamWDsKDoaC5faD1Ii0y1FcETKvdCSR
         L3Nw==
X-Gm-Message-State: AOJu0Yx9Ppy4uHfh3IvgRR0SImyRqnjHgDSMGgdOqwRxBtAeOuijnyw3
	6zzgxdIXIDUTTyxrtqjj0ANKTCVwh1t/etDtPTFjZfULLFWfuwc5xAKp
X-Gm-Gg: ATEYQzxnG3KkioCqoIwcy3nouoM0XZNPy80nAqrr7cJiz27LLYHwycHY3Y7BE31hNz9
	n6EadcRFNjmDsRSppZXEl70XXHNzDj65Y5Jus+gUS9hjc4iNLBijI/FFSOY3wepRv2hP4bKajDG
	uGyhVz9RNeBxrn0hg8fgqeKh5mGgNP6mtNJUBdl0fj9v4xecPZonOLmVydsYwxUN9PdCslbfkxo
	k1hnY3z272tJE5M2haKB1KIHnp3Paxqb+Fwq+//HN2pftgLo1rDIsMU5j7XuJX5N3xozLUuYXxj
	fY4V5cp6oAdahZ5KSSD9W5HPoC4FoczltBIYF4eUL3KCcyuN9j892EW4yeATsIhtCbtiquPEzz8
	iorgnjNUpfrOAA50y52ZURjBzJ7IPsNxakwQ3snD3SlsbqhmhKc7bt2uhi9qgyse0F7qQB4WYSg
	sVZcU547SHVle3rISuwcwsCDvLGaz+KUYuWGqn+RJNnd5htZ64crx+hwuJPCtW2Hx4S/QsY13gL
	Ow1BA==
X-Received: by 2002:a17:90b:4987:b0:359:f7d2:a1fe with SMTP id 98e67ed59e1d1-35a012248e6mr1204164a91.9.1773203328463;
        Tue, 10 Mar 2026 21:28:48 -0700 (PDT)
Received: from localhost.localdomain ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e660dcsm677629a91.5.2026.03.10.21.28.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 21:28:48 -0700 (PDT)
From: phucduc.bui@gmail.com
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	phucduc.bui@gmail.com
Subject: Re: [PATCH v4 1/2] dt-bindings: input: touchscreen: 
Date: Wed, 11 Mar 2026 11:28:43 +0700
Message-Id: <20260311042843.2468-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <abCx6kZkHPd3lYh9@google.com>
References: <abCx6kZkHPd3lYh9@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

Thank you for applying the patch.

Best regards,
Phuc
