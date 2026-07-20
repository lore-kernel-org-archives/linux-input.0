Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B684C399002
	for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567310; cv=none; b=OsAO2rB3SdKzApI21UCxlwFWl0SD5uSpfvulnbf8wNSDpjh+C6lXrFPyLox8YCvR/fj2zN5nTqbaU7CBYnLYXyLUwBMSVK/hKvqW9D68Rj0QGh/8gZz/0wSd3jRL5EEY33znQmoy9XXtnePRnVcjJZc1bz57vDrcmW29W/NWZRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567310; c=relaxed/simple;
	bh=DEeo/lUwBJgIbZTi3tUzGt9Z4GqoKzAJLZ722ywBH4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHHd2UQN3YgVy1dlgdeb3FHw/WOm/Y9oUr6l7P30GEJ3Mb2Yx/+XKr5cWgB826pyEzKf/EARBFOIdG1KtbpkfcPOe19aAHJbH0H5oMXnq2tXwI4R2v8j3TPo2+uRRyGb3sz/sluhCuglO7XNa5VRiMM+/WLvLc9y+VYCuBFqLHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtlGaG0/; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtlGaG0/"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso4197665a12.2
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2026 10:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784567309; x=1785172109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NSwjZu2oRME8Jb/qHPKyib9HpOEMkhZFS+o2UpYz3eo=;
        b=PtlGaG0/wsROMA4b6QPxSt2n9BOp5MYs/2wdDorcJPVaGF3aEDOQUrJvtJkQOYQtvw
         EKfdTccYQP36qDLngKV1G+Ufo+55lcDhexBpJB7u6jn9K2/uPezFVSq5R8960JTdAnjB
         09aebEJ410D24foreMoEf+PDX9vPtX6eVPCOoiLcaZOCE10WnrhZcBoPNyjpsAJqL4Ia
         XYX1aJSRESFQ1uMm+BSnmVDXU7hhSXHhrtENpTB277zrboVfhK/spv675rOxSsu73b3z
         2RyKGdSGIe81FQbpIJyGHpqXdK6nNUUr+2EDgWoAXoXxaVWP7pTJUy3LzgGweP181u/R
         b7Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567309; x=1785172109;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NSwjZu2oRME8Jb/qHPKyib9HpOEMkhZFS+o2UpYz3eo=;
        b=A2+zz9h1QDIZC+9HOOjP+tLDarLdMnjUJBYYRz8F6wWRS3oyalMi4c8vPLvMc1cEzQ
         JJTXbuRwpGyt0ttF4Vhmoo02+1++XDgnBFDbNLfPLWM2VVf1JOXeUT12h7uL38eRuvCd
         7fSRO3CI+fmbUjxi5gfHXQYFCX5wEiZXxboWlCA1rsjvwvdzBWli+GV0zgdBvCa2LtXd
         37gF2Qk5uptOtdWo8KqQq6WlHFAyR9g+YSYAo5+0w/O1Z1Xy810gl+3QhYbvOCsgZjp5
         bFUl64ZIPO0Rd66aUEZDdQDf2B8blPKFGs/izi/UfW+dLXlk7TZMngVeay+34/vM26Q9
         xdLw==
X-Gm-Message-State: AOJu0YzNTpcIGh80KB7V9LPHzrNLNyzZNkoJJYCTjLWtmugusuio9FJ3
	bQ7N1To7RLXuBbisenra1xbjDl/C8PvRb55s9vTn5cBZa+/AeOi+0X4u68jIVQ==
X-Gm-Gg: AfdE7cnpOZrAlIaElDwoWWLFtsm4rYF7157b6Xqp0Y7ouymTbVNfSyPRGPWI4hxsuQv
	3x0q/FFlE854gUvagkP99Yefgc1x4Gcy2fSnYUZ5oLrGwywW62pF/Y9+imJv44/TenIe/IY8Rj2
	XQQvssxAJOg0kT1dJYgnzeqtWx5vdkGfhZ4mza8kw62zzGnLCecqD6P+ipupnRZHYD71hKygYVs
	U0nljGhPJYJTUJATw28YPpIZsvHv5ksutJwr4R/nqetBSZluZcrud4t/Mk3JkIgAl+KOJh6g2IQ
	hW8R5YXM66sQhDtflLTP5EBcPM6y8FKHiPGinfQiuyj/Axh5924cvXTJkhw/eVTPq4O1qw4rRlr
	oiRvTSYBZ7CNscrAewJL0P+auDu2loSQD6+TmGGTl72P7Bc3NSdJ/wQnQ+ePBV8Wxx9xH0S+N33
	lBpxOgqzmI8yMx+6n/JTKFWi44gBNfMsNi3m0cUJcqrg==
X-Received: by 2002:a05:6a21:4a97:b0:3bf:7e2a:e874 with SMTP id adf61e73a8af0-3c3ad6682f3mr16178000637.1.1784567308894;
        Mon, 20 Jul 2026 10:08:28 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a068:ecf:2296:fd47])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1de21asm38852501eec.23.2026.07.20.10.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:08:27 -0700 (PDT)
Date: Mon, 20 Jul 2026 10:08:24 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: phucduc.bui@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: st-keyscan: Improve probe error handling
Message-ID: <al5V0Ym6zCGqPqJI@google.com>
References: <20260720090851.230244-1-phucduc.bui@gmail.com>
 <20260720090851.230244-2-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720090851.230244-2-phucduc.bui@gmail.com>

On Mon, Jul 20, 2026 at 04:08:50PM +0700, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> Use dev_err_probe() for devm_clk_get() so deferred probe errors are
> handled correctly.

Same here: in what way the does existing code handle deferred probe
incorrectly?

Thanks.

-- 
Dmitry
