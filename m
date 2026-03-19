Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C6A385509
	for <linux-input@vger.kernel.org>; Thu, 19 Mar 2026 05:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773897132; cv=none; b=jR4O2A3EltCG3a5Rjj36Ow/tii/R7Dn1aJ12rtkpaMi0VJTIRaaas4j2z+T7qnRHYNobGyNyD5X8FDyY5A+X+RU7BqSfUmVtjyF+aWxVO8BSIgtVgNNrzGxtZ5vBjwcPVqTAu99x6bGt84Sf9te2xI+VJrTU0Vw9O1YWtViE4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773897132; c=relaxed/simple;
	bh=vIW79JnLiLXSaAv76cZHGspHo3wFZfnh6SIto6S7T/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3zPP/kbknKFv+0FMFeJ5SyQhNCwKV7GP7lfWaF+0Kd4Zfv7IQKqu2d2mcSFd+Eg8JF9IL8ZzJQ2edkTd8uip8aKJUi2HhcVFGB3Q3HCP1bblX1Q2AzQ+EfmuS7xGpIZPSepu0zncreBH7zXlcskhUuz4yjUgrscCNTE7G16S1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr0htdfT; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr0htdfT"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1073791eec.0
        for <linux-input@vger.kernel.org>; Wed, 18 Mar 2026 22:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773897128; x=1774501928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hqb9SO+Q6nFQgrXLgRcpJBL/MmDsCN3sih/lzoBOP1Y=;
        b=Lr0htdfT7HXjnl4oNCdrDa+tgBhjY5N6n2Kvh11tMS6xTlisYPXVL0byvAjI45qpFJ
         d5cUjfrB+e6DuMm+Iwq44nefDpzgwmT/Tn2m9HRzG/pQLYLveWWt+1Th4W+b5JYebNrW
         OCRCDdnXQylOdc+1NVxXLVrvbRnuMy/HLFBm+HsDdqGPpQXbMYIyyfEPCxCBZAK8bLqv
         3VBjuXHhjUcra9Kv6qX+wJfBysk/q+w8RnPK3PeiwmOouqmvz9f1xCGmMQY0V96eYapF
         +NAaJAeG06NGnSdxWKZGGsdwwDSTzXt/UfrLEko9IShK/OYMdG12NTmMK5mwtx/98Iks
         FlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773897128; x=1774501928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqb9SO+Q6nFQgrXLgRcpJBL/MmDsCN3sih/lzoBOP1Y=;
        b=CfSVzKcF0tiZ8YDZi6VL6h5ZTyXyVKN26vMzZ3feWRhOdCNd22Jn8bcCM07HhyxhXl
         lSh0UwxqntEvnnshStV2jfCx5XvZSzjeMK6ZyszEajNbCR0SsuKYXNVcICNOv00VfcIs
         iGb2nIJvtPYx8U9TZNvm/sFWmjNhpF8USvpNu+jUuQbvScXk09uL4VrFnOSUCqJYZ/VJ
         rVUvygi5k2sDWDsuBKO3sI5PBqEbbUeT0WRKJJCIIU3q0tL05z8lNskenaqDqIQuV17a
         M+a+sX0KbpPbK9AoTgEXZVHZ5LBuDZEGQF4XQBpzI3V9g+2hE8Zlj8BmuBTc/i7bTmC+
         XHZw==
X-Forwarded-Encrypted: i=1; AJvYcCWlRK9n31sGO9fKHeKGpEgHMLIJUvMc8x+PxZ+k1yUf3fReGdF4Z+FbgTAzCmhTL/gmwkXk4+/0W5r2CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ+IJo1Vd9bhWYObCoiqWto7ojRBrWcBAHbNVAgoD4CT8NcEGD
	h6wNEGLpyx3RfWusMQmG7pdRRlUIXYTDlJixStH0+yrfp23GvYb47VZf
X-Gm-Gg: ATEYQzzFS30KcfCOfNiEo8lKUD8no95hoXPvqJUme20yxox1lR+y3by/3P2+lCEcodf
	eTkdnzBqviLZxNCGmjTDxO7twXRT7ixQH1tIh31uDAHH8NEv0aUr/zyZ1jvt/EI8Ncx6dG6PdpR
	3n3zkExVr8Se7yMUezt7ks1KSe/3M3JLS0I1jGYuxdYW/KSTEJRMYkxSTF4UJongnnDytv9H6Og
	vE24a5hZTTSiOKd7l4jtx5E3L22AbmKNnYv7u2FyXptEx9v/MnU9pCJWRD3XHSKgYCxB/SLsJCq
	DMp1xKNyysN03MiKQTaYbjMosE32LFQ89vtXlE7ZoryiF8FredyOnmRW5ffPZS1Vi119w6Nmn5J
	0EfoxMK8kTkMZIAy4z0NWB95ImW+lUuP4++jh4b4cd1+oAF5hKiea0epFxwi8ciZQeG4jv45U5p
	FKoNHre/gFuLG9FsJFaRzUyqfl6M2oVel39KqNZ7m9l2dNId9/q6esgUk4ZsnINgo=
X-Received: by 2002:a05:7300:fd16:b0:2ba:85d6:e777 with SMTP id 5a478bee46e88-2c0e4f79dc9mr2238568eec.2.1773897128303;
        Wed, 18 Mar 2026 22:12:08 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5966:2bd9:1ed:e7c4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c0e55ca0f6sm6652882eec.25.2026.03.18.22.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:12:07 -0700 (PDT)
Date: Wed, 18 Mar 2026 22:12:04 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Frank Li <Frank.Li@nxp.com>, Job Noorman <job@noorman.info>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>, linux-input@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: touchscreen: trivial-touch: Move allOf:
 after required:
Message-ID: <abuFoZWWra-hVitk@google.com>
References: <20260312224925.186077-1-marek.vasut+renesas@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312224925.186077-1-marek.vasut+renesas@mailbox.org>

On Thu, Mar 12, 2026 at 11:49:01PM +0100, Marek Vasut wrote:
> Majority of schemas place allOf: after required: . Documentation
> Documentation/devicetree/bindings/writing-schema.rst also hints at
> this ordering. Trivially update this schema. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied, thank you.

-- 
Dmitry
