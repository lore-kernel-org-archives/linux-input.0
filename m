Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB1F2BEFEF
	for <linux-input@vger.kernel.org>; Sat,  1 Aug 2026 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785572654; cv=none; b=GgmDZJ1QhapbW/0tJQyIhLO8MgOubld7AIqNJ3c3RkFMak2r5at6UV0M+JQ7hsiYJbnyokO0extdf+8+tumYmm1I3L2dDZskU/nzAzUcYAP1YVJdumRoZUa1RU6MaYmyu55WuZcJDg26oBdE8Oal2VC5wXsg1dNM2+S9x0/MbJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785572654; c=relaxed/simple;
	bh=cO/RfmsdyKO4A//tbu1napYS2r6IRvYSwLN2LisWtaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjCByLXyu0ClIjBtVf5TIvEyycdy5ywvdFJOWrcsoWjUF0ws+/ezwExdW91Kgnijxne4+92x2Kwy8nh8C4PnlEA0W4qKY8x5GoW2avx997a01nnwLkq7nPOO5Q95B+1fVpTopLl44LVTnncJF16TZaOafGvJnSCluGqIl6WlPNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBQRyo8e; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBQRyo8e"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca913a601fbso1228664a12.3
        for <linux-input@vger.kernel.org>; Sat, 01 Aug 2026 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785572653; x=1786177453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cO/RfmsdyKO4A//tbu1napYS2r6IRvYSwLN2LisWtaQ=;
        b=CBQRyo8e07UY3LgAZemLYWaM63azIHlpZMCnOCTu4dl7xU6YhDtHYr0NqEQSTd8zHs
         /EzL1mCLdUvEmGB9vyMTGy7uIQcu7nsAqCRqvETncij/7PLQYUYK0pI1R02jXb5F91RG
         TJyKyGZWWt0XnfapIaFl9UgvoWHQhUiIwktTqVYsXHAk2Lw3mPlQ4tLjeGlq6JJl70mr
         +sNwnrVsPJns01X2qXI1IVWIwbAqaWuMEkzeX+foaiJQ3KX8wrj0js6XZgi/tRe/WVXA
         Hzf3awefPbEb8OpzBgHcLDtorGXoo9rokIbH51Uw5Uc4/ignhWpKzgUyfhMP2EZ6bsTA
         i5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785572653; x=1786177453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cO/RfmsdyKO4A//tbu1napYS2r6IRvYSwLN2LisWtaQ=;
        b=Y5j9QeRK3UB0z3oHExaTLHdXmEDZtN7m3/51FVrUmDRpJbJOBFZhkiwjMEw6enZ4VR
         T9gVnp6J6BOzI0RmA2C0HviJAHldDwhxxnGx/CrDVtwC8zLiQhJxQfTdBTX0DX5voYqN
         UHQHgdG0yaQ8Jf8+wAOl5uFibxWzkhve+ttTmkxNqBd22w3DbIJNx7xLReLZmhu7eLjZ
         NG5GjKaIkeV4nksZdiu6aeF7ivcxP3n3rTxJjPxSKBLtvRH+OsopfNncZuJyrqThhJFL
         GgI60yVjBOyUjt7oycGVlr/EONlt6LOXG/QayJPBk9Y5pCUGnH7moWivPq5q9zLFbGot
         Us0A==
X-Gm-Message-State: AOJu0YycnuN9AD6nEu1HREkWSK1zHHbPbTU+9b7OJBDQpMBhVR+p9i6o
	uGplSoUqOadD6AALxiEuZ+/NLFLFzTYxsB4jQ/zwKABkAP0dXMdm3zsUmzoUnxsInpsgw2j5
X-Gm-Gg: AR+sD13iRxyyGJH+dTwMo2ff/1ymTpzGq7DfnVwpPjNqJFKqN8hG+kfrz59/8YOeqeF
	scRIoPDH4LHgBAwrAorHQPE91ljEeuwcxm/FzfMYsmg46Cp6G5axCAmqshmepTtwayd/u7p58/q
	by/Zg5dPvjmWer00TWbidsquqmZmtuof026iNT6jmBG2e+9W2dLLANxLCtALJrk1ShMnp3OUeGK
	W4I/4GjJVQ0F9cGqdkK7khCdot+HBHjQnYBUG7XM+6NLKGUyZhrJ1ZlHXvAgyC1wghx8c9flRL5
	kUbkNY6zCwJiNmDHa1QNxdEVx0FwAEPd3LFsI27MFTxEufQm6f4e4UsxlnSNEaEfQH8H6xtbkNQ
	2sxDu3I/R/mTxE4IMxFaXcEjmn3XfDLh7OJ3lm3+4aJPUvqNk8HI/aqaiiiQZCrh3marCFsXVsO
	zZP65D1o2J7D/DGJtASQJfz4NKeUvBp9PE+77V8vOSqULTB9o1sk46X3pbOgqD2ujqGQZtNgv9a
	J5dvEeVxnIvrK+rNULqDg+KulijJq0=
X-Received: by 2002:a05:6a21:a91:b0:3c3:a6f0:80af with SMTP id adf61e73a8af0-3c92a84e06fmr2899407637.60.1785572652679;
        Sat, 01 Aug 2026 01:24:12 -0700 (PDT)
Received: from XiaomiLaptop (n112119120034.netvigator.com. [112.119.120.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e045016sm21479134eec.19.2026.08.01.01.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 01:24:12 -0700 (PDT)
From: Andrew Zhou <zhoulol888@gmail.com>
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH] Input: i8042 - add Xiaomi Book Pro 14 to dumbkbd quirk list
Date: Sat,  1 Aug 2026 16:24:01 +0800
Message-ID: <20260801082401.211093-1-zhoulol888@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718122437.11112-1-zhoulol888@gmail.com>
References: <20260718122437.11112-1-zhoulol888@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Gentle ping, since there was no response for 2 weeks.
