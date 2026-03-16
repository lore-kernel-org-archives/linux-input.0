Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A01230C617
	for <linux-input@vger.kernel.org>; Mon, 16 Mar 2026 02:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773628876; cv=none; b=JXsvYb9R1K2olE2EHI9mJ/s0iaDgbq7r2iJNELXgPlAKrIwBfUIPTPgryYwDKfPCMSzO283VHwO1Z6trSpVYOER7f9IeZSWnTZyGIXDM39wMIQsT45DmXaQDC/KXMQ9fyxHFnyqrEHX7JcrEw+NeBalpEUGcHR3SVlvBBsbFcKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773628876; c=relaxed/simple;
	bh=uvscyfAUXBPcXtJxTseop+QZNEX64Gy6pRNaDGlCbOk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BmCySLd/91k5MFlcfYcY25N+JcGKSYzznv3v7Vt7O5CxuxoyMLkGHu5BmhOL6+357aZx2KU6hra2y8lJ9Gv8at3ItubHNHnTM1UaUKJTdyCzbYxZ4CsTGhjVVQx4+IXj7Xs57gISDG1ObjUSMuRrdFgMQyS+TjoPlTWZ9V77cPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKY/rmlR; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKY/rmlR"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-358ed696623so1783157a91.0
        for <linux-input@vger.kernel.org>; Sun, 15 Mar 2026 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773628874; x=1774233674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvscyfAUXBPcXtJxTseop+QZNEX64Gy6pRNaDGlCbOk=;
        b=aKY/rmlRWfDfzd1iq9OefNg+Jn0z18fx3hFx5CNFryFoCINH/aKXq6LwBdLDD97CcZ
         6KolU37qiybDLkgbCfH1bzFU2tTXUKs0dNu9V7X6IloY4s7Kbi51s5k07i0ALV2aAZs7
         zbT1Sox070jZpCMak/W/xAtl39PE+qX0jE0IO71QhoN25bUioTSeejyj7g6EE3ShTml4
         rDumACeWIp5MhOHU61Jy9gRmco69K8yNvYNFich6HoAil/kEsm8XqZjYnz9POLxF+IkI
         acMYnA7NDuZyFFzen8a92tmtm4TSSclH5ttdMFM0zYiIM3pX/6YCO0Q0oAdoB+15qXRu
         ROxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773628874; x=1774233674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uvscyfAUXBPcXtJxTseop+QZNEX64Gy6pRNaDGlCbOk=;
        b=D7dp6WrKaFqh+LzMDJe5BPwELVfPH577QdL8uFv9krPztTEMsKdTaAOZaOPQcO+1Yv
         RDHXvP3B6F2PfWFlUI7CxNSURiFEt7EWg37UptAY1oSdrDx2umOfXI3z83VHdcUPQHfN
         M+HmJWOltiRkKlLNRgYgWtFWvoGE/y4/cbTmLHzdHgUNkYB0Aw/u/OnCnFzwMlpq6Vhg
         61HdA4+frBgxywPar0NntIjieXtrDaB6LrP0hBNFjfXO/0amqVinyY256GuoHv7AX9xK
         6QBLnuwbPMOIU7/v3NeNAecNFui8JnnHzeBwKxG/kr6S0XicE6CkPG/C+WvGN1abuOKS
         3XHA==
X-Forwarded-Encrypted: i=1; AJvYcCUNpObMEmtE370/GvIZlaTQ4iMHiHXZ7sgBL7nZlatSqxGL70zw9K+CKE/d+F0+UndngtHTjFunN49byQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjB0FPh5XFkeHKIDdaPF+nMYbsdxkO6KwZRlIHZmNzIf7B1wKc
	uDBiPEAnZeL8tiJ0ZMUreKU+O+JLjnTYcvRWVFofld28W3z0wVllAib4
X-Gm-Gg: ATEYQzy/h3K5r906IwSSmKv5UX169cG5FmjhS0/bk0hG3BAiz2RDInsaIeml9emU4FQ
	hkOEWkM0waqtaJ2N5nxKE0Mx0BE9lA4IVC1rTrvl7mHuROuwduzFR/xb+6KneNoDTT71VSLW0Kk
	nPhswcU4hysOW/TiZhHzbf8aIf24uUJeU2cMqkWEnJ2n9hToxf8houivFpNkzYclU7xsiiAXxuL
	E7uNv+qcDF7ElntmuyIxIJTzMVXR7hRnsLc2GOkNlO7KRAJ+zPa6YtclS2RDREn9BiS3ImcBZIn
	3Oa2ZFvfC2uGk3qPwAUW4nFb7k+4XCTlgQ/GwMQ5F/UfbGD0BfM4sVoOmMnaJC3oGznMJ1ROnLO
	Q6xL5LveTB6b9gBdFnLud6JM2y0lyjmVJysEnYwQuC5kO7fF/MdJl6G2CtmX0PcMiLNLI23jbPF
	j1O99sJc8vDLDnTUICspaULiacRozkax4bakJN6he1oMAIWSssasVFeWWZhASzU/x+u6nS/dta1
	QMvYG8eXsvN9CRr
X-Received: by 2002:a17:90b:288e:b0:359:8d0d:5905 with SMTP id 98e67ed59e1d1-35a21eba194mr9030288a91.9.1773628874568;
        Sun, 15 Mar 2026 19:41:14 -0700 (PDT)
Received: from localhost.localdomain ([14.160.25.72])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02e19708sm19539638a91.3.2026.03.15.19.41.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 15 Mar 2026 19:41:14 -0700 (PDT)
From: phucduc.bui@gmail.com
To: robh@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	krzk+dt@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marex@denx.de,
	mingo@kernel.org,
	mwelling@ieee.org,
	phucduc.bui@gmail.com,
	tglx@kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: ti,tsc2005: Add 
Date: Mon, 16 Mar 2026 09:41:03 +0700
Message-Id: <20260316024103.3403-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20260313232347.GA3629471-robh@kernel.org>
References: <20260313232347.GA3629471-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rob,

> Write your commit messages independent of the Linux driver.

Thanks for the feedback.

I will rewrite the commit message to focus on the hardware description
and formalizing the binding, and remove references to the Linux driver
implementation.

I will send a v2 shortly with this change.

Best regards,
Phuc
