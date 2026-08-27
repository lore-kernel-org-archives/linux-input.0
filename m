Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AF3AEF36
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 21:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864904; cv=none; b=BL68kB7BUMIhc5Zz+f0hpbW2fIEofnFU+7UIy6aVwY3Ufd19ystOXqvC/D7a/1wHs7fr8gCT/B+fyIR25AaGIU2SR4KnD0PBOv5DPXHww8r1VhsGp2KmZcWffhtMtcJi+1ISzhHiUukNE7EwylCkRLYIzUPwkh5iIsrvzay674w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864904; c=relaxed/simple;
	bh=+xIX1eMAZoyAFbWbcnOY7u7uOA+U/uYBXIImHcni9IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krqwyyGpGrKZMf2q4g6pT+wI8ZT03TsImVIyLSh1l7+MKWvSsLEkyR/rTmpAWddA0OgZACrGa4NT6PsUoae2/FeSsiPz58trr4dm1aDxVD1HRuYT0e5wvwbW09/Yka3EXcgGlLKNnnPNYUqMnElwBuv3FpKmQdixai3mgWqflLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=att3x2UI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="att3x2UI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so1558025e9.1
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 14:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787864901; x=1788469701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+xIX1eMAZoyAFbWbcnOY7u7uOA+U/uYBXIImHcni9IQ=;
        b=att3x2UIVCOC8Iv5ajnga+INBMCP0BuAZ6k8NVH4W/WHb3RYsR3VWUqDAX7/lrHsik
         iFEdjlqWl7x/mzSTn+NET5NIx1O6UqzfpbkuvMV0VHwvgJLckztHXIkq4eLWVrlLamSN
         RE2fYHjzn1qrgptiiu6fkI7lphJqtH738u0HkpjJ44iUHmp16ZZM0yhkEPN5vTEoRIYD
         Z/5JBpTRTFpYfLv4JFBujNLX7tjYsjmVFov/L8wteC6611+/jx2l2zCMaMocF+R7jBxC
         EMLNDTE1JeLrQH0iCie01wn+2GM7IS+9/nLcVApUA9Tr67Y2tbeOiWfTQAhzmReSz3zt
         D1uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787864901; x=1788469701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+xIX1eMAZoyAFbWbcnOY7u7uOA+U/uYBXIImHcni9IQ=;
        b=oU6aOGbtP/VAsNsT4EntnJKOybeYxh+cJZrU0laxvnSMmfPgFWL0c1UfMTtG4zzTor
         kt4lmmvIVTg1GzQ4zWDdQQvJrQPiRCqrNQeaP0V8SXqidQLu7zno8cn6EcB2nu+hYIr6
         KFdFmsINTFPQ+Dbby55MRWZSG25TxmGplo86OlBaZFDhQwDDu4XjqkM1QcKL6hm6ICLF
         iwj6G2BZvBX5Tbjwviop/4QZ2y4YlnLPa0+UgnSmOUD38WviQ7F4asncQuxqJO7sRSBn
         76xl4MOGC3N6EUeQlcgQywKVukJ9+GdSzlu33fye8hYP0Oj8AoCNad/p1A2m0qE27qhp
         EWbw==
X-Forwarded-Encrypted: i=1; AHgh+Rrhht1+RGAT/FC+QS/TzHi1ECG5gyqL7s0ahWLxpSomZNlL57m4CSoSkya2WZYaudVPLub2dp2IpXXmQg==@vger.kernel.org
X-Gm-Message-State: AFuF++mtxPXJbaVkAfHjh7xyZMpX+MNqa6Rk0deXTauSGSYE1wqoYz0w
	rjt3/POQWFQu/7FTC828G2b8o4GBJjz2+RDMziz81ETCNgGTw1Tbv78G
X-Gm-Gg: AR+sD11AI6OB7KXQ59GjU16o8OcZ8ulnnx/k5ThJ0Rw4lT113cJZI6D8LCZE8qylJfX
	dcgtUyA3WHq1/bBN8Z6izzw8TQm+86b5Xuymni+qyBYnPEGUm6dkh2BdFNJR6WgZkHZvoIYd8SK
	1X0VEz4iKQqZlELTPtrGdb1dLh8R8+CLCk2htDqQBHUukHpHfeEyjuySkoY4fgBjGQ8ThMkXd64
	hfAJBh8DdxpXvKxJZe43vwFLMR4n3INzgOm8u4Dq/EIlV8KFZwPGbxrvcnqJh+o9RBMpGkf7P84
	3v2uGSyU6h6wqDfdbsiY5VsJ5jX8mfrMXfcGSXsaUcscYNV/3VSMrvk2g7MQZyQubxheqdocMDD
	GGR6WbpRvWM2lAbTjTULnDZtde4rCgFWFnJlD44B+Ush3W01FTsrqixqTWuPmQFl6gLpgus6FrU
	8hduJL+o7BJJtCw6yf0CaifvKWl8rCGgd7AowaBz3LIe5PZUIjufebdc7OOgCyeaHYnvRV0w==
X-Received: by 2002:a05:600c:3b1a:b0:495:4d5c:903e with SMTP id 5b1f17b1804b1-49b91c2d8f3mr24218465e9.7.1787864900998;
        Thu, 27 Aug 2026 14:08:20 -0700 (PDT)
Received: from m2.. ([37.142.156.156])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49b4ad16262sm64764375e9.11.2026.08.27.14.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 14:08:20 -0700 (PDT)
From: Michael Zaidman <michael.zaidman@gmail.com>
To: linusw@kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	brgl@kernel.org,
	germain.hebert@ca.abb.com,
	rio@r26.me,
	brunoceg1@gmail.com,
	contact@christina-quast.de,
	linux-input@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/13] HID: ft260: uart: fix active-low RTS/CTS/DTR/DSR polarity
Date: Fri, 28 Aug 2026 00:08:08 +0300
Message-ID: <20260827210809.19389-1-michael.zaidman@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAD++jL=92mLe9w_VADZrSxPcban--S6LgsmpcPAHdLQ0yCZpHQ@mail.gmail.com>
References: <CAD++jL=92mLe9w_VADZrSxPcban--S6LgsmpcPAHdLQ0yCZpHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 25 Aug 2026 at 10:16 +0200, Linus Walleij wrote:
> Isn't this just fixing a patch earlier in the same series?
>
> Just fold it in with the patch adding this.

It is, and I have no objection to folding it into the patch that
adds TIOCMGET/TIOCMSET, but it costs an attribution I would
rather not drop on my own.

This patch is Rio's: From: Rio Liu, signed off by him and then
by me. The layout of this series, including Rio authoring the
polarity fix, is what I agreed with Jiri before posting. Folding
it into my patch 8 turns that From: into a Co-developed-by: Rio
Liu with his sign-off, which is honest but is a demotion from
author to contributor. Jiri, Rio - either is fine by me, so tell
me which you prefer and v2 will do that.

> Note: GPIOlib has it's own polarity inversion handling, when
> you rewrite the serial modem control to use the helpers,
> the gpio table will include a flag for polarity inversion, and
> then you just put it there.

Understood. If the modem control moves to the mctrl-gpio helpers
then the inversion belongs in the lookup table as
GPIO_ACTIVE_LOW and this code goes away entirely. I'm looking
into that on your patch 8 mail and will answer there.

Worth noting that this drops Rio's patch rather than folds it -
none of his lines would survive the rewrite - so the credit
would have to move to the commit message body with a link to
his fix.

Thanks,
Michael
