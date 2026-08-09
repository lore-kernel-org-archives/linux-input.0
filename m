Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17503A875A
	for <linux-input@vger.kernel.org>; Sun,  9 Aug 2026 07:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786261433; cv=pass; b=ac4vK8PYuv2b0pJ0ry3k4jPtL4x6uEY0GMhxWIclCHmS5xrU1EnE8Mhd7/BvJwcFDUQDRz2xsQHbV0KeRIJRg6fAFMcIQ0ZW758+Rpmmw2wKF0v92QtjMpDxSjE5EQPFYSNzMUogFCidPEh/KIWAVk7jm6HaUgjw19ms9L+Phnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786261433; c=relaxed/simple;
	bh=/05qgLE2p32zGsXwhgc3ZNNTDJgV+xekWeEwacpLC7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHyDRMEJKtow5vgB3gEPCKt/21l6h7UCUNop0c5aGT5lagQ0lDC45go/0oFVQ+gzPBhiE7bg+Y8CRin0BqZ8EXPYFpf4bY8nD8k8FpXwwx/2a9djNckG1hRV0VpNdB30IT1hko4eexdWhOxEBbHiq5HiumDGoIXR4N+X4MWSXkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azeron.eu; spf=pass smtp.mailfrom=azeron.eu; dkim=pass (2048-bit key) header.d=azeron.eu header.i=@azeron.eu header.b=g1QRG5gI; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=azeron.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=azeron.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=azeron.eu header.i=@azeron.eu header.b="g1QRG5gI"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c197eaaab00so121541666b.0
        for <linux-input@vger.kernel.org>; Sun, 09 Aug 2026 00:43:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786261430; cv=none;
        d=google.com; s=arc-20260327;
        b=GVOn2YBqaotspye9CROYUwqjd6h+vHmpXfruGj2W4fDjJtLt02zEy3P2AaTCzM6AYf
         /AnjOYc1o2pjh4SkYmPT4JRQ+Gn/ytZT00q9++hs19pjJdrkdvuVqfBpoMXY/pqKhnyV
         kYp60Xge4zbgGP63FnEjUfzhyfwHwn6+GeU6YzAa2rqLq5WsF4luKdGENgcmEYtMwkIe
         XZX410X62Tv2let+6GVt6VQCzQSw4y7L+0CsvnVlQR/c2OEjjmUP6BzeGnDd9B8qU/ar
         Ak+03McUhQIUljAtWrNppY2huohjwjjEhx/hVrqv2/0p9yI8Cb7u9IZKzfSRNCKV22sU
         p9GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/05qgLE2p32zGsXwhgc3ZNNTDJgV+xekWeEwacpLC7Q=;
        fh=UcC90ngqAqc4GNuOhC/QSbXA65W4AiKPQffaGXIAR9M=;
        b=WWr4KmtPs9dnxMAx77cqjrkm6R4uCPP8H70bbJTbCrP5nf1e3KE2veYR6LUsyh41Zx
         p3q9uG+q+V2T0ZlHWgVCJj4a5mzg9IRUkpteDcWb+pMOqAI8S6PpIjaER1ykfWyea59Z
         KOMJFAQ9Y728p8cdRgIw5FtIOszUf5Bq6n9mPgG/QpNSX/qsvWBod3k8mLyP3nWO8D1z
         MHhwilBmO6W/j62q29Eg3UFBOPMIoKIBW4uASladGsaKtF/FxQN3mAnrFv9y4rB4Wchg
         M+OMU7pjf5txZtZQe7j9A7epWQgAT8GgV8h2+0tvB8z7xa8Uygh/wE1505Irs2ZmetvU
         lfrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=azeron.eu; s=google; t=1786261430; x=1786866230; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/05qgLE2p32zGsXwhgc3ZNNTDJgV+xekWeEwacpLC7Q=;
        b=g1QRG5gIJVHgtBG+A+cZT0Jfj1GhUSGXEuCs7j7olkVGCGJFrruOFPHecq21BsTXyw
         dar8d7197R2fSatzg3O189dM6xK7LzWSePdtArhDVKxeKxDs5r9GfGorwJvZAuRTeyeE
         mttqrs8ZSrjnb+zJLByWpwrGIKPofvw8oEhi6c2sKC/UGQLpmAWAOLklr8GolUoRODM7
         vVVYG5OQCpGDzJz2VAbNyUgM1f2tATuCSXEvD/L/dH5eeemGpLylXPGBn2lQEMGPGpKo
         amCTALPXk4Yepui6oxKPeQAEctKSr6g2AHDuccjhnD/yvFfPX+EtyS+2QqSHYlY1DsMl
         s6WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786261430; x=1786866230;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/05qgLE2p32zGsXwhgc3ZNNTDJgV+xekWeEwacpLC7Q=;
        b=FhCaLsD8+KaO6EqLVqKyiH5GIFsJSr/4L9yIoDzk9V1nOYjiNdUTSb3/49oVM0dJRD
         1s4FDI9FN+PMKRSH2c+MTLqF+646E32L/EmsBgHwfDSsFURxbkEdRPk9wIuMoza3xWaB
         EH9CIJ1cNEUBislFNSnROhn2RLZwxqMWcfepulFbZ4wCJ4mhoIdbuli71QY7Z4btMbgF
         +0M46aEXC6EklWVJA/JgTZMLDmP1myPw6w91TPrf0R/MKKUDCVB9MoioCmMmqMGdaWLc
         stgWhDNwNtZ1fcW0f3v3jUllVzOePmeBeaKp9NGsqoQcxCbCx9nsT8lma3XctbxUHUX1
         4YSQ==
X-Gm-Message-State: AOJu0YxEXnmBvosvCfrJh773KUnrL0hbFDM90jLqblnmMjGVcHxJagFR
	06lvbPPznyZdvnbHF3Ad7VVHStR9tR7+bhYEV3tpCGz4vQyrtRYEVWtDYe7Siebsd3tWZZKSh+z
	9mlNaNoQhIkAtM7U5X7j/ingkpPEkuHCynemkB6/fQA==
X-Gm-Gg: AR+sD10HNM+671JdH2uIBm6lcaJHhP0P37RC+pbPbHBOYCtQJSgqCgSTFbg719avAtk
	uV1c/3gwTT5K8hG0O0tMsp3BmmaP1Uwg3JPwNfPP90KuUelzlYMWPQYHZIZb2YgFANmpSHGhGl5
	/pnJzUyuCSjUSgjez5zeN02pWMJNbF57Vgv1Ph3zkA0Amv9Pze8juCASAZEhUs1cdt3V7kS0Wi3
	Ff8ufUPKbuCIHSrML2Jw+dJfq+vCAMqyVaCvB/HbOVNYeIniAv5zt4dsrqVV63LJ7+hHnOlf1+c
	Sd1wBG8jc1i4TWzZDidIiC5u1FdbdJEIaOz8CPKjhFdySQ==
X-Received: by 2002:a17:907:6d0b:b0:c12:83da:7eeb with SMTP id
 a640c23a62f3a-c207ece5c9amr691125666b.19.1786261429179; Sun, 09 Aug 2026
 00:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619132821.18764-1-roberts.kursitis@azeron.eu> <20260619142256.208361-1-roberts.kursitis@azeron.eu>
In-Reply-To: <20260619142256.208361-1-roberts.kursitis@azeron.eu>
From: =?UTF-8?Q?Roberts_Kurs=C4=ABtis?= <roberts.kursitis@azeron.eu>
Date: Sun, 9 Aug 2026 10:43:38 +0300
X-Gm-Features: AUfX_myPJjQYOS-F1e896a2GS3QtX1v2rGmBoof081QdKKSENfbyuM4MmHFhF68
Message-ID: <CAKNRk2kDXag8g15Zz5zdnQRXS65GSr2xK6BtFg10bGcDVBRC5Q@mail.gmail.com>
Subject: Re: [PATCH v3] Input: xpad - add support for Azeron devices
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ping. This isn't in linux-next. Should I resend, or is there something
you want changed first?

Thanks!
Roberts
