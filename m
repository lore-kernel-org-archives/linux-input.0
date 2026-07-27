Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E27F1DDC2B
	for <linux-input@vger.kernel.org>; Mon, 27 Jul 2026 04:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785128391; cv=none; b=Q/nVIEAF5iYvfjBUuUFpsqTkFC+8jZxd4TXrSL5xk3t8zXHSYk6Fu587VzftXslZf/srFmdsNZiEP6kLkXTmhpWWQCHyMgJ/rTrrN21LiqNPjCFlv06su+EAxNKa2YQdIe7Vgi609V1sKK0k5A6FYYxqtP7dC9Tl4R4qzu3I0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785128391; c=relaxed/simple;
	bh=KbMLDapCDnQ3gbB6WgqX2/3LGRgS1DrKgagn3WMLD8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eN+QHLK/AHRyXiD1H7uYmo2I9sPUGCORbEDy/JKQE4nVNentvEVxKSDANGdjtonfBnUbQny05JnODdA6o+XDuA8vcvR2w+4HsXVpogLfzaBCIRjwd1ZApoCqrLuWUdzt+G/mStVtH3qRcJbnask5dkJWz/OIzBQFJQNfD/7PSMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFwFI8NT; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFwFI8NT"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1723275a91.0
        for <linux-input@vger.kernel.org>; Sun, 26 Jul 2026 21:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785128390; x=1785733190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yf/y50jjHZ/2DjuYllUvY7ZWDz9jGEBmTBiZ2K7WMgw=;
        b=cFwFI8NTLy9AWJbok4die8Q9+ntpPfjUJkdIE7fJt7jWSUJ07toGmzuy7hZkUO+PJA
         QO3RzPezHsNxQ2Y6+grLC75r50lilKDLUQ6Y5iMqFzU5jppIorquzn5fy98XHDQ0dYRw
         lfRgOwBBJKYA63xfP5e9YSc9evcEqj58wqAZ/Bz4twabyniG1/oatf9AZ26X72xYxFTz
         qOHyDtI22lKr5GAWfgwPU+Rcib7qkFGaRdoY7Kadac9VnjCHbW+Py0WYmA+0jGkmYryu
         9+gXnR/S0KmJzbcTiLBB6d6ybj4NdOmcNOcrD0KSM9cOg4oHBtihhTFxlGYU2gxsSdDQ
         Xkww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785128390; x=1785733190;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yf/y50jjHZ/2DjuYllUvY7ZWDz9jGEBmTBiZ2K7WMgw=;
        b=ZoBPD+ksXr0/ouIyj65gtTlZ7TrocZySALQDJGp5tuYJhiO6R/wPVkPrEBXo1E4GPW
         9RZCLtucqHk5Y8VXEWJ1BP2NrVDfObv3hkoePzdySIFhsvuKT9H8wqwXqEH4Ivz09fPr
         qrJWC7mMTMwdv7Wp7OmeBFZy1ejeVxVoo1abeaa2dhmayCoFHnQnNO/U27p8MSg5+ccG
         G/HHl7Kv1awdPKjgObekHCqAzR1L6G0s44hbZd1WLJfdykMZ/LAfL0fp8g5NID78+kjY
         rP40gwDIevmirXvu6unF3q/R0RuocI712ZoaZUjsRZmY4xsTi2QKpXux7seWwguQ1h6o
         nfMg==
X-Gm-Message-State: AOJu0YyrK/6wa1I7lR72rv6wZduFhVdDs30Gb+bUDyEH1wQx7rgra9Bk
	AlCmfAAop9NC6RJ/pqqECGdu1AVkUyzlBs5pJGScuYX3BJa/03Pd7Syz
X-Gm-Gg: AR+sD134DBz5/8QpXwM00g555Mr4hMW4fXdjFNluvOn0Jx9AG60YDCwhu04x6xUngzk
	vbFjNFC8Mq9M11kkyGAnQwFfDBmS7449xKrgUK3gTPOdEFxDelqAZ9Mf+hyBfIXGPOdP9qhPVn+
	f+CizGCU60UiftnIsIa015u7HIltRC7icE28W03tFCtov+XzoTxvqZEqdxK3fmxyVYqPuTXxNkD
	Cj0kgBIUyKx31ZsJU2GfVQHJkR3VAhii6yF/XGTspmDy0DxnFkSTOJt/tLSYTGQqTPJPWDO1N+t
	TJyc0fD3QS+EwD3AGdgpuP/3LBTKeD8N4XMdSbkCtVFUrdMdZYePSGoiJPCAXBBTDoInNXvVGQL
	qyGa7w2RnMpJB2S/3jfb6DcU1CVUtomNpja6pPkFdPuH5noBziEuj4za+dVijwweQAiRC3b1F6j
	J+SD8W5cKFpf7NNUmtiINk5LszhKYK9VCKv0MKvOWmmX0=
X-Received: by 2002:a17:90b:2703:b0:38e:5b59:c2ff with SMTP id 98e67ed59e1d1-38f293cd41amr6792422a91.3.1785128389662;
        Sun, 26 Jul 2026 21:59:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:fc2f:1878:e714:ef41])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130262d2sm45601415c88.7.2026.07.26.21.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 21:59:47 -0700 (PDT)
Date: Sun, 26 Jul 2026 21:59:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: VegetablCat <vegetablecat@foxmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: xpad - add support for Beitong KP series
 controllers
Message-ID: <amblrS6NsHCy6Vld@google.com>
References: <tencent_A72FD342899FA27A59D321374BEAD5828706@qq.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_A72FD342899FA27A59D321374BEAD5828706@qq.com>

On Mon, Jul 27, 2026 at 01:39:41AM +0800, VegetablCat wrote:
> From: vegetablecat <vegetablecat@foxmail.com>

^^^^ Huh?

Thanks.

-- 
Dmitry
