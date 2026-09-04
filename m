Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84836D9EE
	for <linux-input@vger.kernel.org>; Fri,  4 Sep 2026 21:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788556628; cv=none; b=T6Sv2laFeslYbPDUwBYI8+kGDh3A3X7dIYAEL4wNxM1jnvdOHoAe2IVsvmBq5TOz+jYd7XT5L1YQpMqr6RuzPxvVJ7WP845drLlU6dE5/g/YGmJrLRc5ph8h5yGj9s2Ln3VrJmd2RpYaED8LB0Jh0lCFULg4QrQowXBtYIp2sxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788556628; c=relaxed/simple;
	bh=fbcfuCNP59X+xpC5IcevYHcbPlbySqO8B0ppbV4rWIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaoJdr6QlD90Z0miioK5PFqb5oJTrEIbF00uL06iQRM91RGBSfGOuvHb2QVTn2txhetU885pRHdVhauX1LlaDjaO9g7kDUe/Bu/+XMmwRfFcDnBNf2pciX8bre4b8TWP2gkPtuIzK0VqcZ19vXpgJBO/FJ6gKB12c744/8FE4dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PawRyZl3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PawRyZl3"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso12817415e9.1
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2026 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788556625; x=1789161425; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QMge+xrP5bwgHdzm4UEAERiB2kJzyUIFVLBR/fB/uZk=;
        b=PawRyZl30RpsIFWClGmdd5nmrJpROzKDJfL5WiC3/1bYqUf+GJfpC7BOgtce7NkiJZ
         +fw1/nLgFZBbiMdda4pZaXaOs8+Aknc74gh+XfsCqlYuEupkBcTv67FPaCMJ0VkDcSgU
         TvdMer0cq5zfEH94Io+tmQXiV5hVPKj0mh8bWaHE+m7k6lW3ns/x860RAVO+OZuZ/Knw
         F8WV1nHKz4xEtcMz7WmoHYfGL7UeyNX4wZjBKQ7jBXxVg20FdVDkLtGcGHONTbvGsfOI
         Ihm3yCF/s6CY4FTkKK+43P6fA1JXmv8wQgG1TY3VY5g+rWQ5E6sElA//aGg+4P+gCfgQ
         zGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788556625; x=1789161425;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QMge+xrP5bwgHdzm4UEAERiB2kJzyUIFVLBR/fB/uZk=;
        b=F9lxlqvVrgAc+3aG5a+rxvDHHDNy60XvvGtGtcQ0G2jQk4fkSriqaCadUp3e9uoXbV
         xFhaZV6tcOuYBubcw2/0fA+i6aOErdmwjXlsVHo3mcIm1GvdOZgukpD8A7bgrN06xIeC
         ttQOFe1CWz7jZpu0CnyG7i5AlARHKF0BlFRdOd7zwNSSAqPH2WNtUl8sovk3+UbornD0
         /d71HTisLInZzHfeM7UlfE0DldFhmKDlKhbAyBZ/0iDlasCLyGY+xCKFdqBNiUc9Y3ub
         9E+L+IBD7MERPRZG5SMiInzeeowz8p7CxeO0SqwhJSGfhIQNl4BAuK09YWWXUDhlAXCi
         VYRA==
X-Gm-Message-State: AFuF++m8FZ10YfUFQJZhDNrtcQ0E2tMnDAXKc+tFU8PS/IcMXuFdU9bZ
	9B7q9qzBqaaRxX5PmaIdLHNOTV46E21M1mxkXNQ6S5rSsFiasAziBjosXn91
X-Gm-Gg: AYBFou388PJI194Ww5cbR+bSDnGQX9NJugPajoEqDy7ld4o2bjZiBVRrxyuKjF9WY1V
	7UNO0JMhZB1J75rmRqqzm3CUHL8JHiQwMcOznybQ6VYlHiipkNGHJwqWWq8pEZCdY6ZCR7SH7kl
	j710SW5fi2FOGrAun68z/SnNNKiQAOAP8B5JKExROp1Rs7GKHmWSpjL921vCYhNS/z2egTeQD/j
	I+FhbunLmnUsYaRAdSRwsiZsrnRGcj2jc8eTJSTYA7bBbyUVLSNy2wAtgZtOWeMcgG+dv9WKKbe
	OAO5foGYVIbtPlW/OxYUYsN4vt9TXbEh52A0d2dSK6+J4yfltNAAeLIfK0zrrNOCZjOXPN0iQNU
	DXlTSGzH/PXlsqj/WWFoHdoYbeayIL7nxng90E2W9fvM/Ah4cGmP7ZWy9Yc80SqsrIjf4p+UOzX
	nhFStLmFKgBvgdjq8ZMVrxp7ZXGzibwc/VyS6pMdqvLtCF+6lCu2LTMKO/kxYG4jCL12DczYdsb
	EE=
X-Received: by 2002:a05:600c:350f:b0:499:b65d:124f with SMTP id 5b1f17b1804b1-49cf825d1dcmr82117795e9.11.1788556624926;
        Fri, 04 Sep 2026 14:17:04 -0700 (PDT)
Received: from kali (88-170-213-78.subs.proxad.net. [88.170.213.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce591f846sm102532995e9.1.2026.09.04.14.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 14:17:03 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Derek J. Clark <derekjohn.clark@gmail.com>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] HID: hid-oxp: use cancel_delayed_work_sync() in remove
Date: Fri, 04 Sep 2026 21:17:02 -0000
Message-ID: <178855662286.3192124.2102579968112413785@gmail.com>
In-Reply-To: <949B786B-375B-4F2F-B209-C135EC62E1A5@gmail.com>
References: <20260904105800.3923987-1-tristmd@gmail.com>
 <949B786B-375B-4F2F-B209-C135EC62E1A5@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Derek,

Thanks for the review.

One thing the Sashiko bot flagged, and I think it's valid: if
oxp_hid_probe() returns early on an unknown usage page (the
default: return 0 path), the delayed work items are never
initialized via INIT_DELAYED_WORK().  In that case,
cancel_delayed_work_sync() in remove() would call __flush_work()
on a zero-filled work struct, which hits WARN_ON(!work->func).

The non-sync cancel_delayed_work() didn't trigger this because it
never calls __flush_work().

Do you think this path is actually reachable in practice, or are
the usage page IDs exhaustive for all matched devices?  If it can
happen, I can send a v2 that guards the cancels.

Thanks,
Tristan
