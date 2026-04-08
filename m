Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BB039F169
	for <linux-input@vger.kernel.org>; Wed,  8 Apr 2026 14:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659659; cv=none; b=eML5+m54+/Gwma+ej3pVKxLDk1WAjYDf9MHRVMTCCcrJ1bFoYkS/HVsLzIszw//xmEnSwWwBrjBqMkzBcneyvd+hAnN4ZSOPHaw/dYvcfugPKo2t5e4M7wFtuwwzKky8XztJYE9CKBYvehA7px52qBp8zMpN/aKuDusMnhTuHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659659; c=relaxed/simple;
	bh=XD/VeR7izK6kTKHFyoEfKHxdjgkwYY8WzKbo/vkGJG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sT1fe8lOn8P9soFus0kTPCZjcsK2vnLbUxnm0ZtuFQq0eJ6G1l8whnluEPgLD+FHO8DtcQIjz1x3ZJdf454rjc9b+Cdry+UzegsoCn6TEyoMR7nY5YB739t8lx++B2xL19VhVV+YcBxNlycXVCNKIyLrsmm+/uQ6tMZ82Bu68wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCKwpV5H; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCKwpV5H"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12c1a170a50so1969974c88.0
        for <linux-input@vger.kernel.org>; Wed, 08 Apr 2026 07:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775659657; x=1776264457; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EdkcGsGD82PVNH0uT7AdIxGIf9fHnZQFnXf4LWOVvTI=;
        b=OCKwpV5HoDwg4+l/k0xNx7W9Ui3eD2cnkgolrHt6xfCs575Flg5cwBdLOkAXs+RR2v
         klC7lckvsWDoG+skn3mDHkQ+iLLUfcPV+GfKoMfYpxg512ByUnAz2u7mLQN5GtnpPqND
         nXNuIlsK0IoR2i9O9bfr2VW1myaT5YUmA4qvTwfKU+dQPT3vD3HTWRpUCgrHoRZbvchF
         4wyJqW7HkWAm6L0XJYdehyZ2RP1NqN83tpy2AHPqD810rpDiH2t6t6W0wYU3ZsXH66yX
         RoJCFvABP2u87I3q95cbzzSuXpzQGOvTPhW0Rr2UbZ07J6WrxuoOfx/TQeF9WcUM+pjh
         5ydg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659657; x=1776264457;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EdkcGsGD82PVNH0uT7AdIxGIf9fHnZQFnXf4LWOVvTI=;
        b=bwzNdtHK4sbeS+X4A3Slq6+R760XZ+5RlMCgsVaQgsqcKNT7Jje6FDHWuWReIitx9j
         DCH5fuq44A19/YajeNja1dKDpkwn2/gFdDJ+NEp89X2EcvTC4i9TvOxzodtq8fVPiYvB
         kM4YMkpddsz/gurWvFfMjOee3fwIBKW+wHz1dWRZUJ9r0eNexm0rAdcKusQx7t/9fxKU
         15NFdJ+m0fpGlu9wPHMpUaYNaKjQTJznkStkrlidgQ59YWwwufMoODPbNPB0YcgkLcPN
         QdNFpaPyKmE3E+2YcKqot4wzxWlO34bGxOTrMo9cJMvN16oc+xYBxNADLO6ouvlbjBaz
         H3mw==
X-Gm-Message-State: AOJu0YwqS0vLWqZGrZu3xByGZKJIupvifw1gzNp15ynRtRdbKvJZvBhZ
	uJM6kf5UFdBctjNQc3YqSviHygI6Uv/vYi7bIt7bH7t9sieoQEzYEWo4
X-Gm-Gg: AeBDieuvef1AbVrSjV18kb67hDCrZG2G/h6dVqrCiYS17C5Xdqi/vYSqiC46uJvBQnD
	vz3dCPPq97AktW0/hzb21KBTCIXdWQ4ttv0eBJSvFjGUjkCOE/yXqIK8baMl0J/cstbqBjaU3Te
	fpCITW7lLIHPu/EZ3VsfWSDOn7KdimMBh1TxC3lZRyzkH71k3lB9YnwhFbGCmxn+6MNcp3HVMog
	AJgkVgha2dRiDhdZ5UL2orqXG1kAyZ+7Xy5BENTKeTHigxpQc3PUT+5JRK0roZEBqFaNq97B9Z2
	t8QZxV3mNrZ/Qzw2+9jf/ZQXFOprKjQR995AX3ErFo3TNH3DDrL6Kqjgu8i523MuAbsyX/1jvyE
	WpLOsZt8WGayKd0qpuEV7lsYS82l407DJP2hsliwj8xDVGsuKz75G98x1ddFzVdwqBH4eUjWc3S
	2rZyetmQVqbt7ORuIhx1egHJ9f+FP7w/bDGLD+A8Ii8kXBI/UF9GGa3GnAyd37114G
X-Received: by 2002:a05:7022:6b85:b0:12a:b932:81fa with SMTP id a92af1059eb24-12bfb6fb367mr10997008c88.9.1775659656967;
        Wed, 08 Apr 2026 07:47:36 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:f3cf:7538:b120:7924])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede7f085sm19585452c88.12.2026.04.08.07.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 07:47:36 -0700 (PDT)
Date: Wed, 8 Apr 2026 07:47:20 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: qt1050 - inline i2c_check_functionality check
Message-ID: <adZqZdP92Nt25uMj@google.com>
References: <20260408141926.1181389-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408141926.1181389-3-thorsten.blum@linux.dev>

On Wed, Apr 08, 2026 at 04:19:25PM +0200, Thorsten Blum wrote:
> Inline the i2c_check_functionality() check, since the function returns a
> boolean status rather than an error code.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

Applied both, thank you.

Thanks.

-- 
Dmitry
