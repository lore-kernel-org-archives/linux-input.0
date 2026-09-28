Received: from mail-dl2-f41.google.com (mail-dl2-f41.google.com [74.125.229.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A030CD95
	for <linux-input@vger.kernel.org>; Mon, 28 Sep 2026 04:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790570330; cv=none; b=FvMts4oYraIO41vYU3GRVzJIjpWiP2e3QY3S3tURC4ybbF1c+xw+ZZpXPc5z2rr8yupoH6tMu41PF/0qhwDUie/807N3dz1sRgunUoyBFEVmPX1edOMphtM8FJmTMhQjpr+YGHgHuXx8MkMvJsWyF5tAN281/utMtQD1QjSlexE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790570330; c=relaxed/simple;
	bh=oYMPXUg5FRpTGpq/VChufToWIT8D2XYBNz1jqWQZd14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWkg+roYcroZ3Jl1OsAJvMcRLHFenO6YquGMUP5Rn5InPSAtsOSfwpB3/7b9DJs94pkz5d9qzewddnMdCwuiDKv4mwdSn1w2R/FvAVvONwkzQCQbaEmX1Hkhij5Qu5LQ2JEWjRGu3PTrafxzAQ7LCoDdsPYCElQ2xjVCn+2+5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+S9GrTH; arc=none smtp.client-ip=74.125.229.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+S9GrTH"
Received: by mail-dl2-f41.google.com with SMTP id a92af1059eb24-1474c6b7742so932579c88.1
        for <linux-input@vger.kernel.org>; Sun, 27 Sep 2026 21:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790570328; x=1791175128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=S9YFNOM35bVSfIS9/7AW72GbBEe1YCeVTQopxAj3TL0=;
        b=Q+S9GrTHakmOPeFFNUbWxnb7iokwjTb6dKNPNxocRySVeYxMcySNBHP5pWjMFfqFeI
         T1U3iRA9w5c2Isj9IZeQ/ZMvmxMK0eYpmgbQW6Jpq/mvQkc45mDAnebvBTfG5xnwvLWt
         nFAia4LO2aYxcG/cwwftKzqy1RznYw7grjJ3GAwHISrkG+32oME39aG1suLcC+cnsP3e
         8pCLXvmcix9WlPRnA5Hwx1haoQrW0GqjFM6vNZb3uzy3HMAiq/xmHLbssbRKT1ndq9c6
         +qS50F2g8mvn0rXZIlJOeFImlPbKbq/FnZIrOKRs7kHf9qtGT1dLv6StiEsDCMVzxnmJ
         DVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790570328; x=1791175128;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S9YFNOM35bVSfIS9/7AW72GbBEe1YCeVTQopxAj3TL0=;
        b=DWTtXHJMn7QXsqWJID4aYLuZOF2pQfMZsxYl2z0p+XkiSKH9eQ1oevxCul5BEZ3QKC
         UYYL5RTnkTtvPDKjGpfxZsFFOGtES/CBumvNhJYKn+GaDG4tjG6apnwr9YVYi+xBc2i1
         nZ1Ktz9yaz4ZAKNCY575oF/vY8fO30ea2Booaevc4PVOVWLhUEceEBmndFdPnSzbh6tL
         i1WT6/oI+8nOiFMtpQzSiDyjdRA5E+o9aXE40EythOgznRnvRknlRVs3ctc2dqMCqyBM
         lIJOYPlwBjjcYMyB3MojEEuzR5TwyWfmwIAytvkF+pHQTrS8VOInf9taj86RHVSfA42z
         yb9A==
X-Forwarded-Encrypted: i=1; AKwUvBxxQT+BHOD7nrd+2pFyHnme4fRYPZQu0hFbUhdwrEEPecPreeuYDP59kkgdSELlbyDWWbEExdoOGkD77w==@vger.kernel.org
X-Gm-Message-State: AFuF++klQ2/RpTwDm2QivYaaYD2POIc8+VvlrV/HkU3qYL6FVt8iW2u0
	eCgnQWxiq8ehSF2dsUV1J5lGldjE12gkTityBTCDCX38ic1Vbq0qvl2m
X-Gm-Gg: AYBFou3c+d/Q2VRMur+cZ+CW4og2ERoZ7oMcMi0AwLwbo34w5EcfCu6IIHnzOVCU7Mv
	EM0YeqEdT7pD0yBodtSogKgtp1mlAag4c5u9BCoEJzvh32kcfKtr7cGqKlTc4OAxUgEkgvUbKn+
	oM9Az9IYW3eDDjxf6eRrjSjZcds40XrVahnyZhfPS0LOzdNxyddo57irUsU/yO7iekHaHmGj3dA
	fHEwzzAhDaQU0sxJw2PoOIjsH29vCNp0l73d+87DXC79eV9fs78m5GYm95VhChMJDOLswE3wh7Q
	WkqPL89OFQFIwpbZIbn+ITwCpR0GFkQlKP7XWtn4bAmpbzfLJePNBXEvEzxzchGO7w+F5gPAAa/
	2WjrmJKVd/8ycaVGfsGEB8QCldSYNr1TQljODJoJOd6BUtjYRqmK6+I7EbdUPZ5CjHcylpRymPl
	r71r0Gff+WBNhVrP78QrxFRBylyySvFhZou595JZKJ6sBl2+0GjrCao5DCUeWe07JZtLxyiC8kx
	lSTaEAqb7I+Fh9/mBkS6vYFYwXmNkfIqlRlCUDlUg==
X-Received: by 2002:a05:7022:b048:10b0:144:e658:94f with SMTP id a92af1059eb24-146d0f33db2mr8902859c88.43.1790570328080;
        Sun, 27 Sep 2026 21:38:48 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:526d:2f94:503b:aada])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm16358758c88.17.2026.09.27.21.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 21:38:47 -0700 (PDT)
Date: Sun, 27 Sep 2026 21:38:43 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: david@ixit.cz
Cc: Andi Shyti <andi@etezian.org>, Rob Herring <robh@kernel.org>, 
	Marco Mattiolo <marco.mattiolo@hotmail.it>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	phone-devel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: s6sy761 - fix resume ordering and restore
 sensing
Message-ID: <arnvS7Hk7uIKKLrZ@google.com>
References: <20260926-s6sy761-suspend-v2-1-8f00a96ee6e8@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-s6sy761-suspend-v2-1-8f00a96ee6e8@ixit.cz>

On Sat, Sep 26, 2026 at 10:26:47PM +0200, David Heidelberg via B4 Relay wrote:
> From: David Heidelberg <david@ixit.cz>
> 
> System suspend powers the controller off and resume powers it back on,
> but the resume path enables the interrupt before s6sy761_power_on()
> checks the boot. The firmware raises its boot-complete event on the
> interrupt line, the threaded handler consumes it, s6sy761_power_on()
> then reads an empty event and resume fails with -ENODEV, skipping the
> touch function setup:
> 
> s6sy761 2-0048: PM: dpm_run_callback(): s6sy761_resume [s6sy761] returns -19
> 
> Power the chip on first and only then unmask the interrupt. Once resume
> completes the boot handshake the chip comes back with sensing off, as
> at probe where input_open() turns it on, so the touchscreen stays dead
> after resume. Send SENSE_ON again when the input device is open.
> 
> Tested on a Pixel 3 XL over several s2idle cycles: resume succeeds and
> the touch function and sense status match the pre-suspend state.
> 
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Fixes: 0145a7141e59 ("Input: add support for the Samsung S6SY761 touchscreen")
> Signed-off-by: David Heidelberg <david@ixit.cz>

Applied, thank you.

-- 
Dmitry
