Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC9E3F8DEE
	for <linux-input@vger.kernel.org>; Wed,  1 Apr 2026 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775059907; cv=none; b=Jh3k8pzJcEws4KewAHV6jZCd+jK0bF3Nkq9NOs/YqG8mFxdWFx9z5LpQB6QddAhvXbFel3JT9mFbwp1x+VsLOEiKUubDRHqQ50nLYF32r/dt/ws8/E0Z/R6w1xidBwbPrEXwjPpQf18CrrBR6S2u1fwmFUVscszEWla+aTf7VSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775059907; c=relaxed/simple;
	bh=Lll5oR6Qy//fClu5g8F3P8kwsGrz/Ee9mZz01vlvygw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2i+C08vysYzddYKVRzsyQUZco013WbVR0PFMoJdxmM8zEin1pVzN3KBShMtNpgGlMIO2hV0lekProRERivNglc8Xr3y07n8U33E8I32sudR0lpEo0ca+b9YmZeX5uaiq3DKcr3smifNfqgDMZCWUO7z5pm9W3P5gzwKciA+IaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rspx1OdJ; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rspx1OdJ"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2c156c4a9efso6874558eec.1
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 09:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775059905; x=1775664705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iMl5RIQBcoAsWtIwo/RmJcT3IoyJkv4pCoZnoXhZT0k=;
        b=rspx1OdJ+amBWmL2aOWQ1W9dz6725GF83pw51m3+pzjzfvH+HUxL46SoQDZfJJxN/U
         8ieQcdLJJBAtxYRXRBVqYjd/F7BFl8wTxzYP/9Vz2UGcZMja0pOIqtXcaYqVVaIKlIfK
         hQ//9nMFzjEo54iq6BiilD4n220MOXLxkOL4k20ZErkD6/aA/xv846yE26v7fdBg6t4b
         3xMXv7WGT8+G0OtH3CS0hypuQla1Wg8wniUXWx+qQrWgO1NeWrcZjrxSRTucx5Yd7X2q
         XCsVTWxbk4FhudxUawZjRgtkfcYUIlyWyUzbQeReKfaXDa+AL9gy9aQRiyiuIHNWye6a
         1yJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775059905; x=1775664705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iMl5RIQBcoAsWtIwo/RmJcT3IoyJkv4pCoZnoXhZT0k=;
        b=l/Xohu3/xnCO/gtzlUpk6MOVp4f/ecrriMJtz5QCp7Fl95Vmm9c56Lhu7SqisdAii1
         qvEXWvhSvg4hclLLe72LZ2dxGbXysFoGwxYmQCPWz/qlPn9fuiSVWQWDrkhRe/CFfz+b
         CQ5mn5/SR16UCx3SNf+0uZHwM62/IhBfb3Evtv4VeaLxx76q2AIB8II3a5yRir8Xp3Nx
         KACFaIJt6cLqZZ7SmAANa94S0sRubnMIoXdXsS8RIY3vkM6mgKs8ougys60v70ogLilw
         c6eG9pX/UkDAnbldnZ4VRfDO8RsmWEXjMe9zzbqmLZgugZZ1go8yJVRHmV2qobDQ+qwL
         iatQ==
X-Forwarded-Encrypted: i=1; AJvYcCVajthP+aU3qAcbjTLr8iSbLr7D95xcBqmu3xzLNwLhXUiMsEKJh3zBTpjpnprJeFnY6+gMTeVPEJ9N5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4XVJqofxldmAWhePQPEww6bWq/pjeMf/SDlwtaoPcj9lzgfAN
	SN7siy6iTxafSGdE01P87IpKUAu0AqylwAcyGtLj8e8BvZhrrhZfMIUmR3qwwA==
X-Gm-Gg: ATEYQzzLVd9b8k2qigSSJ/8xQpnJVb13UL531GLG3lNuvw1rMm182B2XH/C3dxLw7YR
	hgjAFKgo4N/fdJb9cyuBCFYSLYEiNpc3kAdXXmo0GThPwHPX29vnGyvijwtM89FEQkXkz8TTA0j
	NQhg9uD6yA7kZLDaVljXPmfT8C4ZnA/bh/wRMbFC7zmP9CMNs6lDaIlYhh0KnN3okaLQUFaffw1
	2rGtkoYWSIfpGmAKrqlePEEdK8Ay6LC+WutjXE1P9gXBSnTb6Vl97wnQl9h7HGCg3nE2gpV/mwH
	mwbzZD5ZHhILEisWlt/GwTNvhNv47kpW+ncvTHwfHSWORO8dtg4ZGjL8sr3WNF0bKhWjLmlUFLP
	shXzdx+ydrBKoiVcC3NWow/MhVsVG6sIUyEg3Q7sTLv3y9PTUmcJiY7r0ulscO4vXfq4dT/LKtl
	HuoG+u66OGFkKOBbX26gKQc9f+XLrKhKHZ33EWmLnw049GeyESBUzQE/lPdzZ0RkvypqHWUAfmu
	BU=
X-Received: by 2002:a05:7300:ed0e:b0:2c3:d51b:91c4 with SMTP id 5a478bee46e88-2c930e6b8b1mr2353682eec.7.1775059905279;
        Wed, 01 Apr 2026 09:11:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5f38:4c97:ec41:caa0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7cf1271asm139156eec.26.2026.04.01.09.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:11:44 -0700 (PDT)
Date: Wed, 1 Apr 2026 09:11:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v4 3/4] Input: aw86938 - add driver for Awinic AW86938
Message-ID: <ac1DclNOl3ZA5bUg@google.com>
References: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
 <20260302-aw86938-driver-v4-3-92c865df9cca@fairphone.com>
 <aae7fRYaoDHMptyu@google.com>
 <DHHWDE7QEOTO.1AQ85UBLO8IQG@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHHWDE7QEOTO.1AQ85UBLO8IQG@fairphone.com>

On Wed, Apr 01, 2026 at 04:44:47PM +0200, Luca Weiss wrote:
> Hi Dmitry,
> 
> On Wed Mar 4, 2026 at 5:56 AM CET, Dmitry Torokhov wrote:
> > On Mon, Mar 02, 2026 at 11:50:27AM +0100, Griffin Kroah-Hartman wrote:
> >> Add support for the I2C-connected Awinic AW86938 LRA haptic driver.
> >> 
> >> The AW86938 has a similar but slightly different register layout. In
> >> particular, the boost mode register values.
> >> The AW86938 also has some extra features that aren't implemented
> >> in this driver yet.
> >> 
> >> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
> >
> > Applied, thank you.
> 
> I'm curious, where did you apply these patches? linux-next doesn't have
> it and I don't see it in your kernel.org repo either.
> https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git/
> 
> Did this slip through the cracks or will these patches still appear
> there?

My bad, I think there was a conflict with Dan Carpenter's patch and as a
result the series got stuck in my internal queue. My apologies.

Should be out in 'next' branch now.

Thanks.

-- 
Dmitry
