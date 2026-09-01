Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583F143E064
	for <linux-input@vger.kernel.org>; Tue,  1 Sep 2026 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282395; cv=pass; b=kdEyeYwkkit4dySBnmWGDMK+ndbuOfkCCGWMJTn7tmPpOgcoYsAsA5X2X4r/cp2vRz3WfzJyp3Tizbb3cNNmKaLwPRpm22HXVuV9osRP6kI0NBTz/G8l01ldsABwFIa32JiT1gEm/1x6kTeOU84CSV/pueW3pxjR4xyhX8exR1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282395; c=relaxed/simple;
	bh=ycdTyrPhQXUQ/I2b8OalvQWSSmxwee6XBnK8rkMIcmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1YlzEdNysyg85uUFrs4EsfGCHDsuLt9shdQA6iks/B6cNSU8Tu3F6OlxLmm/K2FQVQuBD/wg4EU6fPPIulzv/LKWo2SymPbaqY4X1ck99rdUv+y+NQ3AijLHD4RRsxwW/GAfkeNAlG1qMDZKOELaDZbvpW4iaET4Mm1ALNJV98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z/AxyBc8; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/AxyBc8"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39f20d19895so463551fa.2
        for <linux-input@vger.kernel.org>; Tue, 01 Sep 2026 10:06:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788282392; cv=none;
        d=google.com; s=arc-20260327;
        b=LHmBQ5SICTp6ozqtNGVMEv6yZW9iSsSSEWbhPZCM5u4NYEBeiSE+BN3EZ8sLbh9F5S
         3nE6HAhyZZx3Vxb+vkqKCGxqprFEXPXEN4DeBjF+/tG9DICUKxkixqXaWfaU+v04UIMH
         kUJa+sOjjdShSopxpRWH9o9auHKXUooYmQoVBas9ddc+iHMRBwl8Xb3OuNky6mpz8x2N
         4XmXxbxR5bjnY6HPT81QHpnySjrcaGkpw8Nb5mc9yIf5pL+LhFTD1UWLDuHpMKYOVEVM
         ehOaBHnHrnkXHSOKKASODX7zsbVWvBuGoyxca3cjm76MRMLvCAFQPI5kTu+CdAgEsI3s
         7dsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f9MytIosFGt48eG5TjVcHQFGCzHmoJqgK7bwlJqaSz4=;
        fh=5pcUofcH2pGvU/LvbfMmzEABE5ebJMKQQKmCeeg9QLQ=;
        b=nUPE87feONi1VTREIJ5c780rOMbZ5Yx+ewnWud8AYqZYHOBK1K/wlw2pk51tGDQEV3
         z/d3KPnlDtKmnwVMK6NDEFx+k4DjfbwtziZLRXoJbkgieKRKWVKzmjCAUCylvl3xGgIN
         TdoV40HQxGIPlv1C1iw5ICxGVNL5/HPqdMmftXAZOU4+H25WjHm2dzZfBdS9W+OqMCuS
         eVP/S4513hv3jC1W3OR1wprai6XHPrYeCtS0x+lfoXr7sgxlsMebpf3NRAyg0ofX7wJf
         CySsXiv7zzda6uB0BrVNfDnNumki9tw8cvGcH7oYoYL4k5eczC9FMp86dIDAkusGdRRg
         2Irg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282392; x=1788887192; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f9MytIosFGt48eG5TjVcHQFGCzHmoJqgK7bwlJqaSz4=;
        b=Z/AxyBc8jeGqIb2sH/Dt36aKBFXTBEKvcweBrysqomwkOaAT4GgaSxcYyf7BjSKuSO
         q4H0LtRk04GMzF4qDlacp65IVjQTjZ/jdsKmBHJCEjS56Na9+cUtBH29U3mtwBI5xJfl
         dP7z/+tGs3Ztz53notsTGeaHwXEIhxz683TmggCeejU50+61DIlKAYQeBvqKuUCiCVRz
         ONnEYZNudyx16ekHJ1D5dCSJ0lpG31czO0eXlCIjgC3lrUhlHPXsg9utwc0MT2USKdt0
         0Njb0pA/Ha6Lx+HlrhypFrUGIcV8xw4NM/3qMa2ogUCQTe0x778c/yL/qd3WTYG550hb
         DeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282392; x=1788887192;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=f9MytIosFGt48eG5TjVcHQFGCzHmoJqgK7bwlJqaSz4=;
        b=ZIyS9ZHsIHoM9RmOuedmugj5lHB7WkLeYg9anb5B3hMge2aLw7mndcNbxwy/Zxv37x
         BTGaITW3ijI2cjxGsEWzu15MCgHoPqiPe3TjFSMv9RMdPbCg/SBLp6sJqm5ueih5Pa73
         bbTLYA+w2x7XZndUGA/oyEEPOHXqJ8zdgFLKWlg6S1irBZTq1lSFB1UMDuukNy8fNEBU
         /DmcKlCnPNqY9ZJdIeUK4s82jYzWIPszS2qUPadHCm9tDQSGMg6i9ByvJRqykojJNVXN
         NoJ9TkdfjgIFzYdOSD1F8A4MzzUVl9hzTpwuyatQIUmHJ1ghDujA1R0kIvfllBp9Q5gJ
         hjoQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5sC2WqhLEFOFat2f8WNoBmtRZyW790MmquyAkhAOx0xE0LE7piNiCof9jorHS/gFbtliTsRma++orMw==@vger.kernel.org
X-Gm-Message-State: AFuF++nx6UMS6TR804QvR8xDDbq8U5xjxGVcUfvxR1Y9n6JdNk99T/QI
	yJIW9wGeN82TI/FaYvHzD8k+/7wV5Ii6vCdtYmsw3lsdrRkMAeT0W+wWMwEy/h9n0d+uosqB+Qc
	0057S0B56Oh/C4ev+VBithpzGg9z0THc=
X-Gm-Gg: AYBFou0bMsHANK825cKinLQbdAfGtpLXQzokty3Tlxz3bTbDSn89lxw9TVOyup2ZF7K
	soUPRSp+tWj63P7qLZEcJzQCgNBIcGFhuGx/98iDV/Ttg0Q50btgwc6lv4NnESNwiTupGmHRFTg
	j5EqilnTWL5ZcaG3YhMJBQWe8okgqb6B99uIGA56TxBdKduMJM2o/E+F9ZXAkImkeb3Zhp7Ozyg
	J114O7/LD1zeMMzGpT0tI/7J9br6twWOG61JyL77Wz6z/aWDeXx7KrL6Gxk3Tlid7wRISjhTL/E
	Cro6r0Ok65mv+91JV62X0b3jKf3oMPcQRvVl5+lzMWO61eUAZvzp8/ElbJhfzAa80BiEFZlCIAz
	B
X-Received: by 2002:a2e:be11:0:b0:3a1:9562:732 with SMTP id
 38308e7fff4ca-3a30187d050mr71354831fa.1.1788282390447; Tue, 01 Sep 2026
 10:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788222001.git.mradityadash@gmail.com> <49b6e07395d2fe555e844758bd8ccf34ac0cbf0c.1788222001.git.mradityadash@gmail.com>
 <CAFqHKT=7xMJAvTt3__6CtBiS2duGu6eoHq4FWiGONMvjFE2CtA@mail.gmail.com>
In-Reply-To: <CAFqHKT=7xMJAvTt3__6CtBiS2duGu6eoHq4FWiGONMvjFE2CtA@mail.gmail.com>
From: Aditya <mradityadash@gmail.com>
Date: Tue, 1 Sep 2026 22:36:18 +0530
X-Gm-Features: AcwNN1VAAVCVwHi7cXEvli_7Pxy4HhQ7XleJWQRFpTT4Vki9EhB5WF0xAtt5n-w
Message-ID: <CAH7J6R-Vh7uEtG=+Shj0CVgxm1RNpuxjuEmNfLJevhTmCz_3Cg@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] HID: hid-lenovo-go: normalize calibration failure status
To: Derek John Clark <derekjohn.clark@gmail.com>
Cc: Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Derek,

Just to clarify, this behaviour was seen when sending a left
calibration joystick stop command when no calibration was
being performed.

Sending a respective start command returns after 10 seconds
with the error codes you have provided.

Here are the exact requests and responses. Consider ellipsis
to mean that the rest of it is zeros:

Left joystick calibration start:
Request:
    05 00 0c 04 03 01 ...
Response (after 10s, no movement):
    04 00 a0 02 03 02 02 07 ...

Left joystick calibration stop (when no calibration is running):
Request:
    05 00 0c 04 03 02 ...
Response (this is near immediate):
    04 00 a0 02 03 02 08 00 ...

Thanks,
Aditya
