Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02481C860B
	for <linux-input@vger.kernel.org>; Thu, 22 Jan 2026 00:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040610; cv=none; b=YsEzNcdlMzoD5lLOBG4+WmyfaA4a1Lhz0wGzBiEscZ7Wff1tJZF9mc3ER8SnkN66FBbywMrHu1iPktEMViAJ80f0ClrQLKOlg67fgUQhQKBAAelUPfoysWWBuRRy1NclJ3ZnasJmcHgTmm4CFwJHwTpYi1kRVmWbjnYjqr+V468=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040610; c=relaxed/simple;
	bh=y/PYEbYHM+BHKDZnhRrssZDje4LyLT9NI5UAsS8knDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmelipnERv0iI95qr9zxm5wcYktqD84ui/GKn9GMi6X9naRa6TUPAtNuYoHc8nZxDs5BCja5gsc8ULS+00DnCJBk69wFrAgdaJmcf1rS82eNp+JdW5lzgKcC8jDeHasxK5LSvo9tDcSXUEeVZ2fc2coPC9tI6tLoWTe3Cy3iNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpTiCUML; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpTiCUML"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4801d7c72a5so2919035e9.0
        for <linux-input@vger.kernel.org>; Wed, 21 Jan 2026 16:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769040604; x=1769645404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/PYEbYHM+BHKDZnhRrssZDje4LyLT9NI5UAsS8knDI=;
        b=gpTiCUMLEMJZzno1dSYDH6uBdiXER2gL941qHh4GiR22A8tmbAXG8itbNFDEaporkY
         E2LsPf2x8w70tmAXRkhPNDP0hoytBodDn/aHsBy6QP1h32S4qHxyAIDeI3QNKvsPpgln
         NCzwns73gCBNgBwfEnNdKYwDCmGrJDI0cWsWuMcE/kEZ1ys1lcDYw+TkqpYL/QJ6Zh93
         qbSp6fPIwwAq+jfS2GspjsmMOenS6ds8KdFofX7f51ZO9rXig0oUcNHATKnAdCfqo2zo
         ChRvbx9095YDjq16yeZY7WA26r2NU5fBYjkKoBj/0iARLiPKEZ9mTwtq7ZNG2UDWuezo
         nUYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040604; x=1769645404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y/PYEbYHM+BHKDZnhRrssZDje4LyLT9NI5UAsS8knDI=;
        b=de06K0IIWld35vzgpWdrItG4wgUTWPtSLPVX/U5qyp2CfSUQ9yZYmSSW//veZ9Oxqr
         /5mgHyCnUAKroloAMAVhWQACrKzJjk/xQLgmoQxX4yeJVlwqM6IKq/ciciKTUWp3qmCI
         4239OCh/ZqmZXzQjeaSq3gamwHu23iu7JhdHwL3QmAcBeDZT25NDZDdUqXFaSzNudeCk
         ciJtrQTrYL8tdQNm0Ob5KSh87IupC8mwL4dnEUnZdiRvtYZEs8LeA73NDC5Cm2Hj/LK2
         UnfDE4z8ZIL4bBRbXFBBNsImF2Jaz7ZtyxEyjH4J0fD0wxyzb7Ji/IaRGRWqkzdpYEZ2
         L4DA==
X-Gm-Message-State: AOJu0YwVMp7m4+U6aYZ2kf6/8ZY/es8JqxI+EahRj2gF3XLb9Ay59cBf
	HkojdbcQsKHBysN7fkTkVzPdv4PUBicDXjPzyay5i4TRmePlyx9tPZbY
X-Gm-Gg: AZuq6aIU2aVzVlPMBTW1h2mAwK4xb2AVnApnuGRFerrLzo4QUkVUsBF/8yXlvz3Z5W6
	xjCL/rrPmuUkDxawYWHX2ojUJP20qlc73HA6uKKbn20bZzcUInjdqXCQeLwwCZFYUsm2ETM1H8Y
	esb7MiEzEMc2PYtlQGOZtAkVV3uGqc286TtD6NYQO0NU5aWB2oKG9tdTOvE+MFghx+Kw4ymIroi
	wEOKVhjYsnwEPETjXdWJcODFbG+WUhR7LECbfHJLjWe6Epk1zUkCUmn736fNBAK9ZnX4D70+BO7
	jRefIwgsxXR8Cerre6tvrShG47qgNjkUm4ue9BqHoL2xiJ5/A3WytPaCOU5na/fw3pYiIGF0ozl
	7s26RFxBfx+JdPu9qYdBosgakefFwDppmvtGy4ESwsu0zEu6jzisKrfVzlHM0oOKpJ5Mus+GY6B
	ufBv0famTcv8D8YjxRrL4V1Vq8
X-Received: by 2002:a05:600c:c16b:b0:47e:e78a:c831 with SMTP id 5b1f17b1804b1-4801eb14ff0mr260400365e9.36.1769040604114;
        Wed, 21 Jan 2026 16:10:04 -0800 (PST)
Received: from unknown.tail46804.ts.net ([78.209.83.30])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-480470401cbsm24831815e9.4.2026.01.21.16.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:10:03 -0800 (PST)
From: Gianluca Boiano <morf3089@gmail.com>
To: hdegoede@redhat.com
Cc: linux-input@vger.kernel.org,
	dmitry.torokhov@gmail.com
Subject: Re: [PATCH 2/2] input: touchscreen: novatek-nvt-ts: Add support for NT36672A e7t variant
Date: Thu, 22 Jan 2026 01:09:56 +0100
Message-ID: <20260122000956.76443-1-morf3089@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <b4113f8c-0fbd-4a96-9cf6-9675f837ac91@kernel.org>
References: <b4113f8c-0fbd-4a96-9cf6-9675f837ac91@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hans,

Thanks for the suggestion. You're right that removing code is better than
adding more variants.

I've sent v3 which drops the wake_type check entirely, as you suggested.

Gianluca
