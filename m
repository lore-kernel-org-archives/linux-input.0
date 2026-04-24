Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EFB36DA0B
	for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014820; cv=none; b=W5dwUGNPXWbIvWjj7+5f57uqesFqc05W5Gn530zkDTx3c+RZcKrnh+bw2LXcUOEFUwHbwOm5dQG3omtF6weAbZBRIQreSI6Dn6mNkPns+gStK8YY5IKXCbaFjTYwl6XCUKiQZV/sPC2FYfDpEJObUB4f+CKTvtijbxluSZcDf+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014820; c=relaxed/simple;
	bh=TTMApobnGmWOOW06RSWxzVL2ux7eZCtH8CR2tkV9zBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QkAgjgdKbxKalxlnvLjNgI5pFaL7buhugxKQqOXxLNNI/hfKN9nO2O1t2nsDIyMRsM6CVPtvyHWM+yG35CB9mI82vNzQcqWs081290UjYuSsbOrXsS9+j0WWQcNywsAzxBK7Jug/k8OJoXcFsC4ERr3sTL3KJMbtE8b6/u8NUPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VUhfNRB9; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUhfNRB9"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so72028571fa.1
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2026 00:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777014813; x=1777619613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A182jZR5TwBM/HJjBNyA3hAZAqMm6f76hkhqyZnm/tw=;
        b=VUhfNRB9sds1opZVvInmxG5RQYS2iN0wJhkYjK0kVRtDjW61M8YoxPYAmhpeJk+12k
         k1koRQlGVfcxnLBNR5F1q1kdNVxDxFsXa4eyuyxqyzTZyMgdDABxdWlwZY+tJvdsmP71
         GMuuRDAhAIjrLA9M4CzQ/NIcKhLgKDH3Hp4K9Dt+tqXNXJuSAFuB94PxFPB01wiI1/DB
         fe6ZDofZk5cz9OGZEb/kk1nnIiwigWB8zaci34EzNw1jCBX8NuYmdsp47jyh8hoZV04i
         2kcZtYFA+3urkfIXA29v5IsdC081a4gD+GR8DQshAQgKHf6fkyq0JSkfScOkKwA5cAVB
         897Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777014813; x=1777619613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A182jZR5TwBM/HJjBNyA3hAZAqMm6f76hkhqyZnm/tw=;
        b=VR3RRerP3yFipzEJkn+iIbckg8uuVMq9ubaimG1zWBGjJq67ixI+8z5HquDDQXMzeM
         2ZhK2yqjPfHLn0HWE07+wD0Au97CEisMvk+tbhSLK2sGhXvyDbHMjAGT4bHwTNXvJdCI
         /9ZLDbZiJbuK4YO1o4CLDEcPF968mGycWDA6MQ48DsDR1JglCdrn9zF+AHdZtf6lVQdO
         Kwt3K0bg93pJ35oKkqybyPFA+XF6IfiI0Vj8G9PKcC2AN+6hZ3w6NSduD/abhBb/k2QN
         8UwnVCA+W7wIb9XoZqEuCEHYpEgtv7zjkagRSj7rj3P2HukeDBb6c+hBlLTwYVFTawDq
         iPVw==
X-Gm-Message-State: AOJu0Yz2zzs1SAsQFYhLCv3G6r7ClJbUSxZ41bb9zb9+BuPo9PKHA7pG
	qk1uV9X0Umy7x2MQcojElMwGBdaXbOIX8dsVQFPW3+SpA3hKzVfY5eo2
X-Gm-Gg: AeBDieskbJ11EOcMzkzEvpOWiMOl8Wi3+UPJrj5as1VMCoVkO/9BViLb5dDhNgTubFW
	mU114UV8Gseg1fomZ27SPmlR4X2TydiMxTd1EeXNcTlBu8SqNjAhQpLri6IO7rq/PtlDuNXpP92
	RuhkPqjDpUylin5j8tX2mQ27JA9MKbdAeY2wi6YOe+RFOc43bbiHbVlC8ltPL1m/qTWlpmXiPcf
	YsBn7cKbBmQKdRotdALExI1xaoZ2L8eezt6zOyGy67uTC0u6r+eUVSZS9j9CebuV55NjQ3LqQ/6
	cDAqr1uT3oxmct6dX28pIh+EJO3pNF6peL0m9TxwPD42dG2Kw4CDLNdy474+cirZGT1W3lvcdfb
	D0HLnFH7oVZwwOprKcW0dT0dz4cMTt14pciItkN4EbaLIfQcGj8GjXj2G/VkOOS3nq9ajhREf5U
	E+Pa+iJ3NQDULEw9kt13oeR+c=
X-Received: by 2002:a05:651c:1448:b0:38e:90b9:ce98 with SMTP id 38308e7fff4ca-38ec780d734mr96591931fa.6.1777014813092;
        Fri, 24 Apr 2026 00:13:33 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb290095sm43760131fa.0.2026.04.24.00.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 00:13:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] input: misc: add support for Imagis ISA1200 haptic motor driver
Date: Fri, 24 Apr 2026 10:13:03 +0300
Message-ID: <20260424071305.89503-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ISA1200 is a haptic feedback unit from Imagis Technology using two
motors for haptic feedback in mobile phones. Used in many mobile devices
c. 2012 including Samsung Galxy S Advance GT-I9070 (Janice), Samsung Beam
GT-I8350 (Gavini), LG Optimus 4X P880 and LG Optimus Vu P895.

The exact datasheet for the ISA1200 is not available; all data was modeled
based on available downstream kernel sources for various devices and
fragments of information scattered across the internet.

Linus Walleij (1):
  Input: isa1200 - new driver for Imagis ISA1200

Svyatoslav Ryhel (1):
  dt-bindings: input: Document Imagis ISA1200 haptic motor driver

 .../bindings/input/imagis,isa1200.yaml        | 145 ++++++
 drivers/input/misc/Kconfig                    |  11 +
 drivers/input/misc/Makefile                   |   1 +
 drivers/input/misc/isa1200.c                  | 459 ++++++++++++++++++
 include/dt-bindings/input/isa1200.h           |  16 +
 5 files changed, 632 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/imagis,isa1200.yaml
 create mode 100644 drivers/input/misc/isa1200.c
 create mode 100644 include/dt-bindings/input/isa1200.h

-- 
2.51.0

