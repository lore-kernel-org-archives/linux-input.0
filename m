Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B772F7EF3
	for <linux-input@vger.kernel.org>; Mon, 21 Sep 2026 02:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789958330; cv=none; b=KxesI1ygKfvWVlAUrJ2LfTbs9ES6LQwie1RZGOAWilaBV1aWFnqwZLQl/fr+JeuKCPFl/sXj9lC6XhtDhvSvW+poXEk77XaeS0wbVwfkYNuwa+gPl+EtUauOUD14ioiVZZHo2vQl2eukcxGcMuIyZ3p/SNX0CKigjbT7j5GacE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789958330; c=relaxed/simple;
	bh=roqCL/hZ7Ph4PBse9KxMlNOZ2C57CeVfUJf+MSM/X5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIjfo471kEP1tag6WWY+JkIlrB0UN8bFKRrVRtmenMYw0bTtbFTRrw9+Zp9LgJOJa4HKPmzGTHTgdYYMSrs8aV9CUHVxgq53xUGbNAgKA5M4Ay4Xa5N2pf1obGJcL+5BHtrQnLA+boJ6/9ANkVIOTmaHD1B9EhL5v5qjPYZiGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CM8VYNeu; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CM8VYNeu"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b910bdf2eso1639408a91.2
        for <linux-input@vger.kernel.org>; Sun, 20 Sep 2026 19:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789958328; x=1790563128; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ORBs3m+ws4OHfu45BhvkuHCmS+gMggmNeMZoCuvyzTw=;
        b=CM8VYNeuW0VOL6B8yt/DRO+ysw3pyTQ3yl/tUnQvN+Im8R7kSAuDn43fTL6sDUqlKY
         rhdEDGSKL2FiGxZCwLRP8R0DBGaPVVll43KpNDgruBNu+2RtBEhq5oLXDHIY53ZdxppW
         PnEKkW2uh6WeyifZWbD1OAqUAVGxShKGrORQQmt9GkKUnK7x2PbluE4w9BDk+Cr3JfGE
         NApn0WCFGXTzgeE5Rl5r1tPUjgiNcgbl0ztnZWIxhvKzdprZr+Xhj9W+kaWZx/uKxziD
         9W117Ij7n7vOqgpHQ4fa+9SSLwdXdKwULSuGqh9DXYlCtwa7ZplLTF2a2Zvx2Pig4UQ0
         S/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789958328; x=1790563128;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ORBs3m+ws4OHfu45BhvkuHCmS+gMggmNeMZoCuvyzTw=;
        b=0GwyMKFpIiaQHTkC0cIg43TKpaZYeZcDGrfjnQOXNQnqJSPXCvPvivc/G//uaiIK9K
         ba0PCUh6hlpRCNACecNn7ANzqgaTthEAV5FxKu2UCSdw3/Gxcc8vTbUqm5un5EnFWlgP
         85l5r4oK9b6JCBgxfxFIMKTuwLcBv3JxkMApk5TEYn88bANlLPGgLZOE/BhREcD2oGhE
         WM3vAfqzgsi6YYXhs8vyV1Vv8GX596Iz3M9SPPtLXdZY/r7B8Nr7RkAyHuH01w7XklB9
         StvofZs4Q/M5B1t2AqsUtaY5xg26qAT5gWhugTSoHFFZpfqQgWlyU/UmFyc4wCYCgeRq
         PKCQ==
X-Forwarded-Encrypted: i=1; AKwUvBzrVNFnkIUyRQIOemNk6caIJeubEEaBIb6kpsJIuWj4Mma6B/8WjQEgeb0Uv+TJVPCqc7IUk/UcGIZuAA==@vger.kernel.org
X-Gm-Message-State: AFuF++kIwQMmGZ1tlEwu3whtgAqR7ZRk9SOZoF0Ta2D+zHu5lWiZuLD5
	xz42g1fQMfGGZeqrChfmr+5b1bCvjYm4OLcy2Qe6PYRnC+0Xan9k2x0o
X-Gm-Gg: AYBFou3hy8qJNVX5tRAXuQ6r1f9Ukoxov2YLVqiLwTO4yYll242OVP0+WoAprEz9tRg
	9LrZoxFZVAX91gBa3F2CsnlnztQyDfiHnkNlvOIbJYBJ/h0M3HrPgExgD1t4+amQuvpiQI8KJoX
	CBr8A+gEWeP4g8b1YEOLlZfyp3mB4PTYGLdQUP7IQ2C8bYSl2mq8Iq2X543kRDtkydFqukRhFpq
	Wj/wn+adnY08trgN5rxTi+JCoct1ggBVFpmmWznJJCcIla1dIU5rgHXBaph6idnQO0l+iZSMhIr
	d3ameumeGUPLGN86auu8EHBTCU8905kKBO1D0CNqvC8+DrLdvcQWQdhxBKk/tZ/pQZ9Vh2AZnu1
	3jCHN//nfWWt5B474pFWT0e8ZBsQYYHaHUli+YCdT4BDUwr5L4kwn/+5+tKsmlPxg9qQ4zVC7/S
	xnNnlJpud539zwifoI7Xan+9ieulKgHZCYuYhUU6scWg/eq7WhOBvU2zoW8QGy8MWPbp5GJUJvw
	CX9UzBuLK0n7q10smf7mG2i3sm412yXre9JDnwS
X-Received: by 2002:a17:90b:5281:b0:3a0:3673:dbbf with SMTP id 98e67ed59e1d1-3a03673dd7bmr3956785a91.59.1789958327913;
        Sun, 20 Sep 2026 19:38:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:3844:3355:5928:66ce])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c3318744dsm14208387eec.20.2026.09.20.19.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 19:38:47 -0700 (PDT)
Date: Sun, 20 Sep 2026 19:38:44 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-parisc@vger.kernel.org
Subject: Re: [PATCH 1/7] Input: gscps2 - clean up driver code style and
 structure
Message-ID: <arCYnPusyDZxrdCp@google.com>
References: <20260830-gscps2-v1-0-c733d4cae7f9@gmail.com>
 <20260830-gscps2-v1-1-c733d4cae7f9@gmail.com>
 <4cc9fe4b-c3c3-46ff-a32f-d2a86c0ce077@gmx.de>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cc9fe4b-c3c3-46ff-a32f-d2a86c0ce077@gmx.de>

On Tue, Sep 15, 2026 at 11:51:28AM +0200, Helge Deller wrote:
> Hi Dmitry,
> 
> On 8/30/26 22:52, Dmitry Torokhov wrote:
> > Clean up code style issues and function ordering in the gscps2 driver:
> > - Reorder functions to place gscps2_interrupt() before its callers,
> >    allowing removal of its forward declaration.
> > - Change gscps2_enable() to accept a boolean parameter and remove the
> >    ENABLE and DISABLE macro definitions.
> > - Convert printk() calls to dev_dbg() and dev_warn().
> > - Fix operator spacing and multi-variable assignment.
> > - Add spinlock comment and use cpu_relax() in spin-wait loop.
> > 
> > Assisted-by: LLM
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >   drivers/input/serio/gscps2.c | 208 +++++++++++++++++++------------------------
> >   1 file changed, 91 insertions(+), 117 deletions(-)
> you may add for the whole series:
> 
> Acked-by: Helge Deller <deller@gmx.de>
> Tested-by: Helge Deller <deller@gmx.de>

Thank you Helge!

-- 
Dmitry
