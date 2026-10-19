Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6368048BD5B
	for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 07:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396663; cv=pass; b=SO4gIL8B3mk+AvRkRMeItHVDQ2bsmdvZuYCcJcuQRW2dTZ2kpWqpjdn88l0aLJVyEeWg5YckOXU6uk+mBIrdKdwohyCHJGS5k4VRapi84Bv3Ql62pxhHadIWFaJ+ZaBj79oxO7yjqAYFN4OPNWMeIU7/9yTh5Ooa7DjN3m4JFx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396663; c=relaxed/simple;
	bh=MPcEmjZPn0U1HR0YqbRJlGEJNlJcmuvq9yIqrqLbn/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p+0z3faj5KzBSq2Wdx30+N2c6ko3/VLIzLpW2tdZMCW2kMJgY54+s/Tg7b+2hq7hcyc2lABGeG6B9z/J60kBrsMRn7zomCM3mG/wxtxgGUgfvtkqB07V80lIgMjSEgaqGxvvfRRCEOQkTgImsUYtTxigkULS/Sj7ldpC8sAchzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JTuflbtj; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTuflbtj"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a06c60065fso365426b3a.1
        for <linux-input@vger.kernel.org>; Mon, 19 Oct 2026 00:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792396662; cv=none;
        d=google.com; s=arc-20260327;
        b=VEX/e2mOwHiC8Ja3PouUfpCI6qmvgPWKmlBRhXAqg6i5ofqhOq0ivEtDZ/5bwIUCsI
         PUZXFVCuFq1qPCekZIvVcrl4WnkVym6XaAI5EK7Ynz1iTMMfMq1n/Qvp1Ys1IY7+tBXW
         64FfdmGdfF+AB2oQxApZ69FgMqD5+lIUJIzufISK8fRSnmm0HWVAazMGHKmasS+fFqWZ
         uvj7lz2b88FsvwRYte68qTj+146qbkyMqO/+Zpv5rJmKekA46dyrnFSfN/7mgndLgESi
         Iq+hVQQgWf7Cqqi43FexpEzMxkPFuiflrGsjlQUCtwsz7gfP1pgzPN4IH13AEdhb1HM6
         VH4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MPcEmjZPn0U1HR0YqbRJlGEJNlJcmuvq9yIqrqLbn/k=;
        fh=+RzxpZ4u5ZYTGyO+MvL8xnpVagPmv3VjikXCb76CCkw=;
        b=Ma7/6py4IYPrwNPEPlm/GTAWUXFiLkOimmDBFAanvn1iz/fmCmWlSmEgKgaUYNWDeY
         x69KyGBVBjb2lC0llFThmhb1flSsws59tkPyVg8fXpOJFAIyuQuyDR87SpIpiw5p1d2C
         /ciwdMjaU39luNR3+JvdKrXmNZkzkculmtKTd+ULdm19siO5vEm0B32BqsQcpbtSjaCk
         foK0GM55H+Va7+XktOsk0BQYMOz7xfc07ai2kd784bzxVBgwRWhSzSVCXwhHvZ3zI/K9
         GFmK1S8hwvmcawKyig4CzINPxSyjOXw4ksJ5IoIm7LZN9W0oKK/8zV+6Sp5tINSnAqct
         2dmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792396662; x=1793001462; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MPcEmjZPn0U1HR0YqbRJlGEJNlJcmuvq9yIqrqLbn/k=;
        b=JTuflbtjqRg0kNyO3t8Scwuwio0mdIoM/hFSJxzrmOl7mrVni/ryJ1Jpf1H16IaAH7
         EMJ8J1Hr/wyJumDoouhgMsbMBLETo3OdNpvvgwVVbpYYAvW4SidOU6agPx17dlPDPTzU
         ydh6yghiottVbZPC0+mCFnc23HpgJ4wh3xeyUf99hmxvMnDndGsh/vW7DPLmuAa1lyDf
         O71+3GHpcpSJzsFT4nGZzuFH8G3AXcmnwkgChAY89+qziSHkEnLVafHdAVleIc3KL8Rg
         kmYQeKLq+fN+7DcpJKDIemtjp4g7WJ8FerVImtT6nsyMJ0oM+qSTTFjhWgkdlDpv5qEd
         QLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792396662; x=1793001462;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MPcEmjZPn0U1HR0YqbRJlGEJNlJcmuvq9yIqrqLbn/k=;
        b=KXxq0G8XZRmBkX5i4AQ0rYByihnD5BYq0OxdhmM9HtHPwL/QZYvYaXV2vZfYHbZF+t
         5sh1C3RreGXuUL3PGyX143baJwArI4+WnGYZLzJeEpxnX8eiut5t3bVlBiRUd9/t/lVi
         KFnt2xLo081y/q13LGwQ9Rxs75AEf3dpuCvKucHGJ/ZvOU0K0Txf1dAuAgmoya+RBLro
         dPR+G8aR85XMYJe63bTV0uBskpjKU7gNkViR5M582oHSOX7bkmZ5GAd5YABYWmWIPFiK
         Bmjz6eTLRI1RGhjmn8Jz7Peb6LlgSYpZKj0/QLbdE3bMcPrssFYyfB2092cmyeI2vJca
         WU8A==
X-Forwarded-Encrypted: i=1; AKwUvBx50JXBM0e86VegBghWTTx/YlMj+Q/aT5vMLhvmaAC53t+8VouT39FjznhJ/bdqtoatNkIVcJivISsEew==@vger.kernel.org
X-Gm-Message-State: AFq9FYJBkaMdDD+eo0SepqxMwYZ/3zYNGkdSLxj5SYHogSDK+pu3W/IK
	WteZYcPir267cNErZWKMIYpK40v/V9IjcGVPhfXFIO54zMgGv1T5ytWJbQjQruDAL1qoG/hiyde
	4w3L5jeg9XSgrzRjjk4QZCtnr5VAUWcw=
X-Gm-Gg: AYBFou1pv7nTx7g8y9kRHMN1OQBeUkdoFjKJtbEZekL1MXRfTIY/fioCBm9puSn3WDd
	KItHrSuAooZeb8TI4q7TGqUoOrJMFqcX1W79q3udeXMCwNDEDjBuaOcwV9J+nHPGpi7rYuZYsz5
	t7ILQvv8SrkEriLie11ZJyvy8dcxGb3E9qDTeE0m6UH7cauMUuPgdsVzMxnX189kECSB236M+ew
	C+n4zrymMinO6KiZAWG4XL6/XSgbNnHsdaG4RI0FZGxKEoJDYo9CWycVH9xMsA4xVHj1dEKMbYV
	xscq8olIVcyki09vuY8BzcxQeYCDophwAp53k9+DLwbcUMcQdkBf2GHUsb7uOF1jJjvD9gdwCZY
	V54a6HH7eCdyjl+ZWOZcegLwnp+OzjVGOkEQM//rW2UW4HIG1ovT0l0KN3b2cV4J8PtiOcikWzs
	wjInOctw==
X-Received: by 2002:a05:6a00:f8c:b0:874:705d:f64e with SMTP id
 d2e1a72fcca58-8a04ba30be6mr5022138b3a.28.1792396661246; Mon, 19 Oct 2026
 00:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261017140827.290666-1-lukapanio@gmail.com> <20261017140827.290666-7-lukapanio@gmail.com>
 <atW_DkB9H0oV6U8v@monoceros>
In-Reply-To: <atW_DkB9H0oV6U8v@monoceros>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 19 Oct 2026 09:57:28 +0200
X-Gm-Features: AclHuK-MehupUeh6pNNKQQ7CplFtLMUS6VR_BXN9elAOlhRnJMBhoDSEjrXhQXI
Message-ID: <CACi=Ov77_J3N=5UoY8A9XRuQgcprojpV=KahGQ9e3gZz_yErqA@mail.gmail.com>
Subject: Re: [PATCH 6/7] Input: edt-ft5x06 - add SPI transport and FT8722 support
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org, 
	devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks Uwe, both make sense, will fix in v2.
