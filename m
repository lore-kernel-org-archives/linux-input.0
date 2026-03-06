Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3C5361DB1
	for <linux-input@vger.kernel.org>; Fri,  6 Mar 2026 10:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772792688; cv=none; b=GmtkxvFaWT6j0so1nfj3Es+WjF8NHZp1a2jE8Gd8toUrtWKviMe/mTbqNnhjR37CWzdz+HWDvfvNN6aPFYWBT6E/7LQ7Ogl4cXccep8E4ZZiyMhce6Xb9DjUyCY6F/sNoOiztNlqSN0hqv/x3YcgPwCfeFHTIPVc84lKtMZ3OHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772792688; c=relaxed/simple;
	bh=K5zUA29EOHlsQwWG1ZLNtqOq3eZuUrFY697i5ltzkG0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dAruhNxjEbtwSlqZG4RXaDylUjkaGvLvqunm9RyejWOy5VOAfpNuWFdie17/ylgDw6eqpgxvzVXy7D8yvQERXua2GRFtMCI9FidLI+XMU3f4H0/iQL5lKQsOdEz/v3VZcfqEB5/4Zy504qnbcb0WZX0t9rpjrqB9aHzj7HjdfBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/OhqbzQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/OhqbzQ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ae8177446fso4201975ad.0
        for <linux-input@vger.kernel.org>; Fri, 06 Mar 2026 02:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772792687; x=1773397487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MEdOKSA16mhhtBoc0MBYDqjTPTIP+5b6vp0xDmyG/4I=;
        b=W/OhqbzQOWHEOD3x12R3uP0ykfPaFFJfhH2hqy6LFEETNuLsrJx0yZXJN28WiJKvim
         CK4Fm1TDHq01ubNWPm551nFcKPyn3wmveZfcJOZfqGfY5bxB6DeWDYcEeUjm0zMAPsa2
         HvOdqzdA1XLAdiIfZprpNseo8TTq7jKb1M31IUHQHUDNBO0RpldyMj84rFEe7yJdMbQJ
         /Yer5gDUpnYl8aTuOQSsafGvVAlWZLYlM17OyqK1lVGxby5OPPZvSmewP/GaAlZYtyeS
         6LWy6ZNou6oUkfiUH00i1Ib6swHbrSaqGhniIUTGUSRFeuRGWikfxnYlDmkCRpRqr2ar
         ldGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772792687; x=1773397487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MEdOKSA16mhhtBoc0MBYDqjTPTIP+5b6vp0xDmyG/4I=;
        b=HfEZ/vH5e41e0iwkPgfNxaIKVBeTMHUoI7QsQFruwA04TcsRrgOOe0rwHs3cOtl2DL
         43xvYy+RPQvlF8ma1aYTo5xy4A5TEY3hxSA3iV4wyMhDtyyU5KoIE02gqhJZwGXhLd1X
         IgLuSA2E+B/G1w8apOZ0yUNVcVEUnq8hqvXFW9aXRVeIULvXxHtKIDGzXE8oYCiQADHk
         kbPjLRiYaUlGqgOHfOeFMFzdomC/wZeNVwXx8KS+im8aSgFoSfjIcok6aNKtls5uIz8d
         4/nFpuepRoKeT7HqKNtJdZI4mKbZqIKhZ7bInADiGuqaA0xNIzLuL/P2gCdpKc4SlfAR
         yIoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWN2hiN5zfns3FitMsohel2McVnMfsJ1TL333DCH8t6zH1jLeMbfBhaAmTVcPEYqmXf6PR+gR8s9iYgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr7QQ1sKRlaguxCApGJrpm2oZWF1byMPDks8yzeIVOZLlXNQrR
	LA3D6MNN3izitOqDxd2KHz4C5B03c3gmCfctel54ug8g5xinWG56yHnc
X-Gm-Gg: ATEYQzzH6906BJ5QkmG+yxTLOXXFcBta8bMNA5lI1qZPcV0JgNBcKbwI9WS3Wm/vpLY
	rNw8j25WFYkFC++fBmZ2U4t63m7jpeNg/teTCEo2ZPnz7Bju8yBSdLgh6OgsoMruj4SYy4MWCvC
	SzAbbpEDZaqS6xy1+70VOYw/5s7TrXQcMggBCemcJMniRRuvX8KBH0j5OkI8OsHUKIVS1KKcS4a
	aCBO6b4ClY8DNAIunj5PcP+tym2AfPrtVrPglyXkn9TjJc17fqeA0T1xo4SL8zTU28U5GSQDOB0
	yg3O2NmVFrl+jpSPPOdenQS3aFlb2Ha12erTuhjOHiiI+37WjV6OGwtD4a/XTxvpOCGp3OzKljz
	/bnKbdpUkyJHctxxTvw27hRnEotiKtv1l571UZvhUt/63lU8F/96cxcK8k435dyShplJZE8Wbm5
	n/4xbfXOQ2Y1bYNg44wgSev0lz7gQ7OY7s+F45mbsNwSefi1oqYzQhmK/9mCen9J5v35a0c6xrd
	4vIo+zPWd9sBUswdJd7AQ==
X-Received: by 2002:a17:902:c94a:b0:2ae:698d:94a6 with SMTP id d9443c01a7336-2ae8241dd3dmr21919975ad.2.1772792686854;
        Fri, 06 Mar 2026 02:24:46 -0800 (PST)
Received: from localhost.localdomain ([14.160.25.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f770ffsm21667495ad.45.2026.03.06.02.24.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Mar 2026 02:24:46 -0800 (PST)
From: phucduc.bui@gmail.com
To: krzk@kernel.org
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dmitry.torokhov@gmail.com,
	geert+renesas@glider.be,
	hechtb@gmail.com,
	javier.carrasco@wolfvision.net,
	krzk+dt@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	magnus.damm@gmail.com,
	phucduc.bui@gmail.com,
	robh@kernel.org,
	wsa+renesas@sang-engineering.com
Subject: Re: [PATCH 1/2] dt-bindings: input: touchscreen: sitronix,st1232: Add wakeup-source
Date: Fri,  6 Mar 2026 17:24:41 +0700
Message-Id: <20260306102441.3605-1-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20260306-fossa-of-unnatural-authority-29e0ed@quoll>
References: <20260306-fossa-of-unnatural-authority-29e0ed@quoll>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Krzysztof,

Thank you for your review. I will drop the description for the 
'wakeup-source' property and send the v2 series shortly.

Best regards,
Phuc
