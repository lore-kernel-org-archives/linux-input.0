Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BAC3D9DA0
	for <linux-input@vger.kernel.org>; Wed,  3 Jun 2026 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780517706; cv=none; b=QxowGOoshd/N0w8+FwnW/iIPIgETd7CVyqPqTORPNyjfN+9c3zgiyIiRMguVyGANTd30K2JpeEbdc/fj/wrf5HE89do0/zagWIRLYvm8hyJYGjZMWSMshPwdq+a9o7NsYtzIYTnpFsE+2HJbB2Fywf5hffC9rhiUe6Au2SuaxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780517706; c=relaxed/simple;
	bh=sO1nneZ4T7xV8Woi5b1grLQBOHrxGNQXxrPZI2WzrAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il16MAIwJK+KXdqjvY75GJgiwZJFY7rBlMboy1eJg4mxRYjPHTninJQtQQ1kTRPDbsKGhsDkFNbkvB6GY2LR5xNEtSl54eBiHvfKcI2UImsi2mrU6lAGih+Vz8iDI0XtLdWUQs9PKjY4AMJ34Hixq8ZUfZR7lnv7XiFWxddQ5bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3pKSVOp; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3pKSVOp"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-48673dc56a8so34483b6e.3
        for <linux-input@vger.kernel.org>; Wed, 03 Jun 2026 13:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780517704; x=1781122504; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=K/dIMvjAW3Fjg5zbaaxJs4cecWXi6epOwVSNNUQhQXU=;
        b=L3pKSVOpLbVz+Uv2/tzNaI3QA7gUJOb1GmmM+MIXe2xc5Ujn618So0zwNh0QGbIAIF
         Qwu3slk9yfk4W+5u/eTzohKdcfA4B7+BpeAqwKQFysjg5yDEcWHKZdy11Zd+XY+Fm6X5
         Xl5C6MbgsHMoK6uzfKogm50e2zIzZtZgE2vC5gZw7b/nti00P5NDbem0/qKabdhrwmIG
         /gRJ6+pcf5Jb65GdSWw0rvD7RHRjS66rMUg6JEvzF5i2lc7VTS+Teelnqlgdi92vIvAo
         fCv1Q8ZeEI1ZdqkdA81ElzU1WgCN6k7wjmFjzGazSFbkjLfhflRNJCS7BMYEnUHIrVjz
         rj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780517704; x=1781122504;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K/dIMvjAW3Fjg5zbaaxJs4cecWXi6epOwVSNNUQhQXU=;
        b=sIY3JSlevKtavpPgfip9mCGwmYqbeXB1lUcxMn8ttqArR+YCgH4wAnWdvPjiarPJJX
         YvhwiJ86yRnfrvofACNnyIbywJbQ9mzbk/9TIXXhBSoOb/1183Wh7btgoLtsuGu9G8Xq
         KaJwz1scSp30Vh5CZ7iLOJGH0iSbQR1uNBbb1Umf+P66VBirC0GTTsqPJeuA7Zj4izpi
         ePm7UtAdQgDTrzzj1yvZUdW/8prYnwWCDKew7Uoyawt0XIR+f1PFgOSUwdei3/FfwlHF
         EwyDpdwLkHemeq8LlEfqKgcKpp7jUlsBUECmRCgKN7G1g57hidRkiCBTqh3/yUfOGxM+
         23Fw==
X-Forwarded-Encrypted: i=1; AFNElJ/oBj8Aph15LqPeBUZ1C8Oc8qpOfqsRzI6mK1Yd4e1jBWEsRdszUwYOJdHXa7lRlsCV7o60q7Lzq0XWRA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+CnYamfvW420ihgQPsKW2UKiEWYOL4330sEgxdYponGVUZixh
	c1jsZFoIJXdqw/LYE6NcyrLSdYJmJmNeNO75zdDi7IoraJKVKehB8NMv
X-Gm-Gg: Acq92OF/EpJeJkUqXUbdCkMqxCBan/VKGnSgq04AY6cfTiUgIztHDtAGe+VoB3VZ/d+
	7E+GuJMvL/R9Xlvpr7Mq72DAfMTq/LYATgNt5JtI9a2omQiPcNsq5Y2Z581c+2RAKYl4q1hpAVj
	HbyLyaVlM3p3hlYQQvXDsHcDlyG2sAT7cRVdakeqeCAM7IInEqjFA+5WbPW2E57DneNA3vNDW01
	N5FSu19qwMsWOVQZX3jZJ+9Xp9slCpERC4VFUv8TftT6iv6oRDbSF+JzJPQ8Cc/hv0qC5ZFrWtz
	5TeNYmtC80P222krHr12xfigQuKrcLggpzvqmiqxtR86K9oXFQIkqb9Q61uI9heBDWdICl72PYE
	xIvAihrUPDAdC4Da2v4QiahdC+w9eEFPYJcShukI6xogIb1gGmCA4E9pUDAurc0Ed8UAM58j1XZ
	J29VowPRWvzvAwIEwplMzEc0QmnOx8Oo8qeXSeTsI=
X-Received: by 2002:a05:6808:d48:b0:479:fc87:27ee with SMTP id 5614622812f47-4865aa4f1b8mr2895892b6e.1.1780517704461;
        Wed, 03 Jun 2026 13:15:04 -0700 (PDT)
Received: from gmail.com ([108.243.219.47])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-440d8500f0esm3003888fac.18.2026.06.03.13.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 13:15:03 -0700 (PDT)
Date: Wed, 3 Jun 2026 15:15:00 -0500
From: Akash Sukhavasi <akash.sukhavasi@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: input: remove obsolete matrix-keymap.txt
Message-ID: <aiCKBXqvOmQ8gC_t@gmail.com>
References: <20260529052246.4934-5-akash.sukhavasi@gmail.com>
 <20260530052311.271791F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260530052311.271791F00893@smtp.kernel.org>

On Sat, May 30, 2026 at 05:23:10AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The commit message inaccurately claims that 'Eight files still reference matrix-keymap.txt', when only 6 files actually do.
 
> This commit removes the obsolete matrix-keymap.txt stub and updates all
> remaining references across the input and mfd binding documentation to
> point directly to the matrix-keymap.yaml schema.
> 
> > Eight files still reference matrix-keymap.txt, forcing readers
> > through an extra hop to reach the .yaml. The stub has not been
> > touched since June 2020. Update all references across input and mfd
> > binding documentation to point directly to matrix-keymap.yaml and
> > remove the stub.
> 
> [Severity: Low]
> This isn't a bug, but the commit message states that eight files still
> reference the text file. Looking at the patch, there are eight total
> references updated, but they are spread across only six files since
> tc3589x.txt contains three of those references.

Yup, my bad. I counted eight and wrote that, should've said eight
references across six files. Sending v2.

> Sashiko AI review · https://sashiko.dev/#/patchset/20260529052246.4934-1-akash.sukhavasi@gmail.com?part=4

-- 
Thanks,
Akash
