Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EED38D006
	for <linux-input@vger.kernel.org>; Mon,  6 Apr 2026 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775499509; cv=none; b=Ux+woAQGUaL0nRT9VG81sXJSYaQQed9YMbCKiUq1a9RB7XlOY/QqSOduIq/RxDEVXMggrO97NwQ0SUeBrYz9QXu9xh9eRAePANTQi/IWs9kZV+vjbgYmDK/9pckvIZh39Yg8/YV86LIkp3D6V+iyyhb2UyTUGL5/PaBKp+T08mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775499509; c=relaxed/simple;
	bh=GR1sNINO/RUqMYk1EFcM5BXaUzE/t5ecsmgjyUVxapk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhPycqQd/SpF2A5ZXFIoCKatcPP1sXxM1FJUUoHDzNeCf+5luofhvkGWUqQ8EOibcGcHiSprQgtJlFoT9UQpc5FC4N8vYYS8rjUk230XIZX5cnREiGw3q5aTgRdS5ZUJcCEqiEb1KXb9zwPg7BAo+mxTV3dAOer7ISk/iB6vsgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=clUk9wH2; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="clUk9wH2"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1279eced0b9so4733458c88.0
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 11:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775499507; x=1776104307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NfZeHT0ZLthLEJsbk1CZtexgkzwdO4FBprTiGJKUEHU=;
        b=clUk9wH2ddwcvEF9fseopqi8wpjF7hsS4mrRIamHTO3grPArFqh4RzMiR48OOy/zkF
         6X7bdWQIkKncHBDwDX6VyIHiEr5g3WHHBWIKbH8WFkv4h51TXYN2iHz91R6Cy4yXOG05
         r9wXnUhfhf9UXSDAhBu6pNXHAiQT55VRTfyOSRworJ62M6aL4XRUmVh1eAkB38XoPCXZ
         Y/t3TKUym/Qcube2XDxT/FXltrXmZ00qYu2mncaJea//rklDTR6t0YbLzQy2AOsoNzR7
         rTN3X0pviNlj18W75f2UwrZtVyoZkpmJ5U6AdkBksbgrhy+2gzC033E4BcWc1F3tmIJX
         qmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775499507; x=1776104307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NfZeHT0ZLthLEJsbk1CZtexgkzwdO4FBprTiGJKUEHU=;
        b=tK7bA8FPOjPac/0PxVkOhi2T8NxA6NFA0EWTg4duyBMlNExx1lK9xNw7jS7T8VYBf9
         W57UkEaAhEUr21UqcSLH+XY/9Ukobix5kGK425x99bUU16W5BvupNz8FnGs+zP5e5TSI
         OYhyFWoK7t5tbzNLpEAXpKcwbJFTP6Jk48Hj3LL4aZyzSgNuI4niNFUIP/GJT32veGN/
         toTxbuRCIMnBQww+yKPNI6jWbc4m52polaPktVswTSviEhCEhwo/3YIPG4PxIsoPaQYr
         baDsNzSQXRjxdDiJ/EPUCxYt2CHSshODnvVmJ7nxF0NfHyenio6ZjssI5gx/VQC6F57Z
         szwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0cSRXzH/GE/J/A+O0Lyh/rnLw75f7//YiKZWuSVO8AI/QSDjFDJLpp+m6G9HOXOumC1wLfo6EAevB6g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmQFwNnQcxIJp164k1BZT4o0KrrFpr8wnCPsmt6T2AujwYcSi
	LfyAOuRrV7wOAYAo49C7WWcGFT52/aJ1FVTpOxTWTEzPSn+BYv8tZoHs
X-Gm-Gg: AeBDietVfXelro+HMs09wXL5O4/YzNMBhlMChsJe1I2UcnGub2N96hRXggf4AgwLrxa
	si/9BmO7SVbjWxGxWmTlVEH9Dx1FPzuZCYe5V5fIVv7Yx/1bvQOrsyb/Fyy5OnW6pbCnX0Fnppy
	mgkaYT7/2TG7HAEFFGmgW6r8NrlYIZVUtnZjUJz937zGyeMO9/oQ2tH02viKA4LIYrpXd2zVgSM
	YyXeMk54qyAwLKb1yCmr89yKVNLpEUJhnVwup8ZInH16TigMfW2YRhBMUoTM9JkpHyiMxcUAs7+
	7xtLzbFHy5LYEhlYHc92NIT3gmM1N3MY0zXycsO/Q7YOZX/nDKtI/KIyuvxejTJKnkDOJ0CRzVw
	WTQyYwkWhfaCo588ZX7LJCUtqebvs/sTEilhp8WZ7++mG028SruPizt13t/E4xrc/j371VoTCgl
	Ylf14SwxLK9TvaMQeODjCyetTLCd9Cb6+NvxleRFFuKnl/mZjgW6eAYO6d2qOlrLC2
X-Received: by 2002:a05:7022:212:b0:11a:fb3c:568b with SMTP id a92af1059eb24-12bfb744257mr6269320c88.17.1775499506972;
        Mon, 06 Apr 2026 11:18:26 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:dd71:7176:b4e4:a7a5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd4e4e3sm11128775c88.1.2026.04.06.11.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 11:18:26 -0700 (PDT)
Date: Mon, 6 Apr 2026 11:18:23 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Armando De Leon <auribe84@gmail.com>
Cc: Armando De Leon <learmand@amazon.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: gpio-keys - add hibernation support
Message-ID: <adP2qwkmun92q-w0@google.com>
References: <20260406160437.3084755-1-learmand@amazon.com>
 <adPdc2Z1SYxvqDmP@google.com>
 <20260406165833.3137128-1-learmand@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406165833.3137128-1-learmand@amazon.com>

On Mon, Apr 06, 2026 at 09:58:06AM -0700, Armando De Leon wrote:
> Hi Dmitry,
> 
> Thank you for the review.
> 
> The interrupt controller (GICv3) is re-initialized by platform
> firmware during hibernate restore - this is expected behavior, not
> a bug. The IRQ trigger type (EDGE_BOTH) was originally configured
> by devm_request_any_context_irq() during probe(), which does not
> run again after hibernate restore.
> 
> The TLMM/pinctrl registers are correctly saved and restored by the
> platform's syscore_ops - I verified this with register dumps. The
> issue is specifically that the IRQ trigger type configured at the
> GIC level during probe is lost and not re-applied.
> 
> Should the generic IRQ core be responsible for restoring trigger
> types across hibernate? Otherwise, consumer drivers like gpio-keys need to handle
> this in their .restore callback.

I am not sure if it is job of IRQ core vs. particular interrupt
controller, but they should restore the trigger types along with
entirety of the interrupts and pins states to exactly the same condition
that they were before entering hibernation.

> 
> Either way, gpio-keys currently lacks .freeze/.restore callbacks
> entirely, which is needed for proper hibernation support.

Drivers only need dedicated freeze and restore handlers if the behavior
should be different between suspend-to-ram vs suspend-to-disk. For the
vast majority of the drivers they behave exactly the same and I do not
see why it would be different for gpio-keys.

Thanks.

-- 
Dmitry
