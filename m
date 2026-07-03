Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453E6318B96
	for <linux-input@vger.kernel.org>; Fri,  3 Jul 2026 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057589; cv=none; b=Epvoke+ayahc7kwU1Dkt4spSxP3GnoA2L32fYdIjRDodQMHVLQxZvJSjc+MIaepiMPPnvkcfoxvpgTpkoDagyhsdpfPjPAap6JNO6G/nm8nfJM0Y2bFdMYRyKgciLmfk/pNZZNbm6gs8sFPb5A67XXEBXMpfoSNKbm2ADvTnwhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057589; c=relaxed/simple;
	bh=Dv8Nw2p67ddP0dKnVf9qrd2Us/sMLgUELm4HJzxUUzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnuwYvBDjPMcA1ZbjURq+a2rapw1IB/in7G8xcZDfK6rV3Ewo4h7T5wtLkYKlhQqBL3mjyNt6BQgPCMJqK9d7LjCcKNSdf4oBWEPpJFbqJsjxeO4N3N+vopiiljmhext2BUslM2gWkfkboczLcd7N5JuRIfduFVuCdN1iXpuxLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f/n0NoZy; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/n0NoZy"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9c80265bd7so139283a12.1
        for <linux-input@vger.kernel.org>; Thu, 02 Jul 2026 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783057587; x=1783662387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VgOfL6jUNL98zK671Fx4+N1S0EFaelQIFQrG9658iRA=;
        b=f/n0NoZyGOYbidIDRCCijapdeR1GIX21MOTutFMpKSov8YCYrTYhqwKBCCc/4D0a97
         jczXjqQ1QGL7HK3C8g46uBOM1qGWIvGb0QSoJiVQtSP5AoMjYVch+HGkcq07qLQSoyb0
         X0H9Ct4L9fA4/PvYyRuhUtcQGRnbARFQXe5m5RG1jDPtCk/IPl8z4U4vdM2H6MGXy8k/
         p5IMBmMKPwiSv9oOQERvHQ370iLa8qyN/BotnBGwwc/aBN9JB2490sVU6/yaBRJJe5hd
         TzwMR8rvF/5HS/OapwKS9EOqDmVJcZmXYTM/K4qHTGxJD1pQiO3p4wvN04Dbwbq3vtdl
         EjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783057587; x=1783662387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgOfL6jUNL98zK671Fx4+N1S0EFaelQIFQrG9658iRA=;
        b=U7pJl+T29vrYcns8iyjJFH/M233lNQvA0zYdP9qzFlhaRw63YFP3vuDgOQceeEvTYS
         HhPa9tnrp5hKcUYDsuUMMGk8EWKbSAvUiWzRR8vXwCC+jw83MCSFW9/K7Nm/mwb/WZoK
         cm7ZEQMHtlaHI3dVdfXs5lR6FPN0Lufb0diYmG4iEoP3JsSQntYgr81BwjHsffJU1+DP
         Yd6Y12l5IoTH5O6Lcm2jPwYOpMYaMsH15Hwp+ltQFLsVSbiZrw3uVmt0xPAmQ9e+3YSH
         G3o38DudzUWzjwyboASpSjc1c1syqPrgC0CxaosjpVhU7EaKMIk5dHBaV5epWfii3lO6
         TWrA==
X-Gm-Message-State: AOJu0YxGTZe8iRX0R+IDoLwKtBiz8fXKRYPs4QmFuo6AZoS7ayH27Q/t
	hvZkeJvR6BRx1Hwjz9ExkD1Aj1ov37kWH235TMrdtot5zmLtGXf3CCNf
X-Gm-Gg: AfdE7clya4ACXbxrfDN+oVEfgf4D+cLXG9NaFlNbrwSGltnRC4OUBEPtvZSAbBVgBqL
	1OS1Dcl/KsW6MpFMO2mmF6suDtMsfTMiiEQWhMnQ+95SkO0YkJbpeJVEE8ZpYXu8VWM5yQifNkq
	5M7fIQSgzdw5bxqOCoNrZjCK7iG/oyZtfSsrSyEqNeTPeckemW3WEnzOdgeRPeNoPa5MGsqZ/3C
	IuQc0VRUpRjYbF5eoKl0JSViY0zh8TqccgOeWZyHUf/tlRc3hRBm2AI6Wk3gXNvi/cCmGK0OYic
	RZlk9ROPG+xUPVq2KcKJqVJXHlRjjLFVN15C+Dgj4gB2y3aDY5+X4CT4/tD8TNwWqTVZC0Gc/gA
	GvHg+zRedBNdSxkMqH1AimyV/NuxKaPP1qfbUonv9aDipOEMo3pnwwWhlDtq2BP9wUkDVcTVu4V
	CfOgQ9tb15ZSkgSyrNSs0TM/z7C1CzEr3rkDkEDCv9BmIBbG6PqPtGFg==
X-Received: by 2002:a05:6a21:3987:b0:3bf:ae43:4d26 with SMTP id adf61e73a8af0-3bfed0e1385mr11025011637.5.1783057587300;
        Thu, 02 Jul 2026 22:46:27 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:66dd:f357:cb25:7bd5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b85de12sm16655180eec.12.2026.07.02.22.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:46:26 -0700 (PDT)
Date: Thu, 2 Jul 2026 22:46:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Florian Fuchs <fuchsfl@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: maplemouse - fix NULL pointer dereference in
 open()
Message-ID: <akNZDbI4UoGxfuzq@google.com>
References: <20260628230715.2982552-1-fuchsfl@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628230715.2982552-1-fuchsfl@gmail.com>

Hi Florian,

On Mon, Jun 29, 2026 at 01:07:15AM +0200, Florian Fuchs wrote:
> Commit 555c765b0cc2 ("Input: mouse - drop unnecessary calls to
> input_set_drvdata") dropped the input_set_drvdata() call in probe
> because the data appeared to be unused. However, dc_mouse_open() and
> dc_mouse_close() were using maple_get_drvdata(to_maple_dev(&dev->dev)).
> This actually retrieves driver data from the input device's embedded
> struct device. After input_set_drvdata() was removed, that lookup started
> returning NULL and opening the input device dereferences mse->mdev.
> 
> Restore input_set_drvdata() and convert open() and close() to use
> input_get_drvdata() so the dependency is no longer hidden.

Thank you for the patch. While the patch itself is correct I believe the
main culprit is actually 6b3480855aad ("maple: input: fix up maple mouse driver")
that introduced incorrect use of
maple_get_drvdata() and to_maple_dev() on instance of input_dev instead
of maple_device.

I added another Fixes: tag and applied.

Thanks.

-- 
Dmitry
