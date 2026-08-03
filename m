Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829B727603F
	for <linux-input@vger.kernel.org>; Mon,  3 Aug 2026 07:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743050; cv=pass; b=XVZ8P0bgwMsGRniSNsr2a5dH00mTzwtfIqR40S2JbAQEWWHZfb7s+DjONleN8mJ3oWTlgt67QEbUKt/dFDj8JEe9xYXpqQYwjOE81enlQfzzQZdlDsgZaZcDMdjBJ902p/nuulbdL3TrPNqYEfbAbsWR6iAm6TDsr6GcswXFzRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743050; c=relaxed/simple;
	bh=Dr6mbAiUpLjriFA9/Fr3q7PDlQa4stUtOFXp/+mOe3M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=e5t5cSSKRH82HTtFJpRPbmx8Q9I4H/0j6altmJAX7S2jtZy4dVt/f92tM/S6E2ZXFqcYmXvtcp42tJeck9DikX9+U9fHG8RrDa94iob9izx3prLlgF1cBBf6dFx3HOSPWWLfb/O1iSiQ2hDUUWuL0Z5zgIp/sKl5FxvmRMwLCT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fENsvPea; arc=pass smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fENsvPea"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84536ecfc5bso3558009b3a.2
        for <linux-input@vger.kernel.org>; Mon, 03 Aug 2026 00:44:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785743049; cv=none;
        d=google.com; s=arc-20260327;
        b=fqJuYZEZj/gmlbNyX2ViGu4vRr1H+dPPweI8jvuOj9mtSSEmZa1tAYHgyp/Vj5/m39
         ReVyjh1XYErnXGjPxeHFrZtV6DBat/yd0S+bUSg71OVwj/SCfBblke5oqIh759flIinc
         YvWyLB/sE5REiJl58mJSbm1CCOfFGfC369Q6Wz+praAsWAUdEG3COfPy9sCyVaSudyDl
         Rb8tFOJ3r538EID7Ex112/Gv6hFueN6AynlFnnHknAwNeDsaZf6i51qRsTaNQfE/91YM
         VJAj52b5gTk4XchtrXNKyujAvYqnByGjCmSam430Wxksd7EF0eeoXm/G9a4sJtMEdS/o
         2dQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Dr6mbAiUpLjriFA9/Fr3q7PDlQa4stUtOFXp/+mOe3M=;
        fh=6UGC11zvy2ZLwvU5EjUQgNBQqAUnU0n6PX89wO/3Roc=;
        b=oDFTvTXCPTIfMPcPkDWf+QgLsCvxK6wFGCYjfJl0QI0mM4VKlxPKUE+nXr97BideFR
         7stYipNEmCvyh2ft3WMAj06/WetjvgTw8d3EpJThkVaU6cDwbmIiHluasRRF/04mRiJ1
         RPw32H/Asyr2V5EI/NfLZUbOZKqJMMAiimVryRMtzDWtscDOdNUbQaRtGlWUPMhphpox
         dc65ihkWREfcR3eWeF0s+wm6sl2VLjGvEjaWgDWLYyEz6iwjHD0fiQQGFufO++HtUSWO
         lBnHUO6whqer7L2kEvQawCvUd92K7WilT5QhHlVBr3Izd59VJJ2meJGTAvygcxh6ugfX
         8aTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785743049; x=1786347849; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dr6mbAiUpLjriFA9/Fr3q7PDlQa4stUtOFXp/+mOe3M=;
        b=fENsvPeaH4gSv8OT+bBl295b9stMAoe/gNbGEpJ+mAnRT77ebu6UNzicauZTltm+e1
         zABBpIfB1abXBRih1PhLu7nJ2DoYcKWbhcKEv6rFgUKq7Uchp2lNn+1WEgHEYqJvAmld
         5+cyGItOeTbe0q6OgiV1IKqEkj4kdT0ix9+A2/ZC/e4K4m6sYEw6Ejq9G/eJutgGdaI4
         OyCrMMonvP/a4HNlm3NaLVimc9zxbZfWxjC//s3zsoQsg47jt2tH2nqOZgH3fVij5JRn
         /sxXFFn0XdYBvLh5/rDZ0IZleKMsKdQkZITuuwAJtBTtgZfhCkSIfHxn0wQPVgb3M+E2
         09Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785743049; x=1786347849;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Dr6mbAiUpLjriFA9/Fr3q7PDlQa4stUtOFXp/+mOe3M=;
        b=VhsmTprhZsQDTV4/qrIAGkSd3LwzLmJhvM8y3m8YeKTwRQNg/Esb5Tm+ao1MqJuArV
         SviC9bICr5/abd+pGr4qF+C+R7qkpvJXMOnDsZTwDtUTdqzVnexLf2rUGFqQGpIEAss3
         4a0YqQYDsVtSWaOUO+8nLOkKIYk8iSqyRHyMot8cZGc0IW2de14PVt/12FUHleky4ERb
         3kQqksq2bq2r64x7pzc8Pr3HEegbNvXPRNy0iMIsWmoZW7u72q+cxVJ/Lmk43lLdCqJf
         9RdQCiQ9q+6wgrjlO5jU0tFR2do7EkR4YEab+2Sb56HL2FVpg6XGunadXG1osRxcaEl/
         mV6g==
X-Forwarded-Encrypted: i=1; AHgh+Rryw69UiRqutAPgknOyiZpq/Opj54UBiaWiNBe58oU30jdeqif2jvVpKXagQsg9fQhsWa5V9/FWEK0bUQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMfVisycmCu65KFdA+luTPcfwOInwFMqDCExCfQ3RYzPyWht/y
	dX1mZpVrQW0li7Zh9VM9qTkZQDkLd6WQfshyWf9XULZUHLcrv6s/0K24EcR/+k+agJmkKwqPQ4K
	eX+P9GqQYXv/TgOVPznv2oABlQg/cf9w=
X-Gm-Gg: AR+sD13UlZ9TA0LOeaGB/BfH4oXYk7kntr6BTV0X2lekZQ9XCt2fsVbUf138j6CcBBJ
	+uCLJPD29U7rGQOapM2SJxveq5ggrVNuR8uojJJT7RE3hf5f4PYOvF4nrTOAiC4XOmGs57zJiJX
	2lZsI8j9nfeUB3CQyJrm32+Y63Ned4nvO8FxKUGOX8whmfZay9O7u/RbTbgCWufToSUfteqF2vY
	ttkWdZOgbFkk2JddzNJnnU3pr1zgYxbYWrMBqEKi4K/GRefAJ6/7uLLyR47Vya+FoavG+Atd1dY
	LeYagJ1Efjk/2Q0oPyvp3YN+ozPoNo+Q24dHm6Y75yYP
X-Received: by 2002:a05:6a00:1702:b0:845:c662:2be with SMTP id
 d2e1a72fcca58-84ee4953b8cmr7620017b3a.42.1785743048751; Mon, 03 Aug 2026
 00:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Pengyu Ma <mapengyu@gmail.com>
Date: Mon, 3 Aug 2026 15:43:56 +0800
X-Gm-Features: AUfX_myGIH6SemeXP2CSnDTtcW166c-uAydnQoV0L70Z-doI2YGaCipwesY_NPI
Message-ID: <CALSz7m0RLK9qMArB55TuzQhc8YZhJras9XYLTdU3+E6imCsDhg@mail.gmail.com>
Subject: Re: [PATCH v3] Input: xpad - add support for Beitong KP series controllers
To: vegetablecat@foxmail.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	"open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	liushuyu@aosc.io, Shengyu Qu <wiagn233@outlook.com>
Content-Type: text/plain; charset="UTF-8"

Hi VegetablCat,

Thank you for covering the wider KP device family. My patches overlap
with yours but use a different request to keep the controllers in XInput
mode.

Instead of requesting the Microsoft OS Extended Compat ID directly, my
patch sends the standard USB GET_DESCRIPTOR request for the Microsoft OS
string descriptor at index 0xee during probe.

In the Microsoft OS 1.0 sequence, Windows first requests this string
descriptor, which supplies the vendor code for the subsequent Extended
Compat ID request that returns XUSB10. Your patch issues the second
request directly with bRequest set to 0xee.

In my testing on 20bc:5158 and 20bc:5159, the initial string-descriptor
request alone is sufficient to keep the controller in Xbox 360 mode; a
subsequent Extended Compat ID request is not required on these two
devices. The 5158 device additionally needs a keepalive quirk to prevent
it from resetting when its interrupt-IN endpoint is idle.

Could we use the Microsoft OS string-descriptor request as the common
mechanism while retaining your device coverage and attribution? This
follows the protocol sequence and avoids assuming a fixed vendor code.

For the separate 20dd devices, I suggest using HID_QUIRK_ALWAYS_POLL
instead of registering a HID driver from xpad. I verified this on
20dd:5159; 20dd:515c still needs testing.

Could you test the string-descriptor request on the other KP devices? If
it works, we can consolidate the overlapping submissions and preserve
your device coverage and attribution.

[1] https://lore.kernel.org/linux-input/20260725072813.339112-1-mapengyu@gmail.com/
[2] https://lore.kernel.org/linux-input/20260803053932.5897-1-mapengyu@gmail.com/

Thanks,
Aaron
