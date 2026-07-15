Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893A342BC31
	for <linux-input@vger.kernel.org>; Wed, 15 Jul 2026 03:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784087818; cv=none; b=E49vw9KYIgPeDolOvM0NmwFJEaoU+6dq79JwXYQISSO635DOPX9zOVPNLWiv0WZdHJEMCxz+w7CVWvSObz49VZg8Z/qr6RZVHaEWQeYRW0xC46EuZlOYixUwTdlrDrMap/q9uaoaSWr8eyhPRMJqB6faBfs5bNm9aOAz6mgfC3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784087818; c=relaxed/simple;
	bh=esZFnJeecnxv7hYjWEDn+YanZ7oAIfRsbQ+u0ljI4Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGEjQT4A+vBz7jHvZRa9CILfbJp+nwzuzCVGePHd9a8D4Lu2Qt6vcJARhhh7o5PLlHDcVco8lChhWXAlVkqB2YzrP3xKaRTWPLhQ0VYUFxvLZ1kt9qR8x8dOVUA9LmK/3jnGDEgLsEYChjgwmW44uqHqkAFG4bzgJotZ3lY3afg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3FNQ3Tj; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3FNQ3Tj"
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-4a46a53abc9so1186372b6e.3
        for <linux-input@vger.kernel.org>; Tue, 14 Jul 2026 20:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784087816; x=1784692616; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1bZeyniywTft0W36ipmfSXzH7qwrjZcLgWgGMdqV6U=;
        b=D3FNQ3TjYHy5g8TwMFOoV84tf1ZPM0jrGiO8dLJMQMP7KW/DOAGuK+roPsGCJve2v2
         aXYurNYO1lBpnEPEL05j2duK1RLE5i6Z/ATU1Kxi0F3k0dNxVJixurAC8DqMC0LNwqe7
         x94l5GVqTZoNs9D9IatrJ7d60zLPVFMgWyb4R1CYFx13j2HyjqmNVNyGxGFg54OdjjRT
         3k/bOyQAmj31R0EDMMPahJA31695ryfSripGKuxR4yTuKHhEULBitDBkqU7jMF4AvEG5
         xWZdonGaRrJjKEPMDAEI12lz57kHU8x0DwJsuf0vptLQAWprqj5y3IU3qWBrAWDfoRAe
         fYiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784087816; x=1784692616;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1bZeyniywTft0W36ipmfSXzH7qwrjZcLgWgGMdqV6U=;
        b=Flqt2a62PfVnitD0niBOO4dkDXanw2u9fBsKS8X18OCrEe6N6UKmyfvu/LAIl2JdTK
         VFhYk3sNqxyBiV2T9NaXtzO15jPLjq1X3ebp8pi+J3ZE5nnWMysQWxgdlnwUHXMOREI9
         GukiEYYWN+7j+KmshJNiINZ+B0KQ/LvIV9u4Qdq9UYH5wlbjJheQsUIZIhGFEiqtc9q9
         3AgWwryXX+GswH7ogJ0Mz+MKm8oy04VxAc/KAaMBarYacVpTe/V/B9BCoNBgpk4Aa4gQ
         Dav6XTYF9R2+J4qsIny/0Toj1Fh6yXr7zOg+pQnVk2NDZGlrfxkEAsKt8OuFxDrzFF2o
         +iWg==
X-Forwarded-Encrypted: i=1; AHgh+RqFy0PpkBlwiSi+WbgSwkMIslxoDz5dJHN4eJ9o/xPZa8u0LtrrN5hxe69s00DlYcwqswOdZM3ytnbq6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwUyFaM8Te0hrUljpKgbJU8JJsoHswYbEgIarL/MPJORoGC4Ig9
	HMqOn8wSYK9Vo6I38zw8GKkrM3paApjSn5PJw/krjTVJeyQsEtvyRHMp
X-Gm-Gg: AfdE7cmSiXWgrUPKdOX231MyjCu5Oup0UNr8WWG8ltKmpH6KtvsLdxjfdoBrC5DW7U1
	9mcwxsxNokb+n+ERYqUit+cx5rC7sNzSpPFUmwLrXjCY27/VOCthX4DX5UEan/VP5FS7I81Wbiz
	ireUUkaXryEfS5NsKtmzTK7Ah1PdtuxYjArQvyg92NI5UgdRM1YJD2PSBOh1UDxpdFAHsrZUAKL
	en4DwTA3+9S2vk7o37BoprXoIF97bXdLBOlEdJuzGlwkGTl7fdp9KnIftvoGm0Ig6n0fS2veOCu
	ELvieAUvmNTFMkh3Hkok/HiyeVc+UVAe4IVeJWAM7vtnRcJAVQNxEisaQj6+gZ7ieOOBty/ILb4
	XS9L169WesnM1crM4N6gk1pMFmeZShOeoZhl+axThWKkdM4JzIRFHyHG+WpQqotnHMaCvg2xVkF
	3uzr30drQ3sgdD
X-Received: by 2002:a05:6808:1b8c:b0:49b:dcb8:e2b5 with SMTP id 5614622812f47-4a42ae7f868mr10341782b6e.19.1784087816349;
        Tue, 14 Jul 2026 20:56:56 -0700 (PDT)
Received: from desktop ([2806:2f0:9260:f072:92d3:78b1:9863:130a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1adca6bedsm15669386b6e.8.2026.07.14.20.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 20:56:54 -0700 (PDT)
From: =?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
To: andfed.net@gmail.com
Cc: dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	=?UTF-8?q?Jose=20Villase=C3=B1or=20Montfort?= <pepemontfort@gmail.com>
Subject: Re: [PATCH] HID: magicmouse: fix battery reporting for Bluetooth Magic Trackpad USB-C
Date: Tue, 14 Jul 2026 21:56:01 -0600
Message-ID: <20260715035601.489009-1-pepemontfort@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260706175507.47288-1-andfed.net@gmail.com>
References: <20260706175507.47288-1-andfed.net@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrei,

Thanks for tackling this -- I hit the same bug on the Magic Trackpad 2
(USB-C, 004c:0324) over Bluetooth and posted a fix a few days earlier:

  [PATCH] HID: input: read battery capacity from its actual report offset
  https://lore.kernel.org/linux-input/20260702192139.114809-1-pepemontfort@gmail.com/

The two approaches fix the problem in different places:

  - Mine fixes the root cause in the generic query path.
    hidinput_query_battery_capacity() hard-codes buf[1] and ignores the
    battery field's offset within the report. I store the field offset at
    setup and read from it, so any device whose state-of-charge byte is
    not the first field -- like this trackpad, which prefixes it with a
    status byte -- is parsed correctly, with no per-device quirk.

  - Yours keeps the generic path as-is and routes this specific device
    around it via HID_BATTERY_QUIRK_AVOID_QUERY plus a probe-time fetch.

If the generic query is fixed, the AVOID_QUERY quirk shouldn't be needed
for this device. I'm happy to go with whichever the maintainers prefer;
if the generic fix is acceptable I'll respin it with a Fixes: tag and a
stable Cc, as you did. Your note about the connect-time report being
dropped under driver_input_lock is a good catch either way.

Thanks,
Jose
