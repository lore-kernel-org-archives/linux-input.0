Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE4831E822
	for <linux-input@vger.kernel.org>; Wed,  1 Apr 2026 19:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775071759; cv=none; b=Z+BAgkK1gYDaF0VuIPZTPneX542wnTuVP+j602raCvgFIGLwF3MHYxuwxDMuqe3eleJBfQ+Azr+z7sliIdBp2bltlz2Heu1j16q3GDfQ4rwQYXw4zx9vJVhACbyycp0IVWrVqv4L/tzs2Z7VC+wDRGm8ARm6rTaiCv6nfpp7WvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775071759; c=relaxed/simple;
	bh=2eTNHF0bZeLAiPU49Yh2C04Z3O5f2NeB1Pf6s2B287s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7Rla7llw+kyWGexMvDnrmcMOm5eB7X1+iOVFqFP5kUzpqISc+W8CWplvJo6Ro3otYRrN65ysxcqxbj8If99hyeERipIWCHwWcRPRVIAcUX+zKbUary4z673a/qfsMWdSzepslkL7B5bHuRdtQWd3/F7v4z4UOY6mHYuZnTud+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/kj1+rR; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/kj1+rR"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so148751eec.1
        for <linux-input@vger.kernel.org>; Wed, 01 Apr 2026 12:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775071758; x=1775676558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPnSoYguA2Jagx3CZ2LMOq6guAwJIRYuTtTKPzl1j+8=;
        b=b/kj1+rRlkEl831u+L8ZoJSSDMRBJovTNQ4wPnsMfgEpSU2uHpPJz6T9u67c8oiHU6
         yLJv7ODsHYkFTrb+bZCxhhJus88lfYP2QmQyV/B8y8u2Gx3k6UnU7y6Jlvj48YcP5tFE
         3thVJKzXYzxUMn3G1n++cBxMVP8CC4OsoHWVTkgReab4g8I+XHtEq6hcUrGLPFyH5TOj
         byFDWtvc5nV3612gCa6OlOlvF+ATECK3vFr0sNP9+yAg6sau1ckZ4u/rHm9BmvlHYUPM
         jQU9ELJ4til5qcouBwHtFClZPVJ48G+vNjDe+9o+4yrO2pHGU73xjvO7gkr9V42G/5XE
         f5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775071758; x=1775676558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aPnSoYguA2Jagx3CZ2LMOq6guAwJIRYuTtTKPzl1j+8=;
        b=E3UKvZu5wXTGuN19gnQVDpvM/tpddyTWQH1qPXSqfiIPJ3NyC9rWralzyQeAW7brML
         440hHwDE7MMyc3sHx2iZVtIt+1z3HhGdC3CB7F+oToXWgMAaP4jvP8p7ay/Lt4Kja8TW
         WNnb/bxgEuuXxhsrUiohhgcYxv1AiLLnYKeJbyDpeE1E2Ep8SnlQKzwcTxHiIormGZMT
         j3a4vcA/DuK/jBbOvDbmNcTLHCUK4yFfpBk2g3APZlRw7/fz6LxwtgMaxpDUEpUW97T9
         6823k5sHu9DOwDYP3T0SoqQ5f0Xjhr+NFqpnvyQDioQwnD6m4smkYTjjQVm8OGyZrHy4
         hMKg==
X-Gm-Message-State: AOJu0YxH+tmDAcF4Akyk12G9jNRVs58uSlzcn9+qdc312dV1sFVwUske
	pvN48CNR+7QLDzmgrIRgGjO2N/KZjK7zPogG7H/isAvEXu5TQSeVx+w2
X-Gm-Gg: ATEYQzxu7yeZMviEDZRwT/Ft08pBGMMb4eXO+py+mBX8yT6MPDgmkqkJAJSxiDodq1c
	o3q4fXjhh3XMxoCMrBQMs0fb3fJntbeWJKzxlZFbfuu6jC4p782EV8QNwx/S0WexwmlR1mjTarb
	Qth3S0JlWF3DJ3YleRVWfoRoIxL7wqwvnL0xD6j9/h5J0NmDepqdK4yQn91NEUEmOFocEDq06XW
	Ng2a0rU2vPGVDMg071rOngED5yBcHZYpBLBysI3Gy2vCrQy5Q80NyDPp3Fv0pOjyi/vp/TJi3Gb
	b4E0jHKKphloutLxqcHqOldiqugRA6Sr2ICUBTI6f0HSQHiwVeXhinr0hMhg1yNEnMQuVrjr9OV
	1NpLFuB9yrL/8Tzbon+Mie8ZeyGVqQbq1rSPNVzf5UMlz6bZIvvh/qn+L52BzGSadZ0q68HgDnq
	2en2s3K/hmzh5SOjToSSYmRijtG1N1z63TKvZ0G2DASq83Y2k5jMqTOvuf1UiP7iRR8mB/WYhpO
	2A=
X-Received: by 2002:a05:7300:d50c:b0:2c5:704f:714a with SMTP id 5a478bee46e88-2c930c77e37mr2841716eec.8.1775071757905;
        Wed, 01 Apr 2026 12:29:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:5f38:4c97:ec41:caa0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca7d00f5easm480206eec.29.2026.04.01.12.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 12:29:17 -0700 (PDT)
Date: Wed, 1 Apr 2026 12:29:13 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Input: usbtouchscreen - refactor endpoint lookup
Message-ID: <ac1yAkEOTWSEBfSX@google.com>
References: <20260401082212.2180434-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401082212.2180434-1-johan@kernel.org>

On Wed, Apr 01, 2026 at 10:22:12AM +0200, Johan Hovold wrote:
> Use the common USB helpers for looking up bulk and interrupt endpoints
> (and determining endpoint numbers) instead of open coding.
> 
> Note that the NEXIO data interface has two bulk endpoints (see commit
> 5197424cdccc ("Input: usbtouchscreen - add NEXIO (or iNexio) support")
> for the descriptors).
> 
> The lookup in probe handles both bulk-in and interrupt-in endpoints and
> was added to handle NEXIO devices. Replace the open coded lookup with a
> lookup for the common interrupt endpoint and an explicit fallback
> accepting a bulk endpoint.
> 
> This iterates over the (two) endpoints twice for NEXIO devices but makes
> it more clear what is going on.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Applied, thank you.

-- 
Dmitry
