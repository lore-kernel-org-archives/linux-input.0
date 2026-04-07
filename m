Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8527B1397
	for <linux-input@vger.kernel.org>; Tue,  7 Apr 2026 04:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775536305; cv=none; b=pkeMkmvsye1rY6HKvxaddYjv/kHMiH/Y678umbPO6d5ZLIxshtpudnnopFIb0cBwnIUgNo3z3E+cC20rEDrg3DxDp6k+xcvRusdwMo57UURpi47nmZgnlt1rhJobR/Grp8QNjTsmNluLJTed/p7tI/BzOIdr+K5z06/cJMeBWZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775536305; c=relaxed/simple;
	bh=dVBBiX/95LB6Hc2a/buyNfzfe2+rFXyBgt5saJqtdXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2o5P49YR49g80+Vm7uv7QEe+1Ai5orXSKn2Yal6lVzHkT4Rx/WimLXIBzNLqA9drpmIuQ6mhCZ8ZrARVV8bUrA02U/R4UrbsKp3r/OTvunuQveoI4CudWcCjwWYbMV9DeCjwP/6BkCYBXNAK7AvveNMcBkdmDKtswACo0KoThc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlOS8LeZ; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlOS8LeZ"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2bd9a485bd6so11558048eec.1
        for <linux-input@vger.kernel.org>; Mon, 06 Apr 2026 21:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775536304; x=1776141104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F03Ec0GkkWT6TlMSA4pHOSGq3l9GfLuCgSRTyWN3Xzg=;
        b=WlOS8LeZJt6vszddJvAthLEHpxFtXAed8DrhklPLmvCGs34dEwd1WOGnAm6ftti8cx
         Y0JV2OM5clk0zJ/VafWdDU1YcLWdPODBxX8of6Bv6NXAtApWOoZcGVMtaaoU9s/kcJri
         2xP5dXb8M9DFIfxTPPQndjSjLGPIwvnKsuDCg7xS4EoFQGC2yEr3ybyRvj4lug2Xe8da
         PCAH/ahhoeTgszXyTv5Dp/ve1kjH2SKwX2fk3q2LcKH5Hp8yqDCPLz9mx9kBQpGV6YYa
         hQWPcKPJ5w75j1aJFFwgNGcSyuB4APah/9bb0l7s7AZrmCz31IKckYoPMrj8TgTm3iIw
         ih8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775536304; x=1776141104;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F03Ec0GkkWT6TlMSA4pHOSGq3l9GfLuCgSRTyWN3Xzg=;
        b=XogPrKsJ+oSRTA98CsMHaG/MofCsC+ffaqX2ZCQDpYqnqmWw3XejF+hG6efJ4Ix1j6
         JeOfP3HrcZOmZCRxdgdMZENwi7E6b3c7YjNIiVi6pUxN3qI41ee2Yru6Ypg/rBsbUl58
         dP+Iy/vm7gGGVjJj422nwv9hFkswNUpOAg8AkP2V/qRtKfeV7yWE34ceXc+YLfIOp5h3
         zwPAcm/Y6tyqUU80+o4kh5rEsNo1Emh+sZTRgIpqS/3o2BUH1TGK4NEIJlQjwn6626Es
         s8bBoD6XzWsiqorKjfa9QqOe0IIYgd+j24OGEjbrSMY2QcA0fvWxqjSXyofu50LqK3y+
         8EwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3yBaLg1iwa7y8BF3a+bTPJwKoLpSGczqkLuwjKxhuBTmk9A/fvhi2ZXJPf/rNWyVp127LDsRyyML9fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIpvwhrvQLcjoPJRxfHFK260MCgfRYfluCjdCTSNsifwTr+QZ
	4JqzrQ9umz0bg5I3pR3GxDjYux2hwcvbzutdociTczFlm/ioZnE8GEzGexuHPg==
X-Gm-Gg: AeBDieuZdRcrp5rknMdL3tVIbxX422NeMETLchUnvmxf7QIBiJs5eSLdO576LLTxHY3
	90khuvjrjkvxdW/6bAiIKDvJU6HMteKkWG65jJyPhg5qcE9j3Az9899KLWw9oFFNenhRlKtt6a/
	avRqpM7OP/JtX8WuJYGAfBMi6+HHhHcIzb5hqXpO3OeWBW2qbsYHCdgR/TvE1hu49a93Ty/1g3P
	cqNb31i2Qluk4xF9jtvThREgyEuXUHiRbVFgYf4+Q/GDhrFcLOBR82wX6zkXsdJf76Wp0YD6mo0
	8BscsYLjhuJxxCo6czc5GyVHdpn6GC1v0/Puvn7xz1TLP3Cn4A3axXGvtrwpvaM5p9V79TmoiZX
	arIeJb2pIqv49GulUCB8CPPchqsBL95ZGezFOWbnPXtinLUsJLXgTTNBtaqotaCrxon8Km/Cp63
	B8htvZsPLGXlOsAlocINpTGzG6saPdhusqLsDzcxn9ABfIZgX8J5K262UfXLlIzN5T
X-Received: by 2002:a05:7301:4090:b0:2c0:becb:7640 with SMTP id 5a478bee46e88-2cbfa9b364amr7354775eec.12.1775536303406;
        Mon, 06 Apr 2026 21:31:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:dd71:7176:b4e4:a7a5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d1ea7a94fesm340591eec.13.2026.04.06.21.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 21:31:42 -0700 (PDT)
Date: Mon, 6 Apr 2026 21:31:39 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Armando De Leon <auribe84@gmail.com>
Cc: Armando De Leon <learmand@amazon.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: gpio-keys - add hibernation support
Message-ID: <adSIEzW6wfY5rRTK@google.com>
References: <20260406160437.3084755-1-learmand@amazon.com>
 <adPdc2Z1SYxvqDmP@google.com>
 <20260406203932.3391600-1-learmand@amazon.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406203932.3391600-1-learmand@amazon.com>

Hi Armando,

On Mon, Apr 06, 2026 at 01:39:10PM -0700, Armando De Leon wrote:
> Hi Dmitry,
> 
> Thanks for the guidance. I investigated further:
> 
> The upstream GICv3 driver (irq-gic-v3.c) has no suspend/resume or
> syscore_ops for the distributor - it does not save or restore any
> per-IRQ configuration across power cycles. On platforms where the
> GIC is re-initialized by firmware during hibernate restore, all
> trigger type configurations set by consumer drivers during probe()
> are lost.
> 
> The IRQ core does preserve the trigger type in irq_data
> (irqd_get_trigger_type), but resume_irq() in kernel/irq/pm.c only
> re-enables the interrupt without re-applying the trigger type to
> hardware.
> 
> A fix in the IRQ PM resume path (having resume_irq() call
> irq_set_irq_type() using the saved trigger type) would fix all
> consumer drivers generically. However, such a change would have
> broad consequences and impact across all platforms and interrupt
> controllers, and would need very careful review and testing.
> 
> Given that the gpio-keys fix is a single irq_set_irq_type() call
> in the .restore callback - minimal, self-contained, and low risk -
> would it be acceptable to handle it at the driver level for now?
> This avoids the risk of a sweeping IRQ core change while solving
> the immediate problem for gpio-keys users with hibernation support.

I am sorry but as I mentioned, the proper fix is in IRQ/irqchip code,
which will ensure that not only gpio-keys but also the rest of the
consumer drivers have consistent state post hibernate.

I understand that you might need your change for a product; I recommend
applying the patch to your internal tree while you are sorting out a
generic solution.

Thanks.

-- 
Dmitry
