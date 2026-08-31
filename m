Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A707D37C10C
	for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 19:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203808; cv=none; b=U4u3omozRtEU9jt7bfyKyB5OpDVeEkHHyu2hV/a0MBd7F+ecHz5j9Bvgu0FwjJo3wlTeIrNDaRffQcq33PlRfznhuSwZ94DR63XUgNeUsALDJev0khzhDMMLS5EIKQBcH6UYAd8iFge7IPASQyFFOqq6mOgM69upg2AjDWlBDtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203808; c=relaxed/simple;
	bh=1l9Qnwy6fOAZnRDv4fKE40BBxLJirspE0kOwbtTf1+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JrLIdBghL+hp8xwy3C/0+osEp9BN1nfIwdqPljuRldKlESXQHvn+SfyA4PQnIpeGiDJ6MCPI9CI1Dq/6rMDbz4TC8hBby1aTzSeiH07VcJ7lb1qFAirabeZx2/+6P3xyKCkY/CreuCBBoZyUQaCS5jKI6xsUUlecjuWKGmuDXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c73zA0c2; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c73zA0c2"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d5335cf904so37371745ad.2
        for <linux-input@vger.kernel.org>; Mon, 31 Aug 2026 12:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788203807; x=1788808607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1l9Qnwy6fOAZnRDv4fKE40BBxLJirspE0kOwbtTf1+s=;
        b=c73zA0c2imTcdYHBeUrTbd6ciNNKrN5ya7R5oOBJagOWAZPJ13nFiI2MaHTIbaLNHA
         8W+rKMjeXEkxRGmuAuUpL3NxBXUGl12FQuN+5ixncPGOKzkIFyYvoJ5aicBkp39WSc/s
         4BqPdYivxAQlI0BVMTYUNBitEnIHAVjuE5B9/S0jtohLbIwr9VtdlAqTQ6d+fRILLC35
         ms24rpjYUqXg04wOhqBp9Rb9tZvk88PLtCOxWLg6WFkz+1t00teBNFLT9ZMrIUBqJ2KY
         30ONvJyVTCs2toO5l3Pqq1V1duq0e+0k7tq3dCa0nQf0pYwyNqfmL/5FmSVO/OEK1YS/
         wJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788203807; x=1788808607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1l9Qnwy6fOAZnRDv4fKE40BBxLJirspE0kOwbtTf1+s=;
        b=rDcd++C1lC+YUdckzZPmRvXlrzYYzOXgCqqFdHl535uSvSC3UFXe44is6N7oDHHacq
         6DYFtyNCSwWnL9S9n5tKKEeqTOylxB5ihBjzF66JMyHQV6eWGCt6qjqVvMJQ1fCE1cyz
         9ImsvGE03UwW8G3dRz+Hd23woAeyt/ufsD+BlcxVtgeKpDXwbgN8VZLMvXtGfyoa9tmg
         +KHgDsqH0wWQMRyUOeZl1htY9CP0Gbj77Xe77Zo84ETG19l56cFCKSV3lHAZ3dMvLkSM
         Pn9pQ3N8VNFIT0J7ugjtmT7TltCOs2pU4YuDRJSviEqZIjMnEWL0TV8tv1D/x+nqCDfn
         rHbw==
X-Gm-Message-State: AFuF++n1qB+XC+rd5xHqRSJH0lR9okfAt4UOa4UV2iX7+2HDyw8SkaF/
	zq0vhQUsOM+ZNQdgt/tLWrRmf2HmDIAwSiiDLKYAXRc10f2K5YJNR3bi
X-Gm-Gg: AYBFou0fo1zvRhpygEK7inU0wqT48ys2MuImB2MoRK9/E9u1FsnHvyKZ8FIwUzl+QqS
	aHWwevabOqCvq2hcFJq9xMnXXIorOyzP3vI1GEgcXFq4Sp8L9xBdPKLTZ+hAXL2v33AsfKUdUin
	fyOwljgk1uTLfhtzUPinc8ObjSUat21PCj6xPKQe9WKE8pEZBxrNLXa4xT2oOfkvhY49pq19QZZ
	63SpBohPAsJga4YQ0RLYn/9r5YIdZYt2A4MtARDbYBhzPaj3nbbIT2eQgptQcI4Fz+N1wmsK/AB
	NsIXlUGTqRQEs/R4oOvKnbcUboLXV5nxm1Pfi67njw2RkuUujaP3uH9H6v0kX15sRgNa5aKUIoZ
	HTqiDEJZwvSX7m7xyY/0ADrfEw60dwf0yC8tDJbsuIOJaFuxekFkVYMcjulKux4+z0FbgfdHj7C
	16knui10u3sh7t02UNwJLgMMh4jX/CmBQ5359guvWUiy0Q6L1NLqa7hpPMpLhpfHfMtMpVNS2dl
	HiqTGFnrRxGBg78KCEQIolI6Rhp
X-Received: by 2002:a17:902:d54c:b0:2d8:d4cc:be63 with SMTP id d9443c01a7336-2d94a904a83mr39320705ad.16.1788203806601;
        Mon, 31 Aug 2026 12:16:46 -0700 (PDT)
Received: from localhost ([2409:40c4:13b:7a31:95ce:ef4b:57cf:6fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759640becsm40286735ad.36.2026.08.31.12.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 12:16:45 -0700 (PDT)
Date: Tue, 1 Sep 2026 00:46:42 +0530
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: jikos@kernel.org, bentiss@kernel.org, rydberg@bitmath.org
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mayhemandcoffee <mayhemandcoffee@gmail.com>
Subject: Re: [PATCH] HID: multitouch: Add report ID mismatch quirk for ASUS
 ROG Z13 Folio
Message-ID: <apXSkmMq_y7Lq8cV@eggarch>
References: <20260804202031.75738-1-lovekeshsolanki00@gmail.com>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804202031.75738-1-lovekeshsolanki00@gmail.com>

Gentle ping on this patch, just making sure it didn't fall through
cracks.

Please let me know if there are any concerns or fixes on the patch.

Thanks,
Lovekesh
