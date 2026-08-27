Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D634119E0
	for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787828318; cv=none; b=uRGe0AOTQ5YqlbjTkR8z2XnnNDzcANOga+S5pN5sjU2pEwzpLfOvO5KspDS0EEW80hzSBZ94DGEhU+7L1cbyR8kbpXFmti/W8cEnx88yn8mCu5LtkeUbXOWTkujUVaH8bKSYZnvOuExmpEgBWbfQcPH5h+IVmeaWHRqRsea96lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787828318; c=relaxed/simple;
	bh=UvIMv1zVGSgTI6n5HYa7Zx9yz+/Ky53foDBG/QT+8Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avk9e8JcCZwlHHPfTiDKfYgMuVF/5MF2GCzi34Xy3qx2T2NoFV1oHeIsFDdOlawuffPAGiGmOBvnNCk1oifiNukKOMIodj2SAGw906O+YLEENDX3xbtn0kcqqEeIXF9R38Gdcp4PRsZaBMqYU+ZYykT1Iq1EahlH3PlB364ijkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1xoM4Hc; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1xoM4Hc"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39682983a0fso1901172a91.3
        for <linux-input@vger.kernel.org>; Thu, 27 Aug 2026 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787828317; x=1788433117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uja6zaOnTlyUUbBqlUy2HwDT1zP/Roz+ZNzUtgYPkw0=;
        b=K1xoM4HctP8Qnho7a0SdG5XChV6/0DtFJRQM10YEgb9C+L4C39MIue/eirHBtd43DA
         fIRhhUpWa4gom6evujbfD3vYZeoE/r47ZX/85KG7JvlCft/fKdv2MyJQScLlN04+DFV1
         9qZycVsZB6nPtPnjfxIx8v3+GiZU4oE+GnXHrAzPom6yK5WPJcajIzsTup73FqrXXO/X
         g9YkPnDOgLiCoeqBtWNZlUn2Cdv0ToCd9utQl1Cx04JX0bT6cGmIGx6OdzVR2yjkOhq4
         laqDrNK+oYxAxgbBFYPIsVJbql/TTpG0JoXEa03TdeLfvbGztzDAG7hfR+hS/i9SSjKo
         eY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787828317; x=1788433117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uja6zaOnTlyUUbBqlUy2HwDT1zP/Roz+ZNzUtgYPkw0=;
        b=aD3g9pNFFhTNBV0zhm3vr8JydtC2yuyADk+yRYCPbig5j70kbMSxuJfiQYtReahO+c
         rB8FuWC9EsKcip9uQZDi6tXZbBhYNn236QY/sGNndJ+ZoM/dvXIVJfrIUGE2ARPqEEd8
         b9qLR/TsZZ/TcTjAQzxo3T+YP28YCs4Jq7D+fDUxY9QDbnNUjia/q5IpTFrVUbC3CIQw
         Llz3FRrUmCjEKGV0H3/2AaODzTiObewDs71bdz/GCoW0wUBCrbMFX4qvbiTKCXdV1EHq
         n5BcVULLaTeW+Cfzc3aACLjCyTrnxd7mlcwfupMHICHBk1cVQqlO8/rijhAEnc68vfiz
         2iAA==
X-Gm-Message-State: AFuF++l3OLb3U6emE1GQmBVSp3e0XUbp7o24ZN3EPZ6W/aw6785io0/H
	/ecOTYyLuuenLdtIfqyCJT1TvE7uTSMJJYV1GzMlP62lCH40Hc5+i+Fe
X-Gm-Gg: AR+sD139N1Gbu14zj1uzmRGwzYmkbc3q0kgcs6ukJZaUMy6SezdG+DSRpeufdLvH82g
	vuk37yHlHGoiwmK6sWcu8LnqUXrtTCriJjZSgzLVAV+xqFzA2eWr05eeCHd7xCqg9yYUJkvbs0X
	Fmi3gAQlde/xkDDrcYahlByZmSeKAEdvmqyPyqr7VAc4p/zyyv1n/+dFUr9zxD7m0Nq84VOmuKk
	EXuajJ8R8EvJFLkBxrVEq0KDBtX+xAPF5P5kbqJhKzNIIGkQ6VmeMQFXOLf2Kpf4TDsMq0MtwB+
	0K16iuPPcaJkbLU800wubv58fUvM7eMZgNKNsKImlgueNSdUZr/3iVuTSKdu+LzH3HVMOsoD7j2
	EVvgsOQmqldaG9XH9msqd6o9EJPDYQDkgliOvF97SrGe89sqNPQjUgPnX2Q0632tNE7KiPCJfz4
	UbTDTEHNOD9hBUXKHsGSIkLj5o0Gs6349NCRzwHt+gIotQlZUdRuX0pXBdV8nwexP/+wXsZy62r
	Z8nv96/uren6dUJdzZh1zebgeOwm1y2DNwvP0yW
X-Received: by 2002:a17:90b:3b92:b0:393:288:29e3 with SMTP id 98e67ed59e1d1-3966d5d91e7mr26710723a91.10.1787828316996;
        Thu, 27 Aug 2026 03:58:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d96d:bc4e:98d7:146f])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8f20036sm27269939c88.5.2026.08.27.03.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 03:58:36 -0700 (PDT)
Date: Thu, 27 Aug 2026 03:58:33 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Maurizio Casciano <mauriziocasciano7@gmail.com>
Cc: linux-input@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Input: drv260x: Map ACPI enable GPIO
Message-ID: <apAXfjxVv8e-yxJ7@google.com>
References: <20260826132211.3341936-1-mauriziocasciano7@gmail.com>
 <20260826132211.3341936-3-mauriziocasciano7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826132211.3341936-3-mauriziocasciano7@gmail.com>

Hi Maurizio,

On Wed, Aug 26, 2026 at 03:22:11PM +0200, Maurizio Casciano wrote:
> Some ACPI DRV2604 devices describe the enable line as the first GPIO
> resource in _CRS but provide no _DSD mapping for its function. The GPIO
> consumer lookup then returns no descriptor, leaving Yoga Book haptics
> unable to complete calibration.
> 
> Add a managed ACPI GPIO mapping before requesting the optional enable
> line so these devices can power their haptic path.

I would prefer to avoid encoding board behaviors in a generic driver.
Can we try using a software node to provide GPIO mapping for the device?
Maybe in drivers/platform/x86/lenovo/yogabook.c?

Thanks.

-- 
Dmitry
