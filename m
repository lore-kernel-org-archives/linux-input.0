Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486FB2BE04F
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 04:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773202977; cv=none; b=tk8BcGWndKW49+/DCE58O9AlVHOZbVBL9taZBMvPqDuqaSpiqYh0k7qewihnU9I6qZLg+Jqwl+pGTcS+PrQdXAX/IG8XIZZnu/+9zKcPxVTS4atEtSO6eyceg4UKqzVbSIZCgL/nzEzLgKTi6Cul41TFV5rS7mAxZ665ilBfuJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773202977; c=relaxed/simple;
	bh=mBbE/zKBLrYn8rujMkLRaCpcpIa4S8HOBGzlFgBZKaA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cSotwxRbG7br2dVgpNeBquf8ERSfoZfhL0FPz9RfI8s8Gj3LT0YSG/dzlRmBsooQJHxvcj+uOKD8sdnnpIWAqBm824fOGbZUo1U4aCeaDZa/MeaCOF1J7kWJX6Ykf8TtjizTkPF3LvhIHlxinXfmjj8LKDLsQ9iDZ+QYk7KpQmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DX7+ggyd; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DX7+ggyd"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3598df39444so6522101a91.2
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 21:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773202976; x=1773807776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mBbE/zKBLrYn8rujMkLRaCpcpIa4S8HOBGzlFgBZKaA=;
        b=DX7+ggydU2OtpbcszMQPoJqAOK8nu/gHfnYMQUEUftkjpk2HvK4p5qxLRHHHPz1J0y
         2I60PMXTAgGXoQQgcggz5G8Nx8mb2XfS1C6Ib84LxdJ2LLoCBSMJn0jsmgzOi/lVS7a1
         8fstk0rFrGsQHJtv1yjaXVK+VwOD9KJiCCgkFvW+Xki6Iw+nRJnUDKveiIjDlJl8mh2X
         JEMaTqS/mj+xCMRyaBIxjWH5eNP5cZyWOzOTHzDNToGnOJUK3hiGGQkMeNQaOt6cwrzC
         ckL5q6DgUx4wuO9lK2igCWiVga6kC3mlXFvXlE03ZyhJTiIr1h/xY85fHLTgUuTcWwth
         K9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773202976; x=1773807776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mBbE/zKBLrYn8rujMkLRaCpcpIa4S8HOBGzlFgBZKaA=;
        b=I8mDEhD98Vl90d/2Ti8uSNnaGWSKW8D56Xpe3CHhUV8sdns6rORK/rlgV+U/4YeUWK
         RZ3NqC9s5XmCNNdnL0MBHVi5k7FQBIhJRr8ba+o6WUQ2H6AvnpC6o7D+2BjHEdUaTKXk
         c3c7dHhLdPcWEhpcN4mXOTO98M4pOG13aNvSU6efde/2XniNgbBLH2FW87QIWPHdYVhD
         P9rKFFfCesLRIadJqrIeaaHHfylucQvt+mLcO9q2OJFaxLrywkTEdu8zhAflylLk+9KN
         3BKYhMVJYLCxGVSPmwkMHVucISyF4A2CleS6p6kAIAXmT/vkZ2Dsc4P3r8C2QHAFSysW
         2EFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUEa4z+kmEG2xq8kqtxwTAiYh0gA2y0nISe1SyygdAkIbxpa6QkZxahHU9nQotwTyVTdx8c3jmyJiXaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Ghw6PQ1I/16FaBmVCteJn5L+gXJwAI93686aaU/JWUmgFZji
	me+m+B2H+1NTtosdwO+y2ZKcbaE0mLGPbsFxvTg10/K74rWzOo6TtunG
X-Gm-Gg: ATEYQzxcXJJcU3iGdS1f/R9MC9k3KbSG3BuHRxibIPvZ52mEnb0ZTUwYWKjoF5LIZb2
	x/asa+QWTyuMld98DkRluuY65oNNHxUW88VhTAGEXyZ9Byu24/QRj9oBshSgSS0EaD07h9G7K9A
	7c6occ+jnfN2+OeKK+Coba9mSKKVumIWcAWSA0K4Q7/0Ld3fMSIaXn9qSa8hCnYEplg3cvjqx8f
	HwIhF2z3ZYl9ZIp5qD1LBUUQA52SonKsuxv8XvQ1VFGvWVIBoH0Oi3rbb7K8tANFqvl4TNI/1L2
	bDUqQ85lub4+K2vrvKC5l/Unl716HZoU2TuNjIbhkDBboQ7wyRlAyq3gztsIwq4Yz0y25xBX1e4
	7cgMcPpPEQKuhqU4gbSHfXlTNPrxpVrtW4cT0qZtreI/Y6ToMM3ltm25GBStfUWi0EFkYIFqDXS
	eUJ8mdyPd8RuVhxP7n6W+dEKrN9JMb9r/QiiHrcTiZh2JaqbqQEqNzMmyQSfVt/MBFur8DvrOGQ
	K97SvgcWCMNtqHTNmXIRQ==
X-Received: by 2002:a17:90b:3d0f:b0:359:b7a5:21a8 with SMTP id 98e67ed59e1d1-35a011d3905mr1172850a91.5.1773202975638;
        Tue, 10 Mar 2026 21:22:55 -0700 (PDT)
Received: from localhost.localdomain ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359fe40bed5sm1241924a91.5.2026.03.10.21.22.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 21:22:55 -0700 (PDT)
From: phucduc.bui@gmail.com
To: wsa+renesas@sang-engineering.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	geert+renesas@glider.be,
	hechtb@gmail.com,
	javier.carrasco@wolfvision.net,
	jeff@labundy.com,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	krzysztof.kozlowski@oss.qualcomm.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	phucduc.bui@gmail.com,
	robh@kernel.org
Subject: Re: [PATCH v4 2/2] arm: dts: renesas: r8a7740-armadillo800eva: 
Date: Wed, 11 Mar 2026 11:22:49 +0700
Message-Id: <20260311042249.2380-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <abCkX_oyqaa9jM5F@shikoro>
References: <abCkX_oyqaa9jM5F@shikoro>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Wolfram,

Thank you for your review.

Best regards,
Phuc
