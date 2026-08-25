Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FEE3DB634
	for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 10:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654439; cv=none; b=arnfFIQVaVc33HXSx+x5FwAXoDvV2NPfkq4i8tH00b0KCDr8nmfPOeNTwODVC8Dq6+JkW4UEvuGnYCJ9zPs1XH2h1V/HBcf0Bqlp0x4S8eM98W1kEAeFCiSU7ScQwQ5iDGvNaFe8umBbEvRiZTUu6ggn4WkQ5HosfeQHhWFjyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654439; c=relaxed/simple;
	bh=ioddsn5yt5I5hi2jejY9A5CM4bUaACPKih8k4SZvYyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k7qLERQ04scuv3SB3UGTplsfgbDn+8CXMBSYwv0UBTxivTF5Meg0qL+bcQCHisn8yVKlP5dxQAjN9ZeoGAoztoqqPk0zE1kej/InM8N9q7V7OjYpRbOUZtGfqS+IDs0lRfZSGE8cf7r0ECNPBmUqPRmsYlzsJwLFKKk4ha06QGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oZF4o4ND; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZF4o4ND"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc891373e0so49936995ad.2
        for <linux-input@vger.kernel.org>; Tue, 25 Aug 2026 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654438; x=1788259238; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IjJwzyc1eNDpSGhDvSYntYVlSmXkNY0hSMehMAVhsR4=;
        b=oZF4o4NDXOiuxSoztUcgF1r7C6Uv40N682pniJ5aEjyK/Va/PhgIcufCOykTTCnrjb
         +mD03rLa7wbq5pAmUwrafA1t81W5hCRnM/Gj30n4gDnEAgz7MX+otyaVIcBb5TuFiXDW
         Z4u3TY5Iwoae0hLoOD52WPcXnO6tg1QxSvMzq1AssnxIhAACV2MP8FZf+hSeJD8r/MUt
         h/4aNHcHnPeGOvGvjXZqiFBIy0TKW7y1Dm4u+49xbFkQ75lyLwqx6G2YqjDb1VBJpstn
         w6FfwCNDtxeNSpHmb7eDiFDBBynD4rp+8qPby9BFnfoJRSCyx8kXRWdTxUnSke+9465O
         /TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654438; x=1788259238;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IjJwzyc1eNDpSGhDvSYntYVlSmXkNY0hSMehMAVhsR4=;
        b=QkloWKL8wy9/uGw2Td9L34L6K6UJSWHGNt6elyk0F1jNXNo9p7W3Hc/v/N3/GleJs9
         58yVqTmljxM67DrOS8jBN9st4+idflQR5sQZenbSw/03WRfVkquiTi1PD/CDOaGBpUZe
         XYSHvhgSvYVj0qq/Zsj1+Qhb/nTNoiN6pVC2XzRPAyf8GMSkHGiH1xwnxxlOSRtp5Biu
         bcERDfBb+ouNtdl2ZW1yfEdG01rox6XF4vZ9WzCw0tgJ4nmZIfSZpkU5VeuM4otq2Df4
         HuOUDC3NEgkBB6/2j5xqlrHGXia+2VOT93ZS1HYbSK/VR4b6tqiKC9gP3h1Gj0Sc/RNv
         ag4w==
X-Forwarded-Encrypted: i=1; AHgh+Rpy+elY+1fc9YlZgxBL4WZF05G+vaLRHTnRt3HhdZS2wvJtIPQgYBg7Ddteh/viipsNmGyBa2y86yIOSw==@vger.kernel.org
X-Gm-Message-State: AFuF++nZ090i/NmwgZA1sNU1PPOdl4eUMddmzwbqtp65APOUVCZTcz8G
	oGE0CZE3lOfgbph5pQhoHI3V+p56CJZDaNGOW7pPHmzVAdlj0dfKpEx9
X-Gm-Gg: AR+sD1178ANez6IKwZHN6mDGF7WvmcDNZxbZYGIJTnpdvIZiFfwx7FAvRFEEfyaSTtO
	pKKrY+BD2kGX6JcBkrVvmfuCCa3flVBsnMfelx1dkQk0rlobvnBw9uhVuhaVy//tz1NahXeg6vX
	cCnuTYKp24QSfiu/FeB4rqi5NhkHvXMVltwv82+q4PB9gFumFsU8jeU9iC3C01CC7UCpcgX14X3
	ZLhFRmhhrBJaMuWvaLVi9JZsqAZVbzfhuvN7QhOaVWwC8AJkduWt6M32zCKHEenjifDMXnghQUa
	4mMD+JCAveDBe5wpRJdsnua/6RE8RY3XHj8GeM89cygEOBlERAvGL8yiRllMf7Ea3zFPTv2LgIX
	Q4+12ENdidnurheFaeW3aK1ee0ASsPLXnMRsv905nr42eN9W5P1FLDRdJj5mZishrwl7mpGeR6D
	syDTIzYNIZ7T7T2UkAr+u/ivFbTjARCCCHimvzR/nOm1EumicUoJMO1+/7b4CLerzqPGg7Ho7Ge
	Ktb+fz09mxGL450nPdW+P9WyegpHuPtE2F3AHhVXS73mmm3Dv4pA+lE55NNNdSpD8ytKYPuPG1X
	jormia4z2hMYbBgtMcMKbwie
X-Received: by 2002:a17:90b:5485:b0:38e:11ba:992c with SMTP id 98e67ed59e1d1-395df6080e0mr51290530a91.12.1787654437517;
        Tue, 25 Aug 2026 03:40:37 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain (bb119-74-6-224.singnet.com.sg. [119.74.6.224])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39646138f87sm3276991a91.3.2026.08.25.03.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:40:36 -0700 (PDT)
From: Wei Jie LAW <98lawweijie@gmail.com>
To: 98lawweijie@gmail.com,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: aduggan@synaptics.com,
	cheiny@synaptics.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix input_dev->name use-after-free on unplug
Date: Tue, 25 Aug 2026 18:40:31 +0800
Message-ID: <20260825104031.14644-1-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825031315.51860-1-98lawweijie@gmail.com>
References: <20260825031315.51860-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Jie Law <98lawweijie@gmail.com>

Superseded by v2:
https://lore.kernel.org/linux-input/20260825103139.12314-1-98lawweijie@gmail.com/

Please use that one instead.  The only difference is the Assisted-by
tags that Documentation/process/coding-assistants.rst asks for -- AI
tools were used in finding and fixing this bug and I should have
acknowledged that in the original posting -- plus a trim of the commit
message.  The diff is unchanged.

Please mark this one superseded.

Thanks, and sorry for the noise,
Wei Jie
