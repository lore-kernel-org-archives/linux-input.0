Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC7B35675C
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 05:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783056290; cv=none; b=Z2cdVEpDANyGNtJWrGxkh21npf8DoPEAR5ODoDPkh39NbuXPB3wm0wLOeAZVpGJ2HpT9qzLRGd+6O65cmTTHoKvG4Wr6S6SgUoSLsoL18NZzj+230/k6YOfvSNv9tcHEGSb5CtPBw5As32PETKPslsS+CDSv4p4bUyQ6A0oayRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783056290; c=relaxed/simple;
	bh=pVm9pS+PVo1sWY7zlCDKGAP+Y0EYCctZHYBMrpl/GZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiLW5YAxsTIQ7m74A7yTn+aXGqgN4yPNZxumRDl8Zaqj9N62DaR9D99L9DwDvkb2ZT2xZwdTk0orp8buajgjHAXw6WwZapLvHXvo+SeZdbaYqQrmJNA2vJC/qjApKX1Ml7fx6d16s5P71yODxyDXpIZZbp9aXM8c85MVztiEncY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KXJ4pZkR; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KXJ4pZkR"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-497e6956acfso199342b6e.1
        for <linux-input@vger.kernel.org>; Thu, 02 Jul 2026 22:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783056273; x=1783661073; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ku3ZZ8L4tk4M+xljq5uIH94V1Fi9oyEnYUJ16WQL16A=;
        b=KXJ4pZkRaWMoCDVsHoj7F+5BU+SKV1XiAXTHMgr1/EWdolktKmWF1LSM8xlg2nWQKR
         eVySg5h2jsIpESxZ45VId3YPfPcSYNhF4yzO7BRhpsNromS69c0xiliPF6nWYl+0ryd4
         OSloI+O+LZOrVxX3Tr40bX56ZbjZRWyu42G9oq6UgUKjvPd6tdG4NcHjKZIWTThiz6kg
         eohHoZClM+JOTQoYJvAmKdT1s2wR7hk5RgpbPmElLqX/r7efOafuSUakKYsKBWe8m5pi
         oBvoav1sNKlPcIhLupQAfY71WLp1aWXkFZZosD3V0bqRvYldfrEkxQZaVD9m8DMq7BOK
         i7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783056273; x=1783661073;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ku3ZZ8L4tk4M+xljq5uIH94V1Fi9oyEnYUJ16WQL16A=;
        b=Bu2X1QPzedtilwDkc+SIlIJHgy4T4uP5k3KKYeQgPopZHvILN9loqEJt4HaGRZ+1KA
         aGhMJCO4lzkstTUlLakDybAbNscbw8ILzUQpWNLuoaRBOd00SjbCR4b0hrIGU5tBg07l
         9vfVbgXczJVXXUP4744fvxgHPz/9fgqeXs62Kc3BcJpf9v1SfnsBFbpJsMEtDYqIF1ii
         eaQe94q+q4CRf7dAPj/aTmbK4+GaJjOGRZO5Tyrxi+pVLFqSb2vFLCizJPccx6DNyoDu
         i3rKhz4y9JqbBvQNQQOHyhHT+XUNVHQ2dTWfcdt3Sfxgfn01/N3K6JLwI8WHaPKiS6iH
         G6Pg==
X-Forwarded-Encrypted: i=1; AFNElJ8TPwOBU299MCs9TzsDlsIABJFbsRBr6MYwfck79XoVjBxMAGUgGF9O1UAnd38WS4EHHBVSd4tEnZ2RTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFe3YGpC5K/hadC6X32/7ktf5phF9gHYRCU1ir7ZgkUKycPudm
	SOfLFoHItqWrzdNU9QNrQqKcY1bdROk57SD7wrQfNRL8BC28lOaWXzBn
X-Gm-Gg: AfdE7cmsrYje+g1hN7Z1o+X0qlJMz2yi+MRDoUWrJKn+7o1yEWljtDagktVePIxeNSx
	U2hXvs//iz6CBS2gGZrCafRRc2wQ8SdcauIWLYnaYXqUQ5RrDTw2bgvXJZbtEI1DwSZIVGLcfaR
	/FZkM5qUnkPRjVRVl7PxLFzjbFvuVhV+Qo0xcymkZzbCFyTIvYfzCRk7qI8whuEexrnKQ4rMQn8
	9j4VMMpqUBBVgS4Gex5n8Ixuj4E7SdIinDtwuwUipviwVkTGLbDQ+pcmVX8gyTvvUdKZm2qOpE9
	ne6rx8/giMyHtfrBo1q2DqE/2pL5tDZg2qvmzmpsz2xER2d9zniKy5Bghq6EuC3DQPQ74gQW4GM
	N8F/WWQJgmw1cMrHJ41PwpMC153C0z5sYEDl0BCuJSR+7ifEJJNmW8gvmpohkMocotuvydR+uU6
	4VCw29Tw4LRpofdZUkwHNP
X-Received: by 2002:a05:6808:17aa:b0:496:6b1:cc7f with SMTP id 5614622812f47-497e1bec6ebmr2160066b6e.3.1783056273105;
        Thu, 02 Jul 2026 22:24:33 -0700 (PDT)
Received: from gmail.com ([2600:1702:56e9:4b40:ff21:65e6:6e3:5b43])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-497d1b77a11sm3272472b6e.17.2026.07.02.22.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:24:31 -0700 (PDT)
Date: Fri, 3 Jul 2026 00:24:28 -0500
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Lee Jones <lee@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Andrew Lunn <andrew@lunn.ch>, linux-tegra@vger.kernel.org, linux-input@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Thierry Reding <thierry.reding@kernel.org>, linux-media@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Vladimir Oltean <olteanv@gmail.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jonathan Hunter <jonathanh@nvidia.com>, 
	Simon Horman <horms@kernel.org>, devicetree@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2 4/4] dt-bindings: input: remove obsolete
 matrix-keymap.txt
Message-ID: <akdFQ3j6fDW4cVIp@gmail.com>
References: <20260603-b4-remove-redirect-stubs-v2-0-c8c19876ab64@gmail.com>
 <20260603-b4-remove-redirect-stubs-v2-4-c8c19876ab64@gmail.com>
 <178052559618.2296868.8781332297681333925.robh@kernel.org>
 <aiSK6_n4ZnB_KRd8@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiSK6_n4ZnB_KRd8@google.com>

On Sat, Jun 06, 2026 at 02:03:43PM -0700, Dmitry Torokhov wrote:
> On Wed, Jun 03, 2026 at 05:26:38PM -0500, Rob Herring (Arm) wrote:
> > 
> > On Wed, 03 Jun 2026 15:42:21 -0500, Akash Sukhavasi wrote:
> > > matrix-keymap.txt has been a single-line redirect to
> > > matrix-keymap.yaml since commit 639d6eda3b80 ("dt-bindings: input:
> > > Convert matrix-keymap to json-schema"), which introduced the .yaml
> > > schema and reduced the .txt to a stub in the same change. The .yaml
> > > has the same filename in the same directory, making this redirect
> > > unnecessary for discoverability.
> > > 
> > > Eight instances across six files still reference matrix-keymap.txt,
> > > forcing readers through an extra hop to reach the .yaml. The stub has
> > > not been touched since June 2020. Update all references across input
> > > and mfd binding documentation to point directly to matrix-keymap.yaml
> > > and remove the stub.
> > > 
> > > Signed-off-by: Akash Sukhavasi <akash.sukhavasi@gmail.com>
> > > ---
> > > v2:
> > > - Patch 4/4: corrected commit message (eight references in six files,
> > >   not eight files), Sashiko review.
> > >   https://sashiko.dev/#/patchset/20260529052246.4934-1-akash.sukhavasi@gmail.com?part=4
> > > 
> > > v1: https://lore.kernel.org/all/20260529052246.4934-5-akash.sukhavasi@gmail.com/
> > > ---
> > >  Documentation/devicetree/bindings/input/brcm,bcm-keypad.txt    | 2 +-
> > >  Documentation/devicetree/bindings/input/clps711x-keypad.txt    | 2 +-
> > >  Documentation/devicetree/bindings/input/matrix-keymap.txt      | 1 -
> > >  Documentation/devicetree/bindings/input/nvidia,tegra20-kbc.txt | 2 +-
> > >  Documentation/devicetree/bindings/input/pxa27x-keypad.txt      | 2 +-
> > >  Documentation/devicetree/bindings/input/st-keyscan.txt         | 2 +-
> > >  Documentation/devicetree/bindings/mfd/tc3589x.txt              | 6 +++---
> > >  7 files changed, 8 insertions(+), 9 deletions(-)
> > > 
> > 
> > Acked-by: Rob Herring (Arm) <robh@kernel.org>
> > 
> 
> Lee, could you please ack for MFD piece and I can take it through input?
> 
> Thanks.
> 
> -- 
> Dmitry

Friendly ping on this as well. Rob's Acked-by has been on v2 since
June 3, patch still applies cleanly.

-- 
Thanks,
Akash
