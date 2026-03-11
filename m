Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A9CA95E
	for <linux-input@vger.kernel.org>; Wed, 11 Mar 2026 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773187570; cv=none; b=owSUhiaBQrJvKaGyAz88UCT4zcfneAzwl7S9UYXOvE0MLRBpP1mEWebe7moOv6op6MZ728HvX8UoEI+LRJt+qK7BDUhI0HH3JeIjP0TTSi7+42fySxH9OfpQDegO/bCbHIGKpA0dmjeszpo47a50TkWd4St3ghU88JTMmjplYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773187570; c=relaxed/simple;
	bh=wIKqqE/8vyJmPCgNfBKSITLivxZHKdbZkgjw17Dn+AM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLiCYb5UMCStoy2CHSdz1QHXy5PxNujsJV9ga0E0m2/WIunwz6FLhbH6ZhpOzcdWaJmYlmOfA/yCuuyfFckDG1By14pF26Fg6tTJO5pVQ5tjeyXO1np38r8oopsMCREa7IWoqr2xTqWGCgnAvu7Z0j6QE9ClsxfG7rTUE7sEb2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gtaFEKyS; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gtaFEKyS"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2be19f05d7dso521329eec.1
        for <linux-input@vger.kernel.org>; Tue, 10 Mar 2026 17:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773187568; x=1773792368; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0L/lW45CWnvJaIFOxubTqqQoUaHcZ4VbTLXbCRNG3RU=;
        b=gtaFEKySIGqx3nPmi8tgu6KYlj6sPdmgf2Vb4dVfYaZmM1MlLMUI7lc+XsTtu+VETS
         QlqYLZF2IGiVprRiVC3LWHaLSJkPnWdt5BgJaU3NAI544YYQ62ZxZnFQ7nr3bD8JiyI/
         RY0Rs3PHmSj5PDVR2jCdvk8+tQQd7tT02/30NkVkmgNa2reJ/F4iwcGroh6GbZAmur4i
         wrcxlz0D6eKBO4QgcmKHZzSR3E5t0uPPXPgdEaRwBsxn+/FSSPfVwaQ7XRzZUc0wA92n
         DNwPWvESqlna5JqspRID2zV0t0TDZon+buc68yW7sf5Be2Ynas4IOIR5Em7XgiyknRGe
         +tSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773187568; x=1773792368;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0L/lW45CWnvJaIFOxubTqqQoUaHcZ4VbTLXbCRNG3RU=;
        b=rIkQCnRVp3w9zbXKys0CrC18tkSKKQpn4UwbJf0ct/f5Z6PzwMaT0ofmnDucWTXkmz
         8Ow5JObLokw2Q3rhChDRuDe419fxBNJPAQqjAuSmWu3ZdZ2IUpk28wg/hL4rnsMzBtOZ
         bej64omp7FdJ4lsdeo+ayubS+YSUX4eiuA9zlOxbOIywUYBEIuY4BuyDPFBfv3Xok5/r
         +TJPbm3BFe8wEa87tEuxj/iSuXPFZw2+5sInC70stwAIUGD8XJYesxRewYSe822C17GQ
         ks1fvB4tP3CryURw+10S3efRWz+O60JC98OonTq8N5K8eWHbxRZz2emjyI0onRQrPCd9
         HV3Q==
X-Gm-Message-State: AOJu0Yzrs2xN4fNs3CdIXycNJpTVbjd3p/1MWJjG4M3X78Iwe/6PVPKz
	N1DBkJoFktkECxAKyhiksRmYPp2D7lfP8rrMopn7NOekxMHUaxatr5H+
X-Gm-Gg: ATEYQzzdRHc3CQyGxPMtOm7yunftOcZohkYg0u4VaA+saky17Xsn52k3AXaVohw4BA8
	kHPMQjgw65iElYVXKG2Nv5ga2RpbcHIjH9wQmqtLNc8+9tFTW+IrXqfy6V+nUi+sprYocMxUpCp
	yK5ivhYLQVowuv8eIOjSxpB3oyWDP56eWPk0daqZatsXmWRrKDCF835+gd8FPRWqFx3ZlQHexCC
	iSNRDmgZbtWinHhA0Ilt+QcOslupEi2/GblvzF8rlJPpXKvI8K7W5KY8m3DzE6PPISqGsHewr1A
	qSt/ACZuYaIF6rTrasFj4qya2GnN2Whs0GauU7spjzWdw4TsHerqQbnVug/W+1nEQlixHZgiQ+0
	rfvEyDhadnt99L+//hzAjHpnwtH3/bNwUI+F+tnPx3uiQUx4FFyEXFV/4pMpNKKc/OknkyjcG5I
	MBc8itM31eupW15SxdGi0LwAbBXLvY6Fb6iz7mR9Tr1d36cpy/T8G5v0DGOpyvnsJW2M22I1MUC
	L0=
X-Received: by 2002:a05:7300:a483:b0:2be:171c:503b with SMTP id 5a478bee46e88-2be8a25e2b5mr233886eec.16.1773187567943;
        Tue, 10 Mar 2026 17:06:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6e17:9d84:ffa0:986b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be8a853840sm496389eec.8.2026.03.10.17.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 17:06:07 -0700 (PDT)
Date: Tue, 10 Mar 2026 17:06:05 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: phucduc.bui@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: mpr121: Drop redundant wakeup handling
Message-ID: <abCx6kZkHPd3lYh9@google.com>
References: <20260309071413.92709-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309071413.92709-1-phucduc.bui@gmail.com>

On Mon, Mar 09, 2026 at 02:14:13PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The driver currently calls device_init_wakeup() and manually toggles
> IRQ wake in suspend and resume paths. This is unnecessary since the
> I2C core already handles wakeup configuration when the device is
> described in Device Tree with the "wakeup-source" property.
> 
> Note: Compile-tested only, not verified on hardware.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Applied, thank you.

-- 
Dmitry
