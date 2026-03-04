Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AEB3090F5
	for <linux-input@vger.kernel.org>; Wed,  4 Mar 2026 04:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772600188; cv=none; b=oa3pgAsvb529GaNZi2b0tCx2vcKNncPWPiKtBudn2eVVpwXNXe+GCPrWwVOagSsq1ToEYRAeUKCrp+JzceZ8J9OoVORy5HK3PLcJtXDN2KMCGukAN8LHJ+2P8gEgRyguZRGo/wfcRodQIx9EwyeQCP5Ie88effuKi6+sHtRTOxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772600188; c=relaxed/simple;
	bh=UvPE5KRZ6oJZo3zfJg7jfhskZOj8msyDuu72/RzPLkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGO3VJ5a2HFQ0uapyiyzUoCOvHSk1NgN8uTvewGHWAwh3fWd8++W2+mjZh0+wcoNbVRIPlVyEi+jr8QE6PegYU4e2T3JpAagIBeT0aIkI1DYfY1bHbk+4++KQQsJAZbdVdrjQqlBrK1SktPCqx49MKe93idl1vH1WlUWdWjpuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFGDBpuJ; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFGDBpuJ"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2bdd40d3c61so5257459eec.1
        for <linux-input@vger.kernel.org>; Tue, 03 Mar 2026 20:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772600187; x=1773204987; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aTVcJPVpzFRvlrM5JfQCAuSEqp9bcj4wWHMuF6BWOGQ=;
        b=IFGDBpuJy/7IZ/5YUpIsVtURidmeCtrpsAAkxNrxiC6nf+MKT+z+CwQAphQ1m/oSAb
         sWytT6unxtI7JdcXS57SYoqGZeGnhoN7X58Z4a2e71dFLfS5UIGH/DKbndocTkWf6Ssn
         WUwoxDqlWGz8NOB3brMhem7NcYGTIs2Z+AoPxn3LRucOguAWS1wtRLFWW4O2eqIcucDK
         3IU74kZj1rWfrCtef6wTOXKg+mrK5VJtfYeA7S6awBAIDCpZZmHuYXcbcnulDdvXHCxN
         itnpBs4wOPjSke2b1/2bFoUTrTCYLzcBWgHsWmvdw34HHcWGyru1Wz6wFWGyqIqTDCkT
         6X4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772600187; x=1773204987;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aTVcJPVpzFRvlrM5JfQCAuSEqp9bcj4wWHMuF6BWOGQ=;
        b=KKaqHb2JEOgdGt5Iic+fRDMnnEJSd8IcMbGwW/tjrwwN0nDsUT+ddfTosZ0IAOl3Z7
         0qKykhB1ALdmbbQDYvLcuuP1VWRjpJASYJl4DKJIPXWISJqtD9GO5/19nFAo+lAn2Fh4
         PdfTYDscd4YSgrYrZoGvqKDl7GTNV8D2Jg/pKQ4hYxjF37f69jz//zhBshSn+I1jozl0
         tf6dDllTXOX2cQ//evkSI3OjCFCzBGM882zIgxoLiOKZJy8iqAGW7H+n0jmr4dOFMgxp
         kuw6BKuBuMze+RkiQw9HITeJg7DnPrScrHCGuJ3a7gPLXauDayTquLr5Eb3uw5UekOlH
         0ULA==
X-Forwarded-Encrypted: i=1; AJvYcCUN7+GrejsnadoPvvcyoqsz5sorXLZStIAfEpPBSYLw8Hv0FfkT7NByvBsslpA8nJVTI9xm+5g4gwE8iw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yydb9BcA+1HZIkEi6gLDCpLeWKILzoknjobAh875ey9tkBISr/2
	MSoMV2iJwP7dAobOBPeptPMic+U2UhqE1rOV7L9+K6FF61QgTsStnLTu
X-Gm-Gg: ATEYQzzyppoEDyL/NcuFFtzqFVM2sLWBN1z7fzzMyfoJvKFsQ/KVG9pvC7Dtiq97574
	v4jE3CMlbdswGUd6haMUpszC0SO75EQJ9yoiwT5KHUpMgi+4pFEPF0A1fPLSMWarjvlHj9gQOfz
	bp+bXgyWb6dPtD1FuA2dhtXQFEycTFS5yEy79dbuH3RdX7xR0ZCK2My0kZ3ZGS8Eans+xmueNPK
	Lh4AjczO+ADx+D0cB4uGChTPi7VdRGiAQKdb4gZik37rZeuprToIQND7HxEvpn0wNOoFD/gGj8j
	3M6J3FT33bw3oegFgnJsn9sAV9b4HtjUXxIUgAEjYT+iNVDEhVX2JT3Mn1L/0XgO6hVyT2vwFI6
	q79inIiHO1ICLihyAb6O0YThbd2VfkS0KPfu41uQRDFApYpSBZUH+N4fJgl3l4L0BhdL9O+26lU
	0VGCO6zC5kOemM4uk6rT0/PDuSAEOHrV1oZ+BBpvfgZaCbDmoaEid4tvdj6BHdNC4sPPD5LJvql
	XQ=
X-Received: by 2002:a05:7300:dc8c:b0:2be:1803:7e11 with SMTP id 5a478bee46e88-2be311bd422mr242905eec.30.1772600186892;
        Tue, 03 Mar 2026 20:56:26 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:a048:d9ec:d217:7d59])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be12805b93sm7512637eec.15.2026.03.03.20.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 20:56:26 -0800 (PST)
Date: Tue, 3 Mar 2026 20:56:23 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Luca Weiss <luca.weiss@fairphone.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: input: awinic,aw86927: Add Awinic
 AW86938
Message-ID: <aae7dQsFhJnQWTYM@google.com>
References: <20260302-aw86938-driver-v4-0-92c865df9cca@fairphone.com>
 <20260302-aw86938-driver-v4-2-92c865df9cca@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302-aw86938-driver-v4-2-92c865df9cca@fairphone.com>

On Mon, Mar 02, 2026 at 11:50:26AM +0100, Griffin Kroah-Hartman wrote:
> Add bindings for the Awinic AW86938 haptic chip which can be found in
> smartphones. These two chips require a similar devicetree configuration,
> but have a register layout that's not 100% compatible.
> Still, because chip model is fully detectable via ID register, these
> chips can be documnented in the same file.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Griffin Kroah-Hartman <griffin.kroah@fairphone.com>

Applied, thank you.

-- 
Dmitry
