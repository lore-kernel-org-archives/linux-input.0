Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF91547C0
	for <linux-input@vger.kernel.org>; Tue, 23 Jun 2026 05:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192716; cv=none; b=HTl871SA82ekJ0IC08cHYSFNE6aw1UTv/s97ZhvyPwTDjGPmgQrA6mdxkeL35EydO4BWIx5FKOeEMEayB9GDJZWNOn9iGGocy6hpC8M1wRZv4XWkq/GH7BuGq3ByyO4EKQ+zmWxTAYUCTB+W2rowKFjAjHAEQzLMDm8HneABP8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192716; c=relaxed/simple;
	bh=G7gSFJmNGNC/nlv8QHYHAAJ+I84JI0QUN9HfeUOXXmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b15lKD530Y48SzgzuUQ0wcHVd0upP6qVKLOiZhq12cp0/UGOT7JBt28wsoAHzSX5Aoswsg+etopFhT+C9ENlUoCyEl/CjCPeVj+AxVonCz2LAkaJdRdr3+/ipTS7uWRESKXunYlKotgmuPEqyZprpAHbaI9OIOrneOWExU4gIMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKpVDrsr; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKpVDrsr"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-139b914bab6so2207335c88.1
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2026 22:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782192715; x=1782797515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hhjI0s8nXHkgGSUH3JS/n/cfolCeudCVnQ8IdgzgVU=;
        b=nKpVDrsrrs+jQh2iBI1E0ssAmTlWtOB+YyYYs780bdV3xqW2hZxOdtso6fZAG0vEIm
         GtoeOCDYLJ8VHwNoUY5NnYjunzwS8GyV8Pf9TD3geZMB1sMHU4d2AhDE9UwfgeHvZ/b0
         am86rYA48oPfCR7nKJMCLVfEyKkj4j4JmWSr5ZrOeHn+dOYTqQ6FvLWfZVHbBB7WiITP
         sHKPGmqcQIqrf31E+0Q4o/B3BfOLeoUmVrudOYSUUjqBSiIpDvBv0mUC42tE6afQ8OBF
         SvYaeQtJLzLXiar58rEeuKqQgRFTf2rEwxKXU0KARDLpzUkwoR2Vz2wUcU5d/Flly7co
         0AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192715; x=1782797515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hhjI0s8nXHkgGSUH3JS/n/cfolCeudCVnQ8IdgzgVU=;
        b=iXhBAh4Drx7uSsLcZY3FLR8TxinOhHDVuOhdCRcLHTUt36irCCkO30W9Olz4OpcrR6
         oAoP3gR2FgHamUv0YQC7AM5+aHsoxYg/HprxWFsfbdazE/qkifnOTHJFzPQGQJGrCdbN
         UcigbV3V3WKmieR2HQ+/IchNOgnEUCC2qYzUVAd/2OQqso972sPNP7U0hyCYUhLWW274
         euKOBjgGTxc9PQ8maNGO9fcPm8dy1aajYaO0PDecH+HFgSu4WJFn+uik0vJomvWNnmaG
         9Ze/wyBn1Pg7BJr/Ql+DMOhWikT5CIgPDXxyZKjT/coVIPUcHAtxTAgSlFLw8fBIwmat
         CJOw==
X-Forwarded-Encrypted: i=1; AFNElJ9GJFoOoXR2TiQpnsMLBr9ApiE/xqYabzTw2Iv2FfD/zYlKxjDa81Y8OCvHLb7uZwD6zZ3rFP/oymdLIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXeShtaPs6WVQY90MXz5WOBbixbxahcSPCG7CnRpeZ87E3vvE
	7m7+ZM0TRr0tF7CjknRKw50hnY10cDwRyMUBykal6c3aw8FWvYaKr5Xupv6pxA==
X-Gm-Gg: AfdE7ckquDhThNCThCN6WLP0NCrKWwk+2rOKjNF8DZ41EU+8SFKWdAgHbqNnAAf8lVv
	wgeimMihmgcdonP3NCmccaNMAPVpzWNdshznLWuZYZAGeHvjdm9sexnh5NZ6ZBeNnoIRZBiD3zN
	Q+JHpna0Qn762RPESaAI5XWnOoHgjRHuR7lIVYVHDOmRQd4mI5GKbvkIh/d8GmM/jDwqLLXYaEY
	wOUoq+wX3Mv+xq3irR83h3z1pIEjCreBhYKcDpVSi5Vvx+fEBRzTLGQMK6RNKKQ8JcCYdgswSI5
	YCtSAMe7kERRuE3imuZPYaKayZiRELob3j+iGyOlMXESDeptdJPuabLpUYGxsQq+7lOYKqd40BY
	CT7+8h3MJYN9jeMPZmG+5IgwPGweUKFwHhc1c4YzdEPhoZiK73K7qWyl84uoRfeXdcFKcMeYmpw
	pD20ifRmRl2QkoW8653Koqc5+QA3IWpHi5/ITC1p4PLuLrm7YpkMBvTQ==
X-Received: by 2002:a05:7022:921:b0:132:f16:a574 with SMTP id a92af1059eb24-139c6ebfda0mr674667c88.7.1782192714580;
        Mon, 22 Jun 2026 22:31:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7d8d:3bdf:d563:1911])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139adcb7a94sm10869884c88.4.2026.06.22.22.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 22:31:53 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:31:51 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Ranjan Kumar <kumarranja@chromium.org>
Cc: bleung@chromium.org, bentiss@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Input: elan_i2c - prevent division by zero and
 arithmetic underflow
Message-ID: <ajoaQ6D5qDKI8YlL@google.com>
References: <aiefjOflOlbUiWDa@google.com>
 <20260612060339.3829666-1-kumarranja@chromium.org>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612060339.3829666-1-kumarranja@chromium.org>

On Fri, Jun 12, 2026 at 06:03:39AM +0000, Ranjan Kumar wrote:
> The Elan I2C touchpad driver queries the device for its physical
> dimensions and trace counts to calculate the device resolution and width.
> However, if the device firmware or device tree provides invalid zero
> values for x_traces or y_traces, it results in a fatal division-by-zero
> exception leading to a kernel panic during device probe.
> 
> Add checks to ensure these parameters are non-zero before performing
> the division. If invalid trace values are detected, fall back to a safe
> default of 1.
> 
> Additionally, prevent an arithmetic underflow in the touch reporting
> logic. Previously, if the calculated or fallback width was smaller than
> ETP_FWIDTH_REDUCE (90), the subtraction would underflow, resulting in a
> massive unsigned integer being reported to userspace. Clamp the adjusted
> width to a minimum of 0 to safely handle small physical dimensions and
> fallback scenarios.
> 
> Completing the probe with safe fallback values ensures the sysfs nodes
> are created, keeping the firmware update path intact so a recovery
> firmware can be flashed to the device.
> 
> Fixes: 6696777c6506 ("Input: add driver for Elan I2C/SMbus touchpad")
> Fixes: e3a9a1290688 ("Input: elan_i2c - do not query the info if they are provided")
> Signed-off-by: Ranjan Kumar <kumarranja@chromium.org>

Applied, thank you.

-- 
Dmitry
