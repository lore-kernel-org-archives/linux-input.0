Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCCE33C194
	for <linux-input@vger.kernel.org>; Sat, 25 Jul 2026 01:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942566; cv=none; b=p70NWYmr5M8PTGVn1Tw7iDqGukhNs35g6GJ4XgQj+R4Dqlc7LQpNDRhFyN01NZtIeDlhwpxYF1nOyk+MF1mYqXLV4GdFGj8dmFUOo8q0SrM+AqozYrNsm9cwNYwtcufUcuatSRLNpsIEjQf5Di4rlqeCOSBZuecS4FTOQOINSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942566; c=relaxed/simple;
	bh=Z9QXS6xGrKf+qCy5+yj/0vWiDbZXZ5ugExXA6xy0B7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/+rO7M8EYduj7xkuA0a6pECoCDMY00AeRLc05zF5VABsSv1Ka7eoSp2NxeQ/JF+Mw367NqcZ+evbo72rFxmO73kiuj9dboKXenC0yyOkyYft3A7jd3H2YZMrqa13c56EGJnyKL4mc4ukMbd/htsE8i03ZaDi4p5wpydL6udGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ApfGXoKL; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ApfGXoKL"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cf41bab353so14689635ad.0
        for <linux-input@vger.kernel.org>; Fri, 24 Jul 2026 18:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784942564; x=1785547364; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=evBctyG9uOAPggGOtV7ej6S8jtXBTYTc0DEyRDvPdb8=;
        b=ApfGXoKLoxH36oQl9LPirR/bcjNUIAzXBsyE9CRN1c50OuGMqZvpzkPLLiIqf7n1na
         X6pH8/bmWeqXW3qJDtfbsfdyWN7GrRYXymp03cfHP9JqVnHomAEpqG9rsMtsFeKLxzSS
         rKf6pwr0YzJK7Ye53tWoU4ugASp4bYvnUBnwMFbovt2lzzOhQyfssfgOwioSMwzlvjYX
         hTSPzQsGpMAzZczc8CR3Ww3D+PHu9FIN4eDrB1wbAYlG/viHoUTn6d0MUG8riYAJk26u
         o6BjBd7bU2qs/1ZM38PyEgQl+wJIAfbThekFRRU7/5zwNCdxxC5z3oFTvSipdANnzUSU
         omkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784942564; x=1785547364;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=evBctyG9uOAPggGOtV7ej6S8jtXBTYTc0DEyRDvPdb8=;
        b=tX8l64IqRqaWmobL8bqutnmXQbdE8SZ/ltc1kEPHDMX9MCWH562Zy/heXxI6P83290
         tacyapcUBV3cRKKnClYHUbB3DOICEoGdXXQSK1l8mO47cxBMOliE8v+DpfOvX5Vx34M5
         lgMIina8cDXPqvOQmhOpQNLmPX/tfcUqBJv1r76PwlLelRTRqnvb4M+K6ei7V4HUjKb8
         Q3dFfD7tblQKplgGlDpjMxjAT0+R82UmGE9YDYHy6e3+jJA4WMPYa74rsAqda/X7iZb1
         qHJrEh/+byCkvS/OJvtyckmzLCvhsaFmhb1dDa8zeXa6tZFqO1wUDHBBMqdLHNOEIZFI
         nNhw==
X-Forwarded-Encrypted: i=1; AHgh+RrG5zV0ZjVy6wLlkafAIM9OsRDF7ZXvP4psUh6W/KW40rwhawRtGDCJewmsASIiRpwgxXlBSao9eH28+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4EaZXPkeBM18tm7qYE1nTNkt8/eD4cXyqFG1MXqjEPZxDto9H
	ndi/YweQ3UJshRdEPS2nPnfe74te5fKrUQdOmZSDylxI5MfmzVZAtQvi
X-Gm-Gg: AR+sD13ti1wmrC1rudKY3VxuQgDT6eCUAxfvshirdYrIBQunTewWKCm16pFD94phNws
	9W2Q1bwIxW5DAUzo7OA7yifhtWE1CyDC3UvqIMzHjOaW5vq4CQYpx4wTcU3v6XDJ4bhFVLv17+8
	MjkXp3KWxkbwdFxz8P0bAJuYPRcxDwpkRw5Agi/UDzyFeqqryL8Vbim4COUm2zlDyAVKzpRAo6o
	VxcDBhpMLS5brojLtS3OoP1MsvqebR81vGlvh7WDsy+oQ9cxL0qXzhzP490VHZVIcNoJYSMlotr
	voXI6CeWV9SAMPikRb/gX1knwojTTzPmNnWwZ/M01/eNy5M5wd+/5IMxpoD/17+tTx7p5Ov6QsA
	DfDL5Q1n2xpTLFwt0vWyvVsiC68s0sFmgcY8LZ5HYQwwP69ciakvPKm/2KTZK91MFcSfbzn45lN
	vetwQsg3xl27xl3SSjOxJZXw/jPxdQm3+4TpE2nF2SVxs=
X-Received: by 2002:a17:90b:254c:b0:387:e0db:3d8d with SMTP id 98e67ed59e1d1-38f298859c2mr719734a91.40.1784942564547;
        Fri, 24 Jul 2026 18:22:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:40e1:40e4:dabe:543e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5cb670sm5037501eec.31.2026.07.24.18.22.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:22:43 -0700 (PDT)
Date: Fri, 24 Jul 2026 18:22:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eduard Bostina <egbostina@gmail.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, daniel.baluta@nxp.com, simona.toaca@nxp.com, 
	goledhruva@gmail.com, m-chawdhry@ti.com
Subject: Re: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power
 button to DT schema
Message-ID: <amQPyzm6P4BUUGHk@google.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
 <20260718215632.3295049-3-egbostina@gmail.com>
 <amP4csGgdg51VRZw@google.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amP4csGgdg51VRZw@google.com>

On Fri, Jul 24, 2026 at 04:42:46PM -0700, Dmitry Torokhov wrote:
> On Sat, Jul 18, 2026 at 09:56:31PM +0000, Eduard Bostina wrote:
> > Convert the Texas Instruments TPS65217 and TPS65218 Power Button
> > bindings to DT schema.
> > 
> > Signed-off-by: Eduard Bostina <egbostina@gmail.com>
> 
> Applied, thank you.

I actually picked up v4 of the patch.

-- 
Dmitry
