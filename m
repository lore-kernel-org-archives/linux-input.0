Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A8C3CF045
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773225528; cv=none; b=ciKuWacGwQpqJETpV83Il9cy4r1B1FlxC4lE7uwmTEzzSXaY/JElz+fmKgBGFzWfDITolK0jRw+0TXOA1+QsKAq50MAHLxeIlC6l4cog6oFocjCjzlONyo0qdZ06E5L1EjdosR1wunIlh24rVszlNNd00cyODdDr5ICIiDfEEes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773225528; c=relaxed/simple;
	bh=i7nUMXQbtZArZGnsatx9qQeykbtPVUo/SqQprsinRno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tuMYgWekzNE6esVGzjbyDe2AI1hKzwvLqsl6aVdzS/PUqDNuwOB3nlrR3wfmLqKTHrFEg3yRrQ/RnqC1Lp72WyiDHi5biBsPnyhg4oHYHTStL1Nk+lCsCAwSCTdjuPEKzZGLHI02BGaGixBrUJ+r29Hos+qXi2UpVoIXWYv9dlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8E+qNcz; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8E+qNcz"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-829865a8471so6536449b3a.3
        for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773225527; x=1773830327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trxODt72+ZLmM73SSgKB2PrCW34S11oS3WsSFeUrg74=;
        b=J8E+qNczqifmPq/ZFjhO3BYc1oRJN/PB3QhnQEsTSjTWa59nnf3Gyc27YH2UpdA3cd
         Mv0+LI//wgiqAEOLdjLa5V8ncUgKiweo5oQWMHFkaMhfCD3Nsl7g6a419u6bN1U8rJsR
         hnjnmd+m8tabfPNvYR2qj3f4ge2CFBKKieX70VZq/tBZWxLSs+eGNUKCVOs5HPZ7vB1w
         ygmKehbSGLP0jLLRlnUw6AzOpq81DpVAyOLZpC7Yz4xuo01+WNYvZ85bTIqnrIRnE3kb
         Wdk9JbIWB41dUzfA0SkorSZPljMyUwAjyYLxSHt45uIoIMQArNAI3NGVcrlHsqbVggsQ
         HbrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773225527; x=1773830327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=trxODt72+ZLmM73SSgKB2PrCW34S11oS3WsSFeUrg74=;
        b=sjHIpFETzKBgIOH9pj5BMzIkFv1hiYuy9DL3lqW5KJ9c18/jys8plmmorNVxE9CfaL
         1bawodP9LlP7Ozg1R63/fhcVtiAgySEJtISnKSYVYkfyy6zjr9hHVULIYHQPf+3c3dVG
         xUAocHReACo5oOt3azeyxGoXSM8jT+hh/zJfdlRVcHe/q2Gw53T37qTz5mvQAV5I1MPx
         AMF8LfgUKCqbPcU662tmMddBNppK+jU4umHg2W/9HAm1O6D9pC864zDZCcFS81hPUXuN
         Yzfc/FdRC2ot1X8+XYGhLRe0klGT5nGE3Te09Z6ELttTMYFSfdoCETiq9K68/OeCR5bv
         jISA==
X-Forwarded-Encrypted: i=1; AJvYcCXwy6/DL3UT1N979bPYlcSf47uBAXq4d8dOLOWsk9hpIzOjoZzLRI8uKshDO6roR/yhPuQR3iAYD8z5Xw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnhNGr/Yz7WViFciD/stlgPSlzulMLqs9GwfDBnol9k877tzyV
	lwnFsf9eQ7wTvj0CE3M3uIhIz17uJkyP4qXsToAbxjHHyISOGiV/HzRkFrN1Xw==
X-Gm-Gg: ATEYQzzkouqhu5r8+085IH4iBJFEtlqePjhmJzcPXkauT+xrzpLYY7C6oZWIG8OoCRW
	5gySMUxRVxe0y5+U2YYSDv13Ldjb4oTNlzPP4Ce9q8+avFNcFecwpYvKRpnQ7VUyADhpMr2xaeZ
	ecBj4FJbTjW66Bq9HhoJPgb2kfI7EB+yUe7GPxBSStTSEQF9t8n8BdbEW0aP/AmhBggIEdMj2T6
	hhXJisti0czb4evANbRlI4E/owhxuUXCRrJchKKOX4JT4Wt6hfsv3ZK9yeIS7X8NR62eoXH8z7+
	+xe1wLj3ioxvLMbk7JR7WnuTzTfeeASdlGU2kyPFktg9qeeFoHuE3DPRA9slI+aIz62bX6NLzr2
	NpIgco2wYqoQ24wi5T+Aj148+8I8EbByTMrXUnBgOeTKtu8kE0nHFfTtT1aEE467YrduOCPwF9x
	two7Vh4N/Yq5FT1E5cZIZBcEmTYrNcc0fSnKvMVyJCsWi5NMm2ZnCU2xImAw4OhGBFRa/bdZnGZ
	la+lw==
X-Received: by 2002:a05:6a00:189d:b0:81f:38f4:d774 with SMTP id d2e1a72fcca58-829f6ee156dmr2271399b3a.27.1773225526679;
        Wed, 11 Mar 2026 03:38:46 -0700 (PDT)
Received: from localhost.localdomain ([14.160.25.72])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6f1e374sm1785635b3a.44.2026.03.11.03.38.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Mar 2026 03:38:46 -0700 (PDT)
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
Subject: Re: [PATCH v4 0/2] Input: st1232 - add system wakeup support
Date: Wed, 11 Mar 2026 17:38:38 +0700
Message-Id: <20260311103838.5541-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <abCkulmW8XDXkXiT@shikoro>
References: <abCkulmW8XDXkXiT@shikoro>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

> > Demo video showing wakeup from suspend:
> > https://youtu.be/POJhbguiA7A
> 
> Nice video! You really put some effort here, kudos.
> 
> Really awesome seeing Linux 7 on this old platform :)
> 
> Happy hacking,

Thanks for the kind words and encouragement.
I'll keep learning from the feedback here and 
continue hacking on it.

Best regards,
Phuc
