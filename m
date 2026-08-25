Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678553E7BCC
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654766; cv=none; b=g08XmfKk80BrfZVoJ2VgN94NyDZvwdph+skekYDfbmSRsk2SeKStpg76F4/iAALP/luOF1jnckjxjx50KT6aiwGLZdzGOcret0o2TXgyG4x41CaYPkHyz7l9qr74qXxStgp0z1k6CNbN7Yrjl8Mm1t3HxpN6UzWgMVA0h5mzfiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654766; c=relaxed/simple;
	bh=KoWnSXBGaCj0jbCTvpHVOuxUQJsRstO2RferBywnX+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jjBt7oWiVioi+sleApZwe5QH2KaZDmLdf1qekoGoY2tnHcoLEU5v7652kHLT44BWvySBJKbiKZtcSLwjDLPHRojAmNy7L00NFYJBOzEQhG6YeiMiUZuHWSQZhrh/yKJ8K7bV7vWA361EGtMhYDBDWEJVYe4a9XSE4GimHrBaXyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHtFIvj+; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHtFIvj+"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84847482584so478881b3a.0
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654765; x=1788259565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bUuxtBGmNOQbmRdHfy9LEMAv45qzxqGeH6c6o8+FBaw=;
        b=AHtFIvj+/BQoViIcSXaft0hLMxSXaiwmktIVpdOYjaXN/Ax8LzXgnN6Ee6ipbkHDtp
         qLGHd1InfT8gELovqTATjtQXnx1BOzcMONxuqj4+Uq3x0abr3WTnGhRswGQMUtlAOLps
         +5AhgL+2btxtvntx462ZCXyJCiCork6jLKW/uwp9+wGt9vl5NuxaxdkbbolEm59wOfoK
         hqcdHyreG28jgKvbF535nXiabcEEoRQ9cQ8YiPGhn1tvhTggXU98KbGVgETTY3IdnM3P
         FUnWinXPGt2iwhyIYFNIapd1UgNccqDRwKolLMwbEbMcYZDGzE5xFqAzTeCUrByHjE3g
         bh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654765; x=1788259565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bUuxtBGmNOQbmRdHfy9LEMAv45qzxqGeH6c6o8+FBaw=;
        b=oFul2EHqxhvdZGkKgjHXOVQbFNFbIubU6Qv7ass7VdE+xjpvnHruD03DPo9PCHW1v1
         9vEkmYSFNzfQeY5QhIO2pDHlrR4ZRDDyY15aHrMDZln1yH2P7+45Zndx0dT47SN4AIjo
         pWhyu0NsPjPRqGFJaoUt81p4xFD7ToXGM9J8uPVCFOHB4VkeP7lMA70O3iZJNvxkiUdr
         7FKsmYCiLa8ATcJxHsqb6aL2zRviQ5jPYZcEq3wbvw3KHlDyzjGDjVt2n3yZFUj5CPhb
         9xmSrWcE8Qjmt2+IaJfoWO8tnmor0QrRnf5Sp+sPP98zgYC9sw9lnxWe7rL45Zs4vK6O
         em6A==
X-Forwarded-Encrypted: i=1; AHgh+RoxHxDkJh6smpb+QfGbhiHPlk4+VRB4BjyONwHZ+/Z/g8MSR25hUeYYqnu7QE6vZgSXIAg4K8Cybl2DbQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kOhNOMkDu9EFY2GUQrBpq5Eo2M+XcvVJkUBBy+f9zb/GqZqWvM
	Wg6qFZPJIvOwUCooo8FAux5D1GC93hZTZXFQNPYeyp8luzPJ9HmptaHc
X-Gm-Gg: AR+sD104H5t53swRKReo5Ib4XfsS7k4Ze2vx43ocf2oA67WvZLnEWU2/ZM+/bjIwenM
	H2Q0l7h7/VT/aPTZOeA0xdth2zc9r4/qGVQI5y3rs2b2QpZVRD80LgMHtSnGtoKv5BH9gb3dQPj
	qFtLLid6/F3TyV2/y3YWOmfBTusySclQbrta1hXYeWd2eaiJuq/+KL5c1TIcfaV+ZU0myVrAQTP
	7+5ddqXrzQGRfpkMWFWKeTVzWWY6CIznmJd6lHtli2DyAKRfDIMnTgZ19KiyFiV0+eCLFv97/6f
	o3tX8J0kOrUc/StZiY3y/7dQNjobLOs8J3BmfKG3mzL/sSfNtwLYibM5nSoLMUn8XwGwN3fHOVJ
	AM5pT8j63IM/oPTkwoutbRYZzLDZAss4HbEFQ+Qjyf5VKdDcgHcwghk/bTFCxoVjzcqpDCo2ZjE
	WqEe/HESX8+4hnJvCEJRNqlVSmSuTYst5fIu9l2cBNOfH2iRqsgxNKkS+mBnC0QRkU9nANE6Upo
	hR83cqQYcg/R9dKuxDLgDGEO29MEkUnIomgr5hOdhQAjZwwAlKU3R7+uhduAUXqcUY/20K6u/0Q
	9bbfkjwMU2Gn6f/z776LEq5U
X-Received: by 2002:a05:6a00:1256:b0:84f:df11:b78e with SMTP id d2e1a72fcca58-8523ba7ac8cmr6307085b3a.2.1787654764552;
        Tue, 25 Aug 2026 03:46:04 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ef09d4esm3031755b3a.17.2026.08.25.03.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:46:04 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: aduggan@synaptics.com,
	bentiss@kernel.org,
	jikos@kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] Input: synaptics-rmi4 - fix irq[] overrun with 7 interrupt sources
Date: Tue, 25 Aug 2026 18:45:57 +0800
Message-ID: <20260825104557.15951-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825061027.105062-2-98lawweijie@gmail.com>
References: <20260825061027.105062-2-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by the v4 series:
https://lore.kernel.org/linux-input/20260825103123.12216-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing these bugs and I should have
acknowledged that in the earlier postings.  Neither diff is changed.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
