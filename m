Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC27D3E7151
	for <linux-input@vger.kernel.org>; Thu,  7 May 2026 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173637; cv=none; b=nCR9w4TFe4+IXwxkl2mhMmHqLosoIMY9PbgMQc4rS3KONB3/Ytj2Lsjmwi3rblRHSnnPsTqYxzv02ADimAUxAARIIonClQZxPWRK2wgU8p0LXqOAWFo5XK3iUNWWMfIaFRxdfPRCjAHTZ1SfF9Gt+4NaR0XXx9r+IKRNETLI+cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173637; c=relaxed/simple;
	bh=3ehpRE0ohgy8jZwQ70D8MHQv+KEBvTuuJUJPrYQ29P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwQtw1L/v2E4Xd1de9P8hhPxc5tITN4cZJrmlKefbfLYSb+dSl2y34nPtJpGVn4Z+QT7yEB3jdTscKGARYK+APuC8yl5OiaBaY1bXB1e5fTwNcVf0fyUiIWrlguGDargrf22QSMwxZhSnxUwE1dcTw/a+7fTtd3ecbD4Gng32qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1xW/bH+; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1xW/bH+"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c45281a06so1963848c88.1
        for <linux-input@vger.kernel.org>; Thu, 07 May 2026 10:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778173635; x=1778778435; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rufpr9EOUZeXhStW3dVpXKOHmyTFPQwuYeGt/ZjlNtg=;
        b=P1xW/bH+8Pl94gDsWop3WpA/NgsOw3LclRQd4migFlVYy7a+ExIzD5/YDyPaMcgu8H
         NWCcfM9zput5B5s3nj7U0eIS8cSqQtxe7PE4JCSkG2hFfOxz3otjSd1hLkGJ0Kuym80R
         rUexpwcnTAjm73PnL3T7e6pIjv1d/lKvWToBPx6OaXNggfnsYGeSqg0iGnGwBBSMsxd0
         eL4ZpaprkNu1hzwAIG5Z9tb7plSj9JuYtUT7AUPpR1YcBQetp8bzxnz5pSXQQyV1Yy6m
         oLdOjwBBSlEyik1baAoBkPN09Cz81CBj/2JbLrDS5OB0IrUvn9EDBGFS5/u+pRJZNa8j
         J14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778173635; x=1778778435;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rufpr9EOUZeXhStW3dVpXKOHmyTFPQwuYeGt/ZjlNtg=;
        b=LYRcNTVpNAaFoLtzFSY0fxRW11YJz66DRDZbvhbuwqcY8LkIgiD3PX6kkErnQ9gagU
         +rDCoHp3TZ63T1C5WEaV7noUPBZRaRdKzcktpHRyPLM2SryOvfde/+lXHlWHGTK3QHTe
         6GW7gWW2w8ZMt3asiWqfjTHPEY58ZveCOVgRflIQg1sfL/Arn70gYBDn2g6neqOZpEbJ
         9pLhUAzfPRbnYL9E1o9+FWcpqEK/A62G1pDyWTDStOhYmqcaJZeM6K5lFLxRLMM7X99V
         xenB0qCbWibCPR1yYRNkCG0nUJ8QT+xX6SerMgnVGw0tJML6/kEGRmLIGQrtfgsojWA0
         Qg8w==
X-Forwarded-Encrypted: i=1; AFNElJ+fz2mLNw45Lo5MWqmCnknoxhNiOuYByuczD2qM1pDBn9cqAXQuvhbwgXZVKBDRAy8zJ4MwNJYEERdQyg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGzWwyjx0b/L4D5Sch/1/23YsDilr1d8hYgjSDlkZTtXWfzjuX
	fHgpHs5ktoQ0fCl/xAvPjP6NG0krREc+8jbPPoQMESKJWTYWLHirLFh9
X-Gm-Gg: AeBDieuygpVr+O25QQ0rb06lhfXmlbaUGR7MLERgVN1Ol4KqB1xbbfNuBOIplJUtyie
	78du0dUPIlmGr+7bw175rfe6R99rETh1EXgssifVS/8IgOCdAg55/Stkk02H3ac7ah35I0k5JTU
	qIrlRAH5LrMXDp9oby7sSAYdU3030iVms5Fnai4pv19v8pwM+McHFfdONEDoeIx9BXn5GDc1Mko
	WUElEvV1ltp5wsSqRiQJ5dsCKgKIvTINaHKcSWqEi2p2pd9KVIBFgk0fBmiSvixC6ofFdZ57Nf6
	oX8JGUWHjQCz8l8tgFr/3VxMTMi6drGxbZjKilmYXgbZyWFTUyQQUTC5V+FfFzykL8DLS6StoUj
	yGozC1u0W2qLLJqCi2f0/EEtRZZnOJn/1rHobsZ/mVP2gtTAI8XlNBAvFiahzlf8/l0KkD08czi
	GMbzKVgFR2FE/BQ7cqBI+D++yKrBhvFsO/sEF+3KXGQEQOOHAQpOZ+tiDNPYYpdhIvSWvPwWexq
	GU=
X-Received: by 2002:a05:7022:6714:b0:130:ab68:2b7c with SMTP id a92af1059eb24-1317d893c68mr4721518c88.2.1778173634842;
        Thu, 07 May 2026 10:07:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:6a50:9473:7750:56ef])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f56f88f566sm8093446eec.16.2026.05.07.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 10:07:14 -0700 (PDT)
Date: Thu, 7 May 2026 10:07:11 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Kees Cook <kees@kernel.org>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
Subject: Re: [PATCH] Input: gameport: fm801-gp - Simplify initialisation of
 pci_device_id array
Message-ID: <afzGnMCFkXfS7mbm@google.com>
References: <20260507160051.3315630-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507160051.3315630-2-u.kleine-koenig@baylibre.com>

On Thu, May 07, 2026 at 06:00:51PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Instead of assigning the pci_device_id members using a list (which is
> hard to read as you need to look at the order of the members in that
> struct in parallel) use the PCI_VDEVICE() convenience macro to compact
> the initialisation while improving readability.
> 
> Also drop trailing zeros that the compiler will care about then.
> 
> The change doesn't introduce binary changes to the compiled driver,
> verified on both ARCH=x86 and ARCH=arm64.
> 
> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>

Applied, thank you.

-- 
Dmitry
