Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C892E091B
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 03:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199063; cv=none; b=DZMTwba4OfwIPG8uQ4GoRJ+1kmLsCQDmxMLoeOigmC9E8OMWxGzjB1gXQuMrLTAFZVYr27ZzW0D8A2Ca1c/IiUdi1VQrlG0rWp2eAtoDlzYubguGZ62zc8VzSAxlbR8O2t/upFg+s8PzCpFg9h4w2reYnrrwYrojFbBw57ig2Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199063; c=relaxed/simple;
	bh=9oo8f816zUb8gdoM9br7bk+Bv4pQ1YUHqKG/Gnd1WLI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1FCr0Ef53SGhdRiSMrOXH/II9EZG8ZWNhpv3MmhcT8JGh8bNS/E9W3pDDVk9l/SKc2JdiRFmruQk1r3IKJHOO4crz8lIjB0sfpMt9YhFrKeXwlQ7pliR40NeWKwaaPaNFZn5QIo3kghH8PGoLyGM39fMqwqUkDNBUCPH+n3x3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfpQZjZf; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfpQZjZf"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c73a12af63cso2607556a12.0
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 20:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773199062; x=1773803862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9oo8f816zUb8gdoM9br7bk+Bv4pQ1YUHqKG/Gnd1WLI=;
        b=nfpQZjZfY6X76Hb1dyvwJLVEXYQv+4MCXo1Q6Jm8SqZmQXQWUa1rVko+T5WLjqrAll
         cAT4rjT5d+y20Vavldb1mSyRgiqjNtNaTsN22EpX6FRf+mIWEsXfUhV3c5Uxi2s7V//x
         SUfj56KVE/+VaYsvbX77PzzQZwMZCXl1w4BUs0YGyC+UEPrqp5blAeELCt/Mfc1xuKIr
         l2l6HPl3ACm8sAdW8JqHXdkwiZpda6LUyDiSb/HQrQgsitKhSNpqZssfkNUKosNg89tT
         nHDBs+qIWQw0bOw1UHGYUxjDp4au9Vujcamkc4jXQ0oqs9bRQSK628P9e189Q5UDrbJg
         ptYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773199062; x=1773803862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9oo8f816zUb8gdoM9br7bk+Bv4pQ1YUHqKG/Gnd1WLI=;
        b=kusC7j81asAc3AlKHo5UGelfUHW5yBHU0LPeWYLPoeub4v8Cu7sugN72MDFUxHBZCh
         31jFxg/7KtoPEyK9aoKjfrev6XwPL3AhiHT2VZzJgdFCps1m8HoErD6doJhM5j/d7vYp
         Web0UGfOm9uUYqlNsYppE93tOSa4qTCOfjyCChmHQ73QWKeozphhLovHC+iXH/1JWRqk
         0wrAgnnDbCbIhUfVoaRWHJYPlL2LVGc7qsNjwWZ2dP0mLUBEUlncTJUZR61nLrCSD1Ot
         VCy5j7xHOlJLQoXIYYQGY/xZy4U8UrfMFZawCKxQbFiAF2GX6VpsDLmfv83LE0VegxA8
         +sCw==
X-Forwarded-Encrypted: i=1; AJvYcCXor3DxMhAMDtebLz3rkbo6hAFxHye3K5HN7pMqQU5IaefV7ma7ZRCJ2R666pa/ejSNliWlVO5YeZG34Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYeyTj6jgSRZ7pGM0VgQQXXgL3J703SW61/7yYw8LWnOSDgNEy
	E3z99Y2sqJgb+w2o0tWsX6ZngpG9DenOMalqJ1yuWaylNwBWIjnS3i8J
X-Gm-Gg: ATEYQzxS3F0xg7/vIhZxdsPsSD6JuobEz0JzrPJKvfm+zcxsks/eWEXTc8pnmTmdzhI
	gdbtg92dNj/TXSRhQz2+ulnqGfaTmyXLwi7JibvYt8bMaxPEWsWdE8nBXKKYdQ4Dduo+EPYa12s
	I+t5JdqC04qPazAqZVB17dyR3JUJ0oQi8ia2F9Wc7nM8Tq+wV0yhaLb+o2ZKmJ6hYRlrSnzkVz0
	JwJiGMYVg54HJwTiy9BY93yzYPoBAim9r51DZdr8zYI5/ylSeYS1Uh5YsYacRq3MR3qMO/obIv0
	xjPsR/BY7w1aYByTsB8BdtZKf9a3ICdlCSfk4uCQEIbcyWfSG1fIyc0E9i7CFxQ8QwJUQ+4Irnb
	JVWOFC5ozLyS3CdmsFy7lLqRbx4dfUyniX93TrNr2Uduuf09PX+X6RehoVKeHqCdgN5FlcAnGdo
	F4KN0WEdCjP426rw0fJ1KwfkOqxiX9NyyOueyXqPNYJkKBuNYSCum7WuGQM6/k1/r0/+XbY6eLi
	9qxBg==
X-Received: by 2002:a05:6a20:938a:b0:398:6461:6888 with SMTP id adf61e73a8af0-398c615d5f8mr835628637.60.1773199062154;
        Tue, 10 Mar 2026 20:17:42 -0700 (PDT)
Received: from localhost.localdomain ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829f6df3417sm711651b3a.19.2026.03.10.20.17.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Mar 2026 20:17:41 -0700 (PDT)
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
Subject: [PATCH 2/2] Input: Touchscreen: tsc200x - delegate wakeup IRQ 
Date: Wed, 11 Mar 2026 10:17:35 +0700
Message-Id: <20260311031735.2044-1-phucduc.bui@gmail.com>
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

Hi Dmitry,

> Sorry, but this just makes it all worse. There is no downside from
> letting the driver to control wakeup if it wants to, so I'd rather leave
> it as it was, at least for now.

Thanks you for your reply

I was thinking that the code might be simplified by removing
ts->wake_irq_enabled.

In resume(), we could just check device_may_wakeup(dev) before calling
disable_irq_wake(ts->irq). From what I can see, wake_irq_enabled is only
used there, so it seems redundant.

I don't have the hardware to test this right now, so I didn't try the
change myself.

Do you think it would make sense to remove this field?

Best regards,
Phuc
