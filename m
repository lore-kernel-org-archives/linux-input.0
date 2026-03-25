Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02A13E9295
	for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 16:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774455011; cv=none; b=ubmB5dK2BeLrJEPSAjGI6MjhyoAY/K9+S77W5VoWwIFAatzKTnF4e1uyPzyux/6WMWtK/hP61cKln3+reaVojI1XXCUhHtfDBTxcK5DN49KXz8LWU6R2thVp777mGUxfRDcClUChj1bpDn1lYoibXn8QdG4Ot6EXvriC8Yp6u6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774455011; c=relaxed/simple;
	bh=HFKMEf51litA9/inWSKBQf7hbskWp96ia+y9Fji0g5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R7GG8s6T66RTSY9ArGhffZe7lFUtQtmwcDWBxUVweMWTp0a/PQPrtR+MGUUy6ysusmNAcxSfPAh5JRqPi8FFJn197m/fVo+uzprn1YNrV1cIaGrNPufZnj2P6Q5gWzuRDUNwDMgKY6QjQ3E1/lWsCaSqdfAH5Tix81zRTOXvqvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VcBF1dml; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VcBF1dml"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1273349c56bso7438c88.0
        for <linux-input@vger.kernel.org>; Wed, 25 Mar 2026 09:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774455010; x=1775059810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RTMzbPyJc/jcC1jyTvhSmLDBvTP0Tnj61vxqJ27DvE=;
        b=VcBF1dmlTxAZtGwybBQdxmkmLqH2E18otB13Nb60Uitv19AwM0fOugYziPsYemo6Du
         umD+l6B1guy8SrXB5vOz5WzvKT9QB6pg5Yv81smYYi0irkZKos7cZxv6JK/F8WVDTngl
         5BrR3hfmxZj7E3Cq08ibtliiXfVaUxfIc1g08CvOfJFB81pcG2VCXsCSClHRi8uJe/3t
         m9Z74X1poqODvNDhrXRYS9tAukmg2lpy5vNpxWufBlgfl1AzHFHp1x7qmTBjjYlZGV1X
         gd8Lk5I4YiVa2bifR1dJRjhwGUW2G/9Bpf5kcKSFr9prisHJuOE7io6f1oohuCB5N/hO
         QILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774455010; x=1775059810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RTMzbPyJc/jcC1jyTvhSmLDBvTP0Tnj61vxqJ27DvE=;
        b=BNhhAVTm1dIPYWWkAykx5eot9UwAZaVZHeRvYbpxCdKCOMuDnec0dEwbOvpBAo9nRQ
         2PL04jsZF/GYFS5dihQiAFKAznAN9AZNj4VlJZOTbyNFSNchkoyMkH6eFsk3rf/c/NoM
         yAKq9TaCMPlsAmkUEN69SBGen2x/0mKagJgBxNxiM4OWLEJZm/uUwnH74pzq11FIXLQh
         kaidr6InkuA1UYhFsLGzXOJ+JV0pyTo7GmNhjP4tlvZ3VfLbm62ZKjQB6bnlAihhpUpK
         Xu5UVWaulcH4H7aNC6nnbje1WUIC9H2ZrOSLNY+LVjJKSTiaMDPbShW7Awx9PwzS9e6Q
         619A==
X-Forwarded-Encrypted: i=1; AJvYcCWKyfoWEWMmKhfCmIQscjtu+YK1ACGzUbC/sgsEVhbwfrUPgXdwNvecpT/CeV7sT2M6euj6zcCn7GHW0w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRwpsNmEWFsUfIJnKuUYUhjUUvOleMu8pkTwZD6HVJCVPpl4h
	GKf16dy90eFaXz7KuiHw8RYXMZJXsju8kndleZClQoDiD5RMsZnMLOsb0uWKZQ==
X-Gm-Gg: ATEYQzwRPH7fJaIGiTPQ1tcqEKOtNNK9Mk2DvlPIi1wj5osTMS1z3vVagPUBbdA2KgK
	DNtYuv5brNVQe7k7KpLwbjApAUM8dfvzOgsljkP9QLzQOnaxDJnnI1auDCwTxzyhBXwwkyycwUa
	3+LnNjpve+W0qi6wUULL/ATG3FbwKTKfgFku52MM3BK6ScvEdfR2QNmij41KwvpMpVTZBScBeQ+
	PjXWv1O5dXzQYqoNEz5nM+odI2YTne5bHZaaP6f5aRyBTQT3xsC05YatTULPUZkyJ69XlkB9/X1
	mVwCQuV3+UMo8rXfvH/X1WSwmiqFdpYwIrNTpPaVrICH56MYqAsfS6BKINbFtnyMwlrodqKE8Df
	lRoqBvFa5urcR9nnf3mpsi/GdZCaNhZ5pqUWdWta3GNnWJ+OPOw0hpeGMWoCmVr9sGq0zUzIYDh
	1WhGNeRjzM9X8AwNoHXdknZF8bEt9ZgQ8YsnIMwvWBw6tQYQH4krKuFeTxgjSBL0zq
X-Received: by 2002:a05:7022:429:b0:127:9ece:c47a with SMTP id a92af1059eb24-12a96f09732mr2117269c88.36.1774455009760;
        Wed, 25 Mar 2026 09:10:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:b7b4:352d:eb23:66e5])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12aa7248731sm211161c88.4.2026.03.25.09.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:10:08 -0700 (PDT)
Date: Wed, 25 Mar 2026 09:10:06 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: kees@kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH 1/2] input: aiptek: use HID headers
Message-ID: <acQI1xvTrEhr9Iz1@google.com>
References: <20260325143256.371854-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325143256.371854-1-oneukum@suse.com>

On Wed, Mar 25, 2026 at 03:32:46PM +0100, Oliver Neukum wrote:
> The driver uses its own definitions for HID requests.
> This leads to duplication and obfuscation. Use HID's
> definitions.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>

Applied, thank you.

-- 
Dmitry
