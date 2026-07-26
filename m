Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0E2D0C62
	for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 13:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785074187; cv=none; b=ZPTnMeJcrtRz9z8n1gu6neRk7XROwbNOeW2f91HMakPC2nDK6GO/nXZXLXJrhy85C+0PLH4H8hezH3dYEEfchtA8tiNHmlxCrB7koaiT2GU/JsAbMQRnP1q3wNDwX/d4e8Aikm8IE9LMMrn9HkGF1kvH5ZXyWITqOCR5DNAYN48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785074187; c=relaxed/simple;
	bh=LpjBxQ2p7x/wX5TlGebObtsoxAOBnpAFT915OamIKmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JCfW07AASsfM5Pr2Z4OcZdci7w9kMQJZvw0lzwSBgv2FVYXxNbakFLuvgzgaDQ6VXYXcmJWAxGSnIQg3gPST5uyl9bWYHhYpCq6cuI7byKJLkbC8TM0P1c3W70X+ALZTHxP2+zSz/9YbCdFxUWwCT4L+RNBGRuMZeyr0+s62PdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=Mh54+Oy1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0sec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b="Mh54+Oy1"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-496b7622a83so5724145e9.2
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1785074184; x=1785678984; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LpjBxQ2p7x/wX5TlGebObtsoxAOBnpAFT915OamIKmo=;
        b=Mh54+Oy1rjSgOlBKHZIf/vtI4OSm946jiMpN/7EBb6npEdVLmQRBTtaQVEdyO3LqNN
         UY96sTS3VPM60iXtrQpcjL9pAzT4dMj5rNjCjU2fZnZlg9rc3xoQwcKyA2Mw3PaIamd7
         Is5N3bjDvSK3a8595kF73kJJNKfajxAj8RSpKU9UjVfTwxf9uomU02U1OsOUByFFP6NZ
         mNoV1DwQR+fDdbJDQnDlgNtoCGcynLFjdeCshCcsCmJm+9jNwbAvqL6vxIzF2ucf04eG
         Ew80aM24UmwP+QCoddh5/WjEZyKuX1o2FhB9HrtTm1o/HlsXDvn2VQ/X6Z+e9m0Uupco
         KpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785074184; x=1785678984;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LpjBxQ2p7x/wX5TlGebObtsoxAOBnpAFT915OamIKmo=;
        b=MnikI3dKY9aR7A5K+YRRRGa8meM+jvpJKgawSfYEsQTGmqqnGQ5b3J5VXmolo9rP7q
         8pWJge2uwUBcOBc4b23RSyB1jhYn5oHNOIAMg9LPKPszx06vulZMxO8z8q4CuAA9HqsT
         cNryl1l64YWX0I2cVialakn2KNMvMkqJeaPg746odtKiJDVCV43P66qRUF319iF2VUDw
         /sfk4nWhOxayslFIq6kyb17M1FSBFRXT81So0P06H3Ze+1YKDUtxEx5DInyxX4PjOkso
         mIsjYg2m7mAtMw/V4nNMS1ZLcNbokYt6/TsWTstShz/OOLOczBFYac6t3kNOI/74wDSE
         Fhow==
X-Forwarded-Encrypted: i=1; AHgh+Ro6m0b+rZls1LKEwnSGzrnU7ZzqGn4ykhZe29KRF0dFgzEPCp4Dfrqrptpbj911OJ0YLvIqJsLmepKeYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCHpFg4MbY6Kk6Xg9YZNb5pXxaoZIdz3ItpujxhVSul+svUXb
	P55uGs7Fe4ZNNqUzLpQEROMUzIDeN19BTIW/K0Z0DTxsgtmtjZR8VH+p2N3wsFHA9S/GfEGFMCQ
	HXZoohw==
X-Gm-Gg: AR+sD13Z4CmKt67QOsIP9VFDpadTShY7SRTaDjUajj12mYYVa/KqLUXoOCZTcs8Z9DJ
	tpi7l0UHL9isBnx7pSns5l2tClm2VfXsbi0XdVzeLOjsGjYUXwXRgLOvywq1E8VUI1LxjB2yKI3
	YV333bQBfI5t9DfEGy2e6V7LWv4/MTpycwbHB0V6ZIxQpJnIDASy/HdPdFyfN2GRHO8Ek0TKY/j
	X6uTQuS9M9xLj53ofNL4LAXCUb2tqkCjy9CXS98wiR1cdlPhafdJYQnYWyINd/s3pNqjuW7c86D
	Jvaw+RyXMowlGbI2yFRGVoiEqaTaRggSxBaibIyUeR4/sv1TjvlepGEd04pycc1huujt5afyFz9
	CWU3woLeOVR2VYWmyadGYO4jdTUaiaeGG9vjgQvqlG/aRJ87Y12SsXOYzj62I/KvYctuujFhb9P
	z0QFwr/lOD5gEP3xjbPB0GGAT20w6I+bVAiU9jVZV8rf9fw+WKCdfn9J8LtfYuHxY3NuVHID61s
	csSCvdeQNI3zWrbIJfm2Hw2KuxG5oU+fJI=
X-Received: by 2002:a05:600c:4583:b0:495:7426:c392 with SMTP id 5b1f17b1804b1-496b57108dcmr67870595e9.1.1785074184499;
        Sun, 26 Jul 2026 06:56:24 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.222.64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6f076sm41322082f8f.34.2026.07.26.06.56.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 06:56:24 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: sashiko-bot@kernel.org
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: sony: clean up device list on probe failure
Date: Sun, 26 Jul 2026 15:56:22 +0200
Message-ID: <20260726135622.93531-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726124551.15323-1-doruk@0sec.ai>
References: <20260726124551.15323-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, Jul 26, 2026 at 01:04:00PM +0000, sashiko-bot@kernel.org wrote:
> [Critical] Multiple HID collections in a malicious device cause
> permanent IDA leak and list corruption.

Good catch. A second call to sony_input_configured() would re-allocate
the IDA and double-add to the global list. The fix is a one-line guard
checking sc->device_id >= 0, but it depends on the device_id = -1
initialization from this probe-list cleanup patch. I'll send it once
this one lands.

> [Critical] Missing usb_kill_urb() in sony_remove() leads to a
> Use-After-Free and DMA to freed memory when the URB completes.

This is the ghl_poke_timer/ghl_urb UAF I sent as a separate patch on
July 24:
https://lore.kernel.org/linux-input/20260724142703.55813-1-doruk@0sec.ai/

> [High] Unconditional calls to hid_hw_close(hdev) cause
> ll_open_count underflow for devices without battery support.

Confirmed — the err_close path calls hid_hw_close() even when the
device lacks SONY_BATTERY_SUPPORT and hid_hw_open() was never called.
A guard on the quirk would fix it. Separate issue from this patch.

-Doruk
