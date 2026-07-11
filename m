Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E08E2765D7
	for <linux-input@vger.kernel.org>; Sat, 11 Jul 2026 04:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783745379; cv=none; b=AfOAkC2WKA5nq8XB/6R4YDNbhwK1eBPf22MIPXX3xgo2RiMPqlv7Ch8HmNDgXgRyuhiyixFgEDYsNUZb2aYtxaJGRP+qMynxws8xVuwoZpD29Xs89Hj3o9ulURzT6B220pqj3QfGlNWkgrnFiaOCAbzrEQ0RVkQ8SF7L30DRBrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783745379; c=relaxed/simple;
	bh=S7g5HdrobVHgSI3y7yFITx6ZdgODEA0xXX0TnH33v6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKo/vA+6WTstE+vnzUghLcHTXcTXYPCwwhPESQfaHLcPen3oPqXkgxENGG2qu+1Vmncv1lT3rOYUltgW7PEJBuH627upHnWElzaiC1hkE6xPhMPEeemXh3hytACfwoIFsIoLiCH2BPuBLV2KZb53nvnOG3DtHtv7KcIsompaZ6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrUunfIs; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrUunfIs"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8486ac3f347so1949896b3a.1
        for <linux-input@vger.kernel.org>; Fri, 10 Jul 2026 21:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783745377; x=1784350177; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qesMdHKmyxw3NJ4a67qnIHpz73OEBeBHn6uWkzO1uyM=;
        b=WrUunfIsErXFnQOhWCnUXZ7TKyOqI8TaNmxv25pZRtai9YvHHJ6dlC29g3qtOv+vRE
         xYGb5fhsMMmG+7vkZUZWHTJrvL8kinbikFiRoVPLvRke4dZUuCv6kQy49n5hwBvqeAqk
         xhvFXMk5+PlucjVTUu/1Pu+FLP1RNmVxnd7flmwuS/1jWdtuSE6HgVyff+UYnMkYZU+i
         WKs/DPjTZ9fvAifwp0iUhJX/P1HqglKBU2GvRdGjc3RYGJV1ljbf3KUJ6sjsWI8eM1aC
         hyGezqIdlIEcKo4FcZkkfuig2XwLgIQsIOl/Jt/fuqNsfwuLe67ocz3RFcljSVK89Ybx
         DyZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783745377; x=1784350177;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qesMdHKmyxw3NJ4a67qnIHpz73OEBeBHn6uWkzO1uyM=;
        b=adZIjajxd0b7zcJu9dEPvChgL9jpw8OruT9YH4Nh1mCj+rRSw3L3JopStJlg5Ny+oW
         ZWOVMOjYgKCmebos6KNhKnbW+NLN9LYEOQkzEPtuzogqo7aURen+v+f3Vls3Y8GCtUVH
         /4SRbbA5yDFCY6gcbJz6eH+1GCOz4lmJgshZ1Z/Mxh+bspRYHem++4ZrA2ngYLU3zPB1
         U5oA5aTgxruuHu1YhPmg902AnjD91XX9FrEUKQG9oGHF9OEAO7geUs2kNU1N+o4DJIb+
         P3laNpEDLfN/bgtC2c/NpUgikKDgVtqlVOPPaNG4+01H3rnutRrXOfBngffoCy4v0T9c
         WNeA==
X-Forwarded-Encrypted: i=1; AHgh+RpFtTp8krBHDKzi7ZngHQJvsfIYUcx7dnP28v0KrIUbIgX/sZmSL33b8jUiD9qN3q6lNyvjz3RhU2fg5Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz8t6FMXgdo+PJPf7nr52oFTsW4qbN63GBwb/UVFSgTcPxXznM
	C073atpmESIQgUsQANIAMYw/cIp1IReS+dDcMpgRviVQIe1afpuJyHOs
X-Gm-Gg: AfdE7ckXCvjx1EJtA6jYXYqUyw843NxrxhpbfYM6st/oy9NxKoj6OnOa4GGOSHqEgpw
	+pmKKK2ddxVDtRBAZSEMh58pY5oXjWlpXHdkMlGKIw00NwV7z0S1GBjunL1h1u2rzqPEMuL7jc6
	KxVu2S0TXTSk0xLNC7qVO32YP/9AAHx+vJVgBy/sNhI3bT6Pjrolo+P+nYXksFjf7TDXnCTelj4
	aIE0OCoD2l1QXqXJvOP59vNZXDbsk9CeeilsNg0ij49e2MrqDFQgFndny1DuJalYcbPGB/Z/j2q
	p73TIgti/shM87q3h8UHpuJMqEc+G27GmK1MaaxG23SRo7WrCqpOYERwsF5h8jaO2bzIcStLfYt
	gz1lxt3rtl9zKrvi7DNra0Q6Run+rqHeLwgXKJS5nGAv20Eql0bwli9OsUorPPUnFvGMyFQ6um1
	nPy1FdbXKQ93KXZj+uplHPL0Ir0hhsigVrKU7ao22cKgxHY2wPLFXfBg==
X-Received: by 2002:a05:6a20:734f:b0:3bf:6763:f0d0 with SMTP id adf61e73a8af0-3c0f085657fmr7458822637.4.1783745377459;
        Fri, 10 Jul 2026 21:49:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d42f:71b6:335c:aceb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311a6115e61sm25970082eec.22.2026.07.10.21.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 21:49:36 -0700 (PDT)
Date: Fri, 10 Jul 2026 21:49:31 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-gpio@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Gregory Clement <gregory.clement@bootlin.com>, 
	Frank Li <Frank.Li@nxp.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Hauke Mehrtens <hauke@hauke-m.de>, 
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Dominik Brodowski <linux@dominikbrodowski.net>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, patches@opensource.cirrus.com, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-sunxi@lists.linux.dev, linux-phy@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-sound@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v2 09/10] Input: matrix_keyboard - replace linux/gpio.h
 inclusion
Message-ID: <alHLK4O77khiKwtW@google.com>
References: <20260710211954.1373336-1-arnd@kernel.org>
 <20260710211954.1373336-10-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710211954.1373336-10-arnd@kernel.org>

On Fri, Jul 10, 2026 at 11:19:54PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> linux/gpio.h is going away, so remove that since the driver already
> includes linux/gpio/consumer.h.
> 
> Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Adjusted the subject (s/replace/remove) and applied, thank you.

Thanks.

-- 
Dmitry
