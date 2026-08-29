Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341AD328611
	for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788003196; cv=none; b=h082tyMyimKS5c3G68KmrXEBMOEIc8unLz7RsQ4O2ZPCYiePEyoVGhtWdiw5P0axS6qakQ2dSYWoe6QobhGOVr+mioBZyHPRs8elMZtZ43vQLmcDob8G+wjP7afAgoBdQrzcZCbzuqCX0FA+knvjPWNMYboVrGlzPPQXkr8unoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788003196; c=relaxed/simple;
	bh=FpM4tqSX4hPhUysrSwqZpM1BuJL3H6lzhbWmt1k0yxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPrMz8NEq9+8tQP+A3/lbaoiAEp2BADlvmFVXc8yHbufaJiINaXpFu45Ew3mBofq7n4I7r66yPwyBP6mzn2Jx2RIf1SkTE5LYI9NqazO/CWeYFH+TYW9TEHfhLfkXBbtqgyD/apiJcy/BbbN5+pWHncZd0R57PEFxkpwcB9fW9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aS1L2H/F; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aS1L2H/F"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso1688532a12.3
        for <linux-input@vger.kernel.org>; Sat, 29 Aug 2026 04:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788003194; x=1788607994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3mVmEjKYcPxfvF0ZyFi84ObNdLr7s7/nOyCIyHdsRAY=;
        b=aS1L2H/FhPRqHd9+68CDAcNb+IB5km+DFhKnTubYkJ5v8gCZGWdrcnfQu5XFofw0V3
         VuQCCXucnfWfNFRySenSFGElb18+mArdNbP79FOnFd5GEbgvWUgXqMh0Rd+mQoGorl0q
         T2S8gzR+iqnQUKsRCD+NSQlxrYsW4o6pZPDDaERNZSiYRZjkUi1Sv2Yl4f1RjsAvfGDe
         y9YsoYyZ9tkDz1OMMmsELZYJMHkqNkZXsGu3fTDp/LG/qL7CksTcZXOTugMm8qIfxFGv
         ch04o4vQivK2hUA5nemgbSA0uY1c/iyq4NBdQOFYjJD3dyuRfO4EEysSvh8yRtTjdCIe
         sgwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788003194; x=1788607994;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3mVmEjKYcPxfvF0ZyFi84ObNdLr7s7/nOyCIyHdsRAY=;
        b=RiNab4iuLcz8rxA/Dx3LmSGCAR2UofQvwqeltqZTGtmrk1YRdwlvbg2Rf/qCxqh6Bc
         sFVFNuXHtzqv2LVLfmv7dbeNF8NpcDOEpAQvOoUWP0q6ZETswNTeYac04fzPWoUEOtpy
         1G+7jnmMqwjJx+JC17LnS1OTOTNwBZLciaxcnEDS8ZZcsNdMutAiLg3y7gLy2ck+sAGJ
         WF5oGiRNcSdrBwFRD9I2n4FsTJ3dGOnBcvXBMGboGctXoXU4qgwtTTM44YRzUkjFJpa8
         YGcbxe0jnLzWQcnACTji0IxheNtHYpKHvYjO+6xSPVhk38QhQveZfk9oEZQo3jkAnl39
         tsRA==
X-Gm-Message-State: AFuF++niYovpyA0zZz8e/7kJhH9in6z3SXt606OJ4trad8WH6G71rN9b
	A4lWxpQwlSIV43W1LTaNdEwimQz4r1fb4ksYM41u1Gj96hCjFm6aAR11MmKOqorL
X-Gm-Gg: AYBFou2Mqf3P+RrZSDFveTp8Ja83MaKdGpmtBLkAzp/aaXm2cguXoo2S8cxv1WlTTTw
	ebur0P6GJcFxnWR12AKlTmMWp1lKyYjRc7gycLE7Ss5THKC3zmZ/TyBs2+Cg91fKHBtK90T3alF
	h9Emv9RJkTrPBba3niO+0t+QbwL4CcVUEddsegG6F0sBkgI09Bl45h0vneBPB/UuOnJJsM2rN/q
	eajbxPapSJINMk2eZEy4T/2a5iVGbsEtPofoCtRjjtV2cTnpYphA1GwCCql5k6SFgfoM4mJTVZR
	rzHaGUbcxAYS8/49hPj3ZMfKAWp+rhUvw76rkwY9CWY6F1E2ve8KWIyEeI/5hUa6AjgYn5zFYnq
	uL2tvHZrdPSh2HuCVECU7QhMKd2PcT2O/wm2ijFMXuxB/D8PIurkS5vU/QEvcPWXjg07Kz1p2w5
	O+DeDVe2Ih2xk8sZLFK7/zpcMUC2K8Y49rdsl9H7YzmuMlUvwHLzBxrvPzGo/CJuuhPb+d/2Y4I
	bAfj+puR+jY4jaCvmEHkTaezchetg==
X-Received: by 2002:a17:90b:6c5:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-396d0f9d0famr24403544a91.12.1788003194510;
        Sat, 29 Aug 2026 04:33:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:54de:b26f:8c97:cc89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e3cf8sm15880807eec.24.2026.08.29.04.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 04:33:13 -0700 (PDT)
Date: Sat, 29 Aug 2026 04:33:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Maurizio Casciano <mauriziocasciano7@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/2] Input: drv260x: Restore configuration after
 device close
Message-ID: <apLAjoZPxp9JJTrl@google.com>
References: <cover.input-v2.1787872237.git.mauriziocasciano7@gmail.com>
 <684969b0f53a9e5f83636b219c139e904e74e14f.1787872237.git.mauriziocasciano7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <684969b0f53a9e5f83636b219c139e904e74e14f.1787872237.git.mauriziocasciano7@gmail.com>

Hi Maurizio,

On Fri, Aug 28, 2026 at 01:16:36AM +0200, Maurizio Casciano wrote:
> The enable GPIO resets volatile device registers when it is lowered. The

I think this is Sahiko's hallucination and not a fact. I looked at the
data sheet and it says it is "enable" and not "reset" pin. Also, if it
was reset pin then what the driver is doing in suspend and resume makes
no sense.

Thanks.

-- 
Dmitry
