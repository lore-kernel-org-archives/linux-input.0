Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526462DC350
	for <linux-input@vger.kernel.org>; Thu, 13 Aug 2026 00:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582044; cv=none; b=bJSfYzwRBkQVO9mbbLhKwjBiDeNYUhie47GIOB2pbWJC61Y1TYUkX7Slp75bCz7x3o4cmcyESz1M6H7tCuvW+QvFnf3f6/kRQ6s/6fqOtO9lUJO10uANhM05eUesHr/B6Ns/DuaA348VYDzqXKrkDb67eG08mqsiYvrVlFM5cGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582044; c=relaxed/simple;
	bh=nr0JbzfBqGevMUFWP5WeE8p+Mj3rdk2zYt8M2x9Q7UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KbTlpjUuer7RWtzEBLpT+86UoVz8W5Ut4yNesPeLyKzBNB8EuVD4vjlfArRfil69CRBCUTMxijo/pso+HJv/visVtcy1WeQI/k5pB7IHzHfx7FyZeko1yHq7ujjGAlJyJ1c+d53TtaR44wiGoHfc3NVNuonNgvag587/pYq7lFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGV/t7bJ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGV/t7bJ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacb8416a1so19578605ad.1
        for <linux-input@vger.kernel.org>; Wed, 12 Aug 2026 17:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786582042; x=1787186842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9BsxTIcePTgkc+qhqyMPuO3rIwVn2+yc4KgD+VvA3wo=;
        b=tGV/t7bJ1m6xuT9Av+sWqexA+KMjlot80kyUJJqzedbilJiVR5C/sd2H0JCSYaEqUR
         O9LiJZXyT8wY+mDfw+l3Edwf1v7vdqqNXjsiBP2s0KhsnnO8giSDr3VXeY5hpTF21w6N
         6wgQbWxsDIBxEmswikLmylSjE2QTEtPYwOeUH0DuZ2fRVbxmHUW+UL1lm41PTRrhhI5+
         /SwOSZnzhvAEQG1LurT0hOOxFgUGqtree34gF70nf0ulpnMqml4PDLgTDipVKbFjz0PX
         XEY+2gLsMPLkaOC9tTVGDoAX8xrbvMCCGkC9PXu1pnfl+UAhM3wNW6KIM3bKraoM/gOa
         ZAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786582042; x=1787186842;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9BsxTIcePTgkc+qhqyMPuO3rIwVn2+yc4KgD+VvA3wo=;
        b=j+xhdT2njyFWAWJsJs+B9Yr9qljn13vebRNcSajthLtpBTVRXRkuqSnH+xaTzKLk7W
         G2UNdbxjQJkT+zpdSoblnh6Prfq4Ws1OJyLFUBQM8Yc+7TQ+XKcYJxDtg0pnKoiS74sJ
         5D+tbykkIlQmd1G9sdDVhR/2/9BwvVSfnTde+dMmB8FcK1pf//iAT1pg1VSxkh0D4vTJ
         EnO8jNXF/UezkcNuFLXOeG5eV5sBI6dr9G50wdW/qRfwEiYPFV/jRsMVZf4fbZo0+qI7
         i6gjHO/ZpLUQaOfzuctDyVRxZAL5Io/ytZMihFqgdaxa0CO90Pne59smgWFU1jOQ5o3q
         q9IQ==
X-Forwarded-Encrypted: i=1; AHgh+RqnI+JAV9PIIE+09I42eZHU+H145Dme+mDwoy94f+UCh2yd3Ts4K/i3CM4uKTAlm07t+mUN3GkGfTSCkw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzPgCAlzHta0cp9932YZ62O/6v8ILVT2AjWNlCtTr6l1LkGc0dC
	L/6sUBuuHItzLiDzx1AIXLFCmtkWkMfoRncRz5KRgrEf/kd3NN8NIxHm7BYS2w==
X-Gm-Gg: AR+sD11B1Wr/5t3pSYo1e0B9SuGMmdk0n9KG3IMQSDDjMHsCT/cHq3jPcQ1+4pMbIH+
	y5VH0MzN16LPAwAoA+z2t77FBn70Dddc9ljbq+KhmpgoZzu3izUtKesRxE3LD3xUUYcjckS37vN
	4dzv+8MKAHG/r0IOiDXPxQMEVrSlMvKcfUYPbwvOnfaM6DBX4bcylC/oFGbPsT5I4Bb6baMllcU
	HZqFyzFDisGQGOqyMoLpWsGOoRyJMTWIyhUFOqa/67r64R19KkAiwx9bHVnLlNy4IufaMkBgWJK
	e5slvztU+YdNxAAR9vJrvH+RzZZt2r/2dBUdbdk72EmxICCPq/jNTyaGjZDgDxHIbPuDzIpJj7U
	tPSecACQ8rNi6kRzmo5iwwjBOgXWzYw9I+Xb93QUbw38BiytmLDW69hhf/jMYEwnLgaE8WZcuPM
	Ox5UOePmAjYfwLeNQEeruovNPmLxK1yx4dIGXjSvewQ/2d8XEdASsK2J36MDMRisGXTBo04roMS
	s9FB4nmuSryKoePLAIxcvRlLJiy6Q==
X-Received: by 2002:a17:90b:4b92:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-3931e079c22mr1944443a91.6.1786582042327;
        Wed, 12 Aug 2026 17:47:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:8656:b5a6:1038:61b9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebf732166sm1762331eec.18.2026.08.12.17.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:47:21 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:47:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Mark Brown <broonie@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Benson Leung <bleung@chromium.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, linux-input@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 2/9] Input: elan_i2c - sort include statements
Message-ID: <an0UEY6gigYTWFLW@google.com>
References: <20260811122011.3539250-1-wenst@chromium.org>
 <20260811122011.3539250-3-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811122011.3539250-3-wenst@chromium.org>

On Tue, Aug 11, 2026 at 08:20:02PM +0800, Chen-Yu Tsai wrote:
> Sort the include statements before adding new ones in the next change.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Applied, thank you.

-- 
Dmitry
