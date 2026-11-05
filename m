Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909618;
	b=JlJ63UHFQlYdba6ZkU7jbQEtaiDuoBvmRYerzbp1vEfJdmVgtZ1tQebfohOnoVCQn5+/
	 /8J6YtN9eAgNRN9PRR1X2YDG56R3x2necqd4ZkolFPi57C1mij1bgVchHS7DPWkv3Q+eZ
	 It/rdEakLibgLEJCCXjY+ToE7mynkpVLU2J6obbggJyJv5u474CR7IKDCarLQvg1/xKti
	 zO6pXmh5+Z5iynD8BxGB8T4PiH/ApnlEaFofaAokLoScWcJE4Dy9e5WhdulUZeGia5qV9
	 W9o/CvQEoLOEYlpmQysSwgFE8TmJkKo4AgXQZ8E9eawzm/aGMjCZuqHiFmcbjtk3dQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909618;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=uINoRiE1GtHUaPA0Cv7RqFxvFT58JwcXGIedUlmNygg=;
	b=fQcwtfy8X1WTyFoXr4iee5I1/rXSae72rEBwpHJQYjs4SCV6GI1HOLAXdhL65Bzap9RD
	 sAGbGiNRP54hyMXFo+4e9NZK/OeFVuQZj427K5J6xdl213wQtx7BChdZflQ/RhArs1L0G
	 A43IiitCCJE//p1GSStf7L0CniOOsCGvSYPhpME60SxCud34MwtXeImaO9CBKYzNhn19o
	 8GgZYAFuMhW5/g/R5HwOPWTGQEYWky8RjQQhYndl2UCANcy+JB+kIHYRiBGHW7+T2Hm+1
	 hgfR/j9A0f5PLSkesWksD5zfOXIJgiQ/gWBqgiZZjwlEZ+wSEOL85ovxCb80x6KJhRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UD47thWC;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B370606A31B
	for <linux-input@vger.kernel.org>; Thu,  5 Nov 2026 20:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B370606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UD47thWC
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514b90bb89so4444264eec.1
        for <linux-input@vger.kernel.org>; Thu, 05 Nov 2026 12:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793909618; x=1794514418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uINoRiE1GtHUaPA0Cv7RqFxvFT58JwcXGIedUlmNygg=;
        b=UD47thWCs8ygmghwMxYF4kpjAsRaxM/Mzy3DiP/yMMxSGBgDFbqxJhHtnbFiMhBlH5
         6pryiK/RRjj25LX6D0HkoKI4MsUW6TaULKOEQhmK+87d4hYPQ7KzCiURCqSziAcdWF24
         bdkFYmnmRiqqPEW+S6npb887dV09zQVvgiUm5dfA6fcOvwkx41SHmsTj4D4XB6aE0jI3
         UGs/KcjHzCrCDWi+1nyY46zVHKwhgtHyG0SjHUCCpMfO300/DDLPrnkHAOC4vjreyWKu
         rKzwMxVwCRkqWmo2YJOQ6p0EuXhrll/5RdOcrh1eMfl8mjiaRYUh/c581G7loQ1yaj+3
         b2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793909618; x=1794514418;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uINoRiE1GtHUaPA0Cv7RqFxvFT58JwcXGIedUlmNygg=;
        b=tXWS/uEjbpJgHrFsZ0itE20/uyLnfF0ap/RgcLmE3pexnP+YaWDE1xM3j58gs55/J8
         ABs4dODskLJtFDnjnzWGFpTAQbsyx3Onjh/ysMl12n/PfZi/vEyMtJ5ujw9rsEuacO7C
         36XMIZNw3Uo+W+Njmq3OZT0sPAKcWIKmtJ1v5iwJaILZqlBpIMdfUTB1EfpC0peqYakr
         zYtlq38Lj2xkjPz2x8KhPNkNklU0HkUwvGYDCejGl+2RPlwQ0ObhMZjGwxFe13TvuoR+
         pMBVq8xmoyvL1C4BlsBC2OmV0phDJCl4/6gJa5+RvR9hR61oS6dVtJiIy/ECF96johbz
         eZyg==
X-Forwarded-Encrypted: i=1; AKwUvBxq274rfToV3MgM7Y1+/olamKYePrBTw0EDMEQxM/HFK6ZqqfcCl+Y/GRM0ATP1cVwqnz7ryPwozAftDw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9JpbanQZxmsx0sR/priVflpDXMzKfm9GiFaqOzGhyv+yXFG/KL
	CAyMkblMR06YbBAfGbQncvElUvNGQPE30lpnzygku1QvqNkys0kH6eUU
X-Gm-Gg: AYBFou0+vIJo8tHpW8+IQIgNayJCfIl26J9aAV3zgxqtAYki8ltwsHQnPMxN9NsaUCx
	a0nG4YNdrHd4FtCXT7Vpes41wqjtrCvBSNALzeRhgTvb7XOmVPiLsoumUlTyVAGscZBRx03SJfi
	4b+D6N+gObFe29jOcxr3LqyJBJCyNuFLKQDzwoSRFyWoFrm/x6ajiMj03q08uAx2wwC7VSPTor7
	ECodUotoNLW6A80MlQNgeAb9n2vxIDbwbrz5d5ciD1P5n76LluSdjf3iMGIPWSdMi3zZLBZU6Hh
	mN7cNwbtEWGuymQYBfoYduSb11/RkjxUKw/Hbym3EZOlvPeeibT2lJOFSZ01dl1PZbITgVK/+Yd
	hVboP5k7xLq+J2joZOpJvpNn+LPOlH09a2tH5I3C36twgsHgRjx0bPc/0WTd5AURgj99lShaxwU
	RNekIVNSFgL4YH423jVnD4BwOWoqoWaCXCTkJVBE3O32NXI2y9Kw6QlLtzXVscoDE8HiGL8yJzP
	MQS5VFxB7QMjLtItA17ESoPKEdDc4Hshpmb5vyLbSjwmBVTa1bUaqi7VQ1+VKlccwAx73l/eMXt
	FDQ2l8zps/RmYBbRjqyLAbm45GJrr8/MB8ETc9IgSl0OVTbqBJeIYHEN45rj1zep7+sf9PIbCVG
	5ci6CiQTMMBF1gA0=
X-Received: by 2002:a05:7300:680b:b0:36d:394d:e690 with SMTP id 5a478bee46e88-36f785b760bmr248122eec.40.1793909617470;
        Thu, 05 Nov 2026 12:13:37 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:c8f4:b7d9:252f:4483])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36f722ed274sm523275eec.18.2026.11.05.12.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:13:36 -0800 (PST)
Date: Thu, 5 Nov 2026 12:13:33 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Kris Bahnsen <kris@embeddedts.com>, linux-input@vger.kernel.org, 
	Mark Featherston <mark@embeddedts.com>, Marek Vasut <marex@nabladev.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: ads7846 - consolidate coordinate filtering logic
Message-ID: <auzjWxQgGItAMoHp@google.com>
References: <afl3WtbabMFNjE24@google.com>
 <cf9e30d8-f51b-4a19-ae7d-914e6bccb265@embeddedTS.com>
 <afzo03UP-shPfNMe@google.com>
 <aimsXWeg3wouoiB9@darkstar.musicnaut.iki.fi>
 <ainpywl0lj_K2_Lx@google.com>
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Post: <mailto:linux-input@vger.kernel.org>
List-Help: <mailto:linux-input+help@vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-input+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ainpywl0lj_K2_Lx@google.com>

On Wed, Jun 10, 2026 at 03:49:20PM -0700, Dmitry Torokhov wrote:
> On Wed, Jun 10, 2026 at 09:26:37PM +0300, Aaro Koskinen wrote:
> > Hi,
> > 
> > On Thu, May 07, 2026 at 12:35:04PM -0700, Dmitry Torokhov wrote:
> > > I think if you pull 'next' branch of my tree, then the following patches
> > > seem to apply cleanly on 7.0:
> > > 
> > > c68bc840f06c ("Input: ads7846 - restore half-duplex support")
> > > 011bdf9f3a9d ("Input: ads7846 - consolidate coordinate filtering logic")
> > > 
> > > I hope they also build ;)
> > > 
> > > c68bc840f06c should appear in linux-next soon too.
> > 
> > Did you forgot to push this, or was it dropped? Because I fail to see
> > it any any tree...
> 
> Well, that explains why Kris could not find them... Pushed out.

Should I just merge it?

Thanks.

-- 
Dmitry
