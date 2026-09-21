Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522324293C
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 02:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789959206; cv=none; b=N0H4CCR1LkLDnz3lopjWU97zLi2lvHUbXQrT6oe3uDDF55dEh6vWkqiuXs1/loEmsflvKdBoiZhnqbFkfL9Qas0io+g0vyKePeT4AUkeIX1MI8wog0xcltLdsyNgYDaSwP0imdP+hq7ksPTyLB6rOm3/aqWO13Fwa1kX/w4MzXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789959206; c=relaxed/simple;
	bh=VHyYEAblzmgSTYDzcQ/rTwb+iNZ/FxfSAGGwjEdaK7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYD0p2+vq+xgs4cq9gbjGiaDFMjCMSAQNSTt8vcJL34UQ+TdA7I+QJ7peZOlIuANhJwdsYvfIpz4l0oV60S3kjDpVLf8sfgZJefg1y441bsferJhtW36wj54sAbTFINjNwJXeJbgx/ErvYD4wAv+2K/uh6ob8wcW0LfG4xMiQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYcJLfmA; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYcJLfmA"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39647184c73so2960248a91.1
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 19:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789959205; x=1790564005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Se1G+XHmYZanJdo+24xpc9gmmy2jZ9LFjhb6Fx5cYxc=;
        b=UYcJLfmATlfAb3FOZbA9bzP3BBXBSBL1VsaWvoHMydZ3svQtVebR/G7Havfn52kwDS
         1u9AT6KSzqJC5mQjPWI3vo+J/Qs6GJNqGUny6IJtpdZvae9BcXeLhcrSg8Oq2n9SnezW
         spA8K83dunsCbme03vb4KSSgOIjzg3B1Tj5xvDn/29qEEeLOpmsM7j5ygh5uyQTh1iMa
         Sswhl5zxRm2jejEeK+XKJLCslLeW7M6DjSkPKJmAQGHxvrA/wfG6+j6jJYRRYgN5Aj2R
         EExsOL7BzdrF+YE4UnZJXIG5tjKHonAqB1xgBU6nxiBdNgoxwZw6lNoTiqN0OiyQ4N1A
         yw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789959205; x=1790564005;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Se1G+XHmYZanJdo+24xpc9gmmy2jZ9LFjhb6Fx5cYxc=;
        b=ypMrljqQVkHCNiXOBq9CiCU5dIGpavrwWLEgCZ3VPUkfIGKgQLOy15irGDfd6+nXVH
         VvFZ/cza6cA5PAiBQcs6MCTagC/eDktG1Ze1iDgzbc8wOsUodVg2gih5ruDaiB13AYC4
         L4GAVavh7DF3YKKMd0wcTRV9aFoTOVKN/iOndvzMnN6ZKzez5Yx9DVNOyPDKArKgNPyi
         xPLkBcFWQlPxpOlgqXoXtudj5UjUAlycwTnAPEK+cxXxePqMCGhfKsm69OTV18MSxKXG
         ZsBmMbBmCT2aO8tiKbNWGzxFtOVxZ0X1Orox3cvGjOVpuyuEiO05tIrbdYy3whOJTgZ3
         /8Yg==
X-Forwarded-Encrypted: i=1; AKwUvBzKstd3Yj/L0rscL7BIyrpq93S9F77ZI/8/IPqRSIB2RiffScp/JhGyeS/eN6jR78LdNcUprhLOuHp3Kw==@vger.kernel.org
X-Gm-Message-State: AFuF++khEPEm8Fc4uDoC4NH5GMN4SwncXOa9wtGeh74ieUZ4pMBQsT0p
	weB3D70LHqemGv0YmxnMxJ3eljfflgLhkuuK1ZHA2XNLVrg27WkfsMpR
X-Gm-Gg: AYBFou0sRqD5P1P39wrA0kDna2rSAtLjsZMiYOKGmrfhKpERAeP25i5ZBA83QhmSZtZ
	ucR3uEXqsMJAHpb8t6RuMWhvAMSCPteof5xwdOdlFtME3Gmx4fYv3BPQ2dUbmOy7G0P7VGM+JMn
	EBI/wpsUlxjO/RLpjjGt5y0qBIlau7LEutPI4/sgvufyvI8JON8ujddlFAUX82aKeERXnrrtvSo
	FcSVKwlub7wMN5as72Cl4u7gQ0ex4kO5DJBaHEXZJA33+47U34SezFn0lVdTz2Vv84waGRixgTA
	1YbpkPpWZnX1y6n8o7MaI6MPgAwo8jYhhSt8EuHtWI3GPW/BIDqBDQWDv/jGycrSecDEgIWww8y
	gFm4w+0MYvQYzjQ5Iw02EQ+0B8on5fisXGi0Ys5nZ5qGAQezeuYweUV/tMYDc+EIAqqd3awC5UY
	lZb5fUAJqO2bKHM0k1sO3TG+RKzqNcGGHI+g4Y+rek+tJC76Rn13uHyvaUrDG80pwarWrnkB3Jo
	bjRrjxXOCrjCvDX15VV4HshGBrFo9URJtT7VmvI
X-Received: by 2002:a17:90b:1cd0:b0:396:7c01:553f with SMTP id 98e67ed59e1d1-39e36106b85mr17920856a91.21.1789959204603;
        Sun, 20 Sep 2026 19:53:24 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3844:3355:5928:66ce])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d53968afsm16719079c88.0.2026.09.20.19.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:53:23 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:53:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
Cc: rosencutter@gmail.com, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - Add LEN205b entry to smbus_pnp_ids
 for ThinkPad T490
Message-ID: <arCcF3rLAM9AW0OY@google.com>
References: <CAOGuaRh025eKcBf9P8UrvtXNp68vQ0HVF2EbNMp-kpdaC1HNpA@mail.gmail.com>
 <20260920200730.1836756-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920200730.1836756-1-lovekeshsolanki00@gmail.com>

On Mon, Sep 21, 2026 at 01:37:30AM +0530, Lovekesh Solanki wrote:
> Lenovo ThinkPad T490 has a Synaptics Touchpad that supports SMBus/RMI4
> mode, but is not listed in smbus_pnp_ids table.
> 
> Add LEN205b to smbus_pnp_ids[] passlist.
> 
> Reported-by: John Rosencutter <rosencutter@gmail.com>
> Closes: https://lore.kernel.org/all/CAOGuaRh025eKcBf9P8UrvtXNp68vQ0HVF2EbNMp-kpdaC1HNpA@mail.gmail.com/
> Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>

Applied, thank you.

-- 
Dmitry
