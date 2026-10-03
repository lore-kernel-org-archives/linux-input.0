Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B900345EAD
	for <linux-input@vger.kernel.org>; Sat,  3 Oct 2026 18:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791053106; cv=none; b=EY5+C15ln1t1wfMiK8uXezursYskAe/0ZnieDvdQmXAcvfiDZ+5h+z1UUH9wDovYsqAYmqLR2Wmet18Nej0cI+l5WkLL7vbeLYgAfdM64lvw6msaFNSm3xL6Kb9eUpaAU61MfgXbr7df3rm17nbXLXEUGWcGg9LcBPaSGRFuTlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791053106; c=relaxed/simple;
	bh=zkssaX7fnkDc+x6aCkdXY3ObHAFxkiEVjiZd3OTMEDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i5GLzG0K6oL1qRrm20j9hrl/tmaGKRc7fPwotcAkd1XjiOazpBHO4vYbJYtCN11TnbreXQyeOHeIboEL2nMc5UKucWyZohysbHeY2D03iX7Tdz2ubZHH/6Qg6u+1a5DUd+5lK9SxVq+5eue6E8rMSXlJpXT965rntX5QtviNV0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLQeRUKj; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLQeRUKj"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffe281cb1so4853575e9.1
        for <linux-input@vger.kernel.org>; Sat, 03 Oct 2026 11:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791053103; x=1791657903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=djtqvvNIWPRflD8Kc+E4AOFA+52E0tOwKn2avDlsL70=;
        b=MLQeRUKjFdDQnuyu0HBn7Dlza7jShYOsC2KPpgjatvc/DX8Saits3acwGLJuF7msim
         4r6NLudViYA3IjMMxs4xRTRH1LjHI0JKUzj6suoYPeHLcfi3swx0ZLznrcctTsho/Wy3
         8zsmJnVkAI/PVqenenOftqkx2a5pZcN3zIHE1bW337UwG1ctLZVN0J1WSbv3V3bfI1in
         iZgo8aAbf9fEMd3IBmgZAySCNds/Xnu2Ec3xUZ51n0Fu/ZGv+ARf9LR/ykDNL5FyC7ws
         PFrWPt6mrmUu9z2nbmWhrG+gd+c04CfHhlMfKGP2lWP6Og9uejtPbjK/pFJe73ZuLaM/
         RMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791053103; x=1791657903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=djtqvvNIWPRflD8Kc+E4AOFA+52E0tOwKn2avDlsL70=;
        b=sk5qHmIuG3Lz8PXhOs1Pm8XirWQT7s39BRKoR3Cd/1em6wi7DjlWq+1RZ57MPzVGOI
         mWC4UFGhn+pTdaE+Q2l4QbcWTHDlmcTV1uh9JRT8TxbVJ/31O0IbaCCouZcXgCFmeSQn
         Op46xBu8mirruj9Dg3CqKlOFBLOQizIkHhtDbhZaQZgwP4sxPs3n47wg9dnP4xSIHqdj
         KJL4igfieW5SPehcqy+EBPYKe+UgVAMB52R8746bfm8RL0Ag29JriX7VtjcYFl2mCPgt
         YzqQooevppeNTyoTXsIrbK7JPlZmnu+zHGxL1ue3jzf5vZ7Z9G/RpKnzTUD3adp4N+Hl
         hCmw==
X-Forwarded-Encrypted: i=1; AKwUvByhZKR9aC6FWkmQSVLXCpD+x/vnl4wnkxTy8rUk+v15b9DG8b/yIadNV75dfttFw9gLyOUnzuX51LiO3g==@vger.kernel.org
X-Gm-Message-State: AFuF++nq+VZ7OLveDm0d7uAAkhzie28V5gJfDQDBKffjDbvItbj6IPyZ
	VwTfN3D7Qjcm9sGj0s9mzQ+ST38zNYGhdgnZNCn3AgfgLfnylTGL/2ow
X-Gm-Gg: AYBFou1CM/0kfbs4E7IALSB8UuPmEvNACjK5M0sA/qHkWumo/1J32q+uQDi0y6fj8V2
	jKOwET3zpsNN49otpNHyoe2huWn5vn5tzhtTvmtV31NeghIyKL0ZohhxlkGTQcJcS6VLKBidKDd
	Q7tuKF2mbmo4hUFkIeLRHqGsyGq6HYKlhCVLKGirxtXNnB8HEHJ1MHg9RQ8lnP/zO7xp32OYwTa
	1SuBMfeiEuCv1QmE4PbtCcRLIBGQdpSXDbW6hLA+TeHEiKOXrOZQeCr4jB0+Ey90UyWW1cZXiOm
	trjtcVPRg40aqyfu5dWwNz4YROsLyGWAO38Wi6w/R+y5ZDt08QQ3F9s38sUXyXxjbd6v4AUo1xe
	htoQkg+1zGqUNY3Uail4JmMlcw1ay/4Y9fTG0xPkHeYIBRQ+HUV1r10JbskXuKiIZSsZbkz7hGc
	UHUiafxt7ETNK7iFgvCIngEKNxgv/PVNlHtqtdXH+kNUGyw47SzWf/t8cJIRhtOreZXxMMO/bCM
	21uXqgcI7+5r8xVKfpOD/rR4Cvxs65QfIbmPdPsAqgedz/CGbfWV9tZgPT4pGIg5ngeUA8=
X-Received: by 2002:a05:600c:a404:b0:4a1:6af7:9c23 with SMTP id 5b1f17b1804b1-4a16af7a0d6mr31350755e9.7.1791053103279;
        Sat, 03 Oct 2026 11:45:03 -0700 (PDT)
Received: from localhost ([188.234.148.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027740a2fsm222261035e9.13.2026.10.03.11.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 11:45:02 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: jikos@kernel.org,
	bentiss@kernel.org,
	tiwai@suse.de
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] the Topping M62's vendor controls, on the component framework
Date: Sat,  3 Oct 2026 23:44:59 +0500
Message-ID: <20261003184459.35138-1-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930213322.32454-1-mikhail.v.gavrilov@gmail.com>
References: <20260930213322.32454-1-mikhail.v.gavrilov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Superseded by v8, which moves the controls into snd-usb-audio and
renames the HID driver to hid-topping:
https://lore.kernel.org/all/20261003184217.34671-1-mikhail.v.gavrilov@gmail.com/

-- 
Thanks,
Mikhail.
