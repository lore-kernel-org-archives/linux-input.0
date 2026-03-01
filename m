Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E394337107
	for <linux-input@vger.kernel.org>; Sun,  1 Mar 2026 22:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772403023; cv=none; b=Zilkniy/sZBrHUtuLfaQiHpI7DDz4a0iA9kG1ig+wdiMkalnmlhs6LR92iK41MIDg9e70va427FQoSuc/8JXwxMWcVUWcXIeXM53T5Pen0flSoF/ZW55sP5Kty0cJ9GllBGqsBoe4YLBLacp4ToxQbhipdCb1ZVllazj9B8L2O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772403023; c=relaxed/simple;
	bh=thRh1q6Zg8tV6DzFJ3CJKUqKNXpLmy45vgdB9JTO12A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g039Q1xe5pmGcrMV1JYW1qyNJG67lR0v4N+DTuy55e1haS/M378dPGdM9m2zmSEn00b6OqOnqsCSlll7KfRY05xvoyXYCz0PQb6XzcxND4js6hBWpLpYH9UrhoO7bUjCgwLmqGO48l2KR0RQTelV/xA4mAo4vw8HjTjlM89lcpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H75ozLun; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H75ozLun"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4223204eec.0
        for <linux-input@vger.kernel.org>; Sun, 01 Mar 2026 14:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772403020; x=1773007820; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nFjVWYC4aukpE9k+uYV7EwxrLAHwdFE4Qix6Wa9fAVI=;
        b=H75ozLun5rPOR/sPNmlzR5SB5n0Rg/I9CPCiO9f5Q7ojiZgAfrCRho2v3+QMP2ZMYS
         jjCb42kwexcd+o5PfG1JysClQecfik3Sdfv73FBoobBQEBk0vHXmUUWoMo5+k8PRdYuR
         fMDVykZ8W2obbynHb6aBHjoeGWzI9A+MJKPMgJfY1AgWZ8WdfhWGWMFBBF3rrS1jVSV+
         y8ml3NeEllRqn2/TOpV9xw820fSkTz97ZbIDntnR1sWLvPvm7yAHqqdVkrjh7fa5Pn1p
         W+gLE/Ht4yTvDCBGG0zZtMdejxAEU1IPlIYoI3C6AVPO061SrfoSAcqvs0X6LmPjRllY
         Dhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772403020; x=1773007820;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nFjVWYC4aukpE9k+uYV7EwxrLAHwdFE4Qix6Wa9fAVI=;
        b=xMfaCWSYMRlEMaugeA1uWuYnztOP9NyU89+/6JqmfrjwFTarl95Gadc8d26efL9BiV
         s/L6bnJH1EQXyu2SjW+WXHbTP9UzZ4xVQdAm2DFK21uB5GkkMjLteFfFjNR5XgmRsPfF
         GXDF6lXfbBs74KJ5gZWx8W7I0cVy9RS2YSSxNrpaxIWZsty2pM9RKX8gUUBBaq3ar06c
         qFcGQnuqsp5hNOczBFcsCiNZUWiv4jMKwEIo8wMQf4CMSMmq4A3FYSwx3wsLiizFNy3b
         y/QUuEh45GInZOMdzAKRB+u/8BXzjVRlHGPPcBzZlCpFhYe6yHwhxBYFzSBow4F8Dibt
         PI6g==
X-Forwarded-Encrypted: i=1; AJvYcCXbs9pxfBiYjDQQtTqulmUS0udq8Nz86Ns3WX4Bj+hu9bzEf99GpxoGLu+GdvS1oUTgCi/oxmwkqDrjYg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcG8hM9/BMoTEjXQYJHwLMuhOa1kgHvWZx0jtuEx+6ndxJkgYX
	THVyaV7SokMb3kBjJciHA9gWML/CFuGk/kHhp7PNS7gM2jS+mY58Suoy
X-Gm-Gg: ATEYQzxZmavgfzIaC3KHMSfO8LI/JpnloJDqmHF5G9/z3EGVa2tYhIPONf8UkcK6qqe
	Xqs1uyyNQ+6kPWeVdp0trUBAo+giq4MagDJ7LEqLx+7yrzyL2esPCMpmrCp5uXmE8qESxwaZ7h3
	D0Hy8DxuFddcFdwE1xWs+TPRrZiRI4U8oqAoJDBTXZV3DMoG79md7kdSdDmdjzy1EGP2QDGQgPm
	B34QqP5RgjReXSO/phRv/Tc+GHFfTa622mus1iSkbsm6NEx/BEDvt5J81CVnSEWWKKuv5GnusIE
	0DzaXmiu3CdKHYuihtcjgQD4N3eHGgYpSvonskly7SpTqoBSMkRYuHlZnlEGIK4S97+nBzbw9c9
	afZxV4KEnHoFAZUbXfR4dlWjDSi/m1PUq1JtlCf8/rP9Ek3dvQpoEJSJ7OMK+HaZJIgg6mBxbn2
	bt+wl6coEoQ6LnVOYOjpqpg8Juts21OJB7+fyphE79U1/sdk1idr2IIdWhEy8IzO8I
X-Received: by 2002:a05:7300:6c25:b0:2be:e52:a3e2 with SMTP id 5a478bee46e88-2be0e52a574mr617422eec.33.1772403020408;
        Sun, 01 Mar 2026 14:10:20 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:864f:8513:57d0:4064])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be12805b93sm1051546eec.15.2026.03.01.14.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 14:10:19 -0800 (PST)
Date: Sun, 1 Mar 2026 14:10:16 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Henrik Rydberg <rydberg@bitmath.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Petr Hodina <petr.hodina@protonmail.com>, 
	linux-input@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	phone-devel@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH 09/10] Input: stmfts - support FTS5
Message-ID: <aaS4cQopqsQoS807@google.com>
References: <20260301-stmfts5-v1-0-22c458b9ac68@ixit.cz>
 <20260301-stmfts5-v1-9-22c458b9ac68@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301-stmfts5-v1-9-22c458b9ac68@ixit.cz>

Hi David,

On Sun, Mar 01, 2026 at 06:51:23PM +0100, David Heidelberg via B4 Relay wrote:
> From: Petr Hodina <petr.hodina@protonmail.com>
> 
> Introduce basic FTS5 support.
> 
> FTS support SLPI and AP mode, introduce switch GPIO to switch between
> those two. Currently we can handle only full power AP mode, so we just
> switch to it.
> 
> Useful for devices like Pixel 3 (blueline).

I see "is_fts5" sprinkled throughout the code. I wonder: can we define
chip-specific operations and call them instead of doing conditional
logic which is hard to expand (if ever needed) to support additional
variants.
> 
> Nitpick: changed GPL v2 to GPL in module license.

Please split in to a separate patch.

Thanks.

-- 
Dmitry
