Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2832DF13A
	for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777246843; cv=none; b=aStpd2QNCwWmZnKNXWSJleFuaoWgf7SzgSi5izeSNOt/Zdh1Xg+q/r806fzOvYnalsni1RBjxzcF/ZtW0gjVKow3rjZD5c5Z2p0excvWRKK/CJdPpVU5H7zhm64hNUrEMT3nrgp8xFT4T+uPdKoiiWpOsKzHA0pVb29y53TjhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777246843; c=relaxed/simple;
	bh=2JZbIC1j1ZT07IZeXZn2PsOsR4I8cDLN4cHjVdNpjzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEAo2IhHvWnYKON/DMiqfSjJrEU3yyde4HcQ6roivSsIKp98opC2z5KFO7EeNpjy0Ts2uK+ERdOr1Q44BCwCksErnUSy+GUY+6ovmuiwegwBYio8B+Dfw1m0Ar5Z5rhICLDOlsvP0Hsb7ybCqqNhKMUtXwmuBUPOOeLB3PA2n5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=og1bhdDa; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="og1bhdDa"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d891442388so17376325eec.0
        for <linux-input@vger.kernel.org>; Sun, 26 Apr 2026 16:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777246841; x=1777851641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVQAh1zH0R/yT84bvoM6C71cA7nJPq6N2ZR3XUe5gac=;
        b=og1bhdDaSIzYPPikiiqc1MhamfXTzr6yIojrurMuSTsyBBgxvw2Fbgy6BX3s/JizXW
         gRHpQYAF8wIOTr6G1eSe2oBpkKEpvwe2m9wRWrWv6yiN6fjl4hxXeaV8P4eLpKHYvbVQ
         gdrJJJMXrprSOSiXqa0U4VKoLNWm3HE0OQlKFHAlGuqgTtgrm9kQQ/SgQf/2T/9rqeoE
         OC/isuq8SGA938d10kksX3b+eFPIyC6FOdlCv6qiBROuwv1PSg/tVpNQ0xUY9VsBOM+H
         u/lG1kfXoFqCkMhWmhC9d/ZgdN0JkE6Up6iyily/Aa1eOsGjxNJvmePVfPBNGzlsaPHQ
         nMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777246841; x=1777851641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DVQAh1zH0R/yT84bvoM6C71cA7nJPq6N2ZR3XUe5gac=;
        b=TeM+oD1kytfVVyi4AdhbFuprzvD92ekS1nKC0+d1iU7pS4st/6LBBblFQL6CuUBUwo
         CkVRodesME1F3YkyfOBl79CmUVNSkgTkstg8gmdTKO6swetP4xrvcYmw+6ozq4bSKg7w
         rgMm4df6VeTIa58WwB4gXzUqyCa0Hs1jsh4f/gGX+jniGX4UZCGrsrYsTnIETwp0yDlY
         4Tvc8kh+4U3TW197DBn4/Pa0XBUBc5HIuqRJyNdEaKD1nmTvcp7nqAmDYMkCjA20AGn4
         mgClw6OADUMQu/ayStzx7TohGD1Wtwfn0hJ+gqFpGo9sQH91M5KOgo8nFqlWd1n5aDUd
         GViQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5+QCmRcfMiT2o8d2IhBfv4LSs8UybsviejCMiR3KugMz6a5eSo7ig6gqGHsf1KGTSWBs3a4HkQffD5w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdvR0p7Vnyt4V250ikWscYruDvNLgcrAziEGnZ3lf/jXHlg+l7
	EZkvqIU/8h/NMaRvQXXDFodbcN7dG1+oIorZdT5AVbJSxv+voNfcwVxt
X-Gm-Gg: AeBDiet7McNjFbQ+//nX3vA+vh2SC9qtos/fZ8v2jhhnPQLJF/t7nOhAjx1sNONNSyH
	hEqaN1DN9oa37xS0Fie4agA4MnH8Uiut7vq43OP6ilAhDy4k27z4IQgajq5gbVFQ4sJWUEbTobF
	zp3eLDVN4xcPhiB5RgflJIS5yzwsiHYME/mwF9LIMj0RPzI4E4o6ZgMu+Y+oHW0e1pqI7CZtWKN
	RiUK6Lit3dg+0++k+ItZehloT3Roqj2Riqf7CFRl+9EeEARlDdcsZYTHCEXllkmhfd0ftrZQvL6
	gVpzQTOJ6uUz+ChvLa6BoY4qD4Canpvf9Vyg+mZ3dhFq8QKDE4CniJyjZriV5ySb/6UbnhO7vTo
	i/3dpgUV4mSrUL3TOLuA9bGKLm7zpUBKfyFOlRG9s4RcMNAf0qf4zhEcit9xtpXgKIfCOg3vo3L
	3h0/UXmCwoZ2Ln2UkmltPxPe72nEZiExu/J/xoYu2e0yMqbrA33+DMlYKS8IgWk/N5g8q6/8Qrr
	Q==
X-Received: by 2002:a05:7300:fd18:b0:2c5:b972:b436 with SMTP id 5a478bee46e88-2e478c1ff84mr21648118eec.23.1777246841412;
        Sun, 26 Apr 2026 16:40:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:da2b:741f:93fe:403])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce0f5sm41133434eec.17.2026.04.26.16.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 16:40:40 -0700 (PDT)
Date: Sun, 26 Apr 2026 16:40:38 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Hendrik Noack <hendrik-noack@gmx.de>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ferass El Hafidi <funderscore@postmarketos.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] Input: Add support for Wacom W9000-series
 penabled touchscreens
Message-ID: <ae6iPsVrMhSFrqPm@google.com>
References: <20260426135232.371272-1-hendrik-noack@gmx.de>
 <20260426135232.371272-3-hendrik-noack@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426135232.371272-3-hendrik-noack@gmx.de>

Hi Hendrik,

On Sun, Apr 26, 2026 at 03:52:32PM +0200, Hendrik Noack wrote:
> Add driver for Wacom W9002 and two Wacom W9007A variants. These are
> penabled touchscreens supporting passive Wacom Pens and use I2C.
> 
> Co-developed-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
> Signed-off-by: Hendrik Noack <hendrik-noack@gmx.de>

Some of sashiko's comments sem valid, please address them:

https://sashiko.dev/#/patchset/20260426135232.371272-1-hendrik-noack@gmx.de

Thanks.

-- 
Dmitry
