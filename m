Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBAE21578D
	for <linux-input@vger.kernel.org>; Mon, 16 Mar 2026 02:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773629070; cv=none; b=ISEThpuExkyXQ1Qt12fAsEDBbfNZmqAiQ9g/3hcUO4wgmcb2W0hxCOBhqDzQw6MmnuWdB2F/xY0iCshjJEg4recNhOjNNDjVFPFVucR+buR4PE3NDmXV+FgLxrqmHO0KYVHh0CaE/rON6G6YRr+xu0CPk2diqHWmcnqjiu5BW2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773629070; c=relaxed/simple;
	bh=PpKEBuYeYs0pjRivJS9LIQKda+TRZUg9Ie7Ang37SRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dRQRTs/6GXtGYmXsGZbozZYyquzDrUpgT3/yq29STdN36hVXUfqrd9DoEYoHTvZZaTKppiQNU0UynQOG+nLKOwy5Js8w0+sGeGUXFPpKuFzJUR4pmzihyY0ueRxtKZnb6fJCTj8z8W6QuHe9pdpgiGQEXLf6Oc4+aVhQqP/8/ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2wKiwvL; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2wKiwvL"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a1f549e7eso1810109a91.0
        for <linux-input@vger.kernel.org>; Sun, 15 Mar 2026 19:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773629069; x=1774233869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3syyJUxdmUDpDeeFSHzMSFyVj/PjepADLOw7BqnwYc=;
        b=e2wKiwvLcoL1Z1NivmPiaeoHuEka3w1lipO15V4j1oAXsZId1Dft7Na1CUguEV7ehF
         S30EtZwRLzlgoaC490qwzv8w8SToQZ9yhV2E4q6W3QkfHcgvESvhc5EDwlYLpAjFa78A
         L06L0dwgFQtRgULZyUyKgZpaHo9eduGdxw1x7BmMd5661lBFmp5CY9taKz6FtSWZ2BXS
         KBBKuyS0JSEWpX5ofZdsIy0+3uYBLVian/g1udREDdD/rezNECbfxgrrOWc6apCt+9V6
         VgRVMgGoJofH57OfMrYuaXqjhRCAbR2lCjmmct0PO1P56fbtfGt24Wh6+xacaeLzPeRQ
         Yk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773629069; x=1774233869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3syyJUxdmUDpDeeFSHzMSFyVj/PjepADLOw7BqnwYc=;
        b=SHGS9K1zh4M8+eGshG3TXj5qyxZizTsKIEioAc6gCl/0t2ibltJVQ+MYkLKe5OyYdT
         Z+B260odq/gzfhciere7dnqyNoXYELSJrHVPOFHJNKLng2Q2/ovOdAnFfX5rhcyJ8Alb
         pwwxwi8lclnMB6EjMC7+04Pb57t1ahJk8yhVtSi6by4YXW9ztcSBLmakdwtM++04Fpje
         sgmrd2N72e2kaT8aEs1ZYwiXChMknkkn96d3EdjWsJkWKwEoZpP1BxFmGddUGnjltRAt
         lFdCTzAQduHUU1twhz/0KUFRgTpFowcO6aR/av/jW1jIAbePonJso9RfHykozQOvTSgF
         ZeCw==
X-Forwarded-Encrypted: i=1; AJvYcCWO7tXumuY8Jw0sq/ITrGat9f6CbQE2QlyyfqidV3N4oiqghd1t+++VSEqAdij1RE41kzAY0aGlttrXzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZMGaGbFxVZaQRzxNo5/YO4cejpRjkDLwg9uirX6wCCdX7I2qT
	3AxaZTmDIZyptZrBXeVw5DNcNolaQLu9mDX7HW7CaYt1XDxd5nznKxI0
X-Gm-Gg: ATEYQzyxQ2s54/gvxYHq8Tne4um/4qfcqGBhjZugvQLD5ncaAdITgKuX0ptnXCGuhMe
	Iin4aHijebsZ1VOGn/t25g333mkZAajQUq1SK7MZORxdaiYnNMzkHugl2zjbCR7xsTDL0Y9kUNO
	6LSuyTARmF4aEnFjQOf+/Q3b4icBUluWzk768TcxkGcv1d8z8SjTUDuvmF/kKu+xfrVBd0BpEAw
	JA7OGjdsj+BVLjyE/PZxDNLHMWZUGt3qCNvGc+E9gOTru9pD6YalQSnOsaKmX3NPXPl/UWuUamM
	iOlEzVeZzTx71aqqXHmOn/uqEWVsiUJf0m1Fz7yHw0rIBE853pet1czqIyfPiw1PEEpKShklcbp
	M4fCuvDDGQlFzahz2Rrw/szHNuqAWo6Vok3Q0sa1ZUiA+SgpN5xpyLLR7ZRgm69jzV8wiSRx6sh
	ILCJY8wIuSJNFkjgTIJM1LOwapIQPvnSO78WBe1dlHzEV3Zeyl1sbkzjFKqsnZMR5kxVhgt4Y7Z
	a8E72zb4TqjGmSh
X-Received: by 2002:a17:903:3d06:b0:2b0:56bd:4140 with SMTP id d9443c01a7336-2b056bd4a3bmr22278705ad.38.1773629068996;
        Sun, 15 Mar 2026 19:44:28 -0700 (PDT)
Received: from localhost.localdomain ([14.160.25.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece8363b4sm89775905ad.76.2026.03.15.19.44.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Mar 2026 19:44:28 -0700 (PDT)
From: phucduc.bui@gmail.com
To: dmitry.torokhov@gmail.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	mingo@kernel.org,
	mwelling@ieee.org,
	phucduc.bui@gmail.com,
	robh@kernel.org,
	tglx@kernel.org
Subject: 
Date: Mon, 16 Mar 2026 09:44:18 +0700
Message-Id: <20260316024418.3455-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <abC1NfUoHCHEeZpr@google.com>
References: <abC1NfUoHCHEeZpr@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Subject: Re: [PATCH 2/2] Input: Touchscreen: tsc200x - delegate wakeup IRQ 
management to I2C core

Hi Dmitry,

Thanks for the feedback.

I will drop this patch and keep the previous behavior.

I'll send a v2 shortly with only the commit message improvements for
the first patch.

Thanks for the review.

Best regards,
Phuc
