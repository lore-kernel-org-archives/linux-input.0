Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B6A3A0E81
	for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 21:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508726; cv=none; b=gIVAV47lDsuAD8lJpEzOqA8ck+LOHGj7wc3ktL5Mcjy6Hq4oQTgO8BWA6wNSs5henoPkqmttZZ7HDWHqGy44Ic+jWLqx5WVYl65e8oSxmaaWD8u7wlpoJrE904JNpcWss/qe9ScsQi2rqFuGOb831r0Sf8ElAszL4ndVMmKCPJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508726; c=relaxed/simple;
	bh=IkV7U9ogkKqOnX0NBoUpimxq9cdoyREC1nAvxyqFT2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Th8ASqoHGOLi1YJTEVWkv9FOcq4NJJQMoPlvwDILeIahftnkqo2IWYo6zdXzqEBI+egJ9GMTS17gpuaLev0oRsevu8JUQ0fgNL08/NdcPySW6UYhL1viYPfLu4LfR7U/fHbkdIOd4XFRqqzC+mbWOHRpdOR9Ojd7WKs+RcHBzaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtcoFo7v; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtcoFo7v"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-30c944aacbaso370754eec.1
        for <linux-input@vger.kernel.org>; Fri, 26 Jun 2026 14:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782508724; x=1783113524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhyPf6GQJmpSddVhdbYcqKz2oPB1WGoH9FVCpWvWJTY=;
        b=MtcoFo7v6l48mYtL+pRGB/KDvPm4pAhaSuRtc6EG7kT5IOEdG/9E981Vck64qb48UP
         lTY0mwdsvxlkGwF8+ISxz8I2P7O2uTNuTQ1wiw687KjVVbdi5w9rvlTWX1ASMOtKIYjU
         +NlyOhMP3tyT15yLwQEJgDv8Yrc5BMLH5vuac2VPdVw451roNBbYv5DpC5vhAJ96oyRl
         lJNxLWsigmA4BcYeUxp31CJDFD3oi1bDr+th8zVi0+LLi/6PtS1cEAQ/ezVxy/kX9/xB
         pkhBbwQLjMJBVtkqJpOKBkUAVHoLOUbDGS1sDWyhKiLJJGbgxQcbYGNwVpi/CfBtZJgA
         eAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782508724; x=1783113524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZhyPf6GQJmpSddVhdbYcqKz2oPB1WGoH9FVCpWvWJTY=;
        b=Hhhi2ZJr341RITKqalMecDzGYK6USSzZ3ObeMR8ZpGirjgABh46sVg4ZIx+QrxevNd
         RZANF2XnkyEaUT8JP7ufeQoDvj3lBQN4JlylT4aEuxGLosJZPAoQ4ReL2kYBwtVnf8NQ
         AAALS1F+EWQcokpZn97myt5cchgY7HzeVt4jNbwd2HtaOVdQ3/u7ONyIxeq/P81gpZ2K
         yDdcglU0iGcCzll+38LhLLVZQ3cvT3SX/7S/uWxMYHeDa6H4q3juFYMk12Y5uBzGwA5W
         QR6p4xM7CXbU8nd+0jyYhK/FAbk7grpCB8U30B7yVIkXhPji81GfrkpMGMQbONdmHCK8
         3ydw==
X-Gm-Message-State: AOJu0Ywla23mn9so1d+FLqDjnVcHPSE4Dcx/u78SwNXfbizUv4J500Hq
	aJY88aoSu65ycwIYyCzpVPwSQe//bwCf8OTHHHsrp9IYU9aFIAyWGhBD
X-Gm-Gg: AfdE7cnFnXLnKG50PywHtLbw7xM+4izgujG+LsPeC06raBhv5boFWDX57pzp363AZkD
	Rk6ghme246XO75FT7Cpuj/Q+x7LcVV8yEc7/urVDxABR8Gq5m6Ydk6ROdXcEVbyV72d+oJmanNT
	i/Uk2GjtaFZZXEfWyc6oX2IeB22Y8RVBhzZxJbPxF6G9EkbvUfks4hY2cs8Q+w6vx50+08XTLY8
	bxusIYaH6WFaGSSxRj17RQt9qQiMsqa5/2VGp7otAwoeSR2o902TnLZz4Yx8T2Eus1qyStjB5+R
	gDhu/iMa+i2uN0YgSj5wuVCnw8SmpAEcGViSirkizBsBFEgVgn797GKic5soGwgLoy6tf7oAF23
	A+WXCASVOTvmbQZD5O2x6E9QfneSJyvG+vNKqwRh/7AqYdBmTN5ZKEsJimIExgT62Q7H3xe4Npa
	+5JjL1XJsDZJG9ZGmQMcmby6ulProT8OARl442lT3Mu+kk0fs9p7X9PA==
X-Received: by 2002:a05:7300:e6c4:b0:30c:38ed:46b0 with SMTP id 5a478bee46e88-30c84fa74a2mr8166705eec.16.1782508724032;
        Fri, 26 Jun 2026 14:18:44 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:a474:bf4a:4966:8d97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7c52c664sm23589430eec.8.2026.06.26.14.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 14:18:43 -0700 (PDT)
Date: Fri, 26 Jun 2026 14:18:40 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: linux-input@vger.kernel.org, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: [regression] synaptics-rmi4: Failed to read the Control Register
 Descriptor: EIO
Message-ID: <aj7saJXgFX--gP_8@google.com>
References: <de6d34b7-619c-46bd-a6e3-a3917b318571@ixit.cz>
Precedence: bulk
X-Mailing-List: linux-input@vger.kernel.org
List-Id: <linux-input.vger.kernel.org>
List-Subscribe: <mailto:linux-input+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-input+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de6d34b7-619c-46bd-a6e3-a3917b318571@ixit.cz>

Hi David,

On Fri, Jun 26, 2026 at 11:09:54PM +0200, David Heidelberg wrote:
> With next-20260626 without any additional patches, the synaptics fails on
> OnePlus 6T with:
> 
> ```
> [   16.620292] rmi4_i2c 12-0020: registering I2C-connected sensor
> [   16.857617] rmi4_f01 rmi4-00.fn01: found RMI device, manufacturer:
> Synaptics, product: S3706B, fw id: 2852315
> [   16.867324] rmi4_f12 rmi4-00.fn12: Failed to read the Control Register
> Descriptor: -5
> [   16.867338] rmi4_f12 rmi4-00.fn12: probe with driver rmi4_f12 failed with
> error -5
> ```

Yes, at least a98518e72439 "Input: rmi4 - fix register descriptor address
calculation" is wrong and needs to be reverted.

Thanks.

-- 
Dmitry
