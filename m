Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23D534678C
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 16:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775664482; cv=none; b=bx5oFOA0AKC9w/S1TO0ke4+cbPjarEeiI23rV11AX2U35NuuEAq1OhZAhJ2Utm1ynomjTB/8EPu1tp/fixHhM11YfVvi2g41F48csZMU1pnCrWZNl/53TF78ewBJI5hWPF6enQr9msjKryT93E2/1OT6vZhtOFhgPysUa1kGOEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775664482; c=relaxed/simple;
	bh=MfborNBhbArbEBHQP4SuZyjfWstGTD3GEhTSMsnnQGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OBqXlXBOovY+5z8orBVFU0UW+o+ezrSN/1vlpNbJ41IRZrQtgzX6uf7pjTq+xy30fKueGlJQ7dj+qpGNztce1hLP0neEdEpIk8lU9VU+0KFMQLkedmdVKo2tSp/N9x4Sqgo1Bx03+fJp7YyV1Y2nfh12pOHWuBYzn2uzZ6hvifc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB4CBzcX; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB4CBzcX"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82cebbdab08so4594156b3a.2
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 09:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775664481; x=1776269281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfborNBhbArbEBHQP4SuZyjfWstGTD3GEhTSMsnnQGk=;
        b=gB4CBzcXG3vAI1pPMeYg5Bf41CtLqvdIbTBaP+SV9/Z8UC83E4qYnFLxIhYKm9nvj7
         A2LRL8x23ABqPjiI8ZYqBZ67g/ojAoFsw6fdzG1AB23NADCBD1nguIOd3mb6vvGDuzM1
         aWSCeYXb2OxahBPqreAEm6Jn3NvECuVzMg6/kwlqu9ROO0WDmuANh4V5vogYL5FlevTT
         fkZ+pZ+k1Zo4sATp5P+2yZ/7Y1suG8Y3kdK+folCXAIujNhA4BQSevx4KIJnPlphTolQ
         Wjz6Saj+uVQ1fAdHcYogq1tgaOgik/eBPrXf6IHTa/uyTZN9KxXXDyZE9j/1jSzor/ui
         wADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775664481; x=1776269281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MfborNBhbArbEBHQP4SuZyjfWstGTD3GEhTSMsnnQGk=;
        b=OlhoO4F2xy/0Y9L1ERne01UJxpXOpp1Aj886UPJ+SOfc+Sml0MMZz8bZJOWm7ZGui6
         OL/K0sG7s5ywAwtX8T6IAxPkbNayazum0y4GOBir3QU9fIDzYC87aeLwqxlkRRykSEbb
         bhOC0P/nnG2z4u9X8svV1Q3f5kB9UaiEC9KksezV6BbQx3V15tHIHdQrO/NCu5q8VgU4
         EFNgJGHfDlAR9pucyJsEMLZToaGC2s7rf4+t0aXJhK6dZd04EV1skIiPpothxs6Cm/3D
         TIEmn0nrQjO8BeSPY4UCr62sPnjohNihb3yW0N3odc9559UMfadcjffSuzHYjVCqm6sd
         nSqA==
X-Forwarded-Encrypted: i=1; AJvYcCXQYoenBin/tlNQyQIdplUCgezh2mDdZ7ewSwblJtCWYLyX9mCrD4vmqIuS7QjmsYun8TNdGJUmGuufvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTtMcVnIuaWROp13kUI9TO/3+MQcJellT5a3F5ccX13TuTFRyE
	AvUAIhX63+647UyW4SGNbkHicGZl8z6KkARCJ2YtnWHaczBHIjeN8Odh
X-Gm-Gg: AeBDiet5BKOm6WF5jzxzbmw4ePmCOinA9tlACkLpCEKkNr3WdDt7lshS6ksuKxEKX4g
	9DmwPA8RxSMJAKEj9wZECyR4aWnc+hSdsQltBBh3vPHlnK5gAyUpxr2uDoJY6vKVCpkIm4szOsi
	+tiaymKzG9O/bbh8jJtWiuDL/r+jgI1MlRB4ez0d10Qb4ivZKlL5M5ZdbZJb3a6x+uHlkeqX2VG
	VbuMRkysvhlVEhSO8LB+/84OfKnrNJZUc3xHJWNFTzBYf80W2S3YimL0U2oDhDa1yFnRcE8ihQJ
	JiNaigD4hP61R6l/b3DkGfk7roFAeyIxGWx9ehPOy/eOMUZuQBrYp8MOwLJPPuwQ6pecmhPDGjY
	oTB5lEzWZ073f9dJ6YMIe67j5I2matR+pAz6cOz40wJVzYJHMHE3po4egXWvRIe+pxdDzaO6X5v
	LK0kc/1wJoa8HXAqYGZg6ThcEjBLeU2LEOso8E
X-Received: by 2002:a05:6a00:951b:b0:82c:f45d:415e with SMTP id d2e1a72fcca58-82dd89937e9mr75389b3a.8.1775664481109;
        Wed, 08 Apr 2026 09:08:01 -0700 (PDT)
Received: from ITX.tail9b489a.ts.net ([103.142.140.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b261absm25004779b3a.7.2026.04.08.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 09:08:00 -0700 (PDT)
From: Zhouwang Huang <honjow311@gmail.com>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>,
	denis.benato@linux.dev,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	honjow311@gmail.com
Subject: Re: [PATCH] HID: core: add short report quirk and use it for GPD Win (2f24:0137)
Date: Thu,  9 Apr 2026 00:07:55 +0800
Message-ID: <20260408160755.21464-1-honjow311@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <adZ2PTzQ05iObcGt@beelink>
References: <20260407173212.86942-1-honjow311@gmail.com> <adZ2PTzQ05iObcGt@beelink>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Benjamin,

Thanks. Agreed, a core fix that checks the actual buffer size would be
much cleaner than a per-device quirk.

Happy to test when it's ready.

Thanks,
Zhouwang
