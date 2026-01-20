Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9F53A89B2
	for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 20:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940376; cv=none; b=FoZXYOxMjrxMNT17Fgy3t2edZb+KcNIvNdpw8H9vMKGRkzAvniRNN8Rj6LS/OITyyKwacCx3wPk29jFRxPNt324Pe2xQX+SIcFf3cz1xtclAsLJWgz2nV844yCsyC5hcdz7wS1w6Zt2s4TQfl3mCpY31EQTBdUg6eEFOehOONEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940376; c=relaxed/simple;
	bh=zn+N6rNyfAL2Dc/Kb52ImFzzzh8ZSytOEiURmXBfoQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHINGza7VK7WZ2na8jslwnSlE8had0UROwEYIEHeAMvjzuGLn9yPgV6kNuz5WJDhC8pxbNeCVRmfl9rP9ohUdXAismCp6YIpbTsYXyiKVxJrciqRHU2kzJRg1W2Oo9p5KrLzjIe4W89SPxvwmGBQsLfxAd0GO6zes+pDnf5qyS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kK6nOLEz; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kK6nOLEz"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-124566b6693so8447849c88.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jan 2026 12:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768940372; x=1769545172; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YTc63I5THXJj3IDdshG+3YThLuMimCJJjZw9x1hg8Kk=;
        b=kK6nOLEzuFtRq4x8hYqAc2OLVJvIOz5QYI7hEx1a26Tdkr1PRmoHg2f4rUxWlQaWBf
         omgSKCXk2hoMe5PFU9KKcwxx0YXGCrRh6tNKoFti3mIy6ll8Re5xCbCFmaNO0yvjC61T
         mwNp1psMKt6py5IJntQIuHVf9WmEOiTzBC3/CUsY0tK/4KVJnpdF2OSEGr7dM4N4ZrZB
         W7ZmwUP9wz6RaWgrg8ih1qZVbTohgnRZ2Nm6PfKXIi/hGT/4Q+RlrH7oAfSaQKyvUd3v
         bkS0LUIVHQcuQtmSk8/XkylLAaRgAR9PIfE8jFmnaYG1nap39CFNHyFBnA+SXI7n4RyB
         Kw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768940372; x=1769545172;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTc63I5THXJj3IDdshG+3YThLuMimCJJjZw9x1hg8Kk=;
        b=nf5tE7fqrr8o58EYPA6P4PFKW4ooKttsczEe+ZCb1MtpmVp4bgeNtFiiJ+D0S8dlkZ
         gNAhuy3W9MrzlgmVfbqBzPFlHb2s5lnWZ6o1Ts/qY0Jtu7Pb8Jy22g0572KnNt0JXtF2
         n4BjKHkcodea9807lk/bXKsxdF6rDJHDNyJv0VXoiZe+5CXm6jGnS4uGnpvB/9V429WX
         HcVEn8mPXIqvFZRAlmNTDYQuDkxqvrG3nG2RMuScH2t+EYwELT2s9TXgZzwMZV0dWrH+
         pxcvB7XeIWBMcvIyIXmiYo4hCtKYbK/p+71BTWCk982fezswcr6cbi3mVHBvCOVmPBsF
         VVaw==
X-Gm-Message-State: AOJu0YxISPcLZFGmze7EremPUAH1wlHZpa2rLyuo6lZ+pBBh2rechOZw
	z4qZzDK/SwgAtyqYVL4ihHNtGKnGnwR+VEXFzxjQfGnvfwf1BO9YWIPH
X-Gm-Gg: AZuq6aKJhHB808yvndYR251X7GePQdKmmJc3kA6sE//LQtiiIlrtdsZ/oVgc/rqmq43
	6wMsykcfNb72+dr8xhIDR1Jjmb4FQTjvRPPHwxLtCPVT6gLBHZypsSyolFkD4FV1U7ZHKpwKs8x
	6ZBmFiRqu+4r0tAGmJTaCR0MQ0hhZ3puYo2OFNPqOj7el5KaNR2ojqlPuTlWUrkj/S0N0WweiTK
	++HH7Al+fxs7aE/CRs9hrYmuyG7IhChhqJeQcHHr1isA/jVv4J9UYl1rNqR6fzkYOmxsQU+bDHj
	05g+ZDICnyGVEBvvtxSOzso+m8vUf52Ofdz9rZ3wGJB2vvwvQZYNo9eqzBmNr62Lw86TBLHbIwC
	bmGKpGElaq2NGB17eSHMVeByn9HZMWpdn03lDCm1DW9KJ5guWhVUIS/6pt9G+YWzymKsO43CI3Z
	2fQiRcWyK434ZxZ96BelDl6H3h16Sb7sp640CweDMYBPvsxed0Y/Dm
X-Received: by 2002:a05:7300:541:b0:2b0:57ec:d1a6 with SMTP id 5a478bee46e88-2b6b4e2863emr9967410eec.8.1768940372189;
        Tue, 20 Jan 2026 12:19:32 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:d631:e554:f0bd:4106])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7081418f3sm2039844eec.34.2026.01.20.12.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:19:31 -0800 (PST)
Date: Tue, 20 Jan 2026 12:19:29 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Input: dynapro - switch to use scnprintf() to
 suppress truncation warning
Message-ID: <ztm25bpbfen53jeuzi2jsj5afucuw3wjxnse6i3zjqsbo2vlzt@eiwg4cfmauwk>
References: <20260113082845.83550-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113082845.83550-1-andriy.shevchenko@linux.intel.com>

On Tue, Jan 13, 2026 at 09:28:45AM +0100, Andy Shevchenko wrote:
> Switch the driver to use scnprintf() to avoid warnings about potential
> truncation of "phys" field which we can tolerate.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied this and the rest of your similar patches, thanks!

-- 
Dmitry
