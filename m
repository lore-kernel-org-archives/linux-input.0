Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705CB2571DD
	for <linux-input@vger.kernel.org>; Mon,  6 Apr 2026 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494860; cv=none; b=n2IvCAPDLBGMIv3giU5WuD7efNJIzrUi5QdyuG/AiK4msp44eVIJtBZ7CpeYILL03IyxfCKVU2aE9tf79c8SgQIIDEwLT2BZwxm2vEXWTJ6Kw/dHmpNPuxEWkOMa12qmfgjVvj7TRe/RMu7BefirwyEbDVwyEao78n2INLsSuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494860; c=relaxed/simple;
	bh=8QXY/xHAvGSuZXvMIUIACvAJfxKoBGG5tRlmTQslQxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhkEwaTDMhrLuzGpApZEGt+oY5hPBQ7cILpBPbdC+J0kAV8LaSQV5Jl/Tqa9SXDra+2diTDOtWeLSoEOVfXEC0WqdL0GLnllWCHTk7jD6l46CdMZKngOwzdTfhadlrh64evWXtlSzRzjCFnoG75aKdWRZJR3w2zP2sGlCwDR8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mokdEd6I; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mokdEd6I"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12c15414820so274673c88.0
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775494858; x=1776099658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8QXY/xHAvGSuZXvMIUIACvAJfxKoBGG5tRlmTQslQxM=;
        b=mokdEd6IING8qLu/vjvj3pMkPOxyri37Sjw1FLohbmAoNtw8J4iQRICL3mNBoExn/q
         8H9dYpqHkVD52uZwoECL5BdfySpyHM9fnkgNwecC+Em1Y23eAJr+o0xA41Onw8Gnx+AD
         sUlA+F9/4YTCSyZAU83cWi3f2Lp+wvrfZrwKOhPqBM4N4ui45s/2UlTegIDKe5I6VeGa
         9kYLm7MQoWeNzk7PMXdwrmOFDyjFaFJ6mLutHP+1Z3ALeRFttRj4apDzyJFcuaDoaX/j
         QM0wTGsK0QmTbXP6ffUENOZgaGWmcjAe9VjzmE34AX6cGj43eEgbkoCEiq1YY7Xr+ioX
         o4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775494858; x=1776099658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8QXY/xHAvGSuZXvMIUIACvAJfxKoBGG5tRlmTQslQxM=;
        b=TkD6MbiXNimEX9nghdl/eZXjFk4Ui/HDV+2k4DM6R0rPeZIS+2vdDXnlYKSIHc7gNs
         GUo+E1aN3I8WFPVZZ0oAjumiEiQ6YNT4JW7qlb+dBJB1z7CBnQoP/gWe3eL9xbvsTir0
         qM00O7/6Tul3MN9Frd46lSoNgK6SVdrWVbv4rbigkm1nZ79YYQRdAhhhKUTKwKj4cAnq
         TNaQP8hVb/L9U41r33BXXqJKFeMp7froivbMmXhp9HkTak2siJmbKkR9EVZ0jMIk43iT
         FoLBimH0DrX8o+S9tInqM0xvZ/fLipi4rpyySyd7hWzlVFmi3eOpYsIPm5EO5T4neXaC
         +olg==
X-Forwarded-Encrypted: i=1; AJvYcCUMZSzzGqkehCvw36fPxoGPijdhFn7gbAwLY0wHn0U00xog70ccADeGCeBUvQo3LDz3XxbF3e4U+5Jcwg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy77DJNujXO27D112SYUAjGsN/cWPVyuD3mEfhU1m5fcIRoYcWg
	tvzBVnEfCM+W0XeHot93s6Sp40FZY4zBhxFHAImQ3JIz3hamAV3hn5LS
X-Gm-Gg: AeBDiesjFdhFIX4AfYF2ok+3UNIa5LOETY7T4m2J4tJt+NhPl51ZNk8QCjiMHuopD+v
	D2OgU5MDJYynXdQKUXPdVsZLmC6pz/inQ8Izf7nq+a2WUy2DXFzaAsKYm+/P+V0Edfo501v68ng
	oIaMEGsF39lU5EcGWkZqE8t6gURiOsWTT+kiWbYzmhom7cfjknHxkg8gOOPlgVAUBi3bk9544wb
	m1YMgylnYOyLDN/SlrhRFRCFLiz071V8xuRlMSEVxgCCIZfjIBr2X09RoP9X/6PNOWi72pwApr+
	L/ouh5QhaZwhnQxtakkLbLVsAPqnOEhmym3UxBFQS9pr2eHFCI6MDfmTKBMbDUWnx32hYUqL3Kx
	i7sxRZu0weFFr7jiSRwhni/e3PwqUAjUcu6ksLuUKIAb8NeovwFXNE2KNKFumKFNw70eZAyNTwx
	9+bpy8GRcI4U551870gNKuT1NQFzpv1iAYM7oVSL3zo8pGg2tB2MjM5waup9QaokNu6jDmKKMvY
	XPrvZnLsJWLTGD9w/bZ84sSVuyV5H3i+CTPXr1ZBJWuSrqwmBHUnBbawy8vfnJgCg==
X-Received: by 2002:a05:7022:1284:b0:119:e569:f86d with SMTP id a92af1059eb24-12bfaf4edeemr4414215c88.10.1775494858043;
        Mon, 06 Apr 2026 10:00:58 -0700 (PDT)
Received: from uf0ccb33743a85f.ant.amazon.com ([2601:642:4e01:ba30:bfe6:a9ff:a137:33b4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c05a7beffsm5972737c88.15.2026.04.06.10.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 10:00:57 -0700 (PDT)
From: Armando De Leon <auribe84@gmail.com>
X-Google-Original-From: Armando De Leon <learmand@amazon.com>
To: dmitry.torokhov@gmail.com
Cc: Armando De Leon <learmand@amazon.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: gpio-keys - add hibernation support
Date: Mon,  6 Apr 2026 09:58:06 -0700
Message-ID: <20260406165833.3137128-1-learmand@amazon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <adPdc2Z1SYxvqDmP@google.com>
References: <20260406160437.3084755-1-learmand@amazon.com> <adPdc2Z1SYxvqDmP@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Dmitry,

Thank you for the review.

The interrupt controller (GICv3) is re-initialized by platform
firmware during hibernate restore - this is expected behavior, not
a bug. The IRQ trigger type (EDGE_BOTH) was originally configured
by devm_request_any_context_irq() during probe(), which does not
run again after hibernate restore.

The TLMM/pinctrl registers are correctly saved and restored by the
platform's syscore_ops - I verified this with register dumps. The
issue is specifically that the IRQ trigger type configured at the
GIC level during probe is lost and not re-applied.

Should the generic IRQ core be responsible for restoring trigger
types across hibernate? Otherwise, consumer drivers like gpio-keys need to handle
this in their .restore callback.

Either way, gpio-keys currently lacks .freeze/.restore callbacks
entirely, which is needed for proper hibernation support.

Thanks,
Armando
